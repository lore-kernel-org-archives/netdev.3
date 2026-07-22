Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969F175A9D
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680200; cv=none; b=Qi0a9cOE0gEe7UxM6fe/tyYQoAgQ5hOcZwq3pTREi1A2MesrhEyZpstwO+HFs7rNdU1/xz3gmktb30b/ToAkIHfWqm/+Am/ucRjtXCGVc3XPj4GCnF29NGxm5NLHc3ox/cGBICsG5joXcOvSJuRnzdrVkVZ4SoygL+S6dmBG0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680200; c=relaxed/simple;
	bh=/J/yN54WgHwgySAyBEJg13poFEdB2VzJ4/P7xp7qFOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxLs+SrPWhxg6YFr/Ss+njp6EqpWpjcZTHH25SONM+GRN6dVlk1x0d9kpV24rWbmUxGdN4IUwL9rcuuOYIfLKG6novej3z9VS61JNq9Ggz8plZz6q3TKpUbgHhDilYOH7Kvv/okcdRZ8iIDFYBSarGqckHVHF+JgswQGiy+te5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ZB3pD47K; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ZB3pD47K"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so4020482a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784680195; x=1785284995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z23U5EtP10fE0FYpT7HwjmLAZ3cbLvFSK1Bs2GYzQ9U=;
        b=ZB3pD47KiTe4UqAimZqAVtKVFCcnPEhYyjdDMWiCdB95KzJPGPxKIRbVnTKmfOuVOc
         9oKCA+FclrBl/7Kw6c9NzAslZSE1pjwIlJgq4lRk5t4EvKNBjYIaXjoRz9vqwc5sxsRG
         GDjlmHKmEP+7QS8IXpFPdmuZUddwS0KyMWHuU67auM3Lbid1fW4znG8699Q+cwYnKtLn
         4eJA0vOY1LYYdI8IFAq76K4w+FdPFyYwqNzgM+WjsN+UnlVQcpkecujHfkvWr4NMrZEF
         16KqYoOb+VXfKfYHqmUzyQJftvhzFcjza5hC5vwUgVOspMa7XV3YFZHUVEmIGKMbpQ2L
         /T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784680195; x=1785284995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z23U5EtP10fE0FYpT7HwjmLAZ3cbLvFSK1Bs2GYzQ9U=;
        b=elq3Me+EiUu0gKl/uuEtvOTZRzpaW6LTBlSBZy2rRPnzqi9ubcN5HFdSKE8sjCcbO5
         bFOyQursaXmestVLnCV3W/e1FtoJqROQvt5A26OSkun+wmUK87OrvBhFehXhg87CnM5M
         FUvDoBX2iOhtKplEEEyBn0W5AmnyYNJ5EvRUuD1PgYmVI3i8+w7FBTJeRrhH+Z8Qydtm
         KjEFN5gZqB8jfZXV3R3sDrWNawCiQZDLfyyxh7f+Lmt4Dq5waJYYsZtu+kjFf2i0a2Sa
         rQ21EumabfdLv7EfO3ATCvqNH2P1lMdTTXcEWFDeK07QECuE8iYobMVaeu4ltH4fmyTM
         f5AQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPuzX+lQQSe6cUHBJcwEHJvEuoDgrKAb4+0r4fGZ3sdzF0QbsnJuF77dMmCBzDwMIFENyw604=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1e8qrGDep7mF3TuZQkbyNH5ZnX44Zb1jOIp24bMoV5BkGUA3b
	IXioyT8lOngBHBKVjl/7mfG3s++leo4Kv7M65xV5lCJgqPxDB9x4l2Ss19CQf4A0mA==
