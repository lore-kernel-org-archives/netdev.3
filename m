Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA247ACEB;
	Tue,  1 Sep 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268905; cv=pass; b=oCnDZzg+s95OCAsbLgxNTq2MiSe+qz0ufFqtB2bg6+msytZYc27UVDbF2JTdhGsVMlaCxC3OfExi3Ob+QOGhp1ze53V5YXqJM57CjpeAOoz7VdQF/cW70259FBZtW6vkhhyssiyGrQS7ATI3Dpl65ffKme120+MJFqg7/PeqUa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268905; c=relaxed/simple;
	bh=tKWTf1cazHWaXntnYsiXxrJYnrU+iW5fvyj/sDkCDtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hy4hm/1fMk/HL76m2TpYo3i4HqpiCRVfypp270BNqWfbkxdg9KoQIc5DEkK3I9v8pUGrkjmsU2pBL2Crp3VqRpc63CB/13M2+qr8v4PAPqnYcdsf7IbBvaY0F7BfDXX2xvWr0N8vyBlTT2CtVtCrjMJSxQJA3Qz+0IUMqd/Y5EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=RgFq6W1E; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="RgFq6W1E"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ62V0lG1z49QNp;
	Tue, 01 Sep 2026 16:21:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1zGVynj9H5SONi5WNNQRZuKnULVYkGJU/Lsk8iTgW0=;
	b=RgFq6W1EfHAeDT9HqtDjC82r1ZHuxvqQmLJTQ3kU4Uhk4gLOujgMpbf4zRDCEA6zJkJS/p
	VwrjenzmZoGbU8sEOeUW4BugUBoBGDcXrAXhrHkQTPIPVAV6PJuykns1D0kSqXIskDv6S1
	IdyuXTNSPi3/pwR0lneJlaQf5YRbT2+S/fU7YyVIfYOYdnteeeK+o/TzzPkW+mmA6mAET/
	RvV8fWc+7KmZRIODIF0tCOVvv+pjzpAYyu8eTFANkwyoUhpwbJ4yMpKdQ3WvzHGoOrWW7T
	0ibDpC6MOyE/y86+YV3Ht7z4d7iwr4Q8pK7OZqX7p9Khzy1yVCQ+tC+dDsHbTQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268898;
	b=K1xB4FoD+661Ioa4HZ4tX3wRK9++BYIClgyXRKo0OuMtRN1L842IsB1tyWtcR0QfyASAAq
	wnHj/Xw33817rXH7EwCO3z+mEnt0rzzaDyKUPV97xw1a9PUG2keKP0ZlDAoto50MgZMxMd
	X3JsNPdHbcV1j3tEhJyOWzw8rLWzllcSia340cgKparfSz1bIDA80uN901t9QCM08i903X
	EOg2gBQsBe11ynw6T9OjQfo2FTyl+5kzK3CHnjwbrfv/ga0Exq4IkUguuHattZUtNBQ3cY
	fg9B/I3PVvDgJr1w17ZfyqxUvE6lNnebgixFPHzfhFL9/B+kaixMmky8naLy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1zGVynj9H5SONi5WNNQRZuKnULVYkGJU/Lsk8iTgW0=;
	b=Nxu7K3lAPpg1lB8EJxLsyMAu6QiY4tobSGKZAyHXCNRZZAZPuUX/kMHn25kAp3W2q1LEom
	Mglkqr7+1JT9Omuo8ZasSOrXBp9J1uKvtu6Ky7CHyQZFG0+rPGCUBJLD1nSkIYRChmX5n1
	8y7YYRemuOWtWb0gyMgbHKN+D/MsSfZ4e+/n3eQi84x2XEALNwfoqzsc1Te1MOCtWXCw4e
	g3z+enJLv2HbRfUnjquQpiKzQV2WqmxkfQcY03Ug4yXDzLGKNkl2EjrAoggQXKlenP3j4N
	kDdqeMtpSKjvRWchRWfqff7n8BaYefEgiQ/NB0JMnPHgaZmSmm2sj+JOh407jA==
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
Subject: [PATCH v6 09/15] net: qrtr: allow socket endpoint binding
Date: Tue,  1 Sep 2026 16:19:28 +0300
Message-Id: <20260901131934.225991-10-juha-matti.tilli@iki.fi>
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

Introduce the ability to bind a QIPCRTR family socket to a specific
endpoint.  When a socket is bound, only messages from the bound
endpoint can be received, and any messages sent from the socket are
by default directed to the bound endpoint.  Clients can bind a socket
by using the setsockopt system call with the QRTR_BIND_ENDPOINT option
set to the desired endpoint binding.

A previously set binding can be reset by setting QRTR_BIND_ENDPOINT
option to zero.  This behavior matches that of SO_BINDTOIFINDEX.

