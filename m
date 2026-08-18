Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2D44780A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045379; cv=none; b=JMXMLPdntPkG+b8dBwacwfjNN5tOOsHOLOCmS1lSJWxN8DqSPutTXra7VuAltrj5oRHuXWQgFIll68Opf53+37JMR0aIJykrFHcG9A3/qh/1xPL9rNh2+mA+Z3t1Uvr6LMuPnajQnP9bytT0plF+CmBq58USXTtYPx3d5UKazVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045379; c=relaxed/simple;
	bh=VboB/skj3Po2rvrIt6xR4L2Ill5QvazVLp+EdOMOX+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tzy4jJysoMq5JcKpBqhr1ScLC/kBaAYBO1av/Bh0TfuCMD2zMH2Wxt2DZ3u0Ch1rs/dqWmey0EL8+CYgUz5lcVgKaRRp/zUKYlxewND5Wp35zePhtJ7bsa3q6Z1MsucoEHtbAi1P5G2WD33/Zrs/O4t9l/5RNPfT4CIkF1PzS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=aqLvQTa8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="aqLvQTa8"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5733520748;
	Tue, 18 Aug 2026 11:29:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NEXELGx7CaY9; Tue, 18 Aug 2026 11:29:35 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C067F201D3;
	Tue, 18 Aug 2026 11:29:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C067F201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045375;
	bh=PPlJD3ZQ6aTf8CVEhyHiMPR0XgTD4n1QxA3GbptmxI0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=aqLvQTa8hXtgQjaqkk5HSfJoKk4Us5gIOCZymoTtA7OyVhGCYq4V/vp9+9UKiiK35
	 KRjYk8muF2cevSqaXR2FXvTuYy6nDutUrWZTdfTS2NWsrzfhXx+ZOwVnLvz0WzITaj
	 +rnJ9tq2byKWMxlFTHuNWkMrFBpw4JI/K0hFF+l81Crkw2oIIUN5ExN9oGYpBuROKG
	 2c0OMGTvETopGb6nTQ6EOs8G72iMnbusViIfHRYAF72Aawi3jjHhET+MVSJQagcLyv
	 PN4AcErrnXywcZaB3WzoaRvrUjvf4ruJYoDPaUFWzplSBo7wVEN9ImtN9deYQvr6NO
	 NzIIzyTxoyyBg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:33 +0200
Received: (nullmailer pid 657497 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/10] xfrm: Fix skb double-free in xfrm_dev_direct_output()
Date: Tue, 18 Aug 2026 11:28:37 +0200
Message-ID: <20260818092920.653034-7-steffen.klassert@secunet.com>
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

