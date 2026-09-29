Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38128248B
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649413; cv=none; b=I0yl3g/A8j03XW31/RjK+HTnqYoJ33qFJnFyh/Swz1vkK+kr03uTEBdA7EQGmMQ+mvN36E+HUf/eASEu/p3ZNQhAC1fNE/VsDaud+825PpuIiEfAt7H9ET4toUxCse3TtjvSYAARIevRybFVYMg8cwgrHfwLga0dnQDJ37P5aH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649413; c=relaxed/simple;
	bh=OFwAg/hQ2Gs+gQhYFQ+pqZOH1PFUIUaZWpmU4/jo7hc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvM/xiJo35rmeNeDnGXBeGsnIeEh9yhX35PwNdJpGY9i3XJt2D5z+Oo5sV5AotLpN3KnEnlawqDZXIJX4M39K8467gxU3iAMM9azF6RpForP+FGrGUTI0UyFoha5miLH6/thtYK6Rr56U14tpfBv0iG9siCf75xCa/kt14eTyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vpxb5mj+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vpxb5mj+"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T1XcuU2903215;
	Mon, 28 Sep 2026 19:36:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	FwAg/hQ2Gs+gQhYFQ+pqZOH1PFUIUaZWpmU4/jo7hc=; b=Vpxb5mj+yHDGWoliT
	7hZz3bhiWieTNwkG29W0uOCK1zfoTlD9vGuIj7jRUXW6wzItTaVfZmtK43OnWxA6
	/jSXWSYFMAt27N4wct6yYgL/AZVoAp1THxG2ofMUmTAJGKo2S+U73IEM1SyxrCWb
	htSlKjqvAXF/hEL0RGFJKdmG0C81or9pQWOsHAOgK+8IStXtCc647YSXMqU5kp74
	JzXted6PU5QoadwBqVr/gFzY58LjO0e/qDFP5/QjSl7QnRfnxkoKayhqQCoBFgRm
	yc9xPWr53s99AsMVnnJedJxF2W2zcB6KZ+p5WcoGuI342KJvpbD3k/GXiOClJHNz
	9VEhw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gyub5tw2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 19:36:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 28 Sep 2026 19:36:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 28 Sep 2026 19:36:38 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0E5EE3F706F;
	Mon, 28 Sep 2026 19:36:35 -0700 (PDT)
Date: Tue, 29 Sep 2026 08:06:29 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jari =?iso-8859-1?Q?Sepp=E4l=E4?= <jase@nocloud.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <linux-yocto@lists.yoctoproject.org>
Subject: Re: [PATCH net RESEND] octeontx2-pf: Fix RSS indirection table size
Message-ID: <arskLfzeW9LNrQuR@rkannoth-OptiPlex-7090>
References: <20260927154803.4b4bdf35@kernel.org>
 <20260928084711.2462571-1-jase@nocloud.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928084711.2462571-1-jase@nocloud.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAwOSBTYWx0ZWRfX2x2U7+HomIjp
 Rm5VReSX4OgjJOYo0heu+46D4/lRCxqvCwJG60SRI6baHBatUMo6GZgEimaH6gOUefS5M8QNwZJ
 rOC6LmaA678uQQABpOnfE9fbKupSVVSKJG2rNCW1VHrxRlQ6GN4R7XmNgqya9eKfgO21dM+mGs+
 tpo8VxNfSOaZ2GHfZieatCVwu07/hFaAv+ACVSQRu+bhLGrPKy23QQ3O5p013uxGMubjG7SDyvz
 7Ahi5wSWSTG0mz8RF1aiRc/ZYYfjXHwHAzmvFbOPF91tARSYTLfAHU6mYcBD2qXVhksrVaU+UWU
 kFnWswOi+GIuohvirb4N1hljjFOZDYgECfnoqAnzYAJBgi2Bu4Ev+aViB5r2cVeRKvHaoDT8KYu
 MgJ9Wu4GdppluAqtZWBOypEY2mrMm+bC4/xp6gk/IvZFiUc8wj89K7MBu1PNEOvPh/5GRdvfO/5
 7afIgOPVj8/LBfmeh1Q==
X-Proofpoint-ORIG-GUID: JiGUZeFyd-m6S4JNfLCzxkhwfQzHR83T
X-Authority-Analysis: v=2.4 cv=e/ST2qp/ c=1 sm=1 tr=0 ts=6abb2437 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=RIytl6ycAAAA:8 a=M5GUcnROAAAA:8 a=xs-UJ-07zD4AvPOOHmoA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=xs08PT3LXRM9FqCpyaqo:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=WChRXMWxrBZENkJ_ADRk:22
X-Proofpoint-GUID: JiGUZeFyd-m6S4JNfLCzxkhwfQzHR83T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAwOSBTYWx0ZWRfX1d8Clzo9Aoz+
 fVCVDAuPAi67IbJYPvj7pAmT3kMm4COkvebULXpqFs2lVOXF52vWTE8CVch/AIkwOpOqHBsPj4R
 gDRnImFeNiZNtfeWsJW//3yLhdUyguw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01

On 2026-09-28 at 14:17:11, Jari Seppälä (jase@nocloud.org) wrote:
> The conversion to the dedicated RSS context operations replaced the
> pointer to struct otx2_rss_ctx with an inline u32 ind_tbl[] array.
> However, otx2_rss_init() still uses sizeof(*rss->ind_tbl) to set rss_size.
> This now yields the size of one u32 (4), rather than the 256 entries in
> the indirection table.
>
> The RSS initialization and hardware programming loops use rss_size,
> so only four entries are initialized and programmed despite the NIX LF
> being allocated a 256-entry table. On an OCTEON CN102 with eight RX
> queues, the table contained 0, 1, 2, 3 followed by zeros. Traffic was
> concentrated on queue 0 and ethtool -X equal 8 did not correct the table.
>
> Use ARRAY_SIZE() to count the indirection table entries. On the same
> hardware, this restores the full table repeating queue numbers 0 through
> 7, and bidirectional multi-flow traffic increments multiple RX queues.
>
> Fixes: 62e01d8c4170 ("eth: otx2: migrate to the *_rxfh_context ops")
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/netdev/361df563-e29e-43bf-8806-24bdfefed33d@nocloud.org/
> Signed-off-by: Jari Seppälä <jase@nocloud.org>

Thanks.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
