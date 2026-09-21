Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83242571A0;
	Mon, 21 Sep 2026 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958617; cv=none; b=RcxG8idDEYTWzQWPKbhWBg4Tfnv/aGX5pwoMXFbAdHNIrH6863cC6OfSmpSklhV3Gcsod+UkUIFzTG2W503WdLKe+E7PIAXCT6QvD0pvPoLTxCTylebeBre+de+ggqhErYjLz4hl1jPz+5vbUL6G2QtkDHvxEWC42mZCm5/A7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958617; c=relaxed/simple;
	bh=fyrd2o4Z+GYCOsJnAcJKgPGxHo9SOmGGaIKS1snfiUA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjZPKFj6Fpk3fCEeT26DU85/1zkHVO2NvyPLxVgCL3PouK83b3wUFTiP/mlqSmxC20kJO8mQZUnHn31t5ZhxcO2TSc8l3PkNVo7n3njIDqOkSzdbFcOeMxunb9LHzO/qiVwoB+z0Fup1xsAn0i3Qe3TSegmeScqGnlJjnklyBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ezLTnLx1; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ezLTnLx1"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L0lCV41932259;
	Sun, 20 Sep 2026 19:43:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	XRBClo1pFJvZ9okzNzgBPJ+nmUvNua8e/InUdLEx4s=; b=ezLTnLx1xJf1vEhuB
	e1uuGuotXqJzdYvhduaUT5E5rUMFqUtNdNSggijFJme52sQ2x5y6hpU80aisLtfc
	5X+t19NFaY+yiCl/6n0viaXgOD8bBi/XCUPt1ytolww8vguY1PSyHz8lgxT8WagU
	BZWqwAhpqlvs/w5l+B2ryJXSrebSB0hl7ZGdOLrRzwG8w9Kn4jB1XnybfrxO3/FC
	WZYcGoytG72qp6lUrsHO4ZUQkabHZjzblpf+d2c6WcxM8fGlZeqXbBbz/7Ubonum
	DvavTc6IrcCXGIJJKt/lP1CpeOS7qYC5THsAoViJJtCOsM0849Y7Ug1zc7C4d97T
	5jP8w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gsqrmms3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 19:43:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 20 Sep 2026 19:43:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 20 Sep 2026 19:43:13 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 17F873F703F;
	Sun, 20 Sep 2026 19:43:08 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:13:02 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <leon@kernel.org>
Subject: Re: [PATCH net] octeontx2-af: Fix memory scaling limitation in
 SR-IOV mode
Message-ID: <arCZtoQL_9ushLgP@rkannoth-OptiPlex-7090>
References: <20260916022111.1083017-1-rkannoth@marvell.com>
 <178986440480.2160803.16078325840590029895@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178986440480.2160803.16078325840590029895@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDAzNiBTYWx0ZWRfX/u09WK/iVgjW
 oUi/OsQOEb67B0KWbaQPmk1ctwckux3X6Gf0LNqbr7ohzKoobMs0c4PaOnPTNVxAX/bZlbxXf6h
 D+DnM7GjCUPZmUJTb8ht33SCHvIcNQRMfwtMbEwxtapXGjUtDjjT2k63K5UnFWu+gSDRD5jqe4w
 jlJIgWpnh6Qmw+BPHQ5S8fmjjQCPhLhXoGUmcii4EN40djpO4KYyQ7B5LzyBayMhZ23FUZlbgcf
 qEYRgKRp1QPYDQn5ZRHW0qsD/QmhdbH7QeplTK63RlKpipX5x3lvechI43IZiy5WbKqUekGIy1w
 u6gjei11kDBYWKx7JC6OmJPfgLWtuHYA8Ua6dhF67dMV33UzE39rQG0PoB9rZQEcfJ6W/RWFK0s
 HPWsQPK2xFs3VrGTfo+rRqOjkfArbX93Lbw/NpW/lnyXmITyjstsBsx+8G9kbrutD6SNtamOTLu
 wFuhj9qq9flA5gITjew==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDAzNiBTYWx0ZWRfXw7QG4lpcBDKJ
 nKlPWZ/ytmmX9MZD5fgxoNlfuii9U36HRNtUT2u+DL4fGOSTkxui3ItONfyOXIn0ZWwpqRU0sfJ
 3waDdlvjvEYMDlRNla6cQ4sseRFjwSw=
X-Proofpoint-GUID: hpA37y6WJdilId9UQjjLg2gHJPNaO0zL
X-Authority-Analysis: v=2.4 cv=Ga2CDgXL c=1 sm=1 tr=0 ts=6ab099c2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=1nBesQhVAAIfmHikrbwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hpA37y6WJdilId9UQjjLg2gHJPNaO0zL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_01,2026-09-16_02,2025-10-01_01

On 2026-09-20 at 06:03:24, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 · High: 2 (1) · Medium: 1 (1) · Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] New hard allocation ceiling in qmem_alloc() rejects the very SR-
>   IOV/mailbox allocations the commit claims to fix.
Targets CMA exhaustion from many allocations, not max single-chunk size;
supported CN20K configs remain below the boundary.

> - [High] Long-lived CPU/device-shared hardware rings and contexts are
>   converted from coherent DMA memory to an unsynchronized streaming…
OcteonTX2 is fully DMA-coherent

> - [Medium] net: octeontx2: fragile high-order buddy allocations replace
>   CMA
Deliberate move off shared CMA; CN20K mailbox HW needs physically contiguous memory,
so noncontiguous DMA APIs are not applicable; production failure mode was CMA depletion,
not buddy fragmentation.
>
> Pre-existing issues:
> - [High] Untrusted mailbox queue counts overflow the signed size
>   computation in qmem_alloc() and bypass the newly added order check,…
> - [Medium] `struct qmem.base` is produced by qmem_alloc() as a CPU
>   virtual address (previously dma_alloc_attrs(), now kzalloc()), but the…
> - [Low] qmem_alloc() publishes the devm-allocated descriptor into *q
>   (af/common.h:87-90) before both failure returns: the newly added `if…
Will address pre-existing issues in seperate followup patch.
