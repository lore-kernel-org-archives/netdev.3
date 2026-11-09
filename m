Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212304;
	b=kct5GVX/qyakBaw7AaloDcNA03PSPEkH6DwYpIA9qg1Y3JOljO1yspzVy1n5LmBWGx5y
	 Os6bjef0p5zcMKxIg3rsGRvB7qOYUvseL9A0dYz9ggKnauzFr++SukBLWsN5CG4IjOMoC
	 iIlJz/2wqKkc1ypaxyjXtNK+h/p6VFcmddxXsLiD3fFiLzepd8P0yFpg7CLzHjSwXKp7B
	 1ZKBsaIQeDKRMit4rtxBZUfYJcDi05smbmNl+XDhJhOKaKPzGDx5KU57OWtV9Ih2RMC+D
	 zcjCXQhEnPqqMMC5g7d/NML83SMl7flrOPsm6R8UU33+FuZRWX45bADJ9Nd40YEntIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212304;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=o4oe6gDa9O6+CfgBCBBo/NwzOUax1uYWt/w2Plp/5ig=;
	b=4VEIiNaP0Q75CA8i++GWyUZxrs9yzTnBIXXJE5I3NLC+16gCQoOPY7/xgRRTCFKI+FPH
	 hCJyRPdF8+pBXT46zCzGlkqgRYOBEXsE/2xL4pzvcnZCRQ9vK6nmho5KakbP6f+bHUAHC
	 Xnm7fsJR3XmN1YYGNK/3vBC7wBdJtwtyg1jilRRSfubbypxqEVjE3WB6A93BQwdrd6nqZ
	 QDcV1MtISit5JMQ+bhsWMe3Gdz7Uln4wjRQG/A+jHyGUxFl8Rt9ZdKjXIO2bLi9uYBO6H
	 ZE/lyGrYZuK16immi7uh5tG481K3vu2KkG4cC+CKwJQ16Wdy4ubjWpLMhdmC3FkD/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="iLL/NW4S";
	arc=none smtp.remote-ip=91.218.175.138
