Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339238A71F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717677; cv=none; b=YrPkx0IfNCOfWl56cQ3JCGPXcd9Jrt8LQ18zbBk/7Xe7IZWKsUpR+BYyl0vSDxrAAfhAVt44jkIhBTblAnkiXJE04+h+lVv6Fic2wW67PcWXGZGPDMeCSIFiSNIIf1GNEv8Cc45pmFFS22AeRY31JvbSdRHugjI1o+jMdV5Y/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717677; c=relaxed/simple;
	bh=KeEuAPHxLxQzTCxEtiPlodXBxiAe0s3w8mpULpQakss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BfEnIBgJlOsFzy7TZ4XbhEXJYbHBEHNTb1ygbmSK9Igt5YqTE2VNOU2Q9FewcYx3OgdIbGkGcBSgvh5d9mDkLQJ+fVIjGRi2uqMbRM/zqQRv2Yk5rhqtbDf8+J1hMORaxryd/hyfl//lbTuj79Nm27FoUiP+v5cMkztqFHvuRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExOa6o99; arc=none smtp.client-ip=209.85.219.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExOa6o99"
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90cddf4f59eso50367536d6.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788717674; x=1789322474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xnc1P2y/x7OmNd5TJf0IHBPWNWWo+cHzxkfPJmnMLzc=;
        b=ExOa6o99b72iOHS/7VG0EsgGpr0bNO9v2u9JKsG5VkeNBNo+X7a8ORuVBAZAVtfVPQ
         bjcTE5jb74WXC6d9BfrXmUXkajHzxFoEIk2Fb/QTaV8/xgsKyEf7RPvZ/Rr3hhgd4L+Z
         jJV3hBvM5nS77xNhlcNbRH6MVjdeexlUckLmomhjXb6RJOP0lSMnUSHBrgdwDI/O1QR2
         DT3MhGCiwFWk5sWLT3Nh14YMnNcvhKxE6DoZ65uefJJh4YFb1mzAnEQc+nx0ITQJWIjL
         vpgFeTvodaPyuXZ8eQqStQ3q6Gna2qBZJcRcMHErqvNZCUwI6eN4VsGGQr8kdb1HYyy8
         hA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717674; x=1789322474;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xnc1P2y/x7OmNd5TJf0IHBPWNWWo+cHzxkfPJmnMLzc=;
        b=gv79KYf/emFDl0XU+8kumeqiT4QPf41vCPAM++6cjj8XiqL3Sor6G3IVOe+u4JXf1/
         dFpMjlb8Z9t/BD7TI87zA8joK3l3lWck578j+agjwBFBZ874fCsLplDyEb6TjroYtHtl
         eHEWEBis/74gxawcX5d9g/Kobshd5kySQy3ynbxkUF3F3ylHbp0IMD0q/l6G9lU9P0q5
         CNY4VhVjRXtBgoTPe2r4HqiDMqyKT/QVYHXfqLUy4TepnapqEDH7SMOVatDN63mUr7f+
         dZ3eZ3q7LQGhdLaww0tZWs6WlIabqs3LJh4TAQkxgsJzABHcfODIOXKMW9R3+6tuTaVF
         +HBw==
X-Forwarded-Encrypted: i=1; AKwUvBzoyMP/DPfjmy80bmFyg6C31vOf0HDnlN5HT67WuAfiO3AuPPAgfqtANyfpptNM+ztYChxip6g=@vger.kernel.org
X-Gm-Message-State: AFuF++lK8hqDREvZNUqLLgJh1LbS9HJjlbZ5gf3X2xHL8+uEEgYNuCxQ
	+QB5BPg6gEicHFPxRaEqyDkxZiFtrDTlqOxZnefwU0gAQ6rVQVDP4HXauS1Ie/kMp+Hj+eE1UxJ
	O6zldNQ6mJNIm/A==
X-Received: from qvbqb18.prod.google.com ([2002:ad4:4712:0:b0:910:5a28:9fa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5dc8:0:b0:910:49d1:3a8a with SMTP id 6a1803df08f44-91049d1469fmr109346176d6.21.1788717673125;
 Sun, 06 Sep 2026 11:01:13 -0700 (PDT)
Date: Sun,  6 Sep 2026 18:01:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260906180111.1973188-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/8] vxlan: convert configuration to RCU and drop
 RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series converts VXLAN device configuration (struct vxlan_config) to RCU
protection and removes the RTNL dependency from vxlan_fill_info(), enabling
lockless netlink link dumps (RTM_GETLINK) for VXLAN devices.

Patches 1-2 fix pre-existing issues uncovered while auditing RCU and VNIFILTER
paths:
  - Patch 1 zero-initializes _md on the stack in vxlan_xmit_one() to avoid
    leaking uninitialized stack bytes into GBP header fields when metadata
    options are absent.
  - Patch 2 fixes lockless iteration over vg->vni_list in
    vxlan_vnifilter_dump_dev() to use list_for_each_entry_rcu(), and clears
    cb->args[1] on early returns to avoid leaking dump state across devices.

Patches 3-6 convert vxlan->cfg to an RCU-protected pointer:
  - Patch 3 refactors RX, TX, MDB, and VNIFILTER helpers to take a
    const struct vxlan_config * pointer parameter.
  - Patch 4 moves the internal runtime state flag VXLAN_F_MDB out of
    struct vxlan_config into atomic bitops (VXLAN_DEV_F_MDB) on
    vxlan->flags, avoiding RCU reallocation of vxlan_config on MDB updates.
  - Patch 5 converts struct vxlan_config from an embedded struct in
    struct vxlan_dev to a dynamically allocated pointer.
  - Patch 6 adds RCU annotations (__rcu), updates configuration changes to
    publish new configs via rcu_assign_pointer() and free old ones via
    kfree_rcu(), and protects readers under rcu_read_lock().

Patches 7-8 clean up redundant state and remove RTNL from dumps:
  - Patch 7 removes vxlan->default_dst (struct vxlan_rdst), tracks the
    lower netdevice via vxlan->lowerdev, and switches remaining readers to
    access attributes directly from vxlan->cfg.
  - Patch 8 updates vxlan_fill_info() to dereference vxlan->cfg under
    rcu_read_lock() instead of relying on RTNL.

v2: removed patch 2/9 from v1 (Kuniyuki)
    Added Reviewed-by: tags from Kuniyuki.

Eric Dumazet (8):
  vxlan: initialize _md in vxlan_xmit_one()
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
 drivers/net/vxlan/vxlan_vnifilter.c           |  74 +-
 include/net/vxlan.h                           |  11 +-
 9 files changed, 622 insertions(+), 408 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

