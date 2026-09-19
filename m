Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E690547058
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850888; cv=none; b=gz8zKYum3xuxCZh4tQQd3sevMsqEf0sDMXWi8nj47JmN5O7r7JRxnJUZwIrlm3EO2shPI248Z2/ANXFUb3XR+KT1WJG19+ZF/lAhbra4uc3PqwYYvd/w/l4HAu5D/h8K1HsM2nxPAy5vowBAytf3vHyy848uKpvzHfx4OHANGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850888; c=relaxed/simple;
	bh=PXzOW8D/JPC4glKuSHEeGq8SfS8CyVzZS0VKZ//P1OI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIn2CZ41LFrfy93KpZX1Z2bI5ftTjE91X9+77zYePbx9pXU/NkCDdclyHgJRed40BWi4uHogEXbSwE5sUhgY/zb2d5sdLUPltD5Rc+Ynd/uhlN4pSDp9a3jmsPeHSTB1+EKNUQJ7cOSXo/kzr5GOYlwak45vJH+wGKw+Xil10x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/jACuv4; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/jACuv4"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85a4329731cso1432875b3a.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850886; x=1790455686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbzMWY27RNn6TvNZ0mX5/THo8gbiTxzyAVe/fdV+7Y0=;
        b=L/jACuv46l2hKmNpEQd8ITYau2awShtYptfgPFBau5HyuF7pcmnFEuYoZXYSTSnVKz
         2Zt4Ii1nmPyuyWTlbbJ8Ub0ohRqkH41qudBZgnlCl3xmj/a4WzTWRZrJDopNmnm5d3kx
         6Ra71/mjV09f+xrJUSamNInLNZOHqfPXLl1MOLTEFZ18sOoCdxlWSJvIm5bhawGEGy4g
         IAgCtb7PnpwnFDTj0RnjXh1lObWdE2TUeLaFkrEj+Q35wglFBQNFzb+2MruIw+/AKtqJ
         POQ2aHDrzDu8b8wPYaXIMF5KGHO/hvKuNVFpkfLn1n19tZw8w0A/OvQaJxSXM3EFmgSJ
         BhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850886; x=1790455686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbzMWY27RNn6TvNZ0mX5/THo8gbiTxzyAVe/fdV+7Y0=;
        b=QyUve7gGs9x0LxFt0y7yBEFDjWw+XoYjQs4IjId2EfiPal0k0hfCpojfQZNB/vLQSb
         lS/+2GHaihcA5bjlkwKZem72qH/1ul6ArsYdvAxrOvR747cidIS/ATjuQAJ+89l4YFRq
         4p0BtqXK89DBAmgB2YEeVWa256KacJBIBF5dF5alu36QbBgvND/LSS5VxlkcYGCtWWY/
         SDhoGHdGpmBapsktVnmfl9Yia37AuSn4FgHenGYX08kx2olLAYiR35CBoMsZvkkWvTKF
         4Tc1UuSh3so9WcMd+Xe47FY0yMDUu9H4QMKqrjoIsEdXaWEkDZcL8gH51WOYH3GV59GQ
         Jw4g==
X-Forwarded-Encrypted: i=1; AKwUvBwgv10emuvmh/JifDCRZF4OYycSoLpvFCVc/p57y9kH3HYvcw6rtunwlYFNnuP1c+5+lfWIuSA=@vger.kernel.org
X-Gm-Message-State: AFuF++mwoPJGwl8tZkT4wBVegiWax8C7aCOHJk/qtGqQP2izHdjUSPcC
	38AcC1e2GImVg3/5ZEuTZMsrd/Q1CqdvuxLQ1GsrezkXW5YAzQIj0YzU
