#include "Timer.h"

module PlatIOP {
	uses {
		interface Boot;
		interface Timer<TMilli> as Timer0;
		interface Timer<TMilli> as Timer1;
		interface Timer<TMilli> as Timer2;
		interface GeneralIO as Pin0;
		interface GeneralIO as Pin1;
		interface GeneralIO as Pin2;
	}
}
implementation{
	event void Boot.booted(){
		call Timer0.startPeriodic(100);
		call Timer1.startPeriodic(400);
		call Timer2.startPeriodic(1000);
	}

	event void Timer0.fired(){
		if(call Pin0.get())
			call Pin0.set();
		else
			call Pin0.clr();
	}

	event void Timer1.fired(){
		if(call Pin1.get())
			call Pin1.set();
		else
			call Pin1.clr();
	}

	event void Timer2.fired(){
		if(call Pin2.get())
			call Pin2.set();
		else
			call Pin2.clr();
	}
}
