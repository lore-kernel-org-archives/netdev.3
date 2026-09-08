Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A555128B4FD;
	Tue,  8 Sep 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861130; cv=none; b=IRnjQxL23C1XMhYLXcJlPhDRwkyaQXcQYIAa+Er9HHSGGN8a0evcrMpuW8oUehv/4pQasVn+8uWCxyG6TxumM9tSemItQYFoycMYtV4Dx0HeKvJvHBjOkAoLa9foehBCj3W7rxVGnC8Cr1UeTcrGRnQ+ppkfaNwJz662sjTlxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861130; c=relaxed/simple;
	bh=g4EzTukHgINHPK1mCCzVJ9EXC8YOuxx5QeyvRIrqraI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J777tUPd7yQGw5PfKp3J7QlakiihRRRfZAf3ncLXa2IPAuUYW9GP431ApfMkHZ5PlKPHNCMOHGP+UFEjoq1u2jbENN3jL7F5T7GrKjjRG4R3cVjOIy/lPTlsB/4A8j1qk6blGeTc00FB5Slhk1HZusoVli1VhiGRpajPjVN0gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CVB0BcCf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CVB0BcCf"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6889OtBp4025915;
	Tue, 8 Sep 2026 02:51:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=SRR+SojQBY7dhYrHflYyAZuJG
	mfNPQphqldkS1HvwWM=; b=CVB0BcCfnZ6Ml2x93PdPAHjulYs9ouSL+w7Ezev1G
	LjaAUVDxZR4UAB5NVvn8GF8oq6xnrPuVqvftQQ4VxeFOyPXpxrOWX6tLOrn6dWsz
	Zx51JbsNnUoPArJ67VY1IZ25YcKSpYBS8yDUjlzO6kxdg8wUn0NzwyCVtyWc445i
	AXZ8k4DNHBjfQOJHN6Aofx4LgTcZNVGhcaSQyiIQ9aiEVH0iXMYzIFaXW/Ch9nmx
	7dCx1cgGZ3kxNlpP6xOBrC4n7/BE2hB9+MTTKwHBpWP87Wkhbmv3y4ogTO8bYg5/
	dkm+kK5ffTsK7/uytUfLSFxIFF1w2yv0med+/KYluLCpA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gjfq2r1tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 02:51:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Sep 2026 02:51:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 8 Sep 2026 02:51:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6BD8E3F70AC;
	Tue,  8 Sep 2026 02:51:40 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:21:34 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
CC: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <13667453960@163.com>
Subject: Re: [PATCH net-next] octeontx2-af: consolidate RVU AFVF device id
 definitions
Message-ID: <ap_apjF8eI1ADnOF@rkannoth-OptiPlex-7090>
References: <20260908094051.666769-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908094051.666769-1-yijiangshan@kylinos.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwNCBTYWx0ZWRfX/+/0kngAAgsB
 chaj+InwjAsYayYnv1JLw/HynC8H06ScV9C8wh9Hs1BTILvRJDSkJSBGpdyxNCQoNNChWwlugkw
 doMkGT/aWNQfgUk4k+kWV4DlWpVbuLI=
X-Proofpoint-ORIG-GUID: 351Xvo2qO8qfJCJIKjJKrNIA4QpzdSS0
X-Proofpoint-GUID: 351Xvo2qO8qfJCJIKjJKrNIA4QpzdSS0
X-Authority-Analysis: v=2.4 cv=Rq716imK c=1 sm=1 tr=0 ts=6a9fdab1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=BNXLlw457bh0rJ7vRckA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwNCBTYWx0ZWRfX/BdaE4bi1cBR
 0hCP7y60qH4Re6xP4XhlCZ7POC7CLPpfGLh94gWmKZjd1xCvgARFZBZeZpEti6NxfkE+NOh9Qsw
 +UzwJytWQUyMhLL1+tUHWlZtnfipAa4hVkbCnht07UWEOrfQLYwo10mOZdmR8t9x+Ex8jEpYs+a
 j79B81z+AKQRi0bTssiRzU8gkOtNnDZMi+Yobwt3WxrlYmWED53Pdbws0Vqgrn7uj1i6nqSscEC
 T+QwLa7tkLWoxTwTOVeswbbqyT9m/FpACXoU/mmqha4ARKtSg5zK4pz3rnCmOnH6wrPaN1r0VSD
 MWe3S+XQr/SYXFKCE876ux73KrbDlD3AmFMFh51SEAtLTo9J75pioi7le8x+NAH10OSfBu59TWM
 Fs/QfweOhxBPcCImnJk37hTyruOtRQ9T8dzu6iu2KlKGnhCQlRMRaJbjNk6/WqAy3CflzxnzGmK
 n9NVpTGgQzPpmoeZvdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01

On 2026-09-08 at 15:10:51, Jiangshan Yi (yijiangshan@kylinos.cn) wrote:
> commit f695390ea639 ("octeontx2-af: Fix limiting SRIOV VF count logic")
> added a local PCI_DEVID_OCTEONTX2_RVU_AFVF define in rvu.c, duplicating
> RVU_LBK_VF_DEVID in rvu.h.  Move the definition into the "PCI device
> IDs" block in rvu.h, rename RVU_LBK_VF_DEVID to match the PCI_DEVID_*
> naming convention of its peers, and drop the local define.
>
> No functional change.
>

has the code been compile-tested?
Acked-by: Ratheesh Kannoth <rkannoth@marvell.com>
