Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C713E1686
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250565; cv=none; b=WZ4np8prePijsurupAcD/GKczonJL3BY16N3aA9UPBqrHPE/mn5qLXgGx6Xu3SQykFEe/W9aI5xdi/MayRDRRXoXWfq1wcNs1Z1rJQGpRxzRIIorcpqHG9ZQ555QQxXMrT8yxCr+kjSR22Xz0T5YggdiCLhR1uksmygvl0SZRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250565; c=relaxed/simple;
	bh=G9SNbwg7BKCIzw0nFguEEIYDeB0K3a3AGLUm2QYlXmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5HRdGQiUaAlEmRd1ZxvJzDJOXOhqwLfpKow4uMzGPTo9bf3RdUyKSxWH3Id2yVJw3wSxsQ7W3/mUcVk4Dl94+foupElyh0f93z8QDxBtEyOCEW4IgZJ+SGPrODGX9wTbtOQf2QgNuYrD7IUUd/88aAo5uO5WavwKt20L8CrfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Zidrtm6w; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Zidrtm6w"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 63674206D2;
	Fri, 12 Jun 2026 09:49:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 154Zk8mmNxRy; Fri, 12 Jun 2026 09:49:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 887E120758;
	Fri, 12 Jun 2026 09:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 887E120758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250562;
	bh=oiPS6GsEWloDQCDz/DTqXBgZt6K6fidL49TBSQdSeJs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Zidrtm6w2fRhOVzYuShlkQq2COlR2976gjaJ4IhyM+XcCLLHvNXvJIRTorphUF3bN
	 6PIvujXrybdJjTKSesbHkWXsf7adA3IGIKQ+uwW9xlwmCgV8MKTjK7WOH7g1JJuQ4r
	 BDPb2GcVIom6dwkO0D4bz+nalYwAvgQjHdQob+pgrtw4rv5/TkCwQnoO01GTfmdlJp
	 BFCiA8rgJasEj8nyNTGpW867xYjprC90NF1nagNI1eHxe33h3/VuFVZ3jn9lwV4hCM
	 2iiTBAOoD7bwLfT1T6PQvbYdMn/Ocs8m7OryukEWICRweRXEmwjn3A+ZhPjDYO5HAz
	 NxQaZs/63J03A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:49:21 +0200
Received: (nullmailer pid 1768266 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 01/18] xfrm: cleanup error path in xfrm_add_policy()
Date: Fri, 12 Jun 2026 09:46:17 +0200
Message-ID: <20260612074725.1760473-2-steffen.klassert@secunet.com>
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

From: Deepanshu Kartikey <kartikey406@gmail.com>

Replace the open-coded manual cleanup in the error path of
xfrm_add_policy() with xfrm_policy_destroy(), which already
handles all the necessary cleanup internally. This is consistent
with how xfrm_policy_construct() handles its own error paths.

The walk.dead flag must be set before calling xfrm_policy_destroy()
as required by BUG_ON(!policy->walk.dead).

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d56450f61669..ae144d1e4a65 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2267,9 +2267,8 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (err) {
 		xfrm_dev_policy_delete(xp);
-		xfrm_dev_policy_free(xp);
-		security_xfrm_policy_free(xp->security);
-		kfree(xp);
+		xp->walk.dead = 1;
+		xfrm_policy_destroy(xp);
 		return err;
 	}
 
-- 
2.43.0

