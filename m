Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9503D75C9
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673673; cv=none; b=RzVVbAyg2f3vX5uGQAbBhiIad9R9Zn4kbYlFl3XcHWoxkaAcXmWLKu0J9BIiMTs95EATSLIPYdw85Lb5WUBDLqzGZWEdMJd56GDXdw0+HVOuq52QTL68rPxjrhDiMByW7z2KmD8/32y/K8pZZGitjiZRDPw6yQt83GeL4mja990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673673; c=relaxed/simple;
	bh=hYuUOt2XPBr+R1HG9cMXvIfzbP9B3EnfW4DYFIHXZbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQ7i4dUlSnSDqftNm3oEkWW0bZmia0YEPzIEiyAbyKlDmaNvkBk2ocuDWAK8fdujnUtvD3/E3mSTgBzX8JNaBkLhsZjCa9AQO1khqD/urXbzo9gI3UcdeR3P30VnADhblc18XWai5N1olTDPytY/KHnb28VZq6s/xtOZi6jz0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uogny9UO; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uogny9UO"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso332251a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673669; x=1787278469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ag/yhY6dwBf7OKP6i3h9H4JZOR2URi/ogNcfn7Ul4PE=;
        b=uogny9UORXzcXcFo1jFh6NdtKJ8mL/Etuk/I7WNjTqJW6uAePkNWK602TnnSuN8+sd
         ZDTTNVa0P0jxl5Ih89kIQF+JSkcZE20vJhOYjkSnKPgebkeqV9UcK6ycF5G74/3JzjvA
         Yz83UU1YbiJozOjZJQx2BtxogIEwZ5P/u1BRmNr5T8KqEZZCd4+xpJZknYsmelDCc6Zd
         4vQwyNQrGke8hvLPy87lZx19EYXudmfrP7YVNyNlmw9fE29PwqI/SLPd9aIp19Ou37F8
         UT5OxmSGqfJWNdwIc6bpi757EEoeoG8/zWNnH56tgSc5BEs79TuhfVk93CVwATJ7AR+6
         NEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673669; x=1787278469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ag/yhY6dwBf7OKP6i3h9H4JZOR2URi/ogNcfn7Ul4PE=;
        b=nI+/0BlkHmURcHB1X4HVfWRzxOukHjeQqPvpk5E57UtnewlL66WJt5oOUkMOb3SEjf
         D5LxNmUou8tWbq7+0bQC3LuGgWg/v97cXq1IaF/kL9UV1Lvycy9AB57+Wa8lt1wH04dW
         KJgKWvYzyS+vGt2tahAb0FqKCPjZOGGka4T1Lv0JuDZa7xGxv5vf5YJjblF0nBN1a8lL
         lEazPu4Fz8w12BM1UAvSp5+bM3UuJtuBwxZpIvLFQtXruN9H73mjFgd0Jt5MZV4qdbdc
         sofDOCj+6zCPVfvS9JO2EWtSb+oDrgtiJA0LaFqvV+CKD+MudEcO5hJ6WDljAFgFsD6B
         rRHw==
X-Gm-Message-State: AOJu0YxnJ3vjEGIdtmoscz9ZgiWw5+gb07M037De7ag+xxA1Ee8FbtWq
	9RT3ubce4eh6S6ZDVI5kZwR6oiN7+hPZPLOAhzbwOIr4gys9X31shjnpc/K2WyRXK48AVyeaW/A
	M2Q55RBnpS0dSzeIz6j6/XIv+QpnTluG50R6w2lT8yO3TUjimBoGO+H/ddKoTVjhHuAwrotUD9C
	3ObaBbBHy2O6xR2cmQqcOkXvKzLyYWumo4JW66sJtAUAw54oQEAtxcwn6Z/ffRtl4=
X-Received: from pgla28.prod.google.com ([2002:a63:b5c:0:b0:c91:7774:1541])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:700d:b0:39f:59c8:f302 with SMTP id adf61e73a8af0-3cc71dce958mr2558696637.37.1786673668366;
 Thu, 13 Aug 2026 19:14:28 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:14:01 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-12-hramamurthy@google.com>
Subject: [PATCH net-next v4 11/15] gve: split up notify block allocation and
 setup paths
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
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v3:
- remove redundant call to gve_teardown_clock()

 drivers/net/ethernet/google/gve/gve.h      |   2 +
 drivers/net/ethernet/google/gve/gve_main.c | 155 +++++++++++----------
 2 files changed, 86 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index c65c7d264430..8766ea62baf1 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -676,6 +676,7 @@ struct gve_notify_block {
 	struct gve_tx_ring *tx; /* tx rings on this block */
 	struct gve_rx_ring *rx; /* rx rings on this block */
 	u32 irq;
+	bool irq_requested;
 };
 
 /* Tracks allowed and current rx queue settings */
@@ -956,6 +957,7 @@ struct gve_priv {
 	u64 link_speed;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
+	bool mgmt_irq_requested;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
 	/* Must be a power of two. */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9327c5d6956e..11001a980a1f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -429,6 +429,24 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
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
@@ -440,11 +458,9 @@ static const struct cpumask *gve_get_node_mask(struct gve_priv *priv)
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
@@ -458,7 +474,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 		dev_err(&priv->pdev->dev, "Could not enable min msix %d/%d\n",
 			GVE_MIN_MSIX, vecs_enabled);
 		err = vecs_enabled;
-		goto abort_with_msix_vectors;
+		goto abort;
 	}
 	if (vecs_enabled != num_vecs_requested) {
 		int new_num_ntfy_blks = (vecs_enabled - 1) & ~0x1;
@@ -481,15 +497,6 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
@@ -497,15 +504,65 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
+		block->irq = 0;
+		block->irq_requested = false;
+	}
+
+	if (priv->mgmt_irq_requested) {
+		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
+		priv->mgmt_irq_requested = false;
+	}
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
 	}
+	priv->mgmt_irq_requested = true;
 
 	/* Setup the other blocks - the first n-1 vectors */
 	node_mask = gve_get_node_mask(priv);
@@ -523,9 +580,10 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
@@ -539,61 +597,12 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
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
 
 static void gve_free_control_plane_resources(struct gve_priv *priv)
 {
@@ -750,6 +759,7 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 
 static void gve_teardown_device(struct gve_priv *priv)
 {
+	gve_teardown_notify_blocks(priv);
 	gve_teardown_control_plane_resources(priv);
 	gve_adminq_free(priv);
 	/*
@@ -2472,13 +2482,16 @@ static int gve_setup_device(struct gve_priv *priv)
 
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
-- 
2.55.0.691.gc56d675ccc-goog

