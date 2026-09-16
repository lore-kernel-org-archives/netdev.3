Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620784BC016
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552940; cv=none; b=eh8RphgKqMgO+YHG40Dez08A43Qyk5Pzve+rpZnzJgeRjLahn4ZVy0W4cD+4krE08Zi34A+LuHLTebb3/Uuk65v1KOLiz8HFTEtREDr/ngS9CdF8e10vRnO9sbxNwGodQlKH7Hnz+FE3YLEd9DmZC0F31IcsH8XbQIi2fTdkXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552940; c=relaxed/simple;
	bh=ScrI+OiW80Qtp4t9qnqo7sVpJ5ciutPYDjsW6X1jD2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ibbUpYdLZ54w2HTlyprCkz5zYElgu8nRJPOnefshJ2mjmjWDlbGOVysmforkGTjpZU5APxiq7NGsGJAUoZl3UrzaSU9+a89WRxNhIk/uD+FEWHziZWaLeda8MW3N86QUr12clkAPaRDycrKwrtJJl/sQS8fF81iaD5aoEmuhzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlZhbdNg; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlZhbdNg"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so1011050385a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789552916; x=1790157716; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Zz/pD5/kn9SVXyH3cIjYHX+FUnqFyFf/FctF5HVTv0=;
        b=BlZhbdNgMrm2b1O4hG0DmJbqaw5yuSYwQNRXeBQBiG+Ioals/45cRmk4x78wpA9bIu
         06XbzQTqNiYhJpDFdQoXr3okZFYUsELHQ5vpUCV1YpVk5H9dz2f5BiWauQ/Gyqginaxc
         HZi1S6EisZtDUnlbHf1pC1Y3cjRWVQLUTQHzWy/sxUYnGvcurS0ii8AoXA409tPpcHYf
         3LXHD29XlrolOOcGsuudynRmDd2BJ3xFKbBvGEPlIywlC236qfwQLUWY4hzNzuQDVyQk
         TW0tJR2c0Dq1yf13I84Bvgltxa7ngkBQoxAJzh9Xphct4Jn5hEnwc8JmexYF5wWWJnCi
         2whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552916; x=1790157716;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Zz/pD5/kn9SVXyH3cIjYHX+FUnqFyFf/FctF5HVTv0=;
        b=bmi4iKd/ZNhTP///xpUyAlo32LDhEDI4rn/7vRSmfAM8zWETApBx6yYfsmB6MRPRsr
         0FIrdducnzQa7E9CldX9HmLvyxShiWMMUYxuoF1lxBpgz8VZccMkCnzNws5mo0OXU/1h
         CpnRmtTu2pN94a1cKS4t9QPhABKDX+IWG+8kUYr1HcMtJnPY9pZnGG/xGm/3r9yuAQcv
         KHwvcgdRHbwnW35/Kbfw5u2a9FzcNb27mI1PNM+sY9lJ4hicI3BR9vdYO4qO/dLSZyOs
         GQQwhlXz9XKRAk1bTPigFoHS+rbkTc6YxcPNctGcjF/rxinEJsPASrzDozZFL7nkc/yL
         U/OQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGvnLCbUJpA7AoBBaK16wti5t9Ero188W5gyz/6SQLUde+PYQM3wTKzXTQrk4go87Cb1MBO04=@vger.kernel.org
X-Gm-Message-State: AFuF++lkUg0PcVEz7zR9zIGcMD5ooGf/ivrvOPDrqZVRDOzN/BXMWWaY
	nseWcjCz1nA/VW7E9W4qgGhea79Dauv5RjaU+sVZVqSvaglyG6u4EKge/gl7pkkEJufaHHm0lWw
	WjKFpTMfoiySQbw==
