Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BE4398F5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782806; cv=none; b=uupJOe8jluy5u3nFk/bfI7KJJ6JbE/ijElrIaKanacs+x9UBgXV7+TdSUmlb6ocBFZwaWUixh8Mu0fm99acfVuhJiz1XyzMCV1KkQhYurqGtiwNcBvd5Un2CrwZBG0P2y3x7VOQ0Qcbkmh6htrIvpjlI99h7VvqsYVzLjARHn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782806; c=relaxed/simple;
	bh=o4sl3p7EzsNiniVxH17fUGn1Ut+fjVtnh67MYn+VtIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y08i25Y6lofDqDFVnD33S4rYxRR2ZISlXer8IzhI02hYtF9WYw4mp6AjMIpgeeb2P8OX7AN7QYvTtXPHhBhQ//85BkSqPOAt/gyEKQ+rTDFXqwvixZbCnv49n00w9dGn1WvrTMnsQPB/BKaEhla+/+hLVaMRBoQAAZWbov69IeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zu9PSmGL; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zu9PSmGL"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so9203333a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782801; x=1786387601; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1OjdDoxIDxWtacvmMk5xwArStpy9Vv9TskgMY78Ajt0=;
        b=Zu9PSmGLXGfp5YSvcDN/KfBgs4mYJK7+HFC4a5l/vq+dscixzD/bZuVFVTiKJf+V0J
         khVBU63Fy55GwLaIFeAGBlas2EbtEjbbt60k+Rc8HBnJ9OgA/3UNnu0rNcGODw3E70NY
         JOEf8VmDS4KtUVaurwk0NrXtmST6426pslg17xvkIBxqo/GoFHrZvGLt6Plug7rN8irj
         /QVeN0h33g/2ae5nhca9sUnAM9w+tVVrpG+XwMsBubW2PgbKZjHH9JQxJd5DiZsP77/K
         ZpSxFKmBkWW1J4q60C1NJrTybAqFbukIoZq1Pp56KGJQI5JtIWd4Be1v0DGSfRnovtfO
         0vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782801; x=1786387601;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OjdDoxIDxWtacvmMk5xwArStpy9Vv9TskgMY78Ajt0=;
        b=JZa3wLWMHCUPrY+MNiHfwwMFqxfC1ZDZWZ4Ipuzo9BdPCbRaQLVycYw4XSipBW6tHj
         Zh7ODsEbhcLgxCmE5ECEC2vENlJxPAqzhXB4FRImh2tZPw1vgkD4K3OMNBmJoPFD1bIY
         bFqMmyZ7RZMd1JW4OAQr5FXiXNTXTzRFN57RC65WH+gBuot2sFx94EzusNxriOXYOy7O
         nMCqM/u+cY+ZDApeH9lwcAQ7ICOMde0sABbAnO/gF4SPpcLaI8LuS8UvR2Kur8wRkXLs
         UoSjXIjzrQ26wtqw7ViFEOvQH53I+qrg2nn7bYADsbztMSLkCE38AhjKwRY12hcvIcvy
         KRXg==
X-Gm-Message-State: AOJu0Yyx9lucxIrZYfRRrNxg5gt6pRxLDVYhLFPZrbnyWmR2qixymvgz
	8rX7zpt6SITXZ7xzNJXU1/Ixt2d+tzDAlbwD3Rq2rtlCJos+uhldbAYd16CXC87ehlXOyAw80vX
	XQhqemT4gdE7laqmP7lW0zTClK+blcwOtUjyuCZPVxDLyj3Bv8Sxe35BvATBTw/oE3LBao8Yf2H
	ElV4GNbDA5GGNkVWTwCuGlRF+r4pnlxESTIUeU6IMDU//qDBITuHTrum1i0KoQXIw=
X-Received: from pjyt13.prod.google.com ([2002:a17:90a:e50d:b0:381:1b76:a387])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5807:b0:387:e0db:3fae with SMTP id 98e67ed59e1d1-38fbc588cc1mr10596300a91.39.1785782801152;
 Mon, 03 Aug 2026 11:46:41 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:25 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-11-hramamurthy@google.com>
Subject: [PATCH net-next v3 10/15] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
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

Driver initialization and teardown involve a number of control plane
operations that need to be defined for gve_probe to operate in both
mailbox and adminq modes. This list includes:

- get_ptype_map: a mapping of packet types (L3+L4) held in RX completion
  descriptors
- configure_rss: set up default RSS configuration if the device is not
  queryable
