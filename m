Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8C4B66E6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276024; cv=none; b=b3ncYIz812JEMpfabGOzhlb3B/+sB1fFvPwexpBW+hK7x6lsn7++Yp3SM6T78FUDOX0YbKUDcZAS8JguT4Yw8lZw21nSyPhTh61KvDHBlqs7W8E/pWwhAihzXClS/0CgApBr3hcGzoFcqigXYojvRA8t4AyQtWhaVFZCgNnfoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276024; c=relaxed/simple;
	bh=08vuhg9ScLY4vV08LZxRb3Py2BosDvFjVUb+b1gLzg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jDPsKAA7DQufh4zRcaQpguZtGmhlPBu93t0re/ncf+qAEXyLXm0NSC2NBdvbvKSAkM8/DYdwUjKaCpBXcEjui/PbuKHaBqWamluyTbBIdcdye7MBVjOl1HUGBopW4ORhr6eqd/d1sBY+jrYtsOsjDixh+/Jd2FS4FKkU0YjT6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UI1XOYlB; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UI1XOYlB"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a0b6ef90fdso84434a91.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790276012; x=1790880812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6fDt+d1XdgwpfVdxbn4nsSQ2IETcdVBzV4tfQE26E=;
        b=UI1XOYlBn5Qex2RhQHMZLt8Exb9Ehz0TfZrMNdB9LLgWcM18+UBOmpJ8hnbcsYeWVX
         zYxcloS4jvz72k6LbSkxzgIGCg48NhSO63688sS9FsJgTD4Y2Xx+1kPurCQS12oYp4wq
         ZnoXHlkkSCf0g26Q1gzdZs/8nRovVHvlDNfI7ZdZMMqYoFO/RQJ84KEKEmsmVOoHcPwb
         JM1kLaxIvQ4rTHnnWIrkU7En3CqHgLh0k8ImwwgHMRi1tIlUcsJ9LXr/lFnF6I6xgw2q
         JTxMYY3gsecSg46T2sCgh+dTYGJHUI4XjeSc2QnMqfYaqn1k62cx+uWksYI+FJeRbsXD
         Q/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276012; x=1790880812;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8V6fDt+d1XdgwpfVdxbn4nsSQ2IETcdVBzV4tfQE26E=;
        b=E6rrSIbkIxoPNE9HkkvteKr1qAW/Ka0dfnbXgXdUnryGrHO+7lTBa8EQ/bFJp0ItFU
         FYCa5Hh/4wNWHDJYYUwdo0kEcc+vqLgz/l3LJ1IMSY2gygo4AVUq134k05Ds5shqQs6E
         N0WzaHhntvycTWDEUYKs9Fh+5CHc+8MxMU8iY5j6HnAQTo2l21s6snzKGI6ofNmXB06x
         s+YedwBn5wYN65UFtdK54gQzrJLpgkpVCxtDPVra4AId8Oxk8TysHBO83Fh2AQPtt03N
         tIlRlxOLlwmMVbtb5Iq//1wDejFx4XHfMkYagtprlQUPTTO6wUH3PsCzR+qGg6LLFCxj
         Rf/Q==
X-Gm-Message-State: AFuF++lvA0oWjiO9SjA0WR5/dw+9gFZTFemhjxJicRzqkv45ykW0A9Um
	nDSkI2ZhjNbMF4tcWTzzUtG3g8ceFHmdjGN69u52uFv3SmKbuIPuRPsPj0jsSG3MSKsPx6o4hj2
	HzELzQV4WsnIlWAVm/XHuqYIwUAuRBRPfFJUh3eMPit+b9W3+wb+o4v264NniQ4bF3bEtXCNIAr
	0A0ZaAlyqjB46VnpmfM1NTzbhqtppW6wwi5dy88exsl8NQ/wq8Q1CBkBXBhvdaaFc=
X-Received: from pjbbh11.prod.google.com ([2002:a17:90b:48b:b0:3a0:9d29:98f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:268c:b0:3a0:5238:1aed with SMTP id 98e67ed59e1d1-3a098729546mr3175554a91.37.1790276005142;
 Thu, 24 Sep 2026 11:53:25 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:53:12 +0000
In-Reply-To: <20260924185316.2831077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924185316.2831077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924185316.2831077-9-hramamurthy@google.com>
Subject: [PATCH net-next v8 08/12] gve: split up notify block allocation and
 setup paths
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

From: Joshua Washington <joshwash@google.com>

Before this patch, notify block allocation and setup occurred in the same
method. This all occurred before gve_adminq_configure_device_resources,
which populates the irq_db_indicies array, a DMA region with BAR offsets
for MSI-X vectors.

The coming mailbox mode will require notify blocks to be set up only
after receiving the IRQ doorbell offsets, as the request does not work
with a supplied DMA buffer in the way that admin queue mode does. The
intended flow in that case would be:

1) allocate notify blocks
2) request doorbell information
3) set up MSI-X vectors based on doorbell info

