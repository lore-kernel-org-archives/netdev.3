Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5725424679
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892779; cv=none; b=IJkgxa9FLZ6c8qZ+2asNCfTxPNjWRId9Y7E93oXd9dHbPj+gFfMZoUl98WLa7p9ZYHQOrSP0DvA0/uOLYtvFx6vjhFL+ptW/I/83ZIRtfZ07fnlsnZKf7A3xLAVXbv0S1bfzI3Y04W76ifcmaoZx9H2cF0g1bMztY8DxSleqYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892779; c=relaxed/simple;
	bh=bHeGRw5E38tnXB0hRsl/2AteekIVL3rf9jA0rB/OR1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgQDDesI6dIq5fCEQXsmiN/UlggUsN+ESbHHFugYls90VAGZVYpj/00JHUlFnFq/5zMqlIx3izcfizGxkHzcAzM6AD6wUPAxFZUZIvf61OG7pxTx547v3dZC1i4LcoI4UnJbr7TFDbLoKxQv9QSdK8aIpSRn4p6RnbTuNuqloNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb45c3Bq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb45c3Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3A61F000FF;
	Thu,  1 Oct 2026 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790892778;
	bh=iGZcMs0mAl3dFxKbJfI9LrbWdHh+/AGCiuXvKlxOz2w=;
	h=From:To:Cc:Subject:Date;
	b=Qb45c3BqYdsxR+98Zhe2H8WdwwAscFQE9HYK80+x1S1i5foi417sVR+MdSmqwLqBf
	 yn3w/bugkFWufsjdll9hXcILpLG57No5PJz4kEo5B+OW5UiFYuVr3t/45iy915px9m
	 yFevIvbU1GSDrkN+PZsf8r/6i7HcZ3VAkdiK9nyFuvp1oDMl8/1vu7DO5Km2QPbgpq
	 DUdUO5JcKifB0X+NPkxN/d0qCsKA0Feu0tBXtA6pFdpWZDZkQB/EcZlMVEFajGAuUu
	 riI4HdjjyAV65udfABf96BUfyUz33jgAyF/IYenwRzo/0to79/RVR0Uw36pHgl148o
	 qAboOXL4CXXGw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Xinyang Ge <xinyang@anthropic.com>
Subject: [PATCH v2 net] ipv4: free inet_opt and ireq_opt after an RCU grace period
Date: Thu,  1 Oct 2026 22:12:53 +0000
Message-ID: <20261001221253.2964024-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_v4_syn_recv_sock() transfers ownership of ireq->ireq_opt to the
child socket (newinet->inet_opt) without copying it.

Another cpu can concurrently process a retransmitted SYN for the same
request socket, and send a SYNACK from tcp_check_req().
tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
under rcu_read_lock() only, and ip_build_and_send_pkt() and
ip_options_build() then read opt->optlen twice.

Note that the SYNACK timer itself is not an issue: it holds a
reference on its request socket, and inet_csk_reqsk_queue_drop()
calls timer_delete_sync() before the child can be freed.

Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
into ehash table"), request sockets are processed without holding
the listener lock, so nothing prevents the child socket from being
freed while the SYNACK is still being built. TCP child sockets do
not have SOCK_RCU_FREE, and inet_sock_destruct() frees inet_opt
with a plain kfree(), leading to a use-after-free in
ip_options_build().

A similar issue exists with request socket migration
(net.ipv4.tcp_migrate_req=1, or a BPF_SK_REUSEPORT_SELECT_OR_MIGRATE
program). reqsk_timer_handler() clones the request socket with
inet_reqsk_clone(), so that the old request socket and its clone
share the same ireq_opt, then reqsk_migrate_reset() clears the
pointer in the old one. Another cpu holding a reference on the old
request socket can still be using these options (sending a SYNACK,
or creating a child in tcp_v4_syn_recv_sock()) when the clone is
freed, and tcp_v4_reqsk_destructor() also uses a plain kfree().

Readers already use RCU, and other paths replacing inet_opt
(do_ip_setsockopt(), cipso_v4_sock_setattr()...) already use
kfree_rcu(). Use kfree_rcu() in inet_sock_destruct() and
tcp_v4_reqsk_destructor() as well.

IPv6 is not affected by the first issue, because tcp_v6_syn_recv_sock()
duplicates the options. tcp_v6_reqsk_destructor() has the same
migration issue with ipv6_opt, which is only set by CALIPSO. This
will be addressed in a separate patch.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v2: also use kfree_rcu() in tcp_v4_reqsk_destructor() (Sashiko)
    SYNACK timer is not affected, clarify changelog (Jiayuan Chen)
v1: https://lore.kernel.org/netdev/20260929214351.856940-1-edumazet@kernel.org/
---
 net/ipv4/af_inet.c  | 2 +-
 net/ipv4/tcp_ipv4.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4ce38c99fef9ef2a24edff34cd5b110dddfec193..14ce01092fda65dbcf835662c03d78f4de0301f2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -161,7 +161,7 @@ void inet_sock_destruct(struct sock *sk)
 	WARN_ON_ONCE(sk->sk_wmem_queued);
 	WARN_ON_ONCE(sk->sk_forward_alloc);
 
-	kfree(rcu_dereference_protected(inet->inet_opt, 1));
+	kfree_rcu(rcu_dereference_protected(inet->inet_opt, 1), rcu);
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 	dst_release(rcu_dereference_protected(sk->sk_rx_dst, 1));
 	psp_sk_assoc_free(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 04dbb2babbcdc11f84d0d394daa439b1797750c1..bebc5a8d1ab69fe94e51958431d28e8f009c94fc 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1209,7 +1209,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
  */
 static void tcp_v4_reqsk_destructor(struct request_sock *req)
 {
-	kfree(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1));
+	kfree_rcu(rcu_dereference_protected(inet_rsk(req)->ireq_opt, 1), rcu);
 }
 
 #ifdef CONFIG_TCP_MD5SIG
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

