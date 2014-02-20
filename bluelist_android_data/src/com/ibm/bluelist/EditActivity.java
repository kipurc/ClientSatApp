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


import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.TextView.OnEditorActionListener;

import com.ibm.mobile.services.data.IBMDataException;
import com.ibm.mobile.services.data.IBMObjectResult;

public class EditActivity extends Activity {

	String originalItem;
	int location;
	BlueListApplication blApplication;
	List<Item> itemList;
	public static final String CLASS_NAME="EditActivity";
	
	@Override
	/**
	 * onCreate called when edit activity is created.
	 * 
	 * Sets up the application, sets listeners, and gets intent info from calling activity
	 *
	 * @param savedInstanceState
	 */
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		/*get application context, item list*/
		blApplication = (BlueListApplication) getApplicationContext();
		itemList = blApplication.getItemList();
		setContentView(R.layout.activity_edit);
		
		/*information required to edit item*/
		Intent intent = getIntent();
	    originalItem = intent.getStringExtra("ItemText");
	    location = intent.getIntExtra("ItemLocation", 0);
		EditText itemToEdit = (EditText) findViewById(R.id.itemToEdit);
		itemToEdit.setText(originalItem);
		
		/*set key listener for edittext (done key to accept item to list)*/
		itemToEdit.setOnEditorActionListener(new OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                if(actionId==EditorInfo.IME_ACTION_DONE){
                	finishedEdit(v);
                    return true;
                }
                return false;
            }
        });
	}

	/**
	 * on completion of edit, edit itemList, return to main activity with edit return code
	 * @param View v
	 */
	public void finishedEdit(View v) {
		Item item = itemList.get(location);
		EditText itemToEdit = (EditText) findViewById(R.id.itemToEdit);
		String text = itemToEdit.getText().toString();
		item.setName(text);
		/**
		 * IBMObjectResult is used to handle the response from the server after 
		 * either creating or saving an object.
		 * 
		 * onResult is called if the object was successfully saved
		 * onError is called if an error occurred saving the object 
		 */
		item.saveInBackground(new IBMObjectResult<Item>() {
			public void onResult(Item object) {
				if (!isFinishing()) {
					runOnUiThread(new Runnable() {
						public void run() {
							Intent returnIntent = new Intent();
							setResult(BlueListApplication.EDIT_ACTIVITY_RC, returnIntent);
							finish();
						}
					});
				}
			}
			public void onError(IBMDataException error) {
				Log.e(CLASS_NAME, "Exception : " + error.getMessage());
			}
		});
	}
}
