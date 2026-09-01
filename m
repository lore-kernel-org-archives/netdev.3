Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D537E5C2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788240361; cv=none; b=C9SPYzFVbx2rVo94WdpREmpRkFhDg9ztAoxEZSPtC6NpK43ERe0c6ieOPAytlMYAtO9RCro/FH8gLVZdg3kD86Vx+KBYqYi3q4wb6Em0UfzaQ5T3+xQffZUesHz9wVaiH2s0OkMDFcAAhcxi2Pb8dKTMa/1LH9zNyE6b/VSIAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788240361; c=relaxed/simple;
	bh=AVFONoS/BfTAS9rsCJGqnKvi4dokM9XuDnnzAy7kYRo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlUFd0Vjx9Buw+58E0l1R2WLaR8L9RmY9DijVi8AsbMdf7o5RI0XKueexWHOGVgyyRHgw3CoxpADmT1UEqMBsGHCK+cRMTz2rtsuWqtTwwuCUzoYDXrP3mIXpdbXAvuokctXnq0wCgDUnDK3FJkHthy1Pf0ig3jgbf4NFy0Q/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R3hVkKWO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R3hVkKWO"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6810oqHo2737088;
	Mon, 31 Aug 2026 22:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=AVFONoS/BfTAS9rsCJGqnKvi4
	dokM9XuDnnzAy7kYRo=; b=R3hVkKWOrjCTw7SIbMY1sh/+5Byjkfhq6D5JoN1qr
	eevYUtpMjp/oDKEPMXn5dNzYhn5CNtVbi3sJlhFnUrMAD+wpfzBdRWTNd6XnqZTI
	Kq8txC8G+y9eFWFpOMT8tZQjUCwniKJ2j4W/5Fes8EYdV3t01NDTQ8UKjyDMHGrw
	YllqJgPPZNIwmqvF6Zmdc87eTjjVdR/uFpoHMsKZ5Y0e8JG6Kb+2UKhir4jicOg1
	1mtAM0uHQ31bGhIiOwjKk/zlPOyuNVSZWdGspm+KSIoY4yJnU3uit6A45QKUF18d
	fHaw1H9BcvEGFMOtY3QU4ZsDDsYoMzGKe0U8jf2bHoiyQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gdcy1agcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 22:25:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 22:25:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 22:25:47 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 957C15B692A;
	Mon, 31 Aug 2026 22:25:44 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:55:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Juuso Rinta <juuso.rinta@nokia.com>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] octeontx2: use dev_err_probe() for deferred
 probe
Message-ID: <apZh0hMqUJp2i5XD@rkannoth-OptiPlex-7090>
References: <20260901-octeontx2-dev-err-probe-v1-1-1b5e1affb994@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901-octeontx2-dev-err-probe-v1-1-1b5e1affb994@nokia.com>
X-Authority-Analysis: v=2.4 cv=W9MIkxWk c=1 sm=1 tr=0 ts=6a9661dc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=9qxNCY_qAAAA:8
 a=M5GUcnROAAAA:8 a=3g68egSbajkMjAmWKiQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: E8MY2hdFM1AJLrJh93nMVD1Gvnv3uPp-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA0NiBTYWx0ZWRfX64gw/kcW3GjZ
 y9QvFU9yOSM5mjWvHXKxGfLG2AUxC4PKRVAjPdndTJZ/LHFrWWjA1H2VdUW53DYpPQmL6U4scIl
 0TaWr0tEzRbpwLD9qD9lnoLwHlRWC26gdNGqKtL1kW3S7aX4W+NWCIZHWPBUMjUALIYeF2Pch5u
 Y8/tq28to8/nxklIuoeVWPtMkYhaws2OfFdezszd3PmJ2IrpKlOkQ8edR7EMO2Tq9NmYMfP6xeu
 niAQ+mI9lrpBV+VXpqMT34gljWW+JpHVF78EsVyXTl9DS0ek+Ij3b1W9SUEMW8nxvjXIcugRo6c
 tw5zbTz04bfRrfLdezvbrdCzYWTXpnA6xPMeu6Y5ERAcIH+r0gH/rX+1h+4FBTyn8Jn/X1FKtzR
 LSmmYhlHqPR3Pf24MLYV4QVTDWGjpSYZnDRpwgZS0wIMQooxFkJdBqpxxwaHyr601xdBY5PBdkn
 ew+wnvFzqt5FnZsvTQA==
X-Proofpoint-ORIG-GUID: E8MY2hdFM1AJLrJh93nMVD1Gvnv3uPp-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA0NiBTYWx0ZWRfXzBCPzlqlzIe1
 XiIz3L5ows1XmJd5/+RzU4drlujROUXK1hUDzOTlXM391hY+JFNLCaftdOs/HlWxhPMblzXMK0x
 g+/6Ay1yvFhEsGhaPTKd1mgnHHnMamA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01

On 2026-09-01 at 10:47:36, Juuso Rinta (juuso.rinta@nokia.com) wrote:
> The PF and VF drivers warn and return -EPROBE_DEFER when the AF has
> not programmed the RVUM revision or does not answer the mailbox READY
> message. That is expected until rvu_af has finished initializing, so
> the warning is repeated on every deferred retry.
>
> Use dev_err_probe() instead of dev_warn() so the expected deferral is
> not printed at warning level. -EPROBE_DEFER is logged at debug level
> and the reason is recorded in devices_deferred.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
Acked-by: Ratheesh Kannoth <rkannoth@marvell.com>
