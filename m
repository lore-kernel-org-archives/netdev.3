Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D40332ED6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250491; cv=none; b=Hmfu8C2wS3Wt/9ronUIpkDZVscHtTz2fT6y7z+zE6+aoxMB6BzTnmbjBGXjDChRWJLGVqvbKdysEkziqE5Ny3xv9CWz7V6md0Hns7Xgv6Cm7Actae++Z2RgZbGGZEshZ/0bLIdsWrH0aKdheRVnz6/n5pCk9VwY6EQHCZPvYpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250491; c=relaxed/simple;
	bh=U7Ev5hzQq2UehSLF5q5kVHkOJ0BGIWMEuGN87D70xAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV1YF4HijszaX1iJ16MfHOBvGB9tYRSMNOzdMxxt7wBhqGzgDBbXaSvO59q8DZVbxzLcnoXG3J5pDU2GfQDq+ygnIqW85vOpXeoqmz0LAkxNq98vjcj7ACjaaneGJW9BuZDm0lFnTVO53i0meHP5XB0lhkRQo+K2UVbta6K0CRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Xh6eKWjr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Xh6eKWjr"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1B8DE20764;
	Fri, 12 Jun 2026 09:48:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aSElloZq1VGC; Fri, 12 Jun 2026 09:48:02 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7E264206D2;
	Fri, 12 Jun 2026 09:48:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7E264206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250482;
	bh=g19B07hM4ByZv7hniqyVzpomLTHg6MNKuYkR1GLwHHU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Xh6eKWjrvMj037N7Pu+ilyuiz2/sTHCrnKJW6t4wVDfZBKc9FG/+y9Cp/5q1eQVbi
	 RV4syyoEg8QErfheO17QbXai4bMhPiz7A5kTzfkp4BEFAZ4XLB7FUS9M3S1bGvc9u0
	 ploLvOtYkKL/svhyJeNPbP9/tlCcjvA2I5w66SVA6RL+xsNSZDmWpTqM4uvkGTDZja
	 oQ3gwo6XuBqpCrAQoKKdJ6pb++doKFOuYlMBMfHnyCsnYv+e1smY965bE1nVPwZ/wt
	 XtD0XThg3LQSMH7PLcvKPLv2EHv9u9hZZtTFSHd1xzawbIAhLHu9PapzFxLALE10eD
	 Tn726t+UDrBYA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:01 +0200
Received: (nullmailer pid 1768272 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/18] xfrm: remove redundant assignments
Date: Fri, 12 Jun 2026 09:46:19 +0200
Message-ID: <20260612074725.1760473-4-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

These assignments are overwritten within the same function further down

commit e8961c50ee9cc ("xfrm: Refactor migration setup
during the cloning process")
x->props.family = m->new_family;

Which actually moved it in the
commit e03c3bba351f9 ("xfrm: Fix xfrm migrate issues when address family changes")

And the initial
commit 80c9abaabf428 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

added x->props.saddr = orig->props.saddr; and
memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..9417a025270c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1980,8 +1980,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
 	x->props.reqid = orig->props.reqid;
-	x->props.family = orig->props.family;
-	x->props.saddr = orig->props.saddr;
 
 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);
-- 
2.43.0

