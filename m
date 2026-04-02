Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9613BE64C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129481; cv=none; b=jt5RlXL7Sq7CrEPOfzAXLjsTJ6yinTmmatDMFrR2T4cp2raXENyPb7M+nHWJc7d4+4OxSQBgYqTI5WjsF3MSU96+WzKt27s6a6rqvY05YB50HTNzcmos0yuK27c6sh6xR6gjnBa5EH+BKtVl1L18zCWhnO7Uoa4aojB4QciVMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129481; c=relaxed/simple;
	bh=mSEkuCObbX1g+M8UHrqTR0r3eMOViSo0zdQIifKncqg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nJoHlrw2Uq29TLibm5BRuERuZLSFNyFDuo6ioCznXOLNq8Bk2V/KwnbO2mky92fJtKw6fta8dJ2XzfiVwzObRRKkMl9noPzIlAemG6c/ZL/CpBq1aJY9Kw7qKrEzo2orsqDZEf4hRLgTD8lWs7Pi2AGwa0dPp+7CvfZR3mS6BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uR16fDnb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uR16fDnb"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1204320882;
	Thu,  2 Apr 2026 13:31:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qMS7DXoC1Om4; Thu,  2 Apr 2026 13:31:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 808A2205DD;
	Thu,  2 Apr 2026 13:31:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 808A2205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775129465;
	bh=H7aIasCYh51WIu3d7cN2ZR0DMYICst9whbDjaCq3ZYY=;
	h=Date:From:To:CC:Subject:From;
	b=uR16fDnbzxl/z+TGFxBZ4OO4J1wSmP3mhcSmFVKIvgWg9HJLgOFaTPX+j8hhrMAbN
	 E1ERrucat9r5go3qRRGngxfi5KkDd2tkroJT9Md4vJNYymZDXqU6O7o1PrdzI00fXX
	 6h1B2drDYpoQaSrvot9sXKA62TlSmK0TSPdBVhJ1jiCQbWlzU4Jgyx6VsJbRt085Eq
	 40besQ6+mr6kmfFNAepKqayF9+YtlHWHdgAULB4dK13YnGhOBDV3zq6Zcva9bJPiJw
	 joKEb9fFPBqthhH7cddtmLwpy97Gu7xfAKALOlM9JVCa/xFfIN93C+uZYkGGVN3aKr
	 J/vhqUrmHzOkw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:31:05 +0200
Received: (nullmailer pid 3788133 invoked by uid 1000);
	Thu, 02 Apr 2026 11:31:04 -0000
Date: Thu, 2 Apr 2026 13:31:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>
CC: Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec 1/2] xfrm: Wait for RCU readers during policy netns exit
Message-ID: <ac5TePdKtegtWiRG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

xfrm_policy_fini() frees the policy_bydst hash tables after flushing the
policy work items and deleting all policies, but it does not wait for
concurrent RCU readers to leave their read-side critical sections first.

The policy_bydst tables are published via rcu_assign_pointer() and are
looked up through rcu_dereference_check(), so netns teardown must also
wait for an RCU grace period before freeing the table memory.

Fix this by adding synchronize_rcu() before freeing the policy hash tables.

Fixes: e1e551bc5630 ("xfrm: policy: prepare policy_bydst hash for rcu lookups")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 362939aa56cf..8f0188e763c7 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4290,6 +4290,8 @@ static void xfrm_policy_fini(struct net *net)
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
 
+	synchronize_rcu();
+
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
-- 
2.43.0

