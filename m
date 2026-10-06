Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF530E82B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314782; cv=none; b=CQinBT7ejGLYCTaPtqqtmZvYPc9K4fNuFQjzIDVJZlT05H+Z4lNLHrU61y1hONgZs4j+zB8ZirEQx11cBG92xxOJ+jDaKF20EWp++Hr2tbWWev7iNwxcIf3oiAOivl6zoZAuXle5W88L8zIlOdEwI9rQ3mRmt3+yoKdlHgrCCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314782; c=relaxed/simple;
	bh=0ddiAADt57iLLZDUZS4hBsoKjvTYltFCCXULN6Kr7yg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XW5lEtAzVOV2jxTiQaH02I0PAcf8AReT5+6mPEBhv75SgIrpLW2i6oeliJr9DdCjW7QX+1aZhF5Wlp1bq2XmgRoPBmZLV3E37jr/lfJd5f1MOo34vU7U0Q5HLgHVxOQS4GhwblVg+4SfzI/juVAF5C7i1/H+zMrxuGeO6xMQwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzHNZQYB; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzHNZQYB"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4a053dcadso3005444a91.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314780; x=1791919580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rxHstJq4l1kRopeoIsWRTHy2+hd1jphJkRKeOHyJag=;
        b=IzHNZQYBvJqfPwIGU68alhvYWuNeTQ52WhEusbZdU8r2IUgzBEjnLo81SqUqlr6LJ2
         5ZccpGJ9Ss4fqP4ubRCJDu534QxDFhrsWxaGKPFyBGk3lAcU0URx8ROcvJUsC3OceIK1
         ZSx4AnSSe9jCxT8VxL0WjXAlu2Cw7aj4J0zmx5zbCNv2YFm2TKfH6YOqME+NnFJZreu+
         r31om5MKYCYIc0PmApXQKJa28WcJ4nbO16khhry4yYC1nigyDhHLfEgzvYoqeJxzfkdf
         j88m/hXKqSMHQHIrlz19/eIJFP+y/IMEbw6UVkv7KZNmh1zUPP09An4jdKvv1povSmFX
         dKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314780; x=1791919580;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8rxHstJq4l1kRopeoIsWRTHy2+hd1jphJkRKeOHyJag=;
        b=rqZbq1lie6THIC3qnu9YlPYtDg4O1H64nUfPYyZIW0EbkRwlxA6fbofD6lyeYLHSYN
         Sw5rTmTcR+oNGbiZH4HmhUJVCOIU2aklupYZ2v74gQaNQflho4g/40cNmN8SEFGg5Gyv
         EN9ZxI1LGbOopErqufjkXaJRL5Z4o0M0w4KJ58KbveQgVUECwR4WS5iwhQrihAWc/Ejm
         xipTqcczJcxDJ3WnBRKLgARsBfOcxED/SAxXQQz8e2sRf4ZSL5KYHRFOQjMfrfbrs5NV
         fb41SIr+y4B8UK0vQmNN6rWsRo/ta5gYIsZZ2zepGgffljALEX4hnaqt1zOiVii3Brx7
         ZRnA==
X-Forwarded-Encrypted: i=1; AKwUvBxoVYwKgJP/zHFTSKD2BJBCCqQE237r5xCgw8bYtvso7biNcD+OVgL78MNZiuJ3dG9zsi/iw6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcs4uqUNmBVeSV1iV5cAif09ntQDihVn1QAdz2VkvvUekrmF1Q
	ycbAiyOwiKQ/l4g1HgF2pBkmGsI+VxQ6RGwrAv2ns3KFX1PghyC+f/+tVZsNtjzc+HN21BIwF3n
	9XuRddg==
X-Received: from pgcv5.prod.google.com ([2002:a05:6a02:5305:b0:cc7:8504:4675])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37d0:b0:3a8:5cab:1009
 with SMTP id 98e67ed59e1d1-3a8a0f4699bmr163039a91.46.1791314780141; Tue, 06
 Oct 2026 12:26:20 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-1-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 00/10] bpf: Add bpf_tcp_ops hooks for TCP AutoLOWAT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series introduces two callbacks for bpf_tcp_ops:

  .enqueue_rcvq(): invoked when TCP stack enqueues skb to
                   sk->sk_receive_queue

  .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
                   is dequeued from sk->sk_receive_queue

Those callbacks can be enabled on a per-socket basis by
a new kfunc bpf_tcp_ops_set_flags():

  bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
                        BPF_TCP_OPS_FLAG_RCVQ, 0);

