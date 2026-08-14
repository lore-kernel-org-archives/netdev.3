Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A573D6CBA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673674; cv=none; b=QMfsF2y11Ne+AhH2EMnIXn3B5saqCt37VcKbIoA5tOwF0rwTK3Xy480hCngtHTZFdgryza+Xsp+8Ri1k9h0jno1RNtUrF2LJRRSGgpNupOw55ospuWwBdnXZvhEqVIVJwKsTrgkY495iV9aDWH7N7JHdNxLuS6gjjRhZNz2e9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673674; c=relaxed/simple;
	bh=+m2UeT9LyGMFFRpz7I9eZ2RZNUM5QxKXV8kZOd8zm8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FMwypC6u13RLIqvJPsq3m7YVqS+EoOLqsJaBzxNEVz0yFY7W/BtUjO1VKYkB7kR7GaGbTAVkv5B4/TVykAhNjq5SiMajQuTwrEBOYQF0XOWBh9azmaYyhZIN8XOSg1bum9eofjtMVxvHVXCYjnz11yC7Pc9+N+UM1AMDDEPSX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5FVKSMW; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5FVKSMW"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc5faecf01so11084015ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786673665; x=1787278465; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPOjyBQRGCczAdWZmxygXUpPv0szQHv9gt92kjdg6Go=;
        b=G5FVKSMW35d3lWmJd7nMB2doKEeeFBQrWnf1VdouUwqJTIdaonASeZbunh0gUs0YaC
         Yq/I4kTjMJkAKtqlrI+7+x28vJpwDpmpG53r/WihyugLK6DSUpoQKf88RgQtju2P7451
         fFQcS+mOumD+0jr0ElDjegWrqg5Tdol6xqEOOZvA72VUmjSOvMBub3fOfkHR0e2hw//K
         /zplbL6yMFCEB6iUCXEzo02W64bM0+fVOhEB8Uwy5n5A1lpQ9/DHsELxxYfOymQXC1bD
         RzycPGLT+ylD5o+e0qPlP6zy7aQ4W8bOR5fNXEH1hizchjfwbQynAmgUTQyhXQzD7HKQ
         YruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786673665; x=1787278465;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jPOjyBQRGCczAdWZmxygXUpPv0szQHv9gt92kjdg6Go=;
        b=HQZS6O0HXgfONN5cQ4QPKMPoNBW4cyTqpYF7uYglDaeBACKiFpboI7FSnSVI8eK69r
         D1cRy2wbsEEdImxow9za+VaKc8vrQkhvNDf4yJsaCFXyLOXya7FerPIazQMi9GHKLsp4
         Eme739zvlmEQnXPZhFTELczVBZQLTy7w5F2ppE7UjojUUTPWRyIQyPoZxZJUXlA+5Ebz
         T08Y/mKJWneJX3DDshsqtgHijm8Gpi0XbhImrj3lE+nRWsEunpBHNlCqupeV8Cd0739u
         M107RhB1ttEM3fwUhXH6aHvnvYZsXDtHbI3p4CdHSPfXepL7eUZy6qfv/Kb+sPcyBHZu
         ZLQw==
X-Gm-Message-State: AOJu0Yy+Piy3ksUv+J/0nlkyiprDXQ58Rm5WlS1J4liCbmPm9UR4J61g
	lNZ5MgaXljGMBc0qlHDbBrek3ZGpshOXOnzmG1VzqL1IWhV39tD29uB5GNOSiyXAWe+sbK989/C
	4gBTqVFqjjAOH/nRfyySIrgtAArBTXBdx/n7AEWnj2GuEkmxs86teSlIRGILoguADub9y424KR9
	w4hWMcYyeGGg5XzSeBDKVN1ZFwM4gXZR1LmZ4CAiFHycHT5l7P1o6sZy1a+t4hNhw=
X-Received: from plko11.prod.google.com ([2002:a17:902:6b0b:b0:2ca:d820:b697])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d552:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2d3b0d2c159mr30818095ad.23.1786673654855;
 Thu, 13 Aug 2026 19:14:14 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:13:56 +0000
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814021406.3044324-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814021406.3044324-7-hramamurthy@google.com>
Subject: [PATCH net-next v4 06/15] gve: introduce ctrl ops to set vectors and Qs
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

Introduce following ctrl ops for Adminq mode.

- set_num_queues to set maximum and default TX/RX queues in the
  alloc structures used in the initialization flow.
- set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
  initialization flow.

This is done by attaching the adminq_ prefix to the existing
functions placed in the gve_adminq.c file.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
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
index fc5482215588..d0b7ce8ff4c5 100644
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
 	priv->tx_cfg.max_queues =
 		min_t(int, priv->tx_cfg.max_queues, priv->num_ntfy_blks / 2);
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
index 27da5e1284ce..37eed00c4ed1 100644
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
2.55.0.691.gc56d675ccc-goog

