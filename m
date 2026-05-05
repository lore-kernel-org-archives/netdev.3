Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3874218A6
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987425; cv=none; b=DEWUoPvr4Yu1aAQWbkGNyp5FzrfYCa9M/FixkQ5DZy2s2S47P9iT30pgc/vgoKotAxKFi/8UdyJCY7FF9JGjDm9xhqg02SInDnZ6KXtyH/aaBeZEQlBTT71X1m/XC8ollnQ/vjpXyMHJHwsiV3rXy4ecfnrY/E4+jO/3ZzkZwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987425; c=relaxed/simple;
	bh=eSmL81SKr3T1B3gj/s8EhVodS2r87gUUwNvxEN494Iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PREsHv3nDB4i93O2nU0rfpNUCLVezdCQObxjjOOdlpgNx7IGknNwVJlKRkWAV1INq19knVqBghP8l580C9+iQGyzrDygY11PNNZlGXpTWBAn2sLzeuDHHGtt6OaDPaVn5WVidUKujlKSdB5QjyZo3WIeOVJiTvr0zAUU7wZWdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dYjteNy8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dYjteNy8"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5150820748;
	Tue,  5 May 2026 15:23:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l8uM6Nc0WGeO; Tue,  5 May 2026 15:23:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 295A4201CC;
	Tue,  5 May 2026 15:23:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 295A4201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987417;
	bh=lQo6bduM/S+XvcAgQte25csJl6+etYdvKi+QcuKar5U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=dYjteNy8A7uLylrknc4+NuwPFQSeXJBQy4EgS8zjTGN7s6KRJIrxQFkumgDHw+cki
	 SjvEQz+AySwm9wngADeNoAtL+p/8F+p6Y+d0T6LjTHNsMh7GOsifORE6Srlt8iMPn3
	 asDSsED5H1IBDVgGOh1G/rfzUiCoke7z4NdWP4HfR3BrTZNUbs4faxtf53DMi8c1e0
	 l+rc4TC+E+vTWLxt5kR0Iw4fls7/ztkrIAQrBiF7Rvkq2yhsERPZMfu5e6wlWltOkA
	 NE9OTvwywzfKJ2UHJEXQPRXIZMA6CMs26NYUDq+bbCTG8J8XLG7N3AW31IZYd9qTS1
	 htRToPMGwXNCQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:36 +0200
Received: (nullmailer pid 1364080 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/8] ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()
Date: Tue, 5 May 2026 15:22:57 +0200
Message-ID: <20260505132326.1362733-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
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

From: Yilin Zhu <zylzyl2333@gmail.com>

xfrm6_rcv_encap() performs an IPv6 route lookup when the skb does not
already have a dst attached. ip6_route_input_lookup() returns a
referenced dst entry even when the lookup resolves to an error route.

If dst->error is set, xfrm6_rcv_encap() drops the skb without attaching
the dst to the skb and without releasing the reference returned by the
lookup. Repeated packets hitting this path therefore leak dst entries.

Release the dst before jumping to the drop path.

Fixes: 0146dca70b87 ("xfrm: add support for UDPv6 encapsulation of ESP")
Cc: stable@kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/xfrm6_protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
index ea2f805d3b01..9b586fcec485 100644
--- a/net/ipv6/xfrm6_protocol.c
+++ b/net/ipv6/xfrm6_protocol.c
@@ -88,8 +88,10 @@ int xfrm6_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 
 		dst = ip6_route_input_lookup(dev_net(skb->dev), skb->dev, &fl6,
 					     skb, flags);
-		if (dst->error)
+		if (dst->error) {
+			dst_release(dst);
 			goto drop;
+		}
 		skb_dst_set(skb, dst);
 	}
 
-- 
2.43.0

