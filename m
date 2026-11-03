Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697678;
	b=KazXWSgQLwxinBkGr2HpE4xTFugLIWBLjUH+5CQUVmynYNZEtjiXGsAKdeiceAU2hzbp
	 MaQnAwCOAWRbyV9dhuy2QX9KE0zqFMSb6fJJiCHzxWlluARcgHLQy74+FEs8BrUB/C2jU
	 sxWA/Zt1bq+C9qAi55q1XeamO8f6/Hdr7Tpj1AXWh3jVHYBtdBt8WAcntk1mEYwPhXw0m
	 lRbXWjNr+gCFGoQGJ22Sa9ExqBs2SYn1Nhy3IxnaQchYRVhk5MgJmfDseixKIdj7sn5Rb
	 ErTmj8a1AHDjXDaIyPPngCB5Ixr39vyK1wWsw5iv7iDU8oNp1+9c4KKSnmdOLePRmcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697678;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=9seIfKUb5mL9/pRiltJe+WDkz9VAJT3ACyumajU4uZs=;
	b=kUirAHFv8myLjoCllo12TDXQz2wqweIiG4JPTEQlld7VB4n0qDvzC58tpLtuwSGHx07g
	 stPrUsq946VLRbqlu7/9Y/NT9L8p5B4Ye+14B/IvrtIci5TdTLRDnLCbAAcQYi5tP5Kif
	 RQaWYYsqVu5TVVLHUWhDBK4nRXiKe4eLYLAwQJJ9Ay0sJ/oSPB+FBOZ+z9Mqwo0ym6euw
	 Jbn6F+S1QxU1tmbFx/+ZYWASUVvMT2esDglGFzC9/MAKDVxS+VC8o+uMqOcEIA+saH7ha
	 wJ8I8r+WY46gQ20J/Nk1K7PJPlFBssnljqnl6s78ATiBVcYMQyovUijbIN2gfnj9FFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I0mgW61i;
	arc=none smtp.remote-ip=95.215.58.46
Received: from mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38274606A327
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38274606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I0mgW61i
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Dogg26upRcYPteVZYsSyT1265sb9gcafjUHnbvF97og=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793697675; v=1; x=1794302475;
 b=I0mgW61inAYftsexWS2+OTxq41aS9OM4setyUhQfKYaBmWfTJytrcMqojQ0HODeozLwBPc8B
 F2sx/UdNm9jEmk4u1B8Ym+o8SjPVTsrOktNVM0L/K66HIL7G9pqJIfOc53Pz+vjek0BaOQevYR5
 dfLHkzjveKcQhLRg/Iyy8nb4=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 6dbf83cf33588557;
	Tue, 03 Nov 2026 09:21:15 +0000
X-Mizu-Trace-ID: 6dbf83cf33588557
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net v2 0/3] net: ioam6: makes IOAM insertion transparent to
 IPv6 ECMP
Date: Tue, 03 Nov 2026 17:20:49 +0800
Message-Id: <20261103-ipv6_ioam_ecmp-v2-0-6ef0318bdb5e@kylinos.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBREf4XctTVtg/Wx4j8MIW25yFVpSYuNh
 PDvArpyeSYzcyaIGAgjXLIJAiaK5N0CcpeBbbW7IaN6YZBcKsElZ9QnVZHXXYW265nGHBuuc1N
 rhGXUB2zovR1eweEA5TeML3NHO6xXa62lOPgwbtoktvLPcPo3JME4Oxt1FAejmtzy4jE+yfm4t
 w7KeZ4/uK+fcMQAAAA=
X-Change-ID: 20261020-ipv6_ioam_ecmp-ae4ef0a4bdae
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.16.0

This series makes IOAM insertion transparent to IPv6 ECMP, as required
by RFC 9486 (C2): a packet carrying IOAM options must be forwarded
along the same path as the identical packet without them.

Patch 1 fixes the transit side: hash policy 0 hashed the raw IPv6
nexthdr, which becomes NEXTHDR_HOP once an IOAM Hop-by-Hop header is
inserted. The policy-0 key (and the ICMPv6-error flow selection) now
uses the nexthdr the packet would have had if the Hop-by-Hop header
carried only IOAM options and padding.

Patch 2 fixes the injecting node: on an ioam6 output destination-cache
miss, inline mode now reuses orig_dst so the ECMP sibling from the
original socket lookup is kept (the destination does not change).
Encapsulation may switch the destination to tundst, so it still
re-looks up the transformed packet, using the Hop-by-Hop nexthdr for
flowi6_proto (IPPROTO_IPV6 after encap) and precomputing fl6.mp_hash
from the packet so ICMPv6 quoted-flow and L4 keys are not lost when
ip6_route_output() runs with no skb.

Patch 3 adds selftests/net/ioam6_ecmp.sh, covering both places: a
transit forwarder with a multipath route, and an encapsulating node
compared against a plain ip6ip6 baseline.

The issue was found while reviewing RFC9486. It can be reproduced and
verified by the newly added ioam6_ecmp.sh test.

Tested with:
ecmp_rehash.sh
fib_nexthops.sh
ioam6_ecmp.sh
tcp_ecmp_failover.sh
forwarding/gre_inner_v4_multipath.sh
forwarding/gre_inner_v6_multipath.sh
forwarding/gre_multipath_nh_res.sh
forwarding/gre_multipath_nh.sh
forwarding/gre_multipath.sh
forwarding/ip6gre_inner_v4_multipath.sh
forwarding/ip6gre_inner_v6_multipath.sh
forwarding/router_mpath_nh_res.sh
forwarding/router_mpath_nh.sh
forwarding/router_multipath.sh

---
Changes in v2:
- patch 01:
  * use skb_network_offset() as the start of offset.
  * try get inner next header for ICMPv6 errors.
- patch 02:
  * use origin dst for inline mode, as dst is not changed.
  * use HBH nexthdr for encap mode, as dst may change to tundst.
- patch 03:
  * remove `-w` to prevent ping from ignoring `-c` and continuing to send
    packets before receiving replies.
  * remove beta_tnl warm up since the tunnel will be re-create every time.
  * move trap cleanup before setup
  * update some comments
  * remove tunsrc in ioam encap setup
- Link to v1: https://patch.msgid.link/20261028-ipv6_ioam_ecmp-v1-0-9b6715b6f4c0@kylinos.cn

---
Hangbin Liu (3):
      ipv6: route: consider IOAM options in ECMP hash policy 0
      ipv6: ioam6: use transformed packet nexthdr for ECMP re-lookup
      selftests: net: add ioam6 ECMP test (RFC 9486 C2)

 include/uapi/linux/in6.h                  |   1 +
 net/ipv6/ioam6_iptunnel.c                 |  79 ++++---
 net/ipv6/route.c                          |  95 +++++++-
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/config        |   2 +
 tools/testing/selftests/net/ioam6_ecmp.sh | 348 ++++++++++++++++++++++++++++++
 6 files changed, 495 insertions(+), 31 deletions(-)
---
base-commit: c3e67bd82b9b9b1a5118f09a429ccefe2aab0741
change-id: 20261020-ipv6_ioam_ecmp-ae4ef0a4bdae

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

