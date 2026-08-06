Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AB430CCE
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007824; cv=none; b=T8FIByL0yW/P5CK5W3BrPQ2w+qtVxSAKM8pFN60DVa8WxMEEa0w7g7Z7E8HTSXcggNSOlYDHefzAQZlpkpj6lxB5CMeQ7P2Ht1952ydFSpxBwBHVcjncsQt04/RaKuGHgd92AYpytRKxOYK6Dz5KShV4d7xWAQ5A14PEQ/hDGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007824; c=relaxed/simple;
	bh=M/RpwFiHSAqoZO4kspus2T4UZyaP30+NjHFm63I8A94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtLYWcb1G4hvHBa5w86VNqcZpzkrMh1iPs8O+X3NdW6sQ3dzPEqvS7oMks16P9uAr+CCzt/d3M7s9SB6v43DxzMucdtCv+qv7eaSeSMdvqRpBLs8eRdvAZTTfDnDs1kJJKKhFo8umhTpLyI3mj7epA5hniY+JVqkZeXrSrmuLGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rQ1BdQ8H; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rQ1BdQ8H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786007810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gUxTXyO9SEI39IcxI1v9HZ+DOVlkWBmotfQ1Iwo2iyk=;
	b=rQ1BdQ8HfjPEg8zfw8SwGxjLq2kNRaQEWetS4jP5M0jdIOTwXJ07g+s5mtuUtoLwX1wdIV
	OfKM67fuEEWd16bYzDOE+ohrgmf32xa2aNbkxY3FcQ1IUEdp3EDsP2aPDxtkBiJ0blCFi8
	oBUmZ1jjafbPpLGJ7qgMGYEsCosHPFg=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
	Michal Ostrowski <mostrows@gmail.com>
Subject: [RFC net-next] pppoe: remove session socket receive support
Date: Thu,  6 Aug 2026 17:16:24 +0800
Message-ID: <20260806091626.231225-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

No known userspace PPPoE implementation reads from an AF_PPPOX
socket. In particular, pppd uses the socket only to establish a
session and obtain a generic PPP channel with PPPIOCGCHAN. Packet I/O
then uses /dev/ppp.

Before this change, packets received before PPPIOCGCHAN set
PPPOX_BOUND were queued on sk_receive_queue. Since no known
implementation consumed them, they remained there until socket
destruction and unnecessarily consumed memory.

Pass every matched session packet directly to ppp_input(). On a
successful connect, the channel is registered before the socket lock
is released. Generic PPP can therefore queue early packets until
userspace attaches /dev/ppp, preserving packets that arrive between
connect() and PPPIOCGCHAN.

Replace pppoe_recvmsg() with sock_no_recvmsg(). Like PPTP, omit the
poll callback because the socket no longer receives packets. Remove
pppoe_destruct() because the receive queue is no longer used.

Assisted-by: Codex:GPT-5.6
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 50 ++---------------------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index bf7414b46a26..e3d425943c76 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -350,23 +350,9 @@ static int pppoe_rcv_core(struct sock *sk, struct sk_buff *skb)
 {
 	struct pppox_sock *po = pppox_sk(sk);
 
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
+	ppp_input(&po->chan, skb);
 
 	return NET_RX_SUCCESS;
-
-abort_kfree:
-	kfree_skb(skb);
-	return NET_RX_DROP;
 }
 
 /************************************************************************
@@ -498,11 +484,6 @@ static struct proto pppoe_sk_proto __read_mostly = {
 	.obj_size = sizeof(struct pppox_sock),
 };
 
-static void pppoe_destruct(struct sock *sk)
-{
-	skb_queue_purge(&sk->sk_receive_queue);
-}
-
 /***********************************************************************
  *
  * Initialize a new struct sock.
@@ -523,7 +504,6 @@ static int pppoe_create(struct net *net, struct socket *sock, int kern)
 	sock->ops	= &pppoe_ops;
 
 	sk->sk_backlog_rcv	= pppoe_rcv_core;
-	sk->sk_destruct		= pppoe_destruct;
 	sk->sk_state		= PPPOX_NONE;
 	sk->sk_type		= SOCK_STREAM;
 	sk->sk_family		= PF_PPPOX;
@@ -921,31 +901,6 @@ static const struct ppp_channel_ops pppoe_chan_ops = {
 	.fill_forward_path = pppoe_fill_forward_path,
 };
 
-static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
-			 size_t total_len, int flags)
-{
-	struct sock *sk = sock->sk;
-	struct sk_buff *skb;
-	int error = 0;
-
-	if (sk->sk_state & PPPOX_BOUND)
-		return -EIO;
-
-	skb = skb_recv_datagram(sk, flags, &error);
-	if (!skb)
-		return error;
-
-	total_len = min_t(size_t, total_len, skb->len);
-	error = skb_copy_datagram_msg(skb, 0, m, total_len);
-	if (error == 0) {
-		consume_skb(skb);
-		return total_len;
-	}
-
-	kfree_skb(skb);
-	return error;
-}
-
 #ifdef CONFIG_PROC_FS
 static int pppoe_seq_show(struct seq_file *seq, void *v)
 {
@@ -1046,11 +1001,10 @@ static const struct proto_ops pppoe_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= pppoe_getname,
-	.poll		= datagram_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.sendmsg	= pppoe_sendmsg,
-	.recvmsg	= pppoe_recvmsg,
+	.recvmsg	= sock_no_recvmsg,
 	.mmap		= sock_no_mmap,
 	.ioctl		= pppox_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0

