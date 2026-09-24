Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B012F585
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253366; cv=none; b=n9v4kuFNulwucQF6F2wNBWP57eHgXQAcYKYBQcwoo9ROjtW9Zmx9Nek9u5V36EXpus6G79Rc9QKCDHnZivJcO6PKGx+evYG6qq+G2ryBOGDNSoWYb+PMWYKron2I49ZmT8r3FunnMBvLKVPP92jbOad1z14a01+tl4/pdFwAKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253366; c=relaxed/simple;
	bh=hW77pRZQXbxSS5D9kzjdP9Xodkhkdrnrx8+JvhaTYYU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WqX6iusZRHbM1AyW5fLwLJE0w098vHv8m60NntWtpiagJY3ZYs6FMH8cFYmMIjUPJwAHFOUeXWY6lXv2WKbTicd4BhFaPqKRdJJKj11iaj8mwVKPLq3+EKk1iKTD/LzqFdclsPl1veeKJ4h8wnS2cI9Igc9YWh9d021pM1Y1gOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s2KHaDY0; arc=none smtp.client-ip=209.85.219.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2KHaDY0"
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91054f537f9so16921736d6.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790253364; x=1790858164; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPJs7Ki9jdjJ/cve5bA3M2NI6AqnwWemzRdYV5xFfpI=;
        b=s2KHaDY0U0Q1M0Tfs/RI4Fdj1lpB78/YJEbrNd2DDm+3sCEogfkJRsT5Eo0/k4Rjza
         bbRA1bVcEgw/JCmIi7fl/9Vbu5x9EQocrJdMa3tcYsbgGj4a5I9kOYfLOvA56QJUaeiw
         u18e0cReJ+nHF39T95nVGz6J/9oiQ5EVhRMOmDhZlmcJ48EqyI70fUQ8sf2/RkDdxFPt
         ajjRabKgi2IroZ3Jj+bkH7FUY83M1XAOgY6puLbNVs2jVucDWKqiOxCVWtwnirWUqGL6
         9UJkngOA+mTc1SlgSznev1OlpvNZ5bLMbqvveRfHID81anNPSixaypUX21dpEXKLs/im
         w2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253364; x=1790858164;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPJs7Ki9jdjJ/cve5bA3M2NI6AqnwWemzRdYV5xFfpI=;
        b=QgjRYmI+v8t2YIdl6oAxl1QdMRxSREQ9avETouRDHF9gDBr7mwyWmYn3YyKzIQ5+YF
         Y+c8f5lp5By2uD0MhwxBFNDVwfKD/WRps5fBJSFIbCNrRgdk3vFKEuENTV3DjW/wA8Ll
         BiSpiDdEu9K8/79glnOlgW8SWklzWKqEPJOgDLkQgy3jtDOFOtVpKLUKD7YNk76kodUj
         6dKjDvO5rqBwGz5ay59GEEDcnPBx5kRXWFswp3AuKmvGa/htzqFWBHpR5FIOpxQgk4Tg
         SrEHgr0qETQFSpz0V0LaK1fqlFOq26zcEjYJFpB7J/qc/jo3aM9sWueMJx9bKaf7HDiB
         nQUw==
X-Forwarded-Encrypted: i=1; AKwUvBwssHPLoSuPnYBVK8eJJdNmXV3b4U1caVpHyGXz52K3v/2gdjI/jtcOLCiPx0fcuyhsDfXkdoI=@vger.kernel.org
X-Gm-Message-State: AFuF++lQIYzXRNpzH41rD6ZkWt2DWOqdDzSHcBfhdCnt8s50fT4XLUy1
	f4HRIP/Naz6rWQP2TCIIND9/OTVQHvmnMSvdzg+57Zt84OVGWW20lRTBRrD7nWXVnqR6sbBFwRV
	U2tHEpRAHsN+cVQ==
X-Received: from qvbea5.prod.google.com ([2002:ad4:58a5:0:b0:912:6174:6df1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5506:b0:910:3453:fc0 with SMTP id 6a1803df08f44-91421dc552fmr19162196d6.16.1790253363913;
 Thu, 24 Sep 2026 05:36:03 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:36:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924123602.1979090-1-edumazet@google.com>
Subject: [PATCH net 0/2] net: fix SO_RESERVE_MEM socket type restriction and
 value bounds
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
  INT_MAX >> 1 in sk_setsockopt(SO_RESERVE_MEM).

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

Eric Dumazet (2):
  net: restrict SO_RESERVE_MEM to TCP sockets and cap max value
  selftests/net: add SO_RESERVE_MEM test

 net/core/sock.c                              |   4 +-
 tools/testing/selftests/net/.gitignore       |   1 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/so_reserve_mem.c | 333 +++++++++++++++++++
 4 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_reserve_mem.c

-- 
2.56.0.rc1.310.g51773c2048-goog

