Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88F4483A1
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045383; cv=none; b=c+rpDkur6XuNZZYcc6qPxnlFEtC1beoorT0aO1Y74pCFuR6MU0uFVCILcmLAQfoxIy15BQ1tQltVUD6OQB4kP3/+MTDwuiwJ2jhy5emcC+PJgn2XKlHO99yON7tTIMy2XSZlhf1lbo/JZdUluobcDKGGvqOzMwv8Hk8z2FcEpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045383; c=relaxed/simple;
	bh=AvxKvbmvQg5QkquHi81B7VtZw/EpMdlOUBtHjHhnSEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEG4lAN9IFsk+yHa7SzTGJ6B3CtDrA0njMYD5UPJDvtWERbcnoOhxitWf2SkCdS8vRus2ftJ0wmgqPLP3u+IHUBPtde85ruORSnQfyArMjnrPa1KZ6YsdzLfzyp10VYDM9Q8bRUGm6v79Yl4I8S5p/qYxqa+CRK2SY5B699TpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=r3p2H+Uq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="r3p2H+Uq"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3E15320185;
	Tue, 18 Aug 2026 11:29:40 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LBf-EalAgVty; Tue, 18 Aug 2026 11:29:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A4735201D3;
	Tue, 18 Aug 2026 11:29:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A4735201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045379;
	bh=McULMpt6qvfK9HALOZXQZzOQe2pH6Knhki8rrImlCL8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=r3p2H+Uq+mxQCFN2pFoSWKt7Pxk5/npHCSUBmXhOSYaFCQSzhJPVjvcztY7q4EVIH
	 pcST0TA31B4bo8Xyh53m3dE3KIkKgZAG6nXVaV3ZdxQYJow3RIxkJjZN3rJTIlG+H8
	 yVUQi6GK/JaDmegfy2fGbSFuTzO353EifSqlTRvCQaJmMjyNgvJyeT369Q/RDQ3joh
	 yc9xjq6T9H2UYeAzar0kBv9nNeShmJaJGX8roAHM7Y31+85PRACE8uLsGa9BVAizbp
	 DSoSPZ7DHmB/lTK0MpXllz8w1n3lX0lLmQ3QPYLzCOz9M1Lyzqf11KSpKUGUWLPc8C
	 TzyXBcFKde3MQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:37 +0200
Received: (nullmailer pid 657491 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/10] xfrm: drop ESP-in-TCP packets with no ingress device
Date: Tue, 18 Aug 2026 11:28:35 +0200
Message-ID: <20260818092920.653034-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818092920.653034-1-steffen.klassert@secunet.com>
References: <20260818092920.653034-1-steffen.klassert@secunet.com>
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

From: Zhiling Zou <roxy520tt@gmail.com>

ESP-in-TCP receives records through the TCP strparser. handle_esp()
restores skb->dev from the saved skb_iif before passing the packet into
the XFRM input path.

Queued TCP data can be processed after the original ingress device has
been removed, for example during veth or net namespace teardown. In that
case dev_get_by_index_rcu() returns NULL. The XFRM IPv4 and IPv6 input
paths both expect skb->dev to be valid while building the route lookup,
so queued ESP-in-TCP data can dereference a NULL device.

Drop the packet if the saved ingress device can no longer be resolved.
Such a packet can no longer be routed through the normal XFRM receive
path, and this preserves the existing behaviour for packets whose ingress
device still exists.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Assisted-by: Codex:gpt-5.4
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/espintcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index cd817b855ba1..674aedc5af5a 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -37,6 +37,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 
 	rcu_read_lock();
 	skb->dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
+	if (!skb->dev) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		goto out;
+	}
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
@@ -45,6 +50,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	local_bh_enable();
+out:
 	rcu_read_unlock();
 }
 
-- 
2.43.0

