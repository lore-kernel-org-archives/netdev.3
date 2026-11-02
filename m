Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606691;
	b=Qfo05Tj5+Ada9aNAM94eRBoS44PLPon9Vf2kxjUpizvu3qxndY48CWDB9f1DJbI5tu93
	 QQaKrXPAk4bAsRw4qfxB9wwFXfKIiQ/NcFE+qA63fy+Xcj0V9QO050ID2iH0bm794jABF
	 OShpQEt78RXenFG+n1nKCS5gslPPE0AKZo/c8MaJ5QMBIzWCIPgKjxkMyNjE2dvOYOnU2
	 H/4I8psdvN404MZpRauG9hYC4IYK3GmRlmnOP63MUo2eOrF1MPCbWF4zBAwac6LA9sVdu
	 WTD2b0gpQea67FqtbON+ghBBah5ChAHZSiTaASFNB90YPNqYUMf7bp6FvlJQu+FRZlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606691;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=fxT7HXBlhVZyASjDqJy7qF5/OQz1d5UB2n+9b0Tx+a4=;
	b=WLHhfhZwCIJdTnpSOhX3rFjrS5uUOWc3CLC/jrwV6qebxo/xCfJ1rjRySx9cVr/Wrlpm
	 B69Z3CWchoUMN3MwMow+J8iOji2DvGIEtsW9zivpFWlCNlUfrTNWLeuVXmV5wmoNQLOFV
	 NCSqYhxB3JPZ3INPIdHOSa6eRI/trO4oQ90Lc3gCeUIrl+jGLhxW1wXVWLsE6EXIMXPip
	 +KZuZ1jMBKAFm+W2XsgkswK3w9BKdFgkq5cO3JSM6K09WvudfoEKBhxe0W6CAUvpZjO3q
	 URTDZSGL+smqW7N60XGQtPl5VRrMc52YFzafbGgoKr8HevhUCFROuM67djdgzqxlbnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b="zd5I/9L+";
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7687606A33C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7687606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=zd5I/9L+
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D082F207BE;
	Mon,  2 Nov 2026 09:04:46 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJaLi-VWLy7M; Mon,  2 Nov 2026 09:04:46 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 50A3B207B0;
	Mon,  2 Nov 2026 09:04:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 50A3B207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606686;
	bh=fxT7HXBlhVZyASjDqJy7qF5/OQz1d5UB2n+9b0Tx+a4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=zd5I/9L+M/V86vipqEQ9ayNbtkgUNH0c2CuKcD36ssw1BZYpVjFHotBJ5N8Dozpvm
	 xHoqfndxF+lyk0+uhuPXY11DaDhOXvCDMB/ZUl4F/CfUH+JGd3J1EGORT60x4VJrix
	 3+GwCaVkyqGEnbM5iExLJZtRkWQcu6G2dj2K7s+LnuoYWfCHb9hepmuJIrAXRe0bPP
	 s9spXBt6w/i92I/w7Xpda1Ks7fx7pI5GwrR3XeoMK5WJhT2WFrspXqo9BwuLd6q1A0
	 N8a+qvDxVONsbhhjCbAPyg4y16EmUrhGeAOpzgDyDFbgeiL1oFD3yXr1bUgQ2XbHm0
	 ePkIuYWtli/aQ==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:45 +0100
Received: (nullmailer pid 2505915 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/14] xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
Date: Mon, 2 Nov 2026 10:04:07 +0000
Message-ID: <20261102100451.2505200-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100451.2505200-1-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

A concurrent delete can free the migrated state before
xfrm_do_migrate_state() finishes using it.

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.53.0

