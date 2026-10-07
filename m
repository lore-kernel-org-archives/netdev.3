Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D21A3029
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337694; cv=none; b=apPpoGWdLZxSsrOWtsqcQQXcUxFByenNT+bys3uA84Dsh5iCaiqcmz+0VZLaBGbTARL2zXVP81JhwKaIZrb64og+PuOnOtdXpUiGTcwAFxrLgz+2DQQkjUeH/m5E2cYtpn4CNg0XKWGqvuk2JjKyWE8oF3VpPsNs69kPbtl/a8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337694; c=relaxed/simple;
	bh=f91kVa1SnteaYVPhRYgPS0d0Msq8i52Kp/zORt7FXgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzoV+Acv0FE4aomS7WP0mbfHmIqokLz7bIBBf0VVb6LbcPNQhlKRr/Ji1b6Z8kA3GynjCrp6gNYBXh0bIPv0CM/PHkZ+eVg42yfjuj1OmuePZu3kQyyUKbbuqwlkvYDNveQrOTVN9hN7TvoMhBBDN8tmeqSf6hcSenfkhTki+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twbw23fF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twbw23fF"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a4a7eb86a4so1064948a91.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 18:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337692; x=1791942492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sG3CdAIWHpBKyehkdlkkQ/ER3qu8k3On1q5+xe+2nI0=;
        b=Twbw23fFXO7VtbsyuIYvBvMhSCBSB4ZFtZooQkBDMR2m04CQW6v8x3YFECZ/pjSOtd
         UKSZrW8Ub8o6tql6x24eUiEX2ZZTU8m3+v6k0405QR7hDLk49V/VuADLbf/rwVi5z/Gt
         wDjCA2LWBOTuynmQCdK6jdtIySAUasGAUi1MU8c6zu3B7wkSFIUdODdQYrZ4cFF23/Vv
         utLrPzXPhDmK5IIUfr1HbcIGb4QV2EY18nwSiadnnzdJ10A3js+de6LQ0QIa5zTZGfoi
         vI29h6xtUJz9RWdNVrl76WKp0PnZKevBTjxvT7pfC/DPYikfLBp2Z6e3KzRaREo2Wd/9
         e0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337692; x=1791942492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sG3CdAIWHpBKyehkdlkkQ/ER3qu8k3On1q5+xe+2nI0=;
        b=GKUPqMhuEfyQ9xAjI/b+lcI8SkhfAmf8Cvtvyt6DzVjZ20Plon44Erl6FIZC5tkwr8
         Kuf5+VcmvP8ce5DUZgJT4QduOM5Myo2t0ZzvwNPbXyyxZvPpPqzXrFwiGQuSt156+U+u
         Cp4rkaa5Vv1dUo2hWY9uIuHyGYLRDC97cdw2tRycMq5oRWj0yqzsBr4Wl0e8dOskeG4o
         /tuZGkyprt7HvnfyJN8a2214aYd5hATBhNm4W9qaNKr8nD2mHr2WUlDRanE1n01nRBmL
         /TNCsaeN7m6YagfZmBW/WInC93r4wge+mR0pEXAB7KdkBrEDLQxhtVLzAj5zHeWipKaO
         FlBA==
X-Forwarded-Encrypted: i=1; AKwUvBy9yxy8nteEu5pEkPW0/hoM4qa0/TxxI3XVQxOVeTx5ukwF3koYb8+CR6Oi4882fB84Z6OfKuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxpDpUN7cWzvYB0RZWemGPHxT4FRu9FyFZ1t+25w+HKn93WKFl
	ZyKx70Vcz1gHGalmxm0S2iyE/R3NZxpvLGsHDK5d1Y440OKfGDNdwLeILFHNkvPv
