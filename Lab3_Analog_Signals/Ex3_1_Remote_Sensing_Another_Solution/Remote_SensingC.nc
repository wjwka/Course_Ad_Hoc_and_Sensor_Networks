configuration Remote_SensingC{
}
implementation{
	components MainC, Remote_SensingP;
	components new HamamatsuS1087ParC() as SensorPar;
	
	Remote_SensingP.Boot -> MainC.Boot;

	components IPStackC;
	components UDPShellC;
	components RPLRoutingC;
	components StaticIPAddressTosIdC;
	Remote_SensingP.RadioControl -> IPStackC;
	Remote_SensingP.LightPar -> SensorPar;	
	components new ShellCommandC("read-par") as ReadPar;
	Remote_SensingP.ReadPar -> ReadPar;

#ifdef PRINTFUART_ENABLED
	components SerialPrintfC;
#endif
	
	
	
}
