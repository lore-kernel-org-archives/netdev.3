Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF43433E80
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782798; cv=none; b=m8Miw/ojpzjtJRFe1VlDeK8lMBeS3F+thK7ODnPgx5R09LxbwUPAZ2TpB2I9/4hhODc1+zADR7/JUobd7Du2p0NwCP3X+Q718K9VhOnhVr3IlialTlf4jSueGqohOgs+/VBuoY6rSzJjuYOzNCpVmaH4MN7VIBXART96R2eG0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782798; c=relaxed/simple;
	bh=jbKjjaCQnP0pxgEOJNcMtgqJV0Fdpyc3gfnnGlCv9f8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MgMBwzf6/B0LytmS7pIJyVQFPxBpbzZ4RdR446QSDOyKE/gaxEpoMQ+gjSK7gk+yJQxepKXzeic9WtV2tDb5FmOf9Unb34OwdzyBi5W6a0fQXqviErFTVdxzQa+Xn54S61xusboLQy+yBEO3CbkDkvWCSesabu9+t0JObrr0elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5SaQxpr; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5SaQxpr"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848568a6f62so7403316b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782795; x=1786387595; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6Z+knL/Vym2bTZhQ2MmdO9vfyLJl3tvT3HruMB1kzI=;
        b=U5SaQxprx/KdX/tWRxWAhG/g0NPAQqxAT7nes3ZnEUHNHBEH/b6J58U7O2KmxZcVAE
         FYSJfUUIKSxZFPUnOKUMxEQ92S97XS15+Bple/oESxt9fxCPa98n7hBAq/gLCppPA7O8
         S9Qb0A1V0/1/BZVPymdZTaXxuB5btfUFz1+JHTAhgdWJt4Gsel05ogWtycPm5KQHA8FI
         H7AoxFOCgg7cKHZIC4nA5WPC4ZWzl73j3fVSV2Ut/Iik8mOTQLo6z0a8njZ+6gVfljGK
         eBmfrk89O/5dVue0wTWz+y57UIiWZx5p7NYMStQnzxFbY261cCrltq1Gmkx9YVALVBTQ
         h9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782795; x=1786387595;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6Z+knL/Vym2bTZhQ2MmdO9vfyLJl3tvT3HruMB1kzI=;
        b=kkZN5bTcEY9LC1rL8C838kUkyoTNfDkrPaxoN2vIXoMwWtb2LoLL4UQW7/u0YRSjOQ
         cVIYLwbIlSDRTNMyVxehNynrftWWx3fUYYB0VpJ8y07v/IG7RDncKH0lyYLPxDEsU0cv
         bu6T6GGbH/y12T/Z0WBTNZbmPkZZVAydAsFqECLiAnIB0Qz0B+6y1Spoh5BSGMTh6ESr
         CXN0lU2XwLmc5mfRVKmuU7XFaUBgRl7ptJXRCPIwJO7epqa45o8q61HBkqb6MeAR6Qf3
         +g697gFOXeHMeOjDshC+ElsP0jyzW0R+6+je20hKv77JeiqkGHIIjR6HNm4YLJO/Rb4Y
         dMYw==
X-Gm-Message-State: AOJu0YwDX0qCaGaDNMLy2x12/n3Y1oF854XmqKQgrKDx/MtEDd35UWw/
	QF9uIJIDU3dvE9YzcEAYY5osCyyVb06be+v++6nw1GYBu0QG9tDKYQtVKKCtpmvsrEfSlqdFlGs
	pVY4y8x/I/N1lUJKBJS3vGK/ZaPr6JwGhiDBzgfG2BsGvaTLl15JGB5YfgUvWwYsamc3smNQ6z8
	D39xUsxW/IfAd6WutZPMABPg/1guNuM0CmLCt+L+aIC8aPXGkwLimOG81Vbw1mJD8=
X-Received: from pfbbx16.prod.google.com ([2002:a05:6a00:4290:b0:847:9199:e06])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fca:b0:848:2f6e:e532 with SMTP id d2e1a72fcca58-84ee48fb3f5mr9012046b3a.70.1785782794280;
 Mon, 03 Aug 2026 11:46:34 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:17 +0000
In-Reply-To: <20260803184630.3813311-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803184630.3813311-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-3-hramamurthy@google.com>
Subject: [PATCH net-next v3 02/15] gve: refactor initialization with helper functions
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

In the interest of commonizing code, refactor gve_probe()
and gve_init_priv() with a few helper functions that can
be expanded and utilized in upcoming patches that add the
mailbox ABI to the driver. The helper functions are:

