Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111543F080
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608175; cv=none; b=AI4ceX38xz18E8fU1l1l+sBPFNBWNi75fpXSavorFljjYgtRUKMeo/+D//DlZMo9K0F7isB3ww9UuX+JG1fMPlHBqtvOs86rkxKYkgJ1b73j1N2QsAohV/3X6U0vCXEqH4VV84vpDFVCv2qIXkPzjBJAPa1qP8F+EUH7FLU37M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608175; c=relaxed/simple;
	bh=Tafght5oaGd1lkAZby4DOhowVgAJD3HHEFfQlbYrb6c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c/6NzxAD00M37j2ybHn0ScSsCmVtqx9UVK5yzGRnBcmUKC+r5eJKGuzy9b820i2reAjbtDiPacHDZwN2VazDpRAp6qTIZ/W+aFuwt+eCUpNqYcaFr88sH9QdK07D/cDiR9BJW+a0FYJGD3vRUaoun0maXDMNHrySb+Z7yRYXOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MC9C3f6Y; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MC9C3f6Y"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc88e22f92so11394095ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786608170; x=1787212970; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r+Mjvqzu+zsvkQNEaBAHoUvtulV3KmV6u/5SssRJXHk=;
        b=MC9C3f6Ygi/IF0uW/U+nl1p0P8TqRtXFd75iJ8S41iWAqqjQ6lJqV24uMAdnxbFzQK
         yb0ybTqqW8osahlxUnZk+NEG6Uut93iJDgSUWOu2SlkVRG8KabuwO7B/IT3nQDGci110
         LWA8kn7SIgV2TF3ralcMPMnYs59dI0LdkoYeieLTWnZPtv9bArTtBvo+BKtg5jTNpyGf
         ApUOydCssV3NY507ZjYp1OJmkIqb+mUha9coNBr/MVJraQyBhBiebQAHgftl3WKlAidc
         AKKc2VGyFbq3/YkLjvLLys1n4LjKWkpMj0gH8Xea+/ppVt+jh2aW9eF8jAMEo5B9TQhd
         chDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786608170; x=1787212970;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+Mjvqzu+zsvkQNEaBAHoUvtulV3KmV6u/5SssRJXHk=;
        b=oYFgtsO14Qv1tMZsUDU3vs8ERSC92HRFKwBnK4xDmVAfl3Tep9Q6ApGmtxnID97jmA
         DxMw/fEsEPrEHYnZotgQDQkx/yzK/3mvgdcWOlaBQQPzYPlaC1TW+iQ9KOvs6aEKjoSh
         R+Sr/gA+8Oi7Gy6PPLsQs5NjpegM3+EENUWUSkq6cLaX2hEFwlgCmI+Rkc+OpzWkWao2
         WFZ5IWpsnVB2JcgXZ7IDdfGTWk8gorPGYx4Gd7BvXBCGQINILVNySiWphdGgoYEci456
         D6heZ2DTj0uQ0v/uqbhAgLNCw/szWG7QAb+MTJtUDak8KHahyJCRuDcPt+9tk9/DmlhN
         aecg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/nmUnA/DXhrRWWLcjjB1w1FKLNh2xo+kCxC55wbI4k9ovB7Py6BjPlOTSwI0uq3zW9es2DsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyprZcjX3EFvuycJlsJFixeSNH7Wgxf8QqtPPs5OeFGnA4moib
	JuRvomAzWNOzhtabe1TzvTuxgAjpoDJjzAajoS7po+RZR3znrdCuw13Z1a7tYRJtRF+JDP/hlWn
	a5p/uZg==
X-Received: from pgbdo6.prod.google.com ([2002:a05:6a02:e86:b0:c79:5fb7:acae])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e8a:b0:3c4:1c9f:d7e
 with SMTP id adf61e73a8af0-3cc54f3e681mr6052604637.6.1786608170270; Thu, 13
 Aug 2026 01:02:50 -0700 (PDT)
Date: Thu, 13 Aug 2026 08:02:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813080248.407680-1-kuniyu@google.com>
Subject: [PATCH v4 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
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
  v4:
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
2.55.0.691.gc56d675ccc-goog

