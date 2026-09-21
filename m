Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE23E0094
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984904; cv=none; b=IJRnAnQq7pC3bYg7J/F0Lt3mu5eDAIg5bDaBqeCTtztaVwzGiK4Y9xbBoo7IsQIPGAqWNd+b/3q7m/WAfk/O8+ysGVyJogc/wRRIfXNPczo0pA3PEeLVsPvntlj6r15DxzSOlq47Z7HdBwzV0k/TIb2nuG3hiRVYJdG3b5rdJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984904; c=relaxed/simple;
	bh=OxbXoFXO+6mkmmt6BMgVaLpxtZP/c6BysPo2SOEqJhw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CSDy2f8MyTlz34PpKg4oLV5eGAAOA3Xq6xQO+43dZtTN4S4PF8wKD1KRUDaShY6bby3iUEw25iGGlyurzh+s7icbYPoTUn059G8X3bM/sA+i2Ub1ITK6nDOgUdp6GjGN5/4yPuQlC4E7YZMBI+JYAUq1USRd8sLjlozueW0GVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozwvKV4u; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozwvKV4u"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so445157285a.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984901; x=1790589701; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LtS1k+g5KNY8TGsRsTa9daN4qnWRmvThzKdIL8PTBVc=;
        b=ozwvKV4uEbMt71R+efxZ/01C2Fik74AtOpAc/MyTsUdfKcXJRWhyStOGNGMhMjfsPI
         l1YWLwGlOYMvF01jhlnlnITya6W1XmksS12FZgA0IjlLBYe/DsN7PxxYEi3oj18uvISp
         5fYurKOQKsK1IxfZbyYHYtHTAKbdiGJCireIfe1WPBZsMGeOu7MZPoMFjqFj+pot4C75
         EMndRyWyCgHTwLdhZ3eQbgitAPzUdjf1aFu3QsIpkrJhO8q6pdPq4aRVqOufJunw2kTZ
         kxuVcJeJ0GCw8wrv+3o7kCWL6D2lmhdy7JFJHv7k1tPSv7a6MHS73dlLgkh3XeplTPs0
         +bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984901; x=1790589701;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtS1k+g5KNY8TGsRsTa9daN4qnWRmvThzKdIL8PTBVc=;
        b=j/Kk0fXwhL5zyZC6f2yFTkNDMmUoKKXrVfNCnoJbKQP0LLmEJvwIbToYkDIT12U4cw
         vRxiUyQ4yBGDg+jFXngJRjilLWnd0Jf0vpRUKPfkIgddJXLGjK0Qqi5CgVYcM0/Ofalt
         e18uCTua9cuCuxLAsxWQnt1dViIWhYXKoTd785+IPUXew04Xq8h62KXmEIzN2o8Lts9S
         IdHNaHoYMBrZ6Lbwq1baFP0PCQDYvURyyZqrD7es8RmJ2olLihhF9M/CpYTPbZYo8w8F
         ivilZLtqhH8kmpi4QbrDxETKNQr15nEoPXE6SdTeQSoYDRbhgxrvoPco4TktXWP0xU13
         QItA==
X-Forwarded-Encrypted: i=1; AKwUvBxm191XZ8Yb4tkQqkxAUf+z6L3sx8lzkBbPyXymS4R5qa21EIpjaCgcqz84MaKAlBX+LJGQTgM=@vger.kernel.org
X-Gm-Message-State: AFuF++mNVM0WNXneaLjn6osV3ktg2Gaf08A+qnRpy69rioHV9wmw1g0o
	tCWRrLtCfO5dN/ybOMADurTmJcHZj1ROeVQ/wGhY5HR2Rpx+rupOlyru8gdv9vqLt7bQ/nIRkjA
	LfPmyVknnrAScag==
X-Received: from qknqj4.prod.google.com ([2002:a05:620a:8804:b0:93a:378b:d100])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6016:b0:93b:eed8:3a52 with SMTP id af79cd13be357-93bf5519fb4mr1030273185a.3.1789984900950;
 Mon, 21 Sep 2026 03:01:40 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-1-edumazet@google.com>
