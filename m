Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6F476CFE
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799854; cv=none; b=D/jT0pJqkLAbhO4Pg9JVxx39v88wzN4/EkMjMnUbAutZs/PBAQD52WLVTgUGKL51fdgUTrk8jqgYF1ieYrYQ2QC4Dkw3huyC22XEBVTDcsHZkzNzhuACsKWqmBIZUyyTnc//UKG0Z/6jXL1gRQrxeIZUYMIk+HGYFvjbz//z7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799854; c=relaxed/simple;
	bh=G0jFP3uJN4JXgWL4hsy7EIywbqGb8YxJWShXTkzCyY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNAO9/sgXCTomO2gR6fy6J6P9cNe51rFzFGji2iw3kHNf7NMsK6PwTnquodFjfuBlQt8RWn8lga2syCCy+EIQtTB6A/QplgBz5jEuLKqoDu3s4Q/hqZGwMO5HwFA0TMvE55Dx9tqmbblHw9R6GIVolnDEjKz/vokqRHLV2SurSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw+fDuo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw+fDuo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47CB1F0089C;
	Mon, 12 Oct 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799843;
	bh=SSeSbI5Bc24i46wkLAxVBJgOQZD85g1N/Fv5ET6IbWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kw+fDuo2CgvQOt0wTqJ9zrD+MugTzmQhWjAP8SRJbubTkVkopgVFgQrgcVQNB4aXP
	 DKO+fHDJVIzp6qbUd5OqQX4zlGKmrtQCTEZjlaMJdVM+8tB9yOTRn9G58GXpejA9ZC
	 DjSPDy2fnXTctD136jMiuUJvwBA2baO9vHJAULCDdSGQ0JyZz0rs5NCKnAq3RHQ8JI
	 N1zPpDypD2pumPjtznrZYdtsJJdXm+He5sXMUFSixYXhuFRqTZxWLKGKQF5LmoyVTg
	 iOuN2vFdmbA/GOleyDn7g8PSnpVw2pMaB+wV79HgyGdUszG29NnEPUmDHa+DVLIKXx
	 /pY6hz9d3YM4w==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v3 net 1/2] net: use the full socket in sk_mc_loop()
Date: Mon, 12 Oct 2026 12:10:28 +0200
Message-ID: <20261012101029.927296-2-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012101029.927296-1-edumazet@kernel.org>
References: <20261012101029.927296-1-edumazet@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>

sk_mc_loop() is called from ip_mc_output() and ip6_finish_output2()
with skb->sk, which is not always a full socket:

- Since commit ca6fb0651883 ("tcp: attach SYNACK messages to request
  sockets instead of listener"), a SYNACK is attached to its request
  socket.

- Since commit 79636038d37e ("ipv4: tcp: give socket pointer to control
  skbs"), an ACK or RST sent by ip_send_unicast_reply() on behalf of a
  TIME_WAIT socket is attached to the timewait socket.

When such a packet uses a multicast route, inet_test_bit(MC_LOOP, sk)
reads inet_flags past the end of the request or timewait socket.

This happens for instance when a SYN with a multicast source address
reaches a listener, after being looped back with its dst attached, so
that ip_rcv_finish_core() skips the martian source check. A raw
IP_HDRINCL socket sending to a local address does this, as does
re-injection by nft dup or the iptables TEE target. The destination
can also come from a source route option, or from a route of type
multicast covering a unicast prefix.

BUG: KASAN: slab-out-of-bounds in sk_mc_loop+0x111/0x170
Read of size 8 at addr ffff88800f2b7f10 by task repro-raw/470
Call Trace:
 <IRQ>
 sk_mc_loop+0x111/0x170
 ip_mc_output+0x355/0x930
 ip_build_and_send_pkt+0xb87/0xc50
 tcp_v4_send_synack+0x500/0x6f0
 tcp_conn_request+0x2135/0x2d90
 tcp_v4_conn_request+0xa5/0x210
 tcp_rcv_state_process+0x136e/0x6920
 tcp_v4_do_rcv+0x339/0xb10
 tcp_v4_rcv+0x34ab/0x3ab0
 ip_protocol_deliver_rcu+0x6e/0x3e0
 ip_local_deliver_finish+0x34d/0x510
 ip_local_deliver+0x1bc/0x310
 ip_rcv+0x390/0x410
 __netif_receive_skb_one_core+0x199/0x1e0
 process_backlog+0x239/0x680
 __napi_poll+0xb5/0x650
 net_rx_action+0x980/0xd60
 handle_softirqs+0x17f/0x590
 do_softirq+0x3f/0x60
 </IRQ>

The buggy address belongs to the object at ffff88800f2b7d60
 which belongs to the cache request_sock_TCP of size 312
The buggy address is located 120 bytes to the right of
 allocated 312-byte region [ffff88800f2b7d60, ffff88800f2b7e98)

Use sk_const_to_full_sk(), which restores the behavior from before
the two commits above: a request socket uses the setting of its
listener, and a timewait socket gets the default (loop back), as the
per-cpu control socket used before had.

Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets instead of listener")
Fixes: 79636038d37e ("ipv4: tcp: give socket pointer to control skbs")
Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
[edumazet: rewrote the changelog, added the TIME_WAIT case]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
v3:
- Back to the v1 approach: checking the destination in TCP (v2) does
  not cover source routes, multicast typed routes on unicast prefixes,
  or the TIME_WAIT reply path (sashiko).
- Add the TIME_WAIT case and its Fixes tag.
v2: https://lore.kernel.org/netdev/20261008114942.1376889-1-theodorlarionov@gmail.com/
v1: https://lore.kernel.org/netdev/20261008100423.1256884-1-theodorlarionov@gmail.com/

 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330ff4b1d662b0d0133e20d1f74eb728..1302c1e848b2a3c40e86ff37af9c20c1a9f4662a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -769,6 +769,7 @@ bool sk_mc_loop(const struct sock *sk)
 {
 	if (dev_recursion_level())
 		return false;
+	sk = sk_const_to_full_sk(sk);
 	if (!sk)
 		return true;
 	/* IPV6_ADDRFORM can change sk->sk_family under us. */
-- 
2.53.0

