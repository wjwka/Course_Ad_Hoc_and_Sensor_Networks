#include <lib6lowpan/ip.h>
#include <ctype.h>

module EchoP {
	uses {
		interface Boot;
		interface Leds;
		interface SplitControl as RadioControl;

		interface UDP as Echo;
	}
} implementation {

	event void Boot.booted() {
		call RadioControl.start();
		call Echo.bind(7);
		call Leds.led1On();
	}

	event void Echo.recvfrom(struct sockaddr_in6 *from, void *data,
			  uint16_t len, struct ip6_metadata *meta) {
		char* str = data ;
		nx_uint64_t i;
		bool isNumber = TRUE;

		for (i = 0; i < len - 1; i++) {
			if (!isdigit(str[i])) {
				isNumber = FALSE;
				break;
			}
		}

		if (isNumber) {
			i = atoll(str);
			call Echo.sendto(from, &i, sizeof(nx_uint64_t));
		} else { 
			call Echo.sendto(from, data, len);
		}
	}

	event void RadioControl.startDone(error_t e) {}

	event void RadioControl.stopDone(error_t e) {}  
}
