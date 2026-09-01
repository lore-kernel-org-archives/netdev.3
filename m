Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD7429CF3;
	Tue,  1 Sep 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268953; cv=pass; b=LGdejCNKDaNfWmt78vB0K8uBfmyG6k5+8F06XKLyeexj85KExPE/DBg37yfqDaV1fgfNwhqsjPFRrsqzkz5qNpP5gMJV5y9UuOo/Ci9Rfy+rapLRYhXX9qyUKteK8Ro4vekkzq8iRsYnPYvDtbw63HWuaTXlyLAH5cxZat+Dyiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268953; c=relaxed/simple;
	bh=+uxsxkXjN3Bxpg0NC5tRARwWPNMwOUh37H41hx1uM4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9lAgb5/G80Pc7+Dnxrk+BSGvAiULaYYti3hqzNXb7BjuJ3PIMcw0FPTaobe7oRmihFgktq6Covk5OgG14xm1M4HPT+eb8l5K/deR5y14VKggVd4V+6LgI144WrHIx9+j/SLy96bWgmY/UniHfDTrJcjFC8Ua5Ietjv0Nv83zhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=d4xmIgLY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="d4xmIgLY"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ63N4gDLz49QPH;
	Tue, 01 Sep 2026 16:22:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlPgQr/GMs2WGlgIquCEJmPpzMZAme2mzXsO0aoLbe8=;
	b=d4xmIgLYsZVEAasGsN+hlxLJBwyXjvmTf/UBRKPtEt1L+8ZKatA/aYV5ikd6zJ40V65MvW
	DXgkpmQfRE1B/jd/IYdoar1M3YzLJorVvcgqNVBRD+QRlu7nTeD5NVgyXT8tNYkc3XXRSk
	lKRRVfK1/i9ah6MkfJZ9U5mR1tYD7NQnmAz5ZrKsshXUE7Bx+eELqxdCVOcso6pbonivTI
	BlzPEtMNZFuV97dahY2b3LxeyZO7qLqy0hmKLDut6SlgtKYHS6XttmuD30FJR5BKUUocnt
	2LvoIqU2JwOCdAhPK9yXVi6PGMR2frG5b5nHBQn4g+xDM2DoWKs9ylcENEUhWg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268944;
	b=hgAMc9tA73oZKHrfFRbuBb/8gscmCCWFWo3KGknAE2ENI9w7Rd/O1EmmB2ccLsRBvMROqz
	yGE8wnIZSogP3z+giLa5Dfj3oAiahlRRoVIZ8i4qDSHgz/A+3AbwhSDqX4ghzMgntb2905
	Xmb2c0eCGK1SJkmQm96X7Z7LW/CRy/L0OQwVy7b54KuYDjQeOiKWLi1sxeBNLf2N3jUF5B
	Xth0vi0pD/Qd0Vm+WRV7AtsMZlNug+IBgf6Hae6Ia6ossYeKNTjv3iqAZdjsw7PKENIS/H
	2KczkB6ZncwOOQc4Dc0whS/ZemhIPyY0zlpLrtqhyu4zjVW7NBZquZwJ1IqFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlPgQr/GMs2WGlgIquCEJmPpzMZAme2mzXsO0aoLbe8=;
	b=YVu/z//M0WaOqBEevb0odnG/IR0cY8rOwE4qRJHIgIIYJFpqUDbxptHGHfG/qhMeyDFsS7
	QgZmhCarb3Dh6UMWOzd+UXpRGTHVVWClgZjzOQ36BdLmy5vFT+/7bii1TAvQp2/LFqg0B6
	t/Zrb/jGmj05WYp4KHyUDqQQRcdr/2jRuVfmsOdhP+/rmPxeFSJL9shMrKYy9QU2xTywTR
	8JtZ4wD+41r/bYw2xmOx02+/eKKvBFtOupWadsrCuQv2w49GmZwqNq63uNMZKsG2+vhHtn
	qHglb2GkMEmXQQWKIIGNM9nbhmqSUkLWnBSZ1ioYR6oin/C522lUm4D46XD+TA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
