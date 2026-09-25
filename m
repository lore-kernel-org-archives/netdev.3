Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B724A1DE4
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344369; cv=none; b=fBg1fFrT2XLOHXKEvB/hJsOlYT8z+FoEQ8T0zOEzmKvPb93Je5DqSMSejemhkRBtc28hggrI6c1mjlH968RiyRar4zuxsERNx6I3oDkgvvkrDycJ0ATvbjoiSleYrJPXtS7nQyfywPtvIbTU4GlDyua8nX1sYfS3tJzxGKhsNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344369; c=relaxed/simple;
	bh=4+fSNyWUx4JFT3jWS0EsLgyWNB5lPPi4Dd/8QIFXo0o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FtlxfEHSCxzKOb/wWzqwKZByWdNTNHcx2baIiNe5ZvrJGKNsfW8EGblspPZDOGGnbHU7wlklFnSbIphRa7HugC4i8WQxQGtFvDqAwPvdBC5OXGOy/5jrjfqQCfaD/7/cWZxs0fb9mxdnglCrg4GzhhIsI4V4HEWaktQQQRdgNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFLwwcUB; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFLwwcUB"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939d6c515deso181278185a.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790344366; x=1790949166; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+g35WKgAij+rCTTh5HoMaOHnlqNuCBt7ZfS0tJ+Ug34=;
        b=DFLwwcUBUEAqOPyrxJNiFqQukKhDxGewAFqK1l4m38GT8cTRW8qr98P6+R4SSbIoCo
         McWZlb4RiPGwgYLMdtdliHLAYh7V+raZ2H/iRJEAzQYdVAB70v/j3XG2wSYpEhs+YcAi
         CVCNFNyNxP3GwfRuIVDEdvJyQwxgI3jges18Kdi4tqPjPqQdqaVl6QXG/+9nKEA7Xsy9
         2HCx0+9BjFn/T+NsL5zWlz6injrnupsgiCx7DDOLyoPrM/ezc9WfbqxL2z91FNyQRcCr
         ywyp83sqcmQjEEIdOZXg75itvGY/ukKJ70zfs01NRE/QLDBL3iNTQRSBr9ggiO7waeOI
         r/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790344366; x=1790949166;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+g35WKgAij+rCTTh5HoMaOHnlqNuCBt7ZfS0tJ+Ug34=;
        b=xHxDWg5wdjlJXu+duoNhd8kE5aIvn5DTFm43YtL38poMFjIWwEOOPg7FP89DAuA3aY
         +51axSslgzggUb05ijYVYdo7QvgfXNwqvlcml0cildid89Ei3phU8tNMW17KzsuxrfN7
         5RLP+6vgGAYSXq+KGXeN+mt3sJEeLFufEAMDli8WyEi2IQMCW/7kZpaCPtn9wn8nRuQM
         FjUS3FDXxpx8NI7pcZlMKEyQ1NT53pJnDTJ4k6NlgN5bMAVcb7LBxtUsGHLE8j7wbfES
         6BdWoTPwoDKTT5kzABXqxmTiSnXGv4xuVaDHderiNqeji3iX3Lza7GjTsqsjLgkzbHfI
         JqRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtIkcPvAgBv4ceRWepxYiOtaL4FPjdWHaMMa5Ro11EYKd4TX7sKXA3f/9IeXxAh9dr7TbKv5w=@vger.kernel.org
X-Gm-Message-State: AFuF++nZfgWttFOwLqX4FcuOV8V/nWC2jMI+0Z1GfuYBKyJfqS+rOae5
	SWq7c9YG9em4q1yveI1QNDMXjl34UZZbKhaCsSJXU9dbB2t1gF4xUCk5av6JJjRJ42ujGPwO/ln
	sw3KDt7zckCLhYw==
X-Received: from qkkf22.prod.google.com ([2002:a05:620a:15b6:b0:93c:3513:eb1e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3722:b0:93b:d8bc:a864 with SMTP id af79cd13be357-93c43d4b54fmr458532985a.65.1790344366309;
 Fri, 25 Sep 2026 06:52:46 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:52:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925135244.3715196-1-edumazet@google.com>
Subject: [PATCH v2 net 0/2] net: fix SO_RESERVE_MEM socket type restriction
 and value bounds
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Wang <weiwan@google.com>, Simon Horman <horms@kernel.org>, 
	Cai Xinchen <caixinchen1@huawei.com>, netdev@vger.kernel.org, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes two issues with SO_RESERVE_MEM and adds a kselftest suite:

- Patch 1 restricts sock_reserve_memory() to TCP sockets (sk_is_tcp(sk))
  instead of sk_has_account(sk), and caps the requested reservation to
  SZ_1G in sk_setsockopt(SO_RESERVE_MEM).

  Currently, sk_has_account(sk) allows SO_RESERVE_MEM on UDP sockets,
  where sk->sk_forward_alloc is protected by sk->sk_receive_queue.lock
  rather than the socket lock, and udp_rmem_release() does not account
  for sk_unused_reserved_mem(sk). Concurrent UDP packet processing and
  setsockopt(SO_RESERVE_MEM) corrupt sk_forward_alloc and memcg
  accounting. In addition, values near INT_MAX overflow 32-bit signed
  int in sk_mem_pages(delta) and (pages << PAGE_SHIFT).

- Patch 2 adds a kselftest (tools/testing/selftests/net/so_reserve_mem.c)
  covering non-TCP rejection (UDP, AF_UNIX, SOCK_RAW, MPTCP), bounds
  validation, reserve grow/shrink/rounding and SK_MEMINFO_FWD_ALLOC
  reporting, cgroup v2 memory.max enforcement, accept() child zero-reserve
  inheritance, and reserve retention across TCP traffic.

v2:
 - Patch 1: use page-aligned SZ_1G instead of INT_MAX >> 1 so values
   returned by getsockopt(SO_RESERVE_MEM) always round-trip through
   setsockopt(SO_RESERVE_MEM) (Sashiko).
 - Patch 2: enable CONFIG_CGROUPS=y and CONFIG_MEMCG=y in
   tools/testing/selftests/net/config, skip when memcg socket accounting
   is unavailable, restore cgroup.subtree_control on teardown, accept
   ENOPROTOOPT when MPTCP is disabled via sysctl, move the test process
   out of cg_child before lowering memory.max, wait for
   SK_MEMINFO_WMEM_QUEUED to drain before checking cfd forward alloc,
   and drop the arch-specific SO_RESERVE_MEM fallback define (Sashiko).
 - Link to v1: https://lore.kernel.org/netdev/20260924123602.1979090-1-edumazet@google.com/

Eric Dumazet (2):
  net: restrict SO_RESERVE_MEM to TCP sockets and cap max value
  selftests/net: add SO_RESERVE_MEM test

 net/core/sock.c                              |   4 +-
 tools/testing/selftests/net/.gitignore       |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/config           |   2 +
 tools/testing/selftests/net/so_reserve_mem.c | 404 +++++++++++++++++++
 5 files changed, 410 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_reserve_mem.c

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

