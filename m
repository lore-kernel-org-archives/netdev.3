Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D923DA7E6
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673654; cv=none; b=Cf310a8bUp8hqxvOX7COX14s4P8WyH+S/uth3n24UXxIhPRHOOAaIv9+KXMnHdXbCh8ZqvsUsH3Pd8E67uHMF8r1u/yv8sqXlGOtIlt0ASAWcBH52FAW/A6lKEIGOWcIPfKF+pGX1iPKK1/J0pcP5Fj2S72PbuTS+NdwOE9bk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673654; c=relaxed/simple;
	bh=LXTIMcSfH5vTVUzlKTulAXUDtY+yzROXY7e2Zi5XcMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KCRmSFH8G6kBfJEmyshXxNbFAFUi6KRLMEQSJUTIy0iBvZeyDrwkHJYm518Ua2m1mp8pxnicue7/lmrRuMPftAcoRxNNXvsnizyi3ftAVWJ2yJWFJBXGBkM9zSMdcJ4ount+gctXqMKuBogc9WhsxbMgji7KDVATA9vRykCkJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgfP8gTI; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgfP8gTI"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848568a6f62so545676b3a.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673652; x=1787278452; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZcbgeGSInQHo4bfOFeXby0+i+iSONKuxDUIqpuvMFaM=;
        b=GgfP8gTIzH1TnqArRggwMBvp8yF8uksZZv5ZN17Smx6801Z82q89eedpFBS4AYcLV+
         sDnb4PAa+CUKx2MT4JYBNyIgV5MRIIkWlRFYij3eRrOlKN4NFLvD9u7cemqdBTEX7lR8
         TasdVtO+TuISKuQlTenPeLk8CE0O8+LfV2U2BQnsbzsxlDhfjidDRqrr74cnbMmTNb0r
         fbkK4WJYR/LzomVTkRZ/8kO2X9hG2Zbe/DhWp+lVwAtoNQ6IwAaEVnKaoLu05BOwknni
         MdxJGVp0os6IY8e2RSiuOH167ZEiOVmZahrqmv3juf1aiW59WnyEeOYhTkU/SgBQYkKy
         Pvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673652; x=1787278452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZcbgeGSInQHo4bfOFeXby0+i+iSONKuxDUIqpuvMFaM=;
        b=KyFBG2QszTPb3qbkQbDuSJwku6OS+KCToeRMnF9ygab17ub4h1bM1ExUWpvFxcCxNf
         PKA0APomnnAWvH610cbOU29wxUrQhXotDvhP/k00LAPskaAjsRWOI3nThpNsz3TJdp+X
         swgb6JmhILkHMbqZVHs8RoTg9ucKpyzxn8/ZEL1d50bqaw8M4zj+dwE6IPY9DMFnqNj7
         dXX2yDVUn87owyL5bOBuZGAK5mys4962lanvcfJb0P5gy50pirc0rPYR6NLxY1tiVy+E
         lc1UD6ZAEOFjc2Cgu1BKR+T8+ok5ZISd17x+uvRXHwe3odnwsigZCyYjkc4C3o4BJDED
         R/qw==
X-Gm-Message-State: AOJu0Yz5js3kUfzxyuFYpA2eCh3wEVWYe6XqBd0q+o2purURPKr/NO1y
	XjaBLV1YDsR/mySMzmiTQyFXzwDs2SGUOGqRlw508X/LYFZ+H5Z54kofqDhb9Owt79smigxYV7t
	bw2nq8COoAY4pIPoE75+R/p/C+pd01RcJSxqJHxnwvqnr6e6Xm72SI1GKePmIsIUsokgnNNauPy
	X9lehVHqpdGie4FmTPEEaIC/T6G+Yo9raz6LtthXjOS7fGOIej/RkVJ1KJK/cf+ME=