To: linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Andy Gross <agross@kernel.org>,
	Mihai Moldovan <ionic@ionic.de>,
	Denis Kenzior <denkenz@gmail.com>,
	Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 15/15] net: qrtr: solve the 32-bit unsafe use in endpoints
Date: Tue,  1 Sep 2026 16:19:34 +0300
Message-Id: <20260901131934.225991-16-juha-matti.tilli@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
References: <20260901131934.225991-1-juha-matti.tilli@iki.fi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 32-bit architectures, a single radix tree can have at most 32 bit
keys. We're cramming 64 bits in there. To solve this, use a radix tree
of radix trees. First, the endpoint is looked up. Secondly, the node is
looked up based on the endpoint.

Theoretically, there could be the option of skipping the "tree of trees"
approach if long is 64 bits. However, this has the drawback that the
code would be entirely different on 32-bit and 64-bit architectures, and
could create subtle bugs where someone commits and tests modifications
on a 64-bit architecture, and suddenly those who use a 32-bit
architecture would see them break.

This has been tested on a 32-bit ARM machine with two identical ath11k
modules, using patches by Mihai Moldovan to allow multiple modules to
work in parallel.

Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Tested-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 118 ++++++++++++++++++++++++++++++---------------
 net/qrtr/qrtr.h    |  10 ++++
 2 files changed, 89 insertions(+), 39 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 960e6e816be41..7c50d32b11015 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -22,11 +22,7 @@
 #define QRTR_MAX_EPH_SOCKET 0x7fff
 #define QRTR_EPH_PORT_RANGE \
 		XA_LIMIT(QRTR_MIN_EPH_SOCKET, QRTR_MAX_EPH_SOCKET)
-#if BITS_PER_LONG >= 64
 #define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, INT_MAX)
-#else
-#define QRTR_ENDPOINT_RANGE XA_LIMIT(qrtr_local_nid + 1, UINT16_MAX)
-#endif
 
 #define QRTR_PORT_CTRL_LEGACY 0xffff
 
@@ -186,6 +182,9 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
 #define QRTR_INDEX_HALF_SIGNED_MAX ((long)(QRTR_INDEX_HALF_UNSIGNED_MAX) >> 1)
 #define QRTR_INDEX_HALF_SIGNED_MIN ((long)(-1) - QRTR_INDEX_HALF_SIGNED_MAX)
 
