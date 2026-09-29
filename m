Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EC38911E
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664495; cv=none; b=U2kIm+mTOvqbaCLIjbNM1A9W1x/DmLd6628WdnoGMv2R3BSo0qMBoZPuomGrYVtQTglqZhc+XOTLxYwspgn/NgQFnbR0XvnxCXb5nuqrKd5axoF2yK9EHO0ghomS28Wef5DjN5LBA3xKK4yK0rOvy2dvQqPg4YZAld70zukATS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664495; c=relaxed/simple;
	bh=3+NmjIvERmuBnY7QcUewdlPOEpascZaRK8T4x+QhvdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1b2C6il18lmHT9G6bjGex81sJ0AfaY3kHiYQntcn6pMlZFsJ4PFStBAoOJXHJLXe07ceX0J3AeFushfVmBIFpBiJzL7MN0T8tQMgIWA+gJK/CC8qgZd5PRITEyN/iaqbpO7CIJg4Zojz0izxrK1LlUxrZIItxnSuxVbRzWS3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlax1MEM; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlax1MEM"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86b90133ae8so1785014b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790664493; x=1791269293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b7oLTvJ6ByQ0hBew9gX2lRalj9dmq5ZT/5F39nYxjWE=;
        b=Rlax1MEMCw31f956caVQBWuC+0BnkXKE+q0s6XzTPc0f+8pb6+MK2xzUJxt85hVaxt
         dgMfplZ0C1sl/DK33gjtk7NSwqLE70Jh9hOfKHDwdqbQXiwszGoyM3RaZPnfKm1akRKb
         PSrzfO50nFRmXMeyewbLJEcgsIrHzB2okGj7Wp8+bxSC45kEH7jQl7XMclq+Im/8ZeZE
         qMzi3CQU4AhZjPuWEXxiUSuicFYSV1xGP2jwJmwi7aXHZCFddkMrauT7ofYes+heyIxT
         mKghRbhI46c0+DgulboHmBJmuskPAQu6JT2ZAIQFigtu61rRYxWjFEM/1wg+5nnQp9It
         OQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790664493; x=1791269293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b7oLTvJ6ByQ0hBew9gX2lRalj9dmq5ZT/5F39nYxjWE=;
        b=Ugo2yC4cAsZ8rkZsHFmCumxyHHEuiRwEKz35JWMAkzGCDqeWAFNUSE1QQnUgcxJisU
         mW+aamN0qeJOqMj8FZ0IyGTW9pi/uqg/NZl471CyhMtd7oqNFhECX8VAijBWlrSOf+7k
         bgYx6iiTeWWvLK6vuCh89Fv3xo+s/KJjjXoiKUASsH9SBsXs0HHzTnu+NRgPfsoJdi7Y
         ZkbPSBe3XnF2PUevDLt5hq2GZifDjWuIcGYuYZcLD7fGtC3teqn/9/e1TnI9soIGJCle
         v5rZQ7iw1PQlwg0DC1cIVxaK4eAE1+Grx8SRdEw16Pjbl7gYZhLWW40S3cz0YaBdf5xZ
         oAOg==
X-Gm-Message-State: AFuF++kZVioKMDjxrd8EeGd9eLd7HdEY4wit9r1SDHwcSgIWCjJ0t+tN
	5BdKIPdMP+t4X6nm10aSFmq80zdVcPNTr8IXRhxkUwcFuN/VQwtD0ZSk5alcnMSDTMM=
X-Gm-Gg: AYBFou0brHe1Ej8WWX/vFCjy864EMXODo0Zt+MUMxTmvMOjKTOUr14KxMbLVxtvrbvm
	LxOTQAxuEJ9CcYP0/+0Lj08tJEl6F1rgnQp4Bs5hcdqm4oxNn1DJ4jd+UQ/om1tn5yhD5hqdhXp
	RGgYvfjmldsnykW6T5cC+9UJcIqz82xwUDa7fbatl70z1qzS+TWt50BbKaJh7FTVmWZ6qekO7Cb
	MY6F4a+yNGnieRbwsbdATIfBCeXVGlyzfQzLfWXyaDR021EslSYkISm6s9tkM26EanOVKJPr591
	5n4BIZN5HD3A3VI2iPTMOTCPq4VmywIFjg2Bq1ZHisBM9tdX7YBUapDMIPB03rWGGwZxLLp5qWn
	BEBCVw2/Cwy+u0NngJJYJKqjPPXc/rR5y4QbkTjt24nFgxRFLElXnC1vs5iIEriDpf+cYIbnQMD
	J2BUIxeumg5OqzbV/9ngA2Z2O9+FqeVcdk86diwEZcQDYGEuZq1mN5y8abU6FIiOSTC18LSIrnY
	VCXb53ZCsOqTLnDJOvw6Co14mTQ6w==
