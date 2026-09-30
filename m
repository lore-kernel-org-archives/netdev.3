Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBE4C10D5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766954; cv=none; b=o1RjgZp7CQ3SsYcJbik6ba9NisUUJl+8D3igoEytyyg/6kE9McD5zZed/xWT9OHOUSooaIBtqpx2Xi53zWAvLZgC3VitoLENvDNwJQHPGTKNVI+Z9ki2DMJRhKAhwYU9otanMNUDyJFi/pUaZcA8wsrSyGcf9LZgvspmuWkSFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766954; c=relaxed/simple;
	bh=cwIlXdG0qnPurmIr+m3AsGsicBk6PIpIKIUIJHkUsbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3zEOIp+2PhrrIj3Qm7Mkprrf+ZG1kfVidLurOG88P0u1cBVzTA3gdM/vFLqJxcqIpp8F2RlAvJGnv0+M11wdaL23Zovgo5LOuKaNzeK5YfnPRDf807gdPBzyP6zCY8U480K/wv2nprVa6Ni1Dy7QPBthnYKgTuDp8pYXsnDRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=S8FYN3lR; arc=none smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="S8FYN3lR"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so6685343eec.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790766951; x=1791371751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkJtppbFtfQ6HQ2Su3HcBrK/vdVzSNtogQmowFE5Dpc=;
        b=S8FYN3lRddAGxq9FWSrGWJJOt77s9JDA9dnOYat7Af6JWFqgncs+s3utYM0ZvHNZLc
         i78qKWR35BI6O2c98qZ2j9IrpBPN+7PUnXZEDQ92/9gogwC2Hd1OC4Uk+pYSxrBzrFuF
         JsrINNgFc7hOyCCtABcatg6VcyEAkmhYk4AReUzDVCfeBCNsdMx294n6Pb7a1QynUOlc
         AXhXxq3fRulylVSl1v18GZcPzy8DseDKi7zFLNRx9IPfpklfE+iDfCCSn37eD3tLS2ee
         3NXo22/fCAqdfCR+cst+bdH4vKjf3AtPaeWhr7Mtj6YWfBKcVI3knoO/DfdgxzLTH7Xc
         DTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766951; x=1791371751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkJtppbFtfQ6HQ2Su3HcBrK/vdVzSNtogQmowFE5Dpc=;
        b=H/mNyOCa/KBYkgcRJDtp6texwAaJjvNxqlPhjn3H23F2ri2alruAlKQPeSpUK9zutS
         5SbLrnCkb5XhszloRbTA6wr6Rq1fenEFO/36fEqcKH/pDEnsyzQuYpsF+N96YIlW3mJf
         dwWGoEwF49gsfjmw4zTSPyMX6qJon5eJ5nPDOmPX08+fmOPm5YSprOwholjiCyoznqw/
         2Niw9fPoiTGSaOusIT8RNCdGpILrED3HtmcM+yt1E6inBxXKje1XHTxakyA2HFHFCe78
         ch6ci3AWtU3umGCmLBMb9RpTBEFoVpWMG9ttG3qXxCS61QksP6CKZtA5XO2ocWcltHoC
         rCGg==
X-Gm-Message-State: AFq9FYL5lwO2PA6wvV4MbVlXruFBV8pOv9H2frvwRjsbd4kS6B4Yb0HY
	QZXCfQREV4KK8EapuI7jzMwA1uCBTD7u9CJlP4HJ3LuKvcYjl4xZYgrbAtfpclrtqUEhHCVPauF
	DRivL8zpuGi4E76of6XCFT6XLmi6G7MJTgK8UblZezCtJXKySu+o9LPAOINP7ol0KguWDA3u4
X-Gm-Gg: AYBFou2wwPfyvuRzcyo1ed4Uz48r8YSryPBZ67FEe0P/Qa7w9qMJ3XyYRp/jftJJLAb
	KrLBHOBzBaKaUkwii3Z56UoGUgO3SSa5kqc2kr1v7bhOfN+i+dTbtSYc6YYkRgffSyp1mcRFVvG
	lJPDMGGXezKhEGlvDWdTmFdbIMBoLlaYH50h0ObohvQ/eBNlQFo1UC7sUv50TgndCyINDffuqNB
	oZwLGFEGIwMfeU+8tNB1LB/mT+axfAai3UPgSqV3Edn/qRUbJAEByAVgomn3IjJivZGdF63cy9w
	1Au2voObSQfZmG1aBVOgnhaNjpuyIMFJ8093EMOJqMmRmB916yyNG7Ui9drrSZemTpUy9BxM4fa
	PLNHOCO88srverHG/HomXnqpRTsXQTEo9cGldJezf0K/Kdyf5l3vjGXhgRw8ARgOXLc4VTYPsah
	8/7CUqJqPjcUZXz5DestWBpZeci41YA1bZtu3Bycw16TIick16LnKvTvtr7iXYHPwJDloGKQrVs
	ks3Dh3EyyU=
