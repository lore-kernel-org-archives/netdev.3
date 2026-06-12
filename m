Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B13E1223
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250493; cv=none; b=W9ZZVYZbztWcSR64dJoaChQEU68u+6bj9GO+9UQiDocP2ssGIDSJPT+4DU1jRHFVduY70FSnQ2BbO0DfNSKBNxrGMAZjGHfTT7m+N/Gg2TCcSVaFHfQBhKz8GNwZYjD/fl6EgVtrPkPMxmTkyDJZpzIo2fBmtB7JghJA7Rp/DYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250493; c=relaxed/simple;
	bh=XIp1M0f8w6kp4KBN4cajZgEJ5NLubpeT5ufGKeWB83Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSLldwz365PVsBr0n0jy9wyE13WP7zr2wL4XK6vvq9Qbi6aiOiEjdu2GCJwEPAlzL/79qsYkJ/1UpjpVEdUXSOGwdIHFtdsLAxipffug9PXtrtz+7LQ7hlltjLUZi61VDFDuEu2sEHiH1DlZurIS/2qGIEBGtyL2CwE7q/7dKAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AUW20vRg; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AUW20vRg"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A2A292080B;
	Fri, 12 Jun 2026 09:48:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbKVccJdzfvX; Fri, 12 Jun 2026 09:48:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EC6ED207FC;
	Fri, 12 Jun 2026 09:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EC6ED207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250486;
	bh=gToZ6uH/FjO2x9nG0SOuSAmZuteRPrKhxun2dNMxtSU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=AUW20vRgyxE5pgp3MYci1ZXuG9DJEdnXSAmHSJQp/Q+ddWoNZ+iHSRC6hq5cVPQnS
	 00oNlhAbnpdP8dxZhzhtuvH7nLKZHZEnPkQenWT4VHyIPa32T3FGDBUX3DfveVPukx
	 qn1G1DlONhCLwMqdAXblsPtDo9zzGHKJh0WlyqULpoIMmiVU7Ck5nSdW92iuudN4W1
	 oT/alR7ao0djiAEiWgZYd8oJxdU9X41Qj9Q9WfeRcRecEcIfztUOklqzhY/A8QYaG5
	 Fjg0R/x8P7vqaAafIFgpfMz31sgQalQQeQixTL5hb6Uer3cpbcXjofpraDcRnxzEXO
	 x80btXtGTlwrA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:05 +0200
Received: (nullmailer pid 1768287 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/18] xfrm: split xfrm_state_migrate into create and install functions
Date: Fri, 12 Jun 2026 09:46:24 +0200
Message-ID: <20260612074725.1760473-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

To prepare for subsequent patches, split
xfrm_state_migrate() into two functions:
- xfrm_state_migrate_create(): creates the migrated state
- xfrm_state_migrate_install(): installs it into the state table

splitting will help to avoid SN/IV reuse when migrating AEAD SA.

And add const whenever possible.
No functional change.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    | 11 +++++++
 net/xfrm/xfrm_state.c | 73 +++++++++++++++++++++++++++++++------------
 2 files changed, 64 insertions(+), 20 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 368b1dc22e5c..4137986f15e2 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1895,6 +1895,17 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
+struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
+					     const struct xfrm_migrate *m,
+					     const struct xfrm_encap_tmpl *encap,
+					     struct net *net,
+					     struct xfrm_user_offload *xuo,
+					     struct netlink_ext_ack *extack);
+int xfrm_state_migrate_install(const struct xfrm_state *x,
+			       struct xfrm_state *xc,
+			       const struct xfrm_migrate *m,
+			       struct xfrm_user_offload *xuo,
+			       struct netlink_ext_ack *extack);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
 				      struct xfrm_encap_tmpl *encap,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 5424f2becbaf..85fd80520184 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1966,8 +1966,8 @@ static inline int clone_security(struct xfrm_state *x, struct xfrm_sec_ctx *secu
 }
 
 static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
-					   struct xfrm_encap_tmpl *encap,
-					   struct xfrm_migrate *m)
+					   const struct xfrm_encap_tmpl *encap,
+					   const struct xfrm_migrate *m)
 {
 	struct net *net = xs_net(orig);
 	struct xfrm_state *x = xfrm_state_alloc(net);
@@ -2125,12 +2125,12 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 }
 EXPORT_SYMBOL(xfrm_migrate_state_find);
 
-struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
-				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap,
-				      struct net *net,
-				      struct xfrm_user_offload *xuo,
-				      struct netlink_ext_ack *extack)
+struct xfrm_state *xfrm_state_migrate_create(struct xfrm_state *x,
+					     const struct xfrm_migrate *m,
+					     const struct xfrm_encap_tmpl *encap,
+					     struct net *net,
+					     struct xfrm_user_offload *xuo,
+					     struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
@@ -2145,24 +2145,57 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
 		goto error;
 
-	/* add state */
+	return xc;
+error:
+	xc->km.state = XFRM_STATE_DEAD;
+	xfrm_state_put(xc);
+	return NULL;
+}
+EXPORT_SYMBOL(xfrm_state_migrate_create);
+
+int xfrm_state_migrate_install(const struct xfrm_state *x,
+			       struct xfrm_state *xc,
+			       const struct xfrm_migrate *m,
+			       struct xfrm_user_offload *xuo,
+			       struct netlink_ext_ack *extack)
+{
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
-		/* a care is needed when the destination address of the
-		   state is to be updated as it is a part of triplet */
+		/*
+		 * Care is needed when the destination address
+		 * of the state is to be updated as it is a part of triplet.
+		 */
 		xfrm_state_insert(xc);
 	} else {
-		if (xfrm_state_add(xc) < 0)
-			goto error_add;
+		if (xfrm_state_add(xc) < 0) {
+			if (xuo)
+				xfrm_dev_state_delete(xc);
+			xc->km.state = XFRM_STATE_DEAD;
+			xfrm_state_put(xc);
+			return -EEXIST;
+		}
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_state_migrate_install);
+
+struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
+				      struct xfrm_migrate *m,
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
+{
+	struct xfrm_state *xc;
+
+	xc = xfrm_state_migrate_create(x, m, encap, net, xuo, extack);
+	if (!xc)
+		return NULL;
+
+	if (xfrm_state_migrate_install(x, xc, m, xuo, extack) < 0)
+		return NULL;
+
 	return xc;
-error_add:
-	if (xuo)
-		xfrm_dev_state_delete(xc);
-error:
-	xc->km.state = XFRM_STATE_DEAD;
-	xfrm_state_put(xc);
-	return NULL;
 }
 EXPORT_SYMBOL(xfrm_state_migrate);
 #endif
-- 
2.43.0

