Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E239A4D6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437326; cv=none; b=S4r/v8ZD2AYiBpVR26VKr1oSAt8+XHN+x/cFMRjXQdGqr/PMLL6v1O3cItGym3OcRm9eLzjPuhbwzMIw36M4qckZfQzr2ZXrpquLMbJ2hw1MoIRz4NjtcpO6fXZihE6ranukRL99n4LZuMwEyFp+CkjPcKXAfBclAafaTh+kDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437326; c=relaxed/simple;
	bh=L/AqYu8KhV17ND0co2hXeBMdMuE5MdYXaRVbqMXkhSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IHYPYOTaqxZSdyl7i2yY/qx24vEq/9sY7+lcLLHTxJNX74ym9P84IkBWiCFF7R7/+cah8opWlzYCho3SKv2TwkCf6xVORjcUblxZ4viCQ4+RiT3kJ7hcDWm9yhrb1jmhMJlUBiuwSxxFZGZv0PmWsOEDQA0QzT0m0ZrimHmv0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQMnZNT5; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQMnZNT5"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e820609d9so465177485a.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437322; x=1789042122; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXPXLNVBYZFwoGtkAVPfOJj19NVo9B3g1bUGdgnGzVg=;
        b=QQMnZNT5N2ru8VufoMYXzze8jXyxrQP5jEru6tPbFytYaLrXrE022Ub2HyQXaLRW4P
         TTsE1lbiMiGP3Alr3erHEuKmet6TLcFgSkrdAEftwIwyOF+81DigMjJyjy4Kor6+S79W
         9ySu98zpeXbmVbIUj6RvpFPC89t/OfFXEYQxw6SzOZfZzQ8s7/fF/VHSXMK2CsGCb0vP
         n1aoe4dUhFhHSCX0D0NgrO13ZONlgOdfIXexvs/0qkZBj61wuhQpqftyRLqENLhGitBT
         EFFHqM6Lo6JKIkVY4vdV/q4VTD/gSwchciAFCgCThPR6G2oaxetfDrIIQgAUpAz3wCP2
         xBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437322; x=1789042122;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXPXLNVBYZFwoGtkAVPfOJj19NVo9B3g1bUGdgnGzVg=;
        b=dJOKXm+VVUJD33FOpFRerojuZJffHZwNjMfJ411UUdU1XKHh7hHsncRjHB3eR/ZmJu
         HHb1T9u1dR/gGnx3LiaQK77nGK+Q1BTCFGv8RkEMPBdaDDFcBfiaQzMAv+3hZ5vHlXz/
         3mhELvzr0UKoIdzAUd5PEofxInld8h23xuipX2fRhDWnPFvm97iq/Cy6AmgyqKdIHH01
         Nuz/lxEo/Uj67qtA4FT9WMV0fiMCJEo721ONYSQFP9UlTkvhh6928uuR45VvFCw+1vkS
         KrzHIfyUPun4IjnEirSXGeKZPrIWaQPHqSOezEsAvj0uALKqL41Fx/8VwHMbZ3IgB9VU
         yXfA==
X-Forwarded-Encrypted: i=1; AKwUvBz+EUVOj1iNWSpjVZkDN5ayyqzzRfiklLlanTFYPxAALdh46HUaMUqdOjxsSwrMLk4xM6V1Aus=@vger.kernel.org
X-Gm-Message-State: AFuF++m7lirGGSUIkQz5RlDBN3KvWR0o+NfsGhC5Yg3KuhJ0KYR8Y6u4
	BAiEVLF1czHgZicq3gS67WYQQRQRMUrKanf3GXnYCTWkA+xDvDTC8CelQHbyRFjQBsJtxP/y8e0
	xOw8YY1X5+RyozA==
X-Received: from qkof21.prod.google.com ([2002:a05:620a:4095:b0:939:359f:cb12])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b90:b0:939:93f:3b41 with SMTP id af79cd13be357-9396e375d47mr668155485a.16.1788437321258;
 Thu, 03 Sep 2026 05:08:41 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-1-edumazet@google.com>
Subject: [PATCH net-next 0/9] vxlan: convert configuration to RCU and drop
 RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series converts VXLAN device configuration (struct vxlan_config) to RCU
protection and removes the RTNL dependency from vxlan_fill_info(), enabling
lockless netlink link dumps (RTM_GETLINK) for VXLAN devices.

Patches 1-3 fix pre-existing issues uncovered while auditing RCU and VNIFILTER
paths:
  - Patch 1 zero-initializes _md on the stack in vxlan_xmit_one() to avoid
    leaking uninitialized stack bytes into GBP header fields when metadata
    options are absent.
  - Patch 2 fixes a use-after-free in vxlan_vnigroup_uninit() where
    struct vxlan_vni_group was freed synchronously instead of via RCU.
  - Patch 3 fixes lockless iteration over vg->vni_list in
    vxlan_vnifilter_dump_dev() to use list_for_each_entry_rcu(), and clears
    cb->args[1] on early returns to avoid leaking dump state across devices.

Patches 4-7 convert vxlan->cfg to an RCU-protected pointer:
  - Patch 4 refactors RX, TX, MDB, and VNIFILTER helpers to take a
    const struct vxlan_config * pointer parameter.
  - Patch 5 moves the internal runtime state flag VXLAN_F_MDB out of
    struct vxlan_config into atomic bitops (VXLAN_DEV_F_MDB) on
    vxlan->flags, avoiding RCU reallocation of vxlan_config on MDB updates.
  - Patch 6 converts struct vxlan_config from an embedded struct in
    struct vxlan_dev to a dynamically allocated pointer.
  - Patch 7 adds RCU annotations (__rcu), updates configuration changes to
    publish new configs via rcu_assign_pointer() and free old ones via
    kfree_rcu(), and protects readers under rcu_read_lock().

Patches 8-9 clean up redundant state and remove RTNL from dumps:
  - Patch 8 removes vxlan->default_dst (struct vxlan_rdst), tracks the
    lower netdevice via vxlan->lowerdev, and switches remaining readers to
    access attributes directly from vxlan->cfg.
  - Patch 9 updates vxlan_fill_info() to dereference vxlan->cfg under
    rcu_read_lock() instead of relying on RTNL.


Eric Dumazet (9):
  vxlan: initialize _md in vxlan_xmit_one()
  vxlan: vnifilter: free vxlan_vni_group via RCU in
    vxlan_vnigroup_uninit()
  vxlan: vnifilter: use list_for_each_entry_rcu() in
    vxlan_vnifilter_dump_dev()
  vxlan: pass vxlan_config pointer to helper functions
  vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
  vxlan: dynamically allocate struct vxlan_config
  vxlan: convert configuration to RCU protection
  vxlan: remove default_dst and use vxlan_config and lowerdev
  vxlan: no longer rely on RTNL in vxlan_fill_info()

 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |  11 +-
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  14 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  57 +-
 drivers/net/vxlan/vxlan_core.c                | 720 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  45 +-
 drivers/net/vxlan/vxlan_multicast.c           |  80 +-
 drivers/net/vxlan/vxlan_private.h             |  18 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  77 +-
 include/net/vxlan.h                           |  12 +-
 9 files changed, 625 insertions(+), 409 deletions(-)

-- 
2.55.0.970.g62bdec98f9-goog

