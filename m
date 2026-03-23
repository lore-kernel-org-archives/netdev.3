Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E13803C8
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254904; cv=none; b=KVnHyQnCQVx/Fkm90YjBPcoFjk0gbT6BjIaINH9Slc5C/bbxtdqRJpdK9F4sQhp7iUmkX+GjP2bktV2tafXySUS0gl7tY/zynQNL4u5cnmNTjqySR+jCC2I4Yfu4V9/djxe+msjEXPCRUdJO3FIOqqtvUxtbJ1tHaYZQQHHs0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254904; c=relaxed/simple;
	bh=1ZgFkfiCGZjXfbtzYDoU21/BONwUk/CEnQOsNV158i4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWbYwNTlhMee1XP34dU3yQoSSgjQDCzglFtz61QZ4m/7c3Ke3eMn/izhNP3ZUiDBgU3sdnGPGMqTBFJ8/3ZMQ1lxR+idsxl4GDJvSDO3q4HpD3B+NuCdUnVOQ+FSLfGIdfmPjndiJF0fhSG2BG9UOcrX6Ulsyo+EZiF1NbZ/tVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=v+DspITd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="v+DspITd"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BB2E5207AC;
	Mon, 23 Mar 2026 09:35:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQlTwk1irtdC; Mon, 23 Mar 2026 09:35:00 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1E55420826;
	Mon, 23 Mar 2026 09:35:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1E55420826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254900;
	bh=Judxu69k5RLVSTzjAT33nDZA89G3quuOwaAKh8er4AY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=v+DspITdDNvaN2kiafuBjpfgdHgIExdQqlNovFhK1Jw6l8Y/kl2w9FZE8bOHcfjpj
	 Ga9doJ+FIECrIbE6ogu6b/Q33K8O4WNUKcBMYhzgMF/Nvlb/xX5WtY5nrWjbv7+sVi
	 cD7QuxdyG7Qeh1SNIMleBpobeerJwxpSoeheQPQ7EIwpiyU3MtFdx4OI7UbsSZsy2t
	 V9Z8rgDpUA5b2aJXf/bZ3np2R6eSOUwxoiOiOyG+Z8TqpoZ45GHq2/4J6vcHY9x0P4
	 DuR6DtI84lJ+8ijYQ1Xnl51gLa0wpw2pNtF9iLKljfO3UyNapGcLCSAeK/9Oli/4f0
	 F3/ZsSvHXPpBA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:59 +0100
Received: (nullmailer pid 2741830 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/20] xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
Date: Mon, 23 Mar 2026 09:33:52 +0100
Message-ID: <20260323083440.2741292-12-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

From: Sabrina Dubroca <sd@queasysnail.net>

xfrm_state_lookup_spi_proto is called under xfrm_state_lock by
xfrm_alloc_spi, no need to take a reference on the state and pretend
to be under RCU.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_state.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 27192b11be43..f28cbe249c05 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1703,18 +1703,12 @@ static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 sp
 	struct xfrm_state *x;
 	unsigned int i;
 
-	rcu_read_lock();
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
-			if (x->id.spi == spi && x->id.proto == proto) {
-				if (!xfrm_state_hold_rcu(x))
-					continue;
-				rcu_read_unlock();
+		hlist_for_each_entry(x, xfrm_state_deref_prot(net->xfrm.state_byspi, net) + i, byspi) {
+			if (x->id.spi == spi && x->id.proto == proto)
 				return x;
-			}
 		}
 	}
-	rcu_read_unlock();
 	return NULL;
 }
 
@@ -2616,7 +2610,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 			err = 0;
 			goto unlock;
 		}
-		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 next:
-- 
2.43.0

