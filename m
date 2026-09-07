Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809E453A33
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773439; cv=none; b=bDrs2TuRvS/9MRD47VFG9B0AmA3haeab9uPTBi6mDriKCFlDQudLGcldCyXfHKXlkZH5gbTGURFezXMRqZn6LWVT1dc/50v8ftga9D9si4UmyAdBgzYOUJUcyADdkNH5wcgZ/yzvHB5jNrh5qErGQ8MY+Oh6f59ABOPZI4pqpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773439; c=relaxed/simple;
	bh=YI+xdEJ9261IRaoEc7bDRafUF/wY8YNY3L34l0wJ/jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5t0IesKLHymVuB94HTuIjZk6Onrd48EvJ2hyN4OuDGm/JpABIMvd6/e6kJdDTtBgFP5eTpZK0XVpEZ0aaIpxs35/LGj1zn5Thtzg/PqQxFFNJh5562aESv1iBYDskOyVWqVHUBVZ7NhbPKrIJHSlR68rWNFeIDtbDPVOBxioIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iK43Lb7B; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iK43Lb7B"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9DE3C201D5;
	Mon,  7 Sep 2026 11:30:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIgYOkjzLh_f; Mon,  7 Sep 2026 11:30:29 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 95BF8207B2;
	Mon,  7 Sep 2026 11:30:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 95BF8207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773428;
	bh=8tSy5KIz+yRB33F4OIXmOUsG3XFvovnfs/WmcIumFMY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=iK43Lb7BVMBb8mapbALLle7jwl94fv0yCtUYs4AVlzgtIeP3FWT302Fbax2OYk4Y0
	 4KF5d7CcJpNh9xFYFKWJzM0dehl22WsO41n4+6MddY/NyJmoJRwufpPXwWfjOidIqp
	 RXXoXMrtzbKy9vSMatCg1JK7dWizzAzmBkgdC3+m4Hck6Drdt+vsWbuPcffOkKprmk
	 +eGXa9vAfTnGFJ+6zX1Du8eHsyIoll2HvXl0kJQauBJU/VZdWzmT+cAyjkfz9uVgSz
	 DW6gspRFNQg6aUutxK9mhqHBy6+Ds6FxD5Ee47j4NwXxXr60pmriptf8gzYIta2jVA
	 i5mR6ZM9nRndg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:27 +0200
Received: (nullmailer pid 2228829 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/12] xfrm: hold net_device reference under RCU in bundle creation
Date: Mon, 7 Sep 2026 11:29:53 +0200
Message-ID: <20260907093020.2228346-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

xfrm_bundle_create() and xfrm_create_dummy_bundle() read dst->dev into
a local pointer without taking a device reference, then pass it to
xfrm_fill_dst(). A concurrent RTM_DELLINK replaces dst->dev via
dst_dev_put() and frees the old net_device, causing a use-after-free
when xfrm6_fill_dst() later dereferences the stale dev pointer.

  BUG: KASAN: slab-use-after-free in xfrm6_fill_dst+0x82c/0x860
  (net/ipv6/xfrm6_policy.c:86 netdev_hold())
  Read of size 8 at addr ffff8880142fe588 by task exploit/153
  Call Trace:
   xfrm6_fill_dst+0x82c/0x860
   xfrm_resolve_and_create_bundle+0x21d4/0x2bd0
   xfrm_lookup_with_ifid+0x485/0x1640
   ip6_dst_lookup_flow+0x19b/0x1e0
   udpv6_sendmsg+0x1443/0x2dd0

Fix this by reading dst->dev via dst_dev_rcu() and keeping the RCU
read-side critical section active until xfrm_fill_dst() has taken the
required device references.

Fixes: 25ee3286dcbc ("[IPSEC]: Merge common code into xfrm_bundle_create")
Fixes: a0073fe18e71 ("xfrm: Add a state resolution packet queue")
Suggested-by: Steffen Klassert <steffen.klassert@secunet.com>
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Link: https://lore.kernel.org/all/20260820200245.44312-1-blbllhy@gmail.com/
Cc: AutonomousCodeSecurity@microsoft.com
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 932a313b9460..513c9f228334 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2770,9 +2770,12 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	xdst0->path = dst;
 
 	err = -ENODEV;
-	dev = dst->dev;
-	if (!dev)
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	if (!dev) {
+		rcu_read_unlock();
 		goto free_dst;
+	}
 
 	xfrm_init_path(xdst0, dst, nfheader_len);
 	xfrm_init_pmtu(bundle, nx);
@@ -2780,8 +2783,10 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	for (xdst_prev = xdst0; xdst_prev != (struct xfrm_dst *)dst;
 	     xdst_prev = (struct xfrm_dst *) xfrm_dst_child(&xdst_prev->u.dst)) {
 		err = xfrm_fill_dst(xdst_prev, dev, fl);
-		if (err)
+		if (err) {
+			rcu_read_unlock();
 			goto free_dst;
+		}
 
 		xdst_prev->u.dst.header_len = header_len;
 		xdst_prev->u.dst.trailer_len = trailer_len;
@@ -2789,6 +2794,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 		trailer_len -= xdst_prev->u.dst.xfrm->props.trailer_len;
 	}
 
+	rcu_read_unlock();
 	return &xdst0->u.dst;
 
 put_states:
@@ -3058,11 +3064,15 @@ static struct xfrm_dst *xfrm_create_dummy_bundle(struct net *net,
 	xfrm_init_path((struct xfrm_dst *)dst1, dst, 0);
 
 	err = -ENODEV;
-	dev = dst->dev;
-	if (!dev)
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	if (!dev) {
+		rcu_read_unlock();
 		goto free_dst;
+	}
 
 	err = xfrm_fill_dst(xdst, dev, fl);
+	rcu_read_unlock();
 	if (err)
 		goto free_dst;
 
-- 
2.43.0

