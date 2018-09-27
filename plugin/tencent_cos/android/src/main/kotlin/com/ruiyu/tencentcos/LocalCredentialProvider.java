package com.ruiyu.tencentcos;

import com.tencent.qcloud.core.auth.QCloudCredentialProvider;
import com.tencent.qcloud.core.auth.QCloudCredentials;
import com.tencent.qcloud.core.common.QCloudClientException;

class LocalCredentialProvider implements QCloudCredentialProvider {
    @Override
    public QCloudCredentials getCredentials() throws QCloudClientException {
        return new QCloudCredentials() {
            @Override
            public String getSecretId() {
                return null;
            }
        };
    }

    @Override
    public void refresh() throws QCloudClientException {

    }
}
