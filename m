Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028F493631
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463127; cv=none; b=bL4JVH5JzVnccjB5FCEr67a5xd7wMG/CjDCXY19WkQAXvA6xcCleQaYV/BEC5hTvVIMgxryVEO20jJFB8ShwyHyW8Y5u+7tO8jyS8ALPzSEtUF+/8yV6gFlRR5nAe0cU2K4/Z24eSws+rNqdELBecv3//5s/x3bbTZGvArIGutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463127; c=relaxed/simple;
	bh=HvZwkFCoeV5GI6+iNVm2QGed0Fo9DmQBkL/U2ReMVyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWJVlrdwL8BPEgfonwTfLaJEA2FFbG6QOL7wPuprQEbw5lCASdzkkKadWruz0IsNsbyw/6GXf/x/VOSMBSEDcgJnrGCeZrCO1EnGUp9ez1PIHNSfluyULJ1zOoEbMZEgKbjzyzPtkBEc7tx6PTu5p75TiRrCpwX+p3x8/CBtSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=E5tJZt/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQKwNh4S; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="E5tJZt/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQKwNh4S"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E98C714000EC
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:38:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 08 Oct 2026 08:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1791463122; x=1791549522; bh=GkjjC4FBsK
	V8Ux5QRToA75o2Y2OzewDUHKtEUXAOvlI=; b=E5tJZt/w7hLyL5M5/0LOiyyWxe
	msWXHQAMtbhZCujL/Ikc7xc4x7dC4d6ahX62EDfb1KAN8kGxydqq8vPfmgGJoElB
	k8N6f9KfhCcts/mhg7r/rn7Ndq2y8JGc+s0nmwfd50miC71X6a6N+4lyPM9WsAmN
	XUNqGN654S4TswR0xaI+zNjRF2FnX4P6awlgxr1HzH7l4RTHk5E5l9onH04kB89Q
	wZSjefgixxmEUhXUola3Ow3NZ6pWJ1GPrZXeZlMIo890Oo6Ks1vbzxo4f72JnrQ9
	iKaW5yRMghnVQMYOkypa9gNXlglHsKOjtUXjSpmgDsOnA1ObjCegxZJx+frg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791463122; x=1791549522; bh=GkjjC4FBsKV8Ux5QRToA75o2Y2OzewDUHKt
	EUXAOvlI=; b=PQKwNh4S7U86Whj857SFVqeNiPJYbjZWBX1dPu/rcQrAPqtX85a
	Cw9RVqD6lJjC6VfEOP2aSWoI5XJejwtgF9ClZrBocJbifaNTrdbD8VQPNeRHZRAD
	T0p8n/RWi0ftIi0x8JZxPrg8UewR/iKoSf69HooJ6hb+5j3cbrlYOTmPI6/d1WVS
	gNqsMBFFvsk92///CSw2a8CnIFWDhMFLsjhLp18GEruZVjx5xzdkcGwcuoEVcq+n
	x8K5oCs0yKHlejO/0VHdWDRMHztPIpMXykZWa/FZxSxQs0Byyi8y/rYCYiUugCQm
	5JaHCAhLT1ZVLqYKbsewJQ88yPSl5vm5N1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791463122; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:RYVJvKOPGpFlRr8tGv0cd+js00nl6bg/hhYBvJ3AfiFOZdq
	Xx2F1mJNgSxQMKCXbI6HT0qoxKNQg3MQP4a3iPj+8ydBuIjn7OJ2Z5bmBST0Hwzz
	6iQbUD3xsio7jNV66WsGHUdKblWg5Je00HBWcwrKFdNUH5G9S7GpxYGIXOJI98wl
	8UJX+TyIt0jhSaCk3X3VoSEXIjuMYr6kWPSjrgngP4MsiSW5oG06OJHycSY34CUr
	uG/vTB277r0LDmsVEF3knkPUjDG7+H7dx/g6PrFOAbG1eCEYeRCiqXV3sNQTHRZX
	b8TcLs/QLOkxFluwEx4/UFStIlEwGMlwasT3l5w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:5OFAjD7/CCbsT49d7xFSSryg8h+OnFuDovR2QJbPSY4=:HvZwkFCoeV5GI6+iNVm2QGed0Fo9DmQBkL/U2ReMVyI=;
