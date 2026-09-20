Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F5429028
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905074; cv=none; b=sXKlyF1A9G/UYT0265n2wLw7o3SoD40ilGAwmvnfe9lmCjmquWdZPjSEKE+SjILEa0xE+77kzlInlr2ox48FMVB2pbuTFn1jtQVZDt5AW6XPjbam4F8kcNiWnXOB2dsmNPcTCrc3daxv98xuJzd7mKX0XxKb++91ECgsAvK5S3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905074; c=relaxed/simple;
	bh=pMbfx0NjIRyRskdHuH6lM861rKcUzwuGwYYxkIB5WEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDzOhQobE/Kig0qoheTLHty/wY3iit0oUio7UPmkRhVEO8ZwZKd0Uz2DxXsVtMKnoc/JxqkK5oPWP7QePoQRaMWb45tPUEwrpiJ8IGx0HOfG8Nn6c/S6r6T/8chzZ9NS3tOVjrYHxjMINWxadbfBbWih56htVMliae/KB3fJGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=02CKOPTe; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="02CKOPTe"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso1601249a91.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789905069; x=1790509869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVn1m5BbAcLTrd543GgGtPm08/ACaaeHnQhjr+DsHvs=;
        b=02CKOPTes+Ch1feJ1RYD3fC7qLguOEqagMo2m7KU2vAFOYhPq/2keCkhF8panELeuP
         3amgJb5qeZ8w2MicYf1/6S2X2dxoV3CgbY999quQf9bExh5e/eYynB0l0rmBq0bfCxao
         Xz6s+/EJU0I/JsxM5wOMgmpuwQv0tstxUe87ZKCg3/70otj1Tzao5TwEon4QLsBwS5CG
         bRmer7haHbAC2uW7F/WVfdKkxaHzHbLd08MOptAgY1PTMtUSb6Qs9xTrbICxZwmdxQoB
         d/jd3Sn+xsMm+KLhOGPMfPkOAtyQSrDgf9ma8m4t//F/qESLaLKzelIFWv0ITbbHxGif
         4WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789905069; x=1790509869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVn1m5BbAcLTrd543GgGtPm08/ACaaeHnQhjr+DsHvs=;
        b=XZ5dSHsZZwYUMIhWfHUtXrne/pflzMwPyJ5eJGNhhu5BIcRpCpmSPq0GIdN7S4Xfi6
         Y3YAE2DTeQ2dn6voz2l3LfVVXuL2dThhVyeBSMjnbF9/s82CjD7NXNGqtlulJIQnjkIK
         n+nMmfwE0M2dpcGgaW1XQUwi02kRhrJDEaiQ9J6J85505RdXmLq9xX1hzN+YIqjIqhqY
         kErSh8mgYs9udChXVksmsZsiiv3YItim4adIxq2QGj/UeqC2Qa5I5YlAM0aVR3xR71Ta
         Zz6wAMiiMISOhdGRAQYUua2+J/U+iGUQoGHeTMEj2zd1KpZtcMc7Wu/+cRREh2KoZF9q
         M46A==
X-Gm-Message-State: AFuF++mq5EwEjSPWwWULFbiVsbP3AlHJT0oW0dopNIRkPBqA2E7HBn9D
	dFc9leT5e7JzjbAGuqjucVhBDDzE9SyjRNLxzjKAx34TmPghxuHEtqpimaMnMwMvSmo/o+sbXFV
	sVdF0iHdSYH0oizgB/ifFrpstX4SqhpK8kIgLrUC21JbJKW7QTwlfIlW5jd2ect4tTjUl99vSaN
	9Jlw==
X-Gm-Gg: AYBFou2uC7omu5CHzeJvL/4w1sAwAHbuDyEopAUPeFSKrhLWIE4CRXPMAKvHcv0WhQL
	fViMFt+bZcsILgxxepcMPIPyabElRhCyAsVdPRtWyHznYH4+FNQtgO+nCh7y46wmF4u/pLr1PPR
	IN9taunpapIxww+r9akrSJ0f+Br3VSZ1w38xXOuM4/IeumjgyP9thwuMQS01LfXgLpejZgtQn+S
	fmV196vazT/ET/yV205LTfyVs2H9LiH9XbnNQu6GuukmRqKsvnOxDAeZuHTTTTFWmnCjLCKiaze
	iTtTUIsmJgJHDoaHX8gK4hEGFJrZO6GCMSslb5F3uIZKUFV/CWfX7BRId9/r4aHYwsSqYBgiZVX
	gGAqPCzRuPWOSLhGkm/aP8sxs9YUU1h4ihQOm4qc3CPLgakpSzEXzHAhX6MXS/r/ay9MjieU9R2
	SCqiQGh2WCQqylZBd804nZnZDZg+e8YWLClXOmKCl53/jM0+TsU1bdzWLkI5kVSN7qFhTcHCmUO
	nJ1xzel+kA=
X-Received: by 2002:a17:90b:380a:b0:39e:6a7f:1dc7 with SMTP id 98e67ed59e1d1-39e6a7f224bmr6783683a91.35.1789905068691;
        Sun, 20 Sep 2026 04:51:08 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm14633990eec.30.2026.09.20.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:51:08 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	steffen.klassert@secunet.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	huyn@nvidia.com,
	raeds@nvidia.com,
	Wang Zhan <wang.zhan@smartx.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] xfrm: free the whole skb list on the packet offload drop
Date: Sun, 20 Sep 2026 19:50:48 +0800
Message-ID: <20260920115048.3549614-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_xmit_skb() hands the segmentation result of one GSO packet down
to validate_xmit_xfrm() as a list.  The drop for a packet whose packet
offload state no longer matches the device frees the first skb only, so
the rest of the list and its payload are leaked.

Fixes: f8a70afafc175 ("xfrm: add TX datapath support for IPsec packet offload mode")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260918084651.3022878-1-wang.zhan%40smartx.com?part=3
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index f153bf695b9dd..0fdd10d29fd1a 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -140,7 +140,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 	 * XFRM stack.
 	 */
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET && x->xso.dev != dev) {
-		kfree_skb(skb);
+		kfree_skb_list(skb);
 		dev_core_stats_tx_dropped_inc(dev);
 		return NULL;
 	}
-- 
2.47.3

