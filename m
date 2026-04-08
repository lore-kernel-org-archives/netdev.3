Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D239EF1E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642385; cv=none; b=b2np7Vvp5cMw7Bm8VWDUclyey/End3EJFfxZis/ql/gYW5ktqJgV7Mbx7UHYJIb1gWNXD6ef4ENrvzB4m+m/Z6UNdkgWlS5Xt7hWrOmhkOjAO+2CXQt3zg1szcyb2Ikv4XQAXehTRv3xPdsyuk15C+Y99Pw3d7V5+tYKW56BVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642385; c=relaxed/simple;
	bh=gQxUSQCbOCVRy/U0Mk5nZDFEIAyHtJsr0tGa/b9phao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzjO99IAYA9StiLkDVgWot0IvXe/PtlfbF5QUP/gk0+RHgq8Ifnl7rcbtAraHyhEOEGwFNIdjtw6kEnThlovSmPnA9feSYZk4TMxUppQxHEJXMhl3rJWGzj0i6JKpeAPS9CgOF0EUKoP9he6zwamtkMtzo5pzbTEywndTatUOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YjaT7mp1; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YjaT7mp1"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AD141207BE;
	Wed,  8 Apr 2026 11:59:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxEWqn4MJWBF; Wed,  8 Apr 2026 11:59:34 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2480F2080B;
	Wed,  8 Apr 2026 11:59:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2480F2080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775642374;
	bh=JlyyLZVtng1xN5YXmew8a27LPdVRcpLmBOhugxBOMfM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=YjaT7mp1JSoiJhYs8gYAyGrcj45mWaZoZpNy7OMrHBTtEVoj8171iCqEt12L7YovB
	 ksEph6wB6uSO91L12z3yuAQ6oUfIWV50NgLmm82gJN6uFf7Xw/f2P1HTOeoAbBz293
	 4NHwOspT8P4RcWA+9BzOgy2OBMVAIisoy2xtY7dXxyKl7KEZNIbe+Kehh0trOj4Y8B
	 RWv9LEfHhuHJrOmkiULYfkyoKuEoKPLiL6xMAdyiVKGhs4COs/zMKfWummCArkYW2x
	 CfbcZNCp9ag1H0PZohVdvr291Dje5nibzjLmBwYzaiR//rXSBCiITrmkx5IfDj7QkM
	 kCraaHD/XSF9w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:59:33 +0200
Received: (nullmailer pid 256748 invoked by uid 1000);
	Wed, 08 Apr 2026 09:59:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/8] xfrm: account XFRMA_IF_ID in aevent size calculation
Date: Wed, 8 Apr 2026 11:58:58 +0200
Message-ID: <20260408095925.253681-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408095925.253681-1-steffen.klassert@secunet.com>
References: <20260408095925.253681-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Keenan Dong <keenanat2000@gmail.com>

xfrm_get_ae() allocates the reply skb with xfrm_aevent_msgsize(), then
build_aevent() appends attributes including XFRMA_IF_ID when x->if_id is
set.

xfrm_aevent_msgsize() does not include space for XFRMA_IF_ID. For states
with if_id, build_aevent() can fail with -EMSGSIZE and hit BUG_ON(err < 0)
in xfrm_get_ae(), turning a malformed netlink interaction into a kernel
panic.

Account XFRMA_IF_ID in the size calculation unconditionally and replace
the BUG_ON with normal error unwinding.

Fixes: 7e6526404ade ("xfrm: Add a new lookup key to match xfrm interfaces.")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5d59c11fc01e..a779590c985a 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2677,7 +2677,8 @@ static inline unsigned int xfrm_aevent_msgsize(struct xfrm_state *x)
 	       + nla_total_size(4) /* XFRM_AE_RTHR */
 	       + nla_total_size(4) /* XFRM_AE_ETHR */
 	       + nla_total_size(sizeof(x->dir)) /* XFRMA_SA_DIR */
-	       + nla_total_size(4); /* XFRMA_SA_PCPU */
+	       + nla_total_size(4) /* XFRMA_SA_PCPU */
+	       + nla_total_size(sizeof(x->if_id)); /* XFRMA_IF_ID */
 }
 
 static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
@@ -2789,7 +2790,12 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	c.portid = nlh->nlmsg_pid;
 
 	err = build_aevent(r_skb, x, &c);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		spin_unlock_bh(&x->lock);
+		xfrm_state_put(x);
+		kfree_skb(r_skb);
+		return err;
+	}
 
 	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
-- 
2.43.0

