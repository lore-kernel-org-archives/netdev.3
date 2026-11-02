Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606694;
	b=YdSiu+Zv6THKXJ+sdA+bZIOAmqWXLRA0kSipfl7xL9uvB3S94TVOhl2OwLHeQwdcLO/Y
	 YEMYzcEpgsk7jj2rAvnysoTi76su5P8gY6K4znaUTkF9386mVyEvIJQyxbiStpnIwc6MT
	 guSAiSGWs0y749QEyx2rSgIOTgCGTTpLFLP8pn2WCoXOrMqvPJL3OrafYFI2kC4j6e0tf
	 Bzm5tLi6hlhsteZiF9GOhF1m43jY3k0daIXACiGN/3A5uX6yrgibT7MLf+XhifWw6obLb
	 zP1I096B9c+KoFZRWPA8/afOQ38oHHW2f8sLrOAK7XJ1jslWE9aE+WZCOL0UZoRN5Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606694;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=4+A/IPtr1zAGWJVL6F4Lv/Y3Q75zd4cJs2PSxPvnViY=;
	b=c2K27zrbSckBrs8FXSQoxBzKmYok66JDLa1trReqcqnSN9a3clgVc/vgtspsTFMmLahd
	 TJtj5dooeJR9mdiv8dv6UWGwVak39jwLZzIkfjZU39sWPaI0Vh8lFlQWQys9a6N5vE4IY
	 tEz3WbDp+3TzT2aTaeeNSk5I4NSBktZ6MrFZRprFLd3VYCAbXOr4tLyUYVydeiwaOlts5
	 AKOedOOtNs0t6wrrgyzprrqEGQjMZJz8YfDsL+tDVyOxZnfnbArHgy8EeY1/Ri1jFPbVn
	 cAqBG4FEJawhYdF80G9xiZLu+IPYwnDBEAW7qhDqsfFtZgDo/JoZlWsQLVk9P9ru71A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=jmnDooWB;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770260A2600
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6770260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=jmnDooWB
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 444D7207BE;
	Mon,  2 Nov 2026 09:04:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKj9Hcg4nadO; Mon,  2 Nov 2026 09:04:51 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B6728207B0;
	Mon,  2 Nov 2026 09:04:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B6728207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606691;
	bh=4+A/IPtr1zAGWJVL6F4Lv/Y3Q75zd4cJs2PSxPvnViY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jmnDooWBBDcMFGBM43za0DWLcTzq8nT0FI10+e9//+iHJs9SMago5lgYLbrfJ2y/1
	 i3+tKx1oWQ7bKPYWrxWf0NSS2ysmhYJWRMfcar5Q/59ywhgF00SZaloU82AsgC3gMp
	 SRjkTtFWq3Khia9OtgsWyIMmm+vPk2LnGgNiIAFtUeuzlaa6iJvFI0RjtwPN2mLkRz
	 4za4eGuImkvYUhK6/OAxvgG04p6PYLmw54VttLp9t9RWDfGjtHqJfj8Dpfnxf3aoLf
	 Qow+eMIqhSwq28z7/6wowZrhnvIsmi5jGhgCztiSxmy6KFHKbGzxNS+cZ/8fWktnxd
	 3WWSmwNFtJVVQ==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:50 +0100
Received: (nullmailer pid 2505909 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/14] xfrm: policy: reject mark with bits outside its mask on add
Date: Mon, 2 Nov 2026 10:04:05 +0000
Message-ID: <20261102100451.2505200-8-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

Same issue as states: an invalid mark/mask is silently truncated on
insert, so GETPOLICY and DELPOLICY can no longer find the policy by
id. Reject it instead.

The mark is no longer sanitized on policy insert.

Fixes: 0b91fda3a1f0 ("xfrm: Sanitize marks before insert")
Cc: <stable+noautosel@kernel.org> # avoid breaking existing userspace ABI
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 3 ---
 net/xfrm/xfrm_user.c   | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index f6f40ba713d5..0f6fcea28bcd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1575,9 +1575,6 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
-	/* Sanitize mark before store */
-	policy->mark.v &= policy->mark.m;
-
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6b53373168b0..c1571c7a2315 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2307,6 +2307,9 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		return err;
 	err = verify_sec_ctx_len(attrs, extack);
+	if (err)
+		return err;
+	err = verify_mark(attrs, extack);
 	if (err)
 		return err;
 
-- 
2.53.0

