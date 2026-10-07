Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561EB472551;
	Wed,  7 Oct 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365773; cv=none; b=B2677A2xpOvQQwTpjeEyo+NLE0OQ+GAnlntC4hjWEDumQT0DRjCb7X+b3Y26Vh7vxfybnuR0KRDgkvf8uHgkVsjV749/RRSsZKNAyBFoIFPZdslerX1UZLuew5JEDaufiASuM9PffypewPwIXOOMFn9iCUFKVyY9gNeS8uX++Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365773; c=relaxed/simple;
	bh=ZH1f/H8Fh4vX/luAQ/6zICcJVZllTWTaFdoYU3cENBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0G/OhfGbUQ0Y5jMLv9dcGm3PDABzG84sPAzjAAmtvI6fFNiy0bdcAlEdywcQtE0L8CmUzzvjBMgb5kZk0+0eoPngmbXbF95Bhasi+7958dGDRTROeyy1L40aY0786HlaprphAt4XXrI3TIAio6Se3Y0Ylq8Ipuu9BsYrlbyXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=At62KsmJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="At62KsmJ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AB8092084B;
	Wed,  7 Oct 2026 11:35:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8UMRbVAkSzz; Wed,  7 Oct 2026 11:35:57 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DBE0020764;
	Wed,  7 Oct 2026 11:35:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DBE0020764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365757;
	bh=FqDZ4i4jaXyz88J2KJyeoWP+h/RJz+6Kip2B/Ve/k0A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=At62KsmJGELoMmXYMFjmE9u6RptDQmEbx52kuYXskR4eLPaz7kx9MGSxPn/mGWDhR
	 MotE3Piz/TUM/V3+PM4zM/Ks2HdQ7IHyF34GVEDXIQT/nl9erX7JRPaG3RzgDkzErT
	 JS0UczGn5HtUBn6Awn8mH/pCm1L4D5gnydpv/qbPedvmP5krwsi9565HRhjwTVsfu/
	 bMkOqvN58+dGX2/4JXjePfw6ifQJaRpm/Tr6yHBdSpg3YO7Jt7HHdtezXypglEzmE7
	 PObZCnqp/cIG5t0A9DRrYsRBkQq5t6177EGjpR4Quj7D41dIHGDrPnZ/W5rUtX8cMP
	 FqYT0R3TOnqZA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:35:56 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>, Sashiko
	<sashiko-bot@kernel.org>
Subject: [PATCH ipsec v5 7/9] xfrm: include mark in MIGRATE_STATE SA collision check
Date: Wed, 7 Oct 2026 11:35:48 +0200
Message-ID: <migrate-state-fixes-v5-7-d9d3d794553d@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
References: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

The SA lookup tuple is (daddr, spi, proto, family, mark), but the
EEXIST pre-check and the xfrm_state_insert() vs xfrm_state_add()
decision only considered daddr and family, ignoring mark.
A migration that only changes the mark inserts a duplicate SA tuple
into the hash tables.

The collision check is implemented as xfrm_state_mark_collides(),
which walks the SPI hash bucket for the target tuple and excludes the
state being migrated by pointer, rather than doing a separate
exact-match lookup followed by a wildcard lookup and comparing the
result against self.

Before:
root@west:~# ip xfrm state add src 10.1.1.1 dst 10.1.1.2 proto esp \
        spi 0x1000  reqid 100 mode tunnel aead "rfc4106(gcm(aes))" \
        0x1111111111111111111111111111111111111111 96 \
        mark 0x1 mask 0xff

root@west:~# ip xfrm state add src 10.1.1.1 dst 10.1.1.2 proto esp \
        spi 0x1000  reqid 100 mode tunnel aead "rfc4106(gcm(aes))" \
        0x1111111111111111111111111111111111111111 96 \
        mark 0x2 mask 0xff
root@west:~# ip xfrm state migrate dst 10.1.1.2 proto esp spi 0x1000 \
        mark 0x1 mask 0xff \
        new-dst 10.1.1.2 new-src 10.1.1.1 new-reqid 100 \
        new-mark 0x2 mask 0xff
ip x s
src 10.1.1.1 dst 10.1.1.2
    proto esp spi 0x00001000 reqid 100 mode tunnel
    replay-window 0
    mark 0x2/0xff
    aead rfc4106(gcm(aes)) 0x1111111111111111111111111111111111111111 96
    anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
src 10.1.1.1 dst 10.1.1.2
    proto esp spi 0x00001000 reqid 100 mode tunnel
    replay-window 0
    mark 0x2/0xff
    aead rfc4106(gcm(aes)) 0x1111111111111111111111111111111111111111 96
    anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
    sel src 0.0.0.0/0 dst 0.0.0.0/0

