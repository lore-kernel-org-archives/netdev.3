Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2284AF177
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442449; cv=none; b=Zj20iuXXOV+G4GNX4iYAN0ee68Y/4/6cVTw+X4gWTt2LlHR4lraKuQXug4osaiC3wrWSIi/x1+nwbQ7gnyiNlsOTBfcjWaxxS0BRaSb+V2Ob6kmVDrbNUr+RgFxeJAiVYRGz01FUw79jTjPYmlqlxnEuL7gK8J+ANnajprFJnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442449; c=relaxed/simple;
	bh=xAikrkaoNe6ulSGCMoG5jDI8eY1vJF+BqHXdSFIy8Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJxZjbUfBo9h3aQsF6FGnWdskPQkzRefYNbt1gFGtbIayZmdloHXxS3RKW1Uzj9VctaL9jFfC3spioLA/qCnvLQ+DTFSDiXeLEaFg2r6yCWMLBUnHY4rXFozGPFyvcO313w28TgSfS95iJdP6mW0eURyB/10d6iNZwdCQOC/Guo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=RorfLm9E; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="RorfLm9E"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso1879348a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1788442440; x=1789047240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXHL95Icp1Gl54s5WQWI0NUGFyuFCI+fXuPlLc4hAyk=;
        b=RorfLm9EWT0pFpE5GxgGglXn1mwJRJovhuGWDqmLmFQNiz/EL3UiOAD6XEq+Am1Yqf
         vyQQhwgvUu0ZaZs09Ye1fJ95aSZmgXtLESV8aScltue0flMn75zhE3VQdfC1shu+BMKi
         LEBRMMpNhVZKcZlS+E8J14aTuCPMjdGUXplREpfDejI9iycJdXDlQm7tVXhWnYoBnceR
         EWJnMTReW+R1MXzxL0eOU+Cz2koSI6NNB6AoGQt6GRGhX+guv2smYYRlA+eufRD6CAq5
         o18HkjThup0nLQuPRxSII/QcL5G9yBqzDg7Mci6SN6flG7Qs4boLlKm5SnJJ6+uydtBZ
         4QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442440; x=1789047240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXHL95Icp1Gl54s5WQWI0NUGFyuFCI+fXuPlLc4hAyk=;
        b=DUGtPmn0Zv41xTS+2+gLiB4UypkwRhAyh6QEOWYLc8KwbRW9tXZXJIPedklSrhx+QY
         wdjlZoZNdkVOp3isYiAECv2DNdawerlLck+zkSgRci0Lb15pEQGSgyNpzlYgzBKURcPw
         vmDAFOewLBbcINT8/JXV0smKVgedKLIf/tkmJeCjzjIm3pxOPlB7cqiTAeVvBIF8zdTd
         FtxoE55tap4TDN9fd4IujmHUCHioaf+vis1kE4XMUULZSHCFsq0XJmfBuPHiawFXT0ql
         s2kF+jqZIe4vT//YDgsotsyKy/9HEqSZdDZghKB0JgsBTxxrRdldIpt3T/qUadxDjC4Y
         ++6Q==
X-Gm-Message-State: AFuF++lXNMBpFTxiyJ9kmdjLm81xl+6cDxtohEstsaV/ueus7DsDzjk0
	jeHEKxw+74jrlMzRT/otdMz2kE4bANFgKuIkQxF9RNFr8Tkp0tPfr+G7d9u31XDnIKF3Wocq+mH
	ZhXDvHnArXK/fLdC5Zle6gwKSnh5ui8SZAwj0L7yD1MVLyvdt83s2rDjJyyI3GpkMc6eMh1LRMP
	GbRA==
X-Gm-Gg: AYBFou3ZPz50d6lsAU8myP46eZWNZqwyVs+YA0STdGv2tVq516BdW87pQVgFVbyNTS5
	a3mzInZW0puWrbtrO4RycCy58XmT7tRCH6JCb7sZeyPm7jpk8CnSKpgSloVx0+2mKdiCs0Y3U0I
	vj8TKLRqsqqMEvgpBzx1u8nE3+Mhq+IkXDiE1hOXSmGYV56RawnIv6sIJBr2EKZDGsQDvAHXBtr
	4lUUKdxq2pxpy9ue+s36ggu6sbDyh18VLOhPYpPeRrwByuBt1Pujnqm40y4r9EL+7rtAcfaDk9y
	PfNQshAhazvnPk8MqUSLBXAMHX3DTN7w65S111iR4GHm4VdDD/P9EDV6/wuMndilCZWxzVnOZyV
	qCmVXhPxwKiGh8MlFBn98rjZgtPNjkaW/D+1MsDaWR782mC9F0a3fjiBkdzqZ4l2fjm+nvBJGAC
	5wB+YjDEBXbXjMZvwrzW9IWl13LFpFeCRJcWNpfMT+YA2ObgCzRsu8rMbqrPr1eI8RdN8pZfpiD
	Q==
