Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71E3A9D84
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307847; cv=none; b=q9RvIEP8Y8223WeC5iqsg7/piydBywPhiy/dJsIvRQA76nIx4QgYj45xLSbtFa+pptov+H0KhASnj5MuDSFz4vpHVBwGX9M8reJKlXUm//tX7d8ZM2VH74RIjsVB4Hyw/NRDksH6YNfN/tprZBVUipDfznOjm45FRuUK8mT2C28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307847; c=relaxed/simple;
	bh=/TmlojUohDq5LyS4qMhGqwwbLrp00jfD05SvP6hZn24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/4jHiKZjHLXAqcYrqZXG34H5nq9pTYWWWLlFOTeX70E//o1BZ53BCU5Lrb0zUVUNOKsUPn2JcO7U3hdFJvN1SCmwDYIouspeoPLCj4vs0cGvx3i0TX8YFOfdtBigE86PzHuHiItPv4RSrjIISRmKpKZg2tfwI5jnLhKUbvNa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bFemgDJS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bFemgDJS"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 02D1C207A4;
	Wed, 29 Jul 2026 08:50:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xCU17rIp6jJ3; Wed, 29 Jul 2026 08:50:42 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CA4E120754;
	Wed, 29 Jul 2026 08:50:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CA4E120754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785307842;
	bh=Kr8ndA8C/ahkMTNLvfxHgIr0ZJx2LbThihLWTD2EuKQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=bFemgDJSq8SulOTiC63ZGJ0o3PwOQS50k7z26Jl4+8hTuRbZ3osyZmx6Euij5trDK
	 ffse+Tt6TA8zL3m6LwLwpPQEDOr88r2ZtO2BDYpg84Iiz/1CRFTFkutKxsxxOH1948
	 mIGfUzczq1BvnOHOoSdG2GItuxGoNnVDLWh3+49mQ7G61paN8ygrpucTx4NEhTCw3d
	 pSZtTeYYqwOOwJUJJ3Gy2DUmbdZxY9xMH+SJCcSs8aG95GZ1IbHAForVGt323Oj+sT
	 +hraEoosh8iuWQfJLjggrrV3C448pBVJRY+ozLWHMfvTmW6oQSP2hAGcicNvKVP+3C
	 G35+l+6yN2DKg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:50:42 +0200
Received: (nullmailer pid 1592295 invoked by uid 1000);
	Wed, 29 Jul 2026 06:50:38 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 7/8] xfrm: ah6: validate routing header segments_left
Date: Wed, 29 Jul 2026 08:50:17 +0200
Message-ID: <20260729065035.1591985-8-steffen.klassert@secunet.com>
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

From: Asim Viladi Oglu Manizada <manizada@pm.me>

AH6 rearranges routing-header addresses before computing or verifying the
ICV. ipv6_rearrange_rthdr() assumes that segments_left is not larger than
the number of addresses described by the routing header's hdrlen field.

That assumption does not hold for raw IPv6 HDRINCL packets. A packet with
hdrlen equal to 2 describes one address, but can carry an arbitrary
segments_left value. With segments_left equal to 255, the function moves
its address pointer 4,064 bytes backwards and passes a 4,064-byte length to
memmove(), resulting in an out-of-bounds access.

Validate the invariant locally before modifying the routing header or
performing any address-pointer arithmetic, and propagate malformed-header
errors to the existing AH6 input and output error paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/ah6.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 76f7a2de9108..c96f7e0d0a48 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -232,26 +232,28 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *des
  *	Rearrange the destination address in @iph and the addresses in @rthdr
  *	so that they appear in the order they will at the final destination.
  *	See Appendix A2 of RFC 2402 for details.
+ *
+ * Return: 0 on success, -EINVAL if segments_left exceeds the number of
+ * addresses described by hdrlen.
  */
-static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
+static int ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 {
-	int segments, segments_left;
+	unsigned int segments, segments_left;
 	struct in6_addr *addrs;
 	struct in6_addr final_addr;
 
 	segments_left = rthdr->segments_left;
 	if (segments_left == 0)
-		return;
-	rthdr->segments_left = 0;
+		return 0;
 
-	/* The value of rthdr->hdrlen has been verified either by the system
-	 * call if it is locally generated, or by ipv6_rthdr_rcv() for incoming
-	 * packets.  So we can assume that it is even and that segments is
-	 * greater than or equal to segments_left.
-	 *
-	 * For the same reason we can assume that this option is of type 0.
+	/* Raw locally generated packets can reach AH6 without the invariant
+	 * required by the rt0-style address rearrangement below.
 	 */
 	segments = rthdr->hdrlen >> 1;
+	if (segments_left > segments)
+		return -EINVAL;
+
+	rthdr->segments_left = 0;
 
 	addrs = ((struct rt0_hdr *)rthdr)->addr;
 	final_addr = addrs[segments - 1];
@@ -261,6 +263,8 @@ static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 
 	addrs[0] = iph->daddr;
 	iph->daddr = final_addr;
+
+	return 0;
 }
 
 static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
@@ -273,6 +277,7 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 	} exthdr = { .iph = iph };
 	char *end = exthdr.raw + len;
 	int nexthdr = iph->nexthdr;
+	int err;
 
 	exthdr.iph++;
 
@@ -292,7 +297,9 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 			break;
 
 		case NEXTHDR_ROUTING:
-			ipv6_rearrange_rthdr(iph, exthdr.rth);
+			err = ipv6_rearrange_rthdr(iph, exthdr.rth);
+			if (err)
+				return err;
 			break;
 
 		default:
-- 
2.43.0