X-Gm-Gg: AYBFou1yH+aOiXJQmASoDUqOPCj0Gd1cyYOCNZRbnvyxwEU1v3P2/hR9ObTpc7m0eAP
	R6Pcmh5wHKNF+sTEr0GsozV2IlshkNQJArLKhx087CIA1tEWL4+FDgb5ZfYCKXUYooKpWk1MvwA
	za3VNuCyakikOkonJ1kF83lrSVD7+2bVpfE+5Ci0cEuGKDtqP0Jmi5aNzzoFAKCHAdkDH8K5xSJ
	iaHd2P8RE0zGVBAkBmK5MzfczuFl1S3y1fnyTgvtbX0wWL++buTcNZk5JB1G7Ir0o9BB4ThMA3G
	Wo+fgwwb9/HjjAfNE1t6yr5OiqXRke3fdyEh1KBxNRkqSp0WnGuNfzhr4B+KGOTrKdhdjdwabkS
	LeBNRh5MuIshsEU6/jQK6E3eKYya5i+PfLXFMtiotDJmK5g3Nhn/F4O60lb6zwQaJ3GlhIFN17t
	y2oec79G6ogS++2uCWBhMzPXjWBLaWbq8jZYhoo9UWlL2RxIZBTncSBe4HBWRnHjBoFfvOSVkmm
	ywEZRxNWLElK87KU41CfuN/E7yj5bMhxAlguYbiRz/cieaw0Oe/VoMGI0L2pehgkcIs0Wa6jyIr
	a40X8xNo7w==
X-Received: by 2002:a05:6a00:2ea8:b0:878:3658:23dc with SMTP id d2e1a72fcca58-87836678cfcmr2747328b3a.53.1789850886311;
        Sat, 19 Sep 2026 13:48:06 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95f915csm1282928b3a.29.2026.09.19.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:48:05 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ethtool: tsinfo: release net_device reference in ethnl_tsinfo_start()
Date: Sat, 19 Sep 2026 20:48:03 +0000
Message-ID: <20260919204803.2811673-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike ethnl_default_start(), ethnl_tsinfo_start() keeps the net_device
reference acquired by ethnl_parse_header_dev_get() in
ctx->req_info->base.dev until ethnl_tsinfo_done().

When a Netlink dump (NLM_F_DUMP) of ETHTOOL_MSG_TSINFO_GET specifying a
device header fails on its initial netlink_dump() invocation (for
example, with -ENOBUFS when sk_rmem_alloc >= sk_rcvbuf), Netlink keeps
cb->cb_running = true without calling cb->done(). As long as the Netlink
socket remains open, the netdev_hold() reference is held, causing
unregister_netdevice() to hang indefinitely when the device is removed.

Save dev->ifindex in ctx->pos_ifindex with ctx->single_dev = true and
immediately release req_info->base.dev via ethnl_parse_header_dev_put()
in ethnl_tsinfo_start(), looking up the device transiently by ifindex
inside ethnl_tsinfo_dumpit().

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -295,6 +295,7 @@ struct ethnl_tsinfo_dump_ctx {
 	struct tsinfo_reply_data	*reply_data;
 	unsigned long			pos_ifindex;
 	bool				netdev_dump_done;
+	bool				single_dev;
 	unsigned long			pos_phyindex;
 	enum hwtstamp_provider_qualifier pos_phcqualifier;
 };
@@ -476,12 +477,15 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *net = sock_net(skb->sk);
 	int ret = 0;
 
-	if (ctx->req_info->base.dev) {
-		struct net_device *dev = ctx->req_info->base.dev;
+	if (ctx->single_dev) {
+		struct net_device *dev = dev_get_by_index(net, ctx->pos_ifindex);
 
+		if (!dev)
+			return -ENODEV;
 		netdev_lock_ops_compat(dev);
 		ret = ethnl_tsinfo_dump_one_net_topo(skb, dev, cb);
 		netdev_unlock_ops_compat(dev);
+		dev_put(dev);
 		return ret;
 	}
 
@@ -533,6 +537,13 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 	ctx->req_info = req_info;
 	ctx->reply_data = reply_data;
 	ctx->pos_ifindex = 0;
+	ctx->single_dev = false;
+	if (req_info->base.dev) {
+		ctx->pos_ifindex = req_info->base.dev->ifindex;
+		ctx->single_dev = true;
+		ethnl_parse_header_dev_put(&req_info->base);
+		req_info->base.dev = NULL;
+	}
 	ctx->pos_phyindex = 0;
 	ctx->netdev_dump_done = false;
 	ctx->pos_phcqualifier = HWTSTAMP_PROVIDER_QUALIFIER_PRECISE;
-- 
2.43.0
