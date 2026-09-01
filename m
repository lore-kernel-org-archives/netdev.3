Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285247ACEB;
	Tue,  1 Sep 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268898; cv=pass; b=jiPaTfz97vEA/xOY7HgLsR5mS4wLoxA4zaQ36D31jzwJ99K/dUcICBJZp6xXDEhfK+v6G45jLeUSR7uzqhqgQYi5aQ07x0ELBPKw5zAKOhzlNWR6X3qeZ7mZgRccbDweDBx0gMKDUdwLtZQDNnLRoKfD5UlFgbHRY7P39uVKHw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268898; c=relaxed/simple;
	bh=QY1A8D3fH5Ocg0eZmlF5oy360Of+P5EZpl0ZY75wxxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgTPGADhSakiK0Pwi1wnIX/Y4GHb8O2+B0yTXT49N0O3PBNMJeXhgR1vPzLBwD6oQSlM4l4y1tFJ6cca4E52XEa87rm6/grxaF5lP4ngZEOFArx+507Q+U4Ke8HkdmGjzaE/6WHDBDRrn3Kl7Y+QNJXi3+fBJMyXkCy3EAnWRX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ny2k5K6I; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ny2k5K6I"
Received: from mandelbrot.. (xdsl-83-150-90-33.nebulazone.fi [83.150.90.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hZ62L4YKVz49QNC;
	Tue, 01 Sep 2026 16:21:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788268890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAv/+3HXe4Wk5FPqWwSHvR9+eMlqhJUTF/4hhmmGEYo=;
	b=ny2k5K6IZlZwNnLUOSQ7kr6uu3bc8x2auRaysFsxg1uTAtxUxI8ijBUDFHNeFh4x/lidi6
	b3TL4bQNBP7/XIm4qM626BACSRy69ykUwHa7X6CqJeo4bsfDegV4bMAYxvgGURwVaIej+b
	OmXKR2gI9siifxnelmlMFxSsnBCU6HU+uuxXFeiGf3Dj9VkXeoCgXj7FQlqEVWilJUm81f
	CIYZ/IR8zBOgpAWQQLCCDF1Qrd8dAy6h+Ls8Hbqx9DVmSBLFpa6Nkor4SoxOZ/IoJgNox0
	gZw4xjqVkqE9XWCTylpmq1BTpIFSEKSBziOGU8dpAGr+gYIKh6M3EHVyoyCYOA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788268890;
	b=SV97+SH80+8/H9DpiiFhIYeNqmslZAfXnXut01MZHzTUbwkN2VXzE/6yLFbmsXAw653kbS
	RrhCc89XA6djrj0FZ2afzbB1JKwELBWwKWsjIq4aqKOO/aBgvCpr4rYwL4ZJBEhPkF05tv
	enzBlLwsElnmK+x5SC7qOnc8my/KIJo8VXZCWkaVz8+40PAQP/+0tT5zTeiWwZnZNvWGBK
	OyfvaYrj7Pp4VS6TNIjFo5RCDhMgHBA15a775l1v+CreJBOdjmAnamyiumb6hC8PdrL3SB
	5VadtlWg4lfPztQ5/H3jUyJAnH9J1ayZmQtbBx0doVgj+f2c1OwgfN4aEnsCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788268890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LAv/+3HXe4Wk5FPqWwSHvR9+eMlqhJUTF/4hhmmGEYo=;
	b=sLM2JSmWztX45pxU8z1tlQ3ZFTcxxiLvmT9Ae+QdMceeH9KvYbolT227jKamaw9a/+N2CW
	jRnpCziVwEDwIy5G7f4t8TKZZ7IQgcEPMm7SC2U//9sx4yPRVq9aYI5XvAo0aywwlL9C3/
	4ve/4CdSDXmDDrTTWy5nkYkg9/11PKOJVI1S+tPOWzDKGopHLGJ41wuGJH8B+5tJuH9y3n
	sIjhoDnwFzzc1r+v2SY0Kuyx2oxUD55GiJh/BnPzr2zvdmWj5NO0L2xyrG3cMUPzJtzrkm
	koF6x8XmuLTbkFa6dPu3t8DQID0KBTTdogkOSruDxgkTl4sFmxhb47tBVF5rwQ==
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
Subject: [PATCH v6 08/15] net: qrtr: Allow sendmsg to target an endpoint
Date: Tue,  1 Sep 2026 16:19:27 +0300
Message-Id: <20260901131934.225991-9-juha-matti.tilli@iki.fi>
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

Allow QIPCRTR family sockets to include QRTR_ENDPOINT auxiliary data
as part of the sendmsg system call.  By including this parameter, the
client can ask the kernel to route the message to a given endpoint, in
situations where multiple endpoints with conflicting node identifier
sets exist in the system.

For legacy clients, or clients that do not include QRTR_ENDPOINT data,
the endpoint is looked up, as before, by only using the node identifier
of the destination qrtr socket address.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
Reviewed-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Andy Gross <agross@kernel.org>
Signed-off-by: Mihai Moldovan <ionic@ionic.de>
Signed-off-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
---
 net/qrtr/af_qrtr.c | 89 ++++++++++++++++++++++++++++++++++------------
 net/qrtr/qrtr.h    |  2 ++
 2 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index da7ccf19c6851..d4a472f0ac4d1 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -106,6 +106,36 @@ static inline struct qrtr_sock *qrtr_sk(struct sock *sk)
 	return container_of(sk, struct qrtr_sock, sk);
 }
 
+int qrtr_msg_get_endpoint(struct msghdr *msg, u32 *out_endpoint_id)
+{
+	struct cmsghdr *cmsg;
+	u32 endpoint_id = 0;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (!CMSG_OK(msg, cmsg))
+			return -EINVAL;
+
+		if (cmsg->cmsg_level != SOL_QRTR)
+			continue;
+
+		if (cmsg->cmsg_type != QRTR_ENDPOINT)
+			return -EINVAL;
+
+		if (cmsg->cmsg_len < CMSG_LEN(sizeof(u32)))
+			return -EINVAL;
+
+		/* Endpoint ids start at 1 */
+		endpoint_id = *(u32 *)CMSG_DATA(cmsg);
+		if (!endpoint_id)
+			return -EINVAL;
+	}
+
+	if (out_endpoint_id)
+		*out_endpoint_id = endpoint_id;
+
+	return 0;
+}
+
 static unsigned int qrtr_local_nid = 1;
 
 /* for node ids */