This functionality is useful for clients that need to communicate
with a specific device (i.e. endpoint), such as a PCIe-based 5G modem,
and are not interested in messages from other endpoints / nodes.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 include/uapi/linux/qrtr.h |  1 +
 net/qrtr/af_qrtr.c        | 56 ++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/qrtr.h b/include/uapi/linux/qrtr.h
index 6d0911984a050..0a8667b049c3d 100644
--- a/include/uapi/linux/qrtr.h
+++ b/include/uapi/linux/qrtr.h
@@ -48,6 +48,7 @@ struct qrtr_ctrl_pkt {
 
 /* setsockopt / getsockopt */
 #define QRTR_REPORT_ENDPOINT 1
+#define QRTR_BIND_ENDPOINT 2
 
 /* CMSG */
 #define QRTR_ENDPOINT 1
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index d4a472f0ac4d1..ccfa3ed33a996 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -98,6 +98,7 @@ struct qrtr_sock {
 	struct sockaddr_qrtr us;
 	struct sockaddr_qrtr peer;
 	unsigned long flags;
+	u32 bound_endpoint;
 };
 
 static inline struct qrtr_sock *qrtr_sk(struct sock *sk)
@@ -656,10 +657,14 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 			goto err;
 		}
 
-		ret = sock_queue_rcv_skb(&ipc->sk, skb);
-		if (ret) {
-			qrtr_port_put(ipc);
-			goto err;
+		/* Sockets bound to an endpoint only rx from that endpoint */
+		if (!ipc->bound_endpoint ||
+		    ipc->bound_endpoint == cb->endpoint_id) {
+			ret = sock_queue_rcv_skb(&ipc->sk, skb);
+			if (ret) {
+				qrtr_port_put(ipc);
+				goto err;
+			}
 		}
 
 		qrtr_port_put(ipc);
@@ -999,29 +1004,41 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 {
 	struct qrtr_sock *ipc;
 	struct qrtr_cb *cb;
+	int ret = -ENODEV;
 
 	ipc = qrtr_port_lookup(to->sq_port);
-	if (!ipc || &ipc->sk == skb->sk) { /* do not send to self */
-		if (ipc)
-			qrtr_port_put(ipc);
-		kfree_skb(skb);
-		return -ENODEV;
-	}
+	if (!ipc)
+		goto done;
+
+	if (&ipc->sk == skb->sk) /* do not send to self */
+		goto done;
+
+	/*
+	 * Filter out unwanted packets that are not on behalf of the bound
+	 * endpoint.  Certain special packets (such as an empty NEW_SERVER
+	 * packet that serves as a sentinel value) always go through.
+	 */
+	if (endpoint_id && ipc->bound_endpoint &&
+	    ipc->bound_endpoint != endpoint_id)
+		goto done;
 
 	cb = (struct qrtr_cb *)skb->cb;
 	cb->src_node = from->sq_node;
 	cb->src_port = from->sq_port;
 	cb->endpoint_id = endpoint_id;
 
-	if (sock_queue_rcv_skb(&ipc->sk, skb)) {
-		qrtr_port_put(ipc);
-		kfree_skb(skb);
-		return -ENOSPC;
-	}
+	ret = -ENOSPC;
+	if (sock_queue_rcv_skb(&ipc->sk, skb))
+		goto done;
 
 	qrtr_port_put(ipc);
 
 	return 0;
+done:
+	if (ipc)
+		qrtr_port_put(ipc);
+	kfree_skb(skb);
+	return ret;
 }
 
 /* Queue packet for broadcast. */
@@ -1107,7 +1124,8 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (addr->sq_node == ipc->us.sq_node) {
 		enqueue_fn = qrtr_local_enqueue;
 	} else {
-		endpoint_id = msg_endpoint_id;
+		endpoint_id = msg_endpoint_id ?
+			      msg_endpoint_id : ipc->bound_endpoint;
 
 		node = qrtr_node_lookup(endpoint_id, addr->sq_node);
 		if (!node) {
@@ -1385,6 +1403,9 @@ static int qrtr_setsockopt(struct socket *sock, int level, int optname,
 	case QRTR_REPORT_ENDPOINT:
 		assign_bit(QRTR_F_REPORT_ENDPOINT, &ipc->flags, val);
 		break;
+	case QRTR_BIND_ENDPOINT:
+		WRITE_ONCE(ipc->bound_endpoint, val);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 	}
@@ -1413,6 +1434,9 @@ static int qrtr_getsockopt(struct socket *sock, int level, int optname,
 	case QRTR_REPORT_ENDPOINT:
 		val = test_bit(QRTR_F_REPORT_ENDPOINT, &ipc->flags);
 		break;
+	case QRTR_BIND_ENDPOINT:
+		val = READ_ONCE(ipc->bound_endpoint);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 	}
-- 
2.34.1