This allows the BPF prog to dynamically adjust sk->sk_rcvlowat,
suppressing unnecessary EPOLLIN wakeups until sufficient data
is available in the receive queue.

This functionality, which we call "TCP AutoLOWAT", was originally
developed in 2020 by Tenzin Ukyab with the help of Soheil Hassas
Yeganeh, Arjun Roy, and Eric Dumazet.  It has served Google RPC
workloads for more than 5 years.

Combined with TCP RX zerocopy, this typically allows us to read an
entire RPC frame with just a single wakeup and a single system call.

While the original implementation was specialised for our
internal RPC format, this series introduces a more flexible
version by leveraging BPF.

The bpf prog in the last selftest patch closely mirrors the core
logic of the original implementation to provide a real-world
example.

Note that the new callbacks are not supported on legacy SOCK_OPS.


Changes:
  v4:
    * Patch 2
      * Allow-listed BPF_PROG_TYPE_CGROUP_SOCKOPT and _SKB
        in bpf_tcp_ops_set_flags_kfunc_filter()
      * Add doc for flag enum and bpf_tcp_ops members
    * Patch 4
      * Check static key first and then flags
    * Patch 5 (new)
      * Bubble up static key check for SOCK_OPS similar to bpf_tcp_ops
    * Patch 6
      * Use bpf_tcp_ops_call_flag()

  v3: https://lore.kernel.org/bpf/20261005154533.4147685-1-kuniyu@google.com/
    * Add patch 2 ~ 4 (guard bpf_tcp_ops w/ a new flag)
    * Patch 5 & 9 : Adapt to a new flag and kfunc

  v2: https://lore.kernel.org/netdev/20260923213719.224838-1-kuniyu@google.com/
    * Add patch 1 not to allow setsockopt() from new callbacks
    * Patch 8 (selftest)
      * Avoid address comparison for a specific version of gcc.
      * Make rpc_test_cases[] static.
      * Update comment in rpc_test_case[].

  v1: https://lore.kernel.org/bpf/20260920195633.3033620-1-kuniyu@google.com/

Legacy SOCK_OPS version:
  v3: https://lore.kernel.org/bpf/20260523083001.2911931-1-kuniyu@google.com/
  v2: https://lore.kernel.org/bpf/20260522074601.1658705-1-kuniyu@google.com/
  v1: https://lore.kernel.org/bpf/20260508073355.3916746-1-kuniyu@google.com/


Kuniyuki Iwashima (10):
  bpf: tcp: Convert deny-list for bpf_{get,set}sockopt() to allow-list.
  bpf: tcp: Add a new per-socket flag and kfunc for bpf_tcp_ops.
  selftest: bpf: Use bpf_tcp_ops_set_flags() in bpf_tcp_ops_hdr.c.
  bpf: tcp: Guard fast-path bpf_tcp_ops_call() under per-socket flag.
  bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG() after
    cgroup_bpf_enabled(CGROUP_SOCK_OPS).
  bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
  tcp: Split out __tcp_set_rcvlowat().
  bpf: mptcp: Don't support BPF_TCP_OPS_FLAG_RCVQ.
  bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
  selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().

 .../networking/net_cachelines/tcp_sock.rst    |   1 +
 include/linux/bpf-cgroup.h                    |  36 +-
 include/linux/tcp.h                           |   7 +
 include/net/tcp.h                             | 122 +++---
 include/uapi/linux/bpf.h                      |  25 ++
 net/ipv4/af_inet.c                            |   2 +-
 net/ipv4/bpf_tcp_ops.c                        | 159 +++++++-
 net/ipv4/tcp.c                                |  20 +-
 net/ipv4/tcp_fastopen.c                       |   2 +
 net/ipv4/tcp_input.c                          |  37 +-
 net/ipv4/tcp_nv.c                             |   2 +-
 net/ipv4/tcp_output.c                         |  61 ++-
 net/ipv4/tcp_timer.c                          |   6 +-
 tools/include/uapi/linux/bpf.h                |  25 ++
 .../selftests/bpf/prog_tests/tcp_autolowat.c  | 350 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  20 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   2 +
 .../selftests/bpf/progs/tcp_autolowat.c       | 294 +++++++++++++++
 18 files changed, 1033 insertions(+), 138 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_autolowat.c

-- 
2.56.0.360.g66cac248cb-goog

