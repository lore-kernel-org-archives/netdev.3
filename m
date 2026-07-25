Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D330C165
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949148; cv=none; b=Jwm8t4seSIVu9gb73vfuaavaRAviFeaKTjST+dhwPDXc//CXprw3y9nF2QTLiJt9KtXfC7mwU2gb/uqaQs964SOguWJoiutQkNISjnUpP7byfV91FV8HfkVVAMI/31xU6OCuQUei4bAAHQ947fd1U7TlYzl9lQJ5+IWAP7B6YbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949148; c=relaxed/simple;
	bh=vsYifGke6lnY4KN8BmHH/Raq4kUbLLKlKIiC4+ggoeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfrEbgnm/FTvtClmUIRhQFVey8BrHoUMQfnQsgzNDX6xrau6M4KqUolNn119Dj3+mYc1K74MOlqsqcQnLAwf+MAsTUaeTW7vth21IXcatQ4W3A4AiOrNN1iS2+dNuF5Mczxoufl0khi9B7kSIeCjsFoaR3vkGtrhuUy2LIQeeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAFKYY1I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAFKYY1I"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce7d2adef4so13639615ad.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 20:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784949141; x=1785553941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMDNaLVs/3tHgNJc8HBi+uc/gjyAWEQ4BpGD5ItSc8c=;
        b=GAFKYY1IZm8M8XQKU+32CGsNuAaWgBXt3l/Y4iO0fMzuEbnODJu8O8nvBBkb8puxTv
         PdWZPutbtELHh0DBclBbZtH8XAj5v4RArnjACfL1EvlmMff8MYZhBj33cYfhn4ZiFg6+
         iAAKKGyHsIHaKAVtWF8ngGrCeCU3GgXal9Y0L3i15545pzJ4heTUdMwNjsc+TiWPVm+o
         JlOzkAIjn2rW7JVhOwhNf/gEzk7ANu9LYc3OQK53xpXGTn8Pg+lNYiDMyL6c6Cn8FHB2
         avZoRX6e9l4BGnBKuMWLD2DiWPZzdsZw70oJ+SVPzGGjhXfR4yDA2j6bc59ZopOgP2s9
         76vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784949141; x=1785553941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMDNaLVs/3tHgNJc8HBi+uc/gjyAWEQ4BpGD5ItSc8c=;
        b=b0OdeqHc+ptwy5IiO7eYsqZQi8cGFTDiznHX0RR0NziEVJrnNZgf/4DR1HHzKtY+h9
         XbZA6IoKEtOSmfcOQeJEE/fqzrTJitcZTMXxbwaEINhz7Be3ur6vPOaPQUovCGeqz2bQ
         8w5mpqyQuwPhpkBvicsubzz1LpYeu69Ub4b7IYk6YTdcdl2lto6m38FT3OrELs3jXmOi
         t107ef6+M9SpZp/Ek7neq+NEJEkNJ+o9BcB+it5tNATU7UsgiFdCNRIlz/rWFbRt26YV
         Z0hs5nYsJ6vmpbYHVSAY3rOW4iqKEAGqxfHEN+uI8h52tR2vIKd6pIIP9fShVBhRYfkx
         ijHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+ZRyE3sTnuYIr0CeLw7rV1yb6eWWx/J/ame1Pe4FV0LPH8KrEJi3U8hobL3xipnB4u+Iuw7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5m6ifW/qj29ZgfGuSa9lGqgm1hFlWapfpl7d1PKQsCckktRh
	T1V+3ob2xPk2qVLoKhhPbZu1GvmwHXppSNlA5sTVXYSpGb2rNABA3r0h
X-Gm-Gg: AR+sD12cOYvMI9P8K597spcI22j4eU8r+VRMLhW7WX7fiEGUMBM48UuPjDLTcws+yQp
	CONW4uVXhQUMR3ySwG5liD2cIYg/+xJlX+M2jTtqtlGnzL+Uc9+uWqEJpFobBLdLp+znUczevFu
	OeCqmN/HvKFVP/3Sesx+AqN6U7nEHinQYV46OsjI94jy25TKrIsiOC9/MKW0y3wz70GQacDuzPN
	XSN7biFtDJL6TVl4ciqvtgRx03mYoB0UknDq77NF3G3Hj0uMIkX85TPdx40RM7Vdgcx5CxOkiYD
	qUGZ7WG+zNgCk8NQpjshRIsmXNdLQ2YnqN/36XdhqLwzVQU/+UvLFMyOJXJPn/bYZ8h9axNWI1H
	+n9RW/JeZX44VForiTRotkYo+D7gte9LOAoHelwARx5WkV0ZHluuVgkPqrdFfuwGAK6Xk72k6yI
	an9622qziElrOxXaGZcgY7JcS1fJ6BS1KHeT2Xr9eTUIzMxKTvn2WkKNoF3Vx/pYPg
X-Received: by 2002:a17:902:f608:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2cfde795552mr9149185ad.6.1784949140575;
        Fri, 24 Jul 2026 20:12:20 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:a005:2f41:ab3d:c011])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e26e9sm3610265ad.23.2026.07.24.20.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 20:12:19 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Chris J Arges <carges@cloudflare.com>,
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
Subject: [PATCH net-next v3 0/2] ipv6: report why a route was deleted in RTM_DELROUTE
Date: Sat, 25 Jul 2026 12:12:12 +0900
Message-ID: <20260725031214.43059-1-sigefriedhyy@gmail.com>
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

Changes since v2:
- Fix the patch 1 commit message, which still said u8.
- Keep del-reason out of the newroute and delroute request attribute
  lists in the rt-route spec, since the kernel rejects it in requests.

Changes since v1:
- Expand the motivation with the Android use case, per review request.
- Widen RTA_DEL_REASON from u8 to u32, per Netlink uAPI convention.
- Convert dict_keys to a set before the set difference in the
  selftest, for clarity.

Yuyang Huang (2):
  ipv6: report why a route was deleted in RTM_DELROUTE
  selftests: net: verify RTA_DEL_REASON on route deletion

 Documentation/netlink/specs/rt-route.yaml     |  67 ++++++-
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
 11 files changed, 335 insertions(+), 42 deletions(-)

--
2.43.0

