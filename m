Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168C388E46
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221573; cv=none; b=Hm8ToLfKapF7CL4F0aWIH0Cm722ewLh8rnEoYCOYuw2gp4iszmd/DHm9EtbZEquo29fZsESjmeenqQKMSrA2E51U4CO1C0oahEWdF5oU2gujfNhWxVZOMsv1MxbNvoLb0di/Y5TW49hR0ZRvu3lIr2w3qu5UBdXzqqXj1MmBT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221573; c=relaxed/simple;
	bh=ukTKg1CDrP5PXdR5NsWNw0I/bk/nNYuf5bOvNgyYh/s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xrxg3XY6BZ4bDAwriibu+tczvmzSqpCwooyQ/uLOShZIKRn1ZM60iZS4zV67UzljKsQqaRxnMI7HBpAHLISgdexWLkul4S/GpvpRi10nTISVNaiL0F/6B/p8oH1+yBAk+mwTvUqrT85ZnHBimnL5wN02UhFZeDX8nw2e60ug+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZyqdkIH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZyqdkIH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso16257933a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784221571; x=1784826371; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXnY41KjziccEnkKa/6D+ShptkHLC/v8km9IuaNhRh4=;
        b=UZyqdkIHvnTYEmeai1vjiVUb+Qtx4BZEuJqINntpccn8PxFah5tUsJL5El5Lk1J5j+
         +x6y4lP/Be8PyFldIlWac5gE2EWUf4v3spYgwLX+R9/UgHDCJ5/xBJBXlIFNquVlKpbH
         iZyRnWEgMQNUSnLsds+IR/eDSYcX0yLs8GaTukL0BhdHeRwvn8FJgH2VtSdr0u+2I5s0
         0I3pXoqmspzo61+d+pL4J+qMTsfAAWgIOD9bq7gy041UuxRpWFfAwP0cA6IdHsHZC63X
         Sq7N6lsW4jsLeUI4GG322PCxdDMe0BR6faeKHcU3Gz2QatSyFu03B9e8+Cizq5SGWPgE
         DqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221571; x=1784826371;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KXnY41KjziccEnkKa/6D+ShptkHLC/v8km9IuaNhRh4=;
        b=CI/H574+0y+IiQxXhwT9t95700tsjbB7bc1lZyqoRoyRWjfiQiu8i0dzb9uS6zXESI
         6YCt5wiBEW47rkudrd9q4o9U08T1CgWtGezEKFurSJ4YKQlvLT8wrj/cNTBWF5Qbe6b5
         FGeLXvVH5qetITuuFS5CqTmjn9KY9qqQQeovI7+r5Rn0P5YH3i+hxOsK5ceiNkDePP5K
         +cI0Gxy1OVrlk7bw1CeMhy0BwobYi/oIO/iNXzQoF2g1GCaZu9kIhFoGYKk8GeRl3EDe
         eGMHmVJ+hewm3R61gWyNJU7y8IOdoOP1OeOgJiHcU5mBO0WdVak4fb5lOuQVRicgT7Wu
         freA==
X-Forwarded-Encrypted: i=1; AHgh+RqPNkv28rl3JfjHiyEj+xp+jPptna/WR20buUZirPoxDbQJKz0Z+8lRVCclvJVu2Qa3e7XiwGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJBNV4tFU3MOD/ZP/qfplRySBcNie0e9caVYBJ6puZo1p3jyV
	HfUp/l7SPG9TM7hB9bjP+eT2SSVmUWlHtTWlZWLsq8ccz0i0TZTCNekVSNR7xa9upiTZs7+ro47
	UhErQbA==
X-Received: from pjbgd6.prod.google.com ([2002:a17:90b:fc6:b0:38d:d1cb:c52a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:554e:b0:37f:fdc8:71b4
 with SMTP id 98e67ed59e1d1-38e1add8d8emr11129032a91.2.1784221570609; Thu, 16
 Jul 2026 10:06:10 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:06:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716170609.804629-1-kuniyu@google.com>
Subject: [PATCH v1 net] mpls: Set rt->rt_nhn just before returning from mpls_nh_build_multi().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Guillaume Nault <gnault@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Anthony Doeraene <anthony.doeraene@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"

Commit f0914b8436c5 ("mpls: Hold dev refcnt for mpls_nh.") added
change_nexthops() loop to call netdev_put() for the nexthop devices
before freeing mpls_route.

Then, mpls_nh_build_multi() was also changed to avoid iterating
uninitialised nexthops in mpls_rt_free_rcu().

However, setting rt->rt_nhn to 0 at the entry of mpls_nh_build_multi()
makes the following change_nexthops() no-op.

Let's set rt->rt_nhn just before returning from mpls_nh_build_multi().

Fixes: f0914b8436c5 ("mpls: Hold dev refcnt for mpls_nh.")
Reported-by: Anthony Doeraene <anthony.doeraene@uclouvain.be>
Closes: https://lore.kernel.org/netdev/036a0c95-f5d4-46ab-88e7-1eab567d7a84@uclouvain.be/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ca504d9626cf..4a81514e919a 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -922,8 +922,7 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 	struct nlattr *nla_via, *nla_newdst;
 	int remaining = cfg->rc_mp_len;
 	int err = 0;
-
-	rt->rt_nhn = 0;
+	u8 nhs = 0;
 
 	change_nexthops(rt) {
 		int attrlen;
@@ -959,12 +958,15 @@ static int mpls_nh_build_multi(struct mpls_route_config *cfg,
 			rt->rt_nhn_alive--;
 
 		rtnh = rtnh_next(rtnh, &remaining);
-		rt->rt_nhn++;
+		nhs++;
 	} endfor_nexthops(rt);
 
+	rt->rt_nhn = nhs;
+
 	return 0;
 
 errout:
+	rt->rt_nhn = nhs;
 	return err;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

