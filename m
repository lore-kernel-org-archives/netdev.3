Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11D3264C4
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570493; cv=none; b=Vvs+2uTcFCuQ9qxMSfHAdHaZ0hRplWG6tc2BdYqk73iXHWuAeHqlyCIEacl3lpIbwnoyw5qfMvag9qEyZeQNHwwPvd0XgiusetO07I/JdoOd7f9VPyhSjA0JXTVIpVIjVFoIyV3iIs4G0ZADY3WSnUMLTs2kS5mb9e0U0kai0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570493; c=relaxed/simple;
	bh=tq8dtLJDW3EIdk4Olej6y9mhvp+E0bAk3Bg/ZRFJAE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaHVJ02T/6bMRIxbnPFzS5wp3YRz1X17lx/1RXk0r6JatwF+lP/faJJXH1AqHsV2xVaZGmxsPijFbp4lWmvNTrHuiVcxxk40i5reKV5WAwXIpQqDvnB4NK2sGRMhe9MoDX17RJP8vkJpL/5y48b9+2Db6G8zP0Dsh93P43D3HKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=Khvqc1s1; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="Khvqc1s1"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-343479e6005so706828eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790570490; x=1791175290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i24as3+9O/mVgmrzzSr0e9LRF+V9kYzdHum8nONf5co=;
        b=Khvqc1s1DBsv7J3ma0+KdnXsvzpTt8uveY7Ir8Cb4uKjyFOcOV7MQstZ0Uvc2krnFK
         8raHOmEKMyaioSOhx/tDq2fwjWqiOs4qoGzX3xPAPV6AAsUGGnppPod5nBstUp0JPyrl
         Rz/T5cdyekY+7wJer7u+1lyeK44/NMOCEbDYOl78eD5JaUVZThOxvnzog8gIZ/cy5GRq
         qrQLa/fQ/jlBsPdCrM/9x3KmKiSOs4O6RgA+af/9BxbIhyiMBUvvzaviOO24p6eXRcBs
         wGnMbZknWw0lHjsWKMxzchXyoKIT28zalQldIuoau48AfuQkVDGizPv5USI6QWRKCeU/
         FqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570490; x=1791175290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i24as3+9O/mVgmrzzSr0e9LRF+V9kYzdHum8nONf5co=;
        b=0dap5n9o+Qh/QMZB4yxPR7QmgjBiCdZXKvAlNyvfvLpc5Ahpx8/W08Kb55TqsBOcUk
         YzMWioyy1fEVZtioEpfzxPgYyuOfQIPELxwAi72LuIqsjekPKaxvTNesD9cF7XWLi/iu
         Nj8HnCQ1QJnWg1OKJaQ/enhRj4OdH/0fnEUywHBdebmRwv6Ix9X09MvEQLtvV5Od+epc
         yvws/1ysltc73L6irjx90hv00Syxt1sUoANS072zcflINbnzRqu3JLlrJ8vBH9uocvkg
         xZPLwCMGo3EFkobPqfUsoRKKQ3XW3XBTkrj+mm9pBL4uTk2A1hXuirqIdxj1+S8KJDtq
         pyRA==
X-Gm-Message-State: AFq9FYJvnYXnEDZDJEJQGMflwAZP1Oemv5nWnHafERhv3UXKxhAgJfR8
	KdoM7Tj/wQKBrau66gSx3ZfjLXc1fJbutZOn8jUcBO+XDMKGfrOsCCm3vKMrthX9dwcRUgeVaz4
	scebJjpQIoJZY6VEmu3PpRyoynRnjLpljjKmPXlezaU8ayzkZfg56SHH3SzTLGFfhwefNOSOYna
	Bp+Q==
X-Gm-Gg: AYBFou0vEoHho+beTJi2USMp7D2taV0EdoXwkqn4Fe8gvqLBXP/VnlJVrIxXrftSiKO
	R+apw3d4kSYxfyMY4ykISdxAp4bo04tWKSXi8v4tS/SeLlKB+z5mk8TIlRNYdUmtu/VKZyJpCiB
	K/6bp3piQoBk4lFoAKrRX0N7iToXkH3RryUegaTM8KPDzksA1hgsEQ4ING8p3UAAn6EXU084gkz
	RiQ1/gBSEYCmoi7yrJWohEQw9/S0vDIg2L/kyibFn4vD7HXpguARCsitirzsuHkxO6K1dL0S8zN
	MarJXxEEt5C44jEAky/gDTNFgVoEwySllFQ/QsoAzLOi49V8SxEH1oSCbgN/g6I5vXkNGDZy79o
	eojGouU3CQbJez5Kjpq9HAfiJltgsH2kYEIXD+Tcxlz73v7LeBfnwnbX4TVm/ZiwFd9vJrmhasd
	aXa7Qrjb8fZExSrLQac9ZCt+SjTrEwxFqM2D4ldSU8OsjIqfXyqGoun0gwny7Ogs1HgkvNspVKY
	kIS8DMkQ7Ch
X-Received: by 2002:a05:7301:5412:b0:333:75a5:10d8 with SMTP id 5a478bee46e88-34273e309ddmr8291686eec.27.1790570490010;
        Sun, 27 Sep 2026 21:41:30 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22772905eec.28.2026.09.27.21.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:29 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/5] net: core: factor out the GSO device limit check
Date: Mon, 28 Sep 2026 12:40:59 +0800
Message-ID: <20260928044102.1004310-3-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928044102.1004310-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
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

No functional changes.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v3:
- rename the helper to gso_within_dev_limits
- move the check_gso_limits flag and the wrapper split here from patch 4
v2: https://lore.kernel.org/20260918084651.3022878-2-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-2-wang.zhan@smartx.com/
---
 net/core/dev.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ffa9b0c27788c..d66b667071837 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3834,17 +3834,19 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
 			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
 }
 
+static bool
+gso_within_dev_limits(const struct sk_buff *skb, const struct net_device *dev)
+{
+	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
+	       skb->len < netif_get_gso_max_size(dev, vlan_get_protocol(skb));
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
-	if (unlikely(skb->len >=
-		     netif_get_gso_max_size(dev, vlan_get_protocol(skb))))
+	if (check_limits && !gso_within_dev_limits(skb, dev))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
@@ -3893,13 +3895,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	return features;
 }
 
-netdev_features_t netif_skb_features(struct sk_buff *skb)
+static netdev_features_t
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
@@ -3922,6 +3926,11 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
 
 	return harmonize_features(skb, features);
 }
+
+netdev_features_t netif_skb_features(struct sk_buff *skb)
+{
+	return __netif_skb_features(skb, true);
+}
 EXPORT_SYMBOL(netif_skb_features);
 
 static int xmit_one(struct sk_buff *skb, struct net_device *dev,
-- 
2.47.3

