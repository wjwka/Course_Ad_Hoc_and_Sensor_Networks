configuration SensingC {
} implementation {
	components MainC, LedsC, SensingP;
	SensingP.Boot -> MainC;
	SensingP.Leds -> LedsC;

	components IPStackC;
	components RPLRoutingC;
	components StaticIPAddressTosIdC;
	SensingP.RadioControl -> IPStackC;

	components new TimerMilliC() as SenseTimer;
        components new TimerMilliC() as SenseTimer_Light;
	SensingP.SenseTimer -> SenseTimer;
        SensingP.SenseTimer_Light-> SenseTimer_Light;
	components new SensirionSht11C() as HumiditySensor;
	SensingP.Humidity -> HumiditySensor.Humidity;
        components new HamamatsuS1087ParC() as LightSensor;
	SensingP.Light -> LightSensor;
	components new UdpSocketC() as SenseSend;
	SensingP.SenseSend -> SenseSend;
        components new UdpSocketC() as SenseSend_Light;
	SensingP.SenseSend_Light -> SenseSend_Light;

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
