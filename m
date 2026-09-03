Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4E4ACC96
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442460; cv=none; b=T4y/d/nF9qaM4cRb+zAdu6p8G66qLuzi/bczFXTvZZ9RLq5ykUclhJVjgyov34bhcOgJg9rYcuejTc9XJGELpRtF3u6d/kMviaJGsYdew0UQXYhXEkn5t91O7UjpiyLsaUYeUAVayzbhTAXg4RR0Dpu24k4cDjiA5+jvGk73Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442460; c=relaxed/simple;
	bh=B3IN8cTgOYajgIofJSstBFEk7gnWhaCYvlu3RZqS3WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZuJLZ+1exemZ19yQldT3fhc1vmm+ShuTQvq0KEdgoyO/o6C5EPbfX3aqA5xuhm4ymhg+tw+VM+wy9T4rUPt+dqHC4Iglea5CltEi/ZADerj9eSNyJ44pVa9rkAyx2MEaf5FdVQVp2vxKJ1fscn7SKa1R6rlSiFy/nJc01h9zCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=N0wMjRok; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="N0wMjRok"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2859128a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1788442446; x=1789047246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57wFwHH4VQl6f4y7EG38FqZkupmyJLH/i/K4vuMep6c=;
        b=N0wMjRokF9fbtzCEyXaTCK0WIIzmT2AJ6LmLt1gLB6rKLDW/ZfAXrppo52M1DZMbK1
         QQB5W8SCn5NBnlfvG8jWYYHjWPjFaV52xPNmew7YzJjRNKbg2muBoSYo2O79T/S/dvt1
         NVxNBRP779qbdvBcIWQOZLv79exexUrft3tHNz6bcaW5kXIosivcFSWdMqqul/Ce7JAK
         8wI+qXp97b1gDNR6uOwGW0cvbIvfpXyBAxADxEnwiA0wJ41YhHtOczAd6U5SKedPwep8
         WyD/fRs2uqDcQqjrCVJ3EW0elMx6eiSxN2qahbWboQNZ7audeBeWAQtnD7WbHF3yfW+A
         hDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442446; x=1789047246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=57wFwHH4VQl6f4y7EG38FqZkupmyJLH/i/K4vuMep6c=;
        b=SouTtQnLMRRKfp9siCsxKXnjUWhYK6twqESRcDpOw2Mj/ywRto5zKDJ1mK1836C3Cf
         lhRti/6COUUcIbUuSACLIUrKh8mRt4oOA9dx+iMMMZekKMXwhsvLsFVp+Pq1Ac2bT2tN
         8B4QxYU6E1FSDdqTCpVAuyOwGYbP2OYfnQaoiSoRwElCHgYJCBo0dAM1PX6kC4QK7eh/
         Q+jHmaM9Yz6SHCwE/lqgMNPJCBQ8f8f80UPkAOzqFxRZ39pGcEcf1h5AMDMaA3d9YKT7
         q73ht35/H2LdZ3Cp2JtXWBMvhREYFgwZSwHKZPzDaNEamqrwMTLDKQiwuSdLZX9m4YuK
         oeTQ==
X-Gm-Message-State: AFuF++kv9SPPTme48633mVPCJZxlWgsFjdKpE8/dapAMDOpiH5/oG/Rs
	zS8vzZsVJMbYF2YIG0kWURPeHYMp5odBhVgxBCiE96BxRxVWYPuLpEGLbrqXOfkADaERQAZOP/i
	tpj8gsO8Vn7H4JAraRTgCeDGL+HELVczpMGc6/RaldeU2q/3wUIOqcCmSnS+uvGdNNpLRf21VDv
	Jg6A==
X-Gm-Gg: AYBFou0G4G52LeM1aoz8R6VSjuSqpDDB7nRCTGiJ/GtxeQ8lRYmSE151BX5BzpxKnPd
	Xh6ymlP7H/qDjSvFtsjkgqwm/h5QYSFbFx2i4X+ox274B7zcGGkFlWkRviyMx3ghbXRWrE3yezN
	WVWeWWrVTp75kycStDSFmm63FF4bFiqfflpwtHqPj29KXlTxRxWcx/0yd76oBLjeOS5mO4h4DQP
	Kw9asChTJvxvdw2U6ouXT98+Pc99/vyH+zKLh8Nh+l+TQSAhY8Pv+FdBL3VKU/fdVqZdRe1DDdC
	esRsA2udmzcrq3ojcJsklYEkYF9LJWcGWBqt9cXu0ntsUwHza2r9DuSshJoyt+hTdTbnZhuaGcN
	SefObZdg/RcZCoNJGuAgSRtMFA06kjYt56bNc4raSwphl30xkZsqmwEIiM2V4hgsAtx/5ZLxsny
	QPRSLgw7IOH+z4SMfVh9sYQXGbIZh7vp4EeD2/a7efK/qHdJdCQe/e9ztzIQnS01Uu5rjKI1/ky
	g==
X-Received: by 2002:a17:90b:1641:b0:398:c3c9:d0ae with SMTP id 98e67ed59e1d1-39aedc4c929mr15751041a91.0.1788442445539;
        Thu, 03 Sep 2026 06:34:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534e83csm7223347eec.10.2026.09.03.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:34:04 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 2/2] net: sysfs: use ops lock for speed and duplex
Date: Thu,  3 Sep 2026 21:33:14 +0800
Message-ID: <20260903133314.3703381-3-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903133314.3703381-1-wang.zhan@smartx.com>
References: <20260903133314.3703381-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading /sys/class/net/<dev>/{speed,duplex} takes rtnl_lock() even for
ops-locked devices whose get_link_ksettings callback does not require it.
This unnecessarily serializes monitoring reads with unrelated rtnetlink
operations.

On CPU-throttled hosts, a periodic reader such as node-exporter can hold
RTNL for hundreds of milliseconds while an mlx5 callback runs, delaying
unrelated rtnetlink operations.

Use the netdev instance lock for these devices. Retain sysfs_rtnl_lock()
for legacy devices and callbacks that request
ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS.

Preserve the existing speed and duplex sysfs ABI, including -EINVAL for
devices that are down or callbacks that fail.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/core/net-sysfs.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 7bb8bbc1f71ea..fa790e4425704 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -123,26 +123,41 @@ static int sysfs_get_link_ksettings(struct device *dev,
 				    struct ethtool_link_ksettings *cmd)
 {
 	struct net_device *netdev = to_net_dev(dev);
+	bool need_rtnl;
 	int ret;
 
 	/*
-	 * The check is also done in __ethtool_get_link_ksettings; this helps
+	 * The check is also done in netif_get_link_ksettings; this helps
 	 * returning early without hitting the locking section below.
 	 */
 	if (!netdev->ethtool_ops->get_link_ksettings)
 		return -EINVAL;
 
-	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
-	if (ret)
-		return ret;
+	need_rtnl = !netdev_need_ops_lock(netdev) ||
+		    (netdev->ethtool_ops->op_needs_rtnl &
+		     ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS);
+	if (need_rtnl) {
+		ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
+		if (ret)
+			return ret;
+	}
+	netdev_lock_ops(netdev);
+
+	if (!dev_isalive(netdev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
 
 	ret = -EINVAL;
 	if (netif_running(netdev)) {
-		if (!__ethtool_get_link_ksettings(netdev, cmd))
+		if (!netif_get_link_ksettings(netdev, cmd))
 			ret = 0;
 	}
 
-	rtnl_unlock();
+unlock:
+	netdev_unlock_ops(netdev);
+	if (need_rtnl)
+		rtnl_unlock();
 	return ret;
 }
 
-- 
2.47.3

