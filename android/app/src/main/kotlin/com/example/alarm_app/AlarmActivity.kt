package com.example.alarm_app

import android.content.Context
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import io.flutter.embedding.engine.FlutterEngine

class AlarmActivity : ComponentActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      setContent {
          Surface(
              modifier = Modifier.fillMaxSize(),
              color = MaterialTheme.colorScheme.background
          ) {
              Column(
                  horizontalAlignment = Alignment.CenterHorizontally,
              ) {
                  Text(text = "Alarm Nyala")
                  Spacer(modifier = Modifier.height(256.dp))
                  AlarmButton(LocalContext.current as AlarmActivity)
              }
          }
  }
}
}

@Composable
fun AlarmButton(activity: AlarmActivity) {
    Button(
        onClick = {activity.finish()}
    ) {
        Text(text = "OK")
    }
}
