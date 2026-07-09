Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607D2DA75C
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622001; cv=none; b=G2h0e/P9YO0ua9Am5GxUPuVs+JEdwb1Ttw6Pz18sIcDjByR8DREZB3h7YT2bRkLk21WiymmmRBHG0bSpS8qNmkHe/UhX64BVnDjb3+N2lQRhYLv998yJwM9rAKpFEHMkjzdY4lsNlmkOZHGdnQEJ+H8jFbVNeK1W7RrPlSywdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622001; c=relaxed/simple;
	bh=K77ZvXosWhpfZJc8CVqziL0mP9QJYTlnfvTwkj5NbI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y4Qy01jDCbfeylKRCSl7KDw71PRPLIGI117HS4emZYM5Tq2QMAt84MDnR3CJvz8TfUGZLZS/YtA95McOTSDyCYUQvm35r2jWoTTSahaHxj5ETAUuQE8QE2rysqQvF2VUHevbIVNeMAYf+bvn4eoV8buh5/zwPSvyf90FJDXd/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYxxrG3B; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYxxrG3B"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccafc5e82cso521575ad.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783622000; x=1784226800; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmKso++HvKQHDYCZgoX+5AL7yIbCGvaGv0WQW8KfzkI=;
        b=ZYxxrG3BMC5qadvBLyz4Y7DTiZ2TdMjdCFxqqCF59FgarBru6t2Rc9giPXG9dpbw9p
         ofK/L5SMsB/HeKi5S73By34WXBXRPv0BJSjLLHqGkfyUT1nWVwMIfOMFKEYj+Yf7rFKT
         O6ykwvL1MEOnLiByXB3pL1KoQs6JLZLzepkUbKNGHbeupzc1FNPQ3eum6QcgF9WfDDCz
         CqkfsFUcesWxOPo13utxbdrLkLjgkOWs0unrEPO4aLmxSxrlsTuIqMs93enmzCeNym+Z
         3ePs6GkXE76EFJa2O3w6WuuNPUtaso/LvQTqqUFkRmdXMkh9oSg+zL8M4nNQoMnLew6u
         VTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622000; x=1784226800;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmKso++HvKQHDYCZgoX+5AL7yIbCGvaGv0WQW8KfzkI=;
        b=hFBU9BJVkgBip+CUvyf1o1Any21vMMAo/Zermfv8zbsrEEp5R9g1gUGWp+htQU0/mT
         P2nRel4ft5aFlsQFdhRmUkOyn9n5E7jGab74YmTE9J0FDM41OF7uLUFi6k8CBVVYXgsG
         voOhqTQWyv0NxHRuWSDHmxu5xmU/jNxKR7iBokUCXLCuk2sSp7fyi0p+Ef2fdiJB/0hY
         WCmpOC/MtoVQ37kmlyIuUteiuROvjD3NWEElxtVc2VX5QPwF9JLaD6R3hz96DM6NvNEX
         xq8+CRnbVy6GaX/hgt/7UcKbIOHzupsVFEgNcKOSFKluYo1K1p+Y1CzQ8BPy0/m7Pnrm
         Flig==
X-Forwarded-Encrypted: i=1; AHgh+RrwoTtm+eEcmqTHi/bWEzMw93eNJeHa3a2dh6qa1XsTSpMA+p/W6zV9zsrbzM/g/zYOl/eGkNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPn2epqWXwc1GH552Nfb1iOw+Ti2cvzix1EgSU6tpEJL2+iErh
	P+GkvznqonvHgKSfY1nnbyVrBxJFp20ElFTQScaVG18gZM3fws8cPW8HM512jqtCp3jVM/mmABf
	cs4zysw==
X-Received: from pgbfm1.prod.google.com ([2002:a05:6a02:4981:b0:c9e:4cb:83a3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d08:b0:3a2:d79c:416c
 with SMTP id adf61e73a8af0-3c0bc9bb080mr10134172637.32.1783621999711; Thu, 09
 Jul 2026 11:33:19 -0700 (PDT)
Date: Thu,  9 Jul 2026 18:31:40 +0000
In-Reply-To: <20260709183315.965751-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709183315.965751-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709183315.965751-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] net: Call net_enable_timestamp() before failure in sk_clone().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Octavian Purdila <tavip@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When sk_clone() fails, sk_destruct() is called for the new socket.

If the parent socket has SK_FLAGS_TIMESTAMP in sk->sk_flags,
net_disable_timestamp() is called for the child socket even though
net_enable_timestamp() is not called for it.

Let's call net_enable_timestamp() before any failure path in
sk_clone().

Fixes: 704da560c0a0 ("tcp: update the netstamp_needed counter when cloning sockets")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260709032007.9E4D61F000E9@smtp.kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index fc3ff0552d68..504d82a3aacd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2546,6 +2546,9 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
 
+	if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
+		net_enable_timestamp();
+
 	rcu_read_lock();
 	filter = rcu_dereference(sk->sk_filter);
 	if (filter != NULL)
@@ -2595,9 +2598,6 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	if (newsk->sk_prot->sockets_allocated)
 		sk_sockets_allocated_inc(newsk);
-
-	if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
-		net_enable_timestamp();
 out:
 	return newsk;
 free:
-- 
2.55.0.795.g602f6c329a-goog

