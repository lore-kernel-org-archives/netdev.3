Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212600;
	b=P6jaEUCxm2ev4XhfXtD35RJhW4O6PHNiuisgBjr/NJrY9U9ThMZYoP0RjJddh6gFmxhh
	 4mlvqv2uVscw4PPYHzF0dIZTrNFeyO6tTIr71v+PfoM6lULxNcdYX8/MwDHF051zT7JU6
	 CIoyxMIuxgflKduyglwzJN6TV2Oe4ERkQOnThP9TBMclTO2yF3/jP20uQDAnFLuMmWIos
	 sLSSSgFdOQc90lETzG41wG+eRC+Law+AVlufoFL2gi+4lgEIzodClTJm4FSybOuBt8yZv
	 Ka3r4YNazzPaEf7/VyHTxf+gYi1ahHiKrJaHYhcrHSubB4SJiS3j+9dw0MDl2zNAKVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212600;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-ClientProxiedBy;
	bh=tlAM999AN2z4WmQSaz7KboMJcz00mR5dVBM7MGj61rM=;
	b=wlX/yP4bOfAo/d+c65LTTTUyiBpBCQR7S7t+kmMLgNv2jlANhIJi4uHE6+D+VKKsfYKD
	 uc0deYxCqNY/IqqoxTn8zb/SXyp4cPOdniCDm3dvZAAjO0Yozy25ys7HNQMn5hVsntSN2
	 9zE1DGc2heRz254SEEaGw7l6D2HQ6qI06PSoY5ZxrGL4OJEYCwmUr/sm5BWJbatpVwk2N
	 RqYsfe3xmX7umYbr5AkwtfvFnUk5cyRwxMzxyENvgA/U4+Ci52B7j2ogPLKAgYalkvn5X
	 Vjjy/vZMkUW6/OIjBz3w9WIQ0S5k54VU+CUbWswr3NydLeGKX0bB6s4u3yLe6YNcQ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=HA8E34+7;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAFA606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 08:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CAFA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=HA8E34+7
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 438B0201CC;
	Mon,  9 Nov 2026 09:23:10 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qAp99e0zu_q7; Mon,  9 Nov 2026 09:23:09 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 020C62067F;
	Mon,  9 Nov 2026 09:23:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 020C62067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1794212589;
	bh=tlAM999AN2z4WmQSaz7KboMJcz00mR5dVBM7MGj61rM=;
	h=Date:From:To:CC:Subject:From;
	b=HA8E34+7bq1yS5Xx1l3aOA0lDcEYeuc6tr/+5Sx0iiSuz447ASuozXQVccLmGnimI
	 RHaz8oy5FWVuz4dX3HMv78hiDnp0LHo6HGqNXjWrQupXV9KnM09CbygXFyj1PMntjJ
	 6/GrU2TV1VVZ9ztDpB+FZ3VkJsMX6TMuB00otiDnLR9uhO4rd/b3trl1+CyZbBfqVk
	 dzCBkPi9tf62IifrsRjLa4GgMZ/v2lCq5MyQ2W+QX4aISELbs3+306tQhaDmN38f9N
	 0CeVkASO6PKkMkSMVrpT3DvGfUFcGOuIitMrQQbTdtokSc1BSSl8Km91k91gJW+fQi
	 8GMxz4Mw5rrsQ==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 9 Nov
 2026 09:23:08 +0100
Received: (nullmailer pid 2426709 invoked by uid 1000);
	Mon, 09 Nov 2026 08:23:08 -0000
Date: Mon, 9 Nov 2026 09:23:08 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net] MAINTAINERS: Add the new IPsec list and patchwork
 instance
Message-ID: <avGC7CrPVgMrBBtq@gauss4>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

We now have a dedicated mailing list and patchwork instance for
IPsec. Patches for the ipsec and ipsec-next tree should be
submitted to netdev@vger.kernel.org and ipsec@lists.linux.dev,
so that the new IPsec patchwork instance can track it.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---

I targeted the patch to net so that the new workflow gets
implemented faster. But if there are concerns to apply it
to net, it can also go to net-next.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09713dc4c6a7..36767254c33c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19506,7 +19506,9 @@ M:	Steffen Klassert <steffen.klassert@secunet.com>
 M:	Herbert Xu <herbert@gondor.apana.org.au>
 M:	"David S. Miller" <davem@davemloft.net>
 L:	netdev@vger.kernel.org
+L:	ipsec@lists.linux.dev
 S:	Maintained
+Q:	https://patchwork.kernel.org/project/ipsec/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
 F:	Documentation/networking/xfrm/
-- 
2.53.0

