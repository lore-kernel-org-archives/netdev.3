Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A4302767
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787256175; cv=none; b=PnOgKaIKM7UO0O5PfimkE0fjCnbETUuYKk4Kor0l2vTym+/cWWplWJ3babL8Fz3KRbsE91mZj+9To5BOoloZXVWAzzLa2kFRCf1mQy1vNNeug9PZAHyfu8rlm8HfRQ818Eu7XAAq+FdJeJAWA0FjKkLPUu8nEJlO5RglWgRt+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787256175; c=relaxed/simple;
	bh=A97p7/oO1FEEWJb7XQgTlrEih60GzyHAcVdcsXpl0Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EA2JAawVSbuCdllP0NuKZQa2kdWbBn/lhzoO38M7FAdbbtQlkaNgi6zHUPrcBVgPpR1fUwhwVArpcNN/YHXysX+ZQQZBY1VA7MhHvQsfR/+sOiV9N9BxOcyhZ+193jFt6SgBxACgYkwgHjmbIXRWCXCJ+4OX0MKxgFadOofmKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCGsIvmJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCGsIvmJ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c718715fso3895537b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787256173; x=1787860973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLkvx6w7BDuxuNWMAFemUduU8jiN2X4Klba5ZW9AWpA=;
        b=SCGsIvmJbDA7wWiVdUlx3XaZ/n1dpHKLQDlTNNqgyMOmk5jpsngT3HS0hXSqxGBElf
         qvw3b4nRDr/R9PBIMOnWhMBAx3BPgdVHfZOGAWbyXUXB+iO1LF8qKwOeLxo2ZZdYBCoc
         bKggG4OPJ6PgmGNHPnZJq5iiBDfbwaCJsqEYxZmefEdvQwZrlpfb30A7p4YCN7q6U2MN
         L8BYvHwXihuT8ns/Qr9j+th+N1WJgjvDYkGtaDUmZJH1TSHrhYhONQxV4cyckATGXFvO
         qFnvdN20aLL3snWPo2sesfJsdOwFCQWBuPloTUHUzOZt/523l0nnqAcOzNK9xjC03Na3
         7p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787256173; x=1787860973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLkvx6w7BDuxuNWMAFemUduU8jiN2X4Klba5ZW9AWpA=;
        b=jLPxGJY++MuFAtKgP+3+4gjHZxEI+kkFrPHtbyNyz62IOas3X9kVtKjqb35c9A2UxD
         9MnhktVEuTKb6y8yMsHhO18JGya8zRk7TTgtgpEiPtsehpwo5TvCPySKc5dZbTlDp2Xp
         gLJYYeBmOjkh773eDaYe6Ihhv3pnPVDCRggND4bgA2hRNUC0t3sRMa91A/URL0qLD12/
         7KtpUJAjO+UVZBnnlua5//WZ7JcCSkK9yYLpNjtnFDKhGyFrEMi+5kV2dfyh5Btf3gJi
         +ZXddud+4L1CuJseIG1JDZguqiYABkykl8rKu41gR0K2x7lNO0dtXYnoE+PV2thYmBR0
         1Agg==
X-Forwarded-Encrypted: i=1; AHgh+RphCkZaAi72F1OIydBec7q2r66dlkx7BnQHIzYbdcMywL440kyJfgxNKixgwevnnCYfjnDe9Q0=@vger.kernel.org
X-Gm-Message-State: AFuF++l4FvDAYxqM8oiXWfUSMkBgfPJ7OmUy81GRdX3FVRzfJ6d6PdVa
	dWzfjcaJLZUsBPIZnl38u2l0vH61+x3fM5x2h6skhs2YhHCJMi1VaRiC