Notice two states with same mark 0x2/0xff.
After:

Error: New SA tuple already occupied.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v1->v2: pre-check used wildcard lookup; factored the check into
xfrm_state_mark_collides() excluding self directly instead of
lookup_exact()+lookup() with a pointer comparison
---
 include/net/xfrm.h    |  4 ++++
 net/xfrm/xfrm_state.c | 40 +++++++++++++++++++++++++++++++++++++---
 net/xfrm/xfrm_user.c  | 17 ++++++++---------
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 9e053388aa4b..26dd4b570588 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1751,6 +1751,10 @@ struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 struct xfrm_state *xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
 					   const xfrm_address_t *daddr, __be32 spi,
 					   u8 proto, unsigned short family);
+bool xfrm_state_mark_collides(struct net *net, u32 mark,
+			      const xfrm_address_t *daddr, __be32 spi,
+			      u8 proto, unsigned short family,
+			      const struct xfrm_state *self);
 #ifdef CONFIG_XFRM_SUB_POLICY
 void xfrm_tmpl_sort(struct xfrm_tmpl **dst, struct xfrm_tmpl **src, int n,
 		    unsigned short family);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f1e04df8d501..65663c7ba836 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2202,10 +2202,12 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct netlink_ext_ack *extack)
 {
 	if (m->new_family == m->old_family &&
-	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
+	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) &&
+	    xc->mark.v == x->mark.v && xc->mark.m == x->mark.m) {
 		/*
-		 * Care is needed when the destination address of the state is
-		 * to be updated as it is a part of triplet.
+		 * Care is needed when the destination address or mark of the
+		 * state is to be updated, as they are part of the lookup
+		 * triplet.
 		 */
 		xfrm_state_insert(xc);
 	} else {
@@ -2440,6 +2442,38 @@ xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_exact);
 
+/* True if some OTHER state at this tuple would wildcard-match "mark".
+ * Used by MIGRATE_STATE, which must exclude the state being migrated.
+ */
+bool xfrm_state_mark_collides(struct net *net, u32 mark,
+			      const xfrm_address_t *daddr, __be32 spi,
+			      u8 proto, unsigned short family,
+			      const struct xfrm_state *self)
+{
+	struct xfrm_hash_state_ptrs state_ptrs;
+	unsigned int h;
+	struct xfrm_state *x;
+	bool collides = false;
+
+	rcu_read_lock();
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+	h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs.hmask);
+
+	hlist_for_each_entry_rcu(x, state_ptrs.byspi + h, byspi) {
+		if (x != self && x->props.family == family &&
+		    x->id.spi == spi && x->id.proto == proto &&
+		    xfrm_addr_equal(&x->id.daddr, daddr, family) &&
+		    (mark & x->mark.m) == x->mark.v) {
+			collides = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return collides;
+}
+EXPORT_SYMBOL(xfrm_state_mark_collides);
+
 struct xfrm_state *
 xfrm_find_acq(struct net *net, const struct xfrm_mark *mark, u8 mode, u32 reqid,
 	      u32 if_id, u32 pcpu_num, u8 proto, const xfrm_address_t *daddr,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 4de8c401eb44..a5fbe38839c4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3476,15 +3476,14 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 						       x->nat_keepalive_interval);
 
 	if (m.new_family != um->id.family ||
-	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family)) {
-		u32 new_mark_key = m.new_mark ? m.new_mark->v & m.new_mark->m :
-						m.old_mark.v & m.old_mark.m;
-		struct xfrm_state *x_new;
-
-		x_new = xfrm_state_lookup(net, new_mark_key, &m.new_daddr,
-					  um->id.spi, um->id.proto, m.new_family);
-		if (x_new) {
-			xfrm_state_put(x_new);
+	    !xfrm_addr_equal(&m.new_daddr, &um->id.daddr, um->id.family) ||
+	    (m.new_mark && (m.new_mark->v != x->mark.v ||
+			   m.new_mark->m != x->mark.m))) {
+		const struct xfrm_mark *new_mark = m.new_mark ? m.new_mark : &x->mark;
+
+		if (xfrm_state_mark_collides(net, new_mark->v & new_mark->m,
+					     &m.new_daddr, um->id.spi,
+					     um->id.proto, m.new_family, x)) {
 			NL_SET_ERR_MSG(extack, "New SA tuple already occupied");
 			err = -EEXIST;
 			goto out;

-- 
2.47.3

