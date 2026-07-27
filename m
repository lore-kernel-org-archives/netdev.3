Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194C7082D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122907; cv=none; b=tssvwuLMZn1BHldmxj20xNuGnoA8NHueP74v9liovDLGTP3tUKeip2gr+rpvomShdNLlkGfH5XUQJPL3J/C8PLJ1AxpGwG03Lc+Ypv8vrTLATcsWH/t+j6v+HcYg4DDRN8DsdDEg6rgS9DGylky+z8cby2I2uPhIJztz5Cva4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122907; c=relaxed/simple;
	bh=gwliqucWHQjpK3r9LlQzote8QzbnqbsCSwDQetIDMaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+Kri1w0cBihgu6oyBTM5EhKyRYlD+By60i75pZ5RRIFVSmA2ZZ+PAh8MIx0e6pAzDD8x0y4RgLLCgNCZaouM5IJqRbEYPgDfnL4UqAufxFNrDRpKDTa38tY5uD5YHPdi/P75jqs3j4uQpLshHWkZk7Sc2B7vDbsVL1Dt8b6S4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=THZAmG0y; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="THZAmG0y"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1jheh2014903;
	Sun, 26 Jul 2026 20:27:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=teyFLwWMDysO0T2mdo7gpXZHI
	YQ1seZ1Bk0P8UGwOAc=; b=THZAmG0y+s4rTUkpxd7Wbb28L89uraBPiJZVaCFgb
	4Up86FxiEZ94A+vDNkt2O5VML+20giHLX3yT3Y8ObJPKwD7WYVS7uCDLgXgSO6Hu
	qVkwrIQW+JlwxiJqdOEG3SddWXiFnyMKUGU4VcrD4Pruo3SDFqSnmBWswApIR6Re
	N7H+tqEDxiYtzdSK+G8CBua0sKsKY5dxFZVZOrSuQ2ekypRPLOstPO2M/yo90GLK
	Fc/Xj/dh9iaxJzZNMidnXNiwCf1Ele8TR+LDK6aAdZKsdsDbohm4l+M5ZuA3zZsi
	MRxEPMAxVylpp4Dv6rrQ/nNH21g+ZAjnaPfLZa9TuD9qQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fndw8saea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 20:27:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 26 Jul 2026 20:27:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 26 Jul 2026 20:27:56 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 452BB3F7062;
	Sun, 26 Jul 2026 20:27:53 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:57:52 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <Sergey.V.Frolov@kaspersky.com>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <bbhushan2@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Message-ID: <ambQOBLp5yYDbRSr@rkannoth-OptiPlex-7090>
References: <20260724121941.2637908-1-Sergey.V.Frolov@kaspersky.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724121941.2637908-1-Sergey.V.Frolov@kaspersky.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDAzMSBTYWx0ZWRfXwlCZttBDYsc8
 MTTIqNHi1pVl0jnI4Nz9aeNwaZ6ZL//MbE3ivRJwoE125xKBX5VQgI5WIcYP0m2kpPTwV3ro4Ft
 +B5BcNNIIQe9QWPWKV7GawqcVroQNzw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDAzMSBTYWx0ZWRfX7B9EBAWTn62E
 wc84fJwPb4Wvcgq7yu0WONLhyv3Z8nAMc0N/J6115gdihixkoBopqmABweGC+32cshFskcczeMP
 UXpBiZ5SGcMmQ3aEQZ7hunsdDI8KWAJjwQ/aA6UvztxmBLJnhEGS25daFY3m8fK1/ax/L7kMgKS
 YusQPwKZCWd1/gF/z/K58Bn+GmsVsiohtof9K4teIlGqPUdZldzeQ3fJKINkFHCgOtiZbbCWBBW
 kzT/LmrLRe/0Y8uwpcMIxOE2YAt6BdB17UT1mNX97S7El7zdcV5kFQKkYOoCt52bVGBQ8qHb21a
 nsKsT4y4j8wjnqM4jhTHlKMm2nWqniKjLWkBE0lbkuqD7dUzD0GEIYXcT5zm1M3Z+jRVTNBxv6t
 6I3a3SH6m6pyNvffVTsqBAuIcMrM2eazosNbMVjQ6Gs0DuOCqzAC5LqGUjfwg6/PsBqp/kcrHkc
 M6yvw8P9ec3jkAYj1Uw==
X-Proofpoint-ORIG-GUID: bi1T9S1EEumMRGiR2RhVmSpdMr95jxwy
X-Authority-Analysis: v=2.4 cv=DeknbPtW c=1 sm=1 tr=0 ts=6a66d03d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=ACEZY41XAAAA:8
 a=pSQC6eSdxnhi_1PKEGgA:9 a=CjuIK1q_8ugA:10 a=hoMZ6-YlqaBSvj5liN1y:22
X-Proofpoint-GUID: bi1T9S1EEumMRGiR2RhVmSpdMr95jxwy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01

On 2026-07-24 at 17:49:43, Sergey.V.Frolov@kaspersky.com (Sergey.V.Frolov@kaspersky.com) wrote:
> From: "Sergey.V.Frolov" <Sergey.V.Frolov@kaspersky.com>
>
> In function otx2_get_egress_burst_cfg, when the parameter `burst` is
> 255 and the max mantissa is 255 (0xFFULL), `burst_exp` is set to
> `ilog2(255) - 1`, which equals 6.
>
> This results in an unsigned wrap-around when calculating
> `(1ULL << (*burst_exp - 7))`, since `*burst_exp - 7` becomes -1,
> which makes the shift operand 0xFFFFFFFF. This value is greater than
> the width of the left operand.
>
> According to standard 6.5.7 p.3:
> "The type of the result is that of the promoted left operand.
> If the value of the right operand is negative or is greater than
> or equal to the width of the promoted left operand, the behavior
> is undefined."
>
> Add a check to handle cases where `*burst_exp` is less than 7.
>
> Signed-off-by: Sergey.V.Frolov <Sergey.V.Frolov@kaspersky.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 40162b08014d..39bd73a214af 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -53,10 +53,15 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
>  	if (burst) {
>  		*burst_exp = ilog2(burst) ? ilog2(burst) - 1 : 0;
>  		tmp = burst - rounddown_pow_of_two(burst);
> -		if (burst < max_mantissa)
> +		if (burst <= max_mantissa) {

Thanks.
can we handle 255 case with <= ? it looks simple to me.
