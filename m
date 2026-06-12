Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0E38E113
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240354; cv=none; b=aGtR5AzBDwv9TeiYvRFHwFTxJaCA6w1uaj8nZxWkCZH1LGP/8sJvaEhh9TBGS+gfZX4m97vhimBT+QDlaApSmfkt3MdWOc3/v910SYPR3HuUVE1ybSzVGJW/pb1oXmPCtBinsfC0SxQi4OfHtm2Z/DBaTer1hbTiXZQch/y58ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240354; c=relaxed/simple;
	bh=7oTYI04MAYoRHOpFeH/jqNB8neEq3iF8IpgdkeRUBFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iJKhABul9O90Z4GI1JAQrb4Qx31i5NP4O2/+AroM/gOoTCxYogH9+D6y8uMKVZLzaX979BJ2eTIWndfDmTxgWq9GJnnpH9YiBFx3dTnDjNfsYqzlqrf6NaFqJv8WuV26j5Jhhdw8wHIwvm+rJY8rO9pvQaGIR1L3WUnO3oav/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=E8/QUFN5; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="E8/QUFN5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	Cc:To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=8yaVsrZX37yqixZhEhe/eJ8l5qAlfmJzUBT+ebhReZU=; b=E8/QU
	FN5erARVIG5NKnrxP8rSNjbb+JK/wka7USzwqHpztEHgGOwbpqhxO+rYWx4/K2JwtLI9f1qx3QuAc
	msYaXmP/xM8NqIl0ErjeRNcqWd9NkYNRcJq//IG/YzI/+TkdIJ+d9gBzdCOaF13K2TQyRVivjaunr
	we7GCJAkG56kNuslwDAVFxIIf/lYRtZNHFyX5W29kaybRqxXSWvS8YWFdPwR5NXktpSUDA+TcPF9c
	2HF49aFE5hejyR03qcqWkAsUnYO0bEx7O5mONQ1CEFV9M+YN+dqj+Dc3/eXYbNdSlsDs94a1JZck5
	eNqeUlJjud+wwDtWg8L6SGMlKGTAA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXtyt-00000004nXg-2n9P;
	Fri, 12 Jun 2026 12:59:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2026 12:58:59 +0800
Date: Fri, 12 Jun 2026 12:58:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
	Willy Tarreau <w@1wt.eu>
Subject: [PATCH] xfrm: Fix xfrm state cache insertion race
Message-ID: <aiuSE5J-U8SuoZnk@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..bc669f0d6e0e 100644
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
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