Subject: [PATCH v5 net-next 0/8] vxlan: convert configuration to RCU and
 enable lockless dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series converts struct vxlan_config to RCU protection, eliminates
redundant destination fields, and enables lockless RTNL-free link dumping
in vxlan_fill_info().

Changes in v5:
- Widen vxlan_multicast_leave() and vxlan_multicast_join() conditions in
  vxlan_changelink() to also run when VXLAN_F_VNIFILTER is set, so per-VNI
  multicast memberships are migrated across lower-device changes even when
  the device-default remote_ip is 0.0.0.0 (patches 1, 6, 7).
- Unwind already-updated per-VNI entries and the device-wide default FDB
  entry if vxlan_vnilist_update_group() fails partway through in
  vxlan_changelink() (patches 1, 7).
- Bump the vnifilter dump generation counter inside vxlan_vni_update_group()
  as soon as vninode->remote_ip is overwritten, so concurrent dumps still
  observe NLM_F_DUMP_INTR if a subsequent IGMP leave/join fails (patch 3).
- In vxlan_config_validate(), reject clearing IFLA_VXLAN_LINK when
  VXLAN_F_VNIFILTER has per-VNI multicast groups configured (patch 7).
- In vxlan_config_apply(), reset dev->needed_tailroom when detaching a
  lower device and use READ_ONCE()/WRITE_ONCE() for dev->mtu (patch 7).
- Link to v4: https://lore.kernel.org/netdev/20260915175501.391567-1-edumazet@google.com/

Changes in v4:
- Split out the default FDB update fix when the lower device changes into
  patch 1 with a Fixes: tag, and updated vxlan_vnilist_update_group() to
  refresh all VNIs (including those with explicit per-VNI multicast groups)
  so their FDB entries do not retain a stale remote_ifindex. Kept in this
  series rather than routing through net to avoid a cross-tree conflict
  with the default_dst removal in patch 7.
- Added patch 3 to signal interrupted RTM_GETTUNNEL dumps to user space via
  a per-netns atomic generation counter and nl_dump_check_consistent(), per
  Paolo's suggestion.
- Added an explicit VXLAN_DEV_F_MDB check in mlxsw_sp_nve_vxlan_can_offload()
  so moving VXLAN_F_MDB out of cfg->flags does not silently relax mlxsw's
  deny-by-default flag validation (patch 5).
- In vxlan_config_apply(), gated the MTU clamp on lowerdev_changed so that
  unrelated changelink operations do not shrink dev->mtu (patch 7).
- Documented in patch 7's changelog that cfg->remote_ifindex is now committed
  unconditionally and that IFLA_VXLAN_LINK=0 tears down the upper/lower
  adjacency.
- Link to v3: https://lore.kernel.org/netdev/20260911033945.164207-1-edumazet@google.com/

Changes in v3:
- Folded configuration conversion patches into a single patch to maintain
  clean bisectability and avoid intermediate mutable state.
- In vxlan_changelink(), pass lowerdev to vxlan_config_apply() to prevent
  truncating dev->needed_headroom and dev->needed_tailroom when lowerdev
  does not change.
- Cleaned up redundant NULL checks and unreachable error paths.

Eric Dumazet (8):
  vxlan: update default fdb entries when the lower device changes
  vxlan: vnifilter: use list_for_each_entry_rcu() in
    vxlan_vnifilter_dump_dev()
  vxlan: vnifilter: signal interrupted RTM_GETTUNNEL dumps
  vxlan: pass vxlan_config pointer to helper functions
  vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
  vxlan: convert configuration to RCU protection
  vxlan: remove default_dst and use vxlan_config and lowerdev
  vxlan: no longer rely on RTNL in vxlan_fill_info()

 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  11 +-
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  19 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  57 +-
 drivers/net/vxlan/vxlan_core.c                | 754 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  45 +-
 drivers/net/vxlan/vxlan_multicast.c           |  76 +-
 drivers/net/vxlan/vxlan_private.h             |  34 +-
 drivers/net/vxlan/vxlan_vnifilter.c           | 191 +++--
 include/net/vxlan.h                           |  12 +-
 9 files changed, 769 insertions(+), 430 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