- gve_set_num_ntfy_blks()
- gve_set_num_queues()

Reorder code to combine lines that accomplish a similar objective
like setting defaults. Move setting HW-GRO and UDP GSO support out
of an Adminq method into gve_init_priv().

These changes are just code movement, no functional change.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v3:
- ensure to call verify driver compatibility in reset path

 drivers/net/ethernet/google/gve/gve_adminq.c |   8 --
 drivers/net/ethernet/google/gve/gve_main.c   | 104 +++++++++++--------
 2 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 70ffed8b52c3..dfeabddfb396 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1117,14 +1117,6 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports HW-GRO and UDP_GSO */
-	if (gve_is_dqo(priv)) {
-		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
-
-		priv->dev->hw_features |= additional_features;
-		priv->dev->features |= additional_features;
-	}
-
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
 	mtu = be16_to_cpu(descriptor->mtu);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 30bf6df4ebc5..6510aea62b92 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2398,9 +2398,54 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
 };
 
-static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+static int gve_set_num_ntfy_blks(struct gve_priv *priv)
 {
 	int num_ntfy;
+
+	num_ntfy = pci_msix_vec_count(priv->pdev);
+	if (num_ntfy <= 0) {
+		dev_err(&priv->pdev->dev,
+			"could not count MSI-x vectors: err=%d\n", num_ntfy);
+		return num_ntfy;
+	} else if (num_ntfy < GVE_MIN_MSIX) {
+		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
+			GVE_MIN_MSIX, num_ntfy);
+		return -EINVAL;
+	}
+
+	/* gvnic has one Notification Block per MSI-x vector, except for the
+	 * management vector
+	 */
+	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
+	priv->mgmt_msix_idx = priv->num_ntfy_blks;
+
+	return 0;
+}
+
+static void gve_set_num_queues(struct gve_priv *priv)
+{
+	priv->tx_cfg.max_queues =
+		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	priv->rx_cfg.max_queues =
+		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+
+	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
+	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
+	if (priv->default_num_queues > 0) {
+		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
+						priv->tx_cfg.num_queues);
+		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
+						priv->rx_cfg.num_queues);
+	}
+
+	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
+		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
+	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
+		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
+}
+
+static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
+{
 	int err;
 
 	/* Set up the adminq */
@@ -2431,57 +2476,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 			"Could not get device information: err=%d\n", err);
 		goto err;
 	}
-	priv->dev->mtu = priv->dev->max_mtu;
-	num_ntfy = pci_msix_vec_count(priv->pdev);
-	if (num_ntfy <= 0) {
+
+	err = gve_set_num_ntfy_blks(priv);
+	if (err) {
 		dev_err(&priv->pdev->dev,
-			"could not count MSI-x vectors: err=%d\n", num_ntfy);
-		err = num_ntfy;
-		goto err;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		err = -EINVAL;
+			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
 	}
 
-	/* Big TCP is only supported on DQO */
-	if (!gve_is_gqi(priv))
-		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
-
-	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
-	/* gvnic has one Notification Block per MSI-x vector, except for the
-	 * management vector
-	 */
-	priv->num_ntfy_blks = (num_ntfy - 1) & ~0x1;
-	priv->mgmt_msix_idx = priv->num_ntfy_blks;
-	priv->numa_node = dev_to_node(&priv->pdev->dev);
-
-	priv->tx_cfg.max_queues =
-		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
-	priv->rx_cfg.max_queues =
-		min_t(int, priv->rx_cfg.max_queues, priv->num_ntfy_blks / 2);
+	gve_set_num_queues(priv);
 
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (priv->default_num_queues > 0) {
-		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->tx_cfg.num_queues);
-		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->rx_cfg.num_queues);
-	}
-	priv->tx_cfg.num_xdp_queues = 0;
+	if (gve_is_dqo(priv)) {
+		/* DQO supports HW-GRO and UDP_GSO */
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
 
-	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
-		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
-	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
-		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
 
-	if (!gve_is_gqi(priv)) {
 		priv->tx_coalesce_usecs = GVE_TX_IRQ_RATELIMIT_US_DQO;
 		priv->rx_coalesce_usecs = GVE_RX_IRQ_RATELIMIT_US_DQO;
+
+		/* Big TCP is only supported on DQO */
+		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 	}
 
+	priv->dev->mtu = priv->dev->max_mtu;
+	priv->numa_node = dev_to_node(&priv->pdev->dev);
+	priv->tx_cfg.num_xdp_queues = 0;
+	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
 	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
 	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
 
-- 
2.55.0.571.g244d577d93-goog

