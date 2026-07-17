Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542D18FDDE;
	Fri, 17 Jul 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277861; cv=none; b=NvbYewwt4L/8ptI2DaQUbh0LbfgCz73u1jeKCsWp56JpQoRw5aisdVnKoqLKebzCcFONsvmcIc6tT8PLE1pIJo2oxf8S9zUm8JdEoKVERygRajnsVTNjJFyjjTbLtK8+5cw16HMk7PK87nS53kG+ZvUZLf71K4PrkrcUxwNccr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277861; c=relaxed/simple;
	bh=oF/9KBaBSMljvWOkY5pkex9+d03ji0HcE1tP8rGXyt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j6dRGwA/gE/i1Lo66vg52BQOKtmB11gQ3RP7RMCbpgo5faqCjOK31nQxbivanS0W0QpyLQlcxFOPPOe1l6ItWMqukF+jXiCZXgLLyu/MK2XheJwselmksLGB2KXz80cWoUei43gVMwm9leVPjZ97TLGqowqLPNvtGS3WedFfz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Gs0ZoM8S; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Gs0ZoM8S"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6dWBr3475094;
	Fri, 17 Jul 2026 01:43:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RXZzJk6N7nvQHV5CML/GfUm
	8GYxcbReD7mg0Cq8q6eo=; b=Gs0ZoM8SBHf7KR5kswvrlRK4TpIBFYI+GITC+xg
	6pQI9Nj9fZYv5Hr42uhbwols3XKeOo98ns3UTW668/0RBUCMvIFMQk4pFtOigptJ
	ThKNBhtfDWwhjtUlEj5wZHGd5u6OO+M0zTIOcC0v4BnGISaa6L1nWLPadfDiL2xZ
	qTNerflEFn9Qtfs79HMo7BZqW0RpoqS7BKnokXIGFmMxcgfcQaGbskGgZI3opxMf
	BN3FnuDcSj/axa466Tj/hz3I+mXxOBPXpc+hhp6K9jih/hskg20HHXo34eZ4fyzn
	zu8IuUS16/BCiEVg/Nt9L8TPRJpZc02ccQLKNvEd3zw47Cw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fetcbm0jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 01:43:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 17 Jul 2026 01:43:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 17 Jul 2026 01:43:57 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 770E55B693B;
	Fri, 17 Jul 2026 01:43:52 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: [PATCH net] octeontx2-pf: tc: fix egress ratelimiting
Date: Fri, 17 Jul 2026 14:13:49 +0530
Message-ID: <20260717084349.2227796-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: N6DygYCVfPwYdBhxyXLw__7VAg3ELT6K
X-Authority-Analysis: v=2.4 cv=Y7jIdBeN c=1 sm=1 tr=0 ts=6a59eb4f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=N_CG0vIWacVWWM4xhh8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA4NiBTYWx0ZWRfX8WUaat9KFOs3
 lpF4D871xlfQZEar1Vrbp0oHF80AwgBJcrC9y+NEcHH5286a74HC1ocLOCv05LLGBCJxPDuLCQt
 EWw+ReIU7ZsvkyjIne4J7VS9c8LRl64=
X-Proofpoint-GUID: fLf70T8NtE7DIfd0vt99C6LU2KACSoif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA4NiBTYWx0ZWRfX7cMLAiWWT0pO
 3EQEply0lt5h/619aHEZaNtirTSi2ceN9wZ7nvBc/0/bHC4brY94oWhBWt5Ym+GQOK3CZhwyQ1S
 uTeqin+cnmU2pmWJfiQbU54JqTTqMikmZIVo2EPCJvOVCu8W6pSQ0TLuoajbXHlslPUYisrEwJD
 1XE+L6oQW4f4PG7LPMeOiU2FOuJ4+B6HN2ngzJ1fGuFvpOWxNkNAmsq15RXNoL3Yzw8/491x+5V
 Kmo+s37585E0SjBUGm1GoVcxuJf7/5s73V/L6+t7HDMWImgHS+cSW4uthk0oZY7JT6TYv9e5n2v
 NttPeEDFy86f3Cdujo5yz+VC8QZ8ZecxA/D3Bi0AqMe7Pp3dHZ7xOvg/DhcSvLoizfUfR8X08f2
 wN5rTBTRomjOGC+O+Rqk+lAttQR0RIWWYJjepd2f6MCYSYSLI9ccr2ZeXD9k6k5hnOTDj5R+O0w
 5amAz6DgBJHLdudFu8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01

From: Hariprasad Kelam <hkelam@marvell.com>

The egress rate calculation computes an incorrect mantissa and exponent,
causing up to ~50% deviation from the configured rate at lower speeds.

Rework the computation to follow the hardware rate formula:

	rate = 2 * (1 + mantissa/256) * 2^exp / (1 << div_exp)

Keep div_exp = 0 and derive exp and mantissa from half of the requested
rate. Rates below 2 Mbps are floored to the smallest encodable step
(exp = 0, mantissa = 0).

Fixes: e638a83f167e ("octeontx2-pf: TC_MATCHALL egress ratelimiting offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 40162b08014d..0b46ec29e64e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -30,6 +30,7 @@
 #define OTX2_UNSUPP_LSE_DEPTH		GENMASK(6, 4)
 
 #define MCAST_INVALID_GRP		(-1U)
+#define RATE_MANTISSA_BITS		8
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
@@ -66,28 +67,30 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 static void otx2_get_egress_rate_cfg(u64 maxrate, u32 *exp,
 				     u32 *mantissa, u32 *div_exp)
 {
-	u64 tmp;
-
 	/* Rate calculation by hardware
 	 *
 	 * PIR_ADD = ((256 + mantissa) << exp) / 256
 	 * rate = (2 * PIR_ADD) / ( 1 << div_exp)
 	 * The resultant rate is in Mbps.
+	 *
+	 * Use div_exp = 0 and compute exp/mantissa for maxrate / 2; the
+	 * leading factor of two yields the full rate. Rates below 2 Mbps
+	 * are floored to the smallest step (exp = 0, mantissa = 0).
 	 */
 
-	/* 2Mbps to 100Gbps can be expressed with div_exp = 0.
-	 * Setting this to '0' will ease the calculation of
-	 * exponent and mantissa.
-	 */
 	*div_exp = 0;
-
 	if (maxrate) {
-		*exp = ilog2(maxrate) ? ilog2(maxrate) - 1 : 0;
-		tmp = maxrate - rounddown_pow_of_two(maxrate);
-		if (maxrate < MAX_RATE_MANTISSA)
-			*mantissa = tmp * 2;
-		else
-			*mantissa = tmp / (1ULL << (*exp - 7));
+		maxrate = maxrate / 2;
+		if (!maxrate) {
+			/* Rates below 2 Mbps map to the smallest step */
+			*exp = 0;
+			*mantissa = 0;
+		} else {
+			*exp = ilog2(maxrate);
+			/* Clear MSB and derive fractional bits */
+			maxrate &= ~BIT(*exp);
+			*mantissa = (maxrate << RATE_MANTISSA_BITS) >> *exp;
+		}
 	} else {
 		/* Instead of disabling rate limiting, set all values to max */
 		*exp = MAX_RATE_EXPONENT;
-- 
2.48.1

