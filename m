Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B1526F2BE
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737885; cv=none; b=Khq5mQQVDSHXTgSYFmbiEEal7KwV88fWKVYLVrPZIKrvqKtaZaY0eADvIFefNrClAd22VOH+4RYxfB3Dvia702LzoDHR6KkBS7x9RgMYxotHwY3VIhERTaOHjVPxOD6SbhSpDZisCjRni/fIaoIFCRXBe12wx4AGk6qXU5aJfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737885; c=relaxed/simple;
	bh=I/zRPVjg0s5YdRGEHgHNX74lxBFp0Tp7kxHbfxdNFbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM7qM1bGE580QgcVPVf5NdtVM3xkqdkLV57+p0xLgYH1+60whno0CpP1Hlz7uIaO+zxiwqgyMvGnm0S+7n7rwU3KVCC57qd2JF8uRgljSZVxc04kNfuw1TtsngLcflxOPHsfifY8+0CAU40BwgbOydrZuCdZrXOKxRPGOyKOyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t6D4Msah; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t6D4Msah"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785737881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RNlcejKwvmqC0MIxYK5VxA53yHihoPCqC83q4j9Aqn8=;
	b=t6D4MsahC4dE45qUAjoLJRcbON2IuVq3PejkfojMjlp8mJr8GGgMvFKbYiA0GXGE1v20O+
	SmVramVhwdqqqoW4Gr21OWE0lVMsFWDenbtxJ3NPWjHdRiJ4krJqCBUiuH+m8Kx+76ueMp
	jtEQMq5JR3E6doPSrMKk03l5N0WFipQ=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tcp: fix TFO max_qlen accounting across reuseport migration
Date: Mon,  3 Aug 2026 14:17:38 +0800
Message-ID: <20260803061739.134737-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A listener's TCP_FASTOPEN max_qlen stops being accurate and lets through
far more pending Fast Open requests than it was configured for.

This only shows up with SO_REUSEPORT listener migration, where closing a
listener hands its still-pending TFO children over to a surviving one.

fastopenq.qlen is charged in tcp_fastopen_create_child() when the child
is created and uncharged in reqsk_fastopen_remove() when the handshake
completes.  The uncharge follows rsk_listener of the request the child
points at, and inet_reqsk_clone() has repointed the child at a new
request owned by the new listener, so the ++ and the -- land on two
different sockets.  The new listener's qlen drifts negative and its
limit no longer binds.

Charge the new listener during migration, like reqsk_queue_migrated()
already does for queue->young and queue->qlen.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
fastopenq.qlen is read without the lock in tcp_fastopen_queue_check() and
has been since long before this patch, but as this is meant to be
backported I left the READ_ONCE()/WRITE_ONCE() conversion to a separate
patch.
---
 net/ipv4/inet_connection_sock.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba5483..6257459bcee2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -943,11 +943,23 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 
 	nreq->rsk_listener = sk;
 
-	/* We need not acquire fastopenq->lock
-	 * because the child socket is locked in inet_csk_listen_stop().
-	 */
-	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
+	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener) {
+		struct fastopen_queue *fastopenq;
+
+		/* reqsk_fastopen_remove() will uncharge nreq->rsk_listener,
+		 * that is @sk, so charge it here.  Unlike the listener
+		 * being closed, @sk is live and needs its lock.
+		 */
+		fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
+		spin_lock_bh(&fastopenq->lock);
+		fastopenq->qlen++;
+		spin_unlock_bh(&fastopenq->lock);
+
+		/* We need not acquire fastopenq->lock
+		 * because the child socket is locked in inet_csk_listen_stop().
+		 */
 		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
+	}
 
 	return nreq;
 }
-- 
2.43.0

