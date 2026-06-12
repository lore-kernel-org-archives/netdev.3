Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC63E3145
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250496; cv=none; b=ctXQIR2Th0AltrmFNiGHxjRQdBBXh3TIaAsPSAdKgA4fk0uoy5/OvJDEKZ68dLjaTTRfD61ObhQRLN78/wuRinFvrjGJvpOdF2t2XKNOvPuN7P2aF8g4H/1fSCm8C25dVJ4AUgxO8IwGgw7W1o3M+k8f3NHpXbR9pBMTw7Dsuw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250496; c=relaxed/simple;
	bh=zedCNH7cPFEJooxUv5psEH8gmdZgRI6Pq5Hi7SYiJVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIg9KFKplfO3KBa8Hh/s+yryKBWIAS6qHJr8l/3MqEf2Zx+jgEwj2sjw4LGfSuSWdoD4pRAwEk7doq/oYuApJgxKxyyowGTcUsKTAI64TMfbgzcpvM4mhorlO1NsrLsUaY+sPMd8Th+s7l5KnL/uChwrGCWP1Qa4ONw5yIgDX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=n8hGEnvY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="n8hGEnvY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 97D14207B3;
	Fri, 12 Jun 2026 09:48:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iY5-2Bo8k5dj; Fri, 12 Jun 2026 09:48:13 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0E92D20764;
	Fri, 12 Jun 2026 09:48:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0E92D20764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250493;
	bh=EFxIurL7HDAo39RHEsK+XHuo4B40E8XnHfdLl3kBODU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=n8hGEnvYsp1b5yOw05iTgivc8WI+wMT+v9aaoXxpvPWREIKvJ8eYjOXZ0ayebwhfc
	 aiSmnPxBSvy9NeyOXUWKQTTyi4Av+b52P5yYIgSBM+o/7d+x3QzPAkUelUsgMkhgus
	 ITERqhddv/RSRAi1UQ8XIUvjamUrrWUR/KMeb97PY2D0ZSGXSHIK1owoYs0Q+9fSpr
	 oLEVc6mt7XKbj6dLG5BVlZiL6VJQHdETDW9N585rmGQQoklrG1bsCQJKhM00kemLkT
	 lH+WdWEARD+q+D6rCIbKxkgGKCQAIcwpsqu+D9HVqRz59z+WZm5yjXgfLwh4M1ZAug
	 xK2P4P5xgGIRQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:12 +0200
Received: (nullmailer pid 1768269 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 02/18] xfrm: Reject excessive values for XFRMA_TFCPAD
Date: Fri, 12 Jun 2026 09:46:18 +0200
Message-ID: <20260612074725.1760473-3-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: David Ahern <dahern@nvidia.com>

tfcpad is a u32, but that full range is excessive for padding.
Limit it to max IP length (64k).

Signed-off-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ae144d1e4a65..e87f33aaa99c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -937,8 +937,14 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 				   attrs[XFRMA_ALG_COMP], extack)))
 		goto error;
 
-	if (attrs[XFRMA_TFCPAD])
+	if (attrs[XFRMA_TFCPAD]) {
 		x->tfcpad = nla_get_u32(attrs[XFRMA_TFCPAD]);
+		if (x->tfcpad > IP_MAX_MTU) {
+			NL_SET_ERR_MSG(extack, "Excessive TFC padding");
+			err = -EINVAL;
+			goto error;
+		}
+	}
 
 	xfrm_mark_get(attrs, &x->mark);
 
-- 
2.43.0

