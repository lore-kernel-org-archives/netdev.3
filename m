Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478F3AA9F3
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978716; cv=none; b=tIUp7erKUFIA9/yLdLgxsjv6m3hKJ0CMQNxtgMQHgYNEj6+G/zZnukd2nJ21ZNy8VbX9bMbYDHRTYhzLTmtw1rCQq+KdNcIL7GmvFaXCYXjb50JYZCApl6/pu8q/+AosSqtbsu4mtv9LzTskClR/KQCJkGxGlaanDdD1KpIvH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978716; c=relaxed/simple;
	bh=fh2aVZH0XFloieACynGxYahO9L5i6Ywj2QQ/YP6OJIc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GdItTwkTxNjuqXahJRRbC9r2EmeJA7d0HkW4Bx0HFR+//Wtc3DjCQncirPlr2LCAgL6ZJ1TWqOgRK5yjhBtGdgEe3yGDHc9QHfA8QVCxC+J6ZqNiUmZyvnrhGfK+r+NQtImgd6FwCSRpMeWHtKUbQWaWiScxXI9fUHnyepWEwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Or7Z6YDT; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Or7Z6YDT"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso2798345a12.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785978714; x=1786583514; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LTVPjfphXDhaRHaKV0RjaX7X6/y3DzQtxj+anMWWin8=;
        b=Or7Z6YDTU1eYT3DDX16GgiHVOEfYkcUwLlR+2dS9sl26yDOhMCr+1XXYDfCW4DeKhy
         WgK2+BJiAUMzqk1GzB3E1Tn4eK9rusT8ET+qK5dLXFDnFMMxtrK4tc5OpJLGna1qfgUe
         DAAzi28la3tCUKxXkiqWM+wXvVYzmNBTowVaonO/0C5HuC4KSSAtKNxOzUnWxh/LySY/
         oQud2SLsBSwGqPTh8bf3tLjN+RnzPwggKzjeTqMo3NuSX2o1/aVKmJix7bKehvHdG7Lm
         L8mQEQFio0N/bOERewB7p87CHow5i0WQCI43jlYuuZkzr70Pd/cVZrPObszuv/szeXbk
         g/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785978714; x=1786583514;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTVPjfphXDhaRHaKV0RjaX7X6/y3DzQtxj+anMWWin8=;
        b=MHSXQ1peJ0FWoQrIj5fK1eU2ZOSVDTkv/7sdJju2mTZdhMdDOJa8DXOaUw8UqN+k+5
         +NLnNVXKdruD1cxTsI5Fm4pMNzfEacVG+/MFetqDzZZ7orHk7VSlK/3C68TUBxT9KD8C
         oCDpyvObtt+C//QsG2eKhxtZIywNniCuV9Ys5923AEpIMI3Sh6GvwVuLH9yASh6kqsFt
         KwBm51UgEMtkHXA35kFhZnKEd+aAyBMnJ5BGGYEcjjZnO/kK6c9PWpmjd6QWMsj2uRlK
         1sj3sPoFDuuPH2BD7uhbx0Pm+zAHychM1ujE31NU+hac7w1aXnFdqrzlDgXud1Kheuoe
         nGJg==
X-Forwarded-Encrypted: i=1; AHgh+RoW1Vnpv3ExukuGM4Zut7Wc9BN4eD0rEBTivrr4rItKh0wWVMlnWTN6jG7z4A4Woddu84MlrrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzztc9lXHt3u3b7hN0q0L3MTHiHro0msD82UEdB8Ls6v54gGZal
	n7WFylWWEU4CWJwiRnNZQLxn3025eyv1vXz7XKfCTpjH9MA88B+1vdHHBG3PybXUkPo9kFpMO05
	fCJTKnA==
X-Received: from pgbfm2.prod.google.com ([2002:a05:6a02:4982:b0:c79:1600:6a09])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ac44:b0:3c3:8440:f6da
 with SMTP id adf61e73a8af0-3cb85ea6fa5mr13301602637.29.1785978714318; Wed, 05
 Aug 2026 18:11:54 -0700 (PDT)
Date: Thu,  6 Aug 2026 01:11:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806011152.1170012-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/11] neighbour: Namespacify arp_tbl and nd_tbl.
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

Patch 7 ~ 8 replaces the direct access to arp_tbl/nd_tbl to
net->neigh_tables[] using new helpers.

Patch 9 ~ 10 finally replaces the global table with per-netns
table.

Patch 11 cleans up unnecessary net_eq().

Note that some buggy drivers access nd_tbl without checking
disable_ipv6_mod, so nd_tbl's extern definition is still left.


Kuniyuki Iwashima (11):
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
  neighbour: Remove unnecessary net_eq().

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
 include/net/neighbour.h                       |   6 +-
 include/net/net_namespace.h                   |   4 +
 include/net/route.h                           |   7 +-
 net/bridge/br_arp_nd_proxy.c                  |   4 +-
 net/core/neighbour.c                          | 318 ++++++++----------
 net/ieee802154/6lowpan/tx.c                   |   3 +-
 net/ipv4/arp.c                                | 131 +++++---
 net/ipv4/devinet.c                            |  18 +-
 net/ipv4/fib_semantics.c                      |   7 +-
 net/ipv4/route.c                              |   2 +-
 net/ipv6/addrconf.c                           |  17 +-
 net/ipv6/ip6_output.c                         |   4 +-
 net/ipv6/ndisc.c                              | 146 ++++----
 net/ipv6/route.c                              |  18 +-
 30 files changed, 484 insertions(+), 415 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

