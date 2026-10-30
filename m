Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336401;
	b=XeS/TjKsuSgUv+aUBEhGT3Q37PlAiYg7NdoFXS+ilP6HPaJKkC43hYDiRA4dXPKQCsZP
	 tAps5G8N18c4Dj3fO33AhzvsjmF+Xc/8Q+Jv28D4hqkX5ql54GANRtgBOAGPUeiKvSnrO
	 YikNeop4G4RS3TWCVs99JmmaLAbRdo7uzg9JtPEZBhSO+3OZTOka4Su9/0tUY6YT9Z5GV
	 /+up9JT/e8cpo8BZzdRCwOWnEF+byKYBGQyG0dh6ebpKVkLOMyWwGZXny5yKjmxi1Gy3C
	 9UIPe3Btt/BL69lcP7bPOPLDW5lYs0dKM/RwVc9M8Mvfp0lSzpqP2JOF2idpsa77V8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336401;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pUwW+Q+fP9ElwS+xsgVw2JVUV+TCf0ulxE6EbLfKDsI=;
	b=HVRseol8m1PtlgLgxMx54zuThoVPeZrJmwZGlqzSYbkLiLIiT9tcZyybQoD1qr8qgqzn
	 Ri+4AWHOGHoSiVGxSuejJovJoxxr4dSAHTFPeZf/bVh2REb/m1PW6+ZMFl7e+JsiTS0sr
	 MrU1nUc/IlnmZvTjT4rRu7u7G9RbwMNbqeCRgCBGpM1GLtHWFgU+hknxo++EuD5FiaTK9
	 fTB5X3PqXzNLjxO272jeYXYVLQ8jIybbK9PPqEbEzJDPi/gmgg6N/6qEPShf/2jO/juen
	 37vKrYw4dQtM07NFhw1qlMb75GcMml4kqdyTo8HtUrxyxSvD3pT4p5jH2cKpt4qcHgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goyJE6vw;
	arc=none smtp.remote-ip=91.218.175.183
Received: from mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4686606A321
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4686606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goyJE6vw
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7INZl9V8c9lADPRhKXiT3npFSikzWhOKiZ0A9YakGvc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793336398; v=1; x=1793941198;
 b=goyJE6vw6RCGRrIln89nnLLljc+5AUHN+6oFP7/sG1/i9OYHaCD1rD2bPpbVQG7HicL4qCnF
 FyVJkazmXGJojJS5wQaW8A93Px9ny2+VgfOCac7IMrYPYPEa/vKBy08Ygu7/flqG5xxGGHX4vkq
 mcUudeSuACNZSVmtQxRfXJ90=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d90e731cd17644cd;
	Fri, 30 Oct 2026 04:59:58 +0000
X-Mizu-Trace-ID: d90e731cd17644cd
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
Subject: [PATCH net-next v3 2/2] pppoe: queue unbound packets directly
Date: Fri, 30 Oct 2026 12:59:40 +0800
Message-ID: <20261030045943.2093-2-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030045943.2093-1-qingfang.deng@linux.dev>
References: <20261030045943.2093-1-qingfang.deng@linux.dev>
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
v3: no changes
v2: https://lore.kernel.org/netdev/20261028030509.23294-2-qingfang.deng@linux.dev/
---
 drivers/net/ppp/pppoe.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index a1ed756a6220..6bd7d4b4da6e 100644
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