X-Gm-Gg: AR+sD127PvkumCErBaL39qiUE/Pxw06NcZkuPXTkMYsqwsscCyTmiPcr6XdsvXmQsa2
	jIwv8G2+N81LyzPeMA+LU1MbNd9a3ME/2rcDUsnJP1+8cq3vw4iF3ZxMRL2ciPFOnPmTtPiuyia
	nEln7l4Gu7Db1fJD/hu+LkvcdnTKNdXjE3IXGEwIZP0Z+4nrSnlMHcZCj+aTLQ1WRPNqMKGCWYc
	uiv+vLypCBaiy/dEJl1tAPcI9hFf09pzaLz1+9bvxw9HFkFOs3Ko+EisGhcFs4BnOUukSD8H90t
	mBS3jJAOfXN7ZOVMhDD8ZsA91eHhp4ekncovOAIIX3xixTy+KoxoOqEnS0jEPrDnyEytjSyucea
	eecOMO72yf4tRIKuqpe0jBPfUjyw5hkkuTg5mps44nywBCT9rcsgCcA0iOZcn7Oi6MnR2ukbkZW
	hCSTNuhg7P1SXF/0iVI0UrPmsOIV7084Rx8VVLKuGl5TB7QcqA1DxCI4TwCSyS8iz0Qqg=
X-Received: by 2002:a05:690c:e3e5:b0:841:ba65:ae35 with SMTP id 00721157ae682-849f18abb29mr4135467b3.10.1787256173173;
        Thu, 20 Aug 2026 13:02:53 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84511abce11sm30016807b3.2.2026.08.20.13.02.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 13:02:52 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] xfrm: hold net_device reference under RCU in bundle creation
Date: Thu, 20 Aug 2026 16:02:45 -0400
Message-ID: <20260820200245.44312-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm_bundle_create() and xfrm_create_dummy_bundle() read dst->dev into
a local pointer without taking a device reference, then pass it to
xfrm_fill_dst().  A concurrent RTM_DELLINK replaces dst->dev via
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

Fix by reading dst->dev under rcu_read_lock() via dst_dev_rcu() and
taking dev_hold() before leaving the RCU critical section.  To properly
release the reference, add dev_put() on both the success and error
paths, and initialize dev to NULL to prevent dev_put() on an
uninitialized pointer when put_states falls through to free_dst before
dev is assigned.

Fixes: 25ee3286dcbc ("[IPSEC]: Merge common code into xfrm_bundle_create")
Fixes: a0073fe18e71 ("xfrm: Add a state resolution packet queue")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/xfrm/xfrm_policy.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 932a313b9460..13585ff24aba 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2668,7 +2668,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	const struct xfrm_mode *inner_mode;
 	struct net *net = xp_net(policy);
 	unsigned long now = jiffies;
-	struct net_device *dev;
+	struct net_device *dev = NULL;
 	struct xfrm_dst *xdst_prev = NULL;
 	struct xfrm_dst *xdst0 = NULL;
 	int i = 0;
@@ -2770,7 +2770,11 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	xdst0->path = dst;
 
 	err = -ENODEV;
-	dev = dst->dev;
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	if (dev)
+		dev_hold(dev);
+	rcu_read_unlock();
 	if (!dev)
 		goto free_dst;
 
@@ -2789,6 +2793,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 		trailer_len -= xdst_prev->u.dst.xfrm->props.trailer_len;
 	}
 
+	dev_put(dev);
 	return &xdst0->u.dst;
 
 put_states:
@@ -2798,6 +2803,8 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 	if (xdst0)
 		dst_release_immediate(&xdst0->u.dst);
 
+	if (dev)
+		dev_put(dev);
 	return ERR_PTR(err);
 }
 
@@ -3058,11 +3065,16 @@ static struct xfrm_dst *xfrm_create_dummy_bundle(struct net *net,
 	xfrm_init_path((struct xfrm_dst *)dst1, dst, 0);
 
 	err = -ENODEV;
-	dev = dst->dev;
+	rcu_read_lock();
+	dev = dst_dev_rcu(dst);
+	if (dev)
+		dev_hold(dev);
+	rcu_read_unlock();
 	if (!dev)
 		goto free_dst;
 
 	err = xfrm_fill_dst(xdst, dev, fl);
+	dev_put(dev);
 	if (err)
 		goto free_dst;
 
-- 
2.55.0

