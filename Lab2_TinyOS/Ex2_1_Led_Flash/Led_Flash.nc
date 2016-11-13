module Led_Flash{
  	uses interface Timer<TMilli> as Timer0;
  	uses interface Timer<TMilli> as Timer1;
	uses interface Leds;
	uses interface Boot;
}
implementation{
	event void Boot.booted(){
		call Timer0.startPeriodic(100);		
		call Timer1.startPeriodic(1100);		
	}

  	event void Timer0.fired()
  	{
    		dbg("BlinkC", "Timer 0 fired @ %s.\n", sim_time_string());
    		call Leds.led0On();
  	}

  	event void Timer1.fired()
  	{
    		dbg("BlinkC", "Timer 1 fired @ %s.\n", sim_time_string());
    		call Leds.led0Off();
  	}
}
