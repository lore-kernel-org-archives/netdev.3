Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43547ACEB;
	Tue,  1 Sep 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268890; cv=pass; b=Sc69/EuAvDUqafyERjK7gMYwQcPdCelUiMc/XPt6KqCfc7U/Izd3uF3kxd4S+1LmukmelhvMx0p2WyOoJAauACyZu1ggjKmGrL40Ccd3RX0vrsvBUzKtPQCiHHazvDpnURZI/xGlz/A94lFL2fn3IslU4kTXSRP5WcCHIQy/j80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268890; c=relaxed/simple;
	bh=hdtkGhRfz8rVbNwgtAd+nE20hxvZoyBIqJKmY7rY+Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlVsVqYdymlw0My962cCzWour+i4/X6O2xEZBgDC27m3hTXMOztze1eRawfevr3be3k8xIc1kGVEtR2DcSVq8gXItNqvCpkv5/Q4CEVX5GFQLsKXfHZdjmR/n+KRebYNed9RLV3TiB50VOa/yENGXn4RH1lqpBomKmcXuSdb/cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ja0E7aCX; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ja0E7aCX"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ62C23bVz49QMM;
	Tue, 01 Sep 2026 16:21:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWGOLefIcCK3uanL/TxDzRS8ZuMg1qk19zGuow0Q++k=;
	b=ja0E7aCXsx65M3CEogzj5PxpGwtApRqeURdbZNmShDsU5ykmnOH5gWgGcNzYH/JPco+vp7
	XxvYJhak+o+sVe8NHA4OVHSjsTAAj9ykVJgo2UeKLfj7Cm5xABzvb6ot7+xrlKvr41/N6P
	qk2QtPIW8ci24rClKAiQLgi5EQPhNIOQbgjH3ZLZZN3+Pja/DnN2WFMHEYXF8NEAd6FwK7
	aS/YUfRgFmjcGOEQ2STcz6Tv/e8dkAfGIaG690VUwcYx5S1m6esEugTxOFsx9u9gYNvfoh
	r79g3GdiEBzGaOMowWCVn/Ihums3/9qXhDpxiupFqr2YM54ccTlVa5wmPQnQ/g==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268883;
	b=tjmAINtLrn4uIKfkv/f6tAa8d2cc90S40eYq4bufElEpdhx2tKfHVDZK3IPzeFmKEpTdma
	ULBuZBTiEW3w5gjp5YGpSfcD3S46reFRlhtgpcvpZxb+y4R2RE+dpc8b3rV06I6tF3w6gH
	QYe19Ssc6sSL8Dd6/p3XOwYqTqDFoamsaLYOvj9zlTeBiFw2KGy6/qB1lo1vvwcfShyfpX
	rZzYiBQ8UjZIS/yffrsP7+D9Utmd9xipIdsOvyv5AhPd1xs9WS47JiNfuLkr70FOnIPD+F
	fNOVRPPw4hVZKNr+x2AUHQyHFpuxRQdNJTS21m9Ifnt7+iGeDDV98QF37jv76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWGOLefIcCK3uanL/TxDzRS8ZuMg1qk19zGuow0Q++k=;
	b=PAvaqLXxMrPauBpRe6KzZZQehEKL2c4+14sso0qJcamFDEQtoVHqLJ8kTvGn7TVL1yw+lB
	uDSFAUerPDf4y0g8Aq+k8UT5U3r38cI0BHHnudr1tQc//TntmdThgl6KLlTIMCwBala/MX
	VgWdmIhwpEdunxhxn21/q/lceWs6ttBPcmYYTyS86ZSgELr71gMIkbiTFAYy4B10HjiHg0
	K8OTKy6Pv6g64VvPg3qf0VEBk9gwwN9RWxyTv+mtDjPpru4wiAgcR8l0Wqbx9tn2O04p66
	VjjhL7ip+1+hmrnSgOPCMOsnzQJj1dYwFKHovct7ChLul7rIICz+wbj2IoZ39g==
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
Subject: [PATCH v6 07/15] net: qrtr: Report endpoint for locally generated messages
Date: Tue,  1 Sep 2026 16:19:26 +0300
Message-Id: <20260901131934.225991-8-juha-matti.tilli@iki.fi>
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

From: Denis Kenzior <denkenz@gmail.com>

For messages generated by the local endpoint destined
to the local endpoint, report the local endpoint identifier.  Same
QRTR_ENDPOINT auxiliary data and QRTR_REPORT_ENDPOINT socket option
semantics apply as for messages generated by remote endpoints.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 897ecc8dc304d..da7ccf19c6851 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -184,9 +184,11 @@ struct qrtr_tx_flow {
 #define QRTR_TX_FLOW_LOW	5
 
 static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
+			      u32 endpoint_id,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to);
 static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
