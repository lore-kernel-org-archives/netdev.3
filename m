Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163B397B02;
	Tue,  6 Oct 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270398; cv=none; b=gNLRo9k0B7HftdIte6Vhnxzi2B9pkTQlDyNRhrF0LWX0dfm0l/9zBbtfY06kGzOnyqjb03lnVFUyHaOiAEYQ2aFj5Y6EZeWMdkBg6gQCdRqn0+JeHo1cE70Jzr/wQp9cgWAWI0jufLjYv1XGI3d+SoDwi9iG9CNU7Zps8gIVa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270398; c=relaxed/simple;
	bh=9znKpW587vUnd2fqgWhdAEG280DMKsTOwmyotv/xN+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QS8U+meHuVDYsRzIpP8ib2GAbSJPtas8sUYg3C9T4o+N154OLb1JGEgMVfWfJ5//D0WXXvFIJ+hDgc16PSAlq4uLKcZQj9qPBkWPuJAa+81ICwiZ7Xm0SLsEYd4OouQD8slnBXznSRS6dXGvb56a6p/x5KlBQfw0NHQzqoN7UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hV42WE/H; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hV42WE/H"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 501C520704;
	Tue,  6 Oct 2026 09:06:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59R1hWly2Cg2; Tue,  6 Oct 2026 09:06:34 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CA0D0206D2;
	Tue,  6 Oct 2026 09:06:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CA0D0206D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270394;
	bh=09QDpxXxEv937Zvaay+i0OjQpOQ5/SZOjB/Lo5SqWU0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=hV42WE/HmGERVr8oNP2Qw2hRIDQH79DC0FiOh+iKRT01gl+U1Y0xcpqA7LaFephSe
	 NjIdIA7rJJAemBcd1ftrJ5zKzxHpMT/CDlTtid6uFgs8JiNE+CI1PA7D3m6gcfYGaG
	 RcI094FdY5hxYzo95plmus6C8ZOgJsl8H43pWlV/zGxmhDPQPU7qSVWPIcw2s4Dkzi
	 YdaQi9X5PsTW9bLBqadnYCzI1f5/WM/DVxIyGUYEzxhtDxMxWV0e4bcVu7wqzoisLv
	 8Kc6VR1eOfwU+tgyR/THuv3Zm07GTo1/xuL0NwBXBSqMZxAtm4p74pcKbHEBGD4/vC
	 bN2Y5N8xMc/BA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:06:34 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Jamal Hadi Salim
	<hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>, Paul Chaignon
	<paul.chaignon@gmail.com>, Louis DeLosSantos <louis.delos.devel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec v4 8/9] xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
Date: Tue, 6 Oct 2026 09:06:25 +0200
Message-ID: <migrate-state-fixes-v4-8-d5054459fc78@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
References: <migrate-state-fixes-v4-0-d5054459fc78@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
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

