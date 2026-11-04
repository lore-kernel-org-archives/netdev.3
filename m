Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807653;
	b=WMybuL4SXQEXDkK8US36sAWW7updNX1rqzuha9UZwqwpwUKZ3ofAQnoiL88tRDbGWgX9
	 5QKPwggldhejxiT2U5rWkTfV+CoUeSOsDlyqIZ4mVgY84FPcsHjymJKxDvTBzYGRqK9ku
	 IPNRvbjMjQeEeXeEAo347xX4ciaJmBPSSNnv0FJDyNqxskpBmetPrs+s6KQRt9I88l5DH
	 VdVWPtz0/XARP9hBmEJnl0BIXAae+HJvMLmeJxVs0cCn/WWO2MgKQXGrUseQMPTYCmGV9
	 sIXr/MmldTmrq0+GJXCrBlTUrT8a6smJrUS2FKOGJMzKTWly9XZF7XXaBzieW7Lg0Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807653;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=3ZyKVlgETx/e5PJXK1nIzrIGfB7mow/Rq5EMyqi1gw8=;
	b=oVIabaDKY7s6Jh4PV4HTRu5jcsS1ulghkm5uPiUj0pV/tmw39Vx0x4cL2Pi2wetRuEes
	 uHJLJZ2dbIqpb8TVOvlzxO1DDBvKer/qxM0dpIVjE06EhVJlPvqkkHl36BQ/NEcjWwcuJ
	 jIUE6hb2toVX8KOlPWN2VrZ7Oc/27YBDTpiN0nU6GmQTQLk5+U7axfqTWiSsRdF7D84WK
	 57B0NqChX8Gc67KMR+JNpUN6h4n1WYXFTsjY4sn5871JSZigRuXnpl5c9fE1HdwZu3tsp
	 KiNmtZC5YNpTDusPSsbEbUYhrjogDbYzZwReSXw5b1Nq0KA3q2dpBwTavyFdDbNZ+fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b="E0ixl/Yi";
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E94606A330
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E94606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=E0ixl/Yi
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jKVNj5Ts8zNltw;
	Wed, 04 Nov 2026 16:53:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793807637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ZyKVlgETx/e5PJXK1nIzrIGfB7mow/Rq5EMyqi1gw8=;
	b=E0ixl/YinGNQhnB4ZG2o2Rf0sU+Lyv3QubVHY8S8j8NLzppnoFQEeatuXGOfMcV+aCgphn
	b1JxhZxjRujM8R1lOjVyaKT2EtI/CbVhtCrZkQ8H28f9wtgbIjGUlly2t68Zm/IsZJCvmI
	hs8HHkbNmcd6p/Di3CecT9mJewiozjn+5uGOeGYSgcUdRaBH9G8lnRMlFLyZNBrtALJOsI
	D8CBcf+je7hCOxw9gVIlEugVcXCoUteDSpv+Qwq1JxVl6loqfI2mcJE3Rt033azAO5/onV
	Jnt2N15PC0s0jujvw6CRMZLfHLiyCARBlhmTMjWIcPT+vHfEv5+osK35wUuDew==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net-next 0/3] ipv6: tie the dst cookie to the lookup that returned the dst
Date: Wed,  4 Nov 2026 16:53:28 +0100
Message-ID: <cover.1793806941.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jKVNj5Ts8zNltw

Hi,

This series implements a first part of the model proposed in [1] to
address the late cookie sampling race: a dst can be stored together with
a cookie read after a FIB change that its lookup did not see, and then
passes dst_check until the next change.

The case that made me post it as a series is xfrm. Adding a policy
restamps every fib6 node, so a socket whose lookup ran just before the
insertion keeps its plain dst and leaks plaintext although the policy
matches. I reproduced it for TCP connect and connected UDP, and the same
window lets a more specific blackhole route be bypassed for routes using
nexthop objects. The ovpn patch [2] hit the same pattern in
dst_cache_set_ip6.

The conversion is initially limited to tcp_v6_connect,
ip6_datagram_dst_update and ip6_sk_dst_lookup_flow. Other TCP TX cache
paths, including established-socket route refills, header rebuilds and
accepted-socket setup, still use late cookie sampling. This gives the
lookup-cookie API a small set of users and concrete fixes to review. If
the approach is accepted, I plan to follow up with a broader conversion
across the networking core and drivers.

Compared to [1], the fallback cookie is 0 instead of the pre-lookup
generation, so fib6_flush_trees is left alone, and nexthop-object dsts
are checked in ip6_dst_check instead of passing the generation down to
ip6_rt_pcpu_alloc. The other cache users (dst_cache, sctp, ipvs,
flowtable, sk_rx_dst, the xfrm bundle cookies) are not converted and
behave as before.

I tested it in a VM with lockdep, PROVE_RCU and DEBUG_ATOMIC_SLEEP,
using a debug-only delay after the lookup to hit the window: no
warnings, and the plaintext and blackhole bypass are gone in these test
cases.

[1] https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/
[2] https://lore.kernel.org/netdev/cover.1789639346.git.ralf@mandelbit.com/

Thanks,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (3):
  ipv6: stamp the default route node with a fresh serial on link failure
  ipv6: add ip6_dst_lookup_flow_cookie
  ipv6: use the lookup cookie when caching the dst in sockets

 include/net/ip6_route.h | 18 ++++++++++----
 include/net/ipv6.h      | 13 ++++++++++
 net/ipv6/datagram.c     |  6 +++--
 net/ipv6/ip6_output.c   | 55 +++++++++++++++++++++++++++++++++++++++--
 net/ipv6/route.c        | 24 +++++++++---------
 net/ipv6/tcp_ipv6.c     |  5 ++--
 6 files changed, 98 insertions(+), 23 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.56.0

