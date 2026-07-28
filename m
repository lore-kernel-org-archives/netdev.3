Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94C344DB9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210483; cv=none; b=RbaqO71loHO3nW+e60KTEDo2ituMMRxyLPcfbXbBG5U5kH4WHqxB6OqTF7QIxaoRbiPIqGDmis6xat3MvgaBBx/4WxffkE3iT+ckDnGDqG/j138SP40ABCcJ3IFouO4kf0k2Mdq2AB3E2RB7+/AbKSlK/Rev1Ayg3Aq3zk6kDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210483; c=relaxed/simple;
	bh=TDoW7r7MUYw6M1kK295xVexoSXle4XvSVWMlNn4MZQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByMdv1Qbzm8CDvTOXA2unR5ttY5UV/3/zZvwGYeZtvWB94Wfa43k5E8o3AI5Ghh9WDtXS3jgWox6mGzZvNNZ9C3L/9L/W42x4E2TNL0IKBTog2WicX6GDyeHBhe1Ciqs2jWjtc+Y3T+E5bVRv7N38720vTkuZW1FY8H5KaMsqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YXLl+ErL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YXLl+ErL"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3ZC4U657615;
	Mon, 27 Jul 2026 20:47:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	DoW7r7MUYw6M1kK295xVexoSXle4XvSVWMlNn4MZQA=; b=YXLl+ErLHW3SR+pCp
	yjP81h34vDbCL45hDdWXhqThCHhHEMGOzKhJM4ZuVSD9S3qL7MX2qA7e8qAy2kfD
	TOYP8SH6UnLJnL6gfrsIu+DuCdZtjURzEp7nC3PiPH1vNg7oGlpfA/N2RGJpE48E
	oiupMRdSJXJsJp6VFFHVcUDs+KC0b6gqXdjM3OjUQwJYJ/LNCU0unFlcrw3lzW2U
	EvkVL+xJanjZv/OCcf4B8yii2iVpfYpkGq2yrHSumJaDviWHswNoBDQwltUDyQ8D
	aMJmSHK4GR/Siit48/I3YexCdcyaP7j2GudQ00eKkRh/Sgxqg7Q9OkXkHO3z40Ky
	CXyZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fph1arkkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 20:47:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 27 Jul 2026 20:47:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 27 Jul 2026 20:47:30 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 42AAA5B692D;
	Mon, 27 Jul 2026 20:47:27 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:17:26 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "Sergey V. Frolov" <Sergey.V.Frolov@kaspersky.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "sbhatta@marvell.com"
	<sbhatta@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "bbhushan2@marvell.com" <bbhushan2@marvell.com>,
        "gakula@marvell.com"
	<gakula@marvell.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "sgoutham@marvell.com" <sgoutham@marvell.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: octeontx2-pf: Fix UB in shift operation
Message-ID: <amgmTvxY7_Z_u7tq@rkannoth-OptiPlex-7090>
References: <20260724121941.2637908-1-Sergey.V.Frolov@kaspersky.com>
 <ambQOBLp5yYDbRSr@rkannoth-OptiPlex-7090>
 <159a6806dd1ea12bbd559f664ce30d306cdf1178.camel@kaspersky.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159a6806dd1ea12bbd559f664ce30d306cdf1178.camel@kaspersky.com>
X-Proofpoint-GUID: 0RRJb56RZLfuZMXFx_IYXqcJj6wrHI7e
X-Proofpoint-ORIG-GUID: 0RRJb56RZLfuZMXFx_IYXqcJj6wrHI7e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAzMSBTYWx0ZWRfX13l1RvxZ4gvd
 95ImeS/Zh/ZkotwC9fy456Vk1nVXmvbXa/F4NLZC9TjfTgjaixQjQIT6NtEfkRq3QyYdvj1MHU2
 UJVLBmlrjfR7mqqoiuj7D19LuUh1TSU=
