Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2F37F005
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254901; cv=none; b=HK76YfTNGLE863+CiTcOhUV/oRg6GiJ37GZsbM9dNmmOlwCBcRH7m/L/asaYmudQVYIlhO2lKyfuStfQylV1mo2o1L5+N1J2aK1yuoWC5fUS+PPtOVndumeLCxa/AHc3wCyj5gCUfvx9nah89g89VyA39GfNh5HJIqw9KHfoOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254901; c=relaxed/simple;
	bh=A/H1xgGMuTM8HFgEvxWwitpopP42B39lYCSbfE/ywCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V193J/mJ4j0Ugl5L482S1LNNKG2fclldMbOH8+HDboC+zlIsfZaMTLyiqvVJ2vYPM+dXz7per2PJf4IFvQazLxrBn0y/Bn6S2T0OBD9FLVw6YRwaD5LwTLjf7SdLuObdpt9HSGKDLt2N7NWllFjPeRpzK7d8vs2+rHaFYu//XuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BK7/IB7Q; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BK7/IB7Q"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 52C65206DF;
	Mon, 23 Mar 2026 09:34:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SaR9B2t--o0t; Mon, 23 Mar 2026 09:34:51 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BB7AF205ED;
	Mon, 23 Mar 2026 09:34:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BB7AF205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254891;
	bh=fsJQAoIvAsyoA4/HZja7mxru34iCCSRdgzOMrj79mu0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BK7/IB7QxpYmzkPesakHq02oX/TDg+mu2ifVKGJKRJgASW2l1dOnrCRHhOk6UWNkY
	 cFOHuB3VASZw9ga3lB91sUY1uJtC7ewbkryc5dTdmtrVqcVUnyRaWZVnZKztZd5StB
	 20diitJaMb3OA4zdNHUa14PFm02wqHO7+so9R49/y3hP7DZqC/sklpgDiALAOfU5tp
	 suSLPQtzmMkMk1kksqeSqSNP/+WyJ7arXTkaqwP9okMj/3xqXV8LNXCMs+loXceuZR
	 juFUqDQvJjbtgZj/+75Ki2c5DlTwe166dJ6FYc21iAV4uQICyySOQR9UseEpEm97IB
	 zVX5Db/KHFhAw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:50 +0100
Received: (nullmailer pid 2741800 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/20] xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
Date: Mon, 23 Mar 2026 09:33:42 +0100
Message-ID: <20260323083440.2741292-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

We're returning an error caused by invalid user input without setting
an extack. Add one.

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..3e6477c6082e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1850,6 +1850,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
 		if (pcpu_num >= num_possible_cpus()) {
 			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "pCPU number too big");
 			goto out_noput;
 		}
 	}
@@ -3001,8 +3002,10 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_SA_PCPU]) {
 		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
 		err = -EINVAL;
-		if (x->pcpu_num >= num_possible_cpus())
+		if (x->pcpu_num >= num_possible_cpus()) {
+			NL_SET_ERR_MSG(extack, "pCPU number too big");
 			goto free_state;
+		}
 	}
 
 	err = verify_newpolicy_info(&ua->policy, extack);
-- 
2.43.0

