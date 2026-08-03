Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE14399C1
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782811; cv=none; b=ug+TJCFEVJuNUDKN0xOPH8yoTs1xcbk7hqRQBwxT6mdiqB3QKAZNbpov5ceaMG9VCEq7X/Ujz0PlMBycnLiGnmaLkrdU0PyZoABDPjPSb3R2Ptuba5fHs4wGS8VMP492+VMTHHBxhTKjIwwFG8XgcVOk32dcDXHa3/h2UG/ksyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782811; c=relaxed/simple;
	bh=9DFROtzDiHlTQfzIKkmduVXjhrlPhb+mKANyvQpSKKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhpMmiA7fxN7X1qQHztlLd6whUNJ05nE7CzGNiyfK5o0RaW8X0bmTrG7QNVKBfnBT7dqrllIfe1IIcVAg3KuMvP6EfPMtbAbJh8IHE6J6CPF3Kv2XmOf9mRYUfVixt33EXuDy2wBarTJppsI6W1OsZAymmawUII4v5Ymego3PXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sbp/VQ0G; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbp/VQ0G"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb7049fa552so2462081a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782804; x=1786387604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2RBbZvLGwRhyDy9lRoYOxayZ8+y6KrV4gj+1lXpV68=;
        b=sbp/VQ0GtsZ9ZjsMYX7uUWx51tKeXSRZVqJnr1qemghcFb5i8TvOdoMaSG06736KxN
         TrE+8vx2jpRgvdUFIoxgFM8z9l98UQ42NithQ7yAVnyxbAd1yXnpU45e1b8hNLJ7+cJc
         of6HvTK3r1ZOQlxr6fpwVE11jFs4KzCPHDLxJ/DF8+P/EAeuKtR5Rjhw3Z9ibQs0pSwP
         E6/qupxatknjHc81E/6hlYx4fk7+jnJPHBJEA91ngNIO+ObWrwokmIttQVz4m5kKwpOO
         ynChbN3ExZrlK0lPUH7Y6yCAzLBKWfOty4PEtcKms46yvajnEnPveeVkcwb7U3LAiDBX
         Jjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782804; x=1786387604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2RBbZvLGwRhyDy9lRoYOxayZ8+y6KrV4gj+1lXpV68=;
        b=XGcxUgj/xWakBQutT3MRNozjT3N5b9fiQDoUdvv5VjqpoUsfo/GrGFx4tS2K2aVnHS
         9ccwFqCTbGDBwF9PlAdwzt4nSq3tOPiL7xaskqcGLVCsA08I83A399uHkYi8WrY2q2wL
         sUtqWhyhf7EMvByyvij2KDd5ajMJIXP4jzZwogJfMKNkyRNeJhexEWFzOeheDN+i09+8
         U/s+Sh3map7u1tmfle9JpbpvmmMEh3TcdwyE1na3GAhWEo16uI+W709MKLSFXW+MRvR5
         CD2jUV8QfFMVJmQ/bUrRjv5MS/pS0s1g6mHtYn628rGfpMsB4e3/ptZqjRBcgkZdQ4Yc
         dOjA==
X-Gm-Message-State: AOJu0YweaGWwcN3rBBQYKZFLMA31X1eV/ocLfkP6DXg9w5ujHyf8vMtj
	XpSc2lAENc6fInThr+dFgIJOwRiuBOesVOj3kHho07Tw6FbuJWoAK3dYWLfToKI/vv32M1lO3ot
	bO7Y7mBj6d9a5GLJbPJVz0fTbRQk5ABZvq39A7CRZgjkXLLWvQ1UmSqllWrniwdjMZ797/FmJ2B
	KysrbX0j0s3EAV/uTz9HvP1XZSKKi1Hx9X/xgo9mEmLLrj85Xd2tu15XQl1DHvQnU=
X-Received: from pgja2.prod.google.com ([2002:a63:cd42:0:b0:c97:228f:37ae])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:700c:b0:3c3:9aff:7a5b with SMTP id adf61e73a8af0-3c92aa27f78mr11077710637.50.1785782803657;
 Mon, 03 Aug 2026 11:46:43 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:28 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-14-hramamurthy@google.com>
Subject: [PATCH net-next v3 13/15] gve: setup and teardown management interrupts
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