X-Received: by 2002:a05:7301:719e:b0:341:3b78:9e04 with SMTP id 5a478bee46e88-34ce0a2e932mr1394241eec.29.1790766950858;
        Wed, 30 Sep 2026 04:15:50 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5a2c6f9sm3520320eec.21.2026.09.30.04.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:15:50 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v4 2/5] net: core: factor out the GSO device limit check
Date: Wed, 30 Sep 2026 19:15:23 +0800
Message-ID: <20260930111526.2183107-3-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930111526.2183107-1-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gso_features_check() decides whether an egress device can offload a GSO
skb as a single TSO frame by comparing the segment count and the frame
length against the device limits.  The resegmentation path added by a
later patch caps the MSS segments per output skb and needs the same
features computed without those limits, so put the two tests in a helper
and gate them with one flag.

__netif_skb_features() takes that flag and takes the place of
netif_skb_features(), which becomes an inline wrapper in netdevice.h and
passes the flag set.  Existing callers keep their call, and the
resegmentation path asks for the features without the limit checks.

No functional changes.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4:
- keep the two limit tests as separate returns
- move the wrapper into netdevice.h, export __netif_skb_features()
v3: https://lore.kernel.org/20260928044102.1004310-3-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-2-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-2-wang.zhan@smartx.com/
---
 include/linux/netdevice.h |  9 ++++++++-
 net/core/dev.c            | 30 ++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 421c0f5952463e..5b7b0c87e4f637 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5495,7 +5495,14 @@ void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  struct net_device *dev,
 					  netdev_features_t features);
-netdev_features_t netif_skb_features(struct sk_buff *skb);
+netdev_features_t __netif_skb_features(struct sk_buff *skb,
+				       bool check_gso_limits);
+
+static inline netdev_features_t netif_skb_features(struct sk_buff *skb)
+{
+	return __netif_skb_features(skb, true);
+}
+
 void skb_warn_bad_offload(const struct sk_buff *skb);
 
 static inline bool net_gso_ok(netdev_features_t features, int gso_type)
diff --git a/net/core/dev.c b/net/core/dev.c
index 8475d5da64fdf0..a6213c9ed5e721 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3878,16 +3878,24 @@ netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
 	       READ_ONCE(dev->gso_ipv4_max_size);
 }
 
+static bool
+gso_within_dev_limits(const struct sk_buff *skb, const struct net_device *dev)
+{
+	if (skb_shinfo(skb)->gso_segs > READ_ONCE(dev->gso_max_segs))
+		return false;
+
+	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
+		return false;
+
+	return true;
+}
+
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
-					    netdev_features_t features)
+					    netdev_features_t features,
+					    bool check_limits)
 {
-	u16 gso_segs = skb_shinfo(skb)->gso_segs;
-
-	if (gso_segs > READ_ONCE(dev->gso_max_segs))
-		return features & ~NETIF_F_GSO_MASK;
-
-	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
+	if (check_limits && !gso_within_dev_limits(skb, dev))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
@@ -3936,13 +3944,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	return features;
 }
 
-netdev_features_t netif_skb_features(struct sk_buff *skb)
+netdev_features_t
+__netif_skb_features(struct sk_buff *skb, bool check_gso_limits)
 {
 	struct net_device *dev = skb->dev;
 	netdev_features_t features = dev->features;
 
 	if (skb_is_gso(skb))
-		features = gso_features_check(skb, dev, features);
+		features = gso_features_check(skb, dev, features,
+					      check_gso_limits);
 
 	/* If encapsulation offload request, verify we are testing
 	 * hardware encapsulation features instead of standard
@@ -3965,7 +3975,7 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
 
 	return harmonize_features(skb, features);
 }
-EXPORT_SYMBOL(netif_skb_features);
+EXPORT_SYMBOL(__netif_skb_features);
 
 static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    struct netdev_queue *txq, bool more)
-- 
2.47.3

