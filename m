Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214503;
	b=umMPIzB27v/fgmK/Z4lUBLfBJUjZ6kDO3OxMQxwfHdYkDIkZEHrlC/IyzMZAeclrsX8d
	 BUyLiu39v5toqdijNKrU3crky/RE4EyIWH0KC0j4hYkXvpgIdd0Rp+wRtewgKHdiA/B8S
	 AcaRcpT7u1jABX6jAF8jOhedEJQEEsOcZelDgEtADrdisaR5MWtijKyewsosJ0FYrEubb
	 RleZKnYKOe4kJrSiyt7YtBSUifAi18mf4Fgsg1N/NZZPVH3msgXZ2UV3iEAwNLUNd5ydI
	 HQHbfzKcUenH31fO36lo4V7y8mKugNOHHXG8Rn6FpTwvdhquCdJJnqqmHtmcfzP+hpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jzDOXq8MR2vkQ4lcGklcbbk5AhXVULHhAAztX3EIiQ8=;
	b=4RDl84LOYuzWR9c6uenUUWs88+q5LzpBvKz/Js2Q2LyFxccHShyiN06glP4q4oY/C9vr
	 hF+D4zHvuZAI5nor+28UjB5LO3feC4YFTfWbRu8K+oy69Ogc5utFC7g8c+GvABPQDi1mW
	 dlFO2GImQtsY8lqZaAsIl5JYllkOlzFZ8RKfrvDg+lrwfotA3yU2nQDk/mBXb8gcX1lMG
	 eVsyKQdkARBygClJ+z72EKRR7QlE7cioS2S7ZD2OC5YZZY7wl3uAAOmCJyy7ABqXfAl6Y
	 dJMp838brjfa71EjfCowADfjINBHujhl7YVzWz0yqnjGpZBV61FA39tcNg0t3s3tEAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tavip.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jOhYMfNI;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB67606A32A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 19:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CB67606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jOhYMfNI
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb92868263so694692a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214503; x=1793819303; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jzDOXq8MR2vkQ4lcGklcbbk5AhXVULHhAAztX3EIiQ8=;
        b=jOhYMfNIba6AMwBP6kSXlc8ZY9X7Ii1oYRAJDmn6g7UM4LubFr0oDXIP+z90wIHj0N
         krDYYVUPxriZXdC91jjYHhZwfqWYH6fyCMSEElwQPgaUpf5hoCxocsWsgDRHkrT6HTfI
         x28/yiR8yuG43R0zcNzj+XSuvdL7iCsWgBTudSgfegwLxSlj1EVLmymtymeXn3xC0E2g
         C4+OQZAnwWB8fU22RmUzwbqSIC6vrERVZKkJabYEEsFP3NXqTZeqU8ik9R0BV/F/3BdT
         QlJ/mg+DvRMDP9jTesf0UmYIRqP6B+CZTspWNXuckUMYn4UUPDyUWdfjW9Dc+1dBkmlQ
         f8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214503; x=1793819303;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzDOXq8MR2vkQ4lcGklcbbk5AhXVULHhAAztX3EIiQ8=;
        b=gQYHzRiBU1yN54A/67nbRivvW6vqEJnHM+Ldh43L2jEzspi1ZOMWvJF/mhn3w3Wjx2
         gIfIWo8BCQwR6iwxpI22BWOd5HjLfE13OPGcPoV1NCPwaAUNGZJKHYn0g8toKuAnIs/f
         uJ/zAH2YLDM+oYCKPOgHQs7Be2aax7LgZMpU45dn+wZ8K/6g9NVv1QWksvDoFMPV1KxE
         2qxaqFvbWlfcsF45qXIiooPmxZz+oqUkIcnvXWyeD0MtjDeFCyyEsPG01XBpPi7MQ795
         WNGweaVg2pe+4T+lE5L7lL0XWia8t5P2nYhbbgE3IqQqUPfze8ZC2t2GB6YJ07xr49FG
         C7Yg==
X-Forwarded-Encrypted: i=1; AKwUvBw+BYKHc7UzT1/zabjFiHY+R5xAVwbp49ftODhhdauwzPvCvBNcfNWLFMb0JrYf8kn4COtKXX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCbSnn0RSNR7LEXyRXplIYGPdiIftQQM5EmmLlja3rw9irBjWv
	py6IybaF5pUOuSQ/jFOIAncqREfe6ftEmum6mvQQPZQIiMqa5SnrZfK9d2TF5gCKcs7nntbRxGe
	9Vg==
X-Received: from pjzc18.prod.google.com ([2002:a17:90a:e112:b0:3ac:4c80:15de])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b85:b0:3ac:80dc:f409
 with SMTP id 98e67ed59e1d1-3ae5823c699mr2202916a91.61.1793214502613; Wed, 28
 Oct 2026 12:08:22 -0700 (PDT)
Date: Wed, 28 Oct 2026 19:08:20 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190820.2917252-1-tavip@google.com>
Subject: [PATCH net v5] tcp: do not let tcp_collapse() drive sk_forward_alloc negative
From: Octavian Purdila <tavip@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Eric Dumazet <edumazet@kernel.org>

tcp_collapse() charges each newly allocated skb with skb_set_owner_r()
before the skbs it replaces are freed, without scheduling memory first.

Since sk_mem_uncharge() reclaims eagerly, sk->sk_forward_alloc has no
cushion and can become negative. This can be durable when the collapsed
skbs had a high payload/truesize ratio or were partially read, because
the new skbs can have a bigger total truesize than the old ones.

A negative sk_forward_alloc then confuses tcp_wmem_schedule(), which
can return a negative length to tcp_sendmsg_locked(), triggering
a WARN_ON_ONCE(bytes > INT_MAX) in check_copy_size().

Call sk_forced_mem_schedule() before charging nskb.

Fixes: 4890b686f408 ("net: keep sk->sk_forward_alloc as small as possible")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
Changes in v5:
- Replace clamping in tcp_wmem_schedule() with Eric's patch calling
  sk_forced_mem_schedule(sk, nskb->truesize) in tcp_collapse() so
  sk_forward_alloc cannot become negative in the first place and the TX
  fast path is untouched.
- Defer the packetdrill selftest to net-next alongside the upcoming
  broader tcp_collapse() improvements.
- Link to v4: https://lore.kernel.org/netdev/20261026032216.1145201-1-tavip@google.com/

 net/ipv4/tcp_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd8..24d5f016a4eb6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5846,6 +5846,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 			__skb_queue_before(list, skb, nskb);
 		else
 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
+		/* nskb is charged before the skbs it replaces are freed.
+		 * Make sure sk->sk_forward_alloc can not become negative.
+		 */
+		sk_forced_mem_schedule(sk, nskb->truesize);
 		skb_set_owner_r(nskb, sk);
 		mptcp_skb_ext_move(nskb, skb);
 
-- 
2.56.0.313.g2479322e68-goog

