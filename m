Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962901;
	b=dFDmBbDkn39qYALry6NmIYS7TkAr6u5FMrQ044DmUOAnUymucQ863S38hMjyS/av7wGZ
	 fL/VO3Guhz+bzSNmmTdF1g7eSsOiQ2slGM+991Unfx0LPb8ygzyogXX/gs2ypvWREjDKw
	 jaBzBk2y5IlkT5DzSE2kxffQzV+j0Gftt7zGLXYNf++NwkJrFgP68KingOcxmgvlD9BgC
	 c+HNJlM2lCVt339JbuGP2EFEHNHYFu5tLHpWmmQdf+LrsoYFG4VvMl6mF7v4ggsbqPXTM
	 vleziSTYMW+nqnY9KZUc4cgmm389JXnEi4vmBJUTHqowU9xT9uzjN+i9YPa6xGAUKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=68dGMIX5f3nQCS3nrH2I0UaCNbqPUO2VsOr7U+bJ8CA=;
	b=YnUqfDTwFT6gjTCkjWR2wM9dZTNfHCMu8LzEtLU+OotSUSGH/RI1RnuSGLRaR5FAnG7g
	 +MAUXUmSvuKqqAkRtW4RRgXgG85vGx1TpTOp2JLkkDo8bB4PTcNgfflpphPkw9kIkpYng
	 ZYhV5MN0DV07p58SQC1f/rNi0zkUW8AeWDhZ78+jCAlIzeLQUELo0A/s4W0IhTpMbdcVV
	 rWi8W9zDlqncQJvRe5+ajwVusvTnVX2zS+tMl4x2MUi5TLTtXdYhqSkfEXr3yvWxhWyKs
	 yRg9RfzhITyNzXWHv8AUqcZ/rn7zNMKLqk8UCNmVY8n5OPKPBDjcOigll81o5KE/wxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfnlQ0yh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D43606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfnlQ0yh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41551F0089F;
	Fri,  6 Nov 2026 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962900;
	bh=68dGMIX5f3nQCS3nrH2I0UaCNbqPUO2VsOr7U+bJ8CA=;
	h=From:To:Cc:Subject:Date;
	b=mfnlQ0yhHAeXAjO0FUMRghgNEdX6ucKc22Adv2O5lbhLLpCP5e3FaxEJTbHlUpPPr
	 poBx3LuUjhyqYh/dL2jsHduXMflnn3ZCzvCoU+gTTtoXHpCnDDq2U4vUbfwwbxydIo
	 rmtPW/l1PdLZSBgV0wi2Bz8CJmRiO/u8A2ZZzuNr+Hd7D+qbe4QbvKhYSwPI2pKiFS
	 LV2XJnla9F/O3L27+yrTBmU9x4ki5Fe3EY31ZwevMMVKa4GLhvKZqtwg2FXLBVaUkL
	 Y5kn7N6XjuMInXn5IsFS3HBIgmRK8yDa+7xBvRP758vIMMEXEE1pyqHbiYRETAtGDM
	 a9CEESbOXGJdw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] udp: do not use a cross-family sk_rx_dst in early demux
Date: Fri,  6 Nov 2026 12:01:35 +0100
Message-ID: <20261106110135.2161204-1-edumazet@kernel.org>
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

A dual-stack UDP socket connected to a v4-mapped address can receive
both IPv4 packets and IPv6 packets using v4-mapped addresses:
ip6_rcv_core() no longer rejects a v4-mapped source since commit
dcc32f4f183a ("ipv6: weaken the v4mapped source check"), which kept
that check only in tcp_v6_conn_request(). ipv6_portaddr_hash() hashes
v4-mapped addresses like IPv4 ones, so both early demux handlers find
the socket, and both __udp4_lib_rcv() and __udp6_lib_rcv() store their
input dst in the same sk->sk_rx_dst.

udp_v6_early_demux() validates the cached dst with dst_check(), but
ipv4_dst_check() ignores the cookie, so an IPv4 dst gets attached to
an IPv6 skb. ip6_rcv_finish_core() then skips the route lookup and
ip_local_deliver() parses the IPv6 header as an IPv4 one: the IPv6
next header and hop limit are read as a fragment offset, and the IPv4
protocol is taken from a source address byte.

The reverse direction looks possible too: per-cpu dsts of IPv6 routes
using nexthop objects have rt->sernum set, and ip6_dst_check() then
ignores the cookie, so udp_v4_early_demux() can attach an IPv6 dst to
an IPv4 skb.

Kyle Zeng reported that such a packet can reach XFRM input still
holding the prefetched, non refcounted, socket set by early demux,
which can then outlive its RCU grace period.

Only use the cached dst if its family matches the packet. Otherwise
fall back to a regular route lookup.

TCP does not have the same problem: sk_ehashfn() hashes a v4-mapped
socket with inet_ehashfn(), while IPv6 lookups use inet6_ehashfn(),
so IPv6 packets do not normally find a v4-mapped TCP socket.

Fixes: 5425077d73e0 ("net: ipv6: Add early demux handler for UDP unicast")
Fixes: c9f2c1ae123a ("udp6: fix socket leak on early demux")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
This was found while reviewing an AI-generated XFRM patch from Kyle
Zeng, which did not state how the issue was discovered. The
cross-family dst was then identified by manual code inspection.

The IPv4 dst on IPv6 skb case was reproduced on an unmodified kernel,
without error injection, using two netns joined by a veth pair:

 - target: AF_INET6 UDP socket bound to ::ffff:10.0.0.1 port 5000,
   connected to ::ffff:10.0.0.2 port 6000.
 - peer: send a few IPv4 UDP datagrams 10.0.0.2:6000 -> 10.0.0.1:5000.
 - peer: inject with AF_PACKET IPv6/UDP packets from ::ffff:10.0.0.2
   port 6000 to ::ffff:10.0.0.1 port 5000.

Before this patch, IpReasmReqds in the target netns increases once per
injected IPv6 packet. After it, these packets are dropped by IPv6
routing (Ip6InNoRoutes), and the socket still receives the IPv4
datagrams. The IPv6 dst on IPv4 skb case was not reproduced.

reuseport_dualstack, udpgso.sh, udpgro.sh and udpgro_fwd.sh selftests
pass with this patch.

 net/ipv4/udp.c | 5 ++++-
 net/ipv6/udp.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 303d0102519ac1aeac0b04d53e70f846c3a43779..2e5562f353f85d880a15793750d01037303f376e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2850,8 +2850,11 @@ enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
 	skb->destructor = sock_pfree;
 	dst = rcu_dereference(sk->sk_rx_dst);
 
-	if (dst)
+	/* A dual-stack socket can cache an IPv6 dst. */
+	if (dst && dst->ops->family == AF_INET)
 		dst = dst_check(dst, 0);
+	else
+		dst = NULL;
 	if (dst) {
 		u32 itag = 0;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 59f9872c355211704ba0899b1953d97d4ffb4617..9dcefa162522352465d25c234e70b8adedea7cd7 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1249,8 +1249,11 @@ void udp_v6_early_demux(struct sk_buff *skb)
 	skb->destructor = sock_pfree;
 	dst = rcu_dereference(sk->sk_rx_dst);
 
-	if (dst)
+	/* A dual-stack socket can cache an IPv4 dst. */
+	if (dst && dst->ops->family == AF_INET6)
 		dst = dst_check(dst, sk->sk_rx_dst_cookie);
+	else
+		dst = NULL;
 	if (dst) {
 		/* set noref for now.
 		 * any place which wants to hold dst has to call
-- 
2.53.0

