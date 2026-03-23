Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84DB381B14
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254915; cv=none; b=ryaof/miJ0Ls4qU/PVLEXWIPP3pQW+73fd3Lh6p4g8lhLQAX5F9G+7KYpylgSoHXs7SRg973coTtr01g6ZtlnOYl2QfiTexzmVMXYIz9SwKRhfOEKW370WTNgmrwLoJ8Gqp4ponktxpMXx8jVkmLpOv0OpyIrLorilqQqeGMxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254915; c=relaxed/simple;
	bh=b368cmQ1GQ7Y0LD5++jsKA7sXYgLavzLtpleTtOqrqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqp1kNo+iM4yRIBIAKMOnIFhNdrlh18BtYEiNbqZIF9qwyUsaOE3ORHaOtTSe9o29Z6Li2mcU9MTlKNxFfD2zFZ+bo5x7sxH6CUSHEgV9f5dIrfuxZKgMXDzCi1JyX9qx7UR0W6m6/gMyHN5JXmWIYAqyoeYfG87bNtGQ+0zNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RPtwhX2R; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RPtwhX2R"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AB9E1206DF;
	Mon, 23 Mar 2026 09:35:12 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5pcLKF8An9wB; Mon, 23 Mar 2026 09:35:12 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0CDA12068C;
	Mon, 23 Mar 2026 09:35:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0CDA12068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254912;
	bh=APgE9ydDIEEN5WdxrWEs7U0d8hvYDVSAZJq0a+bTpGU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=RPtwhX2RQgA+u5T1xd8dZszJ4OT6BmEkaLRWjc40jsuNX+JarZCVe5UIAvDW8nnpk
	 nUNRHGXgziT7DR0WvqNJilMIpd7RNy3QBMMMehwk2UkG8kF+5MrFhSrYOHBMiND29I
	 X2kkXd87f/DpYofWH/EqPwMkvjL2JeBOXlQnbH8IOvidGi4u6lK5+gobpXzxo/FYcu
	 ZEYzWo5jvRuR10E6CtpHRACztqzufZk5R7si/9E8fR1MzZyozTIJ5wkdyGu7/NSYbM
	 OZ+FMiBggpkGEAwpvxSW4kDBpdvzL1NSovlAQGkIrk51tRKygOeIfY6lgm/PYJuNWy
	 GejpL/RltiNmg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:11 +0100
Received: (nullmailer pid 2741842 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 15/20] xfrm: add rcu_access_pointer to silence sparse warning for xfrm_input_afinfo
Date: Mon, 23 Mar 2026 09:33:56 +0100
Message-ID: <20260323083440.2741292-16-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

xfrm_input_afinfo is __rcu, we should use rcu_access_pointer to avoid
a sparse warning:
net/xfrm/xfrm_input.c:78:21: error: incompatible types in comparison expression (different address spaces):
net/xfrm/xfrm_input.c:78:21:    struct xfrm_input_afinfo const [noderef] __rcu *
net/xfrm/xfrm_input.c:78:21:    struct xfrm_input_afinfo const *

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 4ed346e682c7..dc1312ed5a09 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -75,7 +75,10 @@ int xfrm_input_unregister_afinfo(const struct xfrm_input_afinfo *afinfo)
 
 	spin_lock_bh(&xfrm_input_afinfo_lock);
 	if (likely(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family])) {
-		if (unlikely(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family] != afinfo))
+		const struct xfrm_input_afinfo *cur;
+
+		cur = rcu_access_pointer(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family]);
+		if (unlikely(cur != afinfo))
 			err = -EINVAL;
 		else
 			RCU_INIT_POINTER(xfrm_input_afinfo[afinfo->is_ipip][afinfo->family], NULL);
-- 
2.43.0

