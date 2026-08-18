Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F776446070
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045378; cv=none; b=WRQeesedfzm5URNwgzEKiYkI8cDUyXweVziuOVDlS/ZJg2jigfOLo2yuJ57KsuWlvryY+l7vTNpmHXb/rci7KV77MWZN5rQkUiC0TwNGbm1MLkT36WTPkx0gEtK1hoFCwHaZXNXvS4bBvPz0jtmSKkXoTvzuuopZyrgUNDLtvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045378; c=relaxed/simple;
	bh=NfCZqXQ4nU3JQzpArItDMA58i3fjwuhxVBFdIjgl6e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiUL+I2wcMCqyogG2YUOG5GyxOirSnSa4XMBpWj1+g3y/aD0cKpUSSPwNIb82z+zyq3U7NSpOMwo1BeSM/hx31lgN2w/eT5KKvfjM0GI6R1Osrk7wWtqRRY86H8UsRU3JqpndRtoXkkedl3g5BZF0Y05VkgxJaaiI2xqED/pEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=XUE5tVmG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="XUE5tVmG"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E2C3D20185;
	Tue, 18 Aug 2026 11:29:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vBB2EcnkHmI2; Tue, 18 Aug 2026 11:29:34 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5637020754;
	Tue, 18 Aug 2026 11:29:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5637020754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045374;
	bh=FbmPn4SJ4VM6mS2qfOjbfADi/9vIPxvE4pP6PFI7QRY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=XUE5tVmGE4EStqXHq7yeNY76tewgpEpy/z6At6XrwV44xgeDBwsmcmB54nEfD334+
	 PHzvudjUl8PyawCRd1p/oQp628XiChzrG9dpEeDNrrLcBybxccu206PYLFSXiQta7Z
	 0lDx4KJ+FDSFf94d3g9n9xGy33WycE90fJ2bBX+6XS4pEjDCD+8/thi6ERmxo3/HUO
	 ZAHiBqBMrgfAKFwziYVd3+xt8M4rCiD0HwSxnF5RyJFVXrv6E7Rcw5/boNc70vAuPa
	 XKC8NkTicd7f7ydobQjOxxzLahlpXRCxRd+aa4d7OzGDLMciogVPaDE548eQ5ECsCE
	 ldaN6hsUE1pIg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:32 +0200
Received: (nullmailer pid 657488 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/10] xfrm: espintcp: fix UAF during close
Date: Tue, 18 Aug 2026 11:28:34 +0200
Message-ID: <20260818092920.653034-4-steffen.klassert@secunet.com>
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

From: Sabrina Dubroca <sd@queasysnail.net>

ZDI reported and analyzed a race condition during close for espintcp
sockets:

    espintcp_close() frees emsg->skb via kfree_skb() without holding
    any socket lock. Concurrently, the xfrm_trans_reinject work queue
    invokes esp_output_tcp_finish() -> espintcp_push_skb() ->
    espintcp_push_msgs() -> skb_send_sock_locked(), which reads the
    same skb as a data source.

Fix this by adding a synchronize_rcu() call after resetting sk_prot,
since esp_output_tcp_finish() runs under RCU and won't use a socket
with sk_prot == &tcp_prot.  Simply taking the socket lock in
espintcp_close() could lead to leaks, if esp_output_tcp_finish()
re-adds an skb in the slot we just freed. After this, the existing
barrier() is no longer needed.

Cc: stable@vger.kernel.org
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Reported-by: zdi-disclosures@trendmicro.com
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/espintcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 374e1b964438..cd817b855ba1 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -515,7 +515,8 @@ static void espintcp_close(struct sock *sk, long timeout)
 	strp_stop(&ctx->strp);
 
 	sk->sk_prot = &tcp_prot;
-	barrier();
+
+	synchronize_rcu();
 
 	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
-- 
2.43.0

