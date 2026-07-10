Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8D3D6CB7
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674252; cv=none; b=aOgEn7PfztYGk3suTbHKO4bKF8AF4MTfgjeZ4TP0US18ozJ46ssF0+wKjRKfPLvfTQhJdCxQi3ChipjYVSvjzgCrEBzCmugclPG04MPArDevN2vhBPZkUbkQy9j3BKZN+Dfp+7JaEWElYJSEGeano5XMS3FEvMlW+s4CMPiDsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674252; c=relaxed/simple;
	bh=S45vA7WF7U69JggsaErQXOWdhrkg8rB/y+miNybnleQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaoIor579hAGRXuWpC7Igquczhrfq3LS6aXDNHyEliBGq+PMCQ+qf9ez6t8wJRa07KrCi1EpGkoaWn9SKI4lpED+QqBTdzrkdiw3vDHBeVUlL6sWFpr5ZTjxFWRSf1fcGmqa7UVTLMvfupq6TegsMrAabPAC/PotCOXKmwKHM7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=X13scwNx; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="X13scwNx"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1DEF3207AC;
	Fri, 10 Jul 2026 11:04:09 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hy5kh1Wg8XMa; Fri, 10 Jul 2026 11:04:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 571D92083B;
	Fri, 10 Jul 2026 11:04:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 571D92083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674244;
	bh=Qt2Q0Hn3vCgFS6+2unlTJKnwZuWh7dZVrPEUefz/1TI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=X13scwNxYgtAb8N0F4GXA56SrRE4nclYjIsCDAFBC4QqBoE+sxIWO2Y1buqk6wMNv
	 0Li23nN/PTfmOowSNg7D+tQrZn7C92apiSmrNXpPUwOtvz0QttPA9sJ3DgyVv3zExz
	 YptZqfHleslHCjjfKlYGUN5TqV1lYoT2KdTOq2nJ3YAs1GxsjCWk3ScCbI0L0XT88h
	 9c3Uq86xLPg2BRxzkBTuRll1ANPUXXX2iw6HUkupcq2ZaTp/3Mq/iJVkXDH2qZA8GL
	 IpXfWzmy1oFypyO69e+qpAG6DEySbxW8jaTPHw0pz1elFE2VM0S91OtwvN5gYflgN8
	 pKke7HfQqHzTg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:04:03 +0200
Received: (nullmailer pid 343842 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/10] xfrm: nat_keepalive: avoid double free on send error
Date: Fri, 10 Jul 2026 11:03:16 +0200
Message-ID: <20260710090349.343389-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
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

From: Qianyu Luo <qianyuluo3@gmail.com>

nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
send helper reports an error.

That cleanup is only correct before the skb is handed to the output
path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
networking stack may already have consumed the skb before returning an
error, so freeing it again is unsafe.

Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
keep nat_keepalive_send() responsible only for family dispatch and the
unsupported-family cleanup path.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Qianyu Luo <qianyuluo3@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_nat_keepalive.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 458931062a04..eb1b6f67739e 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -55,8 +55,10 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb,
 			   ka->encap_sport, sock_net_uid(net, NULL));
 
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		kfree_skb(skb);
 		return PTR_ERR(rt);
+	}
 
 	skb_dst_set(skb, &rt->dst);
 
@@ -101,6 +103,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
+		kfree_skb(skb);
 		return PTR_ERR(dst);
 	}
 
@@ -118,7 +121,6 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 					sizeof(struct ipv6hdr)) +
 				    sizeof(struct udphdr);
 	const u8 nat_ka_payload = 0xFF;
-	int err = -EAFNOSUPPORT;
 	struct sk_buff *skb;
 	struct udphdr *uh;
 
@@ -140,16 +142,17 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 
 	switch (ka->family) {
 	case AF_INET:
-		err = nat_keepalive_send_ipv4(skb, ka);
+		nat_keepalive_send_ipv4(skb, ka);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		err = nat_keepalive_send_ipv6(skb, ka, uh);
+		nat_keepalive_send_ipv6(skb, ka, uh);
 		break;
 #endif
-	}
-	if (err)
+	default:
 		kfree_skb(skb);
+		break;
+	}
 }
 
 struct nat_keepalive_work_ctx {
-- 
2.43.0

