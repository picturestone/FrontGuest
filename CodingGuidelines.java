package at.fhv.sma.ue02;

import java.util.Iterator;

/**
 * Klassenbeschreibung ...
 * 	- static/final variables
 *  - grouped global variables
 *  - inner classes
 *  - constructor
 *  - sorted methods
 *  - getters and setters
 * @author	simon
 * @since	23/03/18
 * @version	v0.1
 *
 */
public class Codereview {

	//in this order
	private final static int sUPPERCASE = 0;			//or static final
	private static int sVariable = 1;
	private final String ANOTHERVERYLONGNAME = "bla";	//constant variable
	
	//doSomething
	private String _globalStr;							//description
	private boolean _isVeryLongName;
	private int _x, _y, _z;
	
	//doNothing
	private int _uselessVariable;
	
	/**
	 * Klassenbeschreibung ...
	 * @author	simon
	 * @since	23/03/18
	 * @version	v0.1
	 *
	 */
	private class MyInnerClass {
		
	}
	
	/**
	 * Konstruktorbeschreibung
	 */
	public Codereview() {
		_globalStr  = "";
		_isVeryLongName = true;
		_x = 1;
		_y = 1;
		_z = 2;
	}
	
	/**
	 * This is a methode which does someting.
	 * @param	a
	 * 			a Integer, ...
	 * 
	 * @param	b
	 * 			a Integer, ...
	 * 
	 * @return	true, if 1 is greater than 2 blablabla
	 * 			blablablablablablablablablablablabla
	 * 
	 * @throws	MyException
	 * 			Possible cause of the Exception ...
	 */
	public boolean doSomething(int a, int b) throws MyException {
		int i = 0;
		
		if (false) {
			throw new MyException();
		} else if (true) {
			
		} else {
			
		}
		
		int j = 0;
		while (j < 10) {
			j++;
		}
		
		for (int k = 0; k < array.length; k++) {
			
		}
		
		for (iterable_type iterable_element : iterable) {
			
		}
		
		return (1 > 2) ? true : false;
		
		return (1 > 0);
	}
	
	/**
	 * This is a methode which does nothing.
	 */
	public void doNothing() {
		
	}
	
	
	/* Getters and Setters */			//required comment
	public String getGlobalStr() {		//same name as variable
		return _globalStr;
	}
	
	public boolean getIsVeryLongName() {
		return _isVeryLongName;
	}
}
