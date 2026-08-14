Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E13D8125
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673675; cv=none; b=bvzaKeHg3SFH+a7Oe7LnNj0pTiAJj1m7PU+mElEq1gbZnd5sseWXpSWYDTt92G5sPzHAZn81XnelqPjpRJIwpZpLd0yJyfQQC/ZcNdGJBDdVNFF6G133vsfOuYeZ+G70MXPAldncVq6qjPO9+Rousld5xaVeqQPhN5IpSz4L7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673675; c=relaxed/simple;
	bh=1P7SL3ELHkjZcrK0AeZK45hx1kS2gBmSauo7k457i+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qZcTE1YSoz1m1GByWCz/LAWhsaqpponExszVmLNjrleWbi6qZK29byULgMUsL3O47DbY8RlfwwjhBFXXpaDkOSe6xl/86Vxa//iy2CcB7AM7e5NUyLZOxYhUp+z8FHvritC3tTvU0EpqW2U3vSGIWSidXylYuWOPPWx78LR6Ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfN2Y9ML; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfN2Y9ML"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca3673560so8665125ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673671; x=1787278471; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DcmK68FKuTMXuuhHVbS8GLAbni4+3r6YXbJXIx5kwSg=;
        b=TfN2Y9MLofoksDzo5j67cy3/Z6pAnXbZcyxsUdpVd/JPK89iLHpYMNyY6cHjUg2dWu
         kA+fMMWTAZdadiyo67COfBOkz4k6+6zDmCvANl6K4bapTTUvbIgfyWmLVIiASW+MVYvZ
         GXE9adCcGY6TpRzF2/A6PMlRDxzDrxE6JDCSWzPPOhQNfT2jGdUFvwlwC6dSjSe+I5MR
         jrAWE9dt+zkQM8sS9LQ7Oi8x6fuaVUK4/V7AXK8EdsYhIIHoipoxZFMcwI4DOKdFFgZD
         HE1Hieg+QmkiUj9hgOMFh5GYbFjObPeen4ZOuu2ISLvAmWP1/BpEbn7zGnMm7UKSw5dK
         jgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673671; x=1787278471;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcmK68FKuTMXuuhHVbS8GLAbni4+3r6YXbJXIx5kwSg=;
        b=ob7lqwYyzXaiziJQAFg3dNVlrSldWbnL5BzezcoTg3oa5bOv6xUag1y9ijeY7vileo
         PNjIYAZmGCsjaN2v8M0bF/nwXtd7jt/aATIFYsD7EG82hK5/3cGq7yp4kngS0P9lQYna
         7eVAtyWk4tmH2RRegctiGRC8XOpAJNzQl4bBP8TKOHYtFZBrYWq2iV28enAyxRK6YngQ
         0eJmx5Bka/MBc9sPpteZ04+dq2P6zvYSbNdRggMKTUM8bEvBtskr34/fJvPNrtOxL/BE
         0grM2zXjTMKkU13a4hqXT5doUErUwQ6sBTR1Iwj36qsDT9PCTuKWm+QNCrbNM0E5ZXRh
         0/AQ==
X-Gm-Message-State: AOJu0YzIUZuLTQZYMDwlcs0Uxfn6fIrLtMjscxcGSwx1dviBt5IwbP9l
	WMjxZ/lrhYqgY1u91FTneWdoPQ4tw2M4Q8EmxFxtkw+Dq89hkEd1PS7pOJqj2yN0AMpXj9ksaGn
	aYQleuh0NeWqSULK4fgr6tl4GJxXnpOy9u+Id3PrG56peAob0yI9CdcTSbPr1uwQy44HMnTAKMK
	eO/89ISO5t8v/zctsoGGJLjtWU4TrzIWgUcxnLOJuQovZgmFjxFrllI4nFpj8LeIA=
X-Received: from plbaz8.prod.google.com ([2002:a17:902:a588:b0:2d3:768a:b66c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf07:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2d3b07f77c0mr30625015ad.4.1786673670683;
 Thu, 13 Aug 2026 19:14:30 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:14:03 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-14-hramamurthy@google.com>
Subject: [PATCH net-next v4 13/15] gve: setup and teardown management interrupts
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

Introduce control ops to setup/teardown control plane IRQs. Admin
queue-specific functionality is moved to admin queue files.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  4 +++
 drivers/net/ethernet/google/gve/gve_adminq.c | 36 ++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 ++
 drivers/net/ethernet/google/gve/gve_main.c   | 32 +++++------------
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 2d869d249cdd..c9fffc727eb3 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -839,6 +839,8 @@ struct gve_device_info {
  * @request_db_info: Request and store doorbell information into @priv
  * @release_db_resources: Release device hold on DMA memory holding doorbell
  *			  info (AdminQ only)
+ * @setup_mgmt_irq: Setup control plane IRQ
+ * @teardown_mgmt_irq: Teardown control plane IRQ
  * @get_ptype_map: Learn packet type map from device and store it in @priv
  * @configure_rss: Set up default RSS configuration
  * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
@@ -851,6 +853,8 @@ struct gve_ctrl_ops {
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 	int (*request_db_info)(struct gve_priv *priv);
 	void (*release_db_resources)(struct gve_priv *priv);
+	int (*setup_mgmt_irq)(struct gve_priv *priv);
+	void (*teardown_mgmt_irq)(struct gve_priv *priv);
 	int (*get_ptype_map)(struct gve_priv *priv);
 	int (*configure_rss)(struct gve_priv *priv,
 			     struct ethtool_rxfh_param *param);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 3fdc3575c077..9a06af652533 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1748,3 +1748,39 @@ void gve_adminq_release_db_resources(struct gve_priv *priv)
 			"Could not deconfigure device resources: err=%d\n",
 			err);
 }
+
+static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
+{
+	struct gve_priv *priv = arg;
+
+	/* Device resources are not okay; consider the interrupt spurious. */
+	if (!gve_get_device_resources_ok(priv))
+		return IRQ_NONE;
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
index 52172bf228eb..0b48e9f2a82a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -659,4 +659,6 @@ int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 int gve_adminq_request_db_info(struct gve_priv *priv);
 void gve_adminq_release_db_resources(struct gve_priv *priv);
+int gve_adminq_setup_mgmt_irq(struct gve_priv *priv);
+void gve_adminq_teardown_mgmt_irq(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e57c8596fca4..eecc98807395 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -291,18 +291,6 @@ static void gve_free_stats_report(struct gve_priv *priv)
 	priv->stats_report = NULL;
 }
 
-static irqreturn_t gve_mgmnt_intr(int irq, void *arg)
-{
-	struct gve_priv *priv = arg;
-
-	/* Device resources are not okay; consider the interrupt spurious. */
-	if (!gve_get_device_resources_ok(priv))
-		return IRQ_NONE;
-
-	queue_work(priv->gve_wq, &priv->service_task);
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t gve_intr(int irq, void *arg)
 {
 	struct gve_notify_block *block = arg;
@@ -527,6 +515,7 @@ static int gve_alloc_notify_blocks(struct gve_priv *priv)
 
 static void gve_teardown_notify_blocks(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int i;
 
 	if (!priv->ntfy_blocks)
@@ -546,29 +535,24 @@ static void gve_teardown_notify_blocks(struct gve_priv *priv)
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
@@ -2501,6 +2485,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.configure_rss		= gve_adminq_configure_rss,
 	.request_db_info	= gve_adminq_request_db_info,
 	.release_db_resources	= gve_adminq_release_db_resources,
+	.setup_mgmt_irq		= gve_adminq_setup_mgmt_irq,
+	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.691.gc56d675ccc-goog

