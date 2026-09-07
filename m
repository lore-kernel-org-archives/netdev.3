Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D7369D5E;
	Mon,  7 Sep 2026 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755109; cv=none; b=jF3teoO9E/H0QZAm//fmjBeD3E+jg48uhu0vDaNky8s/r7IbC66lZcgIVJNU3xieXaliERf24GoPkkTmt72ONbc9slErNwZQ5nah3HRVPfnndgpDW4HdUYdh3EePgNbBO+J8n85OKeZuEwJiRHxvz3/Slrv2OUs7Qo2VYobeaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755109; c=relaxed/simple;
	bh=Y9qhZ0EUriUtPw775eUvM6O9EZIkp4uKKR2RSjjkh+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn22Evz0aF4/FdCjng4M4WLzJmi3PTNC9HY6jTEta8wNYdVFLTJlMZiUXOGCj3fCXPs2qLv4Z5j1xO/994uOWR8plZN6KwMLEVdmu2loCJ4Bp2TwzD/XJAnsmdLdSKzvWupFzNa6tiUKIWS2WYkfUKmJjjqAPS3kGeeYAbXl39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f48mMcWV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f48mMcWV"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6873krvZ892503;
	Sun, 6 Sep 2026 21:24:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	9qhZ0EUriUtPw775eUvM6O9EZIkp4uKKR2RSjjkh+w=; b=f48mMcWVLDCRS+RAN
	2XIndda6RkZ4X7c9kMlODQGWW7eBrqgJ4D57LhfbawQ+yVpPjhTFQ1RU7A+qFPwg
	8nlEcgveDwhqihj5bfR/YqFi4o1T3FVPVZBLdNjtLtmW0ERbF7huUb79wrKJLQLe
	ImgBvm2vYia+2vLgGvlLEknzJ6xJJY+9R1r9fYGyGaZj3U2DZE5kYbmf9DjmjrOS
	jw532MVCAM0BlYZo1iFgBwO65d9UgQOPBLplo0lPf3acw7+HFdmPXsDtNdQUTm10
	eK6laWtGHdK8GNpz6E6yze1ZGTWHyeVtOOGqzoBH0lWfil/BcBhQ73N9xIqfJ8dq
	SybOA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gh3u8sfjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 21:24:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 21:24:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 21:24:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E5CA83F70A2;
	Sun,  6 Sep 2026 21:24:40 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:54:34 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <leon@kernel.org>,
        <Qqingfang.deng@linux.dev>
Subject: Re: [PATCH v6 net] octeontx2-af: switch qmem from coherent DMA alloc
 to streaming DMA mapping
Message-ID: <ap48gh5YWPylJUeK@rkannoth-OptiPlex-7090>
References: <20260902021023.2987908-1-rkannoth@marvell.com>
 <178863855246.219967.10510865726694393307@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178863855246.219967.10510865726694393307@kernel.org>
X-Proofpoint-GUID: fkRVYr-P3rO9Ug0Xk5vufcBe-gTWybE6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA0MyBTYWx0ZWRfXzHGHuvmlSdxW
 pyjbnjLK4luriN8h69OO6CssOHSzmRbDJmh7Jgc1/ejHpcMS2WGVT37lWc87DX96YRPNmEjXtzA
 qWZYtGF6CXnoFSmP4VNmEdAT+DtvrZk=
X-Authority-Analysis: v=2.4 cv=b7+CJNGx c=1 sm=1 tr=0 ts=6a9e3c8d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=3SdOMOnD5VJn7s-gbW8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=SqOTP2NwCHEA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA0MyBTYWx0ZWRfX69ls0qod+l7u
 gCa6wh0H6D/th1aWUx2NxO4dcpfXV1tL/c1iLOsz7pu10chf1GGh8YVDWmil2pxU1WDcznNWQwj
 KM+4fxQJqtU1hoUo4YQlpiiLvhwsRzzFLvZcNXaZgS8Ax+oFGqqVxBqIDe4QjbsJzG74itYENdA
 Eoy+ZczEXMcC4d0jwo3Q/sDV/xBUDvcyLCDS7bn+Nq778CdZA28drzfVc5N3V8A9Pwjb5j79o1L
 qcpADAqQbUsi80wTK/x5VdqQekdcSXS/pFkFhm76iXkwKrPSUAEQ9/fJiQOhpe1z0SxfblKeQsQ
 tzl1wIMUP7lSYyIPOmz6amAyEhT0x1a0qq/gX3Mg5PaWgDj4wQ1MfqY+6sI5NtczwWyt+lvLj8a
 HAb/Ni6FYoI0aiEPl+ag77DseEtd/YQWtUD5T4VzuCsMHotM5nE8r5TC1n1ClLyIjP2soWrVVWg
 DJ+ONH3K6g3dsjwSvpw==
X-Proofpoint-ORIG-GUID: fkRVYr-P3rO9Ug0Xk5vufcBe-gTWybE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01

On 2026-09-06 at 01:32:32, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
>
> Critical: 0 · High: 2 · Medium: 3 (1) · Low: 1
>

Will address in in v7

pw-bot: changes-requested