X-Received: by 2002:a17:90b:4b91:b0:399:149a:3f27 with SMTP id 98e67ed59e1d1-39aedf162e5mr16574545a91.9.1788442439481;
        Thu, 03 Sep 2026 06:33:59 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534e83csm7223347eec.10.2026.09.03.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:33:58 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 1/2] net: sysfs: factor out link settings read
Date: Thu,  3 Sep 2026 21:33:13 +0800
Message-ID: <20260903133314.3703381-2-wang.zhan@smartx.com>
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

speed_show() and duplex_show() duplicate device validation, RTNL
locking and the link settings query. Move this common work to
sysfs_get_link_ksettings() so later locking changes stay in one place.

RTNL is released before calling sysfs_emit(). The lock only protects the
link settings query; formatting uses the local cmd copy, so the sysfs
output and error handling remain unchanged.

No functional changes.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/core/net-sysfs.c | 97 ++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df75785..7bb8bbc1f71ea 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -118,6 +118,34 @@ static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
 	return ret;
 }
 
+static int sysfs_get_link_ksettings(struct device *dev,
+				    struct device_attribute *attr,
+				    struct ethtool_link_ksettings *cmd)
+{
+	struct net_device *netdev = to_net_dev(dev);
+	int ret;
+
+	/*
+	 * The check is also done in __ethtool_get_link_ksettings; this helps
+	 * returning early without hitting the locking section below.
+	 */
+	if (!netdev->ethtool_ops->get_link_ksettings)
+		return -EINVAL;
+
+	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	if (netif_running(netdev)) {
+		if (!__ethtool_get_link_ksettings(netdev, cmd))
+			ret = 0;
+	}
+
+	rtnl_unlock();
+	return ret;
+}
+
 /* use same locking rules as GIF* ioctl's */
 static ssize_t netdev_show(const struct device *dev,
 			   struct device_attribute *attr, char *buf,
@@ -332,70 +360,41 @@ static DEVICE_ATTR_RW(carrier);
 static ssize_t speed_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	struct net_device *netdev = to_net_dev(dev);
-	int ret = -EINVAL;
-
-	/* The check is also done in __ethtool_get_link_ksettings; this helps
-	 * returning early without hitting the locking section below.
-	 */
-	if (!netdev->ethtool_ops->get_link_ksettings)
-		return ret;
+	struct ethtool_link_ksettings cmd;
+	int ret;
 
-	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
+	ret = sysfs_get_link_ksettings(dev, attr, &cmd);
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (netif_running(netdev)) {
-		struct ethtool_link_ksettings cmd;
-
-		if (!__ethtool_get_link_ksettings(netdev, &cmd))
-			ret = sysfs_emit(buf, fmt_dec, cmd.base.speed);
-	}
-	rtnl_unlock();
-	return ret;
+	return sysfs_emit(buf, fmt_dec, cmd.base.speed);
 }
 static DEVICE_ATTR_RO(speed);
 
 static ssize_t duplex_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	struct net_device *netdev = to_net_dev(dev);
-	int ret = -EINVAL;
-
-	/* The check is also done in __ethtool_get_link_ksettings; this helps
-	 * returning early without hitting the locking section below.
-	 */
-	if (!netdev->ethtool_ops->get_link_ksettings)
-		return ret;
+	struct ethtool_link_ksettings cmd;
+	const char *duplex;
+	int ret;
 
-	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
+	ret = sysfs_get_link_ksettings(dev, attr, &cmd);
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (netif_running(netdev)) {
-		struct ethtool_link_ksettings cmd;
-
-		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
-			const char *duplex;
-
-			switch (cmd.base.duplex) {
-			case DUPLEX_HALF:
-				duplex = "half";
-				break;
-			case DUPLEX_FULL:
-				duplex = "full";
-				break;
-			default:
-				duplex = "unknown";
-				break;
-			}
-			ret = sysfs_emit(buf, "%s\n", duplex);
-		}
+	switch (cmd.base.duplex) {
+	case DUPLEX_HALF:
+		duplex = "half";
+		break;
+	case DUPLEX_FULL:
+		duplex = "full";
+		break;
+	default:
+		duplex = "unknown";
+		break;
 	}
-	rtnl_unlock();
-	return ret;
+
+	return sysfs_emit(buf, "%s\n", duplex);
 }
 static DEVICE_ATTR_RO(duplex);
 
-- 
2.47.3

