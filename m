Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FC3BCD37
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791600941; cv=none; b=PORko7LueEOT3IaPTM0n74E+DR+sCI5jdnsPGT5DR22/WMvjd78Grk81CuTKGbuxrUMz4MI5gujV7OuFWo/g0BTBq0qsOhDBAh7a6PNQFR3qEGjVRyE7Rb1OzkXO9FJWBNwuqmZQWk0ZLLh3iJ4Vt3ZUVH83s6lPBwjIA7+jAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791600941; c=relaxed/simple;
	bh=j1TaTyk/OTL5zdMp08SYdA2Dlge6Yv09Zs+4VMdCb4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PSv6DT9nLbd2iHa8XRsHEQ2c19Eeuv/zSz62rpe31jcnQTGJaYgeILBMCXVudyiB0XnUE6zvZpox4s498eXcOJ5yayhPvVRw9LawCjG3KhhQpYNFV7YdvYX+qfoQYxoBKPlSHjvLUIOFttQIvChr5JDSFpgu5IzOO25D4hwshsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v5r3+EZh; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v5r3+EZh"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510d0baf63so1036574eec.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791600937; x=1792205737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnXvDkHRygIjqcgALHUWN066KUbjGPQJV9Mzd8woTCg=;
        b=v5r3+EZhy2NbxbsLo7UscqDc/GlsklNmUqAiWUa2REy/k5pA4mxIhHPE4icMxf9ZLh
         UQI1ZNAehjJCibFvwi4yDXE8XD4rFBo3kPfyOibe52lGPepUonBRefkcN3LoAN8bkZ1j
         SPAEqAWgvo9+jwatMULyUH9Cl6PTpZQYJkuGOC/rBKFHGEjOb3NH6bngTNVEMEwCFJc9
         BZI9PrTf2NTIAQYBKHaqgn9cnys2+CLsEQoSjkg4ddk2O5brQpMYwYXa8ywwLUXdexBk
         kqdW78H21/8kXwN8HwRUOvTxHJx6QXTGVusRA1bXwgBIGDWzVJH8pQKpG2aGY/MzLrDV
         boHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791600937; x=1792205737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CnXvDkHRygIjqcgALHUWN066KUbjGPQJV9Mzd8woTCg=;
        b=f2VltDPh+48Thn9NW/OZ1ghmxtbxqnp2utY2nO7uBQsZ6y/fguJpBxIOqhzE0HVd/J
         K7zNe566MmpCqrDMNOY3GasH7X4a8NaQHKX9dXhobEAyn8rQCnoXwhv/4j4Q33erLX8v
         QluScqLc+PIltKH5r6iMZOUv8IB2U6yAKHwbzHK6Fd4Db/JohtTwoUDjygOynz3Le3xH
         yuhOAUSXyTUUxI54D3fHMknMx3o979TgQtPlafJIQYYPMpPrqgqfwtKvE0UQ4982EAVi
         19NJS5guiPB2XkfT6hoWjPcR237TIGdK36t8gUkVhg0wc7SxTn9iDtyQRK5JTlHWTIyW
         Un1w==
X-Forwarded-Encrypted: i=1; AKwUvByLXz7omideo+TPJJpu8rpvvtX++wVzL91AzFLHhKZeYChNKuFkAeGu//zlL1CIm3a+eMNtE8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGw43A0gVbVXIYoZdxVX19zVevvIKTVFrDJRqJ4CoIldRC416b
	+Wd/oM1lnVvpiXC1NcwnlTTd/VOP2H8n7VR15ln4uZJcfCRCTKQio8usMNN0TfjpAQnuC84nCKV
	0Q/FH6t9r7/WAUFC2yhd09J2mtg==
X-Received: from dldyr2-n1.prod.google.com ([2002:a05:701b:4502:10b0:149:37d9:7f80])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:170a:b0:15f:28e1:7c7d with SMTP id a92af1059eb24-16a61d5c4f6mr4133922c88.42.1791600936843;
 Fri, 09 Oct 2026 19:55:36 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:55:15 +0000
In-Reply-To: <20261010025532.839559-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261010025532.839559-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261010025532.839559-4-almasrymina@google.com>
Subject: [PATCH net v1 3/4] netdevsim: support devmem RX and TX bindings
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Taehee Yoo <ap420073@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
netdevsim net_device, and configure page_pool instances with
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_ALLOW_UNREADABLE_NETMEM
and queue_idx so devmem bind-rx and bind-tx netlink operations can be
tested against netdevsim in software selftests.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/netdevsim/bus.c    |  1 +
 drivers/net/netdevsim/netdev.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 5c55c308487b4..f87f5e037b6fb 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -462,6 +462,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
 	nsim_bus_dev->port_count = port_count;
 	nsim_bus_dev->num_queues = num_queues;
 	nsim_bus_dev->initial_net = current->nsproxy->net_ns;
+	dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64));
 	/* Disallow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, false);
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b4a99f3ceac60..4415dc01c610b 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -414,16 +414,22 @@ static int nsim_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
-static int nsim_create_page_pool(struct page_pool **p, struct napi_struct *napi)
+static int nsim_create_page_pool(struct net_device *dev, struct page_pool **p,
+				 struct napi_struct *napi, int idx)
 {
+	struct netdevsim *ns = netdev_priv(dev);
 	struct page_pool_params params = {
 		.order = 0,
 		.pool_size = NSIM_RING_SIZE,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+			 PP_FLAG_ALLOW_UNREADABLE_NETMEM,
+		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
-		.dev = &napi->dev->dev,
+		.dev = &ns->nsim_bus_dev->dev,
 		.napi = napi,
 		.dma_dir = DMA_BIDIRECTIONAL,
-		.netdev = napi->dev,
+		.netdev = dev,
+		.queue_idx = idx,
 	};
 	struct page_pool *pool;
 
@@ -450,7 +456,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
+		err = nsim_create_page_pool(dev, &rq->page_pool, &rq->napi, i);
 		if (err)
 			goto err_pp_destroy;
 	}
@@ -762,14 +768,16 @@ nsim_queue_mem_alloc(struct net_device *dev,
 	if (ns->rq_reset_mode == 1) {
 		if (!netif_running(ns->netdev))
 			return -ENETDOWN;
-		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
+		return nsim_create_page_pool(dev, &qmem->pp,
+					     &ns->rq[idx]->napi, idx);
 	}
 
 	qmem->rq = nsim_queue_alloc();
 	if (!qmem->rq)
 		return -ENOMEM;
 
-	err = nsim_create_page_pool(&qmem->rq->page_pool, &qmem->rq->napi);
+	err = nsim_create_page_pool(dev, &qmem->rq->page_pool, &qmem->rq->napi,
+				    idx);
 	if (err)
 		goto err_free;
 
@@ -1051,6 +1059,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	ns->netdev->netmem_tx = NETMEM_TX_DMA;
 	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
-- 
2.56.0.385.gd3acb90ef8-goog

