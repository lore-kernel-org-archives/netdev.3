Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92710379C57;
	Tue,  6 Oct 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270355; cv=none; b=YaJcLkVjJ5leHQ4yCWYuh0VfGDofWN2FXGHWGkBzkNT5Sk7C+tG38B1R2puCH8Ca0OB/n9ANzSPVKz1X9ZTg54YkmKqRazU3WpuryEfaN+5MT0Gz+RTojOTN2L9b7VP4fok9cEeVEh8eKMIGDohNtrRGL27rgqfUiCsaqoZizAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270355; c=relaxed/simple;
	bh=YD19ZFZ1KHBVVnvK8SZPXYC/J7yLjVe0wKxu5J2Y6qQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6aFFSp2dOk7XIyUmU58p4rjX8yMEbGklJDf1SVQiowPG1V6RIP7HlPYudxCec3Gzd+9v6gOxsmE8o8DLkY9xLtkAScbgV3ARzXkPgP6LWxCK7vSeOIxEm1UHIQ1RuXOEw5IETNsmiM+wattNcn4A2fqS7rToMs0eBGyyTRoPn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KW1mVUFS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KW1mVUFS"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 844C920754;
	Tue,  6 Oct 2026 09:05:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R4JtRecaC09I; Tue,  6 Oct 2026 09:05:50 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 952E22084C;
	Tue,  6 Oct 2026 09:05:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 952E22084C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270350;
	bh=qQDmzr0ojEsCPuNJqETj8QA+UFINXZ0hdeddAHDjcmM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=KW1mVUFS392vqljlkakqXYdIDin9AQrt31vkwFU6RFMMO4c1PufDEA3bzu5Jl+Lit
	 6+XKU5leP1FfzkG2YeFXSl7mZHraUo4DU3c6wVPk16tQ7WVw5FVozjccWlNgS1nrLJ
	 8fs48UDd8MszZctD8xlnHuqiA04n3YvTwnY4jqtxHAkqd6lljdn4+pfwLdsJJpHYM+
	 POlVQXKSEIaO2x5WcoF7CzCs3jS0F6WRf9M7O4BpYDJqGdoeJJ47+7Qffesw/91tIP
	 mT1jsazpzIzLcBWoj2OczbTkLOJ6wh08G/UM0/naj+m/606WbuH5RPvquGBnl/CSdh
	 lw0gYP/9AA0pQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:05:49 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
	<paul.chaignon@gmail.com>, Louis DeLosSantos <louis.delos.devel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec v4 4/9] xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
Date: Tue, 6 Oct 2026 09:05:17 +0200
Message-ID: <migrate-state-fixes-v4-4-d5054459fc78@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
References: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

Add __xfrm_state_lookup_exact(); wire it into DELSA/GETSA, GETAE/NEWAE,
EXPIRE, MIGRATE_STATE.  xfrm_state_update() (UPDSA) keeps wildcard match
because ALLOCSPI's larval state may have  mark (mask=0), so exact-match
UPDSA can't find it and the ADD fallback trips -EEXIST
via xfrm_state_add().

Fixes: 3d6acfa7641f ("xfrm: SA lookups with mark")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v2->v3: mark match use only values and no mask fix typo
v1->v2: UPDSA keep the wildcard lookup
---
 include/net/xfrm.h    |  3 +++
 net/xfrm/xfrm_state.c | 56 ++++++++++++++++++++++++++++++++++++++++++---------
 net/xfrm/xfrm_user.c  | 29 +++++++++++++-------------
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
2.47.3

