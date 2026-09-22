Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F724A9D4A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106363; cv=none; b=NzHkP61aNl0t+PMhP9JixYt591GjklWi/MQCkJTaTFnHsadzY80VCwrYRI6KZlQZ5d1zL0U8GeQDFZ3BDu90UkpICV2o9ENCUV++t71LCm5nRNlH4UZqpnZg005H0q3SwKT2BnLOkqpFhLC93nUliOeCeDwT8DLJs2zfdYM0mGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106363; c=relaxed/simple;
	bh=FfCctRadccrhbBiciGBmKdfV1QGWKniOCykBzuPatXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBPemIJbeuovHI8s0JiqaSzM5/ENDwEOMYsvEfcLVKj+Zcs2foSAZ4vDpxO/i1LpGiV+LhGD58wCOUs/7UIFjIa7RxxZ7H4J2KOHwKG+xwEpuyjbkvuwCTFs0NV4kTsRQIdQYNaeYind8XTyZfi+a2vyNB6ajBnQ7TtNSUCc7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0Z7vbgc; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0Z7vbgc"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso192699a91.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106350; x=1790711150; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tr6UXn84setH0JvzM0Q9v+ToB161JXMxDfH+vSeors=;
        b=a0Z7vbgc1DLLK170LfUiWFAyH93tHhjj82QwNNSeaEWVNV24Ml4ub+SKmjOc7d8Uhn
         IaAh2hC7r6Wj0GFPmQgEhMGI1uwnCNbq7LdMWUDITPwR5KKVe2gV+szqpZf2UkkPvxIt
         lPnAu42rFsDKMK0R550hgLmw4IfEGpPpVbLxITiV1yL6YnkKWS1F6wz7UY0kkQjKJHUJ
         cThaOcUq+Tm+HCSZ3smCrRA6bSBSCeuIj13WUbA/toFtujFEPF8gxm5Lv8zc2T7g0yWB
         CwGV6szTcXPeHHGXH9AsPaQU9Ziazxi6UwUeAWeeuOECWT5cNzEP8GPfJOflDVshiaW3
         3OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106350; x=1790711150;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Tr6UXn84setH0JvzM0Q9v+ToB161JXMxDfH+vSeors=;
        b=VW9s55fCCyhWMeb2vBy7/wYKsMLwP9yia1T6tIjlM/cNyCCC9iix6I83u30mOveFAl
         NuWbF2Pk6Rj+dnoHGCaqZOzIgdkd2Rz9N4VUL/2I1WqxQ0184kBF7KODoojmlRq4WUep
         Ks16vJgs59nop0bR50Leb0qmzt3h6LH9orrRhjYF6ir9qZCQONlcsgNKrHrrKr0XIDU1
         XtcWUasJE8xqnC3x3PyY2dnY1LEOr3/fduDUSe4wIKh6C0l3TPD2P4ZakbOTRI4lW5wM
         DS0ourr0YuKRGEgmMpBF/ugJm/FzLJfCU19uu89a/WfRbcTtgzNUZfTJiOICMadVo5i9
         YbFQ==
X-Gm-Message-State: AFuF++nViG+ku3ui4jw/3qds9yUzwcso7kTFRP2n7aSTkNt1se8YJjFq
	PSaXTZhBerp5ZmhKogVs03kBssYQe1r3fJPXTrzABl/4KkYHqyuENT/1tf1n3upt4OnVQw4qPml
	mtXLsdXMTqFCMLojz+rN24LD328vK3uAGU8AR9sf3lqwdJ2hSrQmaAcCr0AxgsJlDXb6Nou8j+A
	lHHFGtGEyVoVadlsJZNYqU23iKqU9XdSDXRhEuW4X8CSe6Pxc=
X-Received: from pgp27-n2.prod.google.com ([2002:a05:6a02:62db:20b0:cc7:521e:d606])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9101:b0:3dd:a00a:7ac6 with SMTP id adf61e73a8af0-3ddf82c1e03mr444531637.51.1790106349298;
 Tue, 22 Sep 2026 12:45:49 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:30 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-7-joshwash@google.com>
Subject: [PATCH net v2 6/9] gve: fix NULL dereference from premature XSK pool
 DMA unmap
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To ensure that XSK pools are DMA unmapped in all scenarios, GVE performs
the unmapping before validating if the interface is up and early
returning.

However, if rings are up, this introduces a race between the RX NAPI and
the control plane. As part of DMA unmapping the XSK pool, the kernel
sets pool->dev to NULL. Because xsk_buff_dma_sync_for_cpu() relies on
pool->dev, this results in a kernel panic:

BUG: kernel NULL pointer dereference, address: 000000000000030c
...
RIP: 0010:gve_rx_poll_dqo+0x2e2/0x13b0 [gve]
...
Call Trace:
 <IRQ>
 gve_napi_poll_dqo+0x88/0x170 [gve]
 __napi_poll+0x30/0x210
 net_rx_action+0x210/0x410
 ? dst_destroy_rcu+0x12/0x20
 handle_softirqs+0xe4/0x310
 __irq_exit_rcu+0x10e/0x130
 irq_exit_rcu+0xe/0x20
 common_interrupt+0xb6/0xe0
 </IRQ>

Leave the XSK pool DMA mapped until after rings are guaranteed to no
longer rely on the pool.

Fixes: d57ae093c887 ("gve: deduplicate xdp info and xsk pool registration logic")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 25 ++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 3712ff364cbd..49ae2b8c6a27 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1681,22 +1681,18 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	struct napi_struct *napi_rx;
 	struct napi_struct *napi_tx;
 	struct xsk_buff_pool *pool;
+	int err = 0;
 	int tx_qid;
-	int err;
 
-	if (qid >= priv->rx_cfg.num_queues)
-		return -EINVAL;
+	if (qid >= priv->rx_cfg.num_queues) {
+		err = -EINVAL;
+		goto unmap_and_return;
+	}
 
 	clear_bit(qid, priv->xsk_pools);
 
-	pool = xsk_get_pool_from_qid(dev, qid);
-	if (pool)
-		xsk_pool_dma_unmap(pool,
-				   DMA_ATTR_SKIP_CPU_SYNC |
-				   DMA_ATTR_WEAK_ORDERING);
-
 	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
-		return 0;
+		goto unmap_and_return;
 
 	/* Stop and start RDA queues to repost buffers. */
 	if (!gve_is_qpl(priv) && priv->xdp_prog) {
@@ -1725,7 +1721,14 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 			napi_schedule(napi_tx);
 	}
 
-	return 0;
+unmap_and_return:
+	pool = xsk_get_pool_from_qid(dev, qid);
+	if (pool)
+		xsk_pool_dma_unmap(pool,
+				   DMA_ATTR_SKIP_CPU_SYNC |
+				   DMA_ATTR_WEAK_ORDERING);
+
+	return err;
 }
 
 static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
-- 
2.55.0.1082.g2b9226bbc0-goog

