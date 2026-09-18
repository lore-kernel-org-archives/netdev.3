Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78928488F;
	Fri, 18 Sep 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716811; cv=none; b=tJTcmy9TlXntrJgZCzrB1x/gUMkDxyQBebTbA+C70Lyp6KcQ5gy+6o7cX5jHOABzDMYyWIurYxwK77Wr/wtReRhO4P2ynOfvn0eoqMyKDcztAaIVyhRvCEqUrV8DMOr1SA3CpsktKsCYBEFK8ll6wtKl8nEYBvG7FofgYcSK00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716811; c=relaxed/simple;
	bh=PNOqakjCzlDHfhfP+JHYgpaT3NJXVdxW354nD1kuzUo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrD9hcnpYuQ7DT4HeUBXVEDk7CODRxhH0pwprnTHNmeAeldYAnkkpDbIxUSsrnV/cNetSvDeaIUt2ulWQqKhLM4jiqfz5ouUVUw6j2Wmy1FSXGFZLDGALN69BXZ6y4JzdShQ1yhlu2Ah0TyzmyT5IhtBtbMAtW+AkuQBW5XwYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HYZkraWh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HYZkraWh"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I60YYc2610016;
	Fri, 18 Sep 2026 00:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	jKa5d1ACYUoZN5k5LvXWNNY4cP4wUExQhul1U45cEY=; b=HYZkraWhkkyZ7V9lL
	gvoy0R1l8nKtwwbjT05vXmTmmDqWNjM4I7xKHsm4NAIIsZV7Ql53Mrl+x+b7tIm2
	yJXvKhNPYz7Gn72jbZTFcoYHNsi7cLH8L5gIs/1Ri5XGaQ/hOMoz23M8Oau/cB4f
	0O1txu6Nh1O6AHp5300j6FquOFICZnTYXULQa2R8/EgIk2zYd8IGTNg7Sak+L83h
	fxWg/vjyMfK7Zaljqsg/YEZskcSjQSVy/EsEOczHiUCPZXqSIZPLuSNDCRGd9pt8
	oyXZBvvustfcXZ8czo0OpTFprpYGuglV+9pB5PW+KphvVEDYTqagNjGMDLF/3MD+
	1dEWw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4grkjw4pcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 00:33:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 18 Sep 2026 00:33:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 18 Sep 2026 00:33:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C6EF03F705E;
	Fri, 18 Sep 2026 00:33:16 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:03:10 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sbhatta@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: nix: Export CN10K admin queue enqueue
 mbox handler
Message-ID: <aqzpNjAtWSoi7hX1@rkannoth-OptiPlex-7090>
References: <20260915072357.980485-1-rkannoth@marvell.com>
 <178971638355.22033.14086854049232485813@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178971638355.22033.14086854049232485813@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMSBTYWx0ZWRfXy0rUHgQ/MqPl
 FVCdfxhkGpK8/DIrnuo2Z7geenQrg1wX0jZw7b/ksgcTp9O/rzmVHHL6+oM/5os3lumGzbAn9rO
 nqo9wysqx85Imi7FiapH/Ep7GF0ANibPzMDYkvBQ2SDAcl5osH2APamq0ssTRVTeS/ErUJo0NsK
 U1Xpoa4Qu+4dBtCD3tbgKC4kcRz5rluifF8QRUmWB1htlKMYbx0IAwrEws7dJ92/rTBPkz/gghO
 MFObj3asK/cJsfnkgfPAx8X26+iKYMx6r1x18RxHt6TO19PboL2AcaaQILVDJrfwVuRyrGFg9cU
 QnBYqYwDm2/uXCAb7++xBR+7sMa3nEdiIbfPso2omn6RdSnbd56ln3cN6033in4UXFPx5Tcpr+S
 k+sEvBl6E6xU4rtJFbvRl++bLyVPA0kWnLS33exvwI9RcXTfX3TdnFfh2yIX6cn/Be/nEWzIKbc
 E7YvHqwbTa1nqEVNJ2Q==
X-Proofpoint-ORIG-GUID: zRUz3FWhwvSyWOKNOGLuX0TfUEOUq0uD
X-Proofpoint-GUID: zRUz3FWhwvSyWOKNOGLuX0TfUEOUq0uD
X-Authority-Analysis: v=2.4 cv=Zqx4uN7G c=1 sm=1 tr=0 ts=6aace941 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=QNIf5hWDA9SXPf2glzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMSBTYWx0ZWRfX4Wk+cccxuv7A
 kpc0mY9bxc5F8Sj0aLWzwqxQhpCIJf4JkaZbI8x0PaV0sANkf/PZ3pCBoXd0B3ZoHLb7ZOiKDPR
 wIy9sW44c7ie7iuGAmSYnIff283GIU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01

On 2026-09-18 at 12:56:23, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
>
> - [High] New EXPORT_SYMBOL() with no in-tree consumer:
>   `EXPORT_SYMBOL(rvu_mbox_handler_nix_cn10k_aq_enq)` is added in…
Can i post this patch to net-next as consumer is out of tree ?
