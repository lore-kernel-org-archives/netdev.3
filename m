Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE616490BEC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287612; cv=none; b=hab47gXXMhUsMUO5S+iPyCeVe1Y3PSa4mXUDSt06MDr/t+pdkSAoN9DqL6lyJwiG4NRUF0K7n247gJhcAu2QOprXblED0syeV9Bbv5DD6ylcs7JcBoIpdsduoB5b56DO8b+ob6cyFJqnxlgQkjA5pg28dqmPEWshVpP0JhxcTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287612; c=relaxed/simple;
	bh=LiCPXvy+0wNc1Uzb+D3zokphDhjp+kCglRifHPWIrhY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PIbOxgc9t94iPEOK0yrX6QFAb4W6z8rPjkeaQsm3YGC+lDreE5nMc5yURUowSJUEu9dUE0njXBziHHL8+sJVth0zvp1Pi77to2nVRoo7F2BNV8FcE9K8L/mMoLPG5/zrBrp9dDiOWHcTv2akBN9rxfB5IOn+k6TkXYDPsS2Gw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIdjPYzP; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIdjPYzP"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d959904658so1802765ad.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788287610; x=1788892410; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jSVyExx0l2dbFLhALxZhS9EhDwaSWiPU4MxJnKDT5WE=;
        b=JIdjPYzPwadWdEO/HWF8GIaWRSVyK5LZRlCM8OhPf7jblLzUOg/Tx4sAksag/CczSE
         cWQ8BQG0w/M2gguXzmJW7jCarh5097asJFFbJB4n7rQMMUJ0ra0ZMvNgq7aZqOSyPPqS
         s8j31OVRpAFxdI9GvQnb7AHdDqaJG7lDdfS+ogUc55UnhyzjARAkEGDY6b6bFdwCPb3n
         Sy68g79oOsxg5QYbcbqzd8KdlMsmcJAj9zYnq1nupGwn9KTfDimbtKddJ0zjHD3IPrwE
         R2ujPZxajJk1hxtzdidXGy+a1DUTrDYvtOFNoMrprXD2v1LgpALiR0/YFIZSgcwm0J2q
         0FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788287610; x=1788892410;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSVyExx0l2dbFLhALxZhS9EhDwaSWiPU4MxJnKDT5WE=;
        b=aCI+eXbuUDCdBLxUKwK3YJLYEXM0VzLfg+i93vOh2nap6XrKx+TSy5pPixTziGvWUp
         5UMARY98jmtziY/+G+S1sXE5qvKXcxYHJyRZRtawQ3tPfRDd0gMu9wfNeDamFAXTe2cl
         OzaqHVrz19OFiYwOlsZIZEDjnGCJ9avedxSzzAk4k4a5GSDq8mRiZW9h3q63Uw9iX7fa
         VqVP+Jgv/7axyQMTMkyvqu/WoaJlz/jEItyqdsaOcbcvEjkbIe8pjmjst0+6W/jEU3AD
         LtJeaPonlXKVQWS51qg7kztnrJVCTlVqwfECemUk7KarSg5GNhkTSvGxVusisLk7SVsL
         TIfw==
X-Forwarded-Encrypted: i=1; AKwUvBweovxO+5OkxCPH+caOdeBvq0ZA/opvooH8sf+8qSkM9PgyhW9aiClzhdIX7lSeDDdKLoQU/+I=@vger.kernel.org
X-Gm-Message-State: AFuF++kiLQ7gV+3TPYkNwDeIEGMWsaOxJLQvDZFJJ3eq2Wj9BrIkvS42
	4eg5Nxh7mP4qfeIv7by4OvmIn9aNyOG7LYveT9/PELWLNXpGcaSgkNyrHN6RBXfI/xDl8eW7AJN
	JoXxGsw==
X-Received: from plbmc11.prod.google.com ([2002:a17:903:2b0b:b0:2ce:7984:4347])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3883:b0:2d3:716e:e2ae
 with SMTP id d9443c01a7336-2d94a73dd34mr145706995ad.6.1788287609852; Tue, 01
 Sep 2026 11:33:29 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:32:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901183327.3332855-1-kuniyu@google.com>
Subject: [PATCH v5 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
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

With the series, /proc/sys/net/ipv{4,6}/neigh/default/ can
be configured per netns, which was only configurable in
init_net.

To avoid potential regression, all the settings are inherited
from init_net by default, and this behaviour is controlled by
a new sysctl knob, net.core.neigh_inherit_init_net:

  # sysctl net.core.neigh_inherit_init_net
  net.core.neigh_inherit_init_net = 1
  # sysctl net.ipv4.neigh.default.gc_thresh1
  net.ipv4.neigh.default.gc_thresh1 = 128
  # sysctl net.ipv4.neigh.default.gc_thresh1=129
  net.ipv4.neigh.default.gc_thresh1 = 129
  # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
  net.ipv4.neigh.default.gc_thresh1 = 129

If it is turned off, all settings are reset in the new netns:

  # sysctl net.core.neigh_inherit_init_net=0
  net.core.neigh_inherit_init_net = 0
  # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
  net.ipv4.neigh.default.gc_thresh1 = 128

Series overview:

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
  v5:
    * Rebased on the latest net-next

  v4: https://lore.kernel.org/netdev/20260813080248.407680-1-kuniyu@google.com/
    * Patch 12
      * Add sysctl knob, net.core.neigh_inherit_init_net
      * Inherit all neigh parms by default

  v3: https://lore.kernel.org/netdev/20260811022448.116235-1-kuniyu@google.com/
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

 Documentation/admin-guide/sysctl/net.rst      |  14 +
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
 include/net/neighbour.h                       |  22 +-
 include/net/net_namespace.h                   |   4 +
 include/net/route.h                           |   7 +-
 net/bridge/br_arp_nd_proxy.c                  |   4 +-
 net/core/neighbour.c                          | 400 +++++++++---------
 net/core/sysctl_net_core.c                    |  12 +
 net/ieee802154/6lowpan/tx.c                   |   3 +-
 net/ipv4/arp.c                                | 131 ++++--
 net/ipv4/devinet.c                            |  18 +-
 net/ipv4/fib_semantics.c                      |   7 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv6/addrconf.c                           |  17 +-
 net/ipv6/ip6_output.c                         |   4 +-
 net/ipv6/ndisc.c                              | 146 ++++---
 net/ipv6/route.c                              |  18 +-
 tools/testing/selftests/net/test_neigh.sh     |  66 +--
 33 files changed, 620 insertions(+), 469 deletions(-)

-- 
2.55.0.966.g6673acef38-goog

