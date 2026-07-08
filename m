Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFD2D73B5
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526655; cv=none; b=ujMUONDT72yCgEipDDIwg8ifgkdOKgUYSKB0jzS5YePpMww/Ib/PzaQEqIh4jF5AxBVtdVcpcKtTu+f2XdgcV3bmDL1/9yiKbmPwlills3p7nnrUTMyvv5L/vL/onJTXraw0D+TADMIRoK8thWaZIahWCD0KcaayYaOP1SMJSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526655; c=relaxed/simple;
	bh=nsIM5Ads6bh+CgPYhu6ixOfciLb12Lj7UanQv3LU5b8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XKt6qABbEBrY6GmY9ZYthwG53+nWD7/8GwLp2RNA6KQf9iuLBObnghiOHlIdB/wV+3iR9WLdsh1E7+3vaHPVLnoAqfkYCG2Ulf80UTiBURp+rZmJSDqK02/U1HnT5a/uafPCaOj+IgBWpNo+T0Z7REB6D40ygI3Ij5+r2da5GuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlH54cWc; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlH54cWc"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-92e606e8f3eso90618385a.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783526653; x=1784131453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oxNjldRTaaWvRhjZ7JnYIdYwsUU3Hk8/RYarPnBCZsE=;
        b=RlH54cWcgdnqkP/DBH+twXHE6KM9T7RBUJwyF9p+Ms10P8pRxjSeSNDRWx7B0vwwIf
         NoP6DFX/PBPMpQMBBWAJ2D6WiB+8iEbDO2SEDXog0jF+KmMTTWoh+yJG3QJlIaeyu5kC
         McpLSVjhqMDzEjalLRqarT/Rnzqy6HbgfZPkEWy5cNKLYUOB2oLoNZlRQLv+/3SAUq0b
         3A7KHVpBxzBvsbtKoccd9f3+7yKXBRn8HAqeG6nAz/jA42yJjnAOPrNQQEQ/tc+wLJ9N
         KpAlqiYpm3a88LIFVCnULffx7hMCQ6UY+2/A0YUYZEYMwX4Wu8iZ4T4cRFYrshahIQCE
         cEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526653; x=1784131453;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxNjldRTaaWvRhjZ7JnYIdYwsUU3Hk8/RYarPnBCZsE=;
        b=eQi01j0UCaa3Y53kfypY6sHH65TF+IWXcmhn2EwpSPOMmL3WfM8mB9x0Ew8XZlhflf
         6toBqSoEQ12gk9z5kGmulfzb2qyVson/HtdTTA6V4R1tSZ3hfOwsowIe7CT6nXzCq5lE
         iCiic5RgEXFN/dH4+yDxEJMacULfjOdJPM3O6V1NksDKP2VU7+9cMzsG2N81tOwCrRlR
         +PzdUU1+FQmr1xbi5s/0UeGLZgR/GYNi6uozs/kQ9LDaz7A7TfHdCrnigJHDTnRFvy5r
         gh41555wOW7vtubwxRGAgR3MRA/d+1AY/5tAl0Qmx27GhKzdk08yMD1E/wq+zZeYQVpM
         FeWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbjGFVpbbK9nTFJi3ozRRG+a3FUkecmOkAB+zJ2udV2F8B8k3PLr10uZ2OYORsMcJ8zS/YX/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzty9YfzYPfCx6YUGVoytHib90joE2kqdCzFI5LXSXLWVKxaes
	xHNvYyeuZWKE3jy/PdA05X8DSF3NFHUSreqLcpBvsNfZXwi4t+APyLVkwtubS/ZRWMrELqNApPZ
	DjXlpMHUh4Khviw==
X-Received: from qknrg5.prod.google.com ([2002:a05:620a:8ec5:b0:927:dfdd:7617])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4542:b0:92e:8fa8:829b with SMTP id af79cd13be357-92ecf5f3f2bmr323994185a.24.1783526652262;
 Wed, 08 Jul 2026 09:04:12 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:04:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708160411.1355008-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] vxlan: RCU protect vxlan_config and enable
 RTNL-less fill_info
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series converts VXLAN configuration (`struct vxlan_config`)
to be RCU-protected, allowing lockless readers and enabling RTNL-less
`vxlan_fill_info()` netlink link info dumping.

Work has been split into three distinct parts:

1. Refactor helper functions in RX, TX, MDB, VNIFILTER, and OVS paths to
   accept a `const struct vxlan_config *cfg` pointer (or pass specific
   fields such as `flags`/`saddr_family`) rather than accessing
   `vxlan->cfg` directly.

2. Convert `vxlan->cfg` from an embedded struct into an RCU-protected
   pointer (`struct vxlan_config __rcu *cfg`), dynamically allocated on
   device creation or changelink, and freed via `kfree_rcu()`. Update
   offload drivers (`mlxsw`) and OVS (`vport-vxlan.c`) accordingly.

3. Update `vxlan_fill_info()` to run under `rcu_read_lock()` instead of
   relying on RTNL lock, completing the transition to lockless link info
   dumping for VXLAN devices.

Eric Dumazet (3):
  vxlan: pass vxlan_config pointer to helper functions
  vxlan: convert configuration to RCU protection
  vxlan: no longer rely on RTNL in vxlan_fill_info()

 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  14 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  57 +-
 drivers/net/vxlan/vxlan_core.c                | 566 +++++++++++-------
 drivers/net/vxlan/vxlan_mdb.c                 |  37 +-
 drivers/net/vxlan/vxlan_multicast.c           |  12 +-
 drivers/net/vxlan/vxlan_private.h             |   6 +-
 drivers/net/vxlan/vxlan_vnifilter.c           |  24 +-
 include/net/vxlan.h                           |   3 +-
 net/openvswitch/vport-vxlan.c                 |  34 +-
 9 files changed, 475 insertions(+), 278 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog

