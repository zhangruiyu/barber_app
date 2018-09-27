package com.ruiyu.tencentcos;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Build;
import android.preference.PreferenceManager;

/**
 * Created by wjielai on 2017/8/29.
 * <p>
 * Copyright (c) 2010-2017 Tencent Cloud. All rights reserved.
 */

public class Identifier {

    private static SharedPreferences sharedPreferences;

    public static int getIdentifier(Context context) {
        sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context);
        String key = "identity";

        if (sharedPreferences.contains(key)) {
            return sharedPreferences.getInt(key, 0);
        }

        String identity = Build.DEVICE + Build.BRAND + Build.SERIAL + Build.FINGERPRINT;
        int code = Math.abs(identity.hashCode() & 0xFFFFF);

        sharedPreferences.edit().putInt(key, code).apply();

        return code;

    }

    public static String getUserBucket() {
        return sharedPreferences.getString("userBucket", null);
    }

    public static void setUserBucket(String userBucket) {
        sharedPreferences.edit().putString("userBucket", userBucket).apply();
    }

    public static String getUploadId() {
        return sharedPreferences.getString("uploadId", null);
    }

    public static void setUploadId(String uploadId) {
        sharedPreferences.edit().putString("uploadId", uploadId).apply();
    }
}
