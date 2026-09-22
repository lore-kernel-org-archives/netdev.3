Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F2569F1B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094907; cv=none; b=NKFoNMfBsYVq/iRfC72mNVJBlhzczHq6nxUJ1cFDO7eHDGHUFV/UdkAdGF3A5jeiAsxP166BMwSLI/KeTSrG/ELZhT7fuylAac7YKMpVziFWVYhwctJ7kVcSJQ1KKfK7FOt8R/Sa0MrVQxeCCbyahQdG7S+GM5tyZgnhws4m9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094907; c=relaxed/simple;
	bh=e57ZIbSSHnI2gQfGCRQ+G3G0Io4fsGo9mANwSC5Z5XY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uAjDtj+BFFM03ud3gK/pOzi121yQ8pelkoybycrmhl42EhIfTseRasqmxoOtjd1vGozIsim5uWCRIAbzAvuGI2XtActTXuhtZonf8E5iSw8Eo3FsJnvLOhb5YpDzopuSrnVWnQQhwbs8/jCcyz4g/PZPJv5frBV0hqRVrkWw0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4gqQbd/; arc=none smtp.client-ip=209.85.128.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4gqQbd/"
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-88e06764219so2941647b3.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790094904; x=1790699704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kN3h5N0Dq586B8hCad7PZWufvjBVHntZOGU3tDyuZOk=;
        b=Y4gqQbd/+ZROpueEx7P7qCsaWZBMbCCf8tV0fswYrvaJb1BWA+8xW2h1abjJXjqAM8
         aqJfNgDSaDuAaevulaiX1Y5WeHv7r39CvsmQdq0Rs/YxXcPCr1gvB5W6lX+8GvM22Fg6
         4jvnPueCISRMKJ5eV02hjMzaS/xDHe6URovRigNBBwhhPCkIbyXRMT1gF/nQ2VmMxX4c
         d167zse3XvyyUKMRiPzDjeKFPztg92F87IarJOogDBLmxsCjV66Vu2WdmYzwO4bxtpNR
         FUdCDhG5fXHxdEGx6L+AL1xMY8wYlGZDEE9GgWsOV8I19cfOSrdMtP45vnNwUM/ncjVP
         tp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094904; x=1790699704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kN3h5N0Dq586B8hCad7PZWufvjBVHntZOGU3tDyuZOk=;
        b=QqGVCJjVNosas4fKwm4QeM99BsMFjRzyaHOxvTJWrqdA8qf1Y8yMsz+E6v+v3v4Gg8
         BBI7hnNzl2YR7Kk/gNJXurFLOTuYaoQ+44By+oUSgkEuVB1mOjw1qu5rTa9JWepQYM73
         kyWbxXRe6Wst0q7wYIU55BY3nPqymcn+Z7V43KpZFNgKY2uBXHbT2vypSKLrijRPwvrR
         1pXH56wLMMtIhD2/0ybpR5X7vWZSEBIId7av4qo9NPuqUV0l0SqHgAsP6dzixqEfePvM
         fqfwNM4XAHsXF2IH6kvl22APgmUq2skTto44hghczk2W1n7dA8+kEPj7Vbw3oTaClU9w
         +12w==
X-Forwarded-Encrypted: i=1; AKwUvBwHB/PAezMUyAhwcwW6yQEvGJP19phB17Mqm+FW2N/V5rDRgTVogi71nSJgfsgdC6ey0pIzilc=@vger.kernel.org
X-Gm-Message-State: AFuF++nHfBa2UqjEH4xb0tl7oWYN5rjJL9gel+/HFkmSwWN+ib8/jPOP
	YsM5lYsAK5N4jfavTMuBZ3qm6U9rIbYzKCOOSuLgWITNZ/F8QBdf0/cNdHCjGCIQR2Eb0c5/N6q
	em/gHnQUjM36vvw==
