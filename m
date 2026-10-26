Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984941;
	b=WzdQmuOA9SU0B+IcaZYK937P+C8F+W3DFsuQJ6lMc498yJhH7ElAO1KtinDtCcnmEqqw
	 Fc0TyTaqc6MsT4lM4OL5N24g6Y/l5ObyUIluEuWQLQtIwUT6L34CIihknSgyPZ16XUqNi
	 ssznCymv64gsKKkYKG3GqH6SZOnLJBMqEkMfukAtXXxD4FX6vtZNFiQNUTBNexzup/4gJ
	 uF4MVvaV6bvUL1vkfAMKRQVxy+mZcntyn674eGxde55u22Fx9rDGpCdQ8A4t0htiuqKME
	 q7hibbIDsD2DPMY/6GwKtEG+EqTzHkA/LwHhri/Of1cejgz2UWxIyiWoykOKBCWYmNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QTkGoh7JVetp3qKSKYheTjXfXOD9uDVC36zPXxqDxM0=;
	b=y67wMmVd/shC+o+6RH+GSXfEIDIQRaL/b9IrpaocBmNsivqUrOw4NuUzOvaJW+aPQN0H
	 yaU5o0/c7NrzHe0yXY6Zsbpt4kDeNDwnhbmTEl3cbhU08Y7aqhxi9QrzKjUyXqi2aFnWv
	 vq3/2mDLP9nSNWXn2t53+j8rKhIABMIVRMh9POS5CvElm1shqJLA1jd9IHgjYO5oaFmX8
	 tiqPIFBqhI2nFfI47SgtayWccWKDSHXDvdK7Bsx2LV3SXKl07H8rc1Aj8G1XjfjnYJbMh
	 aOsN/EMCE2dHgAT1j8avWFQTUhoPLqADCpQutdhAg2QI7HH/8hZsum72oeWnothZefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tavip.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CNRxYf9Y;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4D606A326
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C4D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CNRxYf9Y
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso4256970a91.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792984939; x=1793589739; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QTkGoh7JVetp3qKSKYheTjXfXOD9uDVC36zPXxqDxM0=;
        b=CNRxYf9YdRSnf3Rd6rkB+ZGcpteiBCjIHm8g4tOFI6uQbEu8eXSuMShXxZ8i6n3d2n
         u5xumqpg/qTnd8rVBOm4lRqtLcCZIR8wIp8xk2Qu46n7hir5zIV7Kx3wZ0ouUxxhnLHW
         IJNPpRpnxBBLmgXKC83tgL1/iS9tf5Fc1fjXOFc1wg8UFfsZ409s1QBrCX/6rlIzZewU
         nOxAENUQfVeI5EZT9LFyz/WVhxVKCykavzgO0h3+sMIK6HpuVqvw/QUcG9CSva6leN0z
         OSJU+r+p4I5gb+bJF4uKqRIOkZawbQ3/IdDtHlugIzEeRqADRepW02lGiDmZ1mcT6wsE
         zDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984939; x=1793589739;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTkGoh7JVetp3qKSKYheTjXfXOD9uDVC36zPXxqDxM0=;
        b=w+xPyibNqhf+ZLK0zW0OCVYzxRL1sLWs0WlvtGsr//WVvzKXzh+nfX/rM+iWfW6RSO
         NaxFrBFhE3q2EL1d4bML71iISSBlDd4RF5fWyt/AzWge3uR38V3suXBs1F7lpkV0mM0u
         ygQdTz6hDZmLNwwyy3/mP1cCPK6qlwK9S8cVFArsZHfY8GDhllQZ2fEXfLRdUqawsQWC
         KoIPR1UDphdRZiN+4eraUZ9RVKTpAL0bml3mPELBlH9ZgIVgQYSgtEJlw3uyBfVdmQgH
         ckCADuHsosE0c4IPCTEBPBYeTbgwS36IEHKf5oJRyRSzkD/wb+Dlj4XXh3d1IkACoWSL
         qRPQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1GAdAMQ4KR3hRMpDBv/++OBK1ibJD9OyS0oaQ+EQJCKQJa5NyN/o5WnHDvSqtnyN4+gEWvRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvdS2ERtHnEB/QRVK7fyqkDmo68uS2tYoVC4iWg/y69o0DfmaE
	QFYWtLDGnSZf9UFdt/qVmjEIuRrZVdM71YVSAXmHQ329U0OnxU+e8Zz20NfKiUoxvIfh624uET0
	zeg==
