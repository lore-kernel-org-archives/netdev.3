Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB04503ED
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773455; cv=none; b=hEpYWiApz+liLC5cyAJUwtOo784kc7OnSAnsyfWDtMx61txytE66JovedmpM6rlS1bv6HAo3RADeZhRWT/BlxCniv6D6AW6E2fcleTExMeOTxYnwC76IvieD7yoSUGs66pl0PR1uypVmL0uWZH6aYzGKfJfy8DheE6qbBDxBWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773455; c=relaxed/simple;
	bh=K3avQDw4SIiRlyiPG5UVu3K7RoMDCA++kibOQbQMYbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxLANhSXiTW83BqpiCNpH2A/A8s1s+9OP+saQBQqLsV7W31LdXQ3IbxKVkoJOYhf7pCc9LDAonDLnhLLuIBP7aEI1SnVEasJ1JXNKXRVnKW/q0TrUA8OngQ0/yBaPBdKeB54+z2Fy75x0FjpG4xtQU+DjeSaEqUH751/qdVOZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eRcodcdi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eRcodcdi"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 132F520719;
	Mon,  7 Sep 2026 11:30:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRTkUEMcaCGY; Mon,  7 Sep 2026 11:30:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7E9E0204D9;
	Mon,  7 Sep 2026 11:30:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7E9E0204D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773452;
	bh=Ranf3Cb2zWU3FrTs7Tdx/hCsyriReweHk8TxL9/x/nc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=eRcodcdiplb9g6AhaxvDUZX+PCk9KcgDQorHA1fr/9CTtdczz3IgWNanutjOGQEdn
	 dWu2JAttRByspn4Wlt44dhsAnEdRuVlYtFizjSIpaWPn+bvXhrW1o9ee7QPXj5nMkj
	 LReoYoFNWU988sJ9zP3CmrcaG0+UZzwjBA7pHu+wB4pmOeFH/ajrY4Dy/gBZywAUGZ
	 Rr2Qob75nDCyzpMnl1F0dqXMIh/pucckuQGc+u/LGyt0M47peFI6Vw7b4fXCqfjyOI
	 YAi4Z0fXeSVXO78jNSk/6J9SoxuaHsHgx9nBQJ+VYH220BHRhLn4RNTIhbM9N4pW98
	 DP+uKaB6smR+A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:51 +0200
Received: (nullmailer pid 2228835 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/12] net: xfrm: reject unrepresentable espintcp transport headers
Date: Mon, 7 Sep 2026 11:29:55 +0200
Message-ID: <20260907093020.2228346-13-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Wyatt Feng <wf.kernel.dev@gmail.com>

ESP-in-TCP can hand xfrm packets whose transport header offset no longer
fits after the stream parser trims the TCP envelope. The plain transport
header reset truncates that offset and triggers the skb warning path.

Use the careful transport-header helper and drop the skb through the
existing XFRM error path when the offset cannot be represented.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <wf.kernel.dev@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/espintcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 674aedc5af5a..3e72b9f067b9 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -30,7 +30,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 {
 	struct tcp_skb_cb *tcp_cb = (struct tcp_skb_cb *)skb->cb;
 
-	skb_reset_transport_header(skb);
+	if (!skb_reset_transport_header_careful(skb)) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		return;
+	}
 
 	/* restore IP CB, we need at least IP6CB->nhoff */
 	memmove(skb->cb, &tcp_cb->header, sizeof(tcp_cb->header));
-- 
2.43.0

