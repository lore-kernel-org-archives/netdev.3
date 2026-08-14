Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E33D6CA5
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673652; cv=none; b=Goc5oZ9rH1wMEIcAtDTne9W1aYl9iEw3pn+71SDd+mlqZh/zHRg9GpK/ZicZbZmsmCBqwB6LoyJQtt3pxqHx57hzR5WgXdnhPehfGKwaKjZBsFE+6rrVVDZENLSgNlVDJ8uXo39kCfOQvYirMr4gdSUlRNsKvD29aAByudcyyIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673652; c=relaxed/simple;
	bh=fR1+yOn1X/Oxt6Op0vFhWWNj9Hn06o6mXazJgaV86tI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZcno0Rm5WRGcyHcQ4KJTh9jBpvCwtfzjjHVYdTdBauRILDT2WoVTWIe0Z4oL2RpAi+FjY2p8otcvKJj1k7rYrpoTFoANJMAKhrabmTS1bHamihzV8He4cmUkjIiqIMrAAjY/QE/vhjsrNw8VkZWtJpAoKCwsglP+cAy9UuuNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STM93Zzy; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STM93Zzy"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbef1d25500so379894a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673650; x=1787278450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mmSqbuVweBWGbqmxEm8QoJgEKbkKxRiioKgLKo7m1I=;
        b=STM93ZzynYOy9kE/FmX+DLLdMCTJQFsfNK9ywWqCgaixtSthbxOklmiS54EaZDjxVY
         gsC0JKHdSSaDyR+RnY2QvBRgfH6hNXaJLvg/IZxxiLW6rQ2TH61DHB8rIlhRWvozOpsP
         ZhVSofWC/CkeI54g9gwzGJnNBXm9Mo9PC3urQjBZLLD62iXC75bAr0LdPj8btU9bEUrM
         JPvLrI3z4ecLEUV37jcYoRXmE8sRWfwiGPjiBHj/7c1E4UpxOTnr4dQqmKC2atImqxrH
         qVMzCicYqqx3ZWBBGUKJjmyg8OCwtwyPSzl8cWo8yPB3zNGlJ0Zz+nQ54eRYDxp3lvZ4
         753A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673650; x=1787278450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mmSqbuVweBWGbqmxEm8QoJgEKbkKxRiioKgLKo7m1I=;
        b=aijVnvvItOnKOovkjOwT7uVOnAp6E9DNBFpsiJAuGo1ws8NHpluDlkN/jx3vScC5om
         C9Oc9hlXeeXFlmgl1OcBLu/FSe8uoGL8jiPmlyjvMCQ8+7giIWHHnyFABRNq/fDMRtbR
         tIoYQnsyMTehWzwyeoI+GnxGhFDalB0sY2mABLYewh+N3E3VYSsI5zbOD2XkCRMab8TB
         xh7okA0ifTKKVj9K7b6xh+a+O6TLnZgnBeP29hkpMtyB2D1bAfasi3lWKFJ3Aghpqth3
         KERZsDO9aSQ1jHmtPJ8oKmo67TKUg+Oj3hAc5c+WOlTNbxbP8PbSnJlucqBL17hydti1
         rZ/w==
X-Gm-Message-State: AOJu0YxSuIqbNUTcLU8NubVP8zNJgme5B9Uw0ztAJ+qX+SgHTIemI5DF
	OJNdMcTVRRIneslOdhx+GdLNnBffXWihaucqNSQEfUyHQ5mBkk6oldaxXiJhbzi27i1aVOGQabE
	EYWqraLELMvRQDq8cYcRvmpV0tRjk2DnXfvScC/fmVuVluQORNGJ1OQFBYRXh1U868DVgUlBr5o
	4+3ony2Q/sHwNXOh/+ofibpWkTZ7WInyUkO/yb4VSIoxBkFGAqBJrm6vNBeEKd+ig=
X-Received: from pgmu38.prod.google.com ([2002:a63:2366:0:b0:c99:90dc:7b3f])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:2289:b0:3cb:e8b4:f03b with SMTP id adf61e73a8af0-3cc71ca5ad5mr2577505637.17.1786673649389;
 Thu, 13 Aug 2026 19:14:09 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:52 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-3-hramamurthy@google.com>
Subject: [PATCH net-next v4 02/15] gve: refactor initialization with helper functions
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
v4:
- move the new functions to gve_adminq.c since that will be their final
  home in the following patches (Przemek Kitszel)
v2:
- ensure to call verify driver compatibility in reset path

 drivers/net/ethernet/google/gve/gve_adminq.c | 49 ++++++++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
 drivers/net/ethernet/google/gve/gve_main.c   | 58 +++++++-------------
 3 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 70ffed8b52c3..fe0dedfb25d7 100644
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
@@ -1600,3 +1592,44 @@ int gve_adminq_query_rss_config(struct gve_priv *priv, struct ethtool_rxfh_param
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
 	return err;
 }
+
+int gve_set_num_ntfy_blks(struct gve_priv *priv)
+{
+	int num_ntfy;
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
+void gve_set_num_queues(struct gve_priv *priv)
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
+}
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 8e80f36116ec..82b52424a63f 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -656,5 +656,7 @@ int gve_adminq_report_nic_ts(struct gve_priv *priv,
 struct gve_ptype_lut;
 int gve_adminq_get_ptype_map_dqo(struct gve_priv *priv,
 				 struct gve_ptype_lut *ptype_lut);
+int gve_set_num_ntfy_blks(struct gve_priv *priv);
+void gve_set_num_queues(struct gve_priv *priv);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 30bf6df4ebc5..37e6205e2eef 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2400,7 +2400,6 @@ static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
-	int num_ntfy;
 	int err;
 
 	/* Set up the adminq */
@@ -2431,57 +2430,38 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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
+			"Could not setup notify blocks: err=%d\n", err);
 		goto err;
-	} else if (num_ntfy < GVE_MIN_MSIX) {
-		dev_err(&priv->pdev->dev, "gve needs at least %d MSI-x vectors, but only has %d\n",
-			GVE_MIN_MSIX, num_ntfy);
-		err = -EINVAL;
-		goto err;
-	}
-
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
-
-	priv->tx_cfg.num_queues = priv->tx_cfg.max_queues;
-	priv->rx_cfg.num_queues = priv->rx_cfg.max_queues;
-	if (priv->default_num_queues > 0) {
-		priv->tx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->tx_cfg.num_queues);
-		priv->rx_cfg.num_queues = min_t(int, priv->default_num_queues,
-						priv->rx_cfg.num_queues);
 	}
-	priv->tx_cfg.num_xdp_queues = 0;
 
+	gve_set_num_queues(priv);
 	dev_info(&priv->pdev->dev, "TX queues %d, RX queues %d\n",
 		 priv->tx_cfg.num_queues, priv->rx_cfg.num_queues);
 	dev_info(&priv->pdev->dev, "Max TX queues %d, Max RX queues %d\n",
 		 priv->tx_cfg.max_queues, priv->rx_cfg.max_queues);
 
-	if (!gve_is_gqi(priv)) {
+	if (gve_is_dqo(priv)) {
+		/* DQO supports HW-GRO and UDP_GSO */
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
+
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
+
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
2.55.0.691.gc56d675ccc-goog