X-Received: from pjbml5.prod.google.com ([2002:a17:90b:3605:b0:3a4:b8b3:a08e])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4490:b0:3ac:53e0:4ed5
 with SMTP id 98e67ed59e1d1-3adeafd1e8bmr4604045a91.39.1792984939373; Sun, 25
 Oct 2026 20:22:19 -0700 (PDT)
Date: Mon, 26 Oct 2026 03:22:14 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026032216.1145201-1-tavip@google.com>
Subject: [PATCH net v4 0/2] tcp: clamp return value of tcp_wmem_schedule() to non-negative
From: Octavian Purdila <tavip@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a bug discovered in production in tcp_wmem_schedule()
where a negative sk->sk_forward_alloc under TCP memory pressure causes
tcp_wmem_schedule() to return a negative copy length when
sk->sk_wmem_queued already reaches or exceeds sysctl_tcp_wmem[0].

sk->sk_forward_alloc can transiently become negative when tcp_collapse()
re-packs partially read or high payload-to-truesize SKBs in the receive
queue and charges newly allocated SKBs via sk_mem_charge() before
freeing the original SKBs. When a subsequent send hits memory pressure
in sk_wmem_schedule() with sk->sk_wmem_queued >= sysctl_tcp_wmem[0],
tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc) < 0.
Callers such as tcp_sendmsg_locked() then pass that negative copy length
to skb_copy_to_page_nocache() -> copy_from_iter_full() ->
check_copy_size(), triggering WARN_ON_ONCE(bytes > INT_MAX) in
production and returning -EFAULT instead of waiting for memory or
returning -EAGAIN.

Patch 1 clamps the return value of tcp_wmem_schedule() to [0, copy] so
a negative sk->sk_forward_alloc is treated as 0 available bytes.
Patch 2 adds a packetdrill selftest that reproduces the negative
sk->sk_forward_alloc condition via tcp_collapse() under memory pressure
and verifies that a non-blocking write fails with EAGAIN rather than
EFAULT.

Changes in v4:
- Add --define=REQUIRES_MEMCG="1" support in ksft_runner.sh to skip the
  test when the cgroup2 memory controller is unavailable and clean up
  pkt_* cgroups and cgroup.subtree_control via an EXIT trap.
- Pin packetdrill to CPU 0, write 0 to memory.high twice to guarantee
  local per-CPU memcg stock is drained synchronously, and set
  memory.swap.max=0 in the test cgroup.
- Fix checkpatch warnings (duplicate Signed-off-by trailer and comment
  line length) and preserve the "net" target prefix on all patches.

Changes in v3:
- Fix packetdrill test failure in netdev CI (CONFIG_MAX_SKB_FRAGS=17):
  adjust segment sizes (35 KB) and buffer limits so the receive SKB
  truesize is identical across CONFIG_MAX_SKB_FRAGS=17 and 45, and
  tcp_collapse() deterministically drives sk_forward_alloc below -16 KB
  without invoking the memcg OOM killer.

Changes in v2:
- Include production warning trace in Patch 1 commit message.
- Skip the packetdrill test when PAGE_SIZE != 4096 via
  --define=REQUIRES_PAGESIZE="4096" in ksft_runner.sh.
- Collect Reviewed-by tags from Kuniyuki Iwashima and Eric Dumazet.

Octavian Purdila (2):
  tcp: clamp return value of tcp_wmem_schedule() to non-negative
  selftests: net: packetdrill: add test for negative sk_forward_alloc in
    tcp_wmem_schedule()

 net/ipv4/tcp.c                                |   2 +-
 .../testing/selftests/net/packetdrill/config  |   2 +
 .../selftests/net/packetdrill/ksft_runner.sh  |  28 +++++
 .../tcp_wmem_schedule_negative_fwd_alloc.pkt  | 116 ++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_wmem_schedule_negative_fwd_alloc.pkt

-- 
2.56.0.257.gf7497c7d27-goog

