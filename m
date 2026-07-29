Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E638888F
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307845; cv=none; b=Bd+e3vI9rFQ/TIMYLY7GrtQrsLY+S+Y3gv6vaTPsvQqRuoaUfz4zcql9Mljk6Ec3Ug265ERoAV2I+4iP0tnTSV8JuSaMVp6tbAJMH6HUZX5WQsxE1SSK1lTDE8Uvr423ohtA+DDJqKzR/22/iEEadv2aw/OPhnb6uU+nhXhMBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307845; c=relaxed/simple;
	bh=VboB/skj3Po2rvrIt6xR4L2Ill5QvazVLp+EdOMOX+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CH08Nwkne6LZ45/12H80EdtGTEJ9VcXtFsgYBg/aoJKfJmoptrQkhgIF7Iq28aL/EyFYdFNuwqF2ccz7FozlcnMZLN6tbZvxquHuXluuHsnUiANvfyyfNUccNsbvgL1cltGPgP7aDKp4IgZFdAQfY7q4YHbOjFxbjxpRhfwrNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=d8HYnASk; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="d8HYnASk"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E40D320758;
	Wed, 29 Jul 2026 08:50:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCsH_fcNSxhh; Wed, 29 Jul 2026 08:50:41 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6427120754;
	Wed, 29 Jul 2026 08:50:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6427120754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307841;
	bh=PPlJD3ZQ6aTf8CVEhyHiMPR0XgTD4n1QxA3GbptmxI0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=d8HYnASkZCmuxSNwob2aGjljJhB8DbOfV9qSZvQeGDZgPNZqAs9ohOpGHm+VhmRak
	 3FJlnrN1gyAz2j5BtLLey05uIdVaziyV2qVwnCoiKApSQnjvpzJ9izum0nEW0DqhGe
	 j6Y/fijSGD2Duo4fkaMTsYYVrHeHZa+HO/OPSWalx0DGtt2DaPQAvheWm37DZ0un+g
	 vAaFD9rTeHtmjZ3cOlnejcwRaYRuE2ZdV2WFHsWfkpOn1d9715E/UR+oOc4XJ4cyw3
	 SkBdB4aOZqzlmBBlte9bsvdq0mbF6Cqd4y/v4Lb/t8yWIWSDiBU3Ua6vWHepYahBpJ
	 Ue5vi5qNxI6Wg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:40 +0200
Received: (nullmailer pid 1592292 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 6/8] xfrm: Fix skb double-free in xfrm_dev_direct_output()
Date: Wed, 29 Jul 2026 08:50:16 +0200
Message-ID: <20260729065035.1591985-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729065035.1591985-1-steffen.klassert@secunet.com>
References: <20260729065035.1591985-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

From: Sanghyun Park <sanghyun.park.cnu@gmail.com>

A return value other than 1 from local_out() means that the skb has been
consumed or its ownership was transferred. xfrm_dev_direct_output()
nevertheless frees the skb on this path, causing a double-free when
netfilter drops the packet and invalidating any other owner.

Return the local_out() result directly, matching the ownership handling
in xfrm_output_resume().

Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index cc35c2fcbbe0..e305ba32e356 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -636,10 +636,8 @@ static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
 	nf_reset_ct(skb);
 
 	err = skb_dst(skb)->ops->local_out(net, sk, skb);
-	if (unlikely(err != 1)) {
-		kfree_skb(skb);
+	if (unlikely(err != 1))
 		return err;
-	}
 
 	/* In transport mode, network destination is
 	 * directly reachable, while in tunnel mode,
-- 
2.43.0

