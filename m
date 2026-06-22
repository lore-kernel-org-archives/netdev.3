Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2738331F
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115066; cv=none; b=rYgikycNEZEvsJkqn0dI6waCKaz88PsJEjdMmVL616AVeJj15rEjkoUJgP2urZj2vx1yHOMgG8gaC6YxbIN6uTx+nRoybPO65lluWY3hRq5Acj8hp+IsFUnQPI/kb2F23PayOmohL1YOKW5Ga+9fm46yhhhBvVNQ63zB485hBfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115066; c=relaxed/simple;
	bh=9VETRhtmhmsevM9PRrNxMDLG6mG50k91IkUCkAGSwYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxPvCFOuv5MYCGHeiJ8h0LXR807cX5RaFpfdMETU2pcdncs7V2ShQ+iCRM678sEoz0rtzg988mKQru8O+LDDWeqUqp+iCz6bYhDVhKfQfAXu0IxqEeTja9jjl885DXZwx74st+G6NZgUxoiHbAMX41RW6Lt5m/JwxkrjtbTzitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EswTFgHM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EswTFgHM"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 39570207B0;
	Mon, 22 Jun 2026 09:57:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1U8W_C9IaQBe; Mon, 22 Jun 2026 09:57:36 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5D8A620684;
	Mon, 22 Jun 2026 09:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5D8A620684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1782115056;
	bh=7GrGSDeuaHnkrn0zJNIn95FIE4mY2ajeQiQA9sOmItk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=EswTFgHMANrhAiovvWaQmiZ0V5Qd1ReKh8WFaMJuATDFwST5sbKowsKy6BYZ0tGDs
	 BhOFSlTxQuJeBua5yYgkFMoAkvK7Fh+EWeAbcaMxQUjvv7CaFsSzY850hhuLY1HtYG
	 8UYIXVilb/op0hiXMc27HXqqfCMckHrXYpp4lpSambNUhoAoDHmDQyOQuufCf5XOTJ
	 UmyDmNnU7Le+U0Gx6QJDIaBonJUp82HpkkTeh19b/X0mwqyuhhDGJsT+ZIuF7vj27r
	 H4W20d+Slsytfb+FSCklyWh842rHc087u2wclkyOAY4B+/FCLAY7RBjNnKUAizLOqn
	 QXnvLA7BJ7AWA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 09:57:35 +0200
Received: (nullmailer pid 30064 invoked by uid 1000);
	Mon, 22 Jun 2026 07:57:32 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/7] xfrm: Fix xfrm state cache insertion race
Date: Mon, 22 Jun 2026 09:57:06 +0200
Message-ID: <20260622075726.29685-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622075726.29685-1-steffen.klassert@secunet.com>
References: <20260622075726.29685-1-steffen.klassert@secunet.com>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

The xfrm input state cache insertion code checks the validity of
the state before acquiring the global xfrm_state_lock.  Thus it's
possible for someone else to kill the state after it passed the
validity check, and then the insertion will add the dead state
to the cache.

Fix this by moving the validity check inside the lock.

This entire function is called on the input path, where BH must
be off (e.g., the caller of this function xfrm_input acquires
its spinlocks without disabling BH).

So there is no need to disable BH here or take the RCU read lock.
Remove both and replace them with an assertion that trips if BH
is accidentally enabled on some future calling path.

Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index d8457ceaf28c..9e87f7028201 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1207,9 +1207,11 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 	struct hlist_head *state_cache_input;
 	struct xfrm_state *x = NULL;
 
+	/* BH is always disabled on the input path. */
+	lockdep_assert_in_softirq();
+
 	state_cache_input = raw_cpu_ptr(net->xfrm.state_cache_input);
 
-	rcu_read_lock();
 	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
 		if (x->props.family != family ||
 		    x->id.spi       != spi ||
@@ -1227,20 +1229,25 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
 	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
-
-	if (x && x->km.state == XFRM_STATE_VALID) {
-		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		if (hlist_unhashed(&x->state_cache_input)) {
+	if (x) {
+		spin_lock(&net->xfrm.xfrm_state_lock);
+		if (x->km.state != XFRM_STATE_VALID) {
+			/*
+			 * The state is about to be destroyed.
+			 *
+			 * Don't add it to the cache but still
+			 * return it to the caller.
+			 */
+		} else if (hlist_unhashed(&x->state_cache_input)) {
 			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
 		} else {
 			hlist_del_rcu(&x->state_cache_input);
 			hlist_add_head_rcu(&x->state_cache_input, state_cache_input);
 		}
-		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+		spin_unlock(&net->xfrm.xfrm_state_lock);
 	}
 
 out:
-	rcu_read_unlock();
 	return x;
 }
 EXPORT_SYMBOL(xfrm_input_state_lookup);
-- 
2.43.0

