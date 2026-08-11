Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B428469A
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415093; cv=none; b=nVdO08YBJFH7v1RH+TB/cj5fWQl7RRjmUOGc2BjU+XEtgnGN+8Z4A+fwTxCy4maV/4/36Dq89ymSiraGJfTvyZF84uLTC0ccBxKMNuyTc8Ws7Hsx6sIPTvIG4c1FuKfk2VoeMHq+iABNPonrMx1cZsdm9G4UQkF4GI8990f2lR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415093; c=relaxed/simple;
	bh=lZZRG+O8ffo/8/z7RSO0YbL9QNxGyRDVGo/8oEmxgNo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F/soCHvTKDX0Hh0kHFoVzKI2UXUh4Ql5/5dKoXxVINarExKQhEzxgRnn+TTPmf+RgAhEX6IS0iiTRZncPT4yzFQa6RFO6kH0QteWn6VmyDAFl+8ayUU8uYDh4u3ia/5RIyKpaGqc7ywdoBZn0mpF8V5zCvGfzQKtOAlh4C+eVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6XUo/r+; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6XUo/r+"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso502908a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786415091; x=1787019891; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bOBZV723kmpmcb3Zi7Vbz9yv0bbRUvSB3taXh7V4Tqg=;
        b=k6XUo/r+tFREq0W0lOYFmkv+Q8PRSnh/dnUS7ohsfDb+jjiBBwxklddrqHhvv/P1bs
         3Vgg/5lFwAVmsyJIXG6ZFBRAirKAimqGZ7rrnGpLT/PUk1SB6WKLi53jJCn1gakKk25A
         Ehq2qY5hOuqXhJiwVTeoyYaIBA/DwHTn+TTMRpWRAcrfpQpjvV1OMVBn5IYzJFoAQa4t
         DAWl3YhMONjcpb0RYIIqp7zIYVdU0D0gHtriSZpEYJbPi2qEVXy/hldCC56UO8XjcByZ
         5bPe5wuxL74qXMF8WMmYdPcFnIgMFCXyWTIPQqkBRBJEp+LOfniIvwVMWYjIZ24Cpyyv
         xS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415091; x=1787019891;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOBZV723kmpmcb3Zi7Vbz9yv0bbRUvSB3taXh7V4Tqg=;
        b=areqWcYmTeykq4fk9DTZ41rudwkOVUdSvGKyHgutiI0xoeHVkamAHQncggVM080iQy
         ZSSxQ86KmKxyUwq26wX9/mgUaENh+mFY25dTZqsFHjCcaGviKUjPk1Nq53RbRRScqNLj
         bvP6MoOEOEArtXiKRzdtYJ3RiAlhI0iArsLzx+19SWKm3M1IP2XyZmpbD85modZTIZOp
         hjVawHxbl6lHfgqOz91/QEMLvHT/382POQgypyUIEls4+UlSswuAP688xz83Hl3aUQnl
         supJ7qW7AIpbDQQhQiNbDhIe8EMUgKY1BHA/cH0XqQqkEszGn2Ny3wtXiU4+Aelfn8wd
         3ctA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4zvfs1/y576gE9fKF2MVq9bC4ViQNdirouT315TcX4O3+jxmufGZ2XVJS9OjRdLr0sxLzT60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLebuxtGieyI82d3BmX/L5FNlQD7KP2QHsKUqvvm7Bmgags/4
	OaErD8uL5dedQ8dDRzX9WJyhrj9rrkWbutuJCyCz7/awuyHaOZdk3TYc/jsveBUSsxDhuEY6d2q
	HCwiALg==