X-Received: from pgbcr10.prod.google.com ([2002:a05:6a02:410a:b0:cbe:dbaf:256e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c8e:b0:847:8b0f:2508 with SMTP id d2e1a72fcca58-84fddfc20damr2690028b3a.13.1786673651659;
 Thu, 13 Aug 2026 19:14:11 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:53 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-4-hramamurthy@google.com>
Subject: [PATCH net-next v4 03/15] gve: add a few helper functions to set
 device properties
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com, debarghyak@google.com, 
	kees@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the mailbox ABI, device properties will come from a different
source compared to the AdminQ mode. To accommodate the new source
when the mailbox ABI is added, add a few helper functions to set a
few device properties. Those functions are:

- gve_set_queue_properties() to set no. of pages for QPL mode and
  number of queues in general
- gve_set_mtu()
- gve_set_mac()

This is just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4: move mac to a variable to reduce diff for next patch

 drivers/net/ethernet/google/gve/gve_adminq.c | 38 +++------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  7 ++-
 drivers/net/ethernet/google/gve/gve_main.c   | 49 ++++++++++++++++++++
 3 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 7e242a0c8edc..8156c6f8c3b0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -920,19 +920,6 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	return err;
 }
 
-static void gve_set_default_desc_cnt(struct gve_priv *priv,
-			const struct gve_device_descriptor *descriptor)
-{
-	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-
-	/* set default ranges */
-	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
-	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
-	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
-}
-
 static void gve_set_default_rss_sizes(struct gve_priv *priv)
 {
 	if (!gve_is_gqi(priv)) {
@@ -1049,8 +1036,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	union gve_adminq_command cmd;
 	dma_addr_t descriptor_bus;
 	int err = 0;
-	u8 *mac;
-	u16 mtu;
 
 	memset(&cmd, 0, sizeof(cmd));
 	descriptor = dma_pool_alloc(priv->adminq_pool, GFP_KERNEL,
@@ -1112,26 +1097,17 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 			 "Driver is running with GQI QPL queue format.\n");
 	}
 
-	/* set default descriptor counts */
-	gve_set_default_desc_cnt(priv, descriptor);
-
 	gve_set_default_rss_sizes(priv);
 
-	priv->max_registered_pages =
-				be64_to_cpu(descriptor->max_registered_pages);
-	mtu = be16_to_cpu(descriptor->mtu);
-	if (mtu < ETH_MIN_MTU) {
-		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
-		err = -EINVAL;
+	err = gve_set_mtu(priv, descriptor);
+	if (err)
 		goto free_device_descriptor;
-	}
-	priv->dev->max_mtu = mtu;
+
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	eth_hw_addr_set(priv->dev, descriptor->mac);
-	mac = descriptor->mac;
-	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
-	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+
+	gve_set_mac(priv, descriptor);
+
+	gve_set_queue_properties(priv, descriptor);
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 82b52424a63f..68c63ce75505 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -658,5 +658,10 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
 int gve_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_set_num_queues(struct gve_priv *priv);
-
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor);
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor);
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5ba534beb40f..dc6c2d08540f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,6 +2398,55 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
+static void gve_set_default_desc_cnt(struct gve_priv *priv,
+				     const struct gve_device_descriptor *descriptor)
+{
+	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
+	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+
+	/* set default ranges */
+	priv->max_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->max_rx_desc_cnt = priv->rx_desc_cnt;
+	priv->min_tx_desc_cnt = priv->tx_desc_cnt;
+	priv->min_rx_desc_cnt = priv->rx_desc_cnt;
+}
+
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor)
+{
+	/* set default descriptor counts */
+	gve_set_default_desc_cnt(priv, descriptor);
+
+	priv->max_registered_pages = be64_to_cpu(descriptor->max_registered_pages);
+	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
+	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+}
+
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor)
+{
+	u16 mtu;
+
+	mtu = be16_to_cpu(descriptor->mtu);
+	if (mtu < ETH_MIN_MTU) {
+		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
+		return -EINVAL;
+	}
+	priv->dev->max_mtu = mtu;
+
+	return 0;
+}
+
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor)
+{
+	u8 *mac;
+
+	mac = descriptor->mac;
+	eth_hw_addr_set(priv->dev, mac);
+	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
+}
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int err;
-- 
2.55.0.691.gc56d675ccc-goog

