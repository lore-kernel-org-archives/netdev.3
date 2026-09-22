Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692048987F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100681; cv=none; b=EFpTDL0GPzoYMFyAm3hS1mNGR0gEFM4frJyxYuXoQBKWf2B7dtdQe/cJw0JkB3Imr4rWru7bSaDv6xYxEtVIlKvbgfSTHbe8UcYVC0LW1TZAuZfUkgDOqx3QaAul2JVj4q6wNHIJy2CL0T1C4X8/vlcPnrNS1k04V9pivjeoQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100681; c=relaxed/simple;
	bh=ohr7Uk4ogSwkPcqbCew6LwgOzZ6EwtOTmSIjvwijWG8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CALA+Yk/EC3VQQXWodZqDZ9m6tO6c4eDfAyXTcz86ZSNsdLLtBK/qtjHOk8ACFL9pQJfahCSYhtXh+f+uKJdDklUnC2geMLGRZOpKLqi54mXM9hIn+hodbi44PBQWCK7YV0dP48V/KO2JoDKg5YXM5I6WJooTAnoUKO5xU//jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADMmYsYK; arc=none smtp.client-ip=209.85.217.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADMmYsYK"
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-79014f0b44cso62051137.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100679; x=1790705479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3d5CjwefpvrKqW5kqjzk2iY0N/xsmTuvBnZ4t2Sr5ec=;
        b=ADMmYsYKXMJS5fbB2VthxFbCwJ4JdpgXNH0/izKAkMabLgNGDr016b5u11SAb+Ga5+
         ZACbSkhzK5Ztx+w8ClD9qSkYdA/CG4YPDc0zYqcgwWTaH+hC6CPdUX94jDDF1SgruABX
         MRoNenFaLCN27LHBvNswTwEw/HXi6TzGsuTBzyc5rsXH0NZw/qLmTpf6C1b5W/r3WGKu
         h9NLE8QAWip7UFw44/f70d9N3wtiIsjDcbGoQ9aoSbX5LjgIiRf6RTIrwK45krAMcfLK
         0DgCbaKp1MPx5WaZCfZFSVUCoh3fXyyDr5GKzQIILa2LHuKSiH16PIeX7ZCtkGobB/PT
         G9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100679; x=1790705479;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3d5CjwefpvrKqW5kqjzk2iY0N/xsmTuvBnZ4t2Sr5ec=;
        b=iVno0vlNJK4gOH8o94EfH5ax8eo8rkIKfXGFLnT6u7yWTUW9JijVH4C3QCN8XZtRf9
         wQa0FIphCU3sDFYI+MMwN06rmdImTF7PV0nVYEvZ9XqBd/j+qO9hZLpBd9+tKfQpcgc6
         rzFA4rcCScX47EG1bHSmf5iLlM3v1HSV6WPFWJDokJfn14GRlZ0A2AI7W6NTrXtHyNdp
         PC7oozkYYSmOMKAL02Mfa7r3JB3UGhU5asWWHq8MhSozdm+Y7FFo50GNZjt3Az7SD6QJ
         relBRgAZaW5Rd8cgbYgslUWk64aTFmCTv5+ikY1FvH4VTaz2pihZN3i1XzV4i1ziRIgz
         0Ayw==
X-Forwarded-Encrypted: i=1; AKwUvByy4M/u/BIzOuMduqwrPPdHSoJR3bN+u5QfMU4hqlktMBcvmh322rUn8OOEgrhi8L5uH1FgwI4=@vger.kernel.org
X-Gm-Message-State: AFuF++mqdnow4zUjnPen+a1SSfYJV/oI55RVU+cbjzxHYXW9v/iu2kh3
	1reH2donhYRnCishKWOg/943yTXtIwa8zqI0jUb/KPxvgkaMYt9IFmJn8KoM7nToxOdQ3234Qbh
	wqnF1036jIS4LGg==
X-Received: from qvtp13.prod.google.com ([2002:ad4:446d:0:b0:910:62b0:bbf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3a13:b0:7a2:568f:815d with SMTP id ada2fe7eead31-7ac1d0cac90mr170527137.18.1790100664128;
 Tue, 22 Sep 2026 11:11:04 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:10:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922181102.3989489-1-edumazet@google.com>
Subject: [PATCH v6 net-next 0/8] vxlan: convert configuration to RCU and
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

Changes in v6:
- In vxlan_multicast_leave_vnigrp(), skip entries matching the device-default
  remote_ip and ignore -EADDRNOTAVAIL when multiple VNIs share a multicast
  group, matching vxlan_multicast_join_vnigrp() (patches 1, 7).
- In vxlan_changelink(), still attempt vxlan_multicast_join() after
  vxlan_config_apply() even if vxlan_multicast_leave() returned an error
  (patches 1, 6, 7).
- In vxlan_vni_update_group(), set oldrip to the previous effective remote IP
  when updating an existing VNI (!create) so replacing a VNI's group removes
  the previous default FDB rdst instead of accumulating duplicates
  (patches 1, 7).
- In vxlan_update_default_fdb_entry(), still delete the newly added rdst on
  rollback (extack == NULL) if re-adding the previous rdst fails (patch 1).
- Link to v5: https://lore.kernel.org/netdev/20260921100139.508191-1-edumazet@google.com/

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
 drivers/net/vxlan/vxlan_core.c                | 762 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  45 +-
 drivers/net/vxlan/vxlan_multicast.c           |  94 ++-
 drivers/net/vxlan/vxlan_private.h             |  34 +-
 drivers/net/vxlan/vxlan_vnifilter.c           | 206 +++--
 include/net/vxlan.h                           |  12 +-
 9 files changed, 798 insertions(+), 442 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

