Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970936897C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803455; cv=none; b=hSTPJcCQZlUekUVsNj5e0sgtEZ8531nh+WcQnB2kgLfy3HH3fKWdz7fvl3tbU33pF3dgN3le3KC5trv6Pdk59oLqxYZQtTobAayAdFKDVRVJ3ngtxNxx7+g0LozYIqNChPz1Ge2r+Tmckvg308wopsMQZjZBeXrNAWm5IBhDVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803455; c=relaxed/simple;
	bh=tu9GQCkW2/a4ZduxX832/M3fDhG3X+IgLSamgrHOn28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnfKmzVe11kI3fMuN4Xox+2COdUuxnDZ+ajIw60IxEde9d+bgEQoQYcvnqFtf9dcGzwsPqGqpHoUjBWgFk8D9hiP6dp+2Ujp0txagMOW/TJ5sut9ZWjRYW84HKO0mxBtXf1YOmANcC0lE9cJfW8IyyqzZU75n7684GPQLIeVZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwlVILZ4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwlVILZ4"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso331499a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784803454; x=1785408254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=entEM0RNZRg+1VcyXgyhCe1R1f8tBTudfno57EV1QXk=;
        b=LwlVILZ4v91F+9JmMIFZ50UvbqmxNlGISZRWthwak8d9w9ZECTQ3fmqx+80at1xf4j
         Sspi2rEADIN+l6SyBSqzeeo/yTwzdnvzDIgp2pVDaeAZptfuySCe+jgqLfIrm0mogCAn
         BHO8jwkoc5pXskjyaqCKlWuVlHRFkRXsdypMDsraDR6Q2TrJ0gBUT37kWxVXKq6z+jOD
         2/Nc6gj0gegQxMxjZ7kLRO40af836pSh8CigBItZY36tOcU9A6qc80UdTdnVge0rVxAG
         XxixyX3O0n5RttUu0zNuP1mvU+CkcPUpvyG7WzDpkDT4sxG3YIr8+bISTw2l6biU68kY
         D6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784803454; x=1785408254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=entEM0RNZRg+1VcyXgyhCe1R1f8tBTudfno57EV1QXk=;
        b=Hlwvg8pKAy6yCqFt/5PDefMNain5NDW6g0yR534a3cLibQdY/W9eRQY9W8nEo17GXK
         TQN83YG8xhxtU3sUFImk5GRI96q+PcH/X4rjNPQns1mbrFCfgWt1wruAF1+msfeePfKl
         /uLvG2IadDHQsdy5llLfh/8EU9mMhyt4wOGEKvqpOC7QX1zRBxH7/KKCHdm0qy2k0f+H
         H7N+f/YUt9Q+Jui+Ecn5eiKFy+71b0YPOfNBlzVsYTIs+x8aFOTi66BXLewFjYuTCBty
         CNGgE7k58J1a8xz9Ec7hrGcgWvXIZkVDTd2cR1jvyihppoFk2N6kLun/CVnT8Gcq5hLq
         pDsg==
X-Forwarded-Encrypted: i=1; AHgh+RpeWoBVW8eRSER3saIF63Tf/Do1QxVZk36Kn1+DnnEJDf4KcwPvCq3H95GdAB039yzp1bp5bAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4weXrq285nRnH64WH0FAHFin+XMwNCoIUKusUPE689ZmmkBN
	R7UcaH0wTPuNm1u3DG+UsumZ1o/0pFWHbkrZEs9gVVpjqifjq8kDi+G8
X-Gm-Gg: AR+sD106UtDJmpwd1jdOU3hJ67KPC3DklTdrOzLTBhWet/BGZyWZxJAemeA5xuKEoFA
	2mGGxPBqMREFqT12IwakyBTNOLP7ciDPUBTEOXGTvGoxmb8SprbemQ3eOcaKNq9+A1l/t5+Ofd3
	U+YNp6y6Wzc0RbQj2DYYfOxey0K7ZBoS+BkiRde8rBupxxgsFNOKudzkOhGw4vMglXg6+0qGnvw
	pJSpTdYBnmhE57TzJ/oHAF1VdecqAsvJHLWDvfVSqlHBEbwwqJDdC9CASPMHSzUmfoDrn0g5pY8
	uVi9htMvWn3HisVmNzAoGkQPt8K8QTFxRqvOkVoXrlXE2dj9Rm4gNsMYJB9KAG46HdTmtbbmjre
	KrMOQ88L+QBGL7JvAol6EhfAkDPCzEuF+hoeuogbK57Yofo05B+SPDF5LKYTZRKC4HiCUPCCNaZ
	UsaAlRU5kDQ2zdv8j+o32fkrMv+XZOa2f1fGKrPsBdYLBIn1Jdb9o=
