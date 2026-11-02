Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606690;
	b=OFXKbWyqLoi/GyWEPmMGtqShM51rwONxAaeDR43syVq4A3ro6++L3JNMqMMnRoPhePtg
	 wtGKByVW2wmbjYcCL7x8gI+xR0FChfbOiQF6SikI6qCICLEpMcoQpDc2VPEUTmNEgZJci
	 OU4kFWTbHJnDz6Lo0tNy/diU+7zmAFMwldCe9WmAO/RZSEzYVXTt13++hqVL9QjUBLLXi
	 gMK3vx7OJbYPPU4IrR6T+G2VTzeAPBd2BZSn41YdVFaV5WU4qkQXsJsUA1nQnOy1XlI6H
	 qGPFMkkW0wNDSSiO7bFnMwASBqDoGWXvJCsiEND1q9k2kEr0crv4iyuVcJR889wDx6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606690;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=zg6lvfSQl2e+W0ReaPcjme52b3BQ9rWrEec8k/nRdrc=;
	b=5gbZyMk5kRomx9cxSZl2LLeo1XQ82Rj5niU+V4Hnoa3z93+yUAGaxKkjLIpUYfPZdz5+
	 LcQcsdqE4sCeDiaNk2VFrAivS5eKR1+JT8bnKBluqj7IgxyQf6MvFUPIl9wRBe++CgvJO
	 eAjuPInpHoW8C/JLDtVcFI21hNe7sqCcGZQsFUUffkFt/MRL9SD6O16U4iQiJgeyQt8DN
	 HLWIxeBeCBdQ6Yz04TWctBsgmcMzGY8iG2Rvg1utrP+RYW0ncSnTJh+zupD8Uril8e4Jr
	 MSGRX0u50onf2cqwQRYQ05qvnmX0olez7Br87Z909vfuafbrGLtwwNTFAhM9Icrp3Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=scmQ+IXR;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E30606A336
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E30606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=scmQ+IXR
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8A80A207A4;
	Mon,  2 Nov 2026 09:04:42 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KHA09_aqY4qO; Mon,  2 Nov 2026 09:04:42 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0AFD1207B0;
	Mon,  2 Nov 2026 09:04:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0AFD1207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606682;
	bh=zg6lvfSQl2e+W0ReaPcjme52b3BQ9rWrEec8k/nRdrc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=scmQ+IXR0PhEgE5spWNwR2u7boUmPBjBGgygRiVSGYh78Q3QvxHJnH4932l5QclvT
	 S7PklgHDtUdIp282ni7zx3AUAod1v5Z/UV9YuiELy/q9gufCwLoxt8rY+R4F+GGvEa
	 rk1zSO80CGBW9WS/j3/gEKTJruPPqB+v8g97VAwo1Wib7UnlmGNR2NHzRK0L00XHtO
	 95oDFdGdIa8HlP7k3XlvUahDhsUTLh6zCAWY+CHgAJ9vDkf9sfWaVltC73JeokDrsW
	 RBu5b621Gjc7xrQlHXmJzU8YTV4uqRdg7L4qC7rQhFOXDc/QgwoTa/5KJi9hMD0n0+
	 NzIG+6cI9whqw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:41 +0100
Received: (nullmailer pid 2505924 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 12/14] xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
Date: Mon, 2 Nov 2026 10:04:10 +0000
Message-ID: <20261102100451.2505200-13-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

xfrm_init_state() takes an extack parameter but doesn't pass it to
xfrm_init_replay(), so replay-window errors can't be reported via
extack.

Fixes: 231a1744dc43 ("xfrm: add extack to xfrm_init_state")
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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
2.53.0

