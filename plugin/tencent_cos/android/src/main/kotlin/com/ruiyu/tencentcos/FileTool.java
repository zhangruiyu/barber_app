package com.ruiyu.tencentcos;

import java.io.File;

public class FileTool {
    private static final Object lock = new Object();
    private static volatile FileTool instance;

    public FileTool() {
    }

    public static FileTool instance() {
        if (instance == null) {
            Object var0 = lock;
            synchronized (lock) {
                if (instance == null) {
                    instance = new FileTool();
                }
            }
        }

        return instance;
    }

    public boolean isEmpty(String str) {
        return (str == null || str.length() == 0) && this.isBlank(str);
    }

    public boolean isBlank(String str) {
        return str == null || str.trim().length() == 0;
    }

    public String getFileName(String filePath) {
        if (isEmpty(filePath)) {
            return filePath;
        } else {
            int lastSep = filePath.lastIndexOf(File.separator);
            return lastSep == -1 ? filePath : filePath.substring(lastSep + 1);
        }
    }
}