X-Received: by 2002:a17:90b:4b0a:b0:387:e0bb:57f9 with SMTP id 98e67ed59e1d1-38ec6a9cfcamr2309332a91.42.1784803453420;
        Thu, 23 Jul 2026 03:44:13 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:86fb:a344:1a3d:eba0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea59c9b5asm1210262a91.3.2026.07.23.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:44:12 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/2] ipv6: report why a route was deleted in RTM_DELROUTE
Date: Thu, 23 Jul 2026 19:44:01 +0900
Message-ID: <20260723104403.7970-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel deletes an IPv6 route on its own, the RTM_DELROUTE
notification does not say why. User space cannot tell a route that
expired from one the router explicitly withdrew, yet the two call for
different reactions: an expired RA route means the router failed to
refresh it in time, which points at a misconfigured or unreliable
router and may warrant action such as disabling IPv6 on that network,
while a zero-lifetime withdrawal is normal, RFC-compliant operation.

This is a general problem for any consumer device running Linux,
especially on Wi-Fi networks, where multicast delivery is not
guaranteed (e.g. frames can be lost around DTIM for clients in power
save mode). The motivating case is Android: the userspace NetworkStack
process listens on RTMGRP_IPV6_ROUTE and today treats any loss of the
IPv6 default route as "router lost". To avoid the device repeatedly
gaining and losing IPv6 connectivity on a badly configured network,
when it detects the device is on a dual-stack network with working
IPv4 connectivity, it defensively clears accept_ra_defrtr and restarts
IPv6, so user space apps stop using broken global IPv6 connectivity
while link-local IPv6 keeps working. That reaction is wrong if the
route was withdrawn by a zero-lifetime RA (some ISPs do this
intentionally for reconfiguration) - with accept_ra_defrtr off, IPv6
never recovers once the router advertises again. It is the right
reaction if the route genuinely expired, since the router failed to
refresh it in time.

Fixing this in user space is not practical: RTM_NEWROUTE carries the
initial route lifetime (in rta_cacheinfo), but the kernel does not
resend it when a later RA refreshes the lifetime. So distinguishing
the cause of an RTM_DELROUTE from user space would mean opening a raw
socket, listening to RAs, and tracking lifetimes independently,
duplicating logic the kernel already has. Sending RTM_NEWROUTE on
every RA lifetime refresh was also considered, but that would be
spammy and is technically wrong, since a lifetime update does not add
a new route.

This series proposes RTA_DEL_REASON instead: it tells user space why
the route was deleted so it can react accordingly. In the Android
case, NetworkStack would defensively disable global IPv6 only on
RTA_DEL_REASON_EXPIRED, and take no action on
RTA_DEL_REASON_RA_WITHDRAWN, since that is RFC-compliant behavior.

Patch 1 adds RTA_DEL_REASON (u32) to RTM_DELROUTE notifications and
records the cause in the kernel-initiated IPv6 deletion paths:
RTA_DEL_REASON_EXPIRED for routes garbage collected after their
RTF_EXPIRES lifetime ran out, and RTA_DEL_REASON_RA_WITHDRAWN for
default routes, prefix routes and RFC 4191 route information routes
withdrawn by Router Advertisements. The rt-route Netlink spec is
extended with the attribute, the route notifications and their
multicast groups.

Only kernel-initiated deletions that user space cannot otherwise
explain are attributed. User-requested deletions are self-explanatory
to the requester, so they carry no reason; the UAPI documents that
absence and RTA_DEL_REASON_UNSPEC must be treated identically, which
keeps the door open for attributing more paths (nexthop removal
cascades, device removal) later.

Patch 2 adds selftests covering all three producer paths: a GC-expired
route, and a default route + PIO prefix route + RIO route advertised
and then withdrawn by hand-crafted RAs over a raw ICMPv6 socket (no
external RA tool needed), plus a check that user-requested deletions
carry no attribute. The notifications are decoded with YNL, which also
exercises the rt-route spec additions.

Changes since v1:
- Expand the motivation with the Android use case, per review request.
- Widen RTA_DEL_REASON from u8 to u32, per Netlink uAPI convention.
- Convert dict_keys to a set before the set difference in the
  selftest, for clarity.

Yuyang Huang (2):
  ipv6: report why a route was deleted in RTM_DELROUTE
  selftests: net: verify RTA_DEL_REASON on route deletion

 Documentation/netlink/specs/rt-route.yaml     |  33 ++++
 include/net/ip6_fib.h                         |   4 +-
 include/net/ip6_route.h                       |   2 +
 include/uapi/linux/rtnetlink.h                |  17 ++
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_fib.c                            |  19 +-
 net/ipv6/ndisc.c                              |   7 +-
 net/ipv6/route.c                              |  66 ++++---
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   7 +-
 tools/testing/selftests/net/rtnetlink.py      | 181 +++++++++++++++++-
 11 files changed, 303 insertions(+), 40 deletions(-)

--
2.43.0