X-Received: by 2002:a05:6a00:8013:b0:882:6668:f022 with SMTP id d2e1a72fcca58-88266783c32mr6324085b3a.17.1790664492686;
        Mon, 28 Sep 2026 23:48:12 -0700 (PDT)
Received: from lsk.tail206e42.ts.net (vps-787f8425.vps.ovh.us. [2604:2dc0:202:300::17a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e1066470sm266922b3a.18.2026.09.28.23.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 23:48:12 -0700 (PDT)
From: liushike <liushike123@gmail.com>
To: netdev@vger.kernel.org
Cc: jmaloy@redhat.com,
	tung.quang.nguyen@est.tech,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 1/2] tipc: abort pending connects when the peer node is lost
Date: Tue, 29 Sep 2026 06:47:41 +0000
Message-Id: <20260929064742.576651-2-liushike123@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929064742.576651-1-liushike123@gmail.com>
References: <20260929064742.576651-1-liushike123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liushike <liushike@ruijie.com.cn>

A client can send a SYN and block in connect() while the listening server
has not yet called accept(). If the last usable link to that server is
lost, the client may remain asleep until its connection timeout expires.
Only established connections are in the peer node's conn_sks list, so
node_lost_contact() cannot notify the pending connection.

Register an active open before sending SYN and check node availability
under the node write lock. Let the existing node-loss notification abort
the pending handshake with EHOSTUNREACH and wake the connect waiter.
Losing one link does not abort the connect while another link survives.

Update the listening port to the accepted port in place on receipt of
ACK, preserving the node-loss registration. Reject a late ACK if node
loss already removed the registration, even if the node has recovered.
Transfer the registration when a named SYN is rerouted to another node.
Avoid registering active opens twice; remove registrations on transmit
failure and terminal rejection, but retain them across overload retries
and connection-wait timeouts, which do not cancel the handshake.

Signed-off-by: liushike <liushike@ruijie.com.cn>
---
 net/tipc/node.c   | 37 ++++++++++++++++++++++++++++++++++++-
 net/tipc/node.h   |  1 +
 net/tipc/socket.c | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..31f2ef44ad37 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -713,13 +713,48 @@ int tipc_node_add_conn(struct net *net, u32 dnode, u32 port, u32 peer_port)
 	conn->peer_port = peer_port;
 
 	tipc_node_write_lock(node);
-	list_add_tail(&conn->list, &node->conn_sks);
+	if (node_is_up(node)) {
+		list_add_tail(&conn->list, &node->conn_sks);
+	} else {
+		err = -EHOSTUNREACH;
+		kfree(conn);
+	}
 	tipc_node_write_unlock(node);
 exit:
 	tipc_node_put(node);
 	return err;
 }
 
+/* Replace the listening port with the accepted port without losing the
+ * node loss subscription. A missing entry means node_lost_contact() has
+ * already aborted this connection attempt, even if the node is up again.
+ */
+int tipc_node_update_conn(struct net *net, u32 dnode, u32 port, u32 peer_port)
+{
+	struct tipc_sock_conn *conn;
+	struct tipc_node *node;
+	int err = -EHOSTUNREACH;
+
+	if (in_own_node(net, dnode))
+		return 0;
+
+	node = tipc_node_find(net, dnode);
+	if (!node)
+		return err;
+
+	tipc_node_write_lock(node);
+	list_for_each_entry(conn, &node->conn_sks, list) {
+		if (conn->port != port)
+			continue;
+		conn->peer_port = peer_port;
+		err = 0;
+		break;
+	}
+	tipc_node_write_unlock(node);
+	tipc_node_put(node);
+	return err;
+}
+
 void tipc_node_remove_conn(struct net *net, u32 dnode, u32 port)
 {
 	struct tipc_node *node;
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 154a5bbb0d29..48693a050aa8 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -107,6 +107,7 @@ void tipc_node_subscribe(struct net *net, struct list_head *subscr, u32 addr);
 void tipc_node_unsubscribe(struct net *net, struct list_head *subscr, u32 addr);
 void tipc_node_broadcast(struct net *net, struct sk_buff *skb, int rc_dests);
 int tipc_node_add_conn(struct net *net, u32 dnode, u32 port, u32 peer_port);
+int tipc_node_update_conn(struct net *net, u32 dnode, u32 port, u32 peer_port);
 void tipc_node_remove_conn(struct net *net, u32 dnode, u32 port);
 int tipc_node_get_mtu(struct net *net, u32 addr, u32 sel, bool connected);
 bool tipc_node_is_up(struct net *net, u32 addr);
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index d5d70eb230b5..191579636351 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1511,6 +1511,16 @@ static int __tipc_sendmsg(struct socket *sock, struct msghdr *m, size_t dlen)
 		return -ENOMEM;
 	}
 
