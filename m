Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1682E03F1;
	Wed, 12 Aug 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516400; cv=none; b=iKdcD22D0kPscBWguaKAgYfBWYUoP0Mm9oNKKvPeHvMXV7Hl9tzkFkP2qN1HU4OmRo0hKokdUj83tnBFta7meR4hkqeY0ly5S3rMrMSh8qhbINafNKjAq7FIryfHwRFKo+zaP4YopieNbI9+j5sam3nhriq3Hso2ZQEd2EBbvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516400; c=relaxed/simple;
	bh=wvCbDOcOjz+2HmsK33nUcUtHJd+kX5x5LG2cV99MWpA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR0iXzVGgsIpBvNKpVftolh6UNrThGrTrMixdVncy0mvd+c54HsIUDsCO9otw9i0SElU1XkBEgejql9TwMGxRx4597qPkC8qKaOW+dsKvqwSTcbvDFgZ+7Z3dC6b7azAtly8U3YYWL8aFwdkUpcfifXhRFyVDLKHz6bHpYD09+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LCQclR22; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LCQclR22"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C61Wt51075123;
	Tue, 11 Aug 2026 23:32:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wvCbDOcOjz+2HmsK33nUcUtHJ
	d+kX5x5LG2cV99MWpA=; b=LCQclR22j7dVmrrmoVsq6sn6sN9sEUP5FCS09iFrS
	mzrbJZZMiEm1vMwVzPWOpyrYxEUNMEc3B3a1+QoswpCM0KE1PYpgvdajCMfXGvOF
	E1qubjDPnTmHXsrRoQzXHlryV6USaZ1hmzWTWEn4jWlBs3YtUU3YPsNrrqDOdshr
	DjfbIqroRibBOD9+GlYFae0hRMctsWSlA1cCgShQWxPOwygcwnn241Lqg+ouSPts
	llptVu2lHe6u7LkI1r75H0zXk1pY6nfuVmneWK4dowXXTmJH2dusAsWo4K1p5Rif
	wOibrVG8n04ou5aZxyH9PDDekwLivNB+ofKDuguAKslwQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fyjvyxnxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 23:32:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 23:32:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 23:32:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D2DC43F704D;
	Tue, 11 Aug 2026 23:32:44 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:02:43 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-af: initialize lmac_bmap in
 rvu_mcs_set_lmac_bmap()
Message-ID: <anwTi3zKvZI3DuNe@rkannoth-OptiPlex-7090>
References: <20260812060730.6181-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812060730.6181-1-kmehltretter@gmail.com>
X-Authority-Analysis: v=2.4 cv=QJ1YgALL c=1 sm=1 tr=0 ts=6a7c1391 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=pGLkceISAAAA:8
 a=M5GUcnROAAAA:8 a=omuPv6vnvsWRjgGCDFgA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: PZRzwfn03Lj-8l3oz_8sSbvTfeDnICdo
X-Proofpoint-ORIG-GUID: PZRzwfn03Lj-8l3oz_8sSbvTfeDnICdo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX0TDPi6/fX1zu
 puZV58laqeiNLYfNj5SsSvis8PLkbVaUSr5LpyjDmxFUL2V3tOYLC2KX8oGnHCAzlR3V/dCpOaQ
 Q7Ru5z+GqGkAE5zh/BYupAwsrWvgsC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX7TET/az2KYi/
 t515cRfKprMKiWDHtZDcsuVD1D4/Axz0o/N2DiOM+r2+Mdr6GzCavGH0ZwVcQCB6DJSBudVqnwq
 40ZD/tm5mfFY1GU9v3OVcTeU7SYXZ6x9T/iCT+Jf4EYqGhlORLRbvdrmbqk3xCHwI+oIVxvKEFp
 +Uq+efrUo7vuROoVMqPpy3CH///648M2bPTmTuu5cwLNlSlXqzIcRDhABSx1JUOcBlr3hQUnLB6
 Su8MXrtLs7pqNpzUoghIlKE4BN+iykTfpvIdT1bk2pdvHE1ZKQnMoDmmFSJQov8627C1frIQWtV
 p7CT8eh3R647unnW/iYUfppauKDwRhgRaz/Y6FNbSYqhy3GrYJ9rqnjUxYxvOq8OsSo+UiMu3Tc
 8ZR0xfxkF2/NCmDmmeqBIlgNXGuIkUOuJZZAZz6uHr1eHyc5FkOzA8bVphRypg3/FqiM8x18h25
 N0Qep1mg1Pgyz5QKJkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01

On 2026-08-12 at 11:37:30, Karl Mehltretter (kmehltretter@gmail.com) wrote:
> rvu_mcs_set_lmac_bmap() declares lmac_bmap without initializing it and
> only sets bits for valid lmacs with set_bit(), which ORs into the word
> without clearing it first. Bits for invalid or skipped ports keep
> whatever was on the stack, and the garbage is stored into
> mcs->hw->lmac_bmap.
>
> Initialize lmac_bmap to 0 so only valid lmacs are marked.
>
> Found with Clang's -Wconditional-uninitialized.
>
> Fixes: ca7f49ff8846 ("octeontx2-af: cn10k: Introduce driver for macsec block.")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Thank you.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
