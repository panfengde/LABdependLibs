package com.pf.createAndroidLibs;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

import com.pf.createAndroidLibs.databinding.ActivityMainBinding;

public class MainActivity extends AppCompatActivity {

    // Used to load the 'createAndroidLibs' library on application startup.
    static {
        System.loadLibrary("createAndroidLibs");
    }

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

    }

}