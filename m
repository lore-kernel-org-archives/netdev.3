Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F32F260C
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062626; cv=none; b=u0BNiESYnhQf7WQpSS04IEKtyfhjHJ4T5Zu7iagjFVnzmfdYppaulPhkpWxLEObU+UYbCNsLHk5IP3Q4zV4EKuioNizUUQSABrIPRr0QfnOhNWveoMC0/bgbQFVnHiepcPlhnuvDPLhM4aDmr5biZ1b/QAiQWUGAm0sT2KaPyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062626; c=relaxed/simple;
	bh=UOOtjxLD+ePAkCTZNapMKB1ITRJtok8U01FbNQ6kIzg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Row0+GRpRPktzML719xSGUdkujsxzigeu44Mf/dGoYFPu2azWJok17ZAO0MLLq0wUrHnGanUBPNhjhF+85txtHOBhIqPP/iS2zgxGQyFCdbLmob1WmjjJXtGHFNl5mQU6UdSONLWpZfiQi2uH0T8UBoGoOuI81H98UUs/jp0dGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBAZSV4K; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBAZSV4K"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-88a46301d92so431457b3a.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062624; x=1791667424; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X8DO8ihXYXfYY6jTG3+QcjiDXU0NSONJOIPatyzetS4=;
        b=KBAZSV4K4gj/YYWTvtyjNIyLJYzpW0eWAdNBbUXDZXhGnEk+Mi2jjuUb2Mmkbp9H6E
         ZZQpm26aei0k8eyUGzd8qHTmQ296qJNh1giD+g2wlK9I6ifGcBNa4lLjD/VUwN8zzuNY
         pJKgiLcZ2NL39NVPFl9sWzCsZu5oeEy6A+XJmys/30ERc7DAAIh02JmxKwQII5vCkhzu
         DE6Fv7GafbUaMw8k/uyl0HLgVzp2aIaR9zhZiw3q6sy6nkgfH4Hxk0hihx7iIh/S/pwl
         yL1/OIBVx9zRz7udB7p/Pgt2bohdyiunoFq4zwMJBxkoSepR89wI62YWxGCIy5/VmXeM
         ePLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062624; x=1791667424;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8DO8ihXYXfYY6jTG3+QcjiDXU0NSONJOIPatyzetS4=;
        b=GYyBZuDjB+ZPpB+sWyS/FV2bM+XJ0/xYIlzdqF9BR6nC0WaP56qcXUjSXIpQkmmDpV
         3jyt1pI9rQScaw1DIiPUbonhB08sKHd0VgAEMDBkMbSefnOLqB999A5vK8o+m/Wm9Y1B
         U/nsebnNciCR3YC5y77z82bj5+FC9EtTzGT08pB7Vb21VqFykUDyxlwqqwb/fRY2AuRJ
         1L+4R3pKyraUB/tZKxmvgJVtrEuZgNyIo8WZZoJaawoStTPObYLcb7ZoIIjXD5nycZT/
         EoKtkLIeYd5C1RamUOPgZZSULBowEby6CVpEL/JXMGxcZakBZEWOApad/yLyONyDC0xm
         d0nw==
X-Forwarded-Encrypted: i=1; AKwUvBwNkZIO41USDbxChcwJJujXK8gmtRL/O9I/hxHRMCexHUF802gzfAq5D1lnYqxS+aS6jlA1xKE=@vger.kernel.org
X-Gm-Message-State: AFuF++kS4RO3SVefJxfLEi4Ybv4BvWKChPMjJlfX/2NAOA0aOTRTnPnD
	freuTa2YKMG07kE83JYJtTZAnU6jvHOEfwxzIcevl8px5muiME25NtT7hD5HHvBDLWIBWrsUBFo
	XSe1AYQ==
X-Received: from pghf23.prod.google.com ([2002:a63:e317:0:b0:cc7:dec6:f88b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e083:b0:3dd:a197:7359
 with SMTP id adf61e73a8af0-3e0d6d3f54fmr3033328637.50.1791062623594; Sat, 03
 Oct 2026 14:23:43 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/9] neighbour: Add IPv4/IPv6-specific wrappers
 for neigh_lookup() and friends.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported that ip6_finish_output2() could pass tbl and dev
from different netns to neigh_create().

When namespacifying neigh_table, I chose to resolve neigh_table
in callers to minimise changes, but it turned out to be error-prone.

This series adds IPv4/IPv6-specific helpers for neigh_lookup()
and neigh_create() that always fetch the netns from dev to fix
the problem.

Along the way, the confusing and now mostly redundant helpers
__neigh_lookup() and __neigh_lookup_errno() are converted and
removed.


Changes:
  v2:
    * Add Patch 9
    * Patch 6 & 7: Convert __teql_resolve()

  v1: https://lore.kernel.org/netdev/20260930200326.718459-1-kuniyu@google.com/


Kuniyuki Iwashima (9):
  ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
  ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
  ipv4: Add wrappers for neigh_lookup() and neigh_create().
  ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
  mlxsw: spectrum: Resolve neigh_table right before neigh_lookup().
  ipv6: Use ipv6_neigh_lookup() and friends.
  ipv4: Use ipv4_neigh_lookup() and friends.
  neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().
  neighbour: Check n->parms->tbl under tbl->lock in ___neigh_create().

 .../marvell/prestera/prestera_router.c        | 14 ++--
 .../mellanox/mlx5/core/en/tc_tun_encap.c      | 14 ++--
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  6 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 77 +++++++++++--------
 .../ethernet/mellanox/mlxsw/spectrum_span.c   | 42 ++++++----
 .../netronome/nfp/flower/tunnel_conf.c        |  8 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
 drivers/net/ethernet/sfc/tc_counters.c        | 11 +--
 drivers/net/vrf.c                             |  4 +-
 drivers/net/vxlan/vxlan_core.c                | 14 +---
 include/net/arp.h                             | 16 ++++
 include/net/ip6_route.h                       |  6 +-
 include/net/ndisc.h                           | 31 ++++++--
 include/net/neighbour.h                       | 24 ------
 net/bridge/br_arp_nd_proxy.c                  |  4 +-
 net/core/neighbour.c                          | 11 ++-
 net/ieee802154/6lowpan/tx.c                   |  3 +-
 net/ipv4/arp.c                                | 26 ++++---
 net/ipv4/fib_semantics.c                      |  5 +-
 net/ipv4/route.c                              | 18 ++---
 net/ipv6/ip6_output.c                         |  2 +-
 net/ipv6/ndisc.c                              | 48 +++++++-----
 net/ipv6/route.c                              | 23 +++---
 net/sched/sch_teql.c                          | 15 +++-
 24 files changed, 234 insertions(+), 190 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

