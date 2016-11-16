configuration Shell_LedC{
}
implementation{
	components MainC, LedsC, Shell_LedP;
	
	Shell_LedP.Boot -> MainC.Boot;
	Shell_LedP.Leds -> LedsC;

	components IPStackC;
	components UDPShellC;
	components RPLRoutingC;
	components StaticIPAddressTosIdC;

	Shell_LedP.RadioControl -> IPStackC;

	components new ShellCommandC("0") as Digit0;
	components new ShellCommandC("1") as Digit1;
	components new ShellCommandC("2") as Digit2;
	components new ShellCommandC("3") as Digit3;
	components new ShellCommandC("4") as Digit4;
	components new ShellCommandC("5") as Digit5;
	components new ShellCommandC("6") as Digit6;
	components new ShellCommandC("7") as Digit7;
	Shell_LedP.Digit0 -> Digit0;
	Shell_LedP.Digit1 -> Digit1;
	Shell_LedP.Digit2 -> Digit2;
	Shell_LedP.Digit3 -> Digit3;
	Shell_LedP.Digit4 -> Digit4;
	Shell_LedP.Digit5 -> Digit5;
	Shell_LedP.Digit6 -> Digit6;
	Shell_LedP.Digit7 -> Digit7;

#ifdef PRINTFUART_ENABLED
  /* This component wires printf directly to the serial port, and does
   * not use any framing.  You can view the output simply by tailing
   * the serial device.  Unlike the old printfUART, this allows us to
   * use PlatformSerialC to provide the serial driver.
   *
   * For instance:
   * $ stty -F /dev/ttyUSB0 115200
   * $ tail -f /dev/ttyUSB0
  */
  components SerialPrintfC;

  /* This is the alternative printf implementation which puts the
   * output in framed tinyos serial messages.  This lets you operate
   * alongside other users of the tinyos serial stack.
   */
  // components PrintfC;
  // components SerialStartC;
#endif
}
