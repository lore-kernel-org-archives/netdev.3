Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BE3A9856
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163598; cv=none; b=t9iY8xol5RJ70mAP3fVUhBkyvRd7uSnri9t8QwAY6+kQUl6+eaGfdJOLxKqOgmoOqTLSH+wdKh8q146W08FNTPXktXS9vdtZoS+Ns1AyzcOGce4k6cXlalipMQffqkq5+joRPOJ05txu7F13TD4/hMqoOrYx5hS+BAtIrzgUWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163598; c=relaxed/simple;
	bh=8BRQlhI6CSykfwzXJJnS/Hu3ZpIG/9o66wIlyBmN9qU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jG2yFNapvqZIAE541vbj36rY2urJWGP60xYKM6wQIjUwEDx+JJIupzLRPQePFDm6XksgrEKKl8VO6sRcv7ffGtM0XDSsdqZxGrcLSUoPi7ueUwvocJZDRXYX6fDguPuwpWtJXxThROO0jAxe1Pcg3QyiRd5EdWceHFis5A/m3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=oRTiyHDw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="oRTiyHDw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so2786882a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1788163595; x=1788768395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yFKFbmtMt8kULTgC57DYAGg0UOmXOs2gF1gOFDlnuB8=;
        b=oRTiyHDw85qMc5YcjjFEEtoCL5S0cIvUcXFu0a/0PKxpeE2REAUlcYAHzgGQLKP8+j
         pkmPcmt+Y1BBLAkd30VCKlblxkBBxitnqND9kGksGdz746O0BVsmhWsnDaXeG/GjYK/6
         EppswBj0Phf1wRnIZsFOJ/KjXU0lnA3cxO8FUDHhYPaoBLxKmeAUo1F4xe67k4wsXeWx
         99IzpH2BGc7ShI22/xohdMd4h+iagU7IZflYrdwolxOIt4bcjn2HiSP3B9O1J//XPkUU
         Tfggnfx2YDFgL1V7XazaK2wVPuhpDxvFVyY5lZym50IBUoU4KOOSjjSZ9LOaUFaPJX8E
         buAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163595; x=1788768395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFKFbmtMt8kULTgC57DYAGg0UOmXOs2gF1gOFDlnuB8=;
        b=cv++zV0c49lWMYir4x9CfVm/+bmqGv/fCImDPBtIlENqHPTrlTMtLzfp2L39poWC1n
         9/fA/sNtBg5UuaO5Y8pWNUGRleYKVBIOOl6PZak9YwvJb2cXBCSqEeKHADL0BSDe4Jua
         VlHQC8vPji8yDTtu0kZi4zR1Cel68fKW99SA4opJG/KKLkMrptLMWmmzJqr3TG+QORGv
         sYvG+AB1E8xLP5b2ZTUsDSLfxwl6PuNTGOdvIFfLEJEaB8W8uMcCQ86KrCEmz0rhtsiz
         qc25VX8zcz0grH9Dnkw1rVdcIc8UR3Wjx9mCfpWGS0A6uXS3Um0N6jTqEsrxeUl+OiTR
         Cfvg==
X-Gm-Message-State: AFuF++lIM4BU5B83+eamR4xcCNI3DN5/sOaXriihLVJ0mvueHNTKyKTT
	lFCWFlE4T7HYtVszOsjRTvFb1lkGzWoibgahIuBcOeB5anpIaKOmP0rvhM31LX3Bb2SCuzXuOJt
	SLxGJIPlMKbmwdzMRuFpBrL7PP8b39XcY2MYY9q6ZW3UHwjbyJ4bic9+MEJhNj5gFBBw=
X-Gm-Gg: AYBFou35+GHUDv2UXJra6C/MLNhhj8ms+gjwVuJAOsWtJzroYA947gUTNWaabGWgbnw
	G0F3kK6ajogPF+aEBiDdoSIqBCVKPeDihMr3tsVNWOxPYjPhV0KSdDIWGpEnG6WmkMvI/6zWGEw
	36VmLtD+lMOfrYA9lMTvtOTf8A/P3PeysFLmG0/bFd30VCzIo5lJjBaKd0mKV3xYoPPDiD+I1ft
	96aULNH+h9KNWZ3SbLSns5WJktGw9RlMf2PXeBrTli9Fbppw9APEcuyvvFymGlrjo2W9hZmUfix
	o2vZcRQJJbva0b7JocVYaNR7ZNhhsHQBL9TxkDosDTUv2AhwC36CSGZrpR7qxA0khEdKQMHgWZo
	J5wQQUD2L1D4Epa/Iu+Nh67UFYmRtnQYOu9t6XnHNkk7twUNN+83vxrSxc9IdsfuqDZBJms3Q7r
	Q5WsfbftnYcGPOwW3hBzGERFttGqVdTsb3dm2M+y734whq3xPiFjP5WHFAqsT+RiEHINPw2W3FM
	g==
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-396d0de4c19mr36317818a91.6.1788163592978;
        Mon, 31 Aug 2026 01:06:32 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm28099812eec.28.2026.08.31.01.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:06:32 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next] net: sysfs: use ops lock for speed and duplex
