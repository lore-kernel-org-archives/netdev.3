Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606696;
	b=GY6RG5v2h6jaKlyX3tZ5cUMws+CYcDhCkbLBMlXwDjrFsphOi3NF0XM85Gvo0lRzsdz3
	 j9OLp/zTuCtrbCWUn5J3aBQKLF13gipDoKMOeyXoLvu+lE5IyhUc9uMWQ8cYWlZWE2HXn
	 9L1FV/JWMJaK2HUuM5bmq6o+GwFxQ5WXewrU8kfAMKg7ANBkRpl//V/vZsTXAJ4y58F7M
	 BjcVbrs7zwZbronUOouHegVjTxkwY5K6QKKNrmn6WCSHpBkRkwms36ty8xzZ3YpM/30GT
	 Sz9h2nlrAgF8DUmk1xJFqEBwzYZwP+wjx5BJzBz3pyHEwBBAv7Y/whofgzu3t7b9Bgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606696;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=pDweGw5HyLxVmwonenPClPBzGH11CJ0lFf5qOHMRBAI=;
	b=dVeAMyROZbg+7+vvb8c1K9SSt+1WFggj/7qVYRJes0zww9hv2oyjxPcvWuM5Q7AiO6AZ
	 +0yjzvoNtO2To8B71Eg4LFS/nXUNZOCR8I5deMio276csc88hWDp1lgyZM6OUQ53BaVWR
	 8RzD2Q/zxigCm/01BHs7CT5wkYUvZEUkSSEEA1ts5s01LgpUSaUWqjPkSMV0IOK7Le6Wj
	 E/5NP193ru9TRNkPqUWY9LEMODMjOUy0W7gf5Xayw/ONgkpx2KEh0EP12u2ELJIvYikNk
	 y9CrxWkTzsAzer/KsOu1yOfkiDHo4k1CbbcEYP35bHK7pos0ZxVhK7p4f/wioUCEMsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b="p/kNYNh5";
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4A60A2600
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE4A60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=p/kNYNh5
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9612520520;
	Mon,  2 Nov 2026 09:04:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kXs2-Jq9b-In; Mon,  2 Nov 2026 09:04:54 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 043F1207B0;
	Mon,  2 Nov 2026 09:04:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 043F1207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606694;
	bh=pDweGw5HyLxVmwonenPClPBzGH11CJ0lFf5qOHMRBAI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=p/kNYNh5mPoNclLqMVTdIlR2A6468NE7idS8cBB7BUC+3yFevOEtVN3CpH234PG9I
	 7rrNKmnBFUgxAxruFy1C6GCmkggvaBr8yifMnOVYo/8EUe3AvwV898EFz/w/08z6MV
	 FeTc4eJJ0HRpxjMtl9q/U/SHNNY5pVu5DKmuTLrNMhfRZohVzd+q++rMu9tjzjq80k
	 CgGa0AuxNKfuRb14F1QywKPrKZ0q7UaY0xxxPtQ1U/APE92OEJjUrBIG/1IDbeDNYJ
	 1I2/CGWuMdb8koVLl3dyVyIUyEu2g4le8wnU0duXQ6dK3XaODAOORZ3bnA7kE4rsRK
	 EnTgfvfaVUWWg==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:53 +0100
Received: (nullmailer pid 2505903 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/14] xfrm: state: reject mark with bits outside its mask on add
Date: Mon, 2 Nov 2026 10:04:03 +0000
Message-ID: <20261102100451.2505200-6-steffen.klassert@secunet.com>
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

A mark/mask like 0x101/0xff is silently truncated to 0x01/0xff on
insert, so the exact-match lookups added later in this series (DELSA,
GETSA, GETAE, NEWAE, EXPIRE, MIGRATE_STATE) could not find the SA.
Reject it instead.

The mark is no longer sanitized on state add.

Also reject an invalid XFRMA_MARK (the new mark) in
XFRM_MSG_MIGRATE_STATE.

Fixes: 0b91fda3a1f0 ("xfrm: Sanitize marks before insert")
Cc: <stable+noautosel@kernel.org> # needs exact-match SA lookups from this series
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c |  3 ---
 net/xfrm/xfrm_user.c  | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e45aa1ed5b96..602404ffc4d4 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1732,9 +1732,6 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
-	/* Sanitize mark before store */
-	x->mark.v &= x->mark.m;
-
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	XFRM_STATE_INSERT(bydst, &x->bydst,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e796b..0723d791b8b7 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -314,6 +314,22 @@ static int verify_selector_prefixlen(u16 family,
 	}
 }
 
+static int verify_mark(struct nlattr **attrs, struct netlink_ext_ack *extack)
+{
+	const struct xfrm_mark *m;
+
+	if (!attrs[XFRMA_MARK])
+		return 0;
+
+	m = nla_data(attrs[XFRMA_MARK]);
+	if ((m->v & m->m) != m->v) {
+		NL_SET_ERR_MSG(extack, "Invalid mark value/mask combination");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct nlattr **attrs,
 			     struct netlink_ext_ack *extack)
@@ -333,6 +349,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	if (err)
 		goto out;
 
+	err = verify_mark(attrs, extack);
+	if (err)
+		goto out;
+
 	err = -EINVAL;
 	switch (p->id.proto) {
 	case IPPROTO_AH:
@@ -3370,6 +3390,10 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 			return err;
 	}
 
+	err = verify_mark(attrs, extack);
+	if (err)
+		return err;
+
 	copy_from_user_migrate_state(&m, um);
 
 	x = xfrm_state_lookup(net, m.old_mark.v & m.old_mark.m,
-- 
2.53.0

