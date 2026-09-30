Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C773F54CB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795085; cv=none; b=omTMpmKObh6tCYojIx+7kpS4fAfzzuMp06VqBOws6+2OKIIgfkiyX9r2DQLFs1oQke5mn3BeGbe+0xNV0dnxoyf8ZcM8OJ8Y9camo5BNxpir2QDymXwFUttMQuE3g0Y846y3m5N7to+pkBYqHKStwNVz4J3yWWobjDCRr+829TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795085; c=relaxed/simple;
	bh=XF4N7zO15fNNNrUxSe7Ch8NDCk0QjDIwOzgVTK1Ij9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uWZhqFaqCsNCI4ViH8vH4BwKa5+8NTRpBVZmdkJgIqhmIcqWHAroiqI+cfIfPchu56HdZXOODt56NscXGwcLlhb4yfV45/z/ytelX5S/1cJq6Yi7Gf1THAKK/ugn3mbUbI8QNh7Gak0yhHuDqP3LwLYhMvtFzWqsRCvCBU0jxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jScNlHFI; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jScNlHFI"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so45591745ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795081; x=1791399881; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2EBtX8tIlbY5zpgCNeMZY1vFGIFJxjkS4hPXZc1tb0k=;
        b=jScNlHFIOaGZCqBE181YGT5O1VYwWHehDanyA7aqaCoUQPIISS0laqWeuuoY2T29B+
         XbRQLT52XxDJJKWki73E5aXuxW+eTQXkE7iudHDIr97fEkyuY68Z2dU0h2JZr/uKeG2e
         fOFE+P7SQvo7rZhqV9BkJoIF22mhyIOLzKB0vkpfweVKPZXudYlYRlmUS7mZPWo618WV
         mAtKJYmiuoURF7lO5ADjPsp6XrpaZUtAlQOV0iaAfVtYyv4VkK2ukcCgIgdtoyWSWhEa
         qDKLlPL+OJysXnCKbwf8QoBSdbJ1fq4IMrYbi9BkgqggMuiCW5elIzvWCJMlJrKgQ6GX
         sTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795081; x=1791399881;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EBtX8tIlbY5zpgCNeMZY1vFGIFJxjkS4hPXZc1tb0k=;
        b=va98t6xgub+DWNBm7P0m1RlFzOsoNH+HkN0u3Sp5K1HuqKK5Anv26ygwdkqojdzZVs
         gWauim158Ud4lX/lTm/XxI9MJ05GSBDAv9ooA3BdSVbl/NpIOIDcHSOwLjTxhV6v6sbU
         UoNn6pZZzuDEC8DyHTOoOAjQUe1sxpOMjWIJD34JoacG9fxwbmw2UGRUcqFcZm1EW/e7
         0FU9j/YidaiGWZJghDyO6xdGXuR/U1B22VdZs0rF3R8DvxumVXVN6Gj8mk4a8AGptW4n
         Wp7RFNgSOccL0UK1AKy9GNBtRUoMyjxdcE6naXenFstW22LzwERD4fZ48EPpqND2XxmJ
         QVIQ==
X-Gm-Message-State: AFq9FYIPqPWUhnxCDWfVvzIe2mAB7XxoNIOmmKYvSMJADA5c/pxT0MmN
	QBwT1CWruQ5aJZB9HRcR0ozhmJD4bM753WI6B+U6QH9gmZV9qYQppE0PPWwW49caJjaaiAbK1hl
	EwyjIyvxtfw0Fayc5wwvasWaabL4GIM9LmG7mBMO/AYMQsDL26w8eggcSexSAhGgwpM/O03TPv7
	0oA9YH4z7WJ/8djZL6763X9hiD8i3NpW0VBYlteOCjocOYSMBpFWZtF5TeHwSZSZU=
X-Received: from plbiw8.prod.google.com ([2002:a17:903:448:b0:2e2:f1dd:3f73])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:37c7:b0:2dd:5363:3219 with SMTP id d9443c01a7336-2e2e4a1e35bmr20926235ad.20.1790795080736;
 Wed, 30 Sep 2026 12:04:40 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:04:27 +0000
In-Reply-To: <20260930190428.1130007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930190428.1130007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930190428.1130007-12-hramamurthy@google.com>
Subject: [PATCH net-next v9 11/12] gve: add ctrl ops for queue operations
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"

Add the next few control ops to

- create queues
- destroy queues

These changes are just moving existing code into ops, no functional
change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v6:
- drop unintentional change of gve_priv from const to non-const

v5:
- remove double logging during queue creation/destruction on err also (Sashiko)

 drivers/net/ethernet/google/gve/gve.h        |  4 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 50 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 43 +++--------------
 4 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 016e85ed91a5..00966b6a730f 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -843,6 +843,8 @@ struct gve_device_info {
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
  * @reset_flow_rules: Flush all flow rules from device
+ * @create_queues: Sends commands to the device to create TX/RX queues.
+ * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -861,6 +863,8 @@ struct gve_ctrl_ops {
 				  dma_addr_t stats_report_addr,
 				  u64 interval_ms); /* AQ-specific */
 	int (*reset_flow_rules)(struct gve_priv *priv);
+	int (*create_queues)(struct gve_priv *priv);
+	int (*destroy_queues)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 05b011417bf3..54f235ea27c1 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -943,6 +943,30 @@ static void gve_set_default_rss_sizes(struct gve_priv *priv)
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
@@ -1787,3 +1811,29 @@ void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
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
index 0b48e9f2a82a..d696e4932a8b 100644
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
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 63377bf2a0f8..8d628c419972 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -944,33 +944,16 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 
 static int gve_create_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 	int i;
 
-	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
+	err = priv->ctrl_ops->create_queues(priv);
 	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
-			  num_tx_queues);
 		/* This failure will trigger a reset - no need to clean
 		 * up
 		 */
 		return err;
 	}
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
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d rx queues\n",
-		  priv->rx_cfg.num_queues);
 
 	if (gve_is_gqi(priv)) {
 		/* Rx data ring has been prefilled with packet buffers at queue
@@ -1114,26 +1097,12 @@ static int gve_queues_mem_alloc(struct gve_priv *priv,
 
 static int gve_destroy_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy tx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
-	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy rx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
-	return 0;
+	err = priv->ctrl_ops->destroy_queues(priv);
+
+	/* A failure will trigger a reset - no need to clean up */
+	return err;
 }
 
 int gve_alloc_page(struct gve_priv *priv, struct device *dev,
@@ -2496,6 +2465,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.release_db_resources	= gve_adminq_release_db_resources,
 	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
+	.create_queues		= gve_adminq_create_queues,
+	.destroy_queues		= gve_adminq_destroy_queues,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

