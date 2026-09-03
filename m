Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18EB4B7150
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445927; cv=none; b=JJi0yENz/PMjA6co918/ukqki3MfjBARp/+EAMUzmksacAZfSIJKOWfsR/jSlW/uC/hzR3yJE6WaJ7J2p3P7ukUOH4umD55uTOHah+26tfYoYxFly9nBoCoYNZentx5BpR0kLDmFM9fo+shD3h5s30hIvIa2p93boZiB05skNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445927; c=relaxed/simple;
	bh=B0IsA/lAeJ4qXMhNIAjjpDlfI19ISSUxT5j/DHGlB/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jarA30IGWtesY7B79bd+sX+sDUOpQkk8OKlw0tuda4RJF3iWfdwUuatyQ7MIBCc+A0KEA4ycnSCm+C0O1lEcEEZR9Iftp9XDmSRofIgrguMbEJZ7ozxjGb/Ek/juIt698ehqV7UJQby3+E7p1IM/Cv7kgfXtTtvD3u1wwMM6Se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=D7d3NSVN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="D7d3NSVN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956869750eso17304635e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445917; x=1789050717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDQk0GUSPZMdmUwgzdH89AyO+OXROlqVMrjjdPFDraw=;
        b=D7d3NSVNmM8zvcHAF3MR9FFYuqZ7q6TmI+YSwvFncQNTKrWTUgkyQKYeqTKdTQemMg
         ET2p4JpeuviRTRK6IxODB2QZyARkfMenF3OOjRyrKrSO1B4Yi5GruWNPf2lTDEkM0cka
         XdTP0TzoynsHL7Q/8MgfximHQNEjFKXWMR76ml4200e7W6vXrMCuTuAwpla0KpL6PC5g
         i2V3F+6Yfy/f9CvECkz1lwV5M/A6VEXlae0+iEynNrh2EC2Pk577VEhdkeXX/qrlyixt
         oNjNPu1xKGZOfV/lxibHPjJzyaREYD6cdTO8915P9yF0GB/rb8nLJF1jVhlOH76SICie
         YboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445917; x=1789050717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDQk0GUSPZMdmUwgzdH89AyO+OXROlqVMrjjdPFDraw=;
        b=bnF/0xcFCHftis7H/bAyl5Rqsjf7tm8OU1dVvx45Vd1mWSFj6G2tGrV2T3YWu3LaPz
         KrUToB7JxO8deFMzTvjh3SKimW/aLVFNdKF7HMTVspBR65B9tpOcWO2RM5GqJgRRnSyf
         pSu3mLKGyC98dLp/XH7X6L7OpWCR8bPUv7n2dHs6ZCGr9nE+RSbbG0pncaGGfoesw5EC
         X7NDYoxHidxXeUPWLWoasL3zwebqg73nJPU8LJKGGIeGzQKlyh19rBztiNpsDbqve/0y
         +t2VG7gUKW02b9YwFwhdKnKi7cqgVZgGn8DxR0EDdiM4V7lGCORuxrg9eZ54OYZEXZAQ
         V69Q==
X-Gm-Message-State: AFuF++mBrKIvwilsI7vUr8YrEE0e5OHZpzna3KDajrrXudy7g0LpnJ8n
	WRm9215tGlHcmeVHvCIpvIZBPkvDxsNKpZesAeKEznSps+2NcQtgVh5qu5URX0jF3ckQaeIs/ex
	Vn/rMY3w=
X-Gm-Gg: AYBFou3V9IxGNw0A3Cdaqt0LlIelNKg/HRrat0umEzGWtpUAjjtS/djIIAicSTgwhNO
	2VDShMVp6P8/CCxLkl1QOyAXBPRC8ha9S+x/flhDHe/A0XBrH6hso92e6FsqLOjwTPjNCru2lDs
	yH+FxxlMtSd/fGKrg5znTtGL6/dLXLXKzI59qtHMlt2W+ll3D/pm2PDSsmYnTXgMgPKDyqhqGei
	h0s9G5tZcot677RMaj9sutCxtuBUldw87ZJGLPM92trorSCsJejHf0VHI6H3c/cu8t7Ujv7krhV
	4hQ1vxKnystHqTmig/PNFzy4CO498PzAGV9bAXEC2I3oEocyebLLmU2Ee6I8w/XZjMdiLUkCWDP
	dbY2ye8c703hxPwfK7r1XPIlJq8l7cLpDQzNd2pZqbsAFd1UBR3dpgyLUh5hCYWL5IN2aX8yUD/
	qYZjDcJG8yjQJpAHgrAOQPWqH61PhRIMg821gfeMoPOG/8IFPjPfZoh31cRGz5/Lrgm2DQmur5Q
	FVrM7QBxrkgUi1LRoHIWQ==
X-Received: by 2002:a05:600c:1987:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-49ce582266fmr203228995e9.12.1788445917298;
        Thu, 03 Sep 2026 07:31:57 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d5d12sm74324245e9.5.2026.09.03.07.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:56 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v2 0/9] net: bridge: vlan: minor cleanups and annotations
Date: Thu,  3 Sep 2026 17:31:29 +0300
Message-ID: <20260903143138.1574598-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
In preparation for a complete vlan fast-path re-work, this set cleans up
a few minor things - removing legacy code barriers that don't help,
                     annotating lockless accesses and using proper helpers.
No functional changes are intended. Sashiko will find many pre-existing
problems, none of them are related to this set. I will try to fix
everything pre-existing separately in -net, there will probably be a few
critical items. So if there are missed places to annotate, or if there're
actual functional changes, these obviously should be addressed in this set.


v2: fix a bit longer lines in patch 8 (were 83 chars)
    fix patch 9, many places were missed, use br_vlan_get_state
    consistently (Ido)

Thanks,
 Nik

Nikolay Aleksandrov (9):
  net: bridge: vlan: drop legacy memory barriers
  net: bridge: vlan: annotate lockless pvid use
  net: bridge: mst: use br_get_pvid helper
  net: bridge: vlan: annotate lockless vlan flags use
  net: bridge: vlan: annotate lockless use of private flags
  net: bridge: vlan: annotate lockless use of num_vlans
  net: bridge: vlan: annotate lockless use of msti
  net: bridge: vlan: add missing tinfo.tunnel_id annotations
  net: bridge: use br_vlan_get_state to get vlan state

 net/bridge/br_arp_nd_proxy.c   |  6 ++++--
 net/bridge/br_mst.c            | 19 ++++++++++-------
 net/bridge/br_multicast.c      | 18 ++++++++++------
 net/bridge/br_netlink.c        | 10 ++++-----
 net/bridge/br_netlink_tunnel.c | 14 ++++++------
 net/bridge/br_private.h        | 37 +++++++++++++++++---------------
 net/bridge/br_vlan.c           | 39 +++++++++++++++++-----------------
 net/bridge/br_vlan_options.c   |  8 ++++---
 net/bridge/br_vlan_tunnel.c    |  2 +-
 9 files changed, 85 insertions(+), 68 deletions(-)

-- 
2.47.3

