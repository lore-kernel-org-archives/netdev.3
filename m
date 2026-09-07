Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827E45349A
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773438; cv=none; b=RATeOAHZCk+xFXLvPAlY38IQ8ncUfavnrsLD6tmeTImV3Kl262m9cqre3ex3YnMBXzr3LsUakJ/Rg9ihVgDbYY7V2sgVbLobRPT8QY7usoOmQ+RQDIYrY1TOU+UsBrZ6/UyoPTC6r6mMDRCW1Tx4VwFOcc1l2XoPIkYkDOSntRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773438; c=relaxed/simple;
	bh=PypWq0MhG+kVqexSMZzJkkOER33fEE6MSvvoZEu85nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9Qi4ys7gg0SqUk+0fXYkQ5AkndrLOJzyfdRZcisAO0LE65/ToSkNyMC+q6j7x3xBLPByZI0gpz0vQoOzo2kGvpAixzLTSFJjYq3tRDx+kyFYjOqCgHlvrKCqWwr6wgU+zPZ+XQow46AASPHTTI+2Otvivw8jNfF+GGf/lNTDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cOljL5Ld; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cOljL5Ld"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 690EB204D9;
	Mon,  7 Sep 2026 11:30:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OdjSpGwD1l5F; Mon,  7 Sep 2026 11:30:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7BA2320508;
	Mon,  7 Sep 2026 11:30:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7BA2320508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773433;
	bh=tjU/viO+z/ifhOFBVx3TRsY4JPRfp92qCD//JKhvuvY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=cOljL5LdayoAySjLL5CGi3bTImCUHTyfu3OK1hQaN2FiIMqiZ5pVypc8mjhlj6oCD
	 jvvq0RAk9Hrv442yoNjgznaoY4+Jug14K26eJklN1bQwaCbPXUNqEcOmAEEIYoqMSf
	 Y2/aahkxGoYLvrJtZH+2f0U1D3Lc7cOHdsKVGE4b2xEA1xomR+TcO/r1NL+nwlC51f
	 b5M05ODf+oSbKjXY+vp+WZD7CNKySIySsl1AwS3o6Et8P490odOhz6zVZPQukdJZME
	 Olbux670UnYrclz65FazpR2cXtJZnDdCmmz5ngKrSjCk7RlmCh4TFF9zZ8V4H50vXN
	 phCqVmTrDXpYg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:32 +0200
Received: (nullmailer pid 2228808 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/12] xfrm: add missing RCU read lock in xfrm_send_migrate_state()
Date: Mon, 7 Sep 2026 11:29:46 +0200
Message-ID: <20260907093020.2228346-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Aleksandr Nogikh <nogikh@google.com>

xfrm_nlmsg_multicast() requires the RCU read lock to be held because it
safely dereferences the net->xfrm.nlsk pointer using rcu_dereference().
When it is called from xfrm_send_migrate_state(), the RCU read lock is not
held, which triggers a suspicious RCU usage warning:

WARNING: suspicious RCU usage
net/xfrm/xfrm_user.c:1630 suspicious rcu_dereference_check() usage!

Call Trace:
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 xfrm_nlmsg_multicast+0x1d8/0x1f0 net/xfrm/xfrm_user.c:1630
 xfrm_send_migrate_state+0x870/0xae0 net/xfrm/xfrm_user.c:3340
 xfrm_do_migrate_state+0x1749/0x1e90 net/xfrm/xfrm_user.c:3507
 xfrm_user_rcv_msg+0x7a8/0xf30 net/xfrm/xfrm_user.c:3907

Fix this by wrapping the xfrm_nlmsg_multicast() call in
xfrm_send_migrate_state() with rcu_read_lock() and rcu_read_unlock().

Fixes: a9d155ea9b44 ("xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration")
Assisted-by: Gemini:gemini-3.5-flash Gemini:gemini-3.1-pro-preview syzbot
Reported-by: syzbot+c0e99a1aa85a286d7a3b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0e99a1aa85a286d7a3b
Link: https://syzkaller.appspot.com/ai_job?id=8977f559-3a7e-4bb5-b4d6-1196956260b6
Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6266a92cf302..980dbeb5a57d 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3337,7 +3337,11 @@ static int xfrm_send_migrate_state(struct net *net,
 		return err;
 	}
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
+	rcu_read_lock();
+	err = xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
+	rcu_read_unlock();
+
+	return err;
 }
 
 static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.43.0

