Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D414D9540
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798616; cv=none; b=kQ5GjB7ugo+lFtdvCh462ebMBigoatHi/RIzLpXg/nBORAGluSlvKzUIjcvY6AFBxuSdvD+rSSLeEDMOpFhOk4LLxOhXpwwz6zxDE+vPg8ezgikXpGlzazooQ/P+TxKT3Jw0nixp4CAv72gBd2+fYoq8awIMcn9+1xeGoCdIO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798616; c=relaxed/simple;
	bh=aErxxCmM4GcghQQWlr8ToqF6k8a8J4gCRtzPWWqkpIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jJQ/Jd4o8EmLao+zP9kVipYXGdecIeadLE/QJkGVIqoW8H3TR21xDcC4e0q9t2O4UTHZN/wc53OdrQhxTgDUzvrq6I37iMVMmDqYzwUKSgXYD7PmI72ZgCSiJRgce5dx3c8iZw4r5hArlFHfiYcpmzNsIwpRcFPn3J4QINqXJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXM4n3KN; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXM4n3KN"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df7bc60df6so44474535ad.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798613; x=1791403413; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NIt50rLjdkXSksR3LGf5o56+O3ADWlhlxNFRheaAns=;
        b=CXM4n3KN6+R4wHpjF76zv3W4SOBKKUlkTFfvEhaNFHecnOAtGyjrv2/WtCvNxCBIC+
         eYOEqZ7YzQs7zggXuJy1i83FQQC4WfdsnYN2+SaKiI4qPJ/cEH+H9C+9vo93LjO0zua4
         BC4hpRWb0MWUG7KipSATTOudfaoNX/agXNNkrK8scEaxEEHU3YFFS+SvGFfxibX+yEUA
         p/ne5BqlNo8pKQUN1M6dXNOTH7ioxzB3eMHoq+3NmN6+ilRi9Kbxy+AtJtC3zsqW5zvy
         d1UhiyvVyAsx9FhvkqbdogX0dxOH9CDLRLFNoBJCMbnWBGW9xO8Jlc0s6SEjmsbKviYJ
         O8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798613; x=1791403413;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NIt50rLjdkXSksR3LGf5o56+O3ADWlhlxNFRheaAns=;
        b=qpRr+fusXEibK3ChPQjodGVDKqyOSZYyMZAkCfbae+Uozb0Ri/bWdS+70to5qG6xpo
         P9yrwat0b6+u/czFGlHh0oTlCPI/34uJEGkWBm5XMLxP0nZ5vf5BIXJNhkUeZbN/f+tI
         N3mqP1ivAbRzpXgnrlSOUvrTH8AuqkKhvBYxqJI5n0tfREaijZgcb4jvZsbWzZzGHxWs
         HgfUGYwguaj1Id9XPnKBC/5im2lDb5KsqErWmqtXVAwWHkg3Pd68zwys/0VmOzWAgV6r
         WHjHv9l7x1IXdmwcAUhT5KTrDuwH5238sh/JQRAPikfOij0+4sK/u5q1WFqHx2OS0kYI
         ze+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzXWiLNVHlQm5IaTXr7aH8/PcoccZMbZTbsRXvLFAPQKq9ASzGuIdeF+2Y3+ThQQWklMAd9FOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf1wH4WgTaQDkdSwkIDo0rXfrPyltF7xAxlLrgNunXxm1q6OQ5
	J1BqAbbBRRMxb7qAFZO5e25iDIljGYs4QTpFccRMcP3SHZ3HDv6EjHbUYnXkSpiN4icvr5nTLZ6
	hlTaOMQ==
X-Received: from pldv20.prod.google.com ([2002:a17:902:ca94:b0:2e2:f224:2352])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:2e1:2421:6807
 with SMTP id d9443c01a7336-2e2e4b59cadmr20982105ad.14.1790798613181; Wed, 30
 Sep 2026 13:03:33 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:12 +0000
In-Reply-To: <20260930200326.718459-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930200326.718459-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930200326.718459-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/8] ipv6: Add wrappers for neigh_lookup() and (__)?neigh_create().
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

