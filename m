Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1454508E9
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773438; cv=none; b=R6S5YZicYc6S+oyhOix5LNyqQ1ShghinHeufPSyZ6KXQI7/gakDYHN1O2n/GQwqBQHGt/dZzQk0r6umSQg6O2N+dsMzAG2ktyvmcWcKdpItaaaWne9JHFlQgL+pBzhFBveKDtxZyJC7TbmYhmHVSkgqFL04R7V3y5p9lma7XKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773438; c=relaxed/simple;
	bh=EnFcOp/5smEyL9UjudpmjJpO0RVyj9b71zV5dewldlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv8Bjc4gRr3Kwn2Xq5cKaieeAqsVGN85ZsmcBnzy4L/H+0m6qxgP3xqpxVgiU0FWYAD0pUIeSC1N8rT0R040cfn9qLQtBrj0jKpaXXRmocPEHEJvfdZrsmh0FBSwuNRtBMy7OFSZ4S4b35QQGp9GeEbvuLHJIuOYOaQIRzHZQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=l7BYmT4+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="l7BYmT4+"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B763020754;
	Mon,  7 Sep 2026 11:30:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B1TgLiX4Cmlp; Mon,  7 Sep 2026 11:30:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A189420663;
	Mon,  7 Sep 2026 11:30:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A189420663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773431;
	bh=6STJUMD1l5xGn2J2trTkCbNUqgNpDPUE/nySkJGqvDk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=l7BYmT4+GDjKRrUWxN2l06A7zrcEYgUbnrJymDF+3MEUHBc+m3o9aPSzgF3SwYn8v
	 0CtFi890t8fC2q6ysC3fhVB3XBimklqtMIxTK4iLjkS6aJGy2gfczg7JTh8UtmkHVn
	 OclzcIRovQykTrNvDOGoW4d38Ir7bFar8xuVeOxU7TKo575svUTqQ0P45Ytq9PWLWW
	 G/u1FByYG6TJ0FUxI7bg//OGM0j6rkKBUKAmfHlmvchrtqwSMashTmu4NrHZm+x09Q
	 q/erRgkGabdUPGj4nBgK29TjHIjwPc+7ZSciRbqF9CHEViWRcU1WhWXdqQjCoRajN3
	 xAOZfJW57BjLA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:30 +0200
Received: (nullmailer pid 2228817 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/12] xfrm: fix compat ALLOCSPI request use-after-free
Date: Mon, 7 Sep 2026 11:29:49 +0200
Message-ID: <20260907093020.2228346-7-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Kyle Zeng <kylebot@openai.com>

xfrm_state_netlink() builds the ALLOCSPI response with
dump_one_state(), which already calls alloc_compat() with the response
skb and header.

xfrm_alloc_userspi() then calls alloc_compat() again, but passes the
original request skb and its header. For a compat request, the
translator therefore interprets the 228-byte compat xfrm_userspi_info
as the 232-byte native layout and reads four bytes past the declared
payload. It also publishes the translated child through the request's
frag_list.

A multicast clone of the request shares skb_shared_info and can observe
that child. xfrm_user_rcv_msg() frees it after the request handler
returns, racing a compat receiver which may still be copying from it and
resulting in a use-after-free.

Remove the redundant conversion. The response keeps its correct compat
translation from dump_one_state(), and no child is attached to the
inbound request.

Fixes: 5f3eea6b7e8f ("xfrm/compat: Attach xfrm dumps to 64=>32 bit translator")
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 980dbeb5a57d..a2587c7e796b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1877,7 +1877,6 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
 	struct xfrm_userspi_info *p;
-	struct xfrm_translator *xtr;
 	struct sk_buff *resp_skb;
 	xfrm_address_t *daddr;
 	int family;
@@ -1943,17 +1942,6 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
-	xtr = xfrm_get_translator();
-	if (xtr) {
-		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
-
-		xfrm_put_translator(xtr);
-		if (err) {
-			kfree_skb(resp_skb);
-			goto out;
-		}
-	}
-
 	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 
 out:
-- 
2.43.0

