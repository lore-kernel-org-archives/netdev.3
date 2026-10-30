Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343618;
	b=b5soLT4gTqj49PeoNlfap+PdAh6zdlwrj7vzX+4diaCWuxiEE4HQ4fkNkmpHK3gngwtG
	 kD4t9qE49iA78D55pSWpBo/I1tmvUTEFvgCeHjtqRbjlvPtCnRDIjDDE5O6lP8xH+g5/H
	 JTa9fKtV60voU8ez7uthfFxV0J5AehXvzkoLsijQpuSBHkCyp0bbeW3WTpQJiBFUh3fTH
	 iufN9RGWINkp8TdVrJTULBf6Nc5wS/fRSbyobUiKlvJaPlRMAX8LdhsfAZpE30RLUrKRp
	 HKNabfYQcnX3QUvBSqRS7rov5/SEEzu0w8o3+qEl18vhViJ+4eShqMvUQWApjbzaTiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343618;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dKgY6h6Q5Ts2DLxnhruLUBnCNbfZQqx2qrxaVmHpCJ8=;
	b=Ez77FOsC5w54njiZGjAjYkq+VQEhCW/ZqyAbzii1Up7rP9vRmWeBlSzcqmPX/8KIqSLy
	 3zLspKjIXqtEnCEE5UciD73B/SnD6LwlcctXyG7tQ0zUkXLapp/07093a8Nmizb+wb5Po
	 k5mAdLaepjZXKyKSFr6e7KMBvUfKtZ13rPyyI5DLb8CrfTLGB2Hv5NcAwEXrITUjvA4FR
	 cQTm1rOU4gabI7NA4I9Iwt+/6kPIFgHeErVTtu7M1iSPNK3jTg0szgZoBquYXXU8wUaiG
	 VqY8LexbqGz+CPqsjwX5v3kZ7HrVKhosAnTCih2JizteLk6pbJs27o/hbXOmOaKAeOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mErMgedX;
	arc=none smtp.remote-ip=91.218.175.214
Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0A606A322
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B0A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mErMgedX
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iwhXvykKTuWWPyDY4VQHOy0zOduOaW4QRZBlnvbofnU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793343614; v=1; x=1793948414;
 b=mErMgedXGeUaoLshovhHilY4jQlJYsAMDZeygrx+YJLp/ttlbGSata3gM06AnHyUjUyTDVZw
 im90XKEAIdaB5Npq2ugP3EAa3fbTz3lb0/qFi4boNElL2jQNXqLDeKxLRz0Rv6GZ6oAPP5Iv7Os
 eKowIH9XV84r9MN86rEiNnDg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a4af3f32c786b08f;
	Fri, 30 Oct 2026 07:00:12 +0000
X-Mizu-Trace-ID: a4af3f32c786b08f
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH net-next] l2tp: ppp: remove unused backlog callback
Date: Fri, 30 Oct 2026 15:00:03 +0800
Message-ID: <20261030070003.2590-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
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

PPPoL2TP sessions receive packets through pppol2tp_recv(), which passes
packets directly to PPP or queues them on sk_receive_queue. No receive
path queues packets on the session socket backlog or calls
sk_receive_skb() with that socket, so pppol2tp_backlog_recv() is unused.

Remove the unused callback. L2TP/IP control sockets retain their
separate backlog callbacks. Selftests passed.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 net/l2tp/l2tp_ppp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 4f311d473a64..15e02864bfd5 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -454,17 +454,6 @@ static struct proto pppol2tp_sk_proto = {
 	.obj_size = sizeof(struct pppox_sock),
 };
 
-static int pppol2tp_backlog_recv(struct sock *sk, struct sk_buff *skb)
-{
-	int rc;
-
-	rc = l2tp_udp_encap_recv(sk, skb);
-	if (rc)
-		kfree_skb(skb);
-
-	return NET_RX_SUCCESS;
-}
-
 /* socket() handler. Initialize a new struct sock.
  */
 static int pppol2tp_create(struct net *net, struct socket *sock, int kern)
@@ -482,7 +471,6 @@ static int pppol2tp_create(struct net *net, struct socket *sock, int kern)
 	sock->state  = SS_UNCONNECTED;
 	sock->ops    = &pppol2tp_ops;
 
-	sk->sk_backlog_rcv = pppol2tp_backlog_recv;
 	sk->sk_protocol	   = PX_PROTO_OL2TP;
 	sk->sk_family	   = PF_PPPOX;
 	sk->sk_state	   = PPPOX_NONE;
-- 
2.43.0

