Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CB405C41
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100503; cv=none; b=tYC7zfF3h0Hc0XYgKM9DLb6RGarxIAV8pQ0ZX6MY9HoGzJOfDBXrn468b0ghj10Q5BdAlC0mZunDyO0DR4yRrNyTnaPw6UYZpEIdn/NWd6G6zOp42R9nPN125XsRzNarDVVhJj9pYT9fq7FVLtFBJljD3VH2FRJ2VGkhzsbQozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100503; c=relaxed/simple;
	bh=QzBUl6Wz8zcuD+83ArX8+wGPLweZhTj+xMGAtIXJIT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2GGzo9Dp/KPCwP0J4nofX+ZQJXzz4vLLzbKIOx6fhTXlL+Ed3oy7zKwWBAKdLGq4csiO+/9FLCcBx9juct9TIAKc+FwiS5oH85UsDjq9SrOnSYYIjCyyLWZ3snJu+uOw/gvltlDtZWz0ki1SRbOjdFZkAibP1+QnGFROwJm1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lgCVR9rh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lgCVR9rh"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4F175207B0;
	Wed, 10 Jun 2026 16:08:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UXleG5ZLi0M1; Wed, 10 Jun 2026 16:08:11 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 27DDC20758;
	Wed, 10 Jun 2026 16:08:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 27DDC20758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781100491;
	bh=egReCZ7OTb/n42kA84x8FZ4d7Ekf0hlNLSM87ZmX2Jk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=lgCVR9rhGgQIkqGBJRZz3NC92QaBJlMsxFxNCbajT73gjqHv0NK6+s3sQDPZchkza
	 fh093CbcG9F/DuePN5EdM7kdCLfbvcjLza1aakeoP6ysw0GUWBBCJk9HvLAIyqvw0u
	 BUqL5oG1ghcfochmO3TldvwmxHszjIssHILIJIxJ2PH9IoG0Gc007J9JwbcMCxwfSw
	 2dlkQB5AfXC/9iZfqIaaV5rGbR2RXOONYy+ZQEMocw+bj/b9XvJru/5rpNS/oYMSRj
	 H/FfBY4lxODBjI6adNZjojfpDbv7ROHLc4D3722S3tuMOST/VcerOK2fxgXTzIBQdv
	 X723dvM9UliYA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 16:08:10 +0200
Received: (nullmailer pid 2563206 invoked by uid 1000);
	Wed, 10 Jun 2026 14:08:07 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/6] xfrm: espintcp: do not reuse an in-progress partial send
Date: Wed, 10 Jun 2026 16:07:44 +0200
Message-ID: <20260610140800.2562818-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610140800.2562818-1-steffen.klassert@secunet.com>
References: <20260610140800.2562818-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Wyatt Feng <bronzed_45_vested@icloud.com>

espintcp keeps a single in-flight transmit in ctx->partial.
Before building a new sk_msg, espintcp_sendmsg() first tries to flush
that state through espintcp_push_msgs().

For blocking callers, espintcp_push_msgs() may return success even when
the previous partial send is still pending. espintcp_sendmsg() would
then reinitialize emsg->skmsg and reuse ctx->partial while the old
transfer still owns that state.

Do not rebuild the send message when ctx->partial is still in progress.
If espintcp_push_msgs() returns with emsg->len still set, fail the new
send instead of overwriting the live partial state.

This is a memory-safety fix: reusing the live partial-send state can
leave a stale offset attached to a new sk_msg and lead to an out-of-
bounds read in the send path.

tcp_sendmsg_locked() already handles waiting for send buffer memory, so
the fix here is just to preserve espintcp's one-message-at-a-time
transmit state.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/espintcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index a2756186e13a..d9035546375e 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -346,6 +346,10 @@ static int espintcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			err = -ENOBUFS;
 		goto unlock;
 	}
+	if (emsg->len) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
 
 	sk_msg_init(&emsg->skmsg);
 	while (1) {
-- 
2.43.0

