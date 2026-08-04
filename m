Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41503429CEF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829540; cv=none; b=YAB+VuKWFSryH1FxF5BuSwoUcDt3q0JayzS40tamYbWeTlem98JCFoXE0EJJsvkbZhAppwp9xtxUgJ+cfDsSDL/IPu5RMR3WYymfic2idapgfrUA1LxFBgdYyozkfS56pegon/8o1eXGxDE+MfDQobMZnvLUbKP4DFprk+oLhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829540; c=relaxed/simple;
	bh=2RlmN3sgqp9WHsXqioLXIcYivJBWcywepD/647jK51Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxoRk9/tuuR9okYXXFyeOPPJclStRopyXs6Fj6OmFkXl7ne/XgOglxNsDr1jHy+OX5GJT8PB3xz9ryenia5eEQjcpm58vohOjLWCr6iGg4bw4EtxO/g+XwwBBiy4uNB1grSbBxgzyo2O4eQFGKuUyZPrUUaLEMHy7u4aMISffi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GFIX43b5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GFIX43b5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785829526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRfFInjJf/bMgDbl6yuOL4E9YQkxpA9l/Y7rsAspSY8=;
	b=GFIX43b5egGwO4UGExij7o0iadKnI6QIKHWIyihw90sFU6Dl6xqYhFhqyu9mTOjiN0cd6C
	/+p3SBt7diar1TKULIwGMKTLNZnXNYefm8VIcl4wM7yrZcJ79yt5k7cZNdjOVw7/NbCmlT
	0wjoj9tXLfrnKXC3i3PCoiUQ4vgKS/k=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: linux-ppp@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next] pppoe: pass bound packets directly to generic PPP
Date: Tue,  4 Aug 2026 15:44:50 +0800
Message-ID: <20260804074452.75548-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Bound PPPoE sockets pass received frames to the generic PPP layer. They
currently do so through __sk_receive_skb(), which takes the socket BH
lock and serializes calls to ppp_input().

The lock originally prevented ppp_input() from racing with
ppp_unregister_channel(). Commit ec4215683e47 ("ppp: defer channel free
to an RCU grace period to fix pppol2tp RX UAF") now keeps the generic
PPP channel alive until in-flight RCU readers have completed, so bound
packets can be passed directly to ppp_input() from pppoe_rcv().

That lifetime guarantee does not cover reuse of the ppp_channel embedded
in struct pppox_sock. An RX handler can find the old session before it
is unhashed, then resume after disconnect and reconnect have cleared and
re-registered po->chan. It could then race initialization of the new
channel or pass an old-session packet through it.

After unhashing an old session, call synchronize_net() before clearing
and reusing po->chan. This drains every receive path that could have
found the old binding while retaining concurrent delivery for the active
session.

Assisted-by: Codex:GPT-5.6
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 6874a1a8edaf..062411624182 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -345,10 +345,10 @@ static struct notifier_block pppoe_notifier = {
 
 /************************************************************************
  *
- * Do the real work of receiving a PPPoE Session frame.
+ * Backlog receive a PPPoE Session frame and deliver to userspace.
  *
  ***********************************************************************/
-static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
+static int pppoe_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct pppox_sock *po = pppox_sk(sk);
 
@@ -373,7 +373,7 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
 
 /************************************************************************
  *
- * Receive wrapper called in BH context.
+ * Receive a PPPoE Session frame.
  *
  ***********************************************************************/
 static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
@@ -420,6 +420,10 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!po)
 		goto drop;
 
+	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
+		ppp_input(&po->chan, skb);
+		return NET_RX_SUCCESS;
+	}
 	return __sk_receive_skb(&po->sk, skb, 0, 1, false);
 
 drop:
@@ -524,7 +528,7 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
 	sock->state	= SS_UNCONNECTED;
 	sock->ops	= &pppoe_ops;
 
-	sk->sk_backlog_rcv	= pppoe_rcv_core;
+	sk->sk_backlog_rcv	= pppoe_backlog_rcv;
 	sk->sk_destruct		= pppoe_destruct;
 	sk->sk_state		= PPPOX_NONE;
 	sk->sk_type		= SOCK_STREAM;
@@ -625,6 +629,13 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 		pn = pppoe_pernet(sock_net(sk));
 		delete_item(pn, po->pppoe_pa.sid,
 			    po->pppoe_pa.remote, po->pppoe_ifindex);
+
+		/* pppoe_rcv() can call ppp_input() without taking the socket
+		 * lock. Once the socket is unhashed, wait for any receive path
+		 * that found it earlier before clearing and reusing po->chan.
+		 */
+		synchronize_net();
+
 		if (po->pppoe_dev) {
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
-- 
2.43.0

