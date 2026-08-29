Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AB3BD65A;
	Sat, 29 Aug 2026 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020120; cv=none; b=USF0WBnCSS0gI9li4luKEeEP4DOHAFKNbR90qGYFbt21HxM826feVZEj3OmphMbWR0CWTcz7YyH58LC6UyWGDvEbmJNCOHQmsukoqoIuOrHy4Wv6/t7msxO6Pl8LPb2+Tj6y59wZzOVEmIITXR5CV/6BbHBnv5ux46v1OW3Gxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020120; c=relaxed/simple;
	bh=fk6soj2kgif1rUwUP76eTosUgLLLhPsTxnPqnlfGzfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqLzIG7Vr7Ef41VeoSXhMbY4PgQBcJ7hHnU/f/XPq49csmVJpE7TLh/9PULI8FnCoA/2d2+iP8QSuNiVcEEiusepJmcGC8bQR/YmRis/dDCXjc4vELhwavHjaI6uKY6hNAHoIgRUbG44FFP1FtNVP3Mo/+Zt2U6s4M3sps5VmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=oTH1iLLZ; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fyMVgo+8; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="oTH1iLLZ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fyMVgo+8"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788020101; bh=889FD8uT+5VIJCvWbwHe9z0
	bvZ7anIjBiHhlW1DiVOc=; b=oTH1iLLZELewgQmZmAOonXJ9x+J3asNkhrmYDzI/FgXc/8LVQb
	W/mE7C3GU8Y//XZnp/0RXma022TcUWO6gV88TXxXmcfW5sLkmBJoCRkAm9N8po7AS6yhYAwgbLm
	nJWw4EDc3fl300qIeGm8+vD1+5M3IWOpGB8E0/eglNn5tIVCIHlJ+w85jJJMeknRhN5Cy88jbas
	fGBe7DATniEe8UjUcj2I+YeXo1kc3n9xbr4H0C2vf73un/CR2ACMA+CmL7m/7Gj2sKE9NnuL1B0
	2Biuh7mIUgT4msokSVSaLQnxXlZRyJnGVc5zYvpx+TIKv5bdezFhjW5L7YFuFZyEr9g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788020101; bh=889FD8uT+5VIJCvWbwHe9z0
	bvZ7anIjBiHhlW1DiVOc=; b=fyMVgo+8fwOmHPYFGwurLk1arO1fhvi7JKVujC1dSPCiWZaujk
	ioFV3uB7bx41/X7LLO0vFCZZ3C0wJr3Cp0BA==;
From: Bradley Morgan <include@grrlz.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH 2/5] net: encx24j600: convert to kthread_run_worker
Date: Sat, 29 Aug 2026 16:15:02 +0000
Message-ID: <20260829161502.18418-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260829161150.16301-1-include@grrlz.net>
References: <20260829161150.16301-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

Embedding a kthread_worker and running kthread_worker_fn yourself is
the old way. Convert encx24j600 to kthread_run_worker(), dropping the
separate kworker_task pointer.

This is part of removing the worker->task self-assignment in
kthread_worker_fn().

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/net/ethernet/microchip/encx24j600.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index b011bf5c2305..460189064332 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -49,8 +49,7 @@ struct encx24j600_priv {
 	struct mutex              lock; /* device access lock */
 	struct encx24j600_context ctx;
 	struct sk_buff           *tx_skb;
-	struct task_struct       *kworker_task;
-	struct kthread_worker     kworker;
+	struct kthread_worker    *kworker;
 	struct kthread_work       tx_work;
 	struct kthread_work       setrx_work;
 	u16                       next_packet;
@@ -823,7 +822,7 @@ static void encx24j600_set_multicast_list(struct net_device *dev)
 	}
 
 	if (oldfilter != priv->rxfilter)
-		kthread_queue_work(&priv->kworker, &priv->setrx_work);
+		kthread_queue_work(priv->kworker, &priv->setrx_work);
 }
 
 static void encx24j600_hw_tx(struct encx24j600_priv *priv)
@@ -884,7 +883,7 @@ static netdev_tx_t encx24j600_tx(struct sk_buff *skb, struct net_device *dev)
 	/* Remember the skb for deferred processing */
 	priv->tx_skb = skb;
 
-	kthread_queue_work(&priv->kworker, &priv->tx_work);
+	kthread_queue_work(priv->kworker, &priv->tx_work);
 
 	return NETDEV_TX_OK;
 }
@@ -1046,15 +1045,12 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 	/* Initialize the device HW to the consistent state */
 	encx24j600_hw_init(priv);
 
-	kthread_init_worker(&priv->kworker);
 	kthread_init_work(&priv->tx_work, encx24j600_tx_proc);
 	kthread_init_work(&priv->setrx_work, encx24j600_setrx_proc);
 
-	priv->kworker_task = kthread_run(kthread_worker_fn, &priv->kworker,
-					 "encx24j600");
-
-	if (IS_ERR(priv->kworker_task)) {
-		ret = PTR_ERR(priv->kworker_task);
+	priv->kworker = kthread_run_worker(0, "encx24j600");
+	if (IS_ERR(priv->kworker)) {
+		ret = PTR_ERR(priv->kworker);
 		goto out_free;
 	}
 
@@ -1087,7 +1083,7 @@ static int encx24j600_spi_probe(struct spi_device *spi)
 out_unregister:
 	unregister_netdev(priv->ndev);
 out_stop:
-	kthread_stop(priv->kworker_task);
+	kthread_destroy_worker(priv->kworker);
 out_free:
 	free_netdev(ndev);
 
@@ -1100,7 +1096,7 @@ static void encx24j600_spi_remove(struct spi_device *spi)
 	struct encx24j600_priv *priv = dev_get_drvdata(&spi->dev);
 
 	unregister_netdev(priv->ndev);
-	kthread_stop(priv->kworker_task);
+	kthread_destroy_worker(priv->kworker);
 
 	free_netdev(priv->ndev);
 }
-- 
2.47.3

