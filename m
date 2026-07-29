Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438D3AE70A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307848; cv=none; b=fBgmamcPJ1fIq8eLRNzZ97hR18aadKSWgqAIF9LSLbvLE/8N3dPgH4aFxcFEuO1VumEOuQNmb+XDK4OvkbSfwCA3yX1Jq339KMB5S+aiCZ3tUPEGqDympTtQWmqMnaqx65/PAetQoHag4UJo8ZMlkH5yo17BL+HSRx1fwvYwWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307848; c=relaxed/simple;
	bh=01nOx0xvY6vc7bFk8zkPSJod+TeG/Pxz4vjAvIM9xdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cicWzGolNQ532hIlRZae8ZEiVr4tMLy1xXSApJGXb27151okQ9PJ97qp8FXO9WPxpDPQ+Se3WhBY1c32NXX18ahLwmgTo7tMIQ4FIFZe83Pr4OgiSeaWfZj/JMGirtW2ojoTxT5Udn8U6J95NHZWqQd2kueCC0qDRwcemo5o0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eVnWVE1F; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eVnWVE1F"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F318A207B2;
	Wed, 29 Jul 2026 08:50:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IzYFxTglOzcK; Wed, 29 Jul 2026 08:50:44 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5620520754;
	Wed, 29 Jul 2026 08:50:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5620520754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307844;
	bh=qrDHEbxeUCyR/wyxtOGGyEClj/JfE7w1U1DZb3p+pec=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=eVnWVE1F7koWKxXFaaIMF7cqunWrvfSCTL3+1tzZwWPP1VnRMNLbi32D6/zE4NdCB
	 DpveDF/aehZ75cgQM0mZqRmHrR2WVpaV6r5759fYqEiGeWrthXTv8Y/TICbCDs3s38
	 tryPXI+xmKEGrg2dDu813UfL73pVjHdQGjTyxTzwA3wyQitbGuhb3aNphBgqm0ICov
	 lEnGtA9IcCeKU21qFtcPYVUzEhlNF6gbFeL0Amo/iTXbX6UTQ1ed+Yiry0/P7DEY/J
	 AGOKUfD9puB7XRKPnJZH6hOPIFT0cJF3w8HY+nOByPhNk3a6OsgdlnfFmLbE2qgzce
	 Ajw5kIFJq7s+A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:43 +0200
Received: (nullmailer pid 1592280 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/8] esp: do not unref managed frag pages in esp_ssg_unref()
Date: Wed, 29 Jul 2026 08:50:12 +0200
Message-ID: <20260729065035.1591985-3-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

From: Maher Azzouzi <maherazz04@gmail.com>

esp_ssg_unref() releases the page references held on the source
scatterlist after the AEAD operation completes.  It calls
skb_page_unref() on every frag page for an out-of-place transform
(req->src != req->dst), and in the error path of esp_output_tail()
(already_unref == true) on the request's own scatterlist.

This is wrong when the skb carries managed frags
(SKBFL_MANAGED_FRAG_REFS).  Managed frags are owned by a zerocopy ubuf
and the skb does not hold a per-frag page reference; io_uring SEND_ZC
with a registered buffer attaches the bvec pages this way via
io_sg_from_iter().  The rest of the stack honours this invariant:
skb_release_data() skips the per-frag unref when SKBFL_MANAGED_FRAG_REFS
is set, and skb_zcopy_managed() is the guard used at the other unref
sites.

esp_ssg_unref() is missing that guard, so for a managed-frag skb it
drops a page reference the skb never acquired.  This can underflow the
page reference count and free a page that is still in use.

Guard the function with skb_zcopy_managed() so both unref paths are
skipped for managed-frag skbs, matching skb_release_data().

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 7 +++++++
 net/ipv6/esp6.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index dfc81ee969ae..fa1710e27e50 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -104,6 +104,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	struct aead_request *req;
 	struct scatterlist *sg;
 
+	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
+	 * per-frag page reference, so we must not drop one here.  Mirrors
+	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
+	 */
+	if (skb_zcopy_managed(skb))
+		return;
+
 	if (x->props.flags & XFRM_STATE_ESN)
 		extralen += sizeof(struct esp_output_extra);
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 296b57926abb..7d216b9c59f0 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -121,6 +121,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	struct aead_request *req;
 	struct scatterlist *sg;
 
+	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
+	 * per-frag page reference, so we must not drop one here.  Mirrors
+	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
+	 */
+	if (skb_zcopy_managed(skb))
+		return;
+
 	if (x->props.flags & XFRM_STATE_ESN)
 		extralen += sizeof(struct esp_output_extra);
 
-- 
2.43.0

