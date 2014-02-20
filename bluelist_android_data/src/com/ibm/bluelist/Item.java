/*
 * IBM Confidential OCO Source Materials
 * 
 * Copyright IBM Corp. 2014
 * 
 * The source code for this program is not published or otherwise
 * divested of its trade secrets, irrespective of what has
 * been deposited with the U.S. Copyright Office.
 */

package com.ibm.bluelist;

import com.ibm.mobile.services.data.IBMDataObject;
import com.ibm.mobile.services.data.IBMDataObjectSpecialization;

@IBMDataObjectSpecialization("Item")
public class Item extends IBMDataObject {
	public static final String CLASS_NAME = "Item";
	private static final String NAME = "name";
	
	/**
	 * gets the name of the Item.
	 * @return String itemName
	 */
	public String getName() {
		return (String) getObject(NAME);
	}

	/**
	 * sets the name of a list item, as well as calls setCreationTime()
	 * @param String itemName
	 */
	public void setName(String itemName) {
		setObject(NAME, (itemName != null) ? itemName : "");
	}
	
	/**
	 * when calling toString() for an item, we'd really only want the name.
	 * @return String theItemName
	 */
	public String toString() {
		String theItemName = "";
		theItemName = getName();
		return theItemName;
	}
}
