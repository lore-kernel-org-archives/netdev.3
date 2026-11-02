Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606693;
	b=sKIJBeaHjKK8HdRghJxD5HvIDR5SDJVMfv0URqdtWILhXrFxZU5BYnFlB9ydJv0cNqkx
	 6WjUwZvyKqnXrEnY66P7ZIYfqu1hAOPy8VOxUmECIT5RDpUHqOAmt4f7UoH1opVAlmnp/
	 CCClq9ewcfrdrauEMMvTPeB1J58ktT+vm3k+didG6UY/49uTr5pin/Q8LzKPEDZGZqpwm
	 iq2IzyymcyKZHovIplIVkFURGMRtOIOBNqszwfq2KTxfGakqgVif4LaWxzIoA7CQR89WY
	 LhCKCs1A/RA6aM3jCVSRQ2skCVK4cisaAJA4ivB/CGwVxE4WBr6RPrvo3YRY12B+EZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606693;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=/X9CEGzVktCVEaMBS68IEDSXgcNVBOiN3gNyicrU2Ow=;
	b=R1aXqVyGn6S+6GVlWBlqx6530xJBWR9En8bRCVjmuFjL+Dhn+RFojwXZVNVG9+LrGpWC
	 coWtK8bCzL7NDUhZ0rTB9iKvbyzfRKx3C5Af5U+HfyoEx/AHvG+GMWcCnUrv+FqKKyTLF
	 CHyXyKWE0m/OHdBe91I6KYpQJAV/1t7vt6OtdAD0ipkitKbpTcH8AoTb6JRLN1WAMZ3/L
	 yc47fqI0MCqSk36RNwaGojTSnIB3otg6nVv0gesz/5fidlcTr09+Jy7Ihmgh/IN+0mvbn
	 wAy2hsaW5QVTPRqFvY+aLxd7Sc794kPGRTj2R6jmQO8Wv6NhpJ8R703hVnNnQthuGYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=fOOhRmMJ;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7F60A2635
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB7F60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=fOOhRmMJ
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 207C7207A4;
	Mon,  2 Nov 2026 09:04:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XTACefF-H0vI; Mon,  2 Nov 2026 09:04:50 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5C13B207B0;
	Mon,  2 Nov 2026 09:04:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5C13B207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606690;
	bh=/X9CEGzVktCVEaMBS68IEDSXgcNVBOiN3gNyicrU2Ow=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=fOOhRmMJLbdT5DMs+CR3HzoXbfuYYTDLZYlSxFx7lk/d5X3btjkCu0+FSjQgdAzX3
	 LM7NdnehycyCFNXWjZe2mj+EBotEsmfWxyxrMt4m02XL+myJ7zFTVGyc+j5ogM+Yma
	 9CbC2fuVFsnwmWFTGHXEnpJz20EkyGDXCDryBzAzQPwIRO63lf3ql4ncHm4ZmEFU9Z
	 Io5PpxiIwlvKue+Fht/PiEdrAUo4KEotWjZaW9ojWCxpPpLNrDQT6dTKV3OUDs63rz
	 Gx98/l3f/SaATK3HhBePkPK7/LdS9J2Nfvc6FXBXkfiRuXkA9eL1MP8nic9yO7nxXK
	 8EWwLUrzpm4Hw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:49 +0100
Received: (nullmailer pid 2505921 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/14] xfrm: include mark in MIGRATE_STATE SA collision check
Date: Mon, 2 Nov 2026 10:04:09 +0000
Message-ID: <20261102100451.2505200-12-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100451.2505200-1-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

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
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.53.0

