Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347128;
	b=Pvg55qTY9XyTa1OA+Vhn/iYV2nSYI260BMC9uAxkhSPS06lW0vVNgE8UIMvY/9kFro5p
	 2y/tBYLwZ5uKAHJsk8Itr9OomWlXLV06x8JkV67XX5RPWCvDlwlZZnBQKBMf4RlQmNqJC
	 aEHXBdMF39AFuuBC2U/617d967L2c8BHzdieRjyG66/D9lziA+so2DZzRiCpEOp1UpzON
	 U5k+IkgMSPGOVYKc6g93BtNGUew9TsC0LwA2WrUqiFRWs4Loa7uqoQ+tQaieqWSPRnf8o
	 TzuAP/jUB9RBOrektLcNjvsqiNTGdmj4QFA1M3avBDdPSD0PpzRi5kuMHZHkvixMsTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gZXHbZniI6ovtIu1JCQcb7cZkxkCt/JEGLR8wEhz0Rs=;
	b=DUhmYm9LQfizEx+XMflHjmGW4PmMyzUtx4e2u2HRhA55I61m5DyLRKTKx8SaI+hcnG1N
	 y+P1tGIuK50kp32gjaNb9ijQaM6qVRnn8Ps8zG7fPSnlK0Ee9Y1cZWh3s5HDxVtT1tcxw
	 x5S53NJq1DPmAwomva6Rr38K/+c50ntjico7qIIxnCQLgl1Yhlsis3b+khmFNpqMulsGc
	 hXULmFI4mX4RJW82sDMiBrBsNBw0FFBgpgZ6/BAfemDkd+mR6PiEy2hqMB4+zjew+jeZU
	 +ZvscnGthmMAqpOY3zStTlri2RBEBtyw6NUcA8g+UyIaEcqLI9G+F06AJ24fIFGPqgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E9NU/b73";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B613606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9NU/b73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C7B1F000C1;
	Fri, 30 Oct 2026 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347128;
	bh=gZXHbZniI6ovtIu1JCQcb7cZkxkCt/JEGLR8wEhz0Rs=;
	h=From:To:Cc:Subject:Date;
	b=E9NU/b73053P6hgkyqJkwG4u7dx9eKdNfw0Fgta3JoxGdM1r3VxPzhuNIgsPPyD7W
	 z0ItHraevONL/yolbJmPmllQfjJs7Dcu+sy6pmoQ6Wk+JdYRl8AMhTKzmVE6wIJm+2
	 4vYUgxK6tMCyHCq7SO+P4LkdQ3cgYHvLzTA0/QDkFIYXUDX1wZTJn46slbOJefFP/c
	 7kTm6K8sRLhcCg/BA0UayxJwq30QudVsONxyP3mUTBfyMKib8xR4K4SjF9d031EtJS
	 nWJAwv2NtwLcJQaTc/uAJZhslRJ74zWm5FdHNk0SkE1RgCXaXBuZ+xLaaSDyqWOV9L
	 GLHL/F0l63BMA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH v2 net] tcp: wait for TIME_WAIT teardown before freeing per-netns ehash
Date: Fri, 30 Oct 2026 08:58:43 +0100
Message-ID: <20261030075843.2567707-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: Kyle Zeng <kylebot@openai.com>

inet_twsk_kill() removes a TIME_WAIT socket from the established hash
before it finishes using the ehash lock, hashinfo and bind tables, and
before it drops the death-row reference. A running timer can therefore
unhash its socket before inet_twsk_purge() reaches it. The purge cannot
synchronize with that timer, and tcp_sk_exit_batch() can free the
private ehash and hashinfo while inet_twsk_kill() is still using them.

An unprivileged reproducer using user and network namespaces, a private
TCP ehash and a FIN_WAIT2 timer triggers a KASAN slab-use-after-free in
inet_twsk_kill(). The allocation and free stacks point to
inet_pernet_hashinfo_alloc() and inet_pernet_hashinfo_free().

Wait for an RCU grace period after purging the whole batch, if one
netns in the batch uses a private ehash. TIME_WAIT removal runs with
bottom halves disabled, so this also waits for removers that were
already invisible to the purge. Keep the wait under
tcp_exit_batch_mutex, before freeing any private hashinfo.

The same window exists with the shared tcp_hashinfo. There, the
hashinfo memory stays valid, but tcp_sk_exit_batch() can decrement
tcp_death_row.tw_refcount from 2 to 1 before inet_twsk_kill() drops its
own reference. This triggers the WARN_ON_ONCE() in tcp_sk_exit_batch(),
then a refcount_t "decrement hit 0" warning from inet_twsk_kill().

Adding a grace period for the shared case would be costly on busy
hosts. It is not needed: struct net is freed by a later cleanup_net(),
after the synchronize_rcu() in ops_undo_list(), so inet_twsk_kill()
can safely drop the last tw_refcount reference itself.
Use refcount_dec_if_one() and only warn if tw_refcount is not 1
after a grace period.

Fixes: d1e5e6408b30 ("tcp: Introduce optional per-netns ehash.")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: only call synchronize_net() if one netns in the batch uses a private ehash,
 use refcount_dec_if_one() to avoid a false WARN with the shared ehash]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2: [edumazet]
    Avoid a false WARN_ON_ONCE() in tcp_sk_exit_batch() when a concurrent
    inet_twsk_kill() still holds a tw_refcount reference, as reported by
    Jiayuan Chen and Sashiko. Use refcount_dec_if_one() and only warn
    after a grace period, instead of adding synchronize_net() for the
    shared ehash, which would be costly on busy hosts.

    When net-next reopens, I plan to free the private hashinfo after
    an RCU grace period (call_rcu()), so that tcp_sk_exit_batch() no
    longer needs synchronize_net(). This would also cover request
    sockets and RCU lookups that could still touch a private ehash.

v1: https://lore.kernel.org/netdev/20261028162510.2180528-1-edumazet@kernel.org/

 net/ipv4/tcp_ipv4.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7f9242f1e429033da2c1284b7c1a1964b2ab171..0dc3b087665dc09ffbdc5c124c4ea2ce7d813c56 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3549,6 +3549,7 @@ static int __net_init tcp_sk_init(struct net *net)
 
 static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 {
+	bool synced = false;
 	struct net *net;
 
 	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
@@ -3563,9 +3564,27 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 
 	tcp_twsk_purge(net_exit_list);
 
+	/* inet_twsk_kill() unhashes a twsk before it is done with ehash
+	 * and bhash, and before it drops its tw_refcount reference,
+	 * so tcp_twsk_purge() can miss it. Such callers run with BH
+	 * disabled: wait for them before freeing a private ehash.
+	 */
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
+			synchronize_net();
+			synced = true;
+			break;
+		}
+	}
+
 	list_for_each_entry(net, net_exit_list, exit_list) {
 		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
-		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
+		/* Without a grace period, a concurrent inet_twsk_kill() might
+		 * still hold a tw_refcount reference. Let it drop it: struct net
+		 * is freed by a later cleanup_net(), after an RCU grace period.
+		 */
+		if (!refcount_dec_if_one(&net->ipv4.tcp_death_row.tw_refcount))
+			WARN_ON_ONCE(synced);
 		tcp_fastopen_ctx_destroy(net);
 	}
 
-- 
2.53.0

