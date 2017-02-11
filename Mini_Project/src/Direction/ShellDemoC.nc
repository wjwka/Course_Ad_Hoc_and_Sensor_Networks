#include "hardware.h"


configuration ShellDemoC {
}
implementation {

	components MainC, ShellDemoP;
    components HplMsp430GeneralIOC;
    components new Msp430GpioC() as Forward;
    components new Msp430GpioC() as Backward;
	ShellDemoP.Boot -> MainC.Boot;

	components IPStackC;
	components UDPShellC;
	components RPLRoutingC;
	components StaticIPAddressTosIdC;

	ShellDemoP.RadioControl -> IPStackC;

    ShellDemoP.Forward -> Forward;
    ShellDemoP.Backward -> Backward;

    Forward -> HplMsp430GeneralIOC.Port26;
    Backward -> HplMsp430GeneralIOC.Port23;

	components new ShellCommandC("forward") as ForwardCmd;
	ShellDemoP.ForwardCmd -> ForwardCmd;
	components new ShellCommandC("backward") as BackwardCmd;
	ShellDemoP.BackwardCmd -> BackwardCmd;
	components new ShellCommandC("stop") as StopCmd;
	ShellDemoP.StopCmd -> StopCmd;

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
