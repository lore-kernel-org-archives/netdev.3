Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403E35A38C
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775470; cv=none; b=fp8H72LKNT/htOkWeLW2Zl1vSy4Yc6g0wkjJqxrSjzRdGBTLkOFegN5rXptmWHBjEF5hyGJtuWdOgNBAFpnSie+/+iUDXc82yXepbxLIznI38/ZGG9EKHHR1ZId+kL93sPqsg4GJ73XNMOK7uG8/0vR6T2g1oha5BWW9QmqpXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775470; c=relaxed/simple;
	bh=l/hTpjViRwyTjYJxISfGUusOgciX3huUiYeL4/xKav4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6EJjy7CJC7MGsNEa3cNJjIYSEDYPyqgpRqdIiaQ2wlFU3/r+E/JU5HR92JK/ffp5yTEAqO5EQf3BZdSZ9uD7+OKwuopcoIKDcLm5lgkp+GLgbcJR8Z9SBsJhAm4neYTnWUfK7rLiNWak7+BJLqGrj4bmQMPlLLz4IhPdCX0bhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDYsWvk1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDYsWvk1"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-85aa9c1308dso5597877b3.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787775468; x=1788380268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5NbKzLTBGGRp/FSaDFEI7G0HrceaH9zXZkvzlIjZSU=;
        b=pDYsWvk1ecggweDelA6p1t7Cro5QIDc8yZwnHWrTpMMhYNxYcE0cLhllcjhdugmfat
         FcZaNY22f1nrsUyNrGVz/ZX8dsh8Ju3jDL+BqU4/s3Xoksq6Q0XgTPZzyTJ68ANbwa39
         R0mGM0XXxWnbXFWNvVhmHFDF7r1yk2bAXwqX0I0jh+hTGlmCGWiujZ+pSKTT6aBqBrRU
         /aAFL4Dzjh589RX+KzArtFPWnGD0hqgEXQZqwIHzXIwVKw6cL2bdUh0/YTiqnAmcGizo
         TmE7gVHFS5LqaKc9PGfe7yJGc/0h+M+SOMxkQ13jRhGrnqIo8VBq1kuvUv8eO+pGFa7D
         nc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775468; x=1788380268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5NbKzLTBGGRp/FSaDFEI7G0HrceaH9zXZkvzlIjZSU=;
        b=OjJ4580CeMlDskxhtoY2gGKfEuP9KvtwpJID2+ajj69xg9ZPMB98dQMLJHC0Ee8Jx+
         H7U7tY1FEKeFe5XgT/1rcuRo3o+t4hEMwFCgXuxxcRq86ns2FXi8Uk1Nz6Isa45ThmNu
         w/97wLB0PbCYDOXSvglnPM64ciW04ZpcfyoezhWqpMRXovCJ26kUD28QI/pi32aehkXD
         gTXmTo7RzGMoDjyU2MnBBVpgb4z4OE5corrNF57LEspgBerSb/5P3ggwZ3oNincE0gLc
         gQ6Beaak+26Fq5tNiXSuCzUYjV5Rrsy5rtpdP63FRBshsKl0ixNl+7EEwSj2sGHfoa7W
         XR4w==
X-Forwarded-Encrypted: i=1; AHgh+RqRu+wIPAhB8ZgH4PmlVPmYcDLqyPrWtVcsWJXR0J78A3FdCFnrxCsoTKNYZ9DWvdLcBEVbX1M=@vger.kernel.org
X-Gm-Message-State: AFuF++njrsX0GnUl+TxlfjJL6p3sDM1zxdUD233QV8rybEXLZytD7iR5
	Sl5iYoW9rGg6Y7M8j8/VGbQfmONNmwvvSoBWNKDk2H/SMTP4evNToeIi
X-Gm-Gg: AR+sD10qzvwtKX77F5owwg8RAE8SNW3rUSk5xi/zXKik7RT5UCqDIO+UG5FZIw91P7f
	2T3/sEzvKYfN7dwQEtqGHdIfWBcdmvEyQ/UWM9JwocjgrB8bq0/TE0S2MqS02wcL2/rehM/KbmE
	sIUhgAKZQ4taodmIWB3FwBY0nSwH/rnCaEZlDSG4pesnm7bZHQsV6v5ZKtj/sX1Tga3Wk77d9O9
	mtKp6BhpOU6jchp1yE+DCZft/+rcbisxWkxU760UO8oBAyAWWHstydLTojc/zV5TChBbomBeN6A
	WALC2kCbadn6+DqTuOaRe314ENE/TftoqpcyECIaj82p6yrhTh/dUonOTnx5j5AIMVIv+uDc1ss
	xHRFfLdiuceD3awcicSBqRrWWvGcjd4tirrXxaX2SUI0qaHRTwn94LORVxvrVqPD+HCKK/iPEid
	0/1QYdtOPJMhSx2OdlLcG7RN/SAua3kvNGQmZVzNRrp3eFO0GPS0a82BWHMZmtzJ9D5wY=
X-Received: by 2002:a53:ca45:0:b0:66d:11b0:819e with SMTP id 956f58d0204a3-66d257e3a60mr2410580d50.46.1787775467871;
        Wed, 26 Aug 2026 13:17:47 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d2459af68sm1975554d50.7.2026.08.26.13.17.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 13:17:47 -0700 (PDT)
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
Subject: [PATCH net v2] xfrm: hold net_device reference under RCU in bundle creation
Date: Wed, 26 Aug 2026 16:17:45 -0400
Message-ID: <20260826201745.43267-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Changes in v2:
- Keep the RCU read-side critical section active through xfrm_fill_dst()
  instead of taking a temporary device reference, as suggested by
  Steffen.

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
2.55.0

