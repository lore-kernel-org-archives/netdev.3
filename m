Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3D4F4CE1;
	Fri, 18 Sep 2026 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726597; cv=none; b=TcwU/1hwYWdRk3VQ82CyfsXCF4o9g6ShITNMvve5duIkK4FgAPQbe+FFMsa7br2ahLlISI0NzsA/+91Ub3DYmKUviYXviqneZCjb6fJUfa9EQ/AWqm6ykHWyLqLaO/fOa/+/QgrDqR0yR92eWUvGbpUQBUAbfLFXk4FHe568FHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726597; c=relaxed/simple;
	bh=UfI4GE9njGOAOXtVn00vzUVQJZx+xPULHfgtFi6mlTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AL3xfg1+bFqUjb9g6V2pUtDqAP6R9jdd0VZ5f0Bu2J0v0fI7bl0eTkrBILbAyLwxUU/0o1cED0lhzxsMSAaehEaFq6ZB1duc2gi3wVRjLy7gFlExpawcXcBk+2e+UFSKX84SJHj9Dx0nVUKMTjrsilWnugk2mSIj/0GIUvqWpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZhWuacfj; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZhWuacfj"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hmT6y5JBBz6MpQ;
	Fri, 18 Sep 2026 12:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789726586;
	bh=UfI4GE9njGOAOXtVn00vzUVQJZx+xPULHfgtFi6mlTk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZhWuacfjDBvo/GpF56emHhvMn9nD4S9IWCNHcD6tNxCGfcmDsHYKpZQsq7aUMVhy0
	 fBeoYFjYgZXVUBsYhq7C9VLkSgLjJTvhkGWJsx0d/0xCGQnLipLvA8DU6n4OTOjl6c
	 wLKZE+JgaF0B8TG1ipORQmT8mMWB0qZuaIzAllHXO7UVbEOZjPTBxQgRpO6fRHZzds
	 URaWMb1I4qh1ZArhUw23ZJ5jHix3MJQFo36XGxyEmusvB67RkLVX0zF93anVAc46l7
	 fHyxTmlG0bpYQhJF9+Z+e3x1LDCFe8XoAt8BbZpNN6pIC6zkEMrCV0fgmGkUKxp+2Q
	 TKKWJiQhtP55Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hmT6y4XsXz4yLd;
	Fri, 18 Sep 2026 12:16:26 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hmT6w4jfBz8sbC;
	Fri, 18 Sep 2026 12:16:24 +0200 (CEST)
