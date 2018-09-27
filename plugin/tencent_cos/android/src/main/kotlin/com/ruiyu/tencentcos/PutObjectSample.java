package com.ruiyu.tencentcos;

import android.app.Activity;
import android.util.Log;

import com.tencent.cos.xml.exception.CosXmlClientException;
import com.tencent.cos.xml.exception.CosXmlServiceException;
import com.tencent.cos.xml.listener.CosXmlProgressListener;
import com.tencent.cos.xml.listener.CosXmlResultListener;
import com.tencent.cos.xml.model.object.PutObjectRequest;
import com.tencent.cos.xml.model.object.PutObjectResult;


/**
 * Created by bradyxiao on 2017/6/1.
 * author bradyxiao
 * <p>
 * Put Object 接口请求可以将本地的文件（Object）上传至指定 Bucket 中。该操作需要请求者对 Bucket 有 WRITE 权限。
 */
public class PutObjectSample {
    PutObjectRequest putObjectRequest;
    QServiceCfg qServiceCfg;


    public PutObjectSample(QServiceCfg qServiceCfg) {
        this.qServiceCfg = qServiceCfg;
    }

    public ResultHelper start() {
        ResultHelper resultHelper = new ResultHelper();
        String bucket = qServiceCfg.getBucketForObjectAPITest();
        String cosPath = qServiceCfg.getUploadCosPath();
        String srcPath = qServiceCfg.getUploadFileUrl();

        putObjectRequest = new PutObjectRequest(bucket,cosPath,
                srcPath);

        putObjectRequest.setProgressListener(new CosXmlProgressListener() {
            @Override
            public void onProgress(long progress, long max) {
                float result = (float) (progress * 100.0 / max);
                Log.w("XIAO", "progress =" + (long) result + "%");
            }
        });
        putObjectRequest.setSign(600, null, null);


        try {
            final PutObjectResult putObjectResult =
                    qServiceCfg.cosXmlService.putObject(putObjectRequest);
            Log.w("XIAO","success");
            resultHelper.cosXmlResult = putObjectResult;
            return resultHelper;
        } catch (CosXmlClientException e) {
            Log.w("XIAO","QCloudException =" + e.getMessage());
            resultHelper.qCloudException = e;
            return resultHelper;
        } catch (CosXmlServiceException e) {
            Log.w("XIAO","QCloudServiceException =" + e.toString());
            resultHelper.qCloudServiceException = e;
            return resultHelper;
        }
    }

    /**
     * 采用异步回调操作
     */
    public void startAsync(CosXmlProgressListener cosXmlProgressListener,CosXmlResultListener cosXmlResultListener) {
        String bucket = qServiceCfg.getBucketForObjectAPITest();
        String cosPath = qServiceCfg.getUploadCosPath();
        String srcPath = qServiceCfg.getUploadFileUrl();

        putObjectRequest = new PutObjectRequest(bucket,cosPath,
                srcPath);
        putObjectRequest.setProgressListener(cosXmlProgressListener);
        putObjectRequest.setSign(600, null, null);
        qServiceCfg.cosXmlService.putObjectAsync(putObjectRequest, cosXmlResultListener);
    }

    private void show(Activity activity, String message) {
       /* Intent intent = new Intent(activity, ResultActivity.class);
        intent.putExtra("RESULT", message);
        activity.startActivity(intent);*/
    }
}
