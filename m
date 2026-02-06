Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FF425CD0
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399285; cv=none; b=X2q0pnjBoLmPnyfyuKnbAhd5YL1dNpvcDvGuDghyL2CJwmBBVaBTN58qS83+JgLSBo8jtJ1OI/PUv0ZiV1GOIcCFvrYoD7O2yzFSsXaVYjqE+wDltzMVazqM9P10ZL3LiGdUCxKxLnYs4NjGsY8IEBlAzSJO/hR++J9LQvhy/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399285; c=relaxed/simple;
	bh=e/4VRMswnbHVHbY6NBIGBfvj1UzmdH/lGRaQCNzSQ9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cBSXxjahyxoTFiJTkhwjJRGcAHDcIr/W9Ha6Hn16kzAyNPouNp/V5YWlA5eE8Oh+ioh/DhK/I2dx4fD7GTX+3urKwRAsULPj+tIkNJz7jiG8TklD0duUl5CvStmnPB12Ar+boEfO0r1N1RO7gHhF4Fudsc6I4NGOOKd6oi95uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xk3PlAwY; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xk3PlAwY"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-502a8fa0a28so46051411cf.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399284; x=1771004084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gZAJXima9yvxaj0x2/I7pJ4bzdcaXBi20T8Kj130+0=;
        b=Xk3PlAwYyBrRqvBdiLlS54Qb6OhrZltFxIMq2zGMX3JZquOXIm/AJNOP8+l3e3fz4q
         IOMyTq4raabEnIsykA5kb4WoHLWTyGnD+9FZiKT8mynEbOWjpMGUCo6evjs+iBnRQUA7
         DHQPEW/IfA+FjeWQBsYMpdkeHYBxmwxvouDp7Bov2Wsx5zMWDlndaezArnzbnagC89Yr
         FIRvx3aYAdpxuyKxRKtcGso9uKllEfdUlDMsOJ/pokqnV9O2wlKcphUhKtdtqbwufM95
         A1BTT61+MeSy67x2bJ5vsB6Ma3ioaIvX2jjjPSa9kSWEGnQg93Oh/0xTXVnBmELlQj82
         8LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399284; x=1771004084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gZAJXima9yvxaj0x2/I7pJ4bzdcaXBi20T8Kj130+0=;
        b=PyxBaJZLp1feqZpCwmZmzDdGKzRfbNlCSUUDHd2FqhaNBqOuY3OKfmqteY8BM/V2Zg
         jnwvjE/ghuqGeEvQHIHerFyaX1nPeJzpXA4vgJKatUJzB++Fk5iyp4phJC9IYUhk5rcZ
         grIwTRgkKX0X05SBIZjTJhPikwC1xrkZ5E9k7tftfLssiTA4IBt6ZTzj/UQL78fKWUqG
         b2bA3QpZpZ/OdnMN9qf4ZfdMEKWfzjUtN86IPWsh2nk5eWCUr1Meiu5WAijpe2576uDF
         XEPZ03iJNB8eLWv4n6PYWDD1LqYbVbfV0L/TRPT1RDtFQhuK2Qq3QO0rkc3Fk8FwOKJR
         ox7w==
X-Forwarded-Encrypted: i=1; AJvYcCU7OkCFJIaE5nYNzZ4thKgZnuZVSSVxj+qWvHXf9S8QBGxz56ATauWXbzSBS7v94rm+2H1MfYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEu+YO4VbkoBMhQvX5qhvGb7bU7eFjzXfEcrJfa6DPMSO4yAl
	fBYsDCxoIamsc/LPlfkPi34zCxzxirG0ySfK11BKqztfcaRdfzeo+1NtBRGTfq2Qv6Ecd+ZXXj2
	Q3vSPYaucyQp3ug==
X-Received: from qtc12.prod.google.com ([2002:a05:622a:8e0c:b0:501:42ca:45fa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5903:0:b0:501:3b8c:7d58 with SMTP id d75a77b69052e-50639846b60mr42345111cf.7.1770399283726;
 Fri, 06 Feb 2026 09:34:43 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:20 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-2-edumazet@google.com>
Subject: [PATCH net-next 1/7] ipv6: add daddr/final storage in struct ipv6_pinfo
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After commit b409a7f7176b ("ipv6: colocate inet6_cork in
inet_cork_full") we have room in ipv6_pinfo to hold daddr/final
in case they need to be populated in fl6_update_dst() calls.

This will allow stack canary removal in IPv6 tx fast paths.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 20aae8357dd151e8c7d6972f41e77cebf1379177..75b98d4849d66b167376769a25bb752d8979c8b5 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -209,6 +209,10 @@ struct ipv6_fl_socklist;
 struct ipv6_pinfo {
 	/* Used in tx path (inet6_csk_route_socket(), ip6_xmit()) */
 	struct in6_addr 	saddr;
+	union {
+		struct in6_addr daddr;
+		struct in6_addr final;
+	};
 	__be32			flow_label;
 	u32			dst_cookie;
 	struct ipv6_txoptions __rcu	*opt;
-- 
2.53.0.rc2.204.g2597b5adb4-goog

