Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E303C13E0;
	Wed,  7 Oct 2026 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365752; cv=none; b=oMwI06b2XDSFZL+JjmfJ7ZHty8C0DqPQCPWi26P3hRoPQcM8LCSjLtXwhNyVwlKWdbG/h7kErtJNd9KIMjphSsh+SQ9wZavIFQ0TardlOh8m6ZLnxuftmsWugeaucsEVS+gLDszOJoeRgDRmC9a5nucjzyuHze97J/q7AXfAxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365752; c=relaxed/simple;
	bh=v71oF5Xn17IJHim8EUiNoLscztvEmjn2yAHV3FfariU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifqHfc2yv7UILakLNyq+kRrc/YmP/IIcuVcqi28Vq3A75gFgHhKJnOUfLH4gdYCIGQKQkhPy6kpL89FKZKP1sD+hZkxOQhZTpc6Dj31BzFpbA2AbQ2NylFEz70fifjBzpnmKGQdlufIqD51WTvFvrnsh7/DHC4+sX/ePPXqGAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XhIrDYQ/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XhIrDYQ/"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6BD3F20764;
	Wed,  7 Oct 2026 11:35:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1iCtlOFKuoK; Wed,  7 Oct 2026 11:35:38 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D833420704;
	Wed,  7 Oct 2026 11:35:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D833420704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791365738;
	bh=/3u6gvybbw8LRUQDWakXcsTuC8FRpU6povHM+9bMFso=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XhIrDYQ/T+vjZr+TiCzkABFHnaeYe0jym9VYF/T7iwpEiTg5W+M1rm48wn99HquyC
	 nrMia8JWWnMks8guZ8P+ZLszeSQ/1EbDTeIWH+ucZiipNkjyTpdRGWw5Y7Yk/57wdW
	 AJWug1QXiqOyaWXtFasxDGDo7D0w3zLco72W20IclAvgN4zdGM+ub+cZCW0HmPc/Vq
	 i/0qP7IY2Lua2KWXTDXBznWuvXzA2NhBEr1k5AwwvUrG3G8Gag2uGaMmflC4aEnJ6X
	 8TtFoQsbi8G+kdMgorIOnhL5Lf3sBZqudhs90/mIuWC/zxGJa9hMmKSkWRDLw4MX+y
	 luhmn8KCzx+Aw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 11:35:37 +0200
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
Subject: [PATCH ipsec v5 5/9] xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
Date: Wed, 7 Oct 2026 11:35:27 +0200
Message-ID: <migrate-state-fixes-v5-5-d9d3d794553d@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

A concurrent delete can free the migrated state before
xfrm_do_migrate_state() finishes using it.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5a9f729b4fcb..8640838dcda0 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3509,6 +3509,7 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 	__xfrm_state_delete(x);
 	spin_unlock_bh(&x->lock);
 
+	xfrm_state_hold(xc);
 	err = xfrm_state_migrate_install(x, xc, &m, extack);
 	if (err < 0) {
 		/*
@@ -3516,6 +3517,7 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 		 * free under xfrm_cfg_mutex. Both SAs are gone if it does;
 		 * restoring x would risk SN/IV reuse.
 		 */
+		xfrm_state_put(xc);
 		goto out;
 	}
 
@@ -3534,6 +3536,7 @@ static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = 0;
 	}
 
+	xfrm_state_put(xc);
 out:
 	xfrm_state_put(x);
 	return err;

-- 
2.47.3

