Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE73F4854
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145376; cv=none; b=mk/ugds9o2XtzH5C3MxTsDHnyZDunvimDd2NakakEaSPTdMqR1R+IVWZhXRoppmmUy/HRrFLOLDk6tzMro2At8jWVv+G01wGrM7KtHZHYp2icKhcBygLl4J6xFPrWgp91yhKrvJpVKVwolJRdTr4UZvTx5+wYgMlTg5hP7ixv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145376; c=relaxed/simple;
	bh=6gawzkc7Vrw0wUrDc8eZ3z5zpYkGK5YvFnVmHqtfnFo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cVdgYgDi1NiZf8KbgtIA6IJp3OKVXe7u2L3iYNAynktlsF5/LbLVA9dwFeg6BAfNZ/Sgyp1ywxsOkBYP6po/j3sxBmab5RrnbOn/TatDKd/vWmMGC0L1v4R5MuhFm0JDfEO5tEX0Pg3z5StbnruOD7AxoweZpKFcv1jPdrOhD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jgt68oJS; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jgt68oJS"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848d21bbb55so132519b3a.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786145374; x=1786750174; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ixfTwcnbpg8mQmqRKTzllTLX1dR+S7HpNIRrzN3lVAI=;
        b=Jgt68oJSf4plvWkBfgzS1hXONG8rak8WCZyG7FkOPToih1NVu+ew6N2dE0e3/QWm6E
         28p69/u9Dfra9UmHiizJ02onuCKKmy+PnDbAL/SiidOHoDgJsWXBiEpk2VUjLx2ob0vg
         VEoo3XvicODtqtTlxZeHUM/PpmWJJLEPnEH5XrwaHj721fj4x/ixOfB4yxyIJ7+lAonl
         AIqqj/Jekn+M2gB3+J2sLkejyMGTcDS+uBS21pTl61RlBK2faw1y9GhH7hxvN90jC3gx
         +chxiG9N2hp0/zsx9WJ1rONG16XAUrIFprQgWejlIshypIfWjHHmZ/zXCAfh12eY+X7Z
         reMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786145374; x=1786750174;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixfTwcnbpg8mQmqRKTzllTLX1dR+S7HpNIRrzN3lVAI=;
        b=FW4IZNeUHGB10dgalf+p1zFGL89cCQ5wnHivSSSOfv/VRZhrzROIldMNJ9IpP3LgrF
         8874VIo15Bj8wmwG3B82h89rqBzIXeUZokr/ktJOSuzyxaAo2jc6PDs9w7prIfULeWKx
         1mednNjEZlI06FuAfNJWyiu8TjLIDIjefnQ5nTX0ibuzz+q+QNM7SI9xuCzetKpTbmov
         GttOMfCNm9bUSVrvz3Q5U/rnjjs3/aiKiehQxJCHcnJNY3df0/zMDA887nrjIEDxl/hv
         K57Y3Vx40lfyUsKdHf2hpLHxK3p97I6YbkURLwVEuzwUn8VbhK71ASs4i0/Pqpci7JDy
         op2g==
X-Forwarded-Encrypted: i=1; AHgh+RrL4fVX2pN6ySa94n2zXD00b/e/GsBQDiBrPgbhqRsYbGZ2MtskF3XI23CzPZrRqiYT0rQ0uIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzulNqiHwkKMaDVAICTIzxdqiqEQKV75AciePapGLHU1suM8LTj
	9QLJrvNBbmQp1iF11AqVF9QhGpQIe5vLKKrQG2UFKocNI7UuyWWYz2r/uM3vXtvuODm1VK1fhHN
	vIQc8Xw==
X-Received: from pfaw13.prod.google.com ([2002:a05:6a00:ab8d:b0:848:4460:aed3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c1ca:10b0:84e:915:d7eb
 with SMTP id d2e1a72fcca58-84f2e0dbfb7mr24288993b3a.37.1786145374003; Fri, 07
 Aug 2026 16:29:34 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:28:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807232932.3986667-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/13] neighbour: Namespacify arp_tbl and nd_tbl.
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

Patch 1 ~ 2 are misc cleanup.

Patch 3 ~ 6 store arp_tbl/nd_tbl to net->neigh_tables[] and
remove the global neigh_tables[].

Patch 7 ~ 8 replace the direct access to arp_tbl/nd_tbl to
net->neigh_tables[] using new helpers.

Patch 9 ~ 10 finally replace the global table with per-netns
table.

Patch 11 ~ 12 clean up unnecessary net_eq().

Patch 13 updates test_neigh.sh.

Note that some buggy drivers access nd_tbl without checking
disable_ipv6_mod, so nd_tbl's extern definition is still left.


Changes:
  v2:
    * Add Patch 11 & 13
    * Patch 7
      * Add note about mlx5e_tc_update_neigh_used_value()
    * Patch 9
      * Add __maybe_unused to net in neigh_table_clear()
        (next patch removes it)
    * Patch 10
      * panic() when register_pernet_subsys(&arp_net_ops) fails
      * Add timer_shutdown_sync() in neigh_flush_one()
    * Patch 11
      * Split from the next patch
      * Remove net comparison in pneigh_dump_table()
      * Remove net arg of pneigh_create(), pneigh_delete(), and
        pneigh_lookup()

  v1: https://lore.kernel.org/netdev/20260806011152.1170012-1-kuniyu@google.com/


Kuniyuki Iwashima (13):
  neighbour: Remove __neigh_for_each_release().
  neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
  neighbour: Remove unnecessary EXPORT_SYMBOL().
  neighbour: Remove __rcu from neigh_tables[].
  neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
  neighbour: Remove neigh_tables[].
  ipv4: Replace &arp_tbl with arp_table(net).
  ipv6: Replace &nd_tbl with nd_table(net).
  neighbour: Clean up neigh_table_init() and neigh_table_clear().
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
 include/net/neighbour.h                       |  18 +-
 include/net/net_namespace.h                   |   4 +
 include/net/route.h                           |   7 +-
 net/bridge/br_arp_nd_proxy.c                  |   4 +-
 net/core/neighbour.c                          | 344 ++++++++----------
 net/ieee802154/6lowpan/tx.c                   |   3 +-
 net/ipv4/arp.c                                | 131 ++++---
 net/ipv4/devinet.c                            |  18 +-
 net/ipv4/fib_semantics.c                      |   7 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv6/addrconf.c                           |  17 +-
 net/ipv6/ip6_output.c                         |   4 +-
 net/ipv6/ndisc.c                              | 146 ++++----
 net/ipv6/route.c                              |  18 +-
 tools/testing/selftests/net/test_neigh.sh     |  26 +-
 31 files changed, 514 insertions(+), 449 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