+			      u32 endpoint_id,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to);
 static struct qrtr_sock *qrtr_port_lookup(int port);
@@ -393,6 +395,7 @@ static int qrtr_tx_flow_failed(struct qrtr_node *node, int dest_node,
 
 /* Pass an outgoing packet socket buffer to the endpoint driver. */
 static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
+			     u32 endpoint_id,
 			     int type, struct sockaddr_qrtr *from,
 			     struct sockaddr_qrtr *to)
 {
@@ -744,7 +747,8 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep)
 		skb = qrtr_alloc_ctrl_packet(&pkt, GFP_ATOMIC);
 		if (skb) {
 			pkt->cmd = cpu_to_le32(QRTR_TYPE_BYE);
-			qrtr_local_enqueue(NULL, skb, QRTR_TYPE_BYE, &src, &dst);
+			qrtr_local_enqueue(NULL, skb, endpoint_id,
+					   QRTR_TYPE_BYE, &src, &dst);
 		}
 	}
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
@@ -809,8 +813,8 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
 		pkt->client.port = cpu_to_le32(ipc->us.sq_port);
 
 		skb_set_owner_w(skb, &ipc->sk);
-		qrtr_bcast_enqueue(NULL, skb, QRTR_TYPE_DEL_CLIENT, &ipc->us,
-				   &to);
+		qrtr_bcast_enqueue(NULL, skb, qrtr_local_nid,
+				   QRTR_TYPE_DEL_CLIENT, &ipc->us, &to);
 	}
 
 	if (port == QRTR_PORT_CTRL)
@@ -950,6 +954,7 @@ static int qrtr_bind(struct socket *sock, struct sockaddr_unsized *saddr, int le
 
 /* Queue packet to local peer socket. */
 static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
+			      u32 endpoint_id,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to)
 {
@@ -967,6 +972,7 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	cb = (struct qrtr_cb *)skb->cb;
 	cb->src_node = from->sq_node;
 	cb->src_port = from->sq_port;
+	cb->endpoint_id = endpoint_id;
 
 	if (sock_queue_rcv_skb(&ipc->sk, skb)) {
 		qrtr_port_put(ipc);
@@ -981,6 +987,7 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 
 /* Queue packet for broadcast. */
 static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
+			      u32 endpoint_id,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to)
 {
@@ -992,11 +999,11 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 		if (!skbn)
 			break;
 		skb_set_owner_w(skbn, skb->sk);
-		qrtr_node_enqueue(node, skbn, type, from, to);
+		qrtr_node_enqueue(node, skbn, endpoint_id, type, from, to);
 	}
 	mutex_unlock(&qrtr_node_lock);
 
-	qrtr_local_enqueue(NULL, skb, type, from, to);
+	qrtr_local_enqueue(NULL, skb, endpoint_id, type, from, to);
 
 	return 0;
 }
@@ -1004,12 +1011,15 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	DECLARE_SOCKADDR(struct sockaddr_qrtr *, addr, msg->msg_name);
-	int (*enqueue_fn)(struct qrtr_node *, struct sk_buff *, int,
-			  struct sockaddr_qrtr *, struct sockaddr_qrtr *);
+	int (*enqueue_fn)(struct qrtr_node *node, struct sk_buff *skb,
+			  u32 endpoint_id, int type,
+			  struct sockaddr_qrtr *from,
+			  struct sockaddr_qrtr *to);
 	__le32 qrtr_type = cpu_to_le32(QRTR_TYPE_DATA);
 	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct qrtr_node *node;
+	u32 endpoint_id = qrtr_local_nid;
 	struct sk_buff *skb;
 	size_t plen;
 	u32 type;
@@ -1093,7 +1103,7 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	}
 
 	type = le32_to_cpu(qrtr_type);
-	rc = enqueue_fn(node, skb, type, &ipc->us, addr);
+	rc = enqueue_fn(node, skb, endpoint_id, type, &ipc->us, addr);
 	if (rc >= 0)
 		rc = len;
 
@@ -1127,7 +1137,8 @@ static int qrtr_send_resume_tx(struct qrtr_cb *cb)
 	pkt->client.node = cpu_to_le32(cb->dst_node);
 	pkt->client.port = cpu_to_le32(cb->dst_port);
 
-	ret = qrtr_node_enqueue(node, skb, QRTR_TYPE_RESUME_TX, &local, &remote);
+	ret = qrtr_node_enqueue(node, skb, cb->endpoint_id,
+				QRTR_TYPE_RESUME_TX, &local, &remote);
 
 	qrtr_node_release(node);
 
-- 
2.34.1

