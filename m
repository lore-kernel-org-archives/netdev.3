Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC756405C3F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795086; cv=none; b=GKOifkGBOHm8rlJiOHHquM+90T+SN0v5MCfGxLacq2gyfftjVxc9jgBJ+u6iuJ06Iir+bmbRAFFgF3qd3NTza8rAOezE/gPwkWJ8vU//0GO9uBkun74GMxi2jxrI/WwiDk6/xeJVwWAoXYOkoQxJlG2ZrBH/jJh3u65A7QMd2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795086; c=relaxed/simple;
	bh=sFQz9Q64Ku1Km/hZ9hKAmDh96BDgibiVpT9WaFOtEWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7Or0i0fBw+VHR72tYdHa2NmZuxPkCiuHn2gF5OUMEsPg6Zi5OV67NhcGLbmDnDhTl++DeTFQ9vNSAiG2VFYKyBgoHtiHeO+LfpRL3N/Eh6m9SuuE7r/jM1lzm6Gs0JSDEm4PHi0sDtT64ijW6c6lj/gQhlU0rTSuGgE7rh5Bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9kHTD76; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9kHTD76"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f75c1219so72320545ad.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795082; x=1791399882; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQvY7ZVGbz9JqrTCAAGcztuWudN5nxqHIUV76zoUX2U=;
        b=R9kHTD76kqVr8DJbysA8WbDjdgWeOCHTB6ZNQ8fH1T79zCiDzNGAY1y89IkMdSggp1
         8M0sHsU4Zs44ouwbVAxoDjdElDSOAqGox4iKFWFYfCNCoTwIv+rwCg85jsl92/d4SZuH
         Pc7JO3Y6sQN3eLV3gehq+lGVS18lyCQm/sgVw2QfDV84yi4B5931X6DW2sfiytEZhhE+
         fV89uM23uLDuPo2UPQc3FoHoPJxAg3rUpimhYE0s7lbe/Gdw3g1vwC6TR+eRuraG0lB4
         bggCUoiM3UuF30whpEPxk2Hk9S6b+tZr1A7osGi/ogxeh+wd1IqlEHFg8gsCpvqfeb6D
         aZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795082; x=1791399882;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQvY7ZVGbz9JqrTCAAGcztuWudN5nxqHIUV76zoUX2U=;
        b=YJ7uVRS6CTU1V61+SAGsPEp/LlM+qEYuhm/VvFIpwOTwq0r2P60Zm81GCMEBA8KLSi
         mIZpG4c56TMkaaFA38pAqMCp/uF8ZzX1MNKu1NibJAiJutoIfHRxo9rXLXtHFKSfkHN5
         dIEthcuEvVZI3pLae8E3eY14hNRVp3dC4mZYqP64GnXzYD8nLRs9DxznNtj+VoA/p4CC
         qkkulx2fBdN0tjhiep0Hb+FhJAB/W6bt+gvKaCK8HRfr+RDfOubzFHzOD8zcljzi0eLl
         1YNcrNNDpiyGqP/UUPD4gTjqnH8JF0XaI28cYFEjlcLxRedHCgJNxZ2ZFmfxxdn0pxnI
         Xi1w==
X-Gm-Message-State: AFq9FYKbk94gXqUegq4X0rIKqFsM2JOTW/y0eHfBztpy3cckzH4mvLdi
	n/QqOEJ9RbRb9LltzSGCligOkHyWB4S6zdmsETut2kyPUs65OslUyE76V4tam7qn//E1aplowLT
	xGKsuTKrn3h6WLfACvUQise0y+ZCnF2UIuJR452XfGiHVUoDkRfaE48i0gTt+hjPyQahy9W0Us2
	NTvdk31ZI1cNcN4buL97ctnEdT0Gw+Su2xJF03Ahayy8SwPPSDIbWfV2bl3k6246Q=
X-Received: from plbg20.prod.google.com ([2002:a17:902:d1d4:b0:2e2:c744:19dc])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b08:b0:2df:9230:9916 with SMTP id d9443c01a7336-2e2e4b51d71mr18702205ad.36.1790795081532;
 Wed, 30 Sep 2026 12:04:41 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:04:28 +0000
In-Reply-To: <20260930190428.1130007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930190428.1130007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930190428.1130007-13-hramamurthy@google.com>
Subject: [PATCH net-next v9 12/12] gve: add link status/speed ctrl ops
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

Refactor link status check to use a control plane op. Introduce
new op for retrieving the link status in AQ mode. This op reads
the link status from the device status register and stores the
value in priv.

