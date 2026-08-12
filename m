Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DF3E0732
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568393; cv=none; b=A5j5FMk3qS+dMsWXcwCZd6haV2AD3/zU9672LP6N/qkou7pt0ZcZlPqMoQvUeqCSQd/GHl4G52+7t6hB4PTuZhQqEucQ9wtv1Q4rCVFA4+IjxKkV4d1lXCHMjnRmrfTNoXs5ijnJsrU1iN1C7nCa6k8xFGXXlxPTc1H8H9yf0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568393; c=relaxed/simple;
	bh=dkTI9AIjPAYPkePRrzOQzxNd2nme9LpBuKzTPjy5TM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KkJGgzMLBCSPo8U/zVfUCALmzeAXpb70bIk1L5TD8eGZG5gv4IqvTbJ8U20D1DijVd9Tjhq4gJ6HSDaIqZIEHV8tnKexxSHXHqvZR3bt2N5Bm/kFAbuf3NguthtCqZ5P9eA/07Y0FZnfRIgqodK4BMsddSGQ1Pbva+mzZOQkKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpSXVBn+; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpSXVBn+"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-933023a5980so4984985a.3
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786568391; x=1787173191; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rGoHilioqtrElBbINYvRFvD7r3Xv7Rf3lUgIqeqvWIo=;
        b=LpSXVBn+IX96rX5jZaov1go+fKu4sozyJWO40Plgka4yQfvLgN7sdN7SIHUGcw8Wdq
         V/tfw4+HpUnGncGX3X4eF+dkVyakSpMvlQRjCDUYaiTJwULgIK9N6izXFYA2+puhbidB
         xiIKoTjWBncNIHDBhW/7guZjAgxyc9n6EtrXcGHYw8txXauEqB8tTke/pm3MfaUOY1kX
         vCWOEKf5M/6PbMM4Yy31SA9AIf8/Mfajkz7FDxI+MIH67TAaEcpdnwnm6Y85QH13u1IO
         vbkATjK6HbnY+i52QYVqTs4KzsgbncR3PFZKeFzAch5l4nKdJuQcBCJsF/a49UFTn5L6
         P7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568391; x=1787173191;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGoHilioqtrElBbINYvRFvD7r3Xv7Rf3lUgIqeqvWIo=;
        b=Yzgdo27WzoUwkZBvkJI12NsWSSpJ0kjYDRg6SKVCKQ4KOCppJxQfKA5r7OhujuiMTG
         7CBkDzrnAKfNQAgtHPLtEH0mDpm2/igwOI+Or3YqrRn5+9GaEYIXtk7kF0urqzFeVWW8
         qvae+TKCfAkXwY+VANme0ViJADFFY53zUmJGMEx8I9CUsAe6ECBNZD22Ucx2liiNnIAx
         u35Wcn4XRQ2wwfiMLqPqrzTFVSzwmNcwBHr4wDcqR87s4Op3uRDTOtJfPRO9h0F4/FIt
         KpETDTGg5hO1WtoQ1LsJ6W4CXH68LcFCrENBVqG4br9AZMPbTqQwtYbNucE0T2R2bDZy
         h/EA==
X-Forwarded-Encrypted: i=1; AHgh+RoiloleXT8H+28HmN+VCKoZN4kEBNwL5Ykf+aQXmrJWDv69DUgMtPXhWQgLCiaCafnsC/H6Myw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeWYbp7zbu7h4aXAL/r4dYxOMGAGgGRa6t0O/gMXbN+swLPfW+
	ieFTaun/5Ud9U2N3aPRjsciYLqMTgrnqyKS/dyq2Rdcm1VFUPoIv0haRp0+nLci9mOZB0UtJcOq
	yjhLKK9T+Kcgzaw==
X-Received: from qkpr18.prod.google.com ([2002:a05:620a:2992:b0:934:96b9:5116])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6e88:10b0:930:ae2b:10c1 with SMTP id af79cd13be357-936bfb37780mr72757685a.42.1786568390555;
 Wed, 12 Aug 2026 13:59:50 -0700 (PDT)
Date: Wed, 12 Aug 2026 20:59:45 +0000
In-Reply-To: <20260812205946.356185-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812205946.356185-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812205946.356185-2-edumazet@google.com>
Subject: [PATCH net 1/2] inetpeer: enforce hard limit on tree size and fix
 NULL peer rate limit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Michael Blunt <michaelbblunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Currently, inet_peer_threshold is used to trigger aggressive garbage
collection when tree size reaches the threshold. However, if garbage
collection is unable to reclaim candidate entries (e.g. due to held
references or active fragment queues), base->total can grow without
any upper bound, consuming excessive slab memory.

Fix this by enforcing a hard limit on inet_peer allocations when
(u64)base->total reaches 2ULL * READ_ONCE(inet_peer_threshold). Casting
to 64-bit unsigned avoids signed integer overflow if inet_peer_threshold
is configured to large values via sysctl.

Additionally, when peer allocation fails and returns NULL,
inet_peer_xrlim_allow() previously returned true, allowing packets
without rate limiting. Fix this to return false when peer is NULL,
ensuring rate limiting fails closed under memory pressure.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Michael Blunt <michaelbblunt@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 5b957a831e7c39f2e9b224469f0eba4703833475..1e2bd1c522326c9ba14c3ceeb8e934f703b827a5 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -192,7 +192,8 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	gc_cnt = 0;
 	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
 	if (!p) {
-		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
+		if ((u64)base->total < 2ULL * READ_ONCE(inet_peer_threshold))
+			p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
 			p->dtime = (__u32)jiffies;
@@ -248,7 +249,7 @@ bool inet_peer_xrlim_allow(struct inet_peer *peer, int timeout)
 	bool rc = false;
 
 	if (!peer)
-		return true;
+		return false;
 
 	token = otoken = READ_ONCE(peer->rate_tokens);
 	now = jiffies;
-- 
2.55.0.691.gc56d675ccc-goog

