Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A83BFAD1;
	Wed,  7 Oct 2026 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365780; cv=none; b=ArDD7P0GU8XDj4I7xAIuhepCvoQrV/qjtr3NIOZHyxrnWqBKMAkr8XVGcuMHWPzJCgAj/Xdu1zxp4i4BqdlvUnIN0bLhcByCFobi3jeVp877ApqeIVQ3laynudnZQJ/1g7AogiwD7CDNDzW1IuTBF6R5FlvohJWwMpKKpPXamt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365780; c=relaxed/simple;
	bh=9znKpW587vUnd2fqgWhdAEG280DMKsTOwmyotv/xN+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhdsNvSAYG0ICul2mzrecTnUEeMRolNawTetx6FHoQDS72626YCxbGyYs/TkE58ux4jjCerlGBPkPwe9k7F/6TNh+Jh4LrRUXramblXbcrH7NplMpDO+DWgUNP/f8a3oO7psxZ60/mCpggH/ROGHLiifTikZGLSEOxU+QzY5meI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oMOJh7NM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oMOJh7NM"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 06C5C2088F;
	Wed,  7 Oct 2026 11:36:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LvDkbly4yrM2; Wed,  7 Oct 2026 11:36:08 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7C58920764;
	Wed,  7 Oct 2026 11:36:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7C58920764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365768;
	bh=09QDpxXxEv937Zvaay+i0OjQpOQ5/SZOjB/Lo5SqWU0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=oMOJh7NMPMINc+1CdASQnPccmb99ADQBUtg9ITq5oknT0UkQDYj0oYvSWTnEfWqG3
	 i5b4kruDZjON/SNQTH3bgJ3WhsAyfqx/yGljj07zSrw1FnpjN7Chdql5TCDd3RovdH
	 cXgD9jgezk7Rih4Jm4PPNAR00qJUu6+70W1c/F6iXzJIJypRpUDTLzcfLCsj/27n+X
	 1Ys18taNGCsPEWPYMFQNeo6zATxwnVuyvBi2zjPThTTlB+8763n+ztbu8UtWd8Y2sV
	 DleeD+uI/A4kDKvqLiA8skrcXVO0HS+S+7kx31h/GcUNQI8936Bn+LvE5jsj6+diNG
	 Eb8eoFgzcnnFw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:36:07 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>
Subject: [PATCH ipsec v5 8/9] xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
Date: Wed, 7 Oct 2026 11:35:58 +0200
Message-ID: <migrate-state-fixes-v5-8-d9d3d794553d@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

xfrm_init_state() takes an extack parameter but doesn't pass it to
xfrm_init_replay(), so replay-window errors can't be reported via
extack.

Fixes: 231a1744dc43 ("xfrm: add extack to xfrm_init_state")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 65663c7ba836..0555e5d796ed 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3384,7 +3384,7 @@ int xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
 	if (err)
 		return err;
 
-	err = xfrm_init_replay(x, NULL);
+	err = xfrm_init_replay(x, extack);
 	if (err)
 		return err;
 

-- 
2.47.3

