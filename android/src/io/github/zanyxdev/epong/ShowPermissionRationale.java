// Java code to request data read/write permissions
package io.github.zanyxdev.epong;

import android.app.Activity;
import android.app.Dialog;

import android.content.DialogInterface;
import android.content.Intent;

import android.os.Bundle;

import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.DialogFragment;
import androidx.annotation.Nullable;


// Method to request permissions for the read and write from / to an external storage
public class ShowPermissionRationale {
    // Activity variable passed in from the Qt program
    private final Activity m_MainActivity;

    // Method to request permissions
    public ShowPermissionRationale(Activity MainActivity) {
        m_MainActivity = MainActivity;

        MainActivity.runOnUiThread(new Runnable(){
            @Override
            public void run(){
                showRationaleDialog(m_MainActivity,
                                    m_MainActivity.getString(R.string.rationale_title),
                                    m_MainActivity.getString(R.string.rationale_desc)
                               );

            }
        });
    }
/**
     * Shows rationale dialog for displaying why the app needs permission
     * Only shown if the user has denied the permission request previously
     */
    private void showRationaleDialog(Context context, String title, String message) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setTitle(title)
               .setMessage(message)
               .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) { ; }
               });
        builder.create().show();
    }

}
