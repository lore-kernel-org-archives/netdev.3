Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606688;
	b=Ixhf5gV0Lmc6z6Y2uWgcXGSvKCOLaTMiC32GoUwSZoy2ARWcIOucfGXKPQNhtAHq3/Kb
	 d6jAFKFOK7dyokJcGRijjiSXUDtljaDfdeiOqAd8mt24g/FMFtVS5wOAZ3X7tlANB1gdh
	 PZlHNWYcTtQO+5yY7c/raoKpsS9I49Xg2efzdmuDd4zJzMIRVrPm7b4weqcHd3fgrQmCM
	 r8wgXVs2cHGY/hnHw0SB8rU6l/qtvUC0f5JwGFb4B3/pnFHqdVEtkoHaDgOm/04OcuUWO
	 JSEa9tmdp8SAf/wb8PDqTlSeMLutO85ydDJT6QV/3CQSI22DvSoUJ+HoCnChL0vDtAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606688;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=xvEy+v5LqCAxZn63wMadtvXPHC27LBOmLc9akLMPl8Y=;
	b=eyN6b5labtzhshXSLpjTUff0jftm5RYlvGSxuh/ZVSCLOzXv64FnKGTtOwR7NSaJbn1r
	 cb1rTWE5t+AcYu5YrjwMP+gIp/Woxbj5IdzEzcdpgAP8S3UZq4PV7V/VvMQqcDrfsuGqJ
	 ZTJHCQJhSEFHZZPGpXzWFHe68DYFIDgbAZaKVUwwT26tGu4w5Z+uIXyYJ057Dz1Qv8ZA0
	 SuVfWWYF+gA1WRbncog2Y0MVkT4V7tlQZ07nNzZbLCmqzYFTm/WOcJ0AE2r02V96JG/+q
	 YtDGDuju3Id6Vy7pEqgg8hieKtRa/jsAxJMXzLVNeeEmi6zAkbF/f3Q62xuVv0VVp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=R69YqXGm;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77529606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77529606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=R69YqXGm
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DB5E420520;
	Mon,  2 Nov 2026 09:04:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3sX1f80iDwP4; Mon,  2 Nov 2026 09:04:39 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 06800207BB;
	Mon,  2 Nov 2026 09:04:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 06800207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606679;
	bh=xvEy+v5LqCAxZn63wMadtvXPHC27LBOmLc9akLMPl8Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=R69YqXGm5VLkR+lR+N8Rm2x/3vjw/30dYBx5LHKOw+lFJE6UGVBccAMXRF+YC7Jw/
	 JK3mCQD1y5V7Hd8E6vVn2jzXjBX+wzE+UsWBs7ti77csCR1BRYVhSg2/J+87Qhc7ik
	 9vWE9QcY2sZIdWUzBe9VIlFg8A52FQmP0onYp5WRZk5/Mwh0YT16cC5vufco2rMQnW
	 G/rjK4QeoZNZJg9tD8RoPSmqV6+XXAPgyHTZvyG0ln4Izo3jF/p5ej/ifNSA98ahEM
	 PPOE9ARIMCyhMttPXVrWZh0e6q4V7RaxGxRkGOXR9YmtF8mkA6HRl/OFTYiScVjKi8
	 hqxaMbM3UVkQg==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:38 +0100
Received: (nullmailer pid 2505912 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/14] xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
Date: Mon, 2 Nov 2026 10:04:06 +0000
Message-ID: <20261102100451.2505200-9-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

Add __xfrm_state_lookup_exact(); wire it into DELSA/GETSA, GETAE/NEWAE,
EXPIRE, MIGRATE_STATE.  xfrm_state_update() (UPDSA) keeps wildcard match
because ALLOCSPI's larval state may be unmarked (mark 0/0), so an
exact-match UPDSA would not find it and the ADD fallback would then
fail with -EEXIST via xfrm_state_add().

Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    |  3 +++
 net/xfrm/xfrm_state.c | 56 +++++++++++++++++++++++++++++++++++--------
 net/xfrm/xfrm_user.c  | 29 +++++++++++-----------
 3 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index a6d69aaa6cd2..9e053388aa4b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1748,6 +1748,9 @@ struct xfrm_state *xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 					    const xfrm_address_t *saddr,
 					    u8 proto,
 					    unsigned short family);
