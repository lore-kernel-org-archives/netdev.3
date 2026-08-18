Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DE4499B6
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045381; cv=none; b=pzD4iF1DpTENoUn4HhjQpF2R8yEF71qOHyqi4Mox9bMv+sgAZ2Fzjg819GuYvNmiPhdROMqOvqqkMjPqK/SvGKrNrBVh3uzEgLtdzHEFsu3wB1GkPqF+TybYGclRKOOGA54O5pYbztZphBU14t22EQ8+0n4FdCVpLbZOSEKriIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045381; c=relaxed/simple;
	bh=1felUV2LqGZTFN6/JXINzuSNp1uJPheuiPFjfp66CJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fILRoZiMq1BTv9upsRGb/Z3kWLgefHcEia3uGoYaczP/Z14tL8d8z2mt7bfRNcZ1lvRlC7PhkZ5f0IrpkstsYq3StRvPtx15+p6el6ipmZlDxdaoHot5idZPXnQFxv3ErLP7gq1Itc+gW6P0oFujh7gyVdk/NV1QdwRaTVsMoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zlZheHQP; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zlZheHQP"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EE16E207A4;
	Tue, 18 Aug 2026 11:29:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Z-oCqzBnfWo; Tue, 18 Aug 2026 11:29:38 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5F5D0201D3;
	Tue, 18 Aug 2026 11:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5F5D0201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1787045378;
	bh=nFfuZTFMHhq16QxmdPzmv7TEBpXq9zR4WQaxGtFxBwY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=zlZheHQPXZN9K7fXns3GAwQdQaPS/VMnlgJvb0et/sKHX7gUDA7drvJ7puKoulGOB
	 uYJ9ehxXMl8uQFM1eSLz3l6EUFq5jiHUNKf9DNuiBPeMXqelrZwQTixIOAH0Dtfu+N
	 8sR0B3Z3WL5hJ8QwvYps3Po0GZxVLOzX9w61UZxQZUx2nfGmdrOpliQK6wjLj4rEIg
	 eND2dWQk+7NWX31KFF4DnwNcQMfPt7damEuxg/YyyJP/E9tbYXZpQv43BlzPuli7oB
	 cF036OAZpyn/WXwTcttyvM3462VFcMRwsu/JevaC3Ll5nnKurmPag3iSsqSDihc3bC
	 A4HjdRHEHyMhg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 18 Aug
 2026 11:29:36 +0200
Received: (nullmailer pid 657506 invoked by uid 1000);
	Tue, 18 Aug 2026 09:29:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/10] Revert "esp: do not unref managed frag pages in esp_ssg_unref()"
Date: Tue, 18 Aug 2026 11:28:40 +0200
Message-ID: <20260818092920.653034-10-steffen.klassert@secunet.com>
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
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

This reverts commit 21697720ff43b8dfa25b8e8d9ca7f56f4597fc80.

The patch does not fix the issue completely, so revert for
now and wait for an updated version.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv4/esp4.c | 7 -------
 net/ipv6/esp6.c | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index fa1710e27e50..dfc81ee969ae 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -104,13 +104,6 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	struct aead_request *req;
 	struct scatterlist *sg;
 
-	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
-	 * per-frag page reference, so we must not drop one here.  Mirrors
-	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
-	 */
-	if (skb_zcopy_managed(skb))
-		return;
-
 	if (x->props.flags & XFRM_STATE_ESN)
 		extralen += sizeof(struct esp_output_extra);
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7d216b9c59f0..296b57926abb 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -121,13 +121,6 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	struct aead_request *req;
 	struct scatterlist *sg;
 
-	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
-	 * per-frag page reference, so we must not drop one here.  Mirrors
-	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
-	 */
-	if (skb_zcopy_managed(skb))
-		return;
-
 	if (x->props.flags & XFRM_STATE_ESN)
 		extralen += sizeof(struct esp_output_extra);
 
-- 
2.43.0