- setup_stats_report: set up DMA region for stats report (AQ-only)
- reset_flow_rules: needed in teardown; flushes all flow rules from
  device

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 12 ++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.c |  7 +++---
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c   | 24 +++++++++++++++-----
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 7d40267b0672..c65c7d264430 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -835,12 +835,24 @@ struct gve_device_info {
  *                  structures stored in @priv to be used during initialization.
  * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
  *                     initialization.
+ * @get_ptype_map: Learn packet type map from device and store it in @priv
+ * @configure_rss: Set up default RSS configuration
+ * @setup_stats_report: Set up DMA region for stats report (AdminQ only)
+ * @reset_flow_rules: Flush all flow rules from device
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
 	void (*unmap_db_bar)(struct gve_priv *priv);
 	void (*set_num_queues)(struct gve_priv *priv);
 	int (*set_num_ntfy_blks)(struct gve_priv *priv);
+	int (*get_ptype_map)(struct gve_priv *priv);
+	int (*configure_rss)(struct gve_priv *priv,
+			     struct ethtool_rxfh_param *param);
+	int (*setup_stats_report)(struct gve_priv *priv,
+				  u64 stats_report_len,
+				  dma_addr_t stats_report_addr,
+				  u64 interval_ms); /* AQ-specific */
+	int (*reset_flow_rules)(struct gve_priv *priv);
 };
 
 struct gve_priv {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index cb0fceb20f69..cb0e7005dd3c 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1327,8 +1327,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut)
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv)
 {
 	struct gve_ptype_map *ptype_map;
 	union gve_adminq_command cmd;
@@ -1354,9 +1353,9 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 
 	/* Populate ptype_lut. */
 	for (i = 0; i < GVE_NUM_PTYPES; i++) {
-		ptype_lut->ptypes[i].l3_type =
+		priv->ptype_lut_dqo->ptypes[i].l3_type =
 			ptype_map->ptypes[i].l3_type;
-		ptype_lut->ptypes[i].l4_type =
+		priv->ptype_lut_dqo->ptypes[i].l4_type =
 			ptype_map->ptypes[i].l4_type;
 	}
 err:
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 12d2d1347e21..d5f98a80be46 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -652,8 +652,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 			     dma_addr_t nic_ts_report_addr);
 
 struct gve_ptype_lut;
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
 void gve_adminq_unmap_db_bar(struct gve_priv *priv);
 int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 578520e10793..c347661faac0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -649,7 +649,8 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 
 static int gve_setup_control_plane_resources(struct gve_priv *priv)
 {
-	int err = 0;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+	int err;
 
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
@@ -664,7 +665,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	}
 
 	if (!gve_is_gqi(priv)) {
-		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
+		err = ops->get_ptype_map(priv);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
@@ -686,12 +687,13 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 		goto teardown_clock;
 	}
 
-	err = gve_adminq_report_stats(priv, priv->stats_report_len,
+	err = ops->setup_stats_report(priv, priv->stats_report_len,
 				      priv->stats_report_bus,
 				      GVE_STATS_REPORT_TIMER_PERIOD);
 	if (err)
 		dev_err(&priv->pdev->dev,
 			"Failed to report stats: err=%d\n", err);
+
 	gve_set_device_resources_ok(priv);
 	return 0;
 
@@ -712,6 +714,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
  */
 static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
 	/* Tell device its resources are being freed */
@@ -721,11 +724,13 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 			dev_err(&priv->pdev->dev,
 				"Failed to reset flow rules: err=%d\n", err);
 		/* detach the stats report */
-		err = gve_adminq_report_stats(priv, 0, 0x0, GVE_STATS_REPORT_TIMER_PERIOD);
+		err = ops->setup_stats_report(priv, 0, 0x0,
+					      GVE_STATS_REPORT_TIMER_PERIOD);
 		if (err)
 			dev_err(&priv->pdev->dev,
 				"Failed to detach stats report: err=%d\n", err);
 		gve_teardown_clock(priv);
+
 		err = gve_adminq_deconfigure_device_resources(priv);
 		if (err)
 			dev_err(&priv->pdev->dev,
@@ -1809,6 +1814,7 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	struct gve_rss_config *rss_config = &priv->rss_config;
 	struct ethtool_rxfh_param rxfh = {0};
 	u16 i;
@@ -1824,15 +1830,17 @@ int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 
 	rxfh.hfunc = ETH_RSS_HASH_TOP;
 
-	return gve_adminq_configure_rss(priv, &rxfh);
+	return ops->configure_rss(priv, &rxfh);
 }
 
 int gve_flow_rules_reset(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+
 	if (!priv->max_flow_rules)
 		return 0;
 
-	return gve_adminq_reset_flow_rules(priv);
+	return ops->reset_flow_rules(priv);
 }
 
 int gve_adjust_config(struct gve_priv *priv,
@@ -2469,6 +2477,10 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.unmap_db_bar		= gve_adminq_unmap_db_bar,
 	.set_num_queues		= gve_adminq_set_num_queues,
 	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
+	.get_ptype_map		= gve_adminq_get_ptype_map_dqo,
+	.reset_flow_rules	= gve_adminq_reset_flow_rules,
+	.setup_stats_report	= gve_adminq_report_stats,
+	.configure_rss		= gve_adminq_configure_rss,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.55.0.571.g244d577d93-goog

