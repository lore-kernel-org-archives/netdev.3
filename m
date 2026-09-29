Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8E530E0A
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718248; cv=none; b=kxiip+Ys/cxtplUe5T8MXvDqXQVATMuwblEbL+xO1nw3buWliUf1lr3TBFYldquILXae4UUwG2cEGoA+xQVy4d+Iu0TXCR51O14NzVfriGnlYMmIXJCMfdpq+Tt9h/VPn4sHykXvGPuj1Jvi870b/ZxIeJFS6JOz39w+DUWZfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718248; c=relaxed/simple;
	bh=XDeRtUISJ43lgfcNFaPi04bh4VLlwOeklh4kE8uS8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpDCvchK8ZkAC8Qi6iZtdSZFkPiZyIkGojzQcQnRn7NuIxh15PL/kOl+TVE/8bIyG1Lp1fDiRwSweGyi61h0buoQegvE2zp28c2coQedlWFmDgtq7N6N5YN7CW2GdCzK86Z0smk/bH3YtuVNpNV8dd3haRMOqAsY2W+mDXtfxxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPM7erxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPM7erxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDCB1F000FF;
	Tue, 29 Sep 2026 21:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790718237;
	bh=s0ToCBzUiGcwiSV0Z5YBvbCZFWPhY/t1jX4YQk6dYnA=;
	h=From:To:Cc:Subject:Date;
	b=LPM7erxRuk0DTXz8D7HqDPy+KiYsQeu9nL4jE4N+u7BxKdnBbz03oSlrudf9urQpd
	 fuf6qsu+LhDC5ikRxr7YuNUNYj61Z8ZOtzXBlq21nzS9EaKuDKsYgA7CYsQ2zMGaYz
	 u5ziNTanF0lPxMmKhETQlQbbWZvj+uubtoQBucI+81oFBZ/AjKXu/1dTDium1EWiKK
	 4qx1S+t6x8BPUipA2T8E97YrOCuXF8F6bHqbl39XiEH6YxNmBObosRYfTUPM1jnFy8
	 dim4Svguor2X4YOVt38WNC0NLabmMM1hRYHX0i4gtGqz5EQSFMTpUP/l2GfEzz3tV/
	 T7dCMj1+MmSKg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	edumazet@google.com,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Xinyang Ge <xinyang@anthropic.com>
Subject: [PATCH net] ipv4: free inet_opt after an RCU grace period
Date: Tue, 29 Sep 2026 21:43:51 +0000
Message-ID: <20260929214351.856940-1-edumazet@kernel.org>
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

Another cpu can concurrently retransmit a SYNACK for the same request
socket (either from a retransmitted SYN, or from the SYNACK timer).
tcp_v4_send_synack() and inet_csk_route_req() read ireq->ireq_opt
under rcu_read_lock() only, and ip_build_and_send_pkt() and
ip_options_build() then read opt->optlen twice.

Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
into ehash table"), request sockets are processed without holding
the listener lock, so nothing prevents the child socket from being
freed while the SYNACK is still being built. TCP child sockets do
not have SOCK_RCU_FREE, and inet_sock_destruct() frees inet_opt
with a plain kfree(), leading to a use-after-free in
ip_options_build().

Readers of inet_opt already use RCU, and other paths replacing
inet_opt (do_ip_setsockopt(), cipso_v4_sock_setattr()...) already use
kfree_rcu(). Use kfree_rcu() in inet_sock_destruct() as well.

IPv6 is not affected, tcp_v6_syn_recv_sock() duplicates the options.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/af_inet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

