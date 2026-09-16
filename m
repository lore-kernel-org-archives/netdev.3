Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8624C2265
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577764; cv=none; b=dsYYN+5sA72/Bbw6KPucN4APBM0jhhUOX6CiVhyAYZGNB6QWzwwYgSWd5yKXInVS4vBLVSAXFitwNle4csnSZThMF0i85wtrvI8hZSVbHoocntuxDtpmPN7DmrxrcpK0OEqCFSpx2N96IjnPInmJ8c6+BK0ErKZ4lWCELoSQl/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577764; c=relaxed/simple;
	bh=z4SqPirq3/thTDZQPpgxjFyVh7R2/dC52uid11RI1f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z8X4vnVr6gIKFAo27JxpSkRtxlSDWZIkAALX2N+oN4kBwXlqtNSEeIjI9JIvfW3Il7UHgHrFgfUDGeDlgpYcZ/GeY5PdtC4eWLlIBZXe/0ciG5G//WgvL8u6JnExFvMcCh0aj+C8qu4/YgyXZnn+fnyWLGrihtKM6hw/uZ4EnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALRmXGGY; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALRmXGGY"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so4939424a91.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789577746; x=1790182546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWhZ/12YRa61Im8pdGuRvfUsDHPeWGyETjtUKvyBLuw=;
        b=ALRmXGGYHbvEK2GiU+uwhJbsl9BFpW0J9ChlM0HOoQEFwdOlclLXLScjuVrYQcfnmg
         kqH53dqpVd/Sap245AYgTj6XunfujVeTYs7oiWNDalREHTKDZxIclrVZ8+0sagjuhx79
         vDBg2fWJS2vpIrgw7n2y1uj6qRRxTRsgOtuc514fikqaS6Eol94vPvrzOYsoXOBWdB3e
         4moxqNMbWsMFeG6nv3kEYfqMFRms7TCPKamMi6SqyX4NifuJVk4TNarlUfFzLyCXvuO1
         Kjc1LYSJ2FRxGTghgr/BF/UVH4nk/zv08BKL+jm/QvrSdWO8GwAwG60ePU7V7oc4tPIV
         s4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577746; x=1790182546;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWhZ/12YRa61Im8pdGuRvfUsDHPeWGyETjtUKvyBLuw=;
        b=EZ4l04yqBSieAjJOyb+Cy1Gm2/AMoW3oHxGvLArwxiIdNKfCr7Q3uNM3F4GokBU5c5
         IrHGx/zbsHXWCV/mtNsul/wcfgN6b4N5p9EiueGjWhO9Cc0NXZ9n8hustZa8DB7QTo45
         LO2poLogtHWVkNIcTUH7l396b9lI2n98qNRuWl61iq4qVsfKC1O4rRrt1yYmQ3jemNKQ
         OiOpJOkGoxCTEDV4IlPaVgObaqlj4eQw/Wd9wMAW/sx9Asr2HgsalE03QGphDB8mkkWV
         tjhrwjxWkrx2nSVuiPVz3G40vHKHo46Ml7R4xfw8birip0OdOPf0t+mhWG7kaCBvd3c/
         Lz/A==
X-Gm-Message-State: AFuF++mKtUTmYeVCmIUy+VLBBMHKnFFxftptpf0lnfrcGNSUgqCOt+Ow
	6SfignLNVklITtw6Fv8ljP2BCE3aJ4i16I42PoP3mxDe3Zx1w9XzpoAG+rxANgR127uP6Md53iS
	5BwNhW1zqND5QFuWi+jotflCccSt9HR2Ox3ALzsL40yUjE3JybpOtaYU97VG7iEO4PGk/YCe9XG
	pJMHGBzwPbbWMo7vhV3S/7VxaNpH5WQZq6QjgtmniDbclDMFiCsx4HFxyep/JBcH0=
X-Received: from pjni12.prod.google.com ([2002:a17:90a:838c:b0:39d:e6b1:6c0c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:46:b0:39e:35a0:9c0f with SMTP id 98e67ed59e1d1-39e35a0a211mr877977a91.14.1789577744326;
 Wed, 16 Sep 2026 09:55:44 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:55:28 +0000
In-Reply-To: <20260916165533.2187434-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916165533.2187434-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916165533.2187434-8-hramamurthy@google.com>
Subject: [PATCH net-next v7 07/12] gve: add gve_ctrl_ops for gve
 initialization/teardown sequences
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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 12 ++++++++++
 drivers/net/ethernet/google/gve/gve_adminq.c |  7 +++---
 drivers/net/ethernet/google/gve/gve_adminq.h |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c   | 24 +++++++++++++++-----
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 026d685ecaee..e0583e8cd2cd 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -833,12 +833,24 @@ struct gve_device_info {
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
index 901673d2e264..1176e13fafc0 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1329,8 +1329,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 	return gve_adminq_execute_cmd(priv, &cmd);
 }
 
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut)
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv)
 {
 	struct gve_ptype_map *ptype_map;
 	union gve_adminq_command cmd;
@@ -1356,9 +1355,9 @@ int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 
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
index fe1e8868cdfe..5e51c060e237 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -652,8 +652,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 			     dma_addr_t nic_ts_report_addr);
 
 struct gve_ptype_lut;
-int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
-				 struct gve_ptype_lut *ptype_lut);
+int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv);
 int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv);
 void gve_adminq_set_num_queues(struct gve_priv *priv);
 int gve_adminq_map_db_bar(struct gve_priv *priv);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 82bf2c5fed3f..8cd82d92d3b0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -653,7 +653,8 @@ static int gve_alloc_control_plane_resources(struct gve_priv *priv)
 
 static int gve_setup_control_plane_resources(struct gve_priv *priv)
 {
-	int err = 0;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+	int err;
 
 	err = gve_adminq_configure_device_resources(priv,
 						    priv->counter_array_bus,
@@ -668,7 +669,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
 	}
 
 	if (!gve_is_gqi(priv)) {
-		err = gve_adminq_get_ptype_map_dqo(priv, priv->ptype_lut_dqo);
+		err = ops->get_ptype_map(priv);
 		if (err) {
 			dev_err(&priv->pdev->dev,
 				"Failed to get ptype map: err=%d\n", err);
@@ -690,12 +691,13 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
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
 
@@ -719,6 +721,7 @@ static int gve_setup_control_plane_resources(struct gve_priv *priv)
  */
 static void gve_teardown_control_plane_resources(struct gve_priv *priv)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	int err;
 
 	/* Tell device its resources are being freed */
@@ -728,11 +731,13 @@ static void gve_teardown_control_plane_resources(struct gve_priv *priv)
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
@@ -1827,6 +1832,7 @@ static int gve_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 
 int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 {
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	struct gve_rss_config *rss_config = &priv->rss_config;
 	struct ethtool_rxfh_param rxfh = {0};
 	u16 i;
@@ -1842,15 +1848,17 @@ int gve_init_rss_config(struct gve_priv *priv, u16 num_queues)
 
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
@@ -2489,6 +2497,10 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
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
2.55.0.1032.g73a4cd73de-goog

