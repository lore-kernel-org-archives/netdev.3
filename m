Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF441DEC4;
	Tue, 11 Aug 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438024; cv=none; b=hGBnm6clGFfyb02+ctGR+Mli3WsSeJvJjr3bHknl3hYjbzurnWWqPZK/E9Y7zktkGdDQmok0eNVUxXSVs/q1tGQueyEYCBpUL968+A58TzL2/K7fPeOB+SUy1VmPN1dRXuaLqWp3I6yQVw+fKB8FPTD+ETMOPTlu/q5QYVWi+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438024; c=relaxed/simple;
	bh=KiosbZMXb5XvMNjiIV2OQ8vRDwOU83pCle5YUMhRWrE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeHLOi5lUCDFo7OY4AaDxUTOsqr54gcRIaT9L1dShGVtmxk6M/gy2qkiVCR6BvcqbGQ2OJ11psylU/6ajtyVyVgByPwaoLfaayJoXq7bVsB/yMP5iRleqlrmni5lM6gSqc+AH15YOtw0AUvErY/Af5hIXbVVGcsoC44Z0IwSPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PxcLln+4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PxcLln+4"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMpkxf2647090;
	Tue, 11 Aug 2026 01:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=KiosbZMXb5XvMNjiIV2OQ8vRD
	wOU83pCle5YUMhRWrE=; b=PxcLln+4zc8UL5BU4eUn8GPU/Oebwetnf3mEZtbIY
	NWKXDia12ndol6mqFaEgiaQBEMVDRY+Unk0MDsnJHOj4ifQlHoZR4ywY+M3LIAMh
	zwRqzwRhq06dvZeeX6uScPDdk896FXrtJXL8EbZ+hUps9Asc/G5yWdfYMRA9v8Rk
	8OHn7NrDKa0MaUG9xs7rdKt+wiFhjwFG1B/jv5s4GvJKuiBOSAB4Ylcrlx3syS3d
	RexUCoDY1NoBi+QDfn8ViQqo3/AIxY8kOJR9S3X63PXpHJPA5pehlxwoHgkJ0L3s
	28G/uDvBHVqdTaa2TQaPiFyOa7RBorpUzXQH2Y2h8ArOg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fyk1hjt6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:46:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 01:46:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 01:46:42 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 018F13F706D;
	Tue, 11 Aug 2026 01:46:38 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:16:37 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v6 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <anrhbdX7XiMWAJvy@rkannoth-OptiPlex-7090>
References: <20260810034738.1786029-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810034738.1786029-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfXyZsSQgzaoKIF
 ct4SVPZ64pwPRODoeJg2Z0sVfHwYTEexDr6vgv7uS3oUq3MVh6qV15RCjcZkctZqHtCDRkkhj44
 uXuz0HNvsKFUA3uacJH9Pg3KEO9SO0U=
X-Proofpoint-ORIG-GUID: G3_PclrGht0MhnHH2PR43FM0seyYa88X
X-Proofpoint-GUID: G3_PclrGht0MhnHH2PR43FM0seyYa88X
X-Authority-Analysis: v=2.4 cv=EIQ2FVZC c=1 sm=1 tr=0 ts=6a7ae173 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=0pSdPhCRaIiOy_kaLW0A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MiBTYWx0ZWRfX1BVQuRJOR11Y
 XnUtNdd64Yn5rm1fs9t6LWAsB2aVZsMg2wqCoLFJ7FpKoGbbd5tEXt3wYqdsv2OKRMt2OJZwjLS
 l2UtKsibIDb76PAF0unpAy9KOZh051WRDkz9FxL7uOmaCe9k997aVoWZuHCLWjj3k8RkdvsnQL4
 wNJLzNk+wVwc5KXZpF5bnQpXf5XJ2r0FcEP7Q2pl4G+Gs4m7qfh9iJ8MV/r0emEFw1q0kSjXrmw
 X1xQW1UrwuJnITXy+y4fOXfRUQuf2diZWJZW6wiy+CnMdhTWCppOSRFljQHhgf/RBHsBwoVVWNs
 5n5FH7Ddb4hxkmbVQoeItWDP2CZU3AmFMDJHyzrqN2cWMmzgOkR/0E8+HzjBAaM1EfzMD/BK4yl
 HOm9y+jEQYjYEvYxVS1C8+0WTZPQ9xO8eqrb5APscktrCT9wUmgxmMpiXFK7qbulONB8/rx9GqS
 RelhbAa6j3wFcez6Vlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01

On 2026-08-10 at 09:17:38, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO handling to program per-queue MDQ CIR/PIR
> shaping after mqprio channel mode setup, widen SMQ allocation when
> per-queue rate limiting is enabled, and align MDQ parents under that
> mode. Reuse otx2_convert_rate for bps-to-Mbps, fix sparse register
> writes when only one of min/max is set, and improve AF txschq map
> mismatch diagnostics.
>

Will address sashiko comments in v7

pw-bot: changes-requested
