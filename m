Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C73C416B;
	Sat, 29 Aug 2026 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788019046; cv=none; b=G8MOL+0JKXInxdpNYzH3ICY1DuI3ppQuB0pCFGcv6PBQfCc3gdNB0PIR677SxeO9IKcH4Mhf0LVZTkylpRxBBwEnfpmqrwfWIroHqR6I59djf+nbk2ORPXdIFoccITbpq5fwqdSMbCgxjgO/flo5aAZmBQ9dlQSn9sum+bIXThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788019046; c=relaxed/simple;
	bh=fk6soj2kgif1rUwUP76eTosUgLLLhPsTxnPqnlfGzfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KydbVDyxpjGe7NrtrIfAywW7P+mkIvMvP2XgL0Kx6f9zgTIv4ikbftKXMCPgEEiG27FpBsA9c4SsjNtlQdreAy4fVaPYflQQ1GmrIWEcK7XsQHOp9l4INW6aDwoKb0enbrtygANivCuK3lNKJt17+HHOrCxiDwx91Lb1x7Iagkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=DuvbTWPE; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=+z7FPinG; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="DuvbTWPE";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="+z7FPinG"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788019011; bh=889FD8uT+5VIJCvWbwHe9z0
	bvZ7anIjBiHhlW1DiVOc=; b=DuvbTWPEV5tTBz8Z/DK64F3Z5MI2lki+SrKBNqBIK9DOw1PwIb
	xC6YGmkvDFxDY5QdBihd9lHor6LmbhluCB/yIPy9NB4z5BT5tYbrR6Gh8KvQ596NBhzvoUc65yo
	2FJPYoMx9cTS5Fpgf7fiZpEsA7rq6V0nGtg9yYMAT/t+EAV5PnTV6bQ5Q7x/PYYOiS6bGffKAW3
	RxDzffSATPVHauHQlgdbsr0r9fYjgjpvdIL3nFHg0QgUD5lj92Ps4lbdR/dG1ZpKdnKNJsmXxC7
	YOxv9UtQS/g3R3bU5s+mPsgf7qKImIPNZciyr+R2CzsEtcsZ0dp2r5zyhIY+F9WbSZA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788019011; bh=889FD8uT+5VIJCvWbwHe9z0
	bvZ7anIjBiHhlW1DiVOc=; b=+z7FPinG98FgpqeLj0iG/HjgFkoMJjJN48kdBRelouU6RaUrhH
	7L/SyQVIb7omsVTsx4PbnbPbABzj+QdaWZAA==;
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
Date: Sat, 29 Aug 2026 15:56:52 +0000
Message-ID: <20260829155652.4438-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
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

