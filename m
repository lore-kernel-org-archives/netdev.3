Received: from outbound.ci.icloud.com (ci-2001b-snip4-1.eps.apple.com [57.103.91.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622894C77BA
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715899; cv=none; b=jcdwJ0LFK4uP80yVCQa2hK2t6RjydO/FeAHXaCYETx07Et+Z6H57CWa4Oh3vlBNAJ/tBiUAhNJsC7GuQDplncZhrvDkYXEDHLUNLpRX+pK/8Bp570fanlJjsrg3nH+/LEEJSri/kSm7lwgXVHZhtmwkdgmtrvjBAga6op9l8ZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715899; c=relaxed/simple;
	bh=3sPsVxDDwcmchVigTZ4/kEzLeFAvhaaf+wWSJh8iHQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im4WS9lgfitzNu3eWAKqcpFty121SznkRIAeO0Ic61OYFKNXK+4VkA9x7gCOHtFA/ZCA59e2qqh0EhL+9Z5/Rab8vDJl8oxmbFTMr8PrtSOETf+vKVg6j78YTIY+EQryv4brS8A5LQYFkvWbuLc5fv90P7iNlwTDCGlVt1+pMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thehaxbys.co.uk; spf=pass smtp.mailfrom=thehaxbys.co.uk; dkim=pass (2048-bit key) header.d=thehaxbys.co.uk header.i=@thehaxbys.co.uk header.b=p2O3y1ql; arc=none smtp.client-ip=57.103.91.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thehaxbys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thehaxbys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thehaxbys.co.uk header.i=@thehaxbys.co.uk header.b="p2O3y1ql"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id 7250D18002B0;
	Wed, 22 Jul 2026 10:24:53 +0000 (UTC)
X-ICL-RepId: 019f895b-5a78-70e2-b906-14da267ed183
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQtJBEMGXgdeAFYCWgBLVxQEElAFdx9aFVEZSw9OGBwTVlZGBhcNVk1NEFYFVhNQCUpWUAIZHllQSxsOWRcDVxxWRVwYQwldBVccHQ5eRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUEMDVxhYAFEUREVRHxcNWE1aAlZNBUoDXwFbBUILSQNfA18DXgFPBV8aWR8aWhBzGV8OWhFBGkoeGQhdXkwTDU1DEkIVBBtGHkMEXy9dF14MXgU=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thehaxbys.co.uk; s=sig1; t=1784715895; x=1787307895; bh=8gbN00omLuFoqSqpFRA+32tb3Eth1TkeYwOTlWHvywI=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=p2O3y1ql3077MUSqf9pQ45G+mQkR9A0MbzyGNCq2xBQq/AtlsFi1JwdIMF59Mtqvl4X/HMVLsh3FWmelhAYzbuIuzjxtiyJCf1jOCDVzorFwnJPtoJer4jOSq0vdPJnZXroLfuu7U+OKnA7gBaYOjaTKsDfky9Cf0u8pVlaQAUkqftIklWML+8B5U1ZqADfTxjP5n738Hhc4KbUKjcBSDoPRdEzxeH+0EUgNN0g6Gnu3voOU7eXOcBGuq1XwcLKnKHlNTnxTjD/k0TCoNX71DlEEmg0SbFFBea9lLO/0UWzKcVcitKjuJ1ehjxhq4wn4t9kPPksD2TQ2ZYLZJc8ucw==
mail-alias-created-date: 1318449231000
Received: from localhost (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id 7B39618002AE;
	Wed, 22 Jul 2026 10:24:52 +0000 (UTC)
From: jch@thehaxbys.co.uk
To: dsahern@kernel.org,
	idosch@nvidia.com
Cc: netdev@vger.kernel.org,
	John Haxby <jch@thehaxbys.co.uk>
Subject: [PATCH 1/1] net/ipv4: discard icmp timestamp requests
Date: Wed, 22 Jul 2026 11:24:41 +0100
Message-ID: <20260722102441.8762-2-jch@thehaxbys.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722102441.8762-1-jch@thehaxbys.co.uk>
References: <20260722102441.8762-1-jch@thehaxbys.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yE6leNymWf1WlVLnWovazkl838omj3qR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwMCBTYWx0ZWRfX5s3Fb6hfXKmN
 N43bjxvzPavXkhdZLuD8ydAm+odQLlFnT1R20D+Q7AmVyybVAgiwR9wGz1DITcZ0FF0U6ZU4OKK
 g0/kgriUXADIBkc+gn+GIPQwU/VfpVyWTqCae10MMcDwAknLKjj3t9GQObYyJUC8BVMTAEhW0cz
 mHVLepm+tMYLoUla08YyMbT4XZf4OOst5KYCAPe221/UhJSYWmgzLS03rVi/5/w59DNHKGmLFEW
 USY+tzrsuvYaw1/Br1D4WVARfuwvIntf9u7SE4wMxpeI87q2SIOoZNyShvuEyaEdZmTYkv2/A5e
 jkaU9aro2X/RhYOjGmS
X-Proofpoint-ORIG-GUID: yE6leNymWf1WlVLnWovazkl838omj3qR

An icmp timestamp request is classed a a minor security vulnerability
(CVE-1999-0524) due to an information leak.  As pretty much everything
uses NTP these days, it's not as though this is an actual problem but
scanners flag this so for everyone's sake, let's just discard timestamp
requests.

Signed-off-by: John Haxby <jch@thehaxbys.co.uk>
---
 net/ipv4/icmp.c | 42 +-----------------------------------------
 1 file changed, 1 insertion(+), 41 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b3..ec0443424110 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1383,46 +1383,6 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	return true;
 }
 
-/*
- *	Handle ICMP Timestamp requests.
- *	RFC 1122: 3.2.2.8 MAY implement ICMP timestamp requests.
- *		  SHOULD be in the kernel for minimum random latency.
- *		  MUST be accurate to a few minutes.
- *		  MUST be updated at least at 15Hz.
- */
-static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
-{
-	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
-			IP_OPTIONS_DATA_FIXED_SIZE);
-	/*
-	 *	Too short.
-	 */
-	if (skb->len < 4)
-		goto out_err;
-
-	/*
-	 *	Fill in the current time as ms since midnight UT:
-	 */
-	icmp_param->data.times[1] = inet_current_timestamp();
-	icmp_param->data.times[2] = icmp_param->data.times[1];
-
-	BUG_ON(skb_copy_bits(skb, 0, &icmp_param->data.times[0], 4));
-
-	icmp_param->data.icmph	   = *icmp_hdr(skb);
-	icmp_param->data.icmph.type = ICMP_TIMESTAMPREPLY;
-	icmp_param->data.icmph.code = 0;
-	icmp_param->skb		   = skb;
-	icmp_param->offset	   = 0;
-	icmp_param->data_len	   = 0;
-	icmp_param->head_len	   = sizeof(struct icmphdr) + 12;
-	icmp_reply(icmp_param, skb);
-	return SKB_NOT_DROPPED_YET;
-
-out_err:
-	__ICMP_INC_STATS(skb_dst_dev_net_rcu(skb), ICMP_MIB_INERRORS);
-	return SKB_DROP_REASON_PKT_TOO_SMALL;
-}
-
 static enum skb_drop_reason icmp_discard(struct sk_buff *skb)
 {
 	/* pretend it was a success */
@@ -1685,7 +1645,7 @@ static const struct icmp_control icmp_pointers[NR_ICMP_TYPES + 1] = {
 		.error = 1,
 	},
 	[ICMP_TIMESTAMP] = {
-		.handler = icmp_timestamp,
+		.handler = icmp_discard,
 	},
 	[ICMP_TIMESTAMPREPLY] = {
 		.handler = icmp_discard,
-- 
2.55.0

