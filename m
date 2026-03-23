Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711FA37FF54
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254910; cv=none; b=RQmLRGpggbNDj8lTnnHe06hDd5QdKLjyxVuLAAozT0XtUH/zfMFnsyYeaRNMNWhdIaEhAI7drqHUJZeeyFvb/YFliKMHNAz8RXCo7UpKjWJzAaxvmFAPRspoe8WfSKeMHvJlGHvWGb7jovWhmz+o2Qmxw6OuHNQqAptryfFayjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254910; c=relaxed/simple;
	bh=qWWEOT4/acS3D/q4eGcpNZSfRfueiV8K/hamVvI36Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMVK8WZOj09yROHUNPWZWYh54q55e7WMW/QI+DSJ1hCuz7v11MorCnUHZQCUCc7nyJdXfgSYFMyE/JEXIY7cJjruNzGz6Ooh01V0z9JZ58d4IDVOpArpuFNrEpQUhfpazj44Hz5g8uJt9lw5n4l75hPnNk/7f6K2zZkDsO12Bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SDaRCqh+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SDaRCqh+"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 18CE5207FB;
	Mon, 23 Mar 2026 09:35:07 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H6XQz_8cYWLq; Mon, 23 Mar 2026 09:35:06 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7F92B20728;
	Mon, 23 Mar 2026 09:35:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7F92B20728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254906;
	bh=x0DXBCQOXOHj6DYKtppLlT99oBVcbXvJ8FbwQR0qLhw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SDaRCqh+KHmkpzzpeU8nlU4A6fQy2xzRhnIeeXhlJaBZSKuVtG4+8p6JghQIRhXDf
	 dh9hDqIoy7SeptACZ6fHUMUgmlQZo+O04sxsKDYHSBKrNkYoH/j8UCo9vlzRTbhT+7
	 fGUJ4LnATQzNFgh9EGZVkl0M4DdvVlZS3X0a1tRj5OjJbWVC+900RXZ7kUr+HuO5KX
	 2XgiRDViU3DpPT7FxkSV0JsstvGQNKwUsW6q6/vbjrqOhsw3V6ywsp17S//uy180g8
	 Kj7a4ubjUHZkUfGKUFLc4v3hr47Nt+JuaZw8dpJKsbSz+6ybhzgSawArTZXWnihKxb
	 w7hGhChtNpViw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:35:05 +0100
Received: (nullmailer pid 2741809 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/20] esp: fix skb leak with espintcp and async crypto
Date: Mon, 23 Mar 2026 09:33:45 +0100
Message-ID: <20260323083440.2741292-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323083440.2741292-1-steffen.klassert@secunet.com>
References: <20260323083440.2741292-1-steffen.klassert@secunet.com>
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

From: Sabrina Dubroca <sd@queasysnail.net>

When the TX queue for espintcp is full, esp_output_tail_tcp will
return an error and not free the skb, because with synchronous crypto,
the common xfrm output code will drop the packet for us.

With async crypto (esp_output_done), we need to drop the skb when
esp_output_tail_tcp returns an error.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 9 ++++++---
 net/ipv6/esp6.c | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 2c922afadb8f..6dfc0bcdef65 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -235,10 +235,13 @@ static void esp_output_done(void *data, int err)
 		xfrm_dev_resume(skb);
 	} else {
 		if (!err &&
-		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
-			esp_output_tail_tcp(x, skb);
-		else
+		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+			err = esp_output_tail_tcp(x, skb);
+			if (err != -EINPROGRESS)
+				kfree_skb(skb);
+		} else {
 			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
+		}
 	}
 }
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index e75da98f5283..9f75313734f8 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -271,10 +271,13 @@ static void esp_output_done(void *data, int err)
 		xfrm_dev_resume(skb);
 	} else {
 		if (!err &&
-		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
-			esp_output_tail_tcp(x, skb);
-		else
+		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+			err = esp_output_tail_tcp(x, skb);
+			if (err != -EINPROGRESS)
+				kfree_skb(skb);
+		} else {
 			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
+		}
 	}
 }
 
-- 
2.43.0

