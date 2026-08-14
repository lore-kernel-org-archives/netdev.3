Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D23D647E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673676; cv=none; b=oaI9clHlcB0hGdnjrNn8rkooghEI17pkXEhcgu41JgNhL5YpLKALZ4lnO+wqHv3eLqlUP+uGQJNo50xWIkDDJ+UqBpFdZfmg0LE5/2/jwZknFSacIHNsLdMWkpChnP2VOpcv446/I37J2bKuD3YL1uGBUDZpfdDVzm5xEIRM/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673676; c=relaxed/simple;
	bh=kgeff5hjMXltLPVnsUwoEjY717fs8SMLIoag/T9Q+VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jshXqbt5zDWuk0K3aGFmWK6ixXyvswDOBYGieKMQKWUURTQG5f1/CvG6a9evkw9CjttXHk/t3wmaFgzdKLC7xQ/q4helq4FPzmUvNibT2rJV5tzjhFct74GCoRNs/J9idgDYCg45zc73fEsq5JXDtnq+HGirBv9W0Oi24pWVCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAm1v5oV; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAm1v5oV"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848860def2cso347652b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673670; x=1787278470; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wHGZmtNngXkf+GAdUEbCHsucY0/wRyW6BFD/+a1i02E=;
        b=eAm1v5oVQPK73cjE2ktoSiw/utQlvYmawNF8AXMDxNmCXhdvq/4wqoFoJBJjUszKtu
         Jgj5I5er4mWemxJt6ZYlIULXKukCri4vdLPGidov++t3D2Jw89ujGA0roBFPBjbk4uRB
         7ewpDZbhmSrBZhkbvKyDbtG6c3HDtw/WU3ZY3HbwftaJjkzH4zAnFRo1JndjUESjjweM
         0bjoMm1/xHl1/Shi8BxVVQ6HBED/TKjrtvdACzMOt15GEe8vHCX/5XXhFW+8H5hd/DxQ
         f1UBXKS3O0v06QZzTtXxKFt6GcUwtZW+E/B8R0r+/rZMPiPEw/2DJWQUZQStcaaBedKJ
         P3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673670; x=1787278470;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHGZmtNngXkf+GAdUEbCHsucY0/wRyW6BFD/+a1i02E=;
        b=FVQCDLfhSFTxWhon3CU2I8aRUZIqIGtDN9ViB1cu64TupscsRBh5Q8leRs82cw2/57
         Fo2Yjd+a3qJPMt6PLsOT5IfX5d39CPjLf8uqmki4dkP0i8gG8sITzQO/pjTHf9u8x3kL
         tkrFQOKmbalf3/S7ChXZJoS+54T7du5oEzvnpuF2trhF0N6Vxa5hpsTm4CNEp/GMlNnM
         hA3kZlKm1rhAgxiW/6SSHZ9F69rb9XU48Qs57H5GseMrOynR4U9bhxudra+YLlUj4tVi
         etpwukkAiCDD3YvuKRRx2pRXltETKS8N8gw927DslQVtl+i+SBwxjaT8v3sm8eafrJo5
         lcrQ==
X-Gm-Message-State: AOJu0YxvLzusBoQCTdW90WT3canB9Y2tonFEglIz284aLcD9x9FsBgcr
	mZG3fCFvkOsb3LQeC5ArOkt5DpR63Zk0zf7D35XxokCdoAiCOUYXlH+2LsKbtUlPhGODF+ePhMg
	dei7asI7FzIrqrXVXaFKDkwq6uVecw8rQLdYSIeTkg2M/LO6nWnsdJhx2VMRmwjZXNldL9Ce9GR
	UWo7i6GocLuULuMsGeyGFzVmkiD7Sp8wJqqSeR9Fg8YNohVCLeIww62YiNwXXZmxA=
