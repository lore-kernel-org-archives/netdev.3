Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF7397B02;
	Tue,  6 Oct 2026 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270368; cv=none; b=tiRQ0RA32J4O1I+aotUCb37eg1myoV+Nykh/A4VTvCrwimXCoNHPZdooiJXeoczCz1Mjnk8G9gzOaUOPZuIVyagHANovlkQRHQYipvmQL3jSw2D8cV8cu3/D9Kg5E0bVBU4x+kvdV9XsQiU40ua2Ipsd+8MrNBsrePeGrE90cpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270368; c=relaxed/simple;
	bh=v71oF5Xn17IJHim8EUiNoLscztvEmjn2yAHV3FfariU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odOM1yEJiJJipfgSajtbVfs+yNTc+sTSf1D4/s+KGOkqvtkZmlOSjih1KdTcA/UjFu/I64lZiF0+ZJSLPmSeFgJ0NuxX6UXBaSvILpTZcLXcBmbXx9J+YOqFiz2ggmKXrj+wW+t4YhSQfNs4MzBJmh+pwItKyfc6QwudBiz+kvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xtFZxSlQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xtFZxSlQ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9CF832084B;
	Tue,  6 Oct 2026 09:06:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3KecgSbeb2Gs; Tue,  6 Oct 2026 09:06:04 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1BC4120754;
	Tue,  6 Oct 2026 09:06:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1BC4120754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791270364;
	bh=/3u6gvybbw8LRUQDWakXcsTuC8FRpU6povHM+9bMFso=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=xtFZxSlQk/6HySmwWMcVgW2DVZep/XqH/Tv/5mCJAbCvLsmUNIW+6QXn0549wJhGA
	 znIQnDbt+P4Vb5FFSbrNMw8SHgvc3hK0BI0/Ld72d31tfCQWruBmwFJMQrTvSz6Jok
	 //HG1at/0rfOMGQTXFmLUsUxsb1HchQi5jQ7O8gnl8AlHR9z/HBm8aBiKUSPExJfPJ
	 fVCEEZ5ZhVm7iXanFp7cc7Jn/9B4sNuMSG83fEDh2NarQ5quf/CAMqtMNefwCmDbnN
	 cwKbSTmyllToX3zp42i/jkJKk7V+siqCP9VxUkm/IQ8owD/xqjsscQ2Tvz/MD1aO7I
	 zgtHYvvIdrPYw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:06:03 +0200
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
	<linux-kernel@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH ipsec v4 5/9] xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
Date: Tue, 6 Oct 2026 09:05:49 +0200
Message-ID: <migrate-state-fixes-v4-5-d5054459fc78@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
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

