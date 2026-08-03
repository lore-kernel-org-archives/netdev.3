Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68C439F9D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782810; cv=none; b=cu9CHiUWPVjaBrluuz686t13b9NBMwi8ouMURUoCQvFBxyzMI9r7DijYASSnz9msXCAgARUw6n8abvJrLoo5GmWePiauflj1tHciEqDJeWdoqv86mBi1Pyz0G6H4tzPy1ofAF1Z+nP+s8YMEZhy+rfrw53c8kXssfDQ4cSANxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782810; c=relaxed/simple;
	bh=t6HBq+w6rky5CjIGVie+Ul/ENCeEYFN/jda0PTWlOuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s93Kd7vNmQeg+wOYFkP4bsxeQ7Lyu7H5nwHe1mtXunV5RzImpJbVgbUTNmiIuWFCduN9dubWaumnImEZqtx2wqO56tRvyOtL1+nwbxMDGi0bMu57/44//IKNwgBdg/y+5Vs4znI7dDugVoARDM+IfKjbCURh6xtR+j+WkDO7d1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECfEZKrW; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECfEZKrW"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso4210288b3a.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782805; x=1786387605; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1tOCOGQChFEvfXheFlEBUxLZ6TJFnKo2WVfob4bak4=;
        b=ECfEZKrWiYCHAT3fir0MNBNQTLdsDvMbsZmvPwlzTptHMT9Qtq3gKJ8sZIKC3f3Ofk
         TG4ijSsPpxf7qphmqblOWiuWT6fqL65ZZcQkKaRBUFjl04OwRX6Qi1oYEg9l+SIxrzJX
         AxUplpCugRsOLJJwhofo/zo9SU18v2fNfJdRVnfIaeey3NWqPN5hxf6mTETBfRVbl8xM
         TAoH850m1BV7xl9vtfPR3H+iehCqKWbmEpWC8jVuCRxo4tCjWqhhEtvL2Tiq22qQuZa+
         uy9KYZP4zCgoTO9NgbH5mdyXiTPutaTnc/wYlb2aaytxkH8p1CTxSL2lOtbU0PE3flya
         SKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782805; x=1786387605;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R1tOCOGQChFEvfXheFlEBUxLZ6TJFnKo2WVfob4bak4=;
        b=MKbT5xRtvAlCPvB40cdXBLPAC8/a5edAu7iMlKZECmmsIkmeZ/21cvo+I9gcvfE3k4
         ofdcVV8lUmvK4a7t+YcsdxKXpf434XqFtzECZAHEVVJdOuRMAsL2GeBF28UdSoz28gki
         WDpaNCNP41Onahpkvw1EgloPFht+vreX4IsOgvFQEeAEucNvGa0x33Q7AA/BkGs/3JGG
         THNyb0S/WVGYtkdYiuyeYu4JugzaroFSzjV5pCGXbQb01cFU2TH8n1ANPHC8aE3ZzwDt
         tbZdpvcMj04paHXgxvtGxZ+cDqpxbyuQblLTIH7hkEThSCBfF6r0cWMGNDflk5+XdUTK
         6cQg==
X-Gm-Message-State: AOJu0YxCtp4F5dDH6q3fbjUTyeZ0cRoSsnNmDrok/NDkCnZpMKqALkpQ
	YeuLgT/XBWB/7OXE8jTSRzxeAenOhkzabVRbGqaVHANiGcmGoTZjYeUmMTGWyLRGKCjOuhxU7va
	KZzoKQNdhTQmQtQVTNJK4Gc0Pvjs6mzNwi7JSzaq5/a61EunUeeFEKXgex9CB/COWJ6uoabiK/J
	r6J5EHtQz5nHyNfNMJSTQFIp0Bi+F0vQEpsuziy+6dRaj50+tGC8kZ8jTYDt49w00=
X-Received: from pfgs25.prod.google.com ([2002:a05:6a00:1799:b0:848:4460:aed3])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b45:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84ee48eac4fmr10278505b3a.35.1785782804441;
 Mon, 03 Aug 2026 11:46:44 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:29 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-15-hramamurthy@google.com>
Subject: [PATCH net-next v3 14/15] gve: add ctrl ops to for queue operations
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

Add the next few control ops to

- create queues
- destroy queues

