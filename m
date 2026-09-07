Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9B390CBF
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773445; cv=none; b=SlemPU2vi5iG8KxGf0Q2tqH1JgNUSy7xPekHdcyTIFMnrIecwfQhSz3/AoJ7FpMRzeLX6LW3BSghC7D5sqb4j+2N2UwSsEzn5rYuOkUvEhACNXZisesc8gRk/pY4uRomQi63l6QhCq2yjWudhoWKXbzua9ZK5oTwh3jS90/SYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773445; c=relaxed/simple;
	bh=3hp0FBrnhVMF5X33oOh1NnG5lfTYak0LO2j0mavx52A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFOydIk/FgpFHWSW0QHnCAnBTbCO1ixJswh8o508+8EJAsAextH2teSsK5n7bc0PAA/FB242dzKWelsoB9gWTxQ6LiFjMKe6bGo1LRkpNuIx3UkG9cNs7pFGT2JnNwV30937eXtMzEkHzeiO5gnIq3UzvchTb+SlgBVjNCojJ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aW3I79dQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aW3I79dQ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B2AB3204D9;
	Mon,  7 Sep 2026 11:30:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30W5TZbfM-4v; Mon,  7 Sep 2026 11:30:40 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8B3DD201D5;
	Mon,  7 Sep 2026 11:30:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8B3DD201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788773440;
	bh=SmJRrVwI72EQp8w/acK38qPlWNagiyasILLEbtXDKY8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=aW3I79dQmFvIm59SgsH1pP1o0HhqXsyssCPEw6+d8BJ5q2rErHDWOG0leMQ/Ipn6Q
	 Nndfa516cNZw02fXD0HfC/S1oMo1/7P14fZ47s5ri4uLwTKzSeuoLdA/9UVlxWWY2f
	 FAO7nO914/apufvtUuNHCpXSs077h40QpT2eAuxXq6GdAko1EcdImxx3t7kCpkodUt
	 /VJkuu31iFfYhqgTzCIA38HmPLRTl9ixf+YpqS++taBXJ0H+rI58ujuJLNKfrhVmRO
	 Ee+oMVPurB236RIOFQysMZGDK4lrvMXSiLht3eWJP8+Fh187RHTc1bwVaBLEHFVQB4
	 xeXxtj8KJtR3Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 7 Sep
 2026 11:30:39 +0200
Received: (nullmailer pid 2228814 invoked by uid 1000);
	Mon, 07 Sep 2026 09:30:24 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 05/12] ipv6: xfrm: use full sockets in local error paths
Date: Mon, 7 Sep 2026 11:29:48 +0200
Message-ID: <20260907093020.2228346-6-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Zhiling Zou <zhilinz@nebusec.ai>

xfrm6_local_rxpmtu() and xfrm6_local_error() dereference skb->sk as if it
always pointed at a full IPv6 socket.

That is not guaranteed. TCP SYN-ACK skbs can be owned by a
TCP_NEW_SYN_RECV request_sock while the output path itself is driven by the
full listener. If rerouting selects an IPv6 XFRM tunnel route with a lower
MTU, the local PMTU/error handling path can reach these callbacks with that
mini-socket still attached to the skb.

The callbacks then miscast the request socket as a full inet/IPv6 socket and
can read beyond the request_sock allocation when they access inet_sock or
ipv6_pinfo state.

Resolve the owner with skb_to_full_sk() in both callbacks and bail out when
no full socket is attached. This matches the surrounding XFRM IPv6 PMTU/error
logic, which already reasons about full sockets with skb_to_full_sk().

Fixes: dd767856a36e ("xfrm6: Don't call icmpv6_send on local error")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/xfrm6_output.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 512bdaf13699..44b221a09a0c 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -19,7 +19,10 @@
 void xfrm6_local_rxpmtu(struct sk_buff *skb, u32 mtu)
 {
 	struct flowi6 fl6;
-	struct sock *sk = skb->sk;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	fl6.flowi6_oif = sk->sk_bound_dev_if;
 	fl6.daddr = ipv6_hdr(skb)->daddr;
@@ -31,7 +34,10 @@ void xfrm6_local_error(struct sk_buff *skb, u32 mtu)
 {
 	struct flowi6 fl6;
 	const struct ipv6hdr *hdr;
-	struct sock *sk = skb->sk;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	hdr = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
 	fl6.fl6_dport = inet_sk(sk)->inet_dport;
-- 
2.43.0