X-ME-Sender: <xms:0Y7HaoZAS7UT1l7ootFUPG1r9WnCv1VzB6n-1hM2Nr4GaaGve13--Q>
    <xme:0Y7Hau0qIctyT-YubncnJJAF3hUqUGHw9sLwtvRujIcY9s_01TkEvVZhMf8TZOZzE
    hVgzQ4rmSgXQ7sIxiYx2YLoxpX941rX5x_ck0ew5tH05FkE131b0uyS>
X-ME-Received: <xmr:0Y7HamdIF-pS4pHj-bft9gxf-yvUKrKADdMp2JJ5oq_wtLD5uJK1Z9dvUrw>
X-ME-Proxy-Cause: dmFkZTEKFr6KtOFZV3gNLwAF75zo+BUBPvIqX5QRVsRRZO5vz2RNl4OuG2jmNMAUad96Q4
    yCIDDZh0qKm1DiWsmUOV/R8LNzfEM8A4bz0jOMvesU+OpcQK558N26maSvlz7x5lZOdHCM
    3r1xscgEYqBAAYkPhgaPNqkSkUWMgfGG/bP1k14b/wkk+qWzGOAf3gs6q9Ou2Ye0CGaWUK
    umb0s5/OXi6GBrbcLv+nyGWZDkW2dklCQ23/PVnOFRB70rER9aHkaIDFxLE2DGxzKQTQaD
    0WmPc05M6e4XiRV5zt3p0nSwmw1fj7o3wdxGjm2kK+2vAY4kpCJKPD8EJcEwqKIdrmi8tS
    UW0V+mYn/l/XU2Re+0TDnabn2/z+HmupXAwfsIDavZ/V72a7rBxBq0NsGWwnwtSp5+YVP0
    lVFHChZjiJgPKCwluRyC+WUkPJbQvexN1iwt08G+6kn5iKhnrQR1Y170fC41NU3JXFbwH/
    jD4k4BUtTEN6IQtdFXMc/HOSthct/EqCahvQomzNmURzZhYk64xS8NTd/G/otYgb1fMiwU
    6bTvJY5LueTaEYZsnBy7xMhDjVQr0J3VHW+eVOtqE+i3DB0l3kWgpALiAtFBNhu7858Rkz
    +IYNcJHD2BoGMIxNv+e2y4Tk2WMeMdGNeh2Tgiz9ple9crYQDlj7957fHqgw
X-ME-Proxy: <xmx:0Y7HanFEF8Oij96kKEJdDrtCHLkxxnfNmQU1RdVErWx54BQ_ib1QeA>
    <xmx:0Y7Hav08pLF55ToiVUFSBbzmIZvZRatGll-LtlOMuY9UAv_3F7MEFQ>
    <xmx:0Y7HavlvllbDu2TO-fSrMoonbyj5kR-yEMKwkm3vQcnnmtk0DhbADw>
    <xmx:0Y7Hav8fSWPCxtzOXiYKez8pEMhW_6BIouZ2vCogEe8ptfeWF2FBEA>
    <xmx:0o7HartEe0IuFewKrS484TGqZcynxGaiqclPiMgUmTi32Xk9YvinHOSJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 08:38:40 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec v2] xfrm: espintcp: reorder operations within espintcp_init_sk
Date: Thu,  8 Oct 2026 14:38:32 +0200
Message-ID: <41fee34088a7ae150f255493b40f54ecbdc300df.1791462408.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2: more barriers and READ/WRITE once according to the ai review
v1: https://lore.kernel.org/all/dcb164e6a1064fcd32c2e72fd9ee918dd1427f15.1790617484.git.sd@queasysnail.net/

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
2.55.0