X-Authority-Analysis: v=2.4 cv=KKBqylFo c=1 sm=1 tr=0 ts=6a682653 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=ACEZY41XAAAA:8
 a=lkOzXEJ-8v_wGRag_xEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAzMSBTYWx0ZWRfX9ecKyqJpVs4S
 gsNPXC+u01dtkDOIm9iyZYnVM0xw5u5gtCf7WMO1SP/rpWVLQ00JOVkPBCBb9iavaMerT7cz5Fq
 /cVfBsma7bVAn8tJPslW1HxWLfi0pdM4UAjz6t6B+zSmCJin6Ygv1v3p1spQs330PHM+ltk+4u5
 DNUlqModXwLhvln9PalbOqvPUf8OIGyV9N8rTQyKagB9RkeYwvM12cos2wvwr85/y75INRknc0e
 XibGxaqZMqL4A4qFEheQLK/DuYTezYYc2DDzUPjudTfpz/I1X8IljEAY0Ll/K54Zyeo8K5fbz6E
 oylY2i8bqnnvRKrO8E/LG95B7+m81xAyUlCVDLDbPovU5r+CSCQlFJMAvijiTAb4ahHqtkVb6tp
 u2acR1tanHwgjG5Xbvd+CNHqDEd87mT1QJgWDZbp84CRe2/2vaUIs+jTDXtbIo65JG/lUlkofvg
 RGQh09nXbUAox2MclVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01

On 2026-07-27 at 17:16:24, Sergey V. Frolov (Sergey.V.Frolov@kaspersky.com) wrote:
> On Mon, 2026-07-27 at 08:57 +0530, Ratheesh Kannoth wrote:
> >
> > >
> > > Signed-off-by: Sergey.V.Frolov <Sergey.V.Frolov@kaspersky.com>
> > > ---
> > >  drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 11
> > > ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > > index 40162b08014d..39bd73a214af 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> > > @@ -53,10 +53,15 @@ static void otx2_get_egress_burst_cfg(struct
> > > otx2_nic *nic, u32 burst,
> > >       if (burst) {
> > >               *burst_exp = ilog2(burst) ? ilog2(burst) - 1 : 0;
> > >               tmp = burst - rounddown_pow_of_two(burst);
> > > -             if (burst < max_mantissa)
> > > +             if (burst <= max_mantissa) {
> >
> > Thanks.
> > can we handle 255 case with <= ? it looks simple to me.
>
> Thank you for reviewing the patch. I see that your simplification works
> with the current value of max_mantissa (which is 255).
>
> However, my concern is that this approach introduces an implicit
> dependency on the fact that max_mantissa never being changed. If in the
> future someone updates this constant (e.g. to support new hardware),
> the shift operation could become invalid again, and the UB would
> return. if max_mantissa becomes 127, then UB would reappear for burst
> values in the range 128-255 (where burst_exp would be 6, making
> *burst_exp - 7 = -1).
>
> My original patch explicitly handles both cases (*burst_exp >= 7 and <
> 7), so it's robust regardless of max_mantissa value. I'd prefer to keep
> the explicit check to avoid introducing a hidden dependency that might
> affect future maintainability.
>
> What do you think?

Thank you for the clarification.

I appreciate the robustness argument, but I'd like to provide some
hardware context that I think is relevant here.

On newer platforms (CN10K/CN20K), max_mantissa is 32767 — significantly
larger than the current OTX2/98xx value of 255. Given this trend, a
future reduction of max_mantissa below 256 would represent a major
architectural regression and is, in practice, highly unlikely.

It is also worth noting that in the proposed patch, the new else branch:

*burst_mantissa = tmp * (1ULL << (7 - *burst_exp));
is entirely unreachable dead code on CN10K/CN20K.

Rather than carrying dead code to guard against a hypothetical future
scenario, Could you consider following minimal approach:

1) Fix the off-by-one boundary condition by changing:
if (burst < max_mantissa)
to
if (burst <= max_mantissa)

2) Add a WARN_ON(*burst_exp < 7) before the else branch as an
explicit safeguard. This ensures that if max_mantissa ever changes
in a way that reintroduces this condition, it will be immediately
caught at runtime rather than silently triggering UB.

This keeps the fix minimal and correct for all current platforms, while
still providing a clear safety net against future regressions — without
adding unreachable code paths.
