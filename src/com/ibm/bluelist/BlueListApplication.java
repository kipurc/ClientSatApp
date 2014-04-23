/*
 * Copyright 2014 IBM Corp. All Rights Reserved
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0 
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ibm.bluelist;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import android.app.Activity;
import android.app.Application;
import android.content.res.AssetManager;
import android.os.Bundle;
import android.util.Log;

import com.ibm.mobile.services.core.IBMBaaS;
import com.ibm.mobile.services.data.IBMDataService;

public final class BlueListApplication extends Application {
	public static final int EDIT_ACTIVITY_RC = 1;
	private static final String CLASS_NAME = BlueListApplication.class.getSimpleName();
	private static final String APP_ID = "applicationID";
	private static final String BAAS_PROPS_FILE = "baas.properties";
	List<Item> itemList;

	public BlueListApplication() {
		registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
			@Override
			public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
				Log.d(CLASS_NAME, "Activity created: " + activity.getLocalClassName());
				// Read from a properties file
				Properties props = new java.util.Properties();
				try {
					AssetManager assetManager = activity.getAssets();					
					props.load(assetManager.open(BAAS_PROPS_FILE));
					Log.i(CLASS_NAME, "Found configuration file: " + BAAS_PROPS_FILE);
				} catch (FileNotFoundException e) {
					Log.e(CLASS_NAME, "The baas.properties file was not found.", e);
				} catch (IOException e) {
					Log.e(CLASS_NAME, "The baas.properties file could not be read properly.", e);
				}
				Log.i(CLASS_NAME, "Application ID is: " + props.getProperty(APP_ID));
				// initialize the IBM core backend-as-a-service
			    IBMBaaS.initializeSDK(activity, props.getProperty(APP_ID));
			    // initialize the IBM Data Service
			    IBMDataService.initializeService();
			    // register Item data specialization
			    Item.registerSpecialization(Item.class);
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
	    //Item.registerSpecialization(Item.class);
	}
	
	/**
	 * returns the itemList, an array of Item objects.
	 * @return itemList
	 */
	public List<Item> getItemList() {
		return itemList;
	}
}