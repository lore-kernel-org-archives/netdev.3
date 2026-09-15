Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CA43CEF7
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494907; cv=none; b=dY3qkhEQdtSnfGFyHDdGbZ8voXGFuSWxZv091J2jwgqrBD7hyQWR4+FGuRxUzAHm6ICbzSEP6zqz04S2GVvoBQH24lm4IcpqJkazh5LUbGyAXahAI9Jx+4To4UCoQap4P5qRJyOfzwtCfFyweXY4Q2vboggeDsXWNGPysPVf/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494907; c=relaxed/simple;
	bh=1L1hXuEG4LI4sRLaoHjbAwIXzIUk0FTeROjRa0mfKJo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XWUXqMbp+jbbEgDtcnJaPb2ZPS9MZ0k/a4AOCVIxafAEfc1wkCQQDmcPLQ+RX7pgxsdJSVAuH8aNeCTR9jOlkAZ/rK5L1GYzq3x+ZPLB4Q/SfaHxePXtJR4vDDpjyu1y53DLjQr8uwTL2/82wglJRWfdGblaooXYFRQIZdzFxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfh0XC1y; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfh0XC1y"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso724014285a.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494903; x=1790099703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DzfdQG1PR4hEdkHkTX0HQwG2aWaoIZZbELA4iW37cx8=;
        b=lfh0XC1y/cwHJ4oIe/0CH0URy+iyy3fzVxxqqbxHIoOGzGPirkgkYmfJWGwvtcKsXU
         0zp8YM8MaRYAU5A7ZmY2YDXqHcIxYRBbSsEn6HG6+ChC4R/DUhCp05ul4GgAUJwLRK9t
         O4yRm8Jn/dh2ipt8tL20EdEMvj378uU8uNVjGM635X7L8y2eAIsOg8hxHKNp7mnTNgKt
         TR7EMuf/MBOzKUmO2NWdPkfwu7gMs38+kKLqoriXNlBmVnjWLxGdawH9vB1cpwuY6Csz
         0gVWHMnVX23ea5Cfrfoo3KtUCu+ie0OyoFktprQbzatpfeUMk5aDiFo6soynQIebj2rs
         o6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494903; x=1790099703;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DzfdQG1PR4hEdkHkTX0HQwG2aWaoIZZbELA4iW37cx8=;
        b=V+vY8n/BRm2hMfGiGvdfFL6c0SdEhQ/Cm3gl2ssnRpmDbOkmQOO9iOpnj5BYD5mOpR
         MfY6T76TdGCylp22vZgbT9LMDgy4MPbQeSfzH0DiTM0CZlmlzX9v+IGar0D5trphwvAj
         7i4FPIJl+bi/e6k4kmwy/1pF9PdODhnPJgpfE0Q9xAJfq6PuRbqVFa5AG/dn+Zov24Al
         Akwvln8tkgLdd6MO5udEKqezxJl86hKrtFCZu9cg0l1pMgof3zZToQZE7Duiyba7bHnd
         M0mC4YYs5raV2ECt6dmr/q2tOa1JUKy1egu6ff+PrHwYR2pvqe8h7Z4xfmdfsw6vihfX
         qfCQ==
X-Forwarded-Encrypted: i=1; AKwUvByd2Dc7ulUtsUFWB4UEi3bAOh9vVhMvo6fMkuGTa6nkNUSTbcGMzI2sqHmHVrXQmLqR9yM4wB8=@vger.kernel.org
X-Gm-Message-State: AFuF++mq5jnWzMyZzW3Ciy74kuZBMHx2keEC2FadWWiy8vrODJfYX2+r
	V9BYxkcRYF9MmgMfV5V0aNiKMOIfX+I9GTx9Wc2J24IIDAMR/wcpyDxB5KJyaamw+l+5wkyB7uM
	rzDo/gcHZl/yOcQ==
X-Received: from qkzz1.prod.google.com ([2002:a05:620a:8c1:b0:93a:1a79:6a20])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:839b:b0:939:9d06:e997 with SMTP id af79cd13be357-93a29999cf7mr1484434285a.26.1789494902868;
 Tue, 15 Sep 2026 10:55:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:54:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-1-edumazet@google.com>
Subject: [PATCH v4 net-next 0/8] vxlan: convert configuration to RCU and
 enable lockless dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series converts struct vxlan_config to RCU protection, eliminates
redundant destination fields, and enables lockless RTNL-free link dumping
in vxlan_fill_info().

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
 drivers/net/vxlan/vxlan_core.c                | 731 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  45 +-
 drivers/net/vxlan/vxlan_multicast.c           |  76 +-
 drivers/net/vxlan/vxlan_private.h             |  28 +-
 drivers/net/vxlan/vxlan_vnifilter.c           | 151 ++--
 include/net/vxlan.h                           |  12 +-
 9 files changed, 705 insertions(+), 425 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

