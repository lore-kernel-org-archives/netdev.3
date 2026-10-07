Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8B47C0FD;
	Wed,  7 Oct 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365761; cv=none; b=AqsYvDDleA/vVJv349IO6n5iX7ocvEYxGm5Q8qK1dCH/1x/vYP2/dwSmuJkOS1a5Z64iqzl+TBA1hrqGsmoh9SAxbp10eDKtdM+Bs3kDZ3I66CoqVWpLharBdp18RAu2aSwdTRCeuavvUqKBHRnn53vrb18IuSkJd7Y9OgpQDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365761; c=relaxed/simple;
	bh=Z3ykhbjVIzJyZNeN3nHF0O+4WsulmWB/JiOUaUbfC9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF/ToU+0fPcwHkJPOxR3scs4qd6WqJKKRYEn79pLT3LtMK3AUbKDCHU2xfCGFQlQyr+ge9VcV7blOAdGzkLJuPZfOFBOB7BZCv14SOXTWNnKCUfErXp0ZIYwnEU3iHUQ7dMRMubNVkdN2gFHs9GnYRzvAwvzh40vM89y8EMFZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UzPXJ0Yj; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UzPXJ0Yj"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6F7E2207D1;
	Wed,  7 Oct 2026 11:35:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t8pnU5MkFrzJ; Wed,  7 Oct 2026 11:35:48 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E5BA920743;
	Wed,  7 Oct 2026 11:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E5BA920743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365747;
	bh=iHrISD0ykxocG4A9U4GLCkTvtry/S+fBRfGGHYXd+P0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=UzPXJ0Yj9TPxrWjq9S7Tiwuc3+N54gLp31lVmsgdVgEsBY5z4FjI8IfsmX8dk01gF
	 3zPZqGWkxRXXbu4g12H3mKGNsPiD54VvMWj2DMB08feH3RiqgBWvOleBFWT4jinkaC
	 GNu4i297YooJiSxg+OOjk7ukoGMkQ2ewulaliMrixukIY3NfJLRUIPu/N+/bIo8ly9
	 z7up0Rt+xkcrti5BC3j3UCzv5dnHFywjBiVkpzprSmTv8RpRJcsV+DjBBXzeOp0y9D
	 aPzZfZnR6J1HiBt6u6cPmQl5/8jVvNAwGEktfVBRO/Hi16fOwqKd52/Tx92+CYU4Mg
	 2mOTuspzk+QfQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:35:47 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>, Sashiko
	<sashiko-bot@kernel.org>
Subject: [PATCH ipsec v5 6/9] xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
Date: Wed, 7 Oct 2026 11:35:39 +0200
Message-ID: <migrate-state-fixes-v5-6-d9d3d794553d@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
References: <migrate-state-fixes-v5-0-d9d3d794553d@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

In the error path, the cloned state is dropped without removing its
hardware offload, leaking the offloaded SA entry.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 8640838dcda0..4de8c401eb44 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3541,6 +3541,8 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 	xfrm_state_put(x);
 	return err;
 out_xc:
+	if (m.xuo)
+		xfrm_dev_state_delete(xc);
 	xc->km.state = XFRM_STATE_DEAD;
 	xfrm_state_put(xc);
 	xfrm_state_put(x);

-- 
2.47.3

