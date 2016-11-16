configuration PlatIOC{
}
implementation{
	components HplMsp430GeneralIOC;
	components PlatIOP, MainC;
	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	components new TimerMilliC() as Timer2;
	PlatIOP.Boot -> MainC;
	PlatIOP.Timer0 -> Timer0;
	PlatIOP.Timer1 -> Timer1;
	PlatIOP.Timer2 -> Timer2;
	PlatIOP.Pin0 -> HplMsp430GeneralIOC.Port54;
	PlatIOP.Pin1 -> HplMsp430GeneralIOC.Port55;
	PlatIOP.Pin2 -> HplMsp430GeneralIOC.Port56;
}
