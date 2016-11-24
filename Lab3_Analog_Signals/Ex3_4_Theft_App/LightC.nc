#define NEW_PRINTF_SEMANTICS

configuration LightC {
}
implementation {

	components MainC, LightP, LedsC;
	LightP -> MainC.Boot;
	LightP.Leds -> LedsC;
	components IPStackC;
	components IPDispatchC;
	components UdpC;
	components UDPShellC;
	components RPLRoutingC;;

	components StaticIPAddressTosIdC;

	LightP.RadioControl -> IPStackC;

	components new ShellCommandC("stream") as StreamCmd;
	components new ShellCommandC("threshold") as ChangeThresholdCmd;
	LightP.StreamCmd -> StreamCmd;
	LightP.ChangeThresholdCmd -> ChangeThresholdCmd;

	components new TimerMilliC() as Timer1;
	LightP.Timer1 -> Timer1;

	components new HamamatsuS1087ParC() as SensorPar;
	LightP.StreamPar -> SensorPar.ReadStream;

#ifdef PRINTFUART_ENABLED
  components SerialPrintfC;

#endif
}