X-Gm-Gg: AYBFou1crp8aWPlb3NGaeWhyA303AihLomohC7LLsCbJAZ54wqyXq5uRR5wXszTbxq6
	TSK1axQeY1NT/d4A98VsJrJsbJD2YpBnE9APLpgfpqP1FupvKfZlMETQYs8H//5IsYQkxeoHFVx
	lsBJSsgNVpo30mWlJxarg2dHAbr0UafNK5XRbCwRSYkuWDQGPsj+8cWdpOQUrl4gW7Z8NqcZpxb
	o+c30/1mHsSprcb28SbfTtzIOSKOiYQiGH57STmvuTUxyWUzgRPW8qBt0Wtk+AJpZm/o7jqMBVY
	IEOAoxuCNSFCR4613JwIi1593rEvWgoDkAFloM2B229Neadd5Nm0+ul4SMO01KdxFXwtNu0t3bR
	CoFTmJwTq4ykNwRCU1kCU39zjfob+q9PBHD7y2Z5BoY00w3YCmgEbRqxwy0kAT2qgEHbI2SiIes
	LP6kw8B4WsoPN7HANm9pRAWvo4NWlBPgFL0DYGwK12E0OTrgi8nR/8va5PsXu7R3Kny2xamrH72
	tdzxrL+TBs=
X-Received: by 2002:a17:90b:134c:b0:3a4:ef4a:4f12 with SMTP id 98e67ed59e1d1-3a8a1c12ec1mr592405a91.61.1791337691999;
        Tue, 06 Oct 2026 18:48:11 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a5f778fasm442161a91.3.2026.10.06.18.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:48:11 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	4ncienth@gmail.com
Subject: [PATCH net v3] netfilter: conntrack: avoid recursive master destruction
Date: Wed,  7 Oct 2026 10:48:02 +0900
Message-ID: <20261007014802.2615503-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A conntrack holds a reference to its master. Userspace can build an
unbounded acyclic chain through ctnetlink. Expectation producers can do the
same: an nft ct expectation can attach its helper to an unconfirmed
expected child and arm the next expectation with that child as master. The
H.323 Q.931 helper can also propagate itself through call-forwarding
expectations.

When only child-held references remain, destroying the leaf calls
nf_ct_put() on its master. If that was the final reference, nf_ct_put()
recurses into nf_ct_destroy(). Repeating this at each level exhausts the
task stack and panics.

Nested expectations are existing helper semantics, and CTA_TUPLE_MASTER
was introduced for conntrackd state replication. Avoid per-producer
restrictions. Decrement the master's refcount directly, then free the
current conntrack. If the refcount reached zero, continue destroying the
master in the same invocation. This preserves existing constructors while
bounding stack use.

Fixes: 5faa1f4cb5a1 ("[NETFILTER]: nf_conntrack_netlink: add support to related connections")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/179127347858.434549.11821822167265441355@kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
v3:
- restore iterative destruction after Sashiko identified nft expectation
  paths that bypass v2
- document conntrackd compatibility and expectation producers
- do not carry Florian's v2 Reviewed-by to the changed patch
v2: https://patch.msgid.link/20261002165601.1754467-1-4ncienth@gmail.com
- replace v1 with ctnetlink entry-point restrictions
v1: https://patch.msgid.link/20261001180224.1018290-1-4ncienth@gmail.com

The source reproducer remains available privately on request. V3 has the same
code and stable patch-id 033ffbf1094d as v1. Code-identical earlier net and
exact v6.12.105 6,000-entry userns runs reclaimed every conntrack without a
crash marker. On fresh net 0984ebc63179, nf_conntrack_core.o builds W=1 clean.
The patch applies to current net, Torvalds, net-next, linux-next, v7.3-rc5 and
v6.12.105. Strict checkpatch is clean. allyesconfig and allmodconfig W=1 were
not run.

 net/netfilter/nf_conntrack_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d0d9e5ea84a095..0ce6141b3dfd70 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -592,6 +592,10 @@ static void warn_on_keymap_list_leak(const struct net *net)
 void nf_ct_destroy(struct nf_conntrack *nfct)
 {
 	struct nf_conn *ct = (struct nf_conn *)nfct;
+	struct nf_conn *master;
+	bool destroy_master;
+
+again:
 
 	WARN_ON(refcount_read(&nfct->use) != 0);
 
@@ -610,10 +614,17 @@ void nf_ct_destroy(struct nf_conntrack *nfct)
 	 */
 	nf_ct_remove_expectations(ct);
 
-	if (ct->master)
-		nf_ct_put(ct->master);
+	master = ct->master;
+	destroy_master = master &&
+		refcount_dec_and_test(&master->ct_general.use);
 
 	nf_conntrack_free(ct);
+
+	if (destroy_master) {
+		ct = master;
+		nfct = &ct->ct_general;
+		goto again;
+	}
 }
 EXPORT_SYMBOL(nf_ct_destroy);
 
-- 
2.55.0