This ordering also works for admin queue mode, so it will be updated to
match.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v8:
- gate mgmt irq vs ntfy block teardown on different conditions
- move gve_teardown_notify_blocks() to gve_teardown_device() from
  gve_reset_device()
- don't set block->irq when tearing down notify blocks
- guard disable_irq() call in gve_remove_napi() on whether the irq was
  requested
- teardown notify blocks as part of device reset

v3:
- remove redundant call to gve_teardown_clock()

 drivers/net/ethernet/google/gve/gve.h       |   2 +
 drivers/net/ethernet/google/gve/gve_main.c  | 155 +++++++++++++++-------------
 drivers/net/ethernet/google/gve/gve_utils.c |   4 +-
 3 files changed, 89 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index e0583e8cd2cd..f624a3e385e4 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -674,6 +674,7 @@ struct gve_notify_block {
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
 	u32 irq;
+	bool irq_requested;
 };
 
 /* Tracks allowed and current rx queue settings */
@@ -954,6 +955,7 @@ struct gve_priv {
 	u64 link_speed;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
+	bool mgmt_irq_requested;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Must be a power of two. */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 45451eac3e0a..a9866e1272cc 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -425,6 +425,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+static void gve_free_notify_blocks(struct gve_priv *priv)
+{
+	pci_disable_msix(priv->pdev);
+	if (priv->irq_db_indices) {
+		dma_free_coherent(&priv->pdev->dev,
+				  priv->num_ntfy_blks *
+				  sizeof(*priv->irq_db_indices),
+				  priv->irq_db_indices,
+				  priv->irq_db_indices_bus);
+		priv->irq_db_indices = NULL;
+	}
+
+	kvfree(priv->ntfy_blocks);
+	priv->ntfy_blocks = NULL;
+	kvfree(priv->msix_vectors);
+	priv->msix_vectors = NULL;
+}
+
 static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
 {
 	if (priv->numa_node == NUMA_NO_NODE)
@@ -436,11 +454,9 @@ static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
 static int gve_alloc_notify_blocks(struct gve_priv *priv)
 {
 	int num_vecs_requested = priv->num_ntfy_blks + 1;
-	const struct cpumask *node_mask;
-	unsigned int cur_cpu;
 	int vecs_enabled;
-	int i, j;
 	int err;
+	int i;
 
 	priv->msix_vectors = kvzalloc_objs(*priv->msix_vectors,
 					   num_vecs_requested);
@@ -454,7 +470,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev, "Could not enable min msix %d/%d\n",
 			GVE_MIN_MSIX, vecs_enabled);
 		err = vecs_enabled;
-		goto abort_with_msix_vectors;
+		goto abort;
 	}
 	if (vecs_enabled != num_vecs_requested) {
 		int new_num_ntfy_blks = (vecs_enabled - 1) & ~0x1;
@@ -477,15 +493,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
 	}
 
-	/* Setup Management Vector  - the last vector */
-	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name), "gve-mgmnt@pci:%s",
-		 pci_name(priv->pdev));
-	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
-			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
-	if (err) {
-		dev_err(&priv->pdev->dev, "Did not receive management vector.\n");
-		goto abort_with_msix_enabled;
-	}
 	priv->irq_db_indices =
 		dma_alloc_coherent(&priv->pdev->dev,
 				   priv->num_ntfy_blks *
@@ -493,15 +500,64 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 				   &priv->irq_db_indices_bus, GFP_KERNEL);
 	if (!priv->irq_db_indices) {
 		err = -ENOMEM;
-		goto abort_with_mgmt_vector;
+		goto abort;
 	}
 
 	priv->ntfy_blocks = kvzalloc(priv->num_ntfy_blks *
 				     sizeof(*priv->ntfy_blocks), GFP_KERNEL);
 	if (!priv->ntfy_blocks) {
 		err = -ENOMEM;
-		goto abort_with_irq_db_indices;
+		goto abort;
+	}
+	return 0;
+
+abort:
+	gve_free_notify_blocks(priv);
+	return err;
+}
+
+static void gve_teardown_notify_blocks(struct gve_priv *priv)
+{
+	int i;
+
+	if (priv->mgmt_irq_requested) {
+		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
+		priv->mgmt_irq_requested = false;
+	}
+
+	if (!priv->ntfy_blocks)
+		return;
+
+	for (i = 0; i < priv->num_ntfy_blks; i++) {
+		struct gve_notify_block *block = &priv->ntfy_blocks[i];
+
+		if (!block->irq_requested)
+			continue;
+
+		irq_set_affinity_hint(priv->msix_vectors[i].vector,
+				      NULL);
+		free_irq(priv->msix_vectors[i].vector, block);
+		block->irq_requested = false;
 	}
+}
+
+static int gve_setup_notify_blocks(struct gve_priv *priv)
+{
+	const struct cpumask *node_mask;
+	unsigned int cur_cpu;
+	int i;
+	int err;
+
+	/* Setup Management Vector  - the last vector */
+	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
+		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
+	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
+			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "Did not receive management vector.\n");
+		return err;
+	}
+	priv->mgmt_irq_requested = true;
 
 	/* Setup the other blocks - the first n-1 vectors */
 	node_mask = gve_get_node_mask(priv);