+	/* Subscribe before sending SYN so node loss also aborts pending connects. */
+	if (syn) {
+		rc = tipc_node_add_conn(net, skaddr.node, tsk->portid, skaddr.ref);
+		if (rc) {
+			__skb_queue_purge(&pkts);
+			__skb_queue_purge(&sk->sk_write_queue);
+			return rc;
+		}
+	}
+
 	/* Send message */
 	trace_tipc_sk_sendmsg(sk, skb_peek(&pkts), TIPC_DUMP_SK_SNDQ, " ");
 	rc = tipc_node_xmit(net, &pkts, skaddr.node, tsk->portid);
@@ -1520,6 +1530,11 @@ static int __tipc_sendmsg(struct socket *sock, struct msghdr *m, size_t dlen)
 		rc = 0;
 	}
 
+	if (unlikely(syn && rc)) {
+		tipc_node_remove_conn(net, skaddr.node, tsk->portid);
+		__skb_queue_purge(&sk->sk_write_queue);
+	}
+
 	if (unlikely(syn && !rc)) {
 		tipc_set_sk_state(sk, TIPC_CONNECTING);
 		if (dlen && timeout) {
@@ -1674,8 +1689,10 @@ static void tipc_sk_finish_conn(struct tipc_sock *tsk, u32 peer_port,
 	msg_set_hdr_sz(msg, SHORT_H_SIZE);
 
 	sk_reset_timer(sk, &sk->sk_timer, jiffies + CONN_PROBING_INTV);
+	/* Active opens already subscribed before sending SYN. */
+	if (sk->sk_state != TIPC_CONNECTING)
+		tipc_node_add_conn(net, peer_node, tsk->portid, peer_port);
 	tipc_set_sk_state(sk, TIPC_ESTABLISHED);
-	tipc_node_add_conn(net, peer_node, tsk->portid, peer_port);
 	tsk->max_pkt = tipc_node_get_mtu(net, peer_node, tsk->portid, true);
 	tsk->peer_caps = tipc_node_get_capabilities(net, peer_node);
 	tsk_set_nagle(tsk);
@@ -2199,12 +2216,14 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 	struct net *net = sock_net(sk);
 	struct tipc_msg *hdr = buf_msg(skb);
 	bool con_msg = msg_connected(hdr);
+	bool reject_ack = false;
 	u32 pport = tsk_peer_port(tsk);
 	u32 pnode = tsk_peer_node(tsk);
 	u32 oport = msg_origport(hdr);
 	u32 onode = msg_orignode(hdr);
 	int err = msg_errcode(hdr);
 	unsigned long delay;
+	int rc;
 
 	if (unlikely(msg_mcast(hdr)))
 		return false;
@@ -2216,6 +2235,18 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 		if (likely(con_msg)) {
 			if (err)
 				break;
+			rc = tipc_node_update_conn(net, pnode, tsk->portid, oport);
+			/* A named SYN may have been rerouted to another node. */
+			if (!rc && onode != pnode) {
+				tipc_node_remove_conn(net, pnode, tsk->portid);
+				rc = tipc_node_add_conn(net, onode, tsk->portid, oport);
+			}
+			if (rc) {
+				err = TIPC_ERR_NO_NODE;
+				/* Return a late ACK to its sender, including any data. */
+				reject_ack = true;
+				break;
+			}
 			tipc_sk_finish_conn(tsk, oport, onode);
 			msg_set_importance(&tsk->phdr, msg_importance(hdr));
 			/* ACK+ message with data is added to receive queue */
@@ -2285,9 +2316,10 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 	}
 	/* Abort connection setup attempt */
 	tipc_set_sk_state(sk, TIPC_DISCONNECTING);
-	sk->sk_err = ECONNREFUSED;
+	tipc_node_remove_conn(net, pnode, tsk->portid);
+	sk->sk_err = err == TIPC_ERR_NO_NODE ? EHOSTUNREACH : ECONNREFUSED;
 	sk->sk_state_change(sk);
-	return true;
+	return !reject_ack;
 }
 
 /**
-- 
2.34.1