+/* endpoint not defined, i.e. endpoint 0 */
+static struct qrtr_node_lookup_helper helper0;
+
 /**
  * struct qrtr_node - endpoint node
  * @ep_lock: lock for endpoint management and callbacks
@@ -245,9 +244,11 @@ static void __qrtr_node_release(struct kref *kref)
 {
 	struct qrtr_node *node = container_of(kref, struct qrtr_node, ref);
 	struct radix_tree_iter iter;
+	struct radix_tree_iter iter2;
 	struct qrtr_tx_flow *flow;
 	unsigned long flags;
 	void __rcu **slot;
+	void __rcu **slot2;
 	unsigned long index;
 
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
@@ -255,8 +256,18 @@ static void __qrtr_node_release(struct kref *kref)
 	 * multiple entries pointing to our released node, delete them all.
 	 */
 	radix_tree_for_each_slot(slot, &qrtr_nodes, &iter, 0) {
-		if (*slot == node)
+		struct qrtr_node_lookup_helper *helper = *slot;
+
+		if (!helper)
+			continue;
+		radix_tree_for_each_slot(slot2, &helper->nodes, &iter2, 0) {
+			if (*slot2 == node)
+				radix_tree_iter_delete(&helper->nodes, &iter2, slot2);
+		}
+		if (helper != &helper0 && radix_tree_empty(&helper->nodes)) {
 			radix_tree_iter_delete(&qrtr_nodes, &iter, slot);
+			helper->added = 0;
+		}
 	}
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 
@@ -494,22 +505,14 @@ static struct qrtr_node *qrtr_node_lookup(unsigned int endpoint_id,
 					  unsigned int nid)
 {
 	struct qrtr_node *node = NULL;
+	struct qrtr_node_lookup_helper *helper = NULL;
 	unsigned long flags;
-	unsigned long key = 0;
-
-	/* nid is chosen by device firmware and is generally a single
-	 * and small number. If firmware chooses otherwise, use it
-	 * modulo 65536 in 32-bit systems.
-	 */
-	if (endpoint_id > QRTR_INDEX_HALF_UNSIGNED_MAX)
-		return node;
-
-	key = ((unsigned long)(endpoint_id) << QRTR_INDEX_HALF_BITS) |
-	      ((unsigned long)(nid) & QRTR_INDEX_HALF_UNSIGNED_MAX);
 
 	mutex_lock(&qrtr_node_lock);
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
-	node = radix_tree_lookup(&qrtr_nodes, key);
+	helper = radix_tree_lookup(&qrtr_nodes, endpoint_id);
+	if (helper)
+		node = radix_tree_lookup(&helper->nodes, nid);
 	node = qrtr_node_acquire(node);
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 	mutex_unlock(&qrtr_node_lock);
@@ -527,33 +530,45 @@ static struct qrtr_node *qrtr_node_lookup(unsigned int endpoint_id,
 static int qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
 {
 	unsigned long flags;
-	unsigned long key;
+	int rc = 0;
+	int did_insert0 = 0;
 
 	if (nid == QRTR_EP_NID_AUTO)
 		return 0;
 
-	/* nid is chosen by device firmware and is generally a single
-	 * and small number. If firmware chooses otherwise, use it
-	 * modulo 65536 in 32-bit systems.
-	 */
-	if (node->ep->id > QRTR_INDEX_HALF_UNSIGNED_MAX)
-		return -EINVAL;
-
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 
-	/* Always insert with the endpoint_id + node_id */
-	key = ((unsigned long)(node->ep->id) << QRTR_INDEX_HALF_BITS) |
-	      ((unsigned long)(nid) & QRTR_INDEX_HALF_UNSIGNED_MAX);
-	radix_tree_insert(&qrtr_nodes, key, node);
-
-	if (!radix_tree_lookup(&qrtr_nodes, nid))
-		radix_tree_insert(&qrtr_nodes, nid, node);
+	if (!radix_tree_lookup(&helper0.nodes, nid)) {
+		rc = radix_tree_insert(&helper0.nodes, nid, node);
+		if (rc)
+			goto err_lock;
+		did_insert0 = 1;
+	}
+	if (!node->ep->helper.added) {
+		INIT_RADIX_TREE(&node->ep->helper.nodes, GFP_ATOMIC);
+		rc = radix_tree_insert(&qrtr_nodes, node->ep->id,
+				       &node->ep->helper);
+		if (rc)
+			goto err_insert0;
+		node->ep->helper.added = 1;
+	}
+	rc = radix_tree_insert(&node->ep->helper.nodes, nid, node);
+	if (rc && rc != -EEXIST)
+		goto err_insert0; // Don't revert helper insertion
 
 	if (node->nid == QRTR_EP_NID_AUTO)
 		node->nid = nid;
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 
 	return 0;
+
+err_insert0:
+	if (did_insert0)
+		radix_tree_delete(&helper0.nodes, nid);
+
+err_lock:
+	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
+	return rc;
 }
 
 /**
@@ -773,6 +788,7 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	mutex_unlock(&qrtr_node_lock);
 	ep->node = node;
 	ep->id = endpoint_id;
+	ep->helper.added = 0;
 
 	return 0;
 free_node:
@@ -791,12 +807,14 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 	struct sockaddr_qrtr src = {AF_QIPCRTR, node->nid, QRTR_PORT_CTRL};
 	struct sockaddr_qrtr dst = {AF_QIPCRTR, qrtr_local_nid, QRTR_PORT_CTRL};
 	struct radix_tree_iter iter;
+	struct radix_tree_iter iter2;
 	struct qrtr_ctrl_pkt *pkt;
 	struct qrtr_tx_flow *flow;
 	struct sk_buff *skb;
 	unsigned long flags;
 	unsigned long index;
 	void __rcu **slot;
+	void __rcu **slot2;
 	u32 endpoint_id;
 
 	mutex_lock(&node->ep_lock);
@@ -807,16 +825,28 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 	/* Notify the local controller about the event */
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 	radix_tree_for_each_slot(slot, &qrtr_nodes, &iter, 0) {
-		if (*slot != node)
+		struct qrtr_node_lookup_helper *helper = *slot;
+
+		if (!helper)
 			continue;
-		src.sq_node = iter.index;
-		skb = qrtr_alloc_ctrl_packet(&pkt, GFP_ATOMIC);
-		if (skb) {
-			pkt->cmd = cpu_to_le32(QRTR_TYPE_BYE);
-			qrtr_local_enqueue(NULL, skb, endpoint_id,
-					   QRTR_TYPE_BYE, &src, &dst);
+		radix_tree_for_each_slot(slot2, &helper->nodes, &iter2, 0) {
+			if (*slot2 != node)
+				continue;
+			src.sq_node = iter.index;
+			skb = qrtr_alloc_ctrl_packet(&pkt, GFP_ATOMIC);
+			if (skb) {
+				pkt->cmd = cpu_to_le32(QRTR_TYPE_BYE);
+				qrtr_local_enqueue(NULL, skb, endpoint_id,
+						   QRTR_TYPE_BYE, &src, &dst);
+			}
 		}
 	}
+	if (ep->helper.added) {
+		radix_tree_for_each_slot(slot, &ep->helper.nodes, &iter, 0)
+			radix_tree_iter_delete(&ep->helper.nodes, &iter, slot);
+		radix_tree_delete(&qrtr_nodes, ep->id);
+		ep->helper.added = 0;
+	}
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 
 	/* Wake up any transmitters waiting for resume-tx from the node */
@@ -1593,8 +1623,17 @@ static int __init qrtr_proto_init(void)
 	if (rc)
 		goto err_sock;
 
+	rc = radix_tree_insert(&qrtr_nodes, 0, &helper0);
+	if (rc)
+		goto err_ns;
+
+	INIT_RADIX_TREE(&helper0.nodes, GFP_ATOMIC);
+	helper0.added = 1;
+
 	return 0;
 
+err_ns:
+	qrtr_ns_remove();
 err_sock:
 	sock_unregister(qrtr_family.family);
 err_proto:
@@ -1605,6 +1644,7 @@ postcore_initcall(qrtr_proto_init);
 
 static void __exit qrtr_proto_fini(void)
 {
+	radix_tree_delete(&qrtr_nodes, 0);
 	qrtr_ns_remove();
 	sock_unregister(qrtr_family.family);
 	proto_unregister(&qrtr_proto);
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index b4f50336ae75a..affc24f426c64 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -9,6 +9,15 @@ struct sk_buff;
 /* endpoint node id auto assignment */
 #define QRTR_EP_NID_AUTO (-1)
 
+/**
+ * struct qrtr_node_lookup_helper - node lookup helper, stored in qrtr_nodes
+ * @nodes: nodes, indexed by node_id
+ */
+struct qrtr_node_lookup_helper {
+	int added;
+	struct radix_tree_root nodes;
+};
+
 /**
  * struct qrtr_endpoint - endpoint handle
  * @xmit: Callback for outgoing packets
@@ -21,6 +30,7 @@ struct qrtr_endpoint {
 	int (*xmit)(struct qrtr_endpoint *ep, struct sk_buff *skb);
 	/* private: not for endpoint use */
 	struct qrtr_node *node;
+	struct qrtr_node_lookup_helper helper;
 	u32 id;
 };
 
-- 
2.34.1

