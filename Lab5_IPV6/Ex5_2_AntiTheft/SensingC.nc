#include "StorageVolumes.h"

configuration SensingC {

} implementation {
	components MainC, LedsC, SensingP;
	SensingP.Boot -> MainC;
	SensingP.Leds -> LedsC;

	components IPStackC;
	components RPLRoutingC;
	components StaticIPAddressTosIdC;
	SensingP.RadioControl -> IPStackC;

	components UdpC;
	components new UdpSocketC() as LightSend;
	SensingP.LightSend -> LightSend;
	components new UdpSocketC() as Settings;
	SensingP.Settings -> Settings;

	components UDPShellC;
	components new ShellCommandC("get") as GetCmd;
	components new ShellCommandC("set") as SetCmd;
	SensingP.GetCmd -> GetCmd;
	SensingP.SetCmd -> SetCmd;

	components new HamamatsuS1087ParC() as LightC;
	SensingP.Light -> LightC;

	components new TimerMilliC() as LightTimer;
	SensingP.LightTimer -> LightTimer;

	components new ConfigStorageC(VOLUME_CONFIG) as LightSettings;
	SensingP.ConfigMount -> LightSettings;
	SensingP.ConfigStorage -> LightSettings;
}