Received: from mta0.migadu.com (out-138.mta0.migadu.com [91.218.175.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5583606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5583606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iLL/NW4S
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Nj39I8pNFtdvwT74hw4UvzUD7EsW6ZkkjkhPcP0ojFQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794212300; v=1; x=1794817100;
 b=iLL/NW4Sn29OcHjbdqVZe0VSg8cRFhKWy37PRUCkjunrpl0XF/Kp0dN1UIKtkmN6eHMCaTse
 pPKQ4PtErvTkruJ7SgrUsk2fbEjLM8VJCTDG1lKMUezYTquXXEbcr/9p/7ojBjQ8RQV02nDWxyX
 LnJGLuwRiT7lxGyGYzfKHs64=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e3faf30fe813c37;
	Mon, 09 Nov 2026 08:18:20 +0000
X-Mizu-Trace-ID: 6e3faf30fe813c37
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH net-next v3 0/4] net: make moving a device to another netns
 cheaper
Date: Mon, 09 Nov 2026 03:18:11 -0500
Message-Id: <20261109-bug-net-netns-move-rcu-barrier-v3-0-6084b02610b3@linux.dev>
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
X-B4-Tracking: v=1; b=H4sIAMOB8WoC/43NvQ6DIBQF4FcxzL0NoPLTqe/RdBBEJanSgBIb4
 7uX0sWtHe5wcnK/s6FgvDUBXYoNeRNtsG5KoTwVSA/N1BuwbcqIYsoIJgzU0sNk5s9NAUYXDXi
 9gGp8cjy0UgrNSlmLEqOEPL3p7JoHbuj7t87onprBhtn5V16OJPf/jkQCGCpS85ZLwWrRXfuxs
 Y+zdmOmIz1y8idHE6eYUZwLrCtJj9y+72/WEVnjJQEAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

Moving a device to another netns waits in rcu_barrier() with RTNL held.
Container and sandbox managers move one end of a veth pair for every
new network namespace, so this barrier limits how fast such namespaces
can be created on the whole system, to under 80 per second in a 4
vCPU guest however many threads create them.

The barrier was added for NETDEV_UNREGISTER_FINAL, which is long gone,
but it still keeps cached IPv4 routes through the moved device from
being accepted in the old netns, and it lets the RCU callbacks of the
nexthops removed with the device flush their IPv6 route exceptions
before the move. Routes through nexthop objects are not fully covered by
it: their cached dst entries are released by an RCU callback queued from
another RCU callback, so a socket in the old netns can still send
through a device that now belongs to another netns whenever the route
generation numbers of the two netns happen to match.

Patches 1 and 2 draw the IPv4 rt_genid and the IPv6 fib6_sernum bumps
from sequences shared by all netns, so a cached route no longer matches
another netns. Patch 3 flushes the cached routes of a nexthop group when
one of its members is removed, instead of leaving the IPv6 exceptions
through that member valid until it is freed. With these, nothing relies
on the barrier, and patch 4 removes it. Patches 1 to 3 fix bugs that
exist today and can go to net on their own if preferred.

Without patch 3, removing the barrier lets a socket keep sending through
a moved device that carries no IPv6 address and is a member of a nexthop
group, until its exceptions are flushed. Datagrams a socket in netns A
sent through such a device after it moved to netns B, 10 trials:

                   patches 1, 2, 4     patches 1-4
  datagrams               561-6525               0

Creating 400 netns, each with a veth pair whose host end is moved back
to the initial netns, a tap device, addresses and routes, in a 4 vCPU
guest, median of 5 runs:

                   before      after
  1 thread        46 /s       56 /s
  4 threads       58 /s       84 /s
  16 threads      75 /s      146 /s

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V2 -> V3:
- Add patch 3: flush the cached routes of a group when one of its
  nexthops is removed. Without it, patch 4 lets a socket keep sending
  through a moved device that has no IPv6 address (Sashiko review)
- 1/4, 2/4: say that cached routes carry values drawn from the sequence
  because inserting a route bumps it, not because NETDEV_UP does, and
  that this holds until the sequence wraps (Sashiko review)
- 1/4, 2/4: add Kuniyuki's Reviewed-by, the code changes only in comments
- 4/4: commit message only, keep Eric's and Kuniyuki's Reviewed-by
- Rebase onto net-next and remeasure in another guest, where the barrier
  costs about 4 ms per move instead of about 10 ms, so the gains are
  smaller than in v2
- Send from my linux.dev address

V1 -> V2:
- 2/3: keep the initial fib6_sernum of each netns and never hand it out
  from the shared sequence, instead of drawing a value at netns creation
  (Eric Dumazet); 1/3: do the same for rt_genid
- 2/3: note that fib6_sernum is no longer monotonic per netns (Eric
  Dumazet); 1/3: likewise for rt_genid
- Drop Kuniyuki's Reviewed-by from 1/3 and 2/3, which changed
- Rebase onto net-next and remeasure

v2: https://lore.kernel.org/r/20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com
v1: https://lore.kernel.org/r/20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com

---
Qiliang Yuan (4):
      ipv4: draw rt_genid from a sequence shared by all netns
      ipv6: take fib6_sernum from a sequence shared by all netns
      nexthop: flush cached routes when a nexthop leaves a group
      net: remove rcu_barrier() from __dev_change_net_namespace()

 include/net/net_namespace.h |  5 +----
 net/core/dev.c              |  1 -
 net/ipv4/nexthop.c          | 10 ++++++++++
 net/ipv4/route.c            | 21 +++++++++++++++++++++
 net/ipv6/ip6_fib.c          | 16 +++++++++++++---
 5 files changed, 45 insertions(+), 8 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261016-bug-net-netns-move-rcu-barrier-d998c6395830

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

