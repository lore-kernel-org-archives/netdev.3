Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606691;
	b=nrYoBIe8JxopHGqgAQBZN2bncEN9nUw7MOsj/d6PjLQWVQIkBTkCg1GFJ28x6XEclsBQ
	 xnoybLZur/jXB2oJu1OIVDP+jDpDl6vAtf+nVpH0OAxrnERoivwrvzdkT353epDIoHwcl
	 8WXQrgsJUMi1V2SRPpajpQXF+cPifjgn4ncePQw5XvqVG2WgfkudNJzHlxNUvVxFIgapg
	 XSuekvWVsttJlbTr8/S/VbQ5eWGUTxrSWdmtxzOW27gN44J8oVBHHFOLuJz8QrXdHO2aV
	 FAlE3PB0xFwwGmIELXq8LJQdHnzufZ/jbQCF9SRfltUU3F5xuG6dSrvQ87yglsn/Fsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606691;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=Z28FTFDQOS5c5X6nFViW3Ykrm9XnnWLENM+RZYavkXc=;
	b=d6yvyfE5JNYDFwmzgschucq9wljh3wLqWVUBkntIwdLVWa/ICpdgwkokEx8xDfRZnZj3
	 9G2iAMLenVXIbYbZhqBHIbzLj05aACnmUj10tpAi5rsJ/VdUf70otujeDd2c7zxZ0u7oG
	 vMGZ5329g+zMOa8mmXnLEvg7ag/4waaYLjKjnECxJ7s3edga6/3lsaj144eOeVXK9u14B
	 FDZ9CgXO1UMXdOG096GSB2DM7SgHjxWJ1Flz0qEQNTUoJV8hnLYet/k+S78R9DRUhnrv/
	 kkE/QM6TzhJKiaxjhvmhhdFHf9fEPXDF3HjGXycMyx7wXc7pg1piQUi5hBLjRYj61Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=tszmte9T;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078060A2604
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7078060A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=tszmte9T
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4819520520;
	Mon,  2 Nov 2026 09:04:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OKoCepaINEkh; Mon,  2 Nov 2026 09:04:45 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 924E5207D8;
	Mon,  2 Nov 2026 09:04:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 924E5207D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606685;
	bh=Z28FTFDQOS5c5X6nFViW3Ykrm9XnnWLENM+RZYavkXc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=tszmte9ToaCXFEsi2o2ZH/UkgsTBgDp+QyyKxSaR+ENEiuNwRqC6EDFtfF7xJOsez
	 91/yYbNQhcxxp1A9vTuJJq82Iq3XD1enHSrccuFRu0CKK/mR7CGTD4NPlwrjmr7Lge
	 j8ni7U/uZPhfFPvpriaNFT0QBAQhTfOs7tVAAWBjnJJhdQ4V8h8MZyal31xyVSCL+N
	 yqjG7jgk0+90N1sIZahrymbn1pOgPsUT/gpoLYUbxwrMP/ab9qwaHErmOlRV5UeyCN
	 RywP8SscZzVtKPXtpTUwRUe11inftOzyWlFrk9BZzOXdNDvNFH9RT9PbZk3UrSDfxD
	 mOZTMcI0HA/oQ==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:44 +0100
Received: (nullmailer pid 2505900 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 04/14] xfrm: espintcp: reorder operations within espintcp_init_sk
Date: Mon, 2 Nov 2026 10:04:02 +0000
Message-ID: <20261102100451.2505200-5-steffen.klassert@secunet.com>
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

From: Sabrina Dubroca <sd@queasysnail.net>

When enabled on a socket, espintcp sets the socket callbacks to its
own before it has finished setting up its context and published it as
icsk_ulp_data. Any one of those callbacks that gets called before will
dereference a NULL icsk_ulp_data.

Fix this by reording the operations, and add memory barriers to ensure
callers will have a struct espintcp_ctx available. Add a few
WRITE_ONCE/READ_ONCE too while we're there.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Peihan Liu <ronbogo@outlook.com>
Reported-by: Yilin Zhu <zylzyl2333@gmail.com>
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://lore.kernel.org/all/c30b645074a1b379e0f7fe297f917c66137d9964.1778464688.git.zylzyl2333@gmail.com/
Link: https://lore.kernel.org/all/20260819155349.3555804-1-jjy600901@snu.ac.kr
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/espintcp.h |  5 +++--
 net/xfrm/espintcp.c    | 43 +++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/include/net/espintcp.h b/include/net/espintcp.h