These changes are just moving existing code into ops, no functional
change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v3:
- remove double logging in the create queues path

 drivers/net/ethernet/google/gve/gve.h        |  4 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +-
 drivers/net/ethernet/google/gve/gve_dqo.h    |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c   | 48 +++++--------------
 5 files changed, 68 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 352755660138..38b93238e2ca 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -844,6 +844,8 @@ struct gve_device_info {
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
  * @reset_flow_rules: Flush all flow rules from device
+ * @create_queues: Sends commands to the device to create TX/RX queues.
+ * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -862,6 +864,8 @@ struct gve_ctrl_ops {
 				  dma_addr_t stats_report_addr,
 				  u64 interval_ms); /* AQ-specific */
 	int (*reset_flow_rules)(struct gve_priv *priv);
+	int (*create_queues)(struct gve_priv *priv);
+	int (*destroy_queues)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 4299a3931789..b04968257355 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -941,6 +941,30 @@ static void gve_set_default_rss_sizes(struct gve_priv *priv)
 	}
 }
 
+int gve_adminq_destroy_queues(struct gve_priv *priv)
+{
+	int num_tx_queues = gve_num_tx_queues(priv);
+	int err;
+
+	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "failed to destroy tx queues\n");
+		/* This failure will trigger a reset - no need to clean up */
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
+	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev,
+			  "failed to destroy rx queues\n");
+		/* This failure will trigger a reset - no need to clean up */
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
+	return err;
+}
+
 static void gve_enable_supported_features(struct gve_priv *priv,
 					  u32 supported_features_mask,
 					  const struct gve_device_option_jumbo_frames
@@ -1784,3 +1808,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
 		priv->mgmt_irq_requested = false;
 	}
 }
+
+int gve_adminq_create_queues(struct gve_priv *priv)
+{
+	int num_tx_queues = gve_num_tx_queues(priv);
+	int err;
+
+	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
+			  num_tx_queues);
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
+		  num_tx_queues);
+
+	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "failed to create %d rx queues\n",
+			  priv->rx_cfg.num_queues);
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
+		  priv->rx_cfg.num_queues);
+
+	return err;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index ff656fb4f113..03e8318f7327 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -628,6 +628,8 @@ int gve_adminq_configure_device_resources(struct gve_priv *priv,
 					  dma_addr_t db_array_bus_addr,
 					  u32 num_ntfy_blks);
 int gve_adminq_deconfigure_device_resources(struct gve_priv *priv);
+int gve_adminq_create_queues(struct gve_priv *priv);
+int gve_adminq_destroy_queues(struct gve_priv *priv);
 int gve_adminq_create_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_destroy_tx_queues(struct gve_priv *priv, u32 start_id, u32 num_queues);
 int gve_adminq_create_single_rx_queue(struct gve_priv *priv, u32 queue_index);
@@ -661,5 +663,4 @@ int gve_adminq_request_db_info(struct gve_priv *priv);
 void gve_adminq_free_db_resources(struct gve_priv *priv);
 int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
 void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
-
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index 5871f773f0c7..ce402020dff6 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -66,7 +66,7 @@ void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);
 void gve_xdp_tx_flush_dqo(struct gve_priv *priv, u32 xdp_qid);
 
 static inline void
-gve_tx_put_doorbell_dqo(const struct gve_priv *priv,
+gve_tx_put_doorbell_dqo(struct gve_priv *priv,
 			const struct gve_queue_resources *q_resources, u32 val)
 {
 	u64 index;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index f2dd82f6c254..484f5a54a408 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -871,33 +871,15 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 
 static int gve_create_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 	int i;
 
-	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
-			  num_tx_queues);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
-		  num_tx_queues);
-
-	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d rx queues\n",
-			  priv->rx_cfg.num_queues);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
+	err = priv->ctrl_ops->create_queues(priv);
+	/* This failure will trigger a reset - no need to clean
+	 * up
+	 */
+	if (err)
 		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
-		  priv->rx_cfg.num_queues);
 
 	if (gve_is_gqi(priv)) {
 		/* Rx data ring has been prefilled with packet buffers at queue
@@ -1052,26 +1034,16 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 
 static int gve_destroy_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
+	err = priv->ctrl_ops->destroy_queues(priv);
+
 	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy tx queues\n");
 		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
-	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
 		netif_err(priv, drv, priv->dev,
-			  "failed to destroy rx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
+			  "failed to destroy queues\n");
 	}
-	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
-	return 0;
+	return err;
 }
 
 static void gve_queues_mem_free(struct gve_priv *priv,
@@ -2482,6 +2454,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.free_db_resources	= gve_adminq_free_db_resources,
 	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
+	.create_queues		= gve_adminq_create_queues,
+	.destroy_queues		= gve_adminq_destroy_queues,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.571.g244d577d93-goog

