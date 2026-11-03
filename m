Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704652;
	b=YQYuGMPQKpVeuxO05ZBPZWA1F5oxpj3g6uknX2hgMFJFJFuDdpd+QHjwwkC78X3xuu+e
	 jR7IAYo/xYP6JfudZNKGghxvcTq+eSHuinueRLkR95TA9HJ3AKwigBPRqZA4mcrvQheAZ
	 76sn2KD3rvGQhWziBQQLIO84V2M391kAxGmYGc0/iAPZaqVCuA6Oxcl7+LNBsr+WvBGcJ
	 txr1mvIOeugXIhOJANnBvaIQK5+HexKlyhdHWs32j1qJEbPzehlIMXYvTHXr6EUTvRt9l
	 TTv8Riyf6dgbqZdCqd7wWywQCyeS5W9cYswZuuXoH5wBOgSbRYIQMxWI+2me+24Gf4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704652;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hFYlYc5PM0tE3sH4k8YQSdBsYLlcumfy6xEhllgkK9Y=;
	b=0dnShlMv4cn3z1C4QnZtwm00V4XlFchALRz4sSL5EpKI5UVasKvqZMsVC6xJ7puqTgF0
	 EN71nPYBZQQqQBv6sZUnJBlY+HliiGSaiUFS/NTF5x2YAAMH9H0RyDVfC9Ij7ZC+41lpa
	 bqE17UO0S20S8KBbFzs7UeaY7RuLq9VVfflytmVOYBNTo5ceK99fgBxYOfA2R+rwrkSGU
	 MXHWAJQJKuYWy08VAbf07KCA/vxdPLBZICuDZk3yHRyPiLwxUToXYFHZzpXv7y0mqCyE5
	 3m87LFWLCcRrjLZkIIaGbVmRqrA36TpZNAZKTLYjx0/EAC2ZkHyVBEG6jB1JnCCrCMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vWAQio1G;
	arc=none smtp.remote-ip=91.218.175.157
Received: from mta0.migadu.com (out-157.mta0.migadu.com [91.218.175.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38E606C595
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE38E606C595
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vWAQio1G
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=er7vEvw7eEQfgtWtDDwvcrrNONf3+8zJKkLeBQQrLno=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793704648; v=1; x=1794309448;
 b=vWAQio1GEpaJzMDT/yYOHxEr8oDaOki9qb8/LOO/5AlQpsZc0CjZZk8of5q9SMkGZOn0ctcN
 O0CXJ+MKPtfbOPEQm43eKQAP7y36J5H2QOZygYEzBQd7+lEPnlkZaMY12r92wmCT4pf54t41ZbL
 vktUPP1yfqNpc7/4Z3ycxbrw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e89f1b07798417ab;
	Tue, 03 Nov 2026 11:17:27 +0000
X-Mizu-Trace-ID: e89f1b07798417ab
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/2] pppoe: queue unbound packets directly
Date: Tue,  3 Nov 2026 19:17:10 +0800
Message-Id: <20261103111711.28202-2-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103111711.28202-1-qingfang.deng@linux.dev>
References: <20261103111711.28202-1-qingfang.deng@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue unbound packets directly with sock_queue_rcv_skb() and remove
the unused backlog callback.

Previously, __sk_receive_skb() serialized receive processing with
PPPIOCGCHAN through the socket lock. Receivers either finished before
the ioctl acquired ownership or ran from the backlog after PPPOX_BOUND
was set.

The new lockless path relies on synchronize_net() from commit
92c1bf630abf ("pppox: drain queued packets on channel handoff").
After setting PPPOX_BOUND, PPPIOCGCHAN waits for receivers that saw
the old state to finish queueing before draining sk_receive_queue
into PPP. This prevents packets from being stranded after handoff.
SOCK_RCU_FREE protects the socket lifetime during teardown.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v4: no changes

v3:
https://lore.kernel.org/netdev/20261030045943.2093-2-qingfang.deng@linux.dev/
---
 drivers/net/ppp/pppoe.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 5d5187e4976b..51445fddb4d3 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -340,35 +340,7 @@ static struct notifier_block pppoe_notifier = {
 
 /************************************************************************
  *
- * Do the real work of receiving a PPPoE Session frame.
- *
- ***********************************************************************/
-static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
-{
-	struct pppox_sock *po = pppox_sk(sk);
-
-	/* Backlog receive. Semantics of backlog rcv preclude any code from
-	 * executing in lock_sock()/release_sock() bounds; meaning sk->sk_state
-	 * can't change.
-	 */
-
-	if (sk->sk_state & PPPOX_BOUND) {
-		ppp_input(&po->chan, skb);
-	} else {
-		if (sock_queue_rcv_skb(sk, skb))
-			goto abort_kfree;
-	}
-
-	return NET_RX_SUCCESS;
-
-abort_kfree:
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-/************************************************************************
- *
- * Receive wrapper called in BH context.
+ * Receive a PPPoE Session frame.
  *
  ***********************************************************************/
 static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
@@ -417,11 +389,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	skb->dev = NULL;
 
-	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
+	if (likely(po->sk.sk_state & PPPOX_BOUND))
 		ppp_input(&po->chan, skb);
-		return NET_RX_SUCCESS;
-	}
-	return __sk_receive_skb(&po->sk, skb, 0, 1, false);
+	else if (sock_queue_rcv_skb(&po->sk, skb))
+		goto drop;
+
+	return NET_RX_SUCCESS;
 
 drop:
 	kfree_skb(skb);
@@ -528,7 +501,6 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
 	sock->state	= SS_UNCONNECTED;
 	sock->ops	= &pppoe_ops;
 
-	sk->sk_backlog_rcv	= pppoe_rcv_core;
 	sk->sk_destruct		= pppoe_destruct;
 	sk->sk_state		= PPPOX_NONE;
 	sk->sk_type		= SOCK_STREAM;
-- 
2.34.1