X-Received: from pjtn6.prod.google.com ([2002:a17:90a:c686:b0:38e:3cf9:2e8b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5447:b0:380:83fc:4315
 with SMTP id 98e67ed59e1d1-3903c66b3bfmr52580593a91.21.1786415091169; Mon, 10
 Aug 2026 19:24:51 -0700 (PDT)
Date: Tue, 11 Aug 2026 02:23:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260811022448.116235-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The neighbour subsystem is almost ready to drop RTNL.

However, the control paths are serialised by the global
per-table lock.

This series converts arp_tbl and nd_tbl to per-netns table.

Patch 1 deflakes test_neigh.sh.

Patch 2 ~ 3 are misc cleanup.

Patch 4 ~ 7 store arp_tbl/nd_tbl to net->neigh_tables[] and
remove the global neigh_tables[].

Patch 8 ~ 9 replace the direct access to arp_tbl/nd_tbl to
net->neigh_tables[] using new helpers.

Patch 10 ~ 12 finally replace the global table with per-netns
table.

Patch 13 ~ 14 clean up unnecessary net_eq().

Patch 15 updates test_neigh.sh.

Note that some buggy drivers access nd_tbl without checking
disable_ipv6_mod, so nd_tbl's extern definition is still left.


Changes:
  v3:
    * Add Patch 1 & 11
    * Patch 12
      * Remove timer_shutdown_sync() in neigh_flush_one() and
        rely on tbl->entries (Patch 11) to free it in neigh_table_free().
    * Patch 15
      * Remove stale comments

  v2: https://lore.kernel.org/netdev/20260807232932.3986667-1-kuniyu@google.com/
    * Add Patch 11 & 13
    * Patch 7
      * Add note about mlx5e_tc_update_neigh_used_value()
    * Patch 9
      * Add __maybe_unused to net in neigh_table_clear()
    * Patch 10
      * panic() when register_pernet_subsys(&arp_net_ops) fails
      * Add timer_shutdown_sync() in neigh_flush_one()
    * Patch 11
      * Split from the next patch
      * Remove net comparison in pneigh_dump_table()
      * Remove net arg of pneigh_create(), pneigh_delete(), and
        pneigh_lookup()

  v1: https://lore.kernel.org/netdev/20260806011152.1170012-1-kuniyu@google.com/


Kuniyuki Iwashima (15):
  selftest: net: Deflake Periodic GC test in test_neigh.sh.
  neighbour: Remove __neigh_for_each_release().
  neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
  neighbour: Remove unnecessary EXPORT_SYMBOL().
  neighbour: Remove __rcu from neigh_tables[].
  neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
  neighbour: Remove neigh_tables[].
  ipv4: Replace &arp_tbl with arp_table(net).
  ipv6: Replace &nd_tbl with nd_table(net).
  neighbour: Clean up neigh_table_init() and neigh_table_clear().
  neighbour: Convert neigh_table.entries to refcount_t.
  neighbour: Namespacify neigh_tables.
  neighbour: Don't store net in struct pneigh_entry.
  neighbour: Remove unnecessary net_eq().
  selftest: net: Specify netns for ip ntable in test_neigh.sh.

 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  27 +-
 .../marvell/prestera/prestera_router.c        |  10 +-
 .../mellanox/mlx5/core/en/rep/neigh.c         |  29 +-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  23 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   6 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  31 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
 .../netronome/nfp/flower/tunnel_conf.c        |  14 +-
 drivers/net/ethernet/rocker/rocker_main.c     |   2 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |   2 +-
 drivers/net/ethernet/sfc/tc_counters.c        |   8 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c   |   4 +-
 drivers/net/vrf.c                             |   2 +-
 drivers/net/vxlan/vxlan_core.c                |  16 +-
 include/net/arp.h                             |  10 +-
 include/net/ndisc.h                           |  20 +-
 include/net/neighbour.h                       |  20 +-
 include/net/net_namespace.h                   |   4 +
 include/net/route.h                           |   7 +-
 net/bridge/br_arp_nd_proxy.c                  |   4 +-
 net/core/neighbour.c                          | 379 ++++++++----------
 net/ieee802154/6lowpan/tx.c                   |   3 +-
 net/ipv4/arp.c                                | 131 ++++--
 net/ipv4/devinet.c                            |  18 +-
 net/ipv4/fib_semantics.c                      |   7 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv6/addrconf.c                           |  17 +-
 net/ipv6/ip6_output.c                         |   4 +-
 net/ipv6/ndisc.c                              | 146 +++----
 net/ipv6/route.c                              |  18 +-
 tools/testing/selftests/net/test_neigh.sh     |  66 +--
 31 files changed, 571 insertions(+), 469 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