X-Gm-Gg: AR+sD11jy80ciz9cnpBYmStH5HkQNbbK1gfATXWbqljLOsnTzzYDjpfZwqO0TrkuZZX
	1rBmjpEf9p0EZF0PFGpnaLsb+/IDGwmVOynq1R0QY93edsT3CEjcJYEzaSrrMd/nQNOIatQFSN4
	KQPkSVgnWaQUIh+20sxzGKX1/+IabEPg7kSoVoOtCn3EqDmS8HRrdWlm2Rmd225oH0DxbuzRd/W
	x40Ybo8Ru0m6nAE0VT4cAjrCn9zpiYmOprxvbRQHKB86LQ7ByjziwF0ASD7CuSm9+FXrcbRUoqc
	ArG1idKGcN2Mrt63uZdTrwbu+JuiRZwJJgldtGvvA2A+XVNVIjbABgb5DwHJCCi2hJNe3NV1S80
	hXX6+nvpa6req1ylQxDLk4YV1IK3fLG4wIXSJhEnD4c8XQy7/C2oXXSXQqpPqyNjxXhpg/I7fGU
	B0tOc0cYA=
X-Received: by 2002:a17:90a:d646:b0:381:50ab:1594 with SMTP id 98e67ed59e1d1-38e4b51be59mr21943047a91.27.1784680195529;
        Tue, 21 Jul 2026 17:29:55 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a8421sm558863c88.10.2026.07.21.17.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 17:29:55 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net 2/2] nexthop: avoid unlocked f6i_list walk in nh_rt_cache_flush
Date: Wed, 22 Jul 2026 00:29:51 +0000
Message-ID: <20260722002951.2614721-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722002951.2614721-1-xmei5@asu.edu>
References: <20260722002951.2614721-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nh_rt_cache_flush() walks nh->f6i_list during an RTNL-serialized nexthop
replace without holding nh->lock, racing the unlocked IPv6 route
add/delete that mutate the list under nh->lock and free fib6_info
entries (nh_rt_cache_flush() is inlined into rtm_new_nexthop()):

  BUG: KASAN: slab-use-after-free in nh_rt_cache_flush (net/ipv4/nexthop.c:2243)
  Read of size 8 at addr ffff888012953e18 by task exploit/146
   nh_rt_cache_flush (net/ipv4/nexthop.c:2243)
   replace_nexthop (net/ipv4/nexthop.c:2610)
   rtm_new_nexthop (net/ipv4/nexthop.c:3323)
   rtnetlink_rcv_msg (net/core/rtnetlink.c:7076)

Unlike the other f6i_list walks, this one bumps each route's sernum via
fib6_update_sernum_upto_root(), which needs tb6_lock; taking nh->lock
around it would invert the established tb6_lock -> nh->lock order and
deadlock. As the only purpose is to invalidate cached dsts, bump the
IPv6 sernum for the whole netns with rt_genid_bump_ipv6() instead,
mirroring the rt_cache_flush() already done for IPv4 just above.

Fixes: 081efd18326e ("ipv6: Protect nh->f6i_list with spinlock and flag.")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv4/nexthop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c1d3b7d7100d..1e9ccac6bf0f 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2240,18 +2240,18 @@ static void remove_one_nexthop(struct net *net, struct nexthop *nh,
 static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 			      struct nexthop *replaced_nh)
 {
-	struct fib6_info *f6i;
 	struct nh_group *nhg;
+	bool have_f6i;
 	int i;
 
 	if (!list_empty(&nh->fi_list))
 		rt_cache_flush(net);
 
-	list_for_each_entry(f6i, &nh->f6i_list, nh_list) {
-		spin_lock_bh(&f6i->fib6_table->tb6_lock);
-		fib6_update_sernum_upto_root(net, f6i);
-		spin_unlock_bh(&f6i->fib6_table->tb6_lock);
-	}
+	spin_lock_bh(&nh->lock);
+	have_f6i = !list_empty(&nh->f6i_list);
+	spin_unlock_bh(&nh->lock);
+	if (have_f6i)
+		rt_genid_bump_ipv6(net);
 
 	/* if an IPv6 group was replaced, we have to release all old
 	 * dsts to make sure all refcounts are released
-- 
2.43.0