X-Received: from pgbdp5.prod.google.com ([2002:a05:6a02:f05:b0:c99:aff5:7078])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9a9:b0:846:a26:8e0b with SMTP id d2e1a72fcca58-84fde521a09mr2064729b3a.18.1786673669134;
 Thu, 13 Aug 2026 19:14:29 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:14:02 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-13-hramamurthy@google.com>
Subject: [PATCH net-next v4 12/15] gve: introduce new methods to handle IRQ doorbells
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

From: Joshua Washington <joshwash@google.com>

Introduce `request_db_info` and `release_db_resources` to
`struct gve_ctrl_ops`. These encapsulate the configuration of device
resources (counter arrays and IRQ doorbell indices) which vary between
Admin Queue and Mailbox modes. Registration and de-registratino of IRQ
dorrbell indices with the device will be managed by these new methods
instead of occurring directly in notify_block setup/teardown methods.
Similarly, GQ ring counters will be managed in `request_db_info`.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4:
  - propagate code changes as specified by v3.
v3:
  - move allocation of IRQ DB indices and counter array back into
    gve_alloc_control_plane_resources() from
    gve_adminq_request_db_info().
  - Similar to above, move free logic out of
    gve_adminq_free_db_resources() and rename all introduced methods
    from *free_db_resources to *release_db_resources to reflect the
    behavioral change.

 drivers/net/ethernet/google/gve/gve.h        | 10 ++
 drivers/net/ethernet/google/gve/gve_adminq.c | 37 ++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 98 ++++++++++----------
 4 files changed, 97 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8766ea62baf1..2d869d249cdd 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -836,6 +836,9 @@ struct gve_device_info {
  *                  structures stored in @priv to be used during initialization.
  * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
  *                     initialization.
+ * @request_db_info: Request and store doorbell information into @priv
+ * @release_db_resources: Release device hold on DMA memory holding doorbell
+ *			  info (AdminQ only)
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -846,6 +849,8 @@ struct gve_ctrl_ops {
 	void (*unmap_db_bar)(struct gve_priv *priv);
 	void (*set_num_queues)(struct gve_priv *priv);
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
+	int (*request_db_info)(struct gve_priv *priv);
+	void (*release_db_resources)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
@@ -1166,6 +1171,11 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
 	return (priv->num_ntfy_blks / 2) + queue_idx;
 }
 
+static inline u32 gve_ntfy_to_msix_idx(struct gve_priv *priv, u32 ntfy_blk_idx)
+{
+	return ntfy_blk_idx;
+}
+
 static inline bool gve_is_qpl(struct gve_priv *priv)
 {
 	return priv->queue_format == GVE_GQI_QPL_FORMAT ||
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 28a27beac7c5..049ef3c48307 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1716,3 +1716,40 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
 
 	pci_iounmap(pdev, priv->db_bar2);
 }
+
+int gve_adminq_request_db_info(struct gve_priv *priv)
+{
+	int err;
+	int i;
+
+	err = gve_adminq_configure_device_resources(priv,
+						    priv->counter_array_bus,
+						    priv->num_event_counters,
+						    priv->irq_db_indices_bus,
+						    priv->num_ntfy_blks);
+	if (unlikely(err)) {
+		dev_err(&priv->pdev->dev,
+			"could not setup device_resources: err=%d\n", err);
+		return -ENXIO;
+	}
+
+	for (i = 0; i < priv->num_ntfy_blks; i++)
+		priv->ntfy_blocks[i].irq_db_index =
+			&priv->irq_db_indices[i].index;
+	return 0;
+}
+
+void gve_adminq_release_db_resources(struct gve_priv *priv)
+{
+	int err;
+
+	/* Log error in deconfigure device, but don't fail. This is only ever
+	 * called as a reset is about to be triggered, so it would be redundant
+	 * to trigger a reset.
+	 */
+	err = gve_adminq_deconfigure_device_resources(priv);
+	if (err)
+		dev_err(&priv->pdev->dev,
+			"Could not deconfigure device resources: err=%d\n",
+			err);
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 5e51c060e237..52172bf228eb 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -657,4 +657,6 @@ int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
+int gve_adminq_request_db_info(struct gve_priv *priv);
+void gve_adminq_release_db_resources(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 6c71da979393..0768faa219e1 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -204,6 +204,30 @@ static void gve_free_counter_array(struct gve_priv *priv)
 	priv->counter_array = NULL;
 }
 
+static int gve_alloc_irq_db_indices(struct gve_priv *priv)
+{
+	priv->irq_db_indices =
+		dma_alloc_coherent(&priv->pdev->dev,
+				   priv->num_ntfy_blks *
+				   sizeof(*priv->irq_db_indices),
+				   &priv->irq_db_indices_bus, GFP_KERNEL);
+	if (!priv->irq_db_indices)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void gve_free_irq_db_indices(struct gve_priv *priv)
+{
+	if (!priv->irq_db_indices)
+		return;
+
+	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
+			  sizeof(*priv->irq_db_indices),
+			  priv->irq_db_indices, priv->irq_db_indices_bus);
+	priv->irq_db_indices = NULL;
+}
+
 /* NIC requests to report stats */
 static void gve_stats_report_task(struct work_struct *work)
 {
@@ -432,15 +456,6 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 static void gve_free_notify_blocks(struct gve_priv *priv)
 {
 	pci_disable_msix(priv->pdev);
-	if (priv->irq_db_indices) {
-		dma_free_coherent(&priv->pdev->dev,
-				  priv->num_ntfy_blks *
-				  sizeof(*priv->irq_db_indices),
-				  priv->irq_db_indices,
-				  priv->irq_db_indices_bus);
-		priv->irq_db_indices = NULL;
-	}
-
 	kvfree(priv->ntfy_blocks);
 	priv->ntfy_blocks = NULL;
 	kvfree(priv->msix_vectors);
@@ -497,24 +512,14 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
 
-	priv->irq_db_indices =
-		dma_alloc_coherent(&priv->pdev->dev,
-				   priv->num_ntfy_blks *
-				   sizeof(*priv->irq_db_indices),
-				   &priv->irq_db_indices_bus, GFP_KERNEL);
-	if (!priv->irq_db_indices) {
-		err = -ENOMEM;
-		goto abort;
-	}
-
 	priv->ntfy_blocks = kvzalloc(priv->num_ntfy_blks *
 				     sizeof(*priv->ntfy_blocks), GFP_KERNEL);
 	if (!priv->ntfy_blocks) {
 		err = -ENOMEM;
 		goto abort;
 	}
-	return 0;
 
+	return 0;
 abort:
 	gve_free_notify_blocks(priv);
 	return err;
@@ -529,13 +534,14 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
+		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
 
 		if (!block->irq_requested)
 			continue;
 
-		irq_set_affinity_hint(priv->msix_vectors[i].vector,
+		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
 				      NULL);
-		free_irq(priv->msix_vectors[i].vector, block);
+		free_irq(priv->msix_vectors[msix_idx].vector, block);
 		block->irq = 0;
 		block->irq_requested = false;
 	}
@@ -564,12 +570,11 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	}
 	priv->mgmt_irq_requested = true;
 
-	/* Setup the other blocks - the first n-1 vectors */
 	node_mask = gve_get_node_mask(priv);
 	cur_cpu = cpumask_first(node_mask);
 	for (i = 0; i < priv->num_ntfy_blks; i++) {
 		struct gve_notify_block *block = &priv->ntfy_blocks[i];
-		int msix_idx = i;
+		int msix_idx = gve_ntfy_to_msix_idx(priv, i);
 
 		snprintf(block->name, sizeof(block->name), "gve-ntfy-blk%d@pci:%s",
 			 i, pci_name(priv->pdev));
@@ -579,14 +584,13 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 				  IRQF_NO_AUTOEN, block->name, block);
 		if (err) {
 			dev_err(&priv->pdev->dev,
-				"Failed to receive msix vector %d\n", i);
+				"Failed to receive msix vector %d\n", msix_idx);
 			goto abort;
 		}
 		block->irq = priv->msix_vectors[msix_idx].vector;
 		block->irq_requested = true;
 		irq_set_affinity_and_hint(block->irq,
 					  cpumask_of(cur_cpu));
-		block->irq_db_index = &priv->irq_db_indices[i].index;
 
 		cur_cpu = cpumask_next(cur_cpu, node_mask);
 		/* Wrap once CPUs in the node have been exhausted, or when
@@ -603,7 +607,6 @@ static int gve_setup_notify_blocks(struct gve_priv *priv)
 	return err;
 }
 
-
 static void gve_free_control_plane_resources(struct gve_priv *priv)
 {
 	bitmap_free(priv->xsk_pools);
@@ -612,9 +615,10 @@ static void gve_free_control_plane_resources(struct gve_priv *priv)
 	kvfree(priv->ptype_lut_dqo);
 	priv->ptype_lut_dqo = NULL;
 
-	gve_free_stats_report(priv);
-	gve_free_notify_blocks(priv);
+	gve_free_irq_db_indices(priv);
 	gve_free_counter_array(priv);
+	gve_free_notify_blocks(priv);
+	gve_free_stats_report(priv);
 	gve_free_rss_config_cache(priv);
 	gve_free_flow_rule_caches(priv);
 }
@@ -627,15 +631,18 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 	if (err)
 		return err;
 	err = gve_alloc_rss_config_cache(priv);
-	if (err)
-		goto abort;
-	err = gve_alloc_counter_array(priv);
 	if (err)
 		goto abort;
 	err = gve_alloc_notify_blocks(priv);
 	if (err)
 		goto abort;
 	err = gve_alloc_stats_report(priv);
+	if (err)
+		goto abort;
+	err = gve_alloc_counter_array(priv);
+	if (err)
+		goto abort;
+	err = gve_alloc_irq_db_indices(priv);
 	if (err)
 		goto abort;
 
@@ -665,15 +672,9 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
-	err = gve_adminq_configure_device_resources(priv,
-						    priv->counter_array_bus,
-						    priv->num_event_counters,
-						    priv->irq_db_indices_bus,
-						    priv->num_ntfy_blks);
-	if (unlikely(err)) {
-		dev_err(&priv->pdev->dev,
-			"could not setup device_resources: err=%d\n", err);
-		err = -ENXIO;
+	err = ops->request_db_info(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Failed to get db info");
 		return err;
 	}
 
@@ -682,7 +683,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
-			goto deconfigure_device;
+			goto release_db_resources;
 		}
 	}
 
@@ -712,8 +713,8 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 
 teardown_clock:
 	gve_teardown_clock(priv);
-deconfigure_device:
-	gve_adminq_deconfigure_device_resources(priv);
+release_db_resources:
+	ops->release_db_resources(priv);
 	return err;
 }
 
@@ -746,12 +747,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
 		gve_teardown_clock(priv);
-
-		err = gve_adminq_deconfigure_device_resources(priv);
-		if (err)
-			dev_err(&priv->pdev->dev,
-				"Could not deconfigure device resources: err=%d\n",
-				err);
+		ops->release_db_resources(priv);
 	}
 
 	gve_clear_device_resources_ok(priv);
@@ -2503,6 +2499,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.reset_flow_rules	= gve_adminq_reset_flow_rules,
 	.setup_stats_report	= gve_adminq_report_stats,
 	.configure_rss		= gve_adminq_configure_rss,
+	.request_db_info	= gve_adminq_request_db_info,
+	.release_db_resources	= gve_adminq_release_db_resources,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.691.gc56d675ccc-goog

