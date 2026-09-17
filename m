Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDF39DBD4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672558; cv=none; b=nJNx63eeFmKOZ/kD0QlAZqDOwv5guQbCiye7KouuC2G80rk9nFIKuggXwburqADJG063Q6R0ywI0Rsmy1lAnQOjtWc/YUJGNaAkhAbQwCuwzYpjJjJhZ+WhtYitT/sPG87WoaLS4ZNhKO5avqYSfyRmulFmweFJO/4XPwj8F5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672558; c=relaxed/simple;
	bh=IhpYp9bSD9+qcUWdk7OxxcwkjkDt/T2GPtPd1Y6rWt8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UYWQYfyf+cN9vIl3LmJr+U5g7mdcbTU+AoDCmh9ASAHKI2Z8/udmypfQ+mF29B547zYR4F3klM10tkWLhgl1DZBHErqPOwMvd7m32k/EcDHWBy+ktLBXRXNrYf4aSa6RszO7U/WFBP4fef6Dodhy+hzyAjwjEUV+v4s50fjqL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnsdd8i5; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnsdd8i5"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1a439db36so1054152a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789672556; x=1790277356; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qCo3Yxfb1GBbpyMMD1mPaT+L/Vwg6/7E5KU2l5EPNws=;
        b=nnsdd8i5Tiw8YWFeTtLY4HnBI1gk82fL5UCmVQ0zrqln1BapP0M4yhXxzIZsKWFRJS
         kCRql0taQy0B6ibA+DXeELR5S3705fZjMcrSiujtpFEOqWzHNN1CS8fdEGIfa+8rpOb1
         b4TXrCdaLoJoIIQL05JrxUs5ixA4Rv+PTLwyaCEFq1g4/GFMW5l7pT3rJWBmAFop2htn
         H/UcNUGx0SIelbXTfoQq/omzHgYWvGD/GrTKXc77B0Fp+F+MoFlf9xvTyUDoxgwyENby
         kWhBJS/z6XYzugaf2HbKgXFmd/5tdsl/UnskLJb9+TBSFrlp+zL/NDfXW4Fbyn5y4EQA
         hBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672556; x=1790277356;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCo3Yxfb1GBbpyMMD1mPaT+L/Vwg6/7E5KU2l5EPNws=;
        b=xFYoOoU5rz29oosfWxcZznCVG2tKTf8yGwL2GX66qaOTsKDk8u/P2mkXKeo2zYgVYl
         gnDJIuVDWh4W5oH4WbD+eKS0KU6DyC9eJEdzcTEp5p8XmyZOaQzKZwR6pudGuh7gWBCt
         bLGeUUTLNHTDqbw9MlQG5FjYjzdE1cY3wJ2llti+fV8EJ1wvNSicn1C0zw3uY5CQ0atD
         Uqi/IOikgEHZ9Ir5z3scQdkP+vOb+aVXH3PNX33hIMEvbNHcHJBB89uHoqrbOy3EHGHh
         5BYPYUMpYbh07GhBCbJkOjFefX1jsm9tPpmxd+V41F7NnLUcqwom4kKF06yVTFxFD04t
         vUDg==
X-Forwarded-Encrypted: i=1; AKwUvBzX5WnSSt/Tzd63u/vASfqqjwADUShMQ4xH1xbNpySbitdFiByKg0YezXfk/NE/CfAJVW8PCpk=@vger.kernel.org
X-Gm-Message-State: AFuF++liCX/MSjTJiokf7HqpX9kbD9Cq+J6m2B5UzXweiy1GZBRNk8m5
	B3r5VpoSSiKL1LX5FE8wjVpPOPYu4C7vxiol4HoJ8Z/ycdTRl+4IkN2TyW7gJUj7VC6aEq+uC/e
	zs5Sa2A==
X-Received: from pgah2.prod.google.com ([2002:a05:6a02:4e82:b0:cbe:e0a7:536b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430e:b0:3d1:66cb:d49
 with SMTP id adf61e73a8af0-3dd5f4066femr19236190637.4.1789672556163; Thu, 17
 Sep 2026 12:15:56 -0700 (PDT)
Date: Thu, 17 Sep 2026 19:15:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917191554.1600494-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] tcp: Set unhashed_state in inet_twsk_hashdance_schedule().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Daniel Zahka <daniel.zahka@gmail.com>
Content-Type: text/plain; charset="UTF-8"

inet_unhash() sets inet_csk(sk)->unhashed_state only when the
socket is hashed because tcp_set_state(sk, TCP_CLOSE) could be
called multiple times, e.g. tcp_abort() calls it directly and
tcp_done_with_error().

However, inet_twsk_hashdance_schedule() also unhashes a socket
when replacing it with twsk, allowing the socket to bypass
checks for inet_csk(sk)->unhashed_state.

Let's update inet_csk(sk)->unhashed_state there as well.

Fixes: 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash and lhash2.")
Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
Closes: https://lore.kernel.org/netdev/DLHLRA8GVI5B.2Q1IRQG5BVJNZ@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_timewait_sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index d4c781a0667f..a1d86026aefb 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -105,10 +105,12 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 				  struct inet_hashinfo *hashinfo,
 				  int timeo)
 {
-	const struct inet_sock *inet = inet_sk(sk);
-	const struct inet_connection_sock *icsk = inet_csk(sk);
 	spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_bind_hashbucket *bhead, *bhead2;
+	const struct inet_sock *inet = inet_sk(sk);
+
+	icsk->unhashed_state = sk->sk_state;
 
 	/* Put TW into bind hash. Original socket stays there too.
 	 * Note, that any socket with inet->num != 0 MUST be bound in
-- 
2.55.0.1082.g2b9226bbc0-goog