@@ -519,9 +575,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to receive msix vector %d\n", i);
-			goto abort_with_some_ntfy_blocks;
+			goto abort;
 		}
 		block->irq = priv->msix_vectors[msix_idx].vector;
+		block->irq_requested = true;
 		irq_set_affinity_and_hint(block->irq,
 					  cpumask_of(cur_cpu));
 		block->irq_db_index = &priv->irq_db_indices[i].index;
@@ -535,61 +592,12 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 			cur_cpu = cpumask_first(node_mask);
 	}
 	return 0;
-abort_with_some_ntfy_blocks:
-	for (j = 0; j < i; j++) {
-		struct gve_notify_block *block = &priv->ntfy_blocks[j];
-		int msix_idx = j;
 
-		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
-				      NULL);
-		free_irq(priv->msix_vectors[msix_idx].vector, block);
-		block->irq = 0;
-	}
-	kvfree(priv->ntfy_blocks);
-	priv->ntfy_blocks = NULL;
-abort_with_irq_db_indices:
-	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
-			  sizeof(*priv->irq_db_indices),
-			  priv->irq_db_indices, priv->irq_db_indices_bus);
-	priv->irq_db_indices = NULL;
-abort_with_mgmt_vector:
-	free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-abort_with_msix_enabled:
-	pci_disable_msix(priv->pdev);
-abort_with_msix_vectors:
-	kvfree(priv->msix_vectors);
-	priv->msix_vectors = NULL;
+abort:
+	gve_teardown_notify_blocks(priv);
 	return err;
 }
 
-static void gve_free_notify_blocks(struct gve_priv *priv)
-{
-	int i;
-
-	if (!priv->msix_vectors)
-		return;
-
-	/* Free the irqs */
-	for (i = 0; i < priv->num_ntfy_blks; i++) {
-		struct gve_notify_block *block = &priv->ntfy_blocks[i];
-		int msix_idx = i;
-
-		irq_set_affinity_hint(priv->msix_vectors[msix_idx].vector,
-				      NULL);
-		free_irq(priv->msix_vectors[msix_idx].vector, block);
-		block->irq = 0;
-	}
-	free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-	kvfree(priv->ntfy_blocks);
-	priv->ntfy_blocks = NULL;
-	dma_free_coherent(&priv->pdev->dev, priv->num_ntfy_blks *
-			  sizeof(*priv->irq_db_indices),
-			  priv->irq_db_indices, priv->irq_db_indices_bus);
-	priv->irq_db_indices = NULL;
-	pci_disable_msix(priv->pdev);
-	kvfree(priv->msix_vectors);
-	priv->msix_vectors = NULL;
-}
 
 static void gve_tx_get_curr_alloc_cfg(struct gve_priv *priv,
 				      struct gve_tx_alloc_rings_cfg *cfg)
@@ -824,6 +832,7 @@ static void gve_teardown_device(struct gve_priv *priv)
 	/* Free any resources shared with the device only after we have a
 	 * guarantee that the device will not try to access such resources.
 	 */
+	gve_teardown_notify_blocks(priv);
 	gve_free_control_plane_resources(priv);
 	gve_queues_mem_remove(priv);
 }
@@ -2477,13 +2486,16 @@ static int gve_setup_device(struct gve_priv *priv)
 
 	err = gve_alloc_control_plane_resources(priv);
 	if (err)
-		goto err;
+		return err;
+
 	err = gve_setup_control_plane_resources(priv);
 	if (err)
-		goto err;
+		return err;
+
+	err = gve_setup_notify_blocks(priv);
+	if (err)
+		return err;
 	return 0;
-err:
-	return err;
 }
 
 static const struct gve_ctrl_ops gve_adminq_ops = {
@@ -2630,6 +2642,7 @@ int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
 	gve_reset_device(priv);
 	gve_queues_stop(priv);
 	gve_queues_mem_remove(priv);
+	gve_teardown_notify_blocks(priv);
 	gve_free_control_plane_resources(priv);
 
 	enable_work(&priv->service_task);
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index b53b7fcdcdaf..caed38cd5f2b 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -119,6 +119,8 @@ void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
 {
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
-	disable_irq(block->irq);
+	if (block->irq_requested)
+		disable_irq(block->irq);
+
 	netif_napi_del_locked(&block->napi);
 }
-- 
2.56.0.rc1.310.g51773c2048-goog

