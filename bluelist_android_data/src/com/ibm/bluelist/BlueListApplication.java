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

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;
import android.util.Log;

import com.ibm.mobile.services.core.IBMBaaS;

public final class BlueListApplication extends Application {
	public static final int EDIT_ACTIVITY_RC = 1;
	private static final String CLASS_NAME = BlueListApplication.class.getSimpleName();
	List<Item> itemList;

	public BlueListApplication() {
		registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
			@Override
			public void onActivityCreated(Activity activity,Bundle savedInstanceState) {
				Log.d(CLASS_NAME, "Activity created: " + activity.getLocalClassName());
				//Initialize the SDK
			    IBMBaaS.initializeSDK(activity);
			}
			@Override
			public void onActivityStarted(Activity activity) {
				Log.d(CLASS_NAME, "Activity started: " + activity.getLocalClassName());
			}
			@Override
			public void onActivityResumed(Activity activity) {
				Log.d(CLASS_NAME, "Activity resumed: " + activity.getLocalClassName());
			}
			@Override
			public void onActivitySaveInstanceState(Activity activity,Bundle outState) {
				Log.d(CLASS_NAME, "Activity saved instance state: " + activity.getLocalClassName());
			}
			@Override
			public void onActivityPaused(Activity activity) {
				Log.d(CLASS_NAME, "Activity paused: " + activity.getLocalClassName());
			}
			@Override
			public void onActivityStopped(Activity activity) {
				Log.d(CLASS_NAME, "Activity stopped: " + activity.getLocalClassName());
			}
			@Override
			public void onActivityDestroyed(Activity activity) {
				Log.d(CLASS_NAME, "Activity destroyed: " + activity.getLocalClassName());
			}
		});
	}
	
	@Override
	public void onCreate() {
		super.onCreate();
		itemList = new ArrayList<Item>();
	    Item.registerSpecialization(Item.class);
	}
	
	/**
	 * returns the itemList, an array of Item objects.
	 * @return itemList
	 */
	public List<Item> getItemList() {
		return itemList;
	}
}