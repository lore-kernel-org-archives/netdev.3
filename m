Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385374;
	b=NvVZUiizwjhEJTlznKtsZKZ4ER3q9HdOD0uQhjx3Kysuq21BEBYQ/sqWS2PkVJAMZNsZ
	 bamQue0kqPTnJtMcQnJtVOy3HjK4/QHVJtkYRz2Ev20IsdQTOwZPKJ1EweTYKTBGIN5Xn
	 VlGrQQcy/5Qlb8qdAo6lfp1QoD6oHOIYz6+EQSgwQbZBfnySkXqMr4T+nEbfuwdfyvUGZ
	 9/OlUT+e570FWuL1Ijz/9UfDt/J+IUFuoqaT+rHlRFhIRGXe4QYYefF1l3r+obafGa68w
	 HIWkAA/mzhVhVke0ewDTpT5dwJ0l2CnMaw5tUTdgWhIpfDrxQEn5v2KjdwllPtA9ESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385374;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=jOdCR7DybIvzy/7/bVj7X2472LW7lSSfULLnLbFNX14=;
	b=2myYeXtSKPCMSgTyDCQXlbZlvicPQum2zw2phubWN1SiiBYU/lvD0N3Ngo3JImforSB0
	 xSd9uRygxNBJZKZlS5XkHtuCFnO3nIkU2ujunLuN5jJYf9WMaDIbvf2qij2QmwO4MuQ1K
	 ibvcWxu1TqkezgCr5znv5ymwdO1/kt6oD0LFiL+gGyQhU/hswsmjlDUWbKaLXTXerN4hc
	 C8yiqFcVouwSTZKwHnOxPudj0cb0t0yt8LyWT5sh4vngEePGioKDzZrMvX4T7OaHcDcm4
	 MlNZQaRrJkhl923syhZhZ9HxrvKEEPsIsY98kOgI3jawpBO3NiqtSkcP9i1bH6ltB3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yVrt5bP6;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA4606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74CA4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=yVrt5bP6
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jPc2x418nz3xv8;
	Wed, 11 Nov 2026 09:22:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794385369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jOdCR7DybIvzy/7/bVj7X2472LW7lSSfULLnLbFNX14=;
	b=yVrt5bP6/FzE4viGqKlsOX7wwzaCpycSeprJmjCSRj84LEkQD1Dhjt9KiKk5sqtlAW27LX
	ohOiyMZQmcRjTBJiA0uOw/eB/qou74J8rV52M2ENB9JERpYjJ1Y2Ri+fA1VOOhOMdngzCD
	0SRyZoDSLYawX4Xy9IHTMcoAp11CXYupz7WqfS81ZkPjrF4kB47XaVdWH3u6fmSJG1Q4iP
	Sp19/8sFiAFLEWJfFEuANNDc74uvWJWcrdt55pUEcw+V34jboP5LWP1tOf1XprIrnALKVN
	d2GKzii0fvedVn1XsZZwPijTB3Dyd+rECP87XO3zhKlcIimB+1KE/RZHu/hHEg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
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
Subject: [PATCH net-next v2 0/3] ipv6: tie the dst cookie to the lookup that returned the dst
Date: Wed, 11 Nov 2026 09:22:34 +0100
Message-ID: <cover.1794384146.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jPc2x418nz3xv8

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
Changes since v1 https://lore.kernel.org/netdev/cover.1793806941.git.ralf@mandelbit.com/
- Fix kdoc return statements in patch 2/3. (NIPA)

Ralf Lici (3):
  ipv6: stamp the default route node with a fresh serial on link failure
  ipv6: add ip6_dst_lookup_flow_cookie
  ipv6: use the lookup cookie when caching the dst in sockets

 include/net/ip6_route.h | 18 +++++++++----
 include/net/ipv6.h      | 13 ++++++++++
 net/ipv6/datagram.c     |  6 +++--
 net/ipv6/ip6_output.c   | 57 ++++++++++++++++++++++++++++++++++++++---
 net/ipv6/route.c        | 24 ++++++++---------
 net/ipv6/tcp_ipv6.c     |  5 ++--
 6 files changed, 98 insertions(+), 25 deletions(-)


base-commit: c4c470912125ec8a1a427a70f4085d8a731b00e4
-- 
2.56.0