Also add an op for retrieving link speed in AQ mode which calls into
gve_adminq_report_link_speed.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v3:
  - Fix kdoc typo ("set link status" -> "set link speed")
  - Copy link status into local variable instead of reading twice to
    prevent TOCTOU issue

 drivers/net/ethernet/google/gve/gve.h         |  5 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  | 10 +++++++
 drivers/net/ethernet/google/gve/gve_adminq.h  |  1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  3 +--
 drivers/net/ethernet/google/gve/gve_main.c    | 26 ++++++++++++-------
 5 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 00966b6a730f..b7ce6e8632db 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -845,6 +845,8 @@ struct gve_device_info {
  * @reset_flow_rules: Flush all flow rules from device
  * @create_queues: Sends commands to the device to create TX/RX queues.
  * @destroy_queues: Sends commands to the device to destroy TX/RX queues.
+ * @report_link_status: Set link status into @priv->link_up
+ * @report_link_speed: Set link speed into @priv->link_speed
  */
 struct gve_ctrl_ops {
 	int (*map_db_bar)(struct gve_priv *priv);
@@ -865,6 +867,8 @@ struct gve_ctrl_ops {
 	int (*reset_flow_rules)(struct gve_priv *priv);
 	int (*create_queues)(struct gve_priv *priv);
 	int (*destroy_queues)(struct gve_priv *priv);
+	int (*report_link_status)(struct gve_priv *priv);
+	int (*report_link_speed)(struct gve_priv *priv);
 };
 
 struct gve_priv {
@@ -966,6 +970,7 @@ struct gve_priv {
 
 	/* Gvnic device link speed from hypervisor. */
 	u64 link_speed;
+	bool link_up;
 	bool up_before_suspend; /* True if dev was up before suspend */
 
 	bool mgmt_irq_requested;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 54f235ea27c1..8b215fca9c1b 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1837,3 +1837,13 @@ int gve_adminq_create_queues(struct gve_priv *priv)
 
 	return err;
 }
+
+int gve_adminq_report_link_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	status = ioread32be(&priv->reg_bar0->device_status);
+	WRITE_ONCE(priv->link_up,
+		   !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status));
+	return 0;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index d696e4932a8b..8daac5fd685a 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -643,6 +643,7 @@ int gve_adminq_report_stats(struct gve_priv *priv, u64 stats_report_len,
 			    dma_addr_t stats_report_addr, u64 interval);
 int gve_adminq_verify_driver_compatibility(struct gve_priv *priv);
 int gve_adminq_get_device_properties(struct gve_priv *priv);
+int gve_adminq_report_link_status(struct gve_priv *priv);
 int gve_adminq_report_link_speed(struct gve_priv *priv);
 int gve_adminq_add_flow_rule(struct gve_priv *priv, struct gve_adminq_flow_rule *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index dd1c44fedc77..a3220c651438 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device *netdev,
 	int err = 0;
 
 	if (priv->link_speed == 0)
-		err = gve_adminq_report_link_speed(priv);
+		err = priv->ctrl_ops->report_link_speed(priv);
 
 	cmd->base.speed = priv->link_speed;
 
 	cmd->base.duplex = DUPLEX_FULL;
-
 	return err;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8d628c419972..0b84ae4ef7ad 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1509,15 +1509,18 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+static void gve_handle_link_status(struct gve_priv *priv)
 {
+	bool link_up;
+
 	if (!gve_get_napi_enabled(priv))
 		return;
 
-	if (link_status == netif_carrier_ok(priv->dev))
+	link_up = READ_ONCE(priv->link_up);
+	if (link_up == netif_carrier_ok(priv->dev))
 		return;
 
-	if (link_status) {
+	if (link_up) {
 		netdev_info(priv->dev, "Device link is up.\n");
 		netif_carrier_on(priv->dev);
 	} else {
@@ -1544,7 +1547,6 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 {
 	struct bpf_prog *old_prog;
 	int err = 0;
-	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
 	if (!netif_running(priv->dev)) {
@@ -1571,8 +1573,8 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 out:
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	priv->ctrl_ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 	return err;
 }
 
@@ -2003,11 +2005,11 @@ static void gve_turnup(struct gve_priv *priv)
 
 static void gve_turnup_and_check_status(struct gve_priv *priv)
 {
-	u32 status;
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 
 	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 }
 
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
@@ -2335,12 +2337,14 @@ static void gve_service_task(struct work_struct *work)
 {
 	struct gve_priv *priv = container_of(work, struct gve_priv,
 					     service_task);
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
 	u32 status = ioread32be(&priv->reg_bar0->device_status);
 
 	gve_handle_status(priv, status);
 
 	gve_handle_reset(priv);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
 }
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)
@@ -2467,6 +2471,8 @@ static const struct gve_ctrl_ops gve_adminq_ops = {
 	.teardown_mgmt_irq	= gve_adminq_teardown_mgmt_irq,
 	.create_queues		= gve_adminq_create_queues,
 	.destroy_queues		= gve_adminq_destroy_queues,
+	.report_link_status	= gve_adminq_report_link_status,
+	.report_link_speed	= gve_adminq_report_link_speed,
 };
 
 static int gve_init_priv(struct gve_priv *priv)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