Date: Mon, 31 Aug 2026 16:06:23 +0800
Message-ID: <20260831080623.1064001-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading /sys/class/net/<dev>/{speed,duplex} takes rtnl_lock() before
calling __ethtool_get_link_ksettings(). For ops-locked devices whose
callbacks do not require RTNL, this unnecessarily serializes sysfs
readers with rtnetlink users. On CPU-throttled hosts, a periodic reader
such as node-exporter can keep RTNL held for hundreds of milliseconds
while an mlx5 callback runs.

Ops-locked devices can run ethtool operations under the netdev instance
lock. The ethtool netlink and ioctl paths use
ETHTOOL_OP_NEEDS_RTNL_LINKSETTINGS to identify callbacks that still need
RTNL, but the sysfs path currently does not. Apply the same rule to sysfs
reads: call netif_get_link_ksettings() under netdev_lock_ops() when the
callback does not require RTNL, and keep sysfs_rtnl_lock() for legacy
devices and callbacks that opt in to RTNL.

Preserve the existing speed and duplex sysfs ABI, including -EINVAL for
devices that are down or callbacks that fail.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/core/net-sysfs.c | 122 +++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 51 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 352173df75785..3e01e7f3cac79 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -118,6 +118,55 @@ static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
 	return ret;
 }
 
+/*
+ * Use the per-device ops lock without RTNL when the device supports it.
+ * Legacy devices and callbacks which explicitly require RTNL retain the
+ * existing locking.
+ */
+static int sysfs_get_link_ksettings(struct device *dev,
+				    struct device_attribute *attr,
+				    struct ethtool_link_ksettings *cmd)
+{
+	struct net_device *netdev = to_net_dev(dev);
+	int ret = -EINVAL;
+	bool need_rtnl;
+
+	/*
+	 * The check is also done in netif_get_link_ksettings(); this helps
+	 * returning early without hitting the locking section below.
+	 */
+	if (!netdev->ethtool_ops->get_link_ksettings)
+		return ret;
+
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
+	ret = -EINVAL;
+	if (!dev_isalive(netdev)) {
+		ret = -ENODEV;
+	} else if (netif_running(netdev)) {
+		/*
+		 * Keep the sysfs ABI: report any callback error as -EINVAL
+		 * instead of propagating the driver's error code.
+		 */
+		if (!netif_get_link_ksettings(netdev, cmd))
+			ret = 0;
+	}
+
+	netdev_unlock_ops(netdev);
+	if (need_rtnl)
+		rtnl_unlock();
+
+	return ret;
+}
+
 /* use same locking rules as GIF* ioctl's */
 static ssize_t netdev_show(const struct device *dev,
 			   struct device_attribute *attr, char *buf,
@@ -332,27 +381,13 @@ static DEVICE_ATTR_RW(carrier);
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
-
-	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
-	if (ret)
-		return ret;
+	struct ethtool_link_ksettings cmd;
+	int ret;
 
-	ret = -EINVAL;
-	if (netif_running(netdev)) {
-		struct ethtool_link_ksettings cmd;
+	ret = sysfs_get_link_ksettings(dev, attr, &cmd);
+	if (!ret)
+		ret = sysfs_emit(buf, fmt_dec, cmd.base.speed);
 
-		if (!__ethtool_get_link_ksettings(netdev, &cmd))
-			ret = sysfs_emit(buf, fmt_dec, cmd.base.speed);
-	}
-	rtnl_unlock();
 	return ret;
 }
 static DEVICE_ATTR_RO(speed);
@@ -360,41 +395,26 @@ static DEVICE_ATTR_RO(speed);
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
-
-	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
-	if (ret)
-		return ret;
-
-	ret = -EINVAL;
-	if (netif_running(netdev)) {
-		struct ethtool_link_ksettings cmd;
-
-		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
-			const char *duplex;
+	struct ethtool_link_ksettings cmd;
+	const char *duplex;
+	int ret;
 
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
+	ret = sysfs_get_link_ksettings(dev, attr, &cmd);
+	if (!ret) {
+		switch (cmd.base.duplex) {
+		case DUPLEX_HALF:
+			duplex = "half";
+			break;
+		case DUPLEX_FULL:
+			duplex = "full";
+			break;
+		default:
+			duplex = "unknown";
+			break;
 		}
+		ret = sysfs_emit(buf, "%s\n", duplex);
 	}
-	rtnl_unlock();
+
 	return ret;
 }
 static DEVICE_ATTR_RO(duplex);

base-commit: 1bb784eb6e38fd73143f021608e4ef3095d0c0d7
-- 
2.47.3

