Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF5390C8E
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439334; cv=none; b=HZfZ0pbVlHii15VNyYPjXU0RQO8dP+I37+UIEpK3hguDiKHLiW+rFbuD58LRGwNlRPXsXwVcI/89VncFZVG95SfiSgHqZbByowCG2AbMu7jU1/B/QEKE/PCsWcQdbw0s5zfCPCT7HuNlFe10uHt3O5QoSF9WlweNmQuPeq5fA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439334; c=relaxed/simple;
	bh=bJAZZtDUU5c/+9Ki2mAas47xrgeTHNMSAUENbevgP7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeO1XswyLIHiBxRZ4Fp2fU1O6YGOjvZBMG/6czRgnS9s14RxnID9kZQOr6ljf1LiYxIxWJrHbRLhFlDLqM1xCFQYHefBJUcFjb6NgIbJ24RRmuHwHWhH/iih+opAUpij0tE5244eQ79KwmZX4j892ZIzRC7ennOikJ/OCa3Q/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+s5Jyoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+s5Jyoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557661F00A3E;
	Sat, 22 Aug 2026 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439332;
	bh=5L5nJ2/unYcO96asuBdmeDTfMO+02gXrtLQ3UOB49S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+s5JyoagNMb28nO8ffkpjE2gCjR5//XveN2dogULb1fZ8JJkR/u/G5kLpsxj/dbL
	 oObpB/gmXCcMkmh0Bn6UpxZwUnFb2kMy+O5CVTiljwJkMIG0ykWKzzksibb2U+fgut
	 uivTFAslg56gretxKKFulpIg8+u0sDGdOsCLKHD9z8x6oB2Vn4Pi7JFdgB/DO+6eUJ
	 UvLRqCNIYuw46yQygy4ze12gsK9l0MTL1mxK/9R3fNphXssH/Q1EwTYpYOi3b7iieO
	 s6png51+m/tG9QDUTajKrCaaj7tM9MIGd/5/mG9MR8CeYQJsJQil2pDQCk4UjU8zdk
	 VPEanzio24m7A==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: edumazet@google.com,
	cratiu@nvidia.com,
	borisp@nvidia.com,
	kuniyu@google.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 2/6] netdevsim: support PSP VC based queue steering
Date: Sat, 22 Aug 2026 15:55:20 -0700
Message-ID: <20260822225524.2328465-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822225524.2328465-1-kuba@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gives the PSP steering selftest something to run against without
hardware. nsim_start_xmit() already mirrors the Tx queue index onto Rx,
so all the cookie does is override that choice.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdevsim.h |  4 ++--
 drivers/net/netdevsim/netdev.c    |  5 +++--
 drivers/net/netdevsim/psp.c       | 26 ++++++++++++++++++++++++--
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 55aec41237b9..3b1c52e43d46 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -453,13 +453,13 @@ void nsim_psp_uninit(struct netdevsim *ns);
 void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext);
 enum skb_drop_reason
 nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
-	    struct netdevsim *peer_ns, struct skb_ext **psp_ext);
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext, int *rxq);
 #else
 static inline int nsim_psp_init(struct netdevsim *ns) { return 0; }
 static inline void nsim_psp_uninit(struct netdevsim *ns) {}
 static inline enum skb_drop_reason
 nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
-	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext, int *rxq)
 {
 	return 0;
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b4a99f3ceac6..04e416d1a377 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -147,11 +147,12 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		peer_dev = peer_ns->netdev;
 	}
 
-	dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext);
+	rxq = skb_get_queue_mapping(skb);
+
+	dr = nsim_do_psp(skb, ns, peer_ns, &psp_ext, &rxq);
 	if (dr)
 		goto out_drop_free;
 
-	rxq = skb_get_queue_mapping(skb);
 	if (rxq >= peer_dev->num_rx_queues)
 		rxq = rxq % peer_dev->num_rx_queues;
 	rq = peer_ns->rq[rxq];
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 32d95205a8cc..5aa5078889eb 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -14,9 +14,26 @@ void nsim_psp_handle_ext(struct sk_buff *skb, struct skb_ext *psp_ext)
 		__skb_ext_set(skb, SKB_EXT_PSP, psp_ext);
 }
 
+/* Pick the Rx queue for a decapsulated frame. Devices which support
+ * PSP_VC_STEER_RX match the destination queue ID carried in the
+ * cookie ahead of consulting the RSS table.
+ */
+static int nsim_psp_steer(struct netdevsim *peer_ns, struct sk_buff *skb,
+			  int rxq)
+{
+	struct net_device *dev = peer_ns->netdev;
+	struct psp_skb_ext *pse;
+
+	pse = skb_ext_find(skb, SKB_EXT_PSP);
+	if (!pse || pse->vc_dst >= dev->real_num_rx_queues)
+		return rxq;
+
+	return pse->vc_dst;
+}
+
 enum skb_drop_reason
 nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
-	    struct netdevsim *peer_ns, struct skb_ext **psp_ext)
+	    struct netdevsim *peer_ns, struct skb_ext **psp_ext, int *rxq)
 {
 	enum skb_drop_reason rc = 0;
 	struct psp_dev *peer_psd;
@@ -44,7 +61,8 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	}
 
 	net = sock_net(skb->sk);
-	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0, 0)) {
+	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0,
+				 psp_assoc_vc_tx_get(pas))) {
 		rc = SKB_DROP_REASON_PSP_OUTPUT;
 		goto out_unlock;
 	}
@@ -73,6 +91,9 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 			goto out_unlock;
 		}
 
+		if (peer_psd->config.vc_steer & (1 << PSP_VC_STEER_RX))
+			*rxq = nsim_psp_steer(peer_ns, skb, *rxq);
+
 		*psp_ext = skb->extensions;
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
@@ -216,6 +237,7 @@ static struct psp_dev_caps nsim_psp_caps = {
 		    1 << PSP_VERSION_HDR0_AES_GCM_256 |
 		    1 << PSP_VERSION_HDR0_AES_GMAC_256,
 	.assoc_drv_spc = sizeof(void *),
+	.vc_steer = true,
 };
 
 static void __nsim_psp_uninit(struct netdevsim *ns, bool teardown)
-- 
2.55.0