From: Joshua Washington <joshwash@google.com>

Introduce control ops to setup/teardown control plane IRQs. Admin
queue-specific functionality is moved to admin queue files.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  4 +++
 drivers/net/ethernet/google/gve/gve_adminq.c | 32 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 28 ++++++-----------
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index f3cfc9d0cdec..352755660138 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -838,6 +838,8 @@ struct gve_device_info {
  *                     initialization.
  * @request_db_info: Request and store doorbell information into @priv
  * @free_db_resources: Free DMA memory holding doorbell info (AdminQ only)
+ * @setup_mgmt_irq: Setup control plane IRQ
+ * @teardown_mgmt_irq: Teardown control plane IRQ
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -850,6 +852,8 @@ struct gve_ctrl_ops {
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 	int (*request_db_info)(struct gve_priv *priv);
 	void (*free_db_resources)(struct gve_priv *priv);
+	int (*setup_mgmt_irq)(struct gve_priv *priv);
+	void (*teardown_mgmt_irq)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index f1ac55cc5b10..4299a3931789 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1752,3 +1752,35 @@ void gve_adminq_free_db_resources(struct gve_priv *priv)
 			"Could not deconfigure device resources: err=%d\n",
 			err);
 }
+
+static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
+{
+	struct gve_priv *priv = arg;
+
+	queue_work(priv->gve_wq, &priv->service_task);
+	return IRQ_HANDLED;
+}
+
+int gve_adminq_setup_mgmt_irq(struct gve_priv *priv)
+{
+	int err;
+
+	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
+		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
+	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
+			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
+	if (err)
+		return err;
+
+	priv->mgmt_irq_requested = true;
+
+	return 0;
+}
+
+void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv)
+{
+	if (priv->mgmt_irq_requested) {
+		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
+		priv->mgmt_irq_requested = false;
+	}
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 985b1aefea6e..ff656fb4f113 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -659,5 +659,7 @@ int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_request_db_info(struct gve_priv *priv);
 void gve_adminq_free_db_resources(struct gve_priv *priv);
+int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
+void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8f4a246cad18..f2dd82f6c254 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -291,14 +291,6 @@ static void gve_free_stats_report(struct gve_priv *priv)
 	priv->stats_report = NULL;
 }
 
-static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
-{
-	struct gve_priv *priv = arg;
-
-	queue_work(priv->gve_wq, &priv->service_task);
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t gve_intr(int irq, void *arg)
 {
 	struct gve_notify_block *block = arg;
@@ -523,6 +515,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 
 static void gve_teardown_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int i;
 
 	if (!priv->ntfy_blocks)
@@ -542,29 +535,24 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
 		block->irq_requested = false;
 	}
 
-	if (priv->mgmt_irq_requested) {
-		free_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector, priv);
-		priv->mgmt_irq_requested = false;
-	}
+	ops->teardown_mgmt_irq(priv);
 }
 
 static int gve_setup_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	const struct cpumask *node_mask;
 	unsigned int cur_cpu;
 	int i;
 	int err;
 
-	/* Setup Management Vector  - the last vector */
-	snprintf(priv->mgmt_msix_name, sizeof(priv->mgmt_msix_name),
-		 "gve-mgmnt@pci:%s", pci_name(priv->pdev));
-	err = request_irq(priv->msix_vectors[priv->mgmt_msix_idx].vector,
-			  gve_mgmnt_intr, 0, priv->mgmt_msix_name, priv);
+	/* Setup Management Vector */
+	err = ops->setup_mgmt_irq(priv);
 	if (err) {
-		dev_err(&priv->pdev->dev, "Did not receive management vector.\n");
+		dev_err(&priv->pdev->dev,
+			"Did not receive management vector.\n");
 		return err;
 	}
-	priv->mgmt_irq_requested = true;
 
 	node_mask = gve_get_node_mask(priv);
 	cur_cpu = cpumask_first(node_mask);
@@ -2492,6 +2480,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.configure_rss		= gve_adminq_configure_rss,
 	.request_db_info	= gve_adminq_request_db_info,
 	.free_db_resources	= gve_adminq_free_db_resources,
+	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
+	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.571.g244d577d93-goog