index c70efd704b6d..7cad3c6822df 100644
--- a/include/net/espintcp.h
+++ b/include/net/espintcp.h
@@ -34,7 +34,8 @@ static inline struct espintcp_ctx *espintcp_getctx(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	/* RCU is only needed for diag */
-	return (__force void *)icsk->icsk_ulp_data;
+	/* pairs with smp_wmb() in espintcp_init_sk() */
+	smp_rmb();
+	return (__force void *)READ_ONCE(icsk->icsk_ulp_data);
 }
 #endif
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 3e72b9f067b9..4052ae5bbb2e 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -434,7 +434,9 @@ static void espintcp_destruct(struct sock *sk)
 
 bool tcp_is_ulp_esp(struct sock *sk)
 {
-	return sk->sk_prot == &espintcp_prot || sk->sk_prot == &espintcp6_prot;
+	const struct proto *prot = READ_ONCE(sk->sk_prot);
+
+	return prot == &espintcp_prot || prot == &espintcp6_prot;
 }
 EXPORT_SYMBOL_GPL(tcp_is_ulp_esp);
 
@@ -466,34 +468,41 @@ static int espintcp_init_sk(struct sock *sk)
 
 	__sk_dst_reset(sk);
 
-	strp_check_rcv(&ctx->strp);
 	skb_queue_head_init(&ctx->ike_queue);
 	skb_queue_head_init(&ctx->out_queue);
+	INIT_WORK(&ctx->work, espintcp_tx_work);
+
+	ctx->saved_data_ready = sk->sk_data_ready;
+	ctx->saved_write_space = sk->sk_write_space;
+	ctx->saved_destruct = sk->sk_destruct;
+
+	/* avoid using task_frag */
+	sk->sk_allocation = GFP_ATOMIC;
+	sk->sk_use_task_frag = false;
+
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
+
+	/* pairs with smp_rmb() in espintcp_getctx() */
+	smp_wmb();
+
+	WRITE_ONCE(sk->sk_data_ready, espintcp_data_ready);
+	WRITE_ONCE(sk->sk_write_space, espintcp_write_space);
+	sk->sk_destruct = espintcp_destruct;
 
 	if (sk->sk_family == AF_INET) {
-		sk->sk_prot = &espintcp_prot;
-		sk->sk_socket->ops = &espintcp_ops;
+		WRITE_ONCE(sk->sk_prot, &espintcp_prot);
+		WRITE_ONCE(sk->sk_socket->ops, &espintcp_ops);
 	} else {
 		mutex_lock(&tcpv6_prot_mutex);
 		if (!espintcp6_prot.recvmsg)
 			build_protos(&espintcp6_prot, &espintcp6_ops, sk->sk_prot, sk->sk_socket->ops);
 		mutex_unlock(&tcpv6_prot_mutex);
 
-		sk->sk_prot = &espintcp6_prot;
-		sk->sk_socket->ops = &espintcp6_ops;
+		WRITE_ONCE(sk->sk_prot, &espintcp6_prot);
+		WRITE_ONCE(sk->sk_socket->ops, &espintcp6_ops);
 	}
-	ctx->saved_data_ready = sk->sk_data_ready;
-	ctx->saved_write_space = sk->sk_write_space;
-	ctx->saved_destruct = sk->sk_destruct;
-	sk->sk_data_ready = espintcp_data_ready;
-	sk->sk_write_space = espintcp_write_space;
-	sk->sk_destruct = espintcp_destruct;
-	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
-	INIT_WORK(&ctx->work, espintcp_tx_work);
 
-	/* avoid using task_frag */
-	sk->sk_allocation = GFP_ATOMIC;
-	sk->sk_use_task_frag = false;
+	strp_check_rcv(&ctx->strp);
 
 	return 0;
 
-- 
2.53.0

