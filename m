Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D54BFE77
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798613; cv=none; b=ggJvQwjy51p0j1jaSGc7h6abuQnQ9FMREyQWWy9/k326MgHzo6yrqBGNLLGuaf5V9vc9UgEFiRzkZawpeSJHpUlswWSoVWj2DSumxU94Uv8ZklNLJjnFq0y5Z5idGI3nNJdcgwErZBb4VdK/OQeFttquQ9OtgijZ/TrtPbJPJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798613; c=relaxed/simple;
	bh=ws2QZCO+F1jL1ix1FBrj1My5B4H/ftlrXiXFKSwLd/E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZB1yLszuizwc5G+JmhqLUy3e91Ynfb0j3YAvvrmUFarbYkaY1p0nzIPO2zJ/pK11J3OhX9OICZYjaY9u7GYlqDCQFYHTlX3qchW7veJwGJakiMtE2YiFQXk4ZHWYUnLkRWeqmV1MLUU7XzqC0wWWtrrfxoAHL9j41EbrOSdngnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgp42eM2; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgp42eM2"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so761435a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798610; x=1791403410; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AlJVTi6qDmkn3aGlUKreia8JAM9HUM5qu17Xe9L0TuM=;
        b=lgp42eM2PaWr5XhZMfPjEprvimKs9DLvhrIdT0T8gOm+Fu0naqqPVxiq5CxoPKpji+
         RStS7ALC86c7MCGUklYtgs6pIWS5q/vyjcnFAXDheID6lh4/oxQHTHkwynKj6Yy147IV
         A51TBQH8F9e5QCRi5V4HtCwiMjhlLiJ6JhcnHVxpqvtjhvKkkEImpCklN3YAV5XlYpup
         oOleG7REIkLGvDlKoY9TuqGfNTwACgNfRZqSDhE4HR+aGlAZMObkoDFhCx6x9ekrO4pR
         mkbQOlYu+5kxkpMLy5glY8SASCd8tVbrmnvs3keKNR/328v0Dq3cFgizaKcMY0zXVYoA
         QDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798610; x=1791403410;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlJVTi6qDmkn3aGlUKreia8JAM9HUM5qu17Xe9L0TuM=;
        b=fVxg2GzALVxaZgA7HWB0F/vjoAx4t3V4061UdpJMkohw4fOb5HH3pqC3ZMHQANtyNK
         vJPbKOFBD1zvQk3MO9KaxujcjLoFwuR7ubog+aTqEsqeLzU1qvtAuLuuW8t0Bv2x1mN7
         CRmQIIEORbBRHcrJQe5FzQsQx/ck/YnrSvsQqeKTLdgUmfpajlHysMKYZ/3N5L4PnPC8
         f2tFc/ibZFjrW/KlRzDjh1ijGtvA8HBeTHlzFHhhSesl2hpDIm2NMk0j+rFpEs05Lq1R
         ACFeXT8qq9oDeRton24NO5SrD4g2xeDVDmGhpPWqTNjVrNy/xszwiLF8tjGQTVwcMHj0
         qcBg==
X-Forwarded-Encrypted: i=1; AKwUvBwMpltQmYg6vmBj9hV+tGiykazj7h55oPvWiXBuBzKVQ18/d4ST6TXZQbFO6Btqs1Zkrbilo1I=@vger.kernel.org
X-Gm-Message-State: AFuF++nzWQ17Lt2Da2xP/DFsvVLX0InGbi627ZYzRIzYQOiIzM2qaZdW
	qFFYmOcPSEztY5u1vPpWMXg0SEIqoT9xF+tzTHeDqESh0/cKt5WXsgU0lrnDMV4sv6Q0Rkw8jjF
	GIY7aXg==
X-Received: from pgcv12.prod.google.com ([2002:a05:6a02:530c:b0:cc4:329b:591a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394a:b0:3de:6338:cfcd
 with SMTP id adf61e73a8af0-3de9eb40b46mr2123573637.57.1790798609708; Wed, 30
 Sep 2026 13:03:29 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930200326.718459-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/8] neighbour: Add IPv4/IPv6-specific wrappers
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


Kuniyuki Iwashima (8):
  ipv4: Rename ipv4_neigh_lookup() to ipv4_dst_neigh_lookup().
  ipv6: Rename ip6_neigh_lookup() to __ip6_dst_neigh_lookup().
  ipv4: Add wrappers for neigh_lookup() and neigh_create().
  ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
  mlxsw: spectrum: Resolve neigh_table right before neigh_lookup().
  ipv6: Use ipv6_neigh_lookup() and friends.
  ipv4: Use ipv4_neigh_lookup() and friends.
  neighbour: Remove __neigh_lookup() and __neigh_lookup_errno().

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
 net/core/neighbour.c                          |  9 ++-
 net/ieee802154/6lowpan/tx.c                   |  3 +-
 net/ipv4/arp.c                                | 26 ++++---
 net/ipv4/fib_semantics.c                      |  5 +-
 net/ipv4/route.c                              | 18 ++---
 net/ipv6/ip6_output.c                         |  2 +-
 net/ipv6/ndisc.c                              | 48 +++++++-----
 net/ipv6/route.c                              | 23 +++---
 net/sched/sch_teql.c                          |  4 +-
 24 files changed, 222 insertions(+), 189 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

