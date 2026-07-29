Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE0381EA4
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307845; cv=none; b=uN8/wjrrByII7NiA910XkASE3pMsrziMNrP8pMN/YqUmCKgdnQ2gZl1j+iuJ7B4yq6CQ51h/zOb0OWMWUBVbQo1tf+aVklbMBqoUtjmIcb+JkgXgyI0R5RJOFV+YQkY2HN5Etp3KHKq6VYiaglGzpUu3glhdTU/GRKBnBfEhxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307845; c=relaxed/simple;
	bh=MPQmdExuW0Upq6haJbQVLvBFZrd6TmwsrlTsCfVMyOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxpYSU5cDajNnoQVWuyRl8Nb3/gOJIToJY0mk13Dmzz0Lii0p/ZAGRH88N76E5myrlEHug+Lhf/VobXdkwFBBOAEheYPZJkydIdY1jhYzplktNeQkYDBaE3a7VfkFJbNUDGapp4urEh3SOQr7h74/oMm5uiUrUmspqv4VVFEuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lB2jWeNu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lB2jWeNu"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0812A207FB;
	Wed, 29 Jul 2026 08:50:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rHDghCBHJkx; Wed, 29 Jul 2026 08:50:40 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6C89A206BC;
	Wed, 29 Jul 2026 08:50:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6C89A206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307840;
	bh=/AGrRQgf/kNAfn7hY/zGUCC94RCgdWH9baIr8IoY/dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=lB2jWeNus11HV3+crYu4p6mk0o7o2QID8o4K8lbkIN3wRf0UnnnYCpuCFvxN3klWf
	 mwOC92DhQRgxhJd4U74GwI92TLEG6v0ij+M71n+hXQWZ/BKsORFzoSDtQFNM3ZUF82
	 ZEFUtCdHetuGfDm+b74xcZ3E8cgyTzlaqXngU7zGcZemFhJwVrd2rA+Y4KKHiedFG4
	 cvaswIUbVcIcosxiQQqp/nIpjft9BYPeMlG0QUWPkkgRh8vEt8n9vfU3ZOTPTBacdS
	 FaweIo5dnPo7uxVbh1PgBaDA9vyNAFwMXH5jg4FFEU+0ssNhYVLBK34Wp+NvMm3JPo
	 fEaotFaaDSAXQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:39 +0200
Received: (nullmailer pid 1592298 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 8/8] xfrm: fix xfrm_state_construct() auth-trunc leak
Date: Wed, 29 Jul 2026 08:50:18 +0200
Message-ID: <20260729065035.1591985-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729065035.1591985-1-steffen.klassert@secunet.com>
References: <20260729065035.1591985-1-steffen.klassert@secunet.com>
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

From: Zihan Xi <zihanx@nebusec.ai>

attach_auth_trunc() can allocate x->aalg while leaving
x->props.aalgo at zero when the selected auth algorithm has no
sadb_alg_id. One real case is cmac(aes).

xfrm_state_construct() then treats !x->props.aalgo as "no auth
algorithm attached yet" and calls attach_auth(). That overwrites
x->aalg and loses the first allocation. Any later failure or teardown
only frees the replacement pointer.

Check whether x->aalg is already attached instead of inferring that
state from x->props.aalgo.

Fixes: 4447bb33f094 ("xfrm: Store aalg in xfrm_state with a user specified truncation length")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304ba6..6266a92cf302 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -940,7 +940,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if ((err = attach_auth_trunc(&x->aalg, &x->props.aalgo,
 				     attrs[XFRMA_ALG_AUTH_TRUNC], extack)))
 		goto error;
-	if (!x->props.aalgo) {
+	if (!x->aalg) {
 		if ((err = attach_auth(&x->aalg, &x->props.aalgo,
 				       attrs[XFRMA_ALG_AUTH], extack)))
 			goto error;
-- 
2.43.0

