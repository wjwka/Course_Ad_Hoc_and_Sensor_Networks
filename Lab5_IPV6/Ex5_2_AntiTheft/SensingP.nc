#include <lib6lowpan/ip.h>
#include "sensing.h"
#include "blip_printf.h"

module SensingP {
	uses {
		interface Boot;
		interface Leds;
		interface SplitControl as RadioControl;

		interface UDP as LightSend;
		interface UDP as Settings;

		interface ShellCommand as GetCmd;
		interface ShellCommand as SetCmd;

		interface Timer<TMilli> as LightTimer;
		interface Read<uint16_t> as Light;

		interface Mount as ConfigMount;
		interface ConfigStorage;
	}
} implementation {

	enum {
		LIGHT_PERIOD = 1000, // ms
		LOW_LIGHT_THRESHOLD = 100,
	};
	

	settings_t settings;
	uint16_t m_light;
	nx_struct sensing_report stats;
	struct sockaddr_in6 route_dest;
	struct sockaddr_in6 multicast;

	event void Boot.booted() {
		settings.light_period = LIGHT_PERIOD;
		settings.light_threshold = LOW_LIGHT_THRESHOLD;

		route_dest.sin6_port = htons(7000);
		//inet_pton6(REPORT_DEST, &route_dest.sin6_addr);
		inet_pton6(MULTICAST, &route_dest.sin6_addr);
		call LightSend.bind(7000);

		multicast.sin6_port = htons(4000);
		inet_pton6(MULTICAST, &multicast.sin6_addr);
		call Settings.bind(4000);

		call ConfigMount.mount();

		//call RadioControl.start();
	}

	//radio
	event void RadioControl.startDone(error_t e) {
		call LightTimer.startPeriodic(settings.light_period);
	}
	event void RadioControl.stopDone(error_t e) {}



	//config
	
	event void ConfigMount.mountDone(error_t e) {
		if (e != SUCCESS) {
			call Leds.led2On();
			call RadioControl.start();
		} else {
			if (call ConfigStorage.valid()) {
				call ConfigStorage.read(0, &settings, sizeof(settings));
			} else {
				settings.light_period = LIGHT_PERIOD;
				settings.light_threshold = LOW_LIGHT_THRESHOLD;
				call RadioControl.start();
			}
		}
	}

	event void ConfigStorage.readDone(storage_addr_t addr, void* buf, storage_len_t len, error_t e) {
		call RadioControl.start();
	}

	event void ConfigStorage.writeDone(storage_addr_t addr, void* buf, storage_len_t len, error_t e) {
		call ConfigStorage.commit();
	}

	event void ConfigStorage.commitDone(error_t error) {}




	//udp interfaces

	event void LightSend.recvfrom(struct sockaddr_in6 *from, void *data, uint16_t len, struct ip6_metadata *meta) {
			memcpy(&stats, data, sizeof(nx_struct sensing_report));
			call ConfigStorage.write(0, &stats, sizeof(stats));
			if(stats.light < settings.light_threshold){
					call Leds.led0On();
			}
	}

	event void Settings.recvfrom(struct sockaddr_in6 *from, void *data, uint16_t len, struct ip6_metadata *meta) {
			memcpy(&settings, data, sizeof(settings_t));
			call ConfigStorage.write(0, &settings, sizeof(settings));
	}

	//udp shell

	event char *GetCmd.eval(int argc, char **argv) {
		char *ret = call GetCmd.getBuffer(40);
		if (ret != NULL) {
			switch (argc) {
				case 1:
					sprintf(ret, "\t[Period: %u]\n\t[Threshold: %u]\n", settings.light_period, settings.light_threshold);
					break;
				case 2: 
					if (!strcmp("per",argv[1])) {
						sprintf(ret, "\t[Period: %u]\n", settings.light_period);
					} else if (!strcmp("th", argv[1])) {
						sprintf(ret, "\t[Threshold: %u]\n",settings.light_threshold);
					} else {
						strcpy(ret, "Usage: get [per|th]\n");
					}
					break;
				default:
					strcpy(ret, "Usage: get [per|th]\n");
			}
		}
		return ret;
	}

	task void report_settings() {
		call Settings.sendto(&multicast, &settings, sizeof(settings));
		call ConfigStorage.write(0, &settings, sizeof(settings));
	}

	task void report_settings_router() {
		call Settings.sendto(&route_dest, &settings, sizeof(settings));
		call ConfigStorage.write(0, &settings, sizeof(settings));
	}

	event char *SetCmd.eval(int argc, char **argv) {
		char *ret = call SetCmd.getBuffer(40);
		if (ret != NULL) {
			if (argc == 3) { 
				if (!strcmp("per",argv[1])) {
					settings.light_period = atoi(argv[2]);
					sprintf(ret, ">>>Period changed to %u\n",settings.light_period);
					post report_settings();
				} else if (!strcmp("th", argv[1])) {
					settings.light_threshold = atoi(argv[2]);
					sprintf(ret, ">>>Threshold changed to %u\n",settings.light_threshold);
					post report_settings();
				} else {
					strcpy(ret,"Usage: set per|th [<sampleperiod in ms>|<threshold>]\n");
				}
			}
			else if (argc == 4) { 
				if (!strcmp("per",argv[1]) && !strcmp("local", argv[3])) {
					settings.light_period = atoi(argv[2]);
					sprintf(ret, ">>>Period changed to %u\n",settings.light_period);
					post report_settings_router();
				} else if (!strcmp("th", argv[1]) && !strcmp("local", argv[3])) {
					settings.light_threshold = atoi(argv[2]);
					sprintf(ret, ">>>Threshold changed to %u\n",settings.light_threshold);
					post report_settings_router();
				} else {
					strcpy(ret,"Usage: set per|th [<sampleperiod in ms>|<threshold>] local\n");
				}
			} else {
				strcpy(ret,"Usage: set per|th [<sampleperiod in ms>|<threshold>] [local] \n");
			}
		}
		return ret;
	}


	//light report loop	

	event void LightTimer.fired() {
		call Light.read();
	}

	task void report_light() {
		stats.seqno++;
		stats.sender = TOS_NODE_ID;
		stats.light = m_light;
		call LightSend.sendto(&route_dest, &stats, sizeof(stats));
	}

	event void Light.readDone(error_t ok, uint16_t val) {
		if (ok == SUCCESS) {
			m_light = val;    
			if (val < settings.light_threshold) {
			//if (val < 1500) {
				call Leds.led0On();
			} else { 
				call Leds.led0Off();
			}
			post report_light();
		}
	}
}
