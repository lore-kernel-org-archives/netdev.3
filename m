Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153A3D1AA6
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808432; cv=none; b=K6+48Px+yqwjRYiwwnakj9NiVQeMTLGrRS2YkG1ddDjVb03svW/3jOCf6zIcE1WtR+RhjJx38fniLph+AuiV+kLmkjDGVfhJGSN7yo6QpRrOCrO1OCdq6sPpROXEp00CXpyAOf0RSMztVF41DyJ4Pz4kCjCsQ47NEQOJeEYgdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808432; c=relaxed/simple;
	bh=aylluD51P2Wrdz9dogQ77g2sC8WgL3RiFSAVF94tdcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LB2OT38xKTS+YtE6t/SG1iyGa6EaFkZcWj7wRDWSwJOMOi9SEj5DdZAX7YGSx5XW38mJnKD7mdGxH4HbEo4es2JwPPWLgegxRDUW7RTL4RIab4Q+jqjxsCzi9ScpUf2zVGVK2evPmSQaz/hFMFLIJs7p2ew+UYprgE68/FQtnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM9NHYev; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM9NHYev"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so4565367a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785808430; x=1786413230; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+VyZbeF6Erw90/eJFcWa9LCzygR3DxTYQLIK4Oru0X8=;
        b=hM9NHYevWBGL+F21B0e9aUgjzuMB+U2uOXUqbA52AN1o5UHwf4uvFxcm0ZaaMs7Smy
         9UHZLR1UljSzSyY12IRaSAKw/wR3lvC+T5+rtyA6VqzA2KMWdAO5BFXLIoP1cSpYihYE
         fWuOtmI50Crrl+2DmYD9h5xlZt88IWzdd/mFM77eJqb2tsTh9IEjM+DP/QeddCVBmdWu
         +og170MjsJMxS5D2anuBE3nVJDo8n7b/QYN7plRanEWglZ3ZqROzZoGIgW0NeWzvjZcg
         uTo/T/2q4vFdKUV0z1yarlb21dxVVKcrP+LZBwD3hpl07EqBmK8flL4UoYitx+ZDZb/f
         HyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785808430; x=1786413230;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+VyZbeF6Erw90/eJFcWa9LCzygR3DxTYQLIK4Oru0X8=;
        b=NUEn65d/nsXo7/gECFC1ozb6aduL0yUaRQ9IWpWaA59hjj5D1kBTt+b8qIr4vMhv52
         /tve4GhcrIVqkOLleWgwtcp3X1rt41sKFP2WYMcbmyscxrWBBtyMcSRnRRZnAnnV6Jqz
         AguqAjTNAx3ULYRoMdyLo0RHQa3CClZHbkH7tXJXROW5EbzOs6zlAu+/MUsj5/5lQeOk
         NWYoDpvqXjiKgNQ/ijobEf3g/wXg7kwBc48LBLsrq7+sLV12ttfZk9iJbS8U5CBXdw9j
         oulpT+p6+D3YHu25984QUlJGBJWGDGK3QlR8mxP1TU8Gb3LKugm0mn7wza88lJi385y1
         cUSA==
X-Forwarded-Encrypted: i=1; AHgh+RoUghsjhqoxuvoJGPmj+adRQsxrBjxAu1pobHXfDh3VH76+SgwYc0Bu1Syl18d8LhayEIwFdPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhR/D00XpspFYR9R9LmjQvJ2Q9sjj9UHFp9Php4XuOK31nEybD
	mh+Mrnm2WbPrwcL81sPnmO/6eTU3l6jw6mmt4SlBTkRKyIeG/QHxonEQr8NlpHKf96KHkC0R7Oi
	x50kxpA==
X-Received: from pjbct3.prod.google.com ([2002:a17:90a:f583:b0:380:58c5:c2e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d004:b0:380:f389:447b
 with SMTP id 98e67ed59e1d1-38fbc422ab5mr11863013a91.11.1785808430311; Mon, 03
 Aug 2026 18:53:50 -0700 (PDT)
Date: Tue,  4 Aug 2026 01:53:16 +0000
In-Reply-To: <20260731140512.566464-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731140512.566464-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804015349.2353056-1-kuniyu@google.com>
Subject: Re: [PATCH] net: inet: prevent lhash2 lookups from escaping into ehash
From: Kuniyuki Iwashima <kuniyu@google.com>
To: david.lee@trailofbits.com
Cc: davem@davemloft.net, dominik.czarnota@trailofbits.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, kylebot@openai.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: David Lee <david.lee@trailofbits.com>
Date: Fri, 31 Jul 2026 14:05:12 +0000
> The lhash2 and ehash tables share sk_nulls_node. When a listening
> socket is unhashed and rehashed as a connected socket

This is only fuzzing scenario, and there is another series trying
to address the same class of issue by touching the fast path as well.

https://lore.kernel.org/netdev/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/


> while an RCU
> listener lookup is walking it, the reader can follow the node's new
> next pointer into ehash. inet_lhash2_lookup() and
> inet6_lhash2_lookup() do not validate the terminal nulls marker, so
> they can return an ehash entry under the listener lookup's
> unreferenced ownership contract.
> 
> In particular, returning a TIME_WAIT socket makes the TCP receive
> path consume a reference that the lookup never acquired. Repeated
> races can free the object while it remains linked in the hash tables.
> 
> Skip non-listening sockets before scoring them. Also restart the walk
> when its terminal nulls marker does not match the expected lhash2 slot,
> as the established lookup already does.
> 
> Fixes: cae3873c5b3a ("net: inet: Retire port only listening_hash")
> Bug found and triaged by OpenAI Security Research and 
> validated by Trail of Bits.
> 
> Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN use-after-free and can share if needed.

Can you test this diff ?

---8<---
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 433c2df23076..903499581db7 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -94,6 +94,7 @@ struct inet_connection_sock {
 	u32			  icsk_rto_max;
 	__u32                     icsk_delack_max;
 	__u32			  icsk_pmtu_cookie;
+	unsigned char		  unhashed_state;
 	const struct tcp_congestion_ops *icsk_ca_ops;
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb..3ed8d5833c3b 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -803,6 +803,14 @@ int inet_hash(struct sock *sk)
 	inet_init_ehash_secret();
 
 	WARN_ON(!sk_unhashed(sk));
+
+	if (unlikely(inet_csk(sk)->unhashed_state)) {
+		if (inet_csk(sk)->unhashed_state != TCP_LISTEN)
+			synchronize_rcu();
+
+		inet_csk(sk)->unhashed_state = 0;
+	}
+
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
 	spin_lock(&ilb2->lock);
@@ -832,6 +840,9 @@ void inet_unhash(struct sock *sk)
 		return;
 
 	sock_rps_delete_flow(sk);
+
+	inet_csk(sk)->unhashed_state = sk->sk_state;
+
 	if (sk->sk_state == TCP_LISTEN) {
 		struct inet_listen_hashbucket *ilb2;
 
@@ -1058,6 +1069,13 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	int ret, i, low, high;
 	bool local_ports;
 
+	if (unlikely(inet_csk(sk)->unhashed_state)) {
+		if (inet_csk(sk)->unhashed_state == TCP_LISTEN)
+			synchronize_rcu();
+
+		inet_csk(sk)->unhashed_state = 0;
+	}
+
 	if (port) {
 		local_bh_disable();
 		ret = check_established(death_row, sk, port, NULL, false,
---8<---
