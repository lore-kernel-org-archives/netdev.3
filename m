Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156743;
	b=pncqFkwh+2/8OZAEG83V6DeSIp6my3WyFxUpboWoUkfFZ/ByBJEtATbY1r8184rHtQgO
	 vfg4iUUxOy0KRzvcN3GKE+cjm98YcMcT8T8G6FDLbW/eL1snIEJVrpxn+RF9AP4TLyM2S
	 bUlQlpQbqp+85DHaNqx5AJu7q0nBzmXYD5gK9Ch8NWBwxbHg6H5vnq+dTuQSwxO3I6yXq
	 YWGThbs8M0ZojYRVvHuF29VJFLgMxsT/LUIga+fMvQn2o6EKI+TRv/k1Rbljb7g2/sH3G
	 RBw1hw9ABGe9+W6F1Jvs1JMpCqkORxvV5Bym1RMCG7Yya43WiGcQjnvk8L/VygEaBbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156743;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GwkhSOyqaJ8SS9nC0FHxqRC5Vnzg20eV2SoYs0/aXik=;
	b=qvYajOZa19TvyFlROJ3qlmk8q2btZurDuqeVpv8xAvXCxWqxxx/hmd4atFiwfAH4POVS
	 KUhqwyIzIBjBOvs+5xozC4T37Yn/mpnrZUdvoth9uFRdc+txCW5JWyyMfNOvQpjDRP0We
	 mDVKsO+mUAsCJWudyI3ZekMP+w9dDmFBeogJYIpsJd7IYnwyMB3StKFlfiHkO5Z29Mkep
	 QPsqr1HX5m4JFdda9LVp7gwMkd15Aeja1YQvwP3YPcPf6h1I+VqRbRuYy6uuE3N3k5A3v
	 OLjt/Wtu4aqh5SLEgdHWo/pwW6S50EC6aldOdnGd1tDVU1m6BsAPGXocfFgr8/IGddw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vVIBvulo;
	arc=none smtp.remote-ip=95.215.58.245
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBC606A320
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61CBC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vVIBvulo
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2YRjNupIoI6u2MoQU53howwAJK6kPPfYlENuwKn4bUI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793156740; v=1; x=1793761540;
 b=vVIBvuloWMVrhI5hoPlpsoc9hIAEB7lYi0pkk8N4gE8dKU3eH6ulimC0AD5FkIkOFPNU6aMa
 8PTmisDCa/E0YaPcFNFLXCXJsKQnfrDNzjz/y5f5gLMo0d7dvYVJCYVMMICf1RUpNlXktzRIIKD
 F5tiTeHoRLHbaPojPYVcvCI8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9fb1fcb3a52b1262;
	Wed, 28 Oct 2026 03:05:25 +0000
X-Mizu-Trace-ID: 9fb1fcb3a52b1262
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Julius Bairaktaris <julius@bairaktaris.de>
Subject: [RFC net-next v2 2/2] pppoe: queue unbound packets directly
Date: Wed, 28 Oct 2026 11:05:06 +0800
Message-ID: <20261028030509.23294-2-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030509.23294-1-qingfang.deng@linux.dev>
References: <20261028030509.23294-1-qingfang.deng@linux.dev>
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
v2: new patch
---
 drivers/net/ppp/pppoe.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index fbd04e7252b2..ae4184dae8dd 100644
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
@@ -415,11 +387,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!po)
 		goto drop;
 
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
@@ -526,7 +499,6 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
 	sock->state	= SS_UNCONNECTED;
 	sock->ops	= &pppoe_ops;
 
-	sk->sk_backlog_rcv	= pppoe_rcv_core;
 	sk->sk_destruct		= pppoe_destruct;
 	sk->sk_state		= PPPOX_NONE;
 	sk->sk_type		= SOCK_STREAM;
-- 
2.43.0

