Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942B4432F2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472573; cv=none; b=G1+T/ivg9GiLxvswFiX7A7u1vTXO2uERWVNbbc7iAnicVGZLh+/LgRYhdfqf88ylVHPCDT5pan1VAO8fvNaZK8n/u4AstFDVVKdGGKyr0cobp+naRGUP4axqFKHDy5hAtuDmeqrWFnJoe/fQOtI+aqdPn9aanLpiFUPT+sQGbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472573; c=relaxed/simple;
	bh=zSrs7aYz+vAgCwpZvQmhCs38kjUmXW9um680axBmA2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j1IJ6oQPmceUDL1Bq4CdKvO3VeW1bx1WVWeAwiY0+juI9JTkeYnlfHSX8lGCGLv7l+u/Kj8A2twG3eEztLp4DMd5SF/HXbWhAjbAAWXOU4GSdNUBGbN4KUPKoybUQ65QTxq3r388BM7rzjovB6B3QPrAYr4b8RkW78WN/fhyU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2UGuOzx; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2UGuOzx"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so5601475ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788472571; x=1789077371; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TG+S/OoFd1G/hm1kf3lv7fyXNZ72KOsUxRjVSuHUUFQ=;
        b=l2UGuOzxEH6P+V2hOpRiPSMWBvg4LEdQy8+a9bdLjEukSo9k2wk51rNeNwWVmKZxW4
         jbYsNh9bcvJC3rWe/vAlMhe6B1xmtKNHeg8hG/0Xx4VQinP+zU7WTV3djJkBGdO4fgOF
         diO0sx4K+FRwjyrQlZ+aon0lyYKRxrBrQbVMidrVxScZYoEpWEqXKEKoMfGSvHbLIdEX
         FeqSEhruj8gAaBrIgIIICcDHBoEbqPTmcYWKHXAeHpCnlzGu3yXPfWDUc+Qa9wQX0qfU
         Mel7Zzr2l3SoBFONuiZ0Is/GAhvGvbYR/A5H7P1nKSz0N1ti6HtwIXEhq+R7X2fNdXsR
         +vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472571; x=1789077371;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG+S/OoFd1G/hm1kf3lv7fyXNZ72KOsUxRjVSuHUUFQ=;
        b=dYUAZIpxNq3O1vO6uUMCbnS1RJxHnCyPHTFrw63vXNs8qCjYboXTuNGrAnuvRdzvJo
         Sn/p0uQU8cJG1ukuGSJklwa07p6bIcwHTAAKpyWJQ5ozx1zuppdxFgnqOsChrYFgoO3P
         IHkNVDa8MQNMufljfNA8it96StxCXzn7erFv7E+vOjz7CW71t8fJtVJ3a+doyyzCoOXJ
         8nbCkn2AQUxH4WpZV0Hyaw5/RAyXGMylSe4ajAJyHIUK6wtY+PQosSBMzUsZTwOfXECP
         9liDIQh92sVIhaxsKJcH9jtZmg9oSVugGGHgYjb7C7MApOF/3b+TWw05aIQSP+2I8ZYZ
         ODrA==
X-Gm-Message-State: AFuF++lP9DNW2wPbBGCGTVKSmdv+aubKUX6raHdozx4HAVGN5r346yZv
	Ed8fv1UBDEERK+g96NLceU5OLgCXXHPxQtt92AYjCaa4chG9vKUqQGT/UOfkLC+/J5B/7iow8Ul
	gawEJvFFUgaLQRObPnag8qFcwgyFas/pERvMSmYAksUYbqYR3BQ32JVtEOQHE71vsz+UT4gCVQW
	6iLn5qK0V5mziU+r05bQwN50Ltdi6Bs3GeYYnmB61zxgm+qv52D7z9LL+kl7D8Ruw=
X-Received: from pldd22.prod.google.com ([2002:a17:902:c196:b0:2d9:3358:3fa8])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2349:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2db125a5535mr27494035ad.2.1788472570755;
 Thu, 03 Sep 2026 14:56:10 -0700 (PDT)
Date: Thu,  3 Sep 2026 21:55:57 +0000
In-Reply-To: <20260903215606.31633-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903215606.31633-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903215606.31633-4-hramamurthy@google.com>
Subject: [PATCH net-next v5 03/12] gve: introduce ctrl ops to set vectors and Qs
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

Introduce following ctrl ops for Adminq mode.

- set_num_queues to set maximum and default TX/RX queues in the
  alloc structures used in the initialization flow.
- set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
  initialization flow.

This is done by attaching the adminq_ prefix to the existing
functions placed in the gve_adminq.c file.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v4: Attach 'adminq_' prefix in the function names for gve_set_num_queues
    and gve_set_num_ntfy_blks and set them as ops (Przemek Kitszel)

 drivers/net/ethernet/google/gve/gve.h        | 6 ++++++
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++--
 drivers/net/ethernet/google/gve/gve_adminq.h | 4 ++--
 drivers/net/ethernet/google/gve/gve_main.c   | 6 ++++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 56148ea3cfbf..1bc5e32b6618 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -829,10 +829,16 @@ struct gve_device_info {
  * struct gve_ctrl_ops - Control plane operations structure
  * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
  * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
+ * @set_num_queues: Sets default and max TX/RX queues into allocation
+ *                  structures stored in @priv to be used during initialization.
+ * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
+ *                     initialization.
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
+	void (*set_num_queues)(struct gve_priv *priv);
+	int (*set_num_ntfy_blks)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 08d8e49d563e..046155ae7d66 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1592,7 +1592,7 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
 	return err;
 }
 
-int gve_set_num_ntfy_blks(struct gve_priv *priv)
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)
 {
 	int num_ntfy;
 
@@ -1616,7 +1616,7 @@ int gve_set_num_ntfy_blks(struct gve_priv *priv)
 	return 0;
 }
 
-void gve_set_num_queues(struct gve_priv *priv)
+void gve_adminq_set_num_queues(struct gve_priv *priv)
 {
 	struct gve_device_info *device_info = &priv->device_info;
 
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 93d3cabb67f1..ed3504853908 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -656,8 +656,8 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
-int gve_set_num_ntfy_blks(struct gve_priv *priv);
-void gve_set_num_queues(struct gve_priv *priv);
+int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 93b714e1d130..12b23c2f948f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2463,6 +2463,8 @@ static void gve_set_buf_sizes(struct gve_priv *priv)
 static const struct gve_ctrl_ops gve_adminq_ops = {
 	.map_db_bar		= gve_adminq_map_db_bar,
 	.unmap_db_bar		= gve_adminq_unmap_db_bar,
+	.set_num_queues		= gve_adminq_set_num_queues,
+	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
 };
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
@@ -2501,14 +2503,14 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 
 	priv->queue_format = priv->device_info.queue_format;
 
-	err = gve_set_num_ntfy_blks(priv);
+	err = priv->ctrl_ops->set_num_ntfy_blks(priv);
 	if (err) {
 		dev_err(&priv->pdev->dev,
 			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	gve_set_num_queues(priv);
+	priv->ctrl_ops->set_num_queues(priv);
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
 	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-- 
2.55.0.979.g7e5102b832-goog