Received: from luggage.fritz.box (unknown [IPv6:2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 5AA3A5FABA;
	Fri, 18 Sep 2026 12:16:22 +0200 (CEST)
Authentication-Results: mxe9fb;
	spf=pass (sender IP is 2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160) smtp.mailfrom=linux@leemhuis.info smtp.helo=luggage.fritz.box
Received-SPF: pass (mxe9fb: connection is authenticated)
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Chris Lew <christopher.lew@oss.qualcomm.com>,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
	Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>,
	Daniel J Blueman <daniel@quora.org>,
	Takashi Iwai <tiwai@suse.de>,
	Vlastimil Babka <vbabka@suse.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH net] Revert "net: qrtr: Send HELLO message on endpoint
 register"
Date: Fri, 18 Sep 2026 12:16:21 +0200
Message-ID: <20260918101621.2848322-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178972658291.632225.12105105254153465727@mxe9fb.netcup.net>
X-NC-CID: DMvukkc/W+eeVYGBLC7WhtEXyYVvojXqlPZbqRsO/U6VwyWUT90=

This reverts commit 544d85de4dc22c01badfd8cefa59829ce35c4858.

It causes suspend and resume problems for numerous people, including
maintainers and developers of ath wifi drivers. A fix was proposed[1],
but did not get any traction, so go for a revert instead.

Cc: Chris Lew <christopher.lew@oss.qualcomm.com>
Cc: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Cc: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
Reported-by: Daniel J Blueman <daniel@quora.org>
Link: https://lore.kernel.org/all/20260909055846.16539-1-daniel@quora.org/ [1]
Reported-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/all/87a4plsg4w.wl-tiwai@suse.de/
Reported-by: Vlastimil Babka <vbabka@suse.com>
Link: https://lore.kernel.org/all/ab1491bb-cca5-4145-ac7d-31c966abf7b4@suse.com/
Reported-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Link: https://lore.kernel.org/all/6257c447-788d-4362-851e-0d552bcf7c56@oss.qualcomm.com/
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

I'm not affected by this, but due to all those reporters mentioned above
it seems it would be good to get this fixed for 7.3-rc4, as Linus' rule
of thumb wrt to fixing regressions is "generally be 'within a week',
preferably before the next rc". Which is why I currently plan to ask
Linus to pull this directly. If this is a bad idea, just tell me.

The patch from Daniel linked above[1] could have fixed the problem, but
none of the developers of the culprit or the maintainers for this area
commented on it within a week, despite some "please fix this soon" and
"Tested-by" replies from various maintainers of other subsystems. So
let's go for a revert instead, the original change can later easily be
reapplied in improved form. The change reverted looks like something
that maybe shouldn't have been merged after -rc1 anyway, but this is not
my area of expertise, so I might be totally wrong there, as mentioned
earlier.

Ciao, Thorsten
---
 net/qrtr/af_qrtr.c | 66 ++--------------------------------------------
 net/qrtr/ns.c      | 35 +++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 65 deletions(-)

diff --git net/qrtr/af_qrtr.c net/qrtr/af_qrtr.c
index 78347c937af76b..a30fa56e6aa31c 100644
--- net/qrtr/af_qrtr.c
+++ net/qrtr/af_qrtr.c
@@ -9,7 +9,6 @@
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/spinlock.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
 
 #include <net/sock.h>
 
@@ -121,10 +120,8 @@ static DEFINE_XARRAY_ALLOC(qrtr_ports);
  * @nid: node id
  * @qrtr_tx_flow: xarray of qrtr_tx_flow, keyed by node << 32 | port
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
- * @hello_sent: hello packet send successful
  * @rx_queue: receive queue
  * @item: list item for broadcast list
- * @say_hello: delayed work for sending hello packet
  */
 struct qrtr_node {
 	struct mutex ep_lock;
@@ -135,11 +132,8 @@ struct qrtr_node {
 	struct xarray qrtr_tx_flow;
 	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
 
-	bool hello_sent;
-
 	struct sk_buff_head rx_queue;
 	struct list_head item;
-	struct delayed_work say_hello;
 };
 
 /**
@@ -193,8 +187,6 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
-	cancel_delayed_work_sync(&node->say_hello);
-
 	skb_queue_purge(&node->rx_queue);
 
 	/* Free tx flow counters */
@@ -349,14 +341,6 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	size_t len = skb->len;
 	int rc, confirm_rx;
 
-	mutex_lock(&node->ep_lock);
-	if (!node->hello_sent && type != QRTR_TYPE_HELLO) {
-		mutex_unlock(&node->ep_lock);
-		kfree_skb(skb);
-		return -EAGAIN;
-	}
-	mutex_unlock(&node->ep_lock);
-
 	confirm_rx = qrtr_tx_wait(node, to->sq_node, to->sq_port, type);
 	if (confirm_rx < 0) {
 		kfree_skb(skb);
@@ -369,7 +353,7 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	hdr->src_node_id = cpu_to_le32(from->sq_node);
 	hdr->src_port_id = cpu_to_le32(from->sq_port);
 	if (to->sq_port == QRTR_PORT_CTRL) {
-		hdr->dst_node_id = cpu_to_le32(READ_ONCE(node->nid));
+		hdr->dst_node_id = cpu_to_le32(node->nid);
 		hdr->dst_port_id = cpu_to_le32(QRTR_PORT_CTRL);
 	} else {
 		hdr->dst_node_id = cpu_to_le32(to->sq_node);
@@ -388,8 +372,6 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			rc = node->ep->xmit(node->ep, skb);
 		else
 			kfree_skb(skb);
-		if (!rc && type == QRTR_TYPE_HELLO)
-			node->hello_sent = true;
 		mutex_unlock(&node->ep_lock);
 	}
 	/* Need to ensure that a subsequent message carries the otherwise lost
@@ -397,9 +379,6 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	if (rc && confirm_rx)
 		qrtr_tx_flow_failed(node, to->sq_node, to->sq_port);
 
-	if (rc == -EAGAIN && type == QRTR_TYPE_HELLO)
-		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
-
 	return rc;
 }
 
@@ -437,7 +416,7 @@ static void qrtr_node_assign(struct qrtr_node *node, unsigned int nid)
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
 	radix_tree_insert(&qrtr_nodes, nid, node);
 	if (node->nid == QRTR_EP_NID_AUTO)
-		WRITE_ONCE(node->nid, nid);
+		node->nid = nid;
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 }
 
@@ -591,38 +570,6 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt,
 	return skb;
 }
 
-static void qrtr_hello_work(struct work_struct *work)
-{
-	struct sockaddr_qrtr from = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
-	struct sockaddr_qrtr to = {AF_QIPCRTR, 0, QRTR_PORT_CTRL};
-	struct qrtr_ctrl_pkt *pkt;
-	struct qrtr_node *node;
-	struct qrtr_sock *ctrl;
-	struct sk_buff *skb;
-
-	node = container_of(to_delayed_work(work), struct qrtr_node, say_hello);
-
-	/* NS must be bound before we can send; retry with backoff if not ready */
-	ctrl = qrtr_port_lookup(QRTR_PORT_CTRL);
-	if (!ctrl) {
-		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
-		return;
-	}
-
-	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
-	if (!skb) {
-		qrtr_port_put(ctrl);
-		schedule_delayed_work(&node->say_hello, msecs_to_jiffies(100));
-		return;
-	}
-
-	pkt->cmd = cpu_to_le32(QRTR_TYPE_HELLO);
-	from.sq_node = qrtr_local_nid;
-	to.sq_node = node->nid;
-	qrtr_node_enqueue(node, skb, QRTR_TYPE_HELLO, &from, &to);
-	qrtr_port_put(ctrl);
-}
-
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -648,9 +595,6 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	node->nid = QRTR_EP_NID_AUTO;
 	node->ep = ep;
 
-	node->hello_sent = false;
-	INIT_DELAYED_WORK(&node->say_hello, qrtr_hello_work);
-
 	xa_init(&node->qrtr_tx_flow);
 	mutex_init(&node->qrtr_tx_lock);
 
@@ -661,9 +605,6 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	mutex_unlock(&qrtr_node_lock);
 	ep->node = node;
 
-	/* Initiate HELLO handshake from the core layer */
-	schedule_delayed_work(&node->say_hello, 0);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qrtr_endpoint_register);
@@ -938,9 +879,6 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 	mutex_lock(&qrtr_node_lock);
 	list_for_each_entry(node, &qrtr_all_nodes, item) {
-		/* Skip nodes with no assigned node ID yet. */
-		if (READ_ONCE(node->nid) == QRTR_EP_NID_AUTO)
-			continue;
 		skbn = pskb_copy(skb, GFP_KERNEL);
 		if (!skbn)
 			break;
diff --git net/qrtr/ns.c net/qrtr/ns.c
index bcb090ee79d494..c5e7e01db24984 100644
--- net/qrtr/ns.c
+++ net/qrtr/ns.c
@@ -212,7 +212,6 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 		pr_err("failed to send lookup notification\n");
 }
 
-/* Announce the list of servers registered on the local node */
 static int announce_servers(struct sockaddr_qrtr *sq)
 {
 	struct qrtr_server *srv;
@@ -327,8 +326,38 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	return 0;
 }
 
+static int say_hello(struct sockaddr_qrtr *dest)
+{
+	struct qrtr_ctrl_pkt pkt;
+	struct msghdr msg = { };
+	struct kvec iv;
+	int ret;
+
+	iv.iov_base = &pkt;
+	iv.iov_len = sizeof(pkt);
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.cmd = cpu_to_le32(QRTR_TYPE_HELLO);
+
+	msg.msg_name = (struct sockaddr *)dest;
+	msg.msg_namelen = sizeof(*dest);
+
+	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
+	if (ret < 0)
+		pr_err("failed to send hello msg\n");
+
+	return ret;
+}
+
+/* Announce the list of servers registered on the local node */
 static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
 {
+	int ret;
+
+	ret = say_hello(sq);
+	if (ret < 0)
+		return ret;
+
 	return announce_servers(sq);
 }
 
@@ -745,6 +774,10 @@ int qrtr_ns_init(void)
 	qrtr_ns.bcast_sq.sq_node = QRTR_NODE_BCAST;
 	qrtr_ns.bcast_sq.sq_port = QRTR_PORT_CTRL;
 
+	ret = say_hello(&qrtr_ns.bcast_sq);
+	if (ret < 0)
+		goto err_wq;
+
 	/* As the qrtr ns socket owner and creator is the same module, we have
 	 * to decrease the qrtr module reference count to guarantee that it
 	 * remains zero after the ns socket is created, otherwise, executing

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.55.0

