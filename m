Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE01448CEC
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045381; cv=none; b=qgJ9d7hUlokECocXDhHDyVaEmJnhZxzTVVSkQoeZaKIeMdTbRhPPgzKAqTvwBl3w3ssH/wvbMnKoEDriGRXuaVx0Gswx3xSD0HJCVSBRY+KUqL27ToIZkaxmH+R1sGvlIB8z5yczG6IcbbYK9pbDFh03/7cIg6h6eKjMOXrTklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045381; c=relaxed/simple;
	bh=MPQmdExuW0Upq6haJbQVLvBFZrd6TmwsrlTsCfVMyOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1VxnF0XirdOsQ7QmVxyfPfqHuEhQnZY6YUa5px4MC1lHhdsz/XgJiRD4tojo0fqvFd/xJmlFnB1OEg50Gaf3iVoy3GKBUdICt4WJe+JNEnXBhN+TENlN53367m5MTnM/YaQ0yhuxe18/CS3P20i1jgtuneSvxgZTHQzsDZO0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=pJr9HGeX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="pJr9HGeX"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F24E120754;
	Tue, 18 Aug 2026 11:29:37 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Zn-8TXte3YP; Tue, 18 Aug 2026 11:29:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6A74D201D3;
	Tue, 18 Aug 2026 11:29:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6A74D201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045377;
	bh=/AGrRQgf/kNAfn7hY/zGUCC94RCgdWH9baIr8IoY/dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=pJr9HGeXx7ZxykbuJFCfjUZh6+ZC1Nt17Y9WnPvSGEsLfCIXSnNGbtM3Rv7X6casd
	 Fu4XAmSOwyN8gtLWqZTV91DTm7uv0rk3Rd2SLAdaSgLaqDpz56LlFtaO2vYncxl+D7
	 FOxZsL2gwWFJsHc4x9n1GUGYL+zPy6OrIUlgy7bzWiwf19zd5WjEXgkGnELRX+KCoo
	 kD5sdSz7Rv1ZLUBbD+vJEZtZBX1s4dkrE5L4FkINEcWcvbtOiN83QRFakgCG9j5whi
	 mJ/gSDrOzrVcEWxuD6XMxuY589LDB/L0kM2XQmtnttd9tgTyq0KwA/WuAlP3qCEpd6
	 Gma7gCHHxbxLA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:35 +0200
Received: (nullmailer pid 657503 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/10] xfrm: fix xfrm_state_construct() auth-trunc leak
Date: Tue, 18 Aug 2026 11:28:39 +0200
Message-ID: <20260818092920.653034-9-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818092920.653034-1-steffen.klassert@secunet.com>
References: <20260818092920.653034-1-steffen.klassert@secunet.com>
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