+struct xfrm_state *xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
+					   const xfrm_address_t *daddr, __be32 spi,
+					   u8 proto, unsigned short family);
 #ifdef CONFIG_XFRM_SUB_POLICY
 void xfrm_tmpl_sort(struct xfrm_tmpl **dst, struct xfrm_tmpl **src, int n,
 		    unsigned short family);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 602404ffc4d4..f1e04df8d501 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1177,11 +1177,19 @@ static struct xfrm_state *__xfrm_state_lookup_all(const struct xfrm_hash_state_p
 	return NULL;
 }
 
-static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
-					      u32 mark,
-					      const xfrm_address_t *daddr,
-					      __be32 spi, u8 proto,
-					      unsigned short family)
+static bool xfrm_state_mark_matches(const struct xfrm_state *x, u32 mark, u32 mask, bool exact)
+{
+	if (exact)
+		return x->mark.v == mark && x->mark.m == mask;
+	return (mark & x->mark.m) == x->mark.v;
+}
+
+static struct xfrm_state *
+__xfrm_state_lookup(const struct xfrm_hash_state_ptrs *state_ptrs,
+		    u32 mark, u32 mask, bool exact,
+		    const xfrm_address_t *daddr,
+		    __be32 spi, u8 proto,
+		    unsigned short family)
 {
 	unsigned int h = __xfrm_spi_hash(daddr, spi, proto, family, state_ptrs->hmask);
 	struct xfrm_state *x;
@@ -1193,7 +1201,7 @@ static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs
 		    !xfrm_addr_equal(&x->id.daddr, daddr, family))
 			continue;
 
-		if ((mark & x->mark.m) != x->mark.v)
+		if (!xfrm_state_mark_matches(x, mark, mask, exact))
 			continue;
 		if (!xfrm_state_hold_rcu(x))
 			continue;
@@ -1203,6 +1211,17 @@ static struct xfrm_state *__xfrm_state_lookup(const struct xfrm_hash_state_ptrs
 	return NULL;
 }
 
+static struct xfrm_state *
+__xfrm_state_lookup_exact(const struct xfrm_hash_state_ptrs *state_ptrs,
+			  const struct xfrm_mark *mark,
+			  const xfrm_address_t *daddr,
+			  __be32 spi, u8 proto,
+			  unsigned short family)
+{
+	return __xfrm_state_lookup(state_ptrs, mark->v, mark->m, true,
+				   daddr, spi, proto, family);
+}
+
 struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 					   const xfrm_address_t *daddr,
 					   __be32 spi, u8 proto,