X-Received: from ywad25.prod.google.com ([2002:a05:690c:a759:b0:79d:5f40:6504])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e143:20b0:853:d1fb:2121 with SMTP id 00721157ae682-8a457a82781mr428047b3.1.1790094903707;
 Tue, 22 Sep 2026 09:35:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:34:57 +0000
In-Reply-To: <20260922163458.3900996-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922163458.3900996-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922163458.3900996-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] netdevsim: support reporting RSS key,
 indirection table, and flow hash fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Initialize a per-device RSS key in nsim_ethtool_init() using
netdev_rss_key_fill() and wire up get_rxfh_key_size, get_rxfh_indir_size,
get_rxfh, and get_rxfh_fields on nsim_ethtool_ops.

This allows RSS selftests under tools/testing/selftests/drivers/net/ to
exercise both /proc/sys/net/core/netdev_rss_key and ethtool netlink RSS
reporting against netdevsim without requiring physical hardware.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/netdevsim/ethtool.c   | 53 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  3 ++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 025ea79879f3a93cb9a75c1a20464d81c4ca5cef..c3d2bc783d5571fd98547e8c5cb2fd9fb9b01351 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -205,7 +205,59 @@ static int nsim_get_ts_info(struct net_device *dev,
 	return 0;
 }
 
+static u32 nsim_get_rxfh_key_size(struct net_device *dev)
+{
+	return NETDEV_RSS_KEY_LEN;
+}
+
+static u32 nsim_get_rxfh_indir_size(struct net_device *dev)
+{
+	return NSIM_RSS_INDIR_SIZE;
+}
+
+static int nsim_get_rxfh(struct net_device *dev,
+			 struct ethtool_rxfh_param *rxfh)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+	u32 i;
+
+	rxfh->hfunc = ETH_RSS_HASH_TOP;
+	if (rxfh->indir) {
+		for (i = 0; i < NSIM_RSS_INDIR_SIZE; i++)
+			rxfh->indir[i] = ethtool_rxfh_indir_default(i, ns->ethtool.channels);
+	}
+	if (rxfh->key)
+		memcpy(rxfh->key, ns->ethtool.rss_key,
+		       sizeof(ns->ethtool.rss_key));
+
+	return 0;
+}
+
+static int nsim_get_rxfh_fields(struct net_device *dev,
+				struct ethtool_rxfh_fields *info)
+{
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+		info->data = RXH_IP_SRC | RXH_IP_DST |
+			     RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		return 0;
+	case IPV4_FLOW:
+	case IPV6_FLOW:
+		info->data = RXH_IP_SRC | RXH_IP_DST;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct ethtool_ops nsim_ethtool_ops = {
+	.get_rxfh_key_size		= nsim_get_rxfh_key_size,
+	.get_rxfh_indir_size		= nsim_get_rxfh_indir_size,
+	.get_rxfh			= nsim_get_rxfh,
+	.get_rxfh_fields		= nsim_get_rxfh_fields,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
@@ -250,6 +302,7 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	ns->ethtool.fec.active_fec = ETHTOOL_FEC_NONE;
 
 	ns->ethtool.channels = ns->nsim_bus_dev->num_queues;
+	netdev_rss_key_fill(ns->ethtool.rss_key, sizeof(ns->ethtool.rss_key));
 
 	ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
 	ns->ethtool_ddir = ethtool;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index eb9d684e3bccf677f080786c201587d81e875aa2..fd5599cd3bb9f1638ce80e34247b5e34b997b9cb 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -87,10 +87,13 @@ struct nsim_ethtool_pauseparam {
 	bool report_stats_tx;
 };
 
+#define NSIM_RSS_INDIR_SIZE		128
+
 struct nsim_ethtool {
 	u32 get_err;
 	u32 set_err;
 	u32 channels;
+	u8 rss_key[NETDEV_RSS_KEY_LEN];
 	struct nsim_ethtool_pauseparam pauseparam;
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
-- 
2.55.0.1082.g2b9226bbc0-goog

