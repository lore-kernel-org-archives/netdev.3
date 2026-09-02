Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4147A899
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381464; cv=none; b=EfIeJB2KBPDqDvcPUQFjP/GqBOTwv0yUTzk2H6JQwBrWCK9zNdKAvb6MrlpnWaDhinx3c746nPMb4Pn6sxzdItS0gXk/EZyxkV4GzM3XYwl+DvChfQT+I16013d4TY76jHk/Yf+7vmW43sU2GXxzT7BoyYTdxTh7jkOmqt798AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381464; c=relaxed/simple;
	bh=2edZcXKNp4ztGJxOQFGQBpPF8dJfKCaOvf6gk1cWo2A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pzf5jVDm1RWKISWL+HZsEfMfOfdhZbRYWro/j5w6+xpgQVBRuqDU0cqBZlrcANjRsou5yPDMytMq5PMqWScMSVZBOKix29VvCrmQOF0IQkXfp+USGT5fzpHeqklthhh5ISnqAjKfDBhjV19NyefJGoPBzQQkAydu8bz1ZI8WMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTTqGqGX; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTTqGqGX"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e375d9736so1353154b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381462; x=1788986262; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i73ZU8dNn3/xPt/JoIsrzZEp0mXdlhe6VUhoY6nKhmg=;
        b=JTTqGqGX14yAi1PrhQl5P76C7BIR2dWdZgcO+VdL9QeBbJQV57zFOPSFqABxkY4zpl
         kPigiJSUn3aj7hdJ32jgWpl7/f6VVv0lpZL2JD7GtMrRm4g7ITRyyLuiJwqtniWgmeLH
         EoRxkZJus/ie/btzvZc764qcwGvFREkA4QEpJuna90MHLngGuzMgGkGhjvNS8I6In+LQ
         bXacE8WBXdv+g/pcHmVTtRe8IzG3MG+8m2CXyhLsunp24Q5+IZTQ1jF0qUuYH2bxMQSf
         uHfg5Pfz56AGCwS/V2Iu0PoSMXskiRaELLEKt4gWHMQW798kcZa1Sjo9y4FvmeMk58aT
         dH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381462; x=1788986262;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i73ZU8dNn3/xPt/JoIsrzZEp0mXdlhe6VUhoY6nKhmg=;
        b=WnOiwAa185iRzADstJ1AJIjTKeHET266sDcOb6EpHdVBBq3uutumxhBXOrQSOPkJNs
         FbQFUx3glRp94qD0fjSMNW1unF1RkibaWIOwo+Ce6/qzxA1SO3UVoYKVLBXTwUvw+RdL
         H1x3822HV5hlJodBlsv5vdGDIbsEZ2CW/zQKUnUqn0YUlKVfDvzIQDFp1XvVTBVnCQ9q
         FGo71GRYqr63v+qNyck8GetXDsG5Fw3CYBIFU1yvxtMn+4LtSMHyOAFWNrehe/AbJMiM
         j3PCVdaDORDhPpuQMGHryWh3TgYev14dL0bhmHG75JMMbf9PzwTKykXnlGliaxStpYgt
         8G0w==
X-Forwarded-Encrypted: i=1; AKwUvBwnL+MSLJjXHyCkKMcFOHpbfpuSd0B9ESJMgySUsy5JeBKl+jgNfzjfz2/KAUubSc3iS2VGIoQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kMJl8fe3pusuX2v15E2EfM73nJ4QDyDmmcGKqW70vgboCVXRgG
	dKU21CRifk5c0h0X5lUBooIJcxNG/Wi/Vg5KJFe+frBbs73e5ZeFicf5FyVqoNlVQxlHRyeNtGP
	k3yWhRg==
X-Received: from pgvc27.prod.google.com ([2002:a65:619b:0:b0:cc4:33e1:5b76])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b18:b0:3d3:adbf:7780
 with SMTP id adf61e73a8af0-3d9afb00c9emr12665789637.21.1788381461892; Wed, 02
 Sep 2026 13:37:41 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:36:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902203722.926528-1-kuniyu@google.com>
Subject: [PATCH v6 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
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

After this series, I will follow up on two suggestions by Ido:
https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/


Changes:
  v6:
    * Patch 12
      * Define sysctl_neigh_inherit_init_net in neighbour.c
        for CONFIG_SYSCTL=n

  v5: https://lore.kernel.org/netdev/20260901183327.3332855-1-kuniyu@google.com/
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
 net/core/neighbour.c                          | 402 +++++++++---------
 net/core/sysctl_net_core.c                    |  10 +
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
2.55.0.970.g62bdec98f9-goog

