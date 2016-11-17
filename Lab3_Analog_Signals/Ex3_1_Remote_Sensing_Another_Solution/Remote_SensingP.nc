#include <stdio.h>
module Remote_SensingP{
	uses interface Boot;
	uses interface SplitControl as RadioControl;
	uses interface ShellCommand as ReadPar;
	uses interface Read<uint16_t> as LightPar;
	provides event void status();
}
implementation{
	int light_intensity = 0;
	int flag = 0;
	//char* ret_string = malloc(16*sizeof(char));
	event void Boot.booted(){
		call RadioControl.start();		
	} 
	
	event void RadioControl.startDone(error_t e) {}
	
	event void status(){
		flag = 1;
	}

	event void RadioControl.stopDone(error_t e) {}
	
	event char* ReadPar.eval(int argc, char** argv){ 
		char* ret = call ReadPar.getBuffer(16); 
		call LightPar.read();
		while(!flag);
		snprintf(ret, 16,  "	[value: %d]\n", light_intensity);
		flag = 0;
		return ret;
	}

	event void LightPar.readDone(error_t e, uint16_t val){
		if(e == SUCCESS){
			light_intensity = val;		
		}
		else{
			light_intensity = -1;
		}
		signal status();
	}
	
}
