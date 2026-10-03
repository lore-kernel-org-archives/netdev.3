Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CF49BD87
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062629; cv=none; b=q7QKskpWZzKWz7qDAW/BEBI56DBRh+gPssSVDHezUVTXMavNPAdpDjjim+JIwi0IOrsAiUwIyh9AY/lRMZ45OJjcsEnHLagA338kDpbn5ChLKfqLJR2yFguAMaJb/HG5tK91MPNENozoIKZzyS2LxeSv9MQl9bDOnyMMFTrd15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062629; c=relaxed/simple;
	bh=aErxxCmM4GcghQQWlr8ToqF6k8a8J4gCRtzPWWqkpIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NjUwEAKZPZOiR5Ld79OFSfv8HGa7Dzgb62Cne/o/5TFzPlhNEahYatQjkn4XZ6nAQdUyPNyh5erCw7E4v6Hfv8aQuFF7SUk22F5aIhOaB8BmnIzi0WkEqG5WyNh2EfguqnGs2skbGEZEDyr6zlBJ2kMI06O9ig+oJe8ygk2P0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lopUYuDS; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lopUYuDS"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc435388657so721066a12.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791062627; x=1791667427; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NIt50rLjdkXSksR3LGf5o56+O3ADWlhlxNFRheaAns=;
        b=lopUYuDSMw4SW+zZHl9J9ELAVJU39xmMgiBwPNJxBTGNC2FFNiqgUAw5J/Aps3iGND
         xcu4B0PmNCy5xFowu4LGhpfQqQZSZupws5SoCSy+U4vzwWJ63gm0D8pjWmlDPc/bJ4aC
         ALWo1o+07buXsAG7XnSk8Y/LAZ6uKAVogRepl0ZZzfi39nNYqyPb9KunL0sRvmqvGU/n
         J0SmRfczuNd41peTHPMTPB6bBEdlKAPpFkTOE8qYoagoTG17Qr5FXw6qx5VwyuYT9p2L
         khuTf92saWh3x98GCcXghRiuOyz4D+VdyRFY+ViHr2Q+h+hi72AhTTzHvBZEXS2TeqEl
         Y6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791062627; x=1791667427;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NIt50rLjdkXSksR3LGf5o56+O3ADWlhlxNFRheaAns=;
        b=dh4H4SudT8SXruCFQAInxZIkN5RNcdudTtCRH0HKwxQawExoJfM4GWWV4TYWrXTYp2
         mWKaNh8ssDGwkQtgnTe5fcHTOILHvdfUcA1qRPbenraS6nkDHcUJONZ2aXrfVIVEJXXG
         fb/Mob2IOeGvx5pb51waV223E0V9suNEfjYvFvzD7f78ZneBhKiMCTaMLBcchYBZDOYV
         N6XOA6bdx4YjHx0czp+7bWKYpi37VnJjsHcvQlsG0WuY5MQHhB8ORlHtmXAiRn+OfkO/
         7e56XlIdAFTImIN2Vxdj0dhJ+c+sNI9Lh34pgRWVGXdA3UWMZrhVG2F6OyynafNEmVZ9
         nVBw==
X-Forwarded-Encrypted: i=1; AKwUvBw+a8jUeUBrFWn4YcJAPJBsU0H7Z70vVlcvWC+8lrjeqaSQUFVW8X+lk2II9NDIpShMidgIri8=@vger.kernel.org
X-Gm-Message-State: AFuF++lgDAlhCatwMI9Qdlf6WYz/X5Fg1fK7FgyAXEGIJ4tiAuHaXU6m
	521n9WEFgXr51PwsRM7U926Q0qomBM4C755sWV0hG5WDgb82/IH3mOu2PB0blpuWhFjuM+bF0Rq
	XgiH7cA==
X-Received: from pfet15.prod.google.com ([2002:aa7:938f:0:b0:88a:e621:a588])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b82:b0:3dd:a007:cb2f
 with SMTP id adf61e73a8af0-3e0bcf97e5bmr6704633637.43.1791062626962; Sat, 03
 Oct 2026 14:23:46 -0700 (PDT)
Date: Sat,  3 Oct 2026 21:23:17 +0000
In-Reply-To: <20261003212336.1304988-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261003212336.1304988-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003212336.1304988-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 4/9] ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_lookup() accepts struct neigh_table *tbl and struct
net_device *dev, and both of them must exist in the same
netns.

It is error-prone to require callers to fetch a netns and
get neigh_table, which might belong to a different netns
than dev_net(dev).

Let's add IPv6-specific wrappers for neigh_lookup() and
(__)?neigh_create() that always fetch netns from dev.

Similar to IPv4, we do not add wrappers for __neigh_lookup()
since 3 out of 4 users call it with create=1, which should be
simply written as neigh_lookup() and neigh_create().

IPv6 has 3 callers of __neigh_create(want_ref=false), so
ipv6_neigh_create_noref() is also added.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ndisc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 96e3bb6e83af..2fce6fccf55a 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -381,6 +381,30 @@ static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, cons
 	return n;
 }
 
+static inline struct neighbour *ipv6_neigh_lookup(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = nd_table(dev_net(dev));
+
+	return neigh_lookup(tbl, pkey, dev);
+}
+
+static inline struct neighbour *ipv6_neigh_create(struct net_device *dev,
+						  const void *pkey)
+{
+	struct neigh_table *tbl = nd_table(dev_net(dev));
+
+	return neigh_create(tbl, pkey, dev);
+}
+
+static inline struct neighbour *ipv6_neigh_create_noref(struct net_device *dev,
+							const void *pkey)
+{
+	struct neigh_table *tbl = nd_table(dev_net(dev));
+
+	return __neigh_create(tbl, pkey, dev, false);
+}
+
 static inline void __ipv6_confirm_neigh(struct net_device *dev,
 					const void *pkey)
 {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

