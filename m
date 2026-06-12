Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8C23AE9B;
	Fri, 12 Jun 2026 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228972; cv=none; b=Ki1PRl88JIVZvFZU39w6E6CB+Ed6v61DlPz9FC7G/TzngJb2V++z0VT1+QgKzEbYcPJSDnrNFxblbvuPTqQ0PTvf81bedI1aNGZEH8RED4Q9E/TTRFCzvOlNJPZvBQrvW+NTVcY7W6KwxsoW9jlAmReId0EdjS/ALo24YyWQknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228972; c=relaxed/simple;
	bh=M4eJrZWpcB9Aw7Nf+IqzdE3R7/pCpiNvITcSdaa2uhg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UilOwQ3GiT3cZYYuv+1fnaA6GC8caPsF+O/sKQ1MRBsUUSOSnrEhyuLFfZKKs/IzkqEkNrNhiSPMjvm6rZEK8Uu8wg0AQiRQ5OWj5DErArjpJQtMoPO5BOlDeF2OgUsjVqSy+hj5OK/b5PycLd5Mu2C0GEzkFokeQE5HQST3ZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HOBZHBlB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HOBZHBlB"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMRne13175730;
	Thu, 11 Jun 2026 18:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=DTqyqBdd5C18D5wuA2PGiWif9
	/XIpDtROOsQQtGY4CU=; b=HOBZHBlBJpDY7BQas8xS+bOoFSqCMnW3k8YeDqHMw
	fR3bUAKL36LQOpHO49NToFHaCPh7t5QZ6HAjyJWFVIrdWJZZSuzZStPhDU+hvn2T
	MADQGA2japc7QsiPYT1Oyw8gkkpZohpQmw+m1JbtgDRDUSk2bh1QKLLffn4lr0Ul
	4HxoGOjvwyJuAaCbxXuDqZWQ1gFiRyvpseRQ6ACGze1w03beEPmcC1DuiLfrINig
	jRckw4QTJqCNvxWRksDZkCIrRH8NFqpTjHeGR4YZS0BZYtkiW1QMQ4nXXMmd+iRK
	SfVlWZtdXx5izTaYE//gDxYN5KI3HWYow6rNiaaxYZt6Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w5k37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 18:49:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 18:49:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 18:49:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 86D173F704F;
	Thu, 11 Jun 2026 18:49:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:19:04 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Yuho Choi <dbgh9129@gmail.com>, Sunil Goutham <sgoutham@marvell.com>,
        "Linu Cherian" <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nshettyj@marvell.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference leaks
 in debugfs
Message-ID: <aitlkIiQnud9L0vP@rkannoth-OptiPlex-7090>
References: <20260608165546.61347-1-dbgh9129@gmail.com>
 <20260610083544.0da95356@kernel.org>
 <aioblJqQctA_9U8y@rkannoth-OptiPlex-7090>
 <20260611104547.22cedb69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260611104547.22cedb69@kernel.org>
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAxNCBTYWx0ZWRfXwQsL8UN/40Uk
 GH09yC0GJ4wUQ2rUbZwEofazM/+FW68feBCIrti3uv8A2HiGoDGQajqGV8MDKxvrLoDx5U69eQV
 hvEYp4Cb5/1sT1qnLRfXLsCAAH9/0wTYXvZeNCnZIu43JQwoUv6gJ/6gf1OXxIAYgaT2GHf62C2
 4gRfdl8NSqXSQiJtZcAGgK+L5ENVHAhsXKIyaXgYPBvM6H4LQ8AG8EooKhiinFX1kl4iLkuzwR7
 wNmf3eO9X6vMbrSq9jFAdifohMJ4/3SIz1r4ZklVUKfbZMzgXVT4H40Ny2KyUXoY0wn25a1CjSr
 jHA+d1zCVJonucJEjXSDrZSfDXQQREWjTZNd2H53T4nSrAqite9DvMOJf5reketiOuR1yEtmzwG
 xVrQDgCSvpcePE55/134m2bM8kOSW07lnpLv4qdljs1dkCIRQLrXns8+PKrEwG6hmgsb4Ff22mx
 A953kA3hV67oVXcDvPg==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2b6596 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=atD5_INQohETGejqZ2kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAxNCBTYWx0ZWRfX7YIhPaCGhsvT
 mwFCjv7m0oUzHz7Aq5AEx4jOUbwv1LlGF1i3BfSkwOw6r7/YR9agnByWQvsyX8jX8a/L9GtoIm6
 G6och4aKoBkh06/hjwSIAjbsMvZU6Zk=
X-Proofpoint-GUID: 3LWHye4SiBSlGCGqxhPnKoA_qPMVJGm7
X-Proofpoint-ORIG-GUID: f1UnxqN6DTJC7REL3Lu_qpVSoK4iYKFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01

On 2026-06-11 at 23:15:47, Jakub Kicinski (kuba@kernel.org) wrote:
> On Thu, 11 Jun 2026 07:51:08 +0530 Ratheesh Kannoth wrote:
> > > Review question sort of based on a Sashiko comment - this is part of
> > > the rvu device driver, AFAIU, does anything prevent the AF from getting
> > > removed (via sysfs for instance) while this code is using its priv?
> >
> > RVU AF driver's teardown sequence prevents the race here. In
> > rvu_remove(), the very first call is rvu_dbg_exit(rvu),
> > which calls debugfs_remove_recursive() on the debugfs root.
> > ASFAIK, debugfs_remove_recursive() will block until all active
> > readers (i.e., any in-progress seq_file read callbacks like
> > cgx_print_stats(), cgx_print_dmac_flt(), and
> > cgx_print_fwdata()) have completed before the removal
> > proceeds. Only after rvu_dbg_exit() returns does
> > rvu_remove() proceed to free the rvu structure.
> >
> > A better approach would be to pass the rvu object(rvu structure has pdev field) while
> > creating the debugfs file itself, e.g.:
> >
> >   RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, s/NULL/rvu);
> >
> > This would eliminate the pci_get_device() lookup entirely. We
> > will post this as a code clean-up patch to net-next.
>
> Oh, that's much better, somehow I assumed that this dance is necessary
> because we are accessing a different PCI device.
>
> Also, since you're actively working upstream and nobody else on the CC
> list responded - should you perhaps be added to maintainers for this
> driver so that you're CCed on patches?  (instead of one of the useless
> ones)

Thank you for the feedback, and I would be glad to be added to the
MAINTAINERS file for the RVU driver to help with reviews and tracking
moving forward.

Regarding the review coverage from our side, a few of
listed maintainers have transitioned out of the organization, and the
remaining team members have been tightly coupled with some critical internal
deliverables recently. However, we absolutely recognize the importance of
consistent upstream engagement. Moving forward, we are aligning our
internal focus to ensure we actively participate in review cycles and
maintain a steady presence on the list.

I will prepare and submit a formal patch to update the MAINTAINERS file.

Regarding the code cleanup discussed above, we will get the net-next patch
ready to replace the pci_get_device() lookup with the direct rvu context
pass.

Thanks again for your guidance and support.