X-Received: from qkbf18.prod.google.com ([2002:a05:620a:6d52:b0:93a:141a:46cd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:371a:b0:92e:7383:4a93 with SMTP id af79cd13be357-93bb78c01d4mr319490385a.35.1789552915726;
 Wed, 16 Sep 2026 03:01:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:01:50 +0000
In-Reply-To: <20260912150944.3470971-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260912150944.3470971-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916100155.1398403-1-edumazet@google.com>
Subject: [PATCH net v2 0/5] ip_tunnel, ip_gre: fix changelink lengths and
 ERSPAN receive
From: Eric Dumazet <edumazet@google.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes bugs in how IPv4/IPv6 tunnels and IPv4/IPv6 GRE/ERSPAN
tunnels apply a netlink changelink, and an out-of-bounds read in the ERSPAN
receive path. They all come from the same place: the changelink paths mutate
the live device as they go, without keeping tunnel->hlen,
dev->needed_headroom and dev->mtu in sync.

Patch 1 stops ip_tunnel_encap_setup() and ip6_tnl_encap_setup() from clearing
the active encapsulation before the requested one has been validated. They
memset() t->encap before calling ip[6]_encap_hlen(), so a request naming an
unknown encapsulation type, or one whose module is not loaded, returns -EINVAL
with FOU/GUE already switched off on a working tunnel, while t->encap_hlen and
t->hlen keep their old values. The memset() is redundant -- all four fields of
struct ip_tunnel_encap are assigned unconditionally once the length check has
passed, and a tunnel being created starts from the zeroed private area of
alloc_netdev() -- so it is simply removed. net-next already removed the IPv4
one in commit 88b84cae6b94 ("ip_tunnel: use WRITE_ONCE in
ip_tunnel_encap_setup"), which is not in net; removing the same lines here
keeps the merge trivial, and extends the fix to IPv6, which that commit did
not touch.

Patch 2 makes ipgre_netlink_parms() and erspan_netlink_parms() parse into
local variables and commit only once every attribute has been validated.
Today a request carrying IFLA_GRE_COLLECT_METADATA together with an invalid
IFLA_GRE_IGNORE_DF is rejected after dev->type has already become
ARPHRD_NONE, which breaks the interface for good.

Patch 3 stops maintaining the device lengths as a difference.
ipgre_link_update() adjusts them by a delta computed from tun_hlen only,
while ip_tunnel_bind_dev() assigns the same fields from tunnel->hlen. Two
writers, two models, and a delta that ignores the encapsulation, is applied
on top of the absolute assignment when the link changes too, and is computed
from a length ip_tunnel_encap_setup() may have published for a request that
then failed. tunnel->hlen is now recomputed from tun_hlen and encap_hlen, and
ip_tunnel_bind_dev() becomes the only writer of the device lengths. The patch
also restricts the dev->hard_header_len update to devices installing
ipgre_header_ops: ip_tunnel_bind_dev() subtracts hard_header_len from the MTU
only for ARPHRD_ETHER, so the old "if (dev->header_ops)" was inflating
gretap's 14-byte Ethernet header and having it subtracted a second time. Not
a memory safety issue: ip_tunnel_xmit() computes its own headroom for the
encapsulation, only the advertised MTU is wrong.

Patch 4 gives ERSPAN the same treatment, where erspan_tunnel_init() was the
only place computing tun_hlen and hlen even though erspan_changelink() can
change both. After a version 0 -> 2 change tun_hlen is still 4, so
gre_build_header() writes the sequence number at greh + tun_hlen - 4, that is
over greh->flags and greh->protocol, corrupting every transmitted packet.

Patch 5 fixes an out-of-bounds read of the ERSPAN metadata in collect_md
mode. erspan_rcv() and ip6erspan_rcv() copy 8 bytes from 12 bytes into the
GRE header, but only pull erspan_hdr_len(ver) bytes beyond it, which is 0
for version 0. A type I packet (4-byte GRE header, no ERSPAN header) reaches
a collect_md tunnel through itn->collect_md_tun and takes the
ERSPAN_V2_MDSIZE branch of the ternary, and a malformed packet with an 8-byte
GRE header and ershdr->ver == 0 gets there too, on both the IPv4 and the IPv6
side.

Apply order
-----------
Patch 1 must land before patch 3. ipgre_changelink() returns early, without
reaching the new link_update: label, when ipgre_newlink_encap_setup() fails,
which is only correct because patch 1 guarantees that a failing
ip_tunnel_encap_setup() has published nothing.

Behaviour change
----------------
Patches 3 and 4 recompute the MTU from ip_tunnel_bind_dev() instead of
shifting it by a delta, as ip_tunnel_update() already does for a link or
fwmark change. It is guarded by tunnel->hlen != old_hlen, so a MTU configured
by the user still survives a request that does not change the header length,
but one that does now discards it.

Patch 5 rejects an ERSPAN base header whose version is neither 1 nor 2,
where such packets were previously decapsulated. For version 0 the current
code leaves the 4-byte base header inside the payload, corrupting the inner
frame, and the transmit side (erspan_fb_xmit(), ip6erspan_tunnel_xmit())
already rejects anything that is not 1 or 2. Native ERSPAN type I tunnels
are not affected: they send a 4-byte GRE header and take the
is_erspan_type1() path.

Notes for reviewers, because not all bugs are fixed
---------------------------------------------------
The changelink paths still commit into the live tunnel step by step. A
rejected request is therefore not a no-op, and since the xmit path is
lockless, a concurrent erspan_xmit() can briefly see a new erspan_ver while
dev->needed_headroom still describes the old one. Patch 4 shrinks that window
from permanent to the duration of a single changelink, since
erspan_changelink() does not refresh the lengths at all today, but closing it
means publishing a whole new configuration atomically.

The same is true of __gre_xmit(), which takes a snapshot of the flags from
its caller but reads tunnel->tun_hlen live, while ipgre_changelink()
publishes t->parms.o_flags before ipgre_link_update() recomputes tun_hlen.
gre_build_header() walks backwards from greh + hdr_len - 4, so the two must
agree: new flags with an old tun_hlen writes the sequence number over
greh->flags and greh->protocol, and old flags with a new tun_hlen leaves the
four extra skb_push()ed bytes uninitialised on the wire.

Both are pre-existing and both need the larger rework, which will come with
the ip_tunnel RCU conversion in net-next.

v2:
  - Patch 1 is new: do not clear t->encap before the requested encapsulation
    has been validated, in the IPv4 and IPv6 tunnels. It must precede the
    former patch 2, now patch 3.
  - Patch 5 is new: fix the out-of-bounds read of the ERSPAN metadata in
    collect_md mode, on the IPv4 and IPv6 receive paths.
  - The three patches of v1 are unchanged in intent and become patches 2, 3
    and 4.
  - Patch 2 (was 1/3): clarify in the comments that only the attribute
    parsers become all-or-nothing, ip_tunnel_changelink() can still fail
    afterwards.
  - Patch 3 (was 2/3): test for ipgre_header_ops rather than for any
    header_ops, so gretap keeps its 14-byte hard_header_len; add a second
    Fixes tag for fdafed459998; drop the incorrect claim that
    ip_tunnel_xmit() cows before ip_tunnel_encap() pushes the FOU/GUE header,
    and describe instead the headroom ipgre_xmit() already reserved at tunnel
    entry.
  - Patch 4 (was 3/3): also refresh the lengths on the
    ip_tunnel_changelink() error paths; replace the skb_under_panic() claim,
    which is not reachable, with the actual GRE header corruption.
  - All five patches now carry Cc: stable@vger.kernel.org. Patch 4 does not
    build without patch 3.

Assisted-by: LLM
Link: https://lore.kernel.org/netdev/20260912150944.3470971-1-edumazet@google.com/ [v1]

Eric Dumazet (5):
  ip_tunnel: do not clear the active encap before validating the new one
  ip_gre: validate netlink attributes before changing the tunnel
  ip_gre: compute tunnel lengths absolutely instead of by delta
  ip_gre: recompute erspan header lengths after a change
  gre: fix out-of-bounds read of erspan metadata in collect_md mode

 include/net/ip_tunnels.h |   1 +
 net/ipv4/ip_gre.c        | 201 ++++++++++++++++++++++++++++-----------
 net/ipv4/ip_tunnel.c     |  19 +++-
 net/ipv6/ip6_gre.c       |   2 +
 net/ipv6/ip6_tunnel.c    |   2 -
 5 files changed, 164 insertions(+), 61 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

