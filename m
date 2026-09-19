Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E12D73B6
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789825431; cv=none; b=XY2M4c2AE3NRxgHGFyiAaHcsPBAMMj1hk2hI/3g0l/b7iHFvYVe2mtoaFHvH68YpMIFvbtpxzhvgYj2pxNygJ+FtnEXakmnXYIQL2MTig3+cCkB1GYqN/UJ8VstQ6d7d3zbAFQP5mPM6erAkbBh73sQY0CkIXRzXGlmGQE+XX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789825431; c=relaxed/simple;
	bh=dFZ63T3zvOowaEIbbYHyNeo31i69lA6u+JkTJ9+rQeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1lq4ypPlGRWCN3hIKcveAwvLfnbyQtoQJhLS6Lfe0BVoIU06IkYgutCHMsUOz3BzWPUXQ7gtkraZDCOsjkLygTVHIQZbo06xbhde/FQ+yocu6kPPbuxx+F0mdQ5W7ttyPFE7l9C+1KZyudz+Hx1SbyI3SEJuZazJnVcKMM+YnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/zngkOn; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/zngkOn"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5d4688decso16487981fa.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789825428; x=1790430228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
        b=H/zngkOncThpID1/pMXMVInlk7OkTPlKuJk5fdWven3hX8/TIEcozwB2K1Dz8XNdRj
         pq6ysDnx+Cz5VmuoIm0q891L2OhMcX9l+wGIHAeIgrE+ho4F1TPWM0XmpwBu1n+BgLIa
         LlrLHexOZyXo0r8tIujIGvQkwVz738I25ovWMZc+ZTFYQs8DUWjWYnZ+5HReb3nfD8Fz
         FdNLFUybxbouKAPqslPUrY42xdKgp++U2y//2UN45u83YmK0yRYcpKgINF7nY1LHiYz+
         MDS7gvJtxYtE5X+jlrHOk4byiTTWdklQf6QUJPgGkSIuUU+Zq4CJ7YOQFEu7ldqwajdK
         b9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789825428; x=1790430228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuHF/oDZVPSpibhsK+iPHeV9FkZXWA2uFO4o60iu8z0=;
        b=kIkOQugqFih0k/vHhLulu5Pe/VwKI1xlTsXALpAFRmtKfJHITVv+9Kx6mlfyyjlEpy
         ONSAIQd7YckQlYL3EAuRTKANM+ioGph9d0bZv/SYY0dashEHFdENNJBgpEG9k4YTfFfV
         qoHPr4mntT9gPrkD9Hpq8FCQ24YdVPSTmPLMGXSRwrJuFcQ6ZT4+aAKbmh0Ua/igtXcA
         p1WOTK+BiTpY4mpq1p7S7NxZw6KGU1lBXkws97kyTUnngDsU+4RLh6Xq70+dhA/2TKIz
         jz6RH7SX49smkWX8OK0jQPktJBrmL/59+EAdSGmHmZ6hC1InixakyytuuSDxKWtx11rM
         BreA==
X-Gm-Message-State: AFuF++kzDuRzL1lzH7RobAfYMNUCbPJr9H2gAuwDQFUoD67o7OfEVGPF
	ME2A1L1ImLUHVfjwudEO0yuSjxkyMXfYrUF3nhbdwO4x22CGBlL5/yHQ1T1ONiS8
X-Gm-Gg: AYBFou2nZ2i1I1D/1e529ZdCcaS2seBq102JJJOzCcl+GyyJtPWX5HYIQmhR7HlHEdi
	OxqC8vbFA5iJMXnEbENz+SqAxX7q2zIu6LM4iScmWaeBBxf/n1nNsWdOEErTAcvqtUrJc+POT6K
	qlAoLoRXSKj+iwtujrWtGjh3AheUDauS8iWfNK8FaGNX6H0EstZcrl8uesv2Vr6Y3Bqvp5BYl2C
	RXOB27NwtAA2NWbVp56HokGkN6NmVyUCzokj+YuaK+m36RdrgeMyYu6FSR/MtbcWbk4N0OVpzj9
	3TZ7YgMnE6KkJ52E9yRiLnM2/XDd5tGBFE/4J0S6ihY8/UU2/KA/9RLUutMuf6ZJ2yLKNhJs6MD
	dB66y82v78C+kJeOvqzXLWb9UYlTsj5xoLAsaCaQqcHg720D6VRGTzolYDpblD+MFCnIxZWp9zk
	dBq3kYCEzwNMMpa7POqxLgMoYDvoGlNtuK27rf8m2FQJPu3PhT+Vo25jyr3omcYXx9qcPVcZgT6
	9ZzhPemdj5YyTgKglEPM5VFoTW/+DaB58EnkSIvvpbYH4fSxbaOCgS9U4vxuT22ijCG
X-Received: by 2002:a05:651c:2213:b0:3a3:314d:1169 with SMTP id 38308e7fff4ca-3a5fbf05908mr10726771fa.1.1789825427681;
        Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60767aa6asm6220941fa.40.2026.09.19.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:43:47 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v3 0/2] bridge: report an oversized IFLA_AF_SPEC nest instead of truncating
Date: Sat, 19 Sep 2026 16:43:31 +0300
Message-ID: <20260919134333.49379-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds extack to ndo_bridge_getlink(), patch 2 returns -E2BIG
when the AF_SPEC nest, or the MST/CFM nest inside it, overflows nla_len.

v3: handle the MST and CFM nests too, use nla_nest_end_safe() (Nikolay)
v2: https://lore.kernel.org/netdev/20260912135022.1701-1-iprintercanon@gmail.com/
v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit in a netlink attribute

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 +--
 drivers/net/ethernet/emulex/benet/be_main.c   |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  6 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +--
 drivers/s390/net/qeth_l2_main.c               |  4 +--
 include/linux/netdevice.h                     |  5 ++--
 include/linux/rtnetlink.h                     |  3 +-
 net/bridge/br_netlink.c                       | 28 +++++++++++++------
 net/bridge/br_private.h                       |  2 +-
 net/core/rtnetlink.c                          | 18 +++++++-----
 13 files changed, 57 insertions(+), 36 deletions(-)


base-commit: e3bfd25626b44b6fa61a13c17178922171d519ce
-- 
2.43.0

