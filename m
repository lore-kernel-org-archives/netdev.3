Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE93E1235
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250493; cv=none; b=EuPxILNLIkLqqBwNck4H1l/Q166EvfvHjx9HysxnCA9wRkeHKjzHDuIAZmfxDfPE+beVAdlqjGb4YDzZzfQlLU4cFf+lZGGEeoBwPpGn4xVSHEj8yqnfaFNIQmnktLfjYMhCBv4pyL/S2RPFon0zmaHjAu3m0ufpfnm55RTdb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250493; c=relaxed/simple;
	bh=azHEFTpBXCFE7SKsbM2IKeydw4fePa3y5WcD8Gxhedo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8HNH6+gyInfcoV0cGs4sOEiAR/brNUr84NsFiNHBd9GcxMOKPPis8wxr7K3W5tptkJfhT8DHlOWP21YVV/UMibMwefO9n5jY7ON9TDbEeg27T4cNF3pZwkHRknwF2dvI45BZC2pss9jsEL/pg9yszFROVg9oZMwzRB1vVqCZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SC5LJrPi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SC5LJrPi"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AF9AB206D2;
	Fri, 12 Jun 2026 09:48:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dwUnHoM-OQlz; Fri, 12 Jun 2026 09:48:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 291F4207FC;
	Fri, 12 Jun 2026 09:48:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 291F4207FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250485;
	bh=pTh/NIbJobX+7qkzqlJNTzT4B20LRk4bDUPgNtSJoXI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SC5LJrPiS15XUjUvsf/6qvGeTM1zB5MUI44vlpv3YMxxJaU422Z5wVGlHjutHjiYs
	 aIbjJ9SHsHkccmrlrz8Nit3cbnO2LOgpMfKNIdMF0J7ZFQw6W/EpavmqBsXWOE42fL
	 BVKLkDddKhR4kfFwQ7rPeD+Gh5feNZ4sWRnNyb1kYjCR8iNx7QZTzqGkzzVMqxD21j
	 WgOVG7NfmAddO3EaSXurkrdbE654eX2OxdZABQLM3aovUeTeL284ySxXeEAvjGoDhE
	 yRdM4swM+pH3USBDvttF4uF2MPUuKRjPgVIwbsGBxluPjvn1Dpg3Bcmx90/L189FeW
	 peLCXrASIzzqA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:04 +0200
Received: (nullmailer pid 1768290 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/18] xfrm: check family before comparing addresses in migrate
Date: Fri, 12 Jun 2026 09:46:25 +0200
Message-ID: <20260612074725.1760473-10-steffen.klassert@secunet.com>
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

When migrating between different address families, xfrm_addr_equal()
cannot meaningfully compare addresses, different lengths.
Only call xfrm_addr_equal() when families match, and take
the xfrm_state_insert() path when addresses are equal.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 85fd80520184..327a855253e6 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2159,10 +2159,11 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack)
 {
-	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
+	if (m->new_family == m->old_family &&
+	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/*
-		 * Care is needed when the destination address
-		 * of the state is to be updated as it is a part of triplet.
+		 * Care is needed when the destination address of the state is
+		 * to be updated as it is a part of triplet.
 		 */
 		xfrm_state_insert(xc);
 	} else {
-- 
2.43.0

