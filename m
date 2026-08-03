Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8544334BB
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782799; cv=none; b=qRhjBVusuk9vkq+QmsBiopGtr+gCwDZ/51OiQ9Blcrr1rodp19YJmVE5KFYwGp2y9PnxP8X9r0FxhMHS5ME7sRrtMhN8h/D1k0VPfCt9vd6G1+xQP+avMiJ2fk6T+0Aicw5kFFr7UgdTKNdNB81X79r6RMzSdIwHB8X5uukvQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782799; c=relaxed/simple;
	bh=etI8e+sT66DzWo4LOICOABXbHGS3zV7c/BFbpZf84ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ApYMr4nQuyx4s+/XVLJQjj2SJXjxRjJtL57xFWHfXy2FH1761755oM+tXCXhLnq1gUowhT+wh0JC4avWn9HfxT3Uc1ZV7B8hAZ7+p2KIBAjDcLpVaWseH/0ghv2JE2gP0ayrEGO0KAgLzUyETmlrzQqNzgWS2UAD7+9lwxAYcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tkj3FfkI; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tkj3FfkI"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848568a6f62so7403347b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782795; x=1786387595; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g0vu+fy30PN67mmeEypCW5wKZeCfMTP0waJvT1m5hRU=;
        b=Tkj3FfkIZEVxQnjfJULeECd6NfiNRbLoGCcgfn2H6a19mrRwUKa/CRoNMLwae2y+b9
         ouEPtczcDkCoZNg0ryWvRTzdnWrhfnlN13WIaSvBbPmO/IVC78YlImK/G74nOw1rGHOU
         cFId7mYPv2DboQr3niZZTeRQ1SC8gg5U9rfNod9ljzrMxj28i9hjRhC18NG+p4/6ZIgL
         rbdNitg5qI4D/70B7xCBWUhczQh5ODLROWbPIs2PRO0w9uaZz66rjuymzQj4k6BW7j/1
         o4spi7Kq5vjVjpsQ3g8BwLke81RDKyMUn0IYvsmEZELcrWOAXJyX7kZnIm1vN7bZTa34
         THVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782795; x=1786387595;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0vu+fy30PN67mmeEypCW5wKZeCfMTP0waJvT1m5hRU=;
        b=E4W0VLZsLDSQ41JgpxCeD+KxNLyMF989ZHw88gpwoPNGUry2LVOCs+p5lor6rMutOe
         cVlZ3Vo6K6Ac4X9rhjk1tlTSh4w2ASzPuuJGwSlhPtVUDyQ8GoMiZBKLxL0wyJYm1GP/
         3H2UNJpz/oxXiwHYyyakzJqX3qij+y7GnhobUfzDITFTgA0W6nO6cJlesPbfon/J7ngn
         +tGD49WBoGrtp6Hcd/0Edu91073yE1mDYYvgxOETO46BIhytOD3krIMkDYwA7DQJ/fmh
         SXqOywB99XhR1gTxrASWc1Jo3MJYJO2eid34KkmDf9U/pK4gK4Y7qZP7DouqpbYUXEi5
         gY+A==
X-Gm-Message-State: AOJu0YzZCyCrfcR1GvDxlRZK6o9uyCLmQ3zcHgJ0Lg2moGLAl3722vyb
	HZCSUAB05CJW1fKK0uIxui3fhCYW8veQTDfE19pcv2TxyfGrXhvUyXpg9vMSsJ16QXmMesmUTRz
	8f0DXDZbwU/HbtKY6ZB1k8Hk0qCh921B6muk00z7ScK8an8lakrK06ZKqEbJrgiuJ/L18IbRE9/
	WYPHdimIOhHVb0sh4VvfhZ/0RK/j7tJ95m5cXNZRRJkBvgFCKG6IX6gRMM9rwVjeQ=
X-Received: from pfle9.prod.google.com ([2002:aa7:9209:0:b0:847:b0e2:92a3])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:189d:b0:84c:4d9a:ae42 with SMTP id d2e1a72fcca58-84ee47d7283mr10045977b3a.27.1785782795100;
 Mon, 03 Aug 2026 11:46:35 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:18 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-4-hramamurthy@google.com>
Subject: [PATCH net-next v3 03/15] gve: add a few helper functions to set
 device properties
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
 drivers/net/ethernet/google/gve/gve_adminq.c | 38 +++-------------
 drivers/net/ethernet/google/gve/gve_adminq.h |  6 +++
 drivers/net/ethernet/google/gve/gve_main.c   | 46 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index dfeabddfb396..2ae15289e2c8 100644
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
index 8e80f36116ec..580332df28db 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -656,5 +656,11 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+void gve_set_queue_properties(struct gve_priv *priv,
+			      struct gve_device_descriptor *descriptor);
+int gve_set_mtu(struct gve_priv *priv,
+		struct gve_device_descriptor *descriptor);
+void gve_set_mac(struct gve_priv *priv,
+		 struct gve_device_descriptor *descriptor);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 6510aea62b92..e818ebc6ec27 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2444,6 +2444,52 @@ static void gve_set_num_queues(struct gve_priv *priv)
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 }
 
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
+	eth_hw_addr_set(priv->dev, descriptor->mac);
+	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
+}
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int err;
-- 
2.55.0.571.g244d577d93-goog

