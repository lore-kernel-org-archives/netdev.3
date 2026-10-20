Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514336;
	b=1WuEXquCh3umeIyKwVPaOnqxBMknnfA8NoKTh3rsB2I/jHFKEqgcvsJvHutE9qmsWtVj
	 bZyCNkAJiXCNTvZ0CJGZATFXtRz3cqarvOTakvD47idNiqp0NFFUPwwFOTTczJaNjMSMM
	 6MQ/mjSJ5fyabgZZGYVZHNgxvKgq/l1P+fg5j2IcJmevxpp5FgL+bbuvPNrvJTxiMi9DS
	 L35r8GRuueuaGfwAS6hngC7abT1GtiFNaJBDDfygvoZkPoFBE04RxvqiJ0Jrz/TmOzdMZ
	 OPvzV3H7CjqhhofxGoD9FRNGsjpLhLAbKH4Iy4nhHVUzQhllChYxvVhZte94wT3w9Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0eL1bMQxR78cjQluECOSoKDJwxenOA4EKKzM001UOl8=;
	b=pNKmDBtVCEW1w1Crqdrf3U9Y5dCKwSGlUBHCKpAw17t5e1Lf7JhQn4Xetirgng60RPlZ
	 W1SHKDh9ZsmEop6Tb4u3XKSjqI4SdvZBHScgBM94ZBqcbB/KO67L4nqWudaLZyCwdBKpz
	 hR40eZlqOSJehGcp+3goavfG1frN8VeKGnFOiYKTvWUfw+bQ0g79x7dxaA3UJlLyXAuev
	 WwelHRYzyrDem+rb/pVzUloE5lAQpvsmJP+m74eWWMnWJiQYJmiotTDGkkMLGg/sUKnZv
	 sVwTXZUfdLnKQPJj8bFXzfJU8IuYm8fRofXiiRpquGD+IARkwyi3m59ipCWYNtI/vXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tavip.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NX0CBQcY;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E0606D508
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C21E0606D508
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NX0CBQcY
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a065e2933fso3042524b3a.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792514335; x=1793119135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eL1bMQxR78cjQluECOSoKDJwxenOA4EKKzM001UOl8=;
        b=NX0CBQcY3P4W0TiwsM82em+iAbBrFoTIezq2Di+lUvkr3lD9sYRCd1jbeU/nSNVJ17
         6wXnIM5GjbFgzDth6MiKPyVeNTJutveDWji2TD+gRs4nKlN5Dp8T/0V0/Z1ZIu1LRiZA
         HKTHDk+rU//DdS4P03msQoec+9qgMVBTKlV/ZT5S1wU3Zhz9L1yUvBYQmC3IOEVrQwFU
         5cpFKdke9R643TfNOlfCe/K3I2HhQgkRTy9bQsMBcRTOnJxd1yCQ4XG8oK30ACYMLDu8
         EtlPhLQVCOgNtgvvVhHqHvirCrQ+J6NpFvZwvYQZn11uCAt0pA7bQ56km0PfLPmgh4gs
         Wihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514335; x=1793119135;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0eL1bMQxR78cjQluECOSoKDJwxenOA4EKKzM001UOl8=;
        b=Vd2u8LBDyhxZsheMAWB/JN7GeS/3fr14CRrzuqWbvTuiaBH0pWmUmw4e2C3yiQajvR
         yS6MbxTUCReasiAMeTUJXO91rxNT70XXzDUqkOT/wxt87R5BDMJoCtU0diw4KZqarkJJ
         ezD3XsH7pnj+YM93H60apUJ7XTtQKvuuDbL3cNIGJ46qFMdHcxEF3Xkjvcld8oHL2dnw
         bQ5N1qvbhfQV+Ol94U6U76n/RkVsLY5ZAku3YLEBpTgSYpKhnJehpvfOrGI6A282n3lX
         kVWCck5jttY4rLCndXclUQJgd+viXUT8KKX+oczd+JIWKo4utdj5aj8U9Q4zioT4Htcg
         aTVw==
X-Forwarded-Encrypted: i=1; AKwUvBxi5vWBvkWITe50qaFhKe208koj0es8uRwwe410IhUza+v0noHIINeuYRbzV3V1/xmU+Mz7bZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHmj+bb5DCDpW8Iuf9ERQkPAS3zpMxxnRas8QorhNJdJ7R3Skw
	Za6HJh5oOkn+HkIZQIfhaQDwlzSzLVE/bmS7l2xRAOg91tjWdvqp3Mg7eX/WgF8B6DHG46EfGFT
	/9A==
X-Received: from pfbdr8.prod.google.com ([2002:a05:6a00:4a88:b0:89f:2041:c861])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1393:b0:892:e080:4ed8
 with SMTP id d2e1a72fcca58-8a04ce526edmr8946515b3a.47.1792514334875; Tue, 20
 Oct 2026 09:38:54 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:38:34 +0000
In-Reply-To: <20261020163835.4076594-1-tavip@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020163835.4076594-1-tavip@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020163835.4076594-2-tavip@google.com>
Subject: [PATCH net v2 1/2] tcp: clamp return value of tcp_wmem_schedule() to non-negative
From: Octavian Purdila <tavip@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Wei Wang <weiwan@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

When sk_wmem_schedule(sk, copy) fails under TCP memory pressure and
sk->sk_wmem_queued already reaches or exceeds sysctl_tcp_wmem[0],
tcp_wmem_schedule() returns min(copy, sk->sk_forward_alloc).

However, sk->sk_forward_alloc is a signed int that can transiently
become negative when tcp_collapse() re-packs partially read or high
payload-to-truesize SKBs in the receive queue and charges newly
allocated SKBs via sk_mem_charge() before freeing the original SKB.

If tcp_wmem_schedule() returns a negative value, tcp_sendmsg_locked()
passes that negative copy length to skb_copy_to_page_nocache() ->
copy_from_iter_full() -> check_copy_size(), where it is converted to an
unsigned size_t > INT_MAX, triggering a WARN_ON_ONCE(bytes > INT_MAX)
in production and returning -EFAULT instead of waiting for memory or
returning -EAGAIN:

  WARNING: CPU: 1 PID: 939331 at include/linux/thread_info.h:249 tcp_sendmsg+0x10c1/0x1530
  Call Trace:
   <TASK>
   __sys_sendmsg+0x292/0x490
   do_syscall_64+0x88/0x340
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Clamp the return value of tcp_wmem_schedule() to [0, copy] so callers
treat negative sk_forward_alloc as 0 available bytes.

Fixes: 849b425cd091 ("tcp: fix possible freeze in tx path under memory pressure")
Assisted-by: LLM
Signed-off-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
v2:
- Add production warning trace to the commit message.

 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 87ef6d5cbfeba..0e062fcd94a6c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1037,7 +1037,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
 	left = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->sk_wmem_queued;
 	if (left > 0)
 		sk_forced_mem_schedule(sk, min(left, copy));
-	return min(copy, sk->sk_forward_alloc);
+	return clamp(sk->sk_forward_alloc, 0, copy);
 }
 
 void tcp_free_fastopen_req(struct tcp_sock *tp)
-- 
2.56.0.212.g129ede20d9-goog

