Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21937882A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140493; cv=none; b=UCDL7SSnfMW8ORyFgM8rYEwAw/KNBV6A6mbBmb6FEx4YS8VghRyPPPfNO7bkFQG149exqP8FKbXA0mxw3KD3d0R9iF0Na6GRciRgFzNQ9qqQmtoLumkcGbWnSwkpdDDjAkzNn8JaR6QhXikJRZ1DvhLH60Xn7UFZkPsc86KM+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140493; c=relaxed/simple;
	bh=5U0cWj16TuzpJ6LypMJIFdb8UNY75AXVQ8zBdqY/BAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O07R9g+N0/KXvxIK3J0g6ds7aIjtNPSa+RLje30k4clFjswqxCteWIrqHIEm8qXABmz1DHFvHu3cSBpBDau30Y0Yr/rnkZ6Br503e6YsoJNvwc87uIRNPgfNeWK6enzUOJMS6kgNeglVV4IH8sfU49tueg6JYPLrx0iUSRUfy+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSq+BrF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSq+BrF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9221F000C4;
	Fri, 16 Oct 2026 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792140491;
	bh=PwALp2Ex+NAygyLDKXMv1KuSJwM5TCw3qafRqShoQSY=;
	h=From:To:Cc:Subject:Date;
	b=aSq+BrF4UphQfTVgwo0a6WIDSITKJWnyp0ogWmc6+dlygeA8c22O0KGLLIgu9TySY
	 DpgI1Fj7Y3ryBJ252fPWzJWH9prJ7WbccGyTgLQve+G6HL12wnDbp6VbeFN4jZrpIJ
	 qB/K17/9PT4WDdRWYuIR0s0cflQNkQz0LHMzRlM5xZWSykdP6cQacogDwpL8o4RTEV
	 NWSLQmBugrfldTB973xEgi4iYgJI1S5aQY/8LHHoYY1zIWe6zsbeuskA2211CZViGI
	 snczuJdN5KXLRElub6+evYmf5LTkLvDjirZKt4W0UJU1par1B4XeW3C2/n1cN8Db0x
	 vKyUUcOv1MYTg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH net] tcp: tcp_metrics: use the socket netns, not the dst device netns
Date: Fri, 16 Oct 2026 10:48:02 +0200
Message-ID: <20261016084802.2725187-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_get_metrics(), __tcp_get_metrics_req() and tcpm_new() look up and
create metrics entries in the netns of the cached dst device rather than
in the netns of the socket.

These usually match, but not after the device has been moved to another
netns or unregistered: a socket can keep a stale dst in sk_dst_cache
until it is checked again, and tcp_update_metrics() reads it with
__sk_dst_get() without any dst_check(). Once dst_dev_put() has run, the
dst device is blackhole_netdev and the entry is created in init_net.
Before that, for instance for routes through nexthop objects whose
cached dsts are released from a nested RCU callback, it is the netns the
device has just been moved to.

A TCP socket of netns A that enters TIME_WAIT in that window then
creates or updates an entry carrying A's addresses and RTT in another
netns, where TCP_METRICS_CMD_GET can dump it and where new connections
to the same peer inherit those metrics.

The metrics belong to the netns of the socket, so use sock_net() for
full sockets and request sockets, and pass it to tcpm_new().

Kernel sockets that do not hold a netns reference can still reach
tcp_time_wait() after tcp_net_metrics_exit_batch() has flushed the
entries of their dismantling netns, and an entry created then would
never be flushed and would keep a dangling tcpm_net. Make tcpm_new()
refuse to create entries when check_net() fails. Its callers are in
an RCU read-side section, and cleanup_net() waits for a grace period
between the refcount reaching zero and the flush, so an entry added
after a successful check is always seen by the flush.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Qiliang Yuan <odys.yuan@gmail.com>
---
 net/ipv4/tcp_metrics.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index dc0c081fc1f33f735a38aaae8a7b4ab3d633b148..d58f99c67d4dc0877d0e853c9e9faddd80343c22 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -161,16 +161,26 @@ static void tcpm_check_stamp(struct tcp_metrics_block *tm,
 	rcu_dereference_protected(p, lockdep_is_held(&tcp_metrics_lock))
 
 static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
+					  struct net *net,
 					  struct inetpeer_addr *saddr,
 					  struct inetpeer_addr *daddr,
 					  unsigned int hash)
 {
 	struct tcp_metrics_block *tm;
 	bool reclaim = false;
-	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dst_dev_net_rcu(dst);
+
+	/* Do not add entries to a dismantling netns: they would not be
+	 * flushed again. Callers are in an RCU read-side section, and
+	 * cleanup_net() waits for a grace period after the netns refcount
+	 * reached zero and before tcp_metrics_flush_all(NULL) runs, so an
+	 * entry added after a successful check_net() is seen by the flush.
+	 */
+	if (unlikely(!check_net(net))) {
+		tm = NULL;
+		goto out_unlock;
+	}
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +283,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dst_dev_net_rcu(dst);
+	net = sock_net(req_to_sk(req));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +328,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dst_dev_net_rcu(dst);
+	net = sock_net(sk);
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -326,7 +336,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	if (tm == TCP_METRICS_RECLAIM_PTR)
 		tm = NULL;
 	if (!tm && create)
-		tm = tcpm_new(dst, &saddr, &daddr, hash);
+		tm = tcpm_new(dst, net, &saddr, &daddr, hash);
 	else
 		tcpm_check_stamp(tm, dst);
 
-- 
2.53.0