@@ -448,14 +478,23 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
  *
  * callers must release with qrtr_node_release()
  */
-static struct qrtr_node *qrtr_node_lookup(unsigned int nid)
+static struct qrtr_node *qrtr_node_lookup(unsigned int endpoint_id,
+					  unsigned int nid)
 {
-	struct qrtr_node *node;
+	struct qrtr_node *node = NULL;
 	unsigned long flags;
+	unsigned long key = 0;
+
+	if (endpoint_id > QRTR_INDEX_HALF_UNSIGNED_MAX ||
+	    nid > QRTR_INDEX_HALF_UNSIGNED_MAX)
+		return node;
+
+	key = ((unsigned long)(endpoint_id) << QRTR_INDEX_HALF_BITS) |
+	      ((unsigned long)(nid) & QRTR_INDEX_HALF_UNSIGNED_MAX);
 
 	mutex_lock(&qrtr_node_lock);
 	spin_lock_irqsave(&qrtr_nodes_lock, flags);
-	node = radix_tree_lookup(&qrtr_nodes, nid);
+	node = radix_tree_lookup(&qrtr_nodes, key);
 	node = qrtr_node_acquire(node);
 	spin_unlock_irqrestore(&qrtr_nodes_lock, flags);
 	mutex_unlock(&qrtr_node_lock);
@@ -1019,6 +1058,7 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
 	struct sock *sk = sock->sk;
 	struct qrtr_node *node;
+	u32 msg_endpoint_id;
 	u32 endpoint_id = qrtr_local_nid;
 	struct sk_buff *skb;
 	size_t plen;
@@ -1031,46 +1071,48 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (len > 65535)
 		return -EMSGSIZE;
 
+	rc = qrtr_msg_get_endpoint(msg, &msg_endpoint_id);
+	if (rc < 0)
+		return rc;
+
 	lock_sock(sk);
 
 	if (addr) {
-		if (msg->msg_namelen < sizeof(*addr)) {
-			release_sock(sk);
-			return -EINVAL;
-		}
+		rc = -EINVAL;
 
-		if (addr->sq_family != AF_QIPCRTR) {
-			release_sock(sk);
-			return -EINVAL;
-		}
+		if (msg->msg_namelen < sizeof(*addr))
+			goto release_sock;
+
+		if (addr->sq_family != AF_QIPCRTR)
+			goto release_sock;
 
 		rc = qrtr_autobind(sock);
-		if (rc) {
-			release_sock(sk);
-			return rc;
-		}
+		if (rc)
+			goto release_sock;
 	} else if (sk->sk_state == TCP_ESTABLISHED) {
 		addr = &ipc->peer;
 	} else {
-		release_sock(sk);
-		return -ENOTCONN;
+		rc = -ENOTCONN;
+		goto release_sock;
 	}
 
 	node = NULL;
 	if (addr->sq_node == QRTR_NODE_BCAST) {
 		if (addr->sq_port != QRTR_PORT_CTRL &&
 		    qrtr_local_nid != QRTR_NODE_BCAST) {
-			release_sock(sk);
-			return -ENOTCONN;
+			rc = -ENOTCONN;
+			goto release_sock;
 		}
 		enqueue_fn = qrtr_bcast_enqueue;
 	} else if (addr->sq_node == ipc->us.sq_node) {
 		enqueue_fn = qrtr_local_enqueue;
 	} else {
-		node = qrtr_node_lookup(addr->sq_node);
+		endpoint_id = msg_endpoint_id;
+
+		node = qrtr_node_lookup(endpoint_id, addr->sq_node);
 		if (!node) {
-			release_sock(sk);
-			return -ECONNRESET;
+			rc = endpoint_id ? -ENXIO : -ECONNRESET;
+			goto release_sock;
 		}
 		enqueue_fn = qrtr_node_enqueue;
 	}
@@ -1109,6 +1151,7 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 out_node:
 	qrtr_node_release(node);
+release_sock:
 	release_sock(sk);
 
 	return rc;
@@ -1123,7 +1166,7 @@ static int qrtr_send_resume_tx(struct qrtr_cb *cb)
 	struct sk_buff *skb;
 	int ret;
 
-	node = qrtr_node_lookup(remote.sq_node);
+	node = qrtr_node_lookup(cb->endpoint_id, remote.sq_node);
 	if (!node)
 		return -EINVAL;
 
diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
index 11b897af05e67..22fcecbf8de23 100644
--- a/net/qrtr/qrtr.h
+++ b/net/qrtr/qrtr.h
@@ -34,4 +34,6 @@ int qrtr_ns_init(void);
 
 void qrtr_ns_remove(void);
 
+int qrtr_msg_get_endpoint(struct msghdr *msg, u32 *out_endpoint_id);
+
 #endif
-- 
2.34.1