@@ -1233,7 +1252,7 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
 
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
-	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
+	x = __xfrm_state_lookup(&state_ptrs, mark, 0, false, daddr, spi, proto, family);
 	if (x) {
 		spin_lock(&net->xfrm.xfrm_state_lock);
 		if (x->km.state != XFRM_STATE_VALID) {
@@ -1283,7 +1302,7 @@ static struct xfrm_state *__xfrm_state_lookup_byaddr(const struct xfrm_hash_stat
 	return NULL;
 }
 
-static inline struct xfrm_state *
+static struct xfrm_state *
 __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 {
 	struct xfrm_hash_state_ptrs state_ptrs;
@@ -1293,7 +1312,7 @@ __xfrm_state_locate(struct xfrm_state *x, int use_spi, int family)
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
 	if (use_spi)
-		return __xfrm_state_lookup(&state_ptrs, mark, &x->id.daddr,
+		return __xfrm_state_lookup(&state_ptrs, mark, 0, false, &x->id.daddr,
 					   x->id.spi, x->id.proto, family);
 	else
 		return __xfrm_state_lookup_byaddr(&state_ptrs, mark,
@@ -2380,7 +2399,7 @@ xfrm_state_lookup(struct net *net, u32 mark, const xfrm_address_t *daddr, __be32
 	rcu_read_lock();
 	xfrm_hash_ptrs_get(net, &state_ptrs);
 
-	x = __xfrm_state_lookup(&state_ptrs, mark, daddr, spi, proto, family);
+	x = __xfrm_state_lookup(&state_ptrs, mark, 0, false, daddr, spi, proto, family);
 	rcu_read_unlock();
 	return x;
 }
@@ -2404,6 +2423,23 @@ xfrm_state_lookup_byaddr(struct net *net, u32 mark,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byaddr);
 
+struct xfrm_state *
+xfrm_state_lookup_exact(struct net *net, const struct xfrm_mark *mark,
+			const xfrm_address_t *daddr, __be32 spi,
+			u8 proto, unsigned short family)
+{
+	struct xfrm_hash_state_ptrs state_ptrs;
+	struct xfrm_state *x;
+
+	rcu_read_lock();
+	xfrm_hash_ptrs_get(net, &state_ptrs);
+
+	x = __xfrm_state_lookup_exact(&state_ptrs, mark, daddr, spi, proto, family);
+	rcu_read_unlock();
+	return x;
+}
+EXPORT_SYMBOL(xfrm_state_lookup_exact);
+
 struct xfrm_state *
 xfrm_find_acq(struct net *net, const struct xfrm_mark *mark, u8 mode, u32 reqid,
 	      u32 if_id, u32 pcpu_num, u8 proto, const xfrm_address_t *daddr,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c1571c7a2315..5a9f729b4fcb 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1109,11 +1109,12 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 	struct xfrm_state *x = NULL;
 	struct xfrm_mark m;
 	int err;
-	u32 mark = xfrm_mark_get(attrs, &m);
+
+	xfrm_mark_get(attrs, &m);
 
 	if (xfrm_id_proto_match(p->proto, IPSEC_PROTO_ANY)) {
 		err = -ESRCH;
-		x = xfrm_state_lookup(net, mark, &p->daddr, p->spi, p->proto, p->family);
+		x = xfrm_state_lookup_exact(net, &m, &p->daddr, p->spi, p->proto, p->family);
 	} else {
 		xfrm_address_t *saddr = NULL;
 
@@ -1124,7 +1125,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 		}
 
 		err = -ESRCH;
-		x = xfrm_state_lookup_byaddr(net, mark,
+		x = xfrm_state_lookup_byaddr(net, m.v & m.m,
 					     &p->daddr, saddr,
 					     p->proto, p->family);
 	}
@@ -2821,14 +2822,13 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct sk_buff *r_skb;
 	int err;
 	struct km_event c;
-	u32 mark;
 	struct xfrm_mark m;
 	struct xfrm_aevent_id *p = nlmsg_data(nlh);
 	struct xfrm_usersa_id *id = &p->sa_id;
 
-	mark = xfrm_mark_get(attrs, &m);
+	xfrm_mark_get(attrs, &m);
 
-	x = xfrm_state_lookup(net, mark, &id->daddr, id->spi, id->proto, id->family);
+	x = xfrm_state_lookup_exact(net, &m, &id->daddr, id->spi, id->proto, id->family);
 	if (x == NULL)
 		return -ESRCH;
 
@@ -2869,7 +2869,6 @@ static int xfrm_new_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_state *x;
 	struct km_event c;
 	int err = -EINVAL;
-	u32 mark = 0;
 	struct xfrm_mark m;
 	struct xfrm_aevent_id *p = nlmsg_data(nlh);
 	struct nlattr *rp = attrs[XFRMA_REPLAY_VAL];
@@ -2889,9 +2888,10 @@ static int xfrm_new_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return err;
 	}
 
-	mark = xfrm_mark_get(attrs, &m);
+	xfrm_mark_get(attrs, &m);
 
-	x = xfrm_state_lookup(net, mark, &p->sa_id.daddr, p->sa_id.spi, p->sa_id.proto, p->sa_id.family);
+	x = xfrm_state_lookup_exact(net, &m, &p->sa_id.daddr, p->sa_id.spi,
+				    p->sa_id.proto, p->sa_id.family);
 	if (x == NULL)
 		return -ESRCH;
 
@@ -3025,9 +3025,10 @@ static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_user_expire *ue = nlmsg_data(nlh);
 	struct xfrm_usersa_info *p = &ue->state;
 	struct xfrm_mark m;
-	u32 mark = xfrm_mark_get(attrs, &m);
 
-	x = xfrm_state_lookup(net, mark, &p->id.daddr, p->id.spi, p->id.proto, p->family);
+	xfrm_mark_get(attrs, &m);
+
+	x = xfrm_state_lookup_exact(net, &m, &p->id.daddr, p->id.spi, p->id.proto, p->family);
 
 	err = -ENOENT;
 	if (x == NULL)
@@ -3402,9 +3403,9 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	copy_from_user_migrate_state(&m, um);
 
-	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,
-			      &um->id.daddr, um->id.spi,
-			      um->id.proto, um->id.family);
+	x = xfrm_state_lookup_exact(net, &m.old_mark,
+				    &um->id.daddr, um->id.spi,
+				    um->id.proto, um->id.family);
 	if (!x) {
 		NL_SET_ERR_MSG(extack, "Can not find state");
 		return -ESRCH;
-- 
2.53.0

