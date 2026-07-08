Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D23AF656
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541581; cv=none; b=A4s39dyci+/YulYhuQtStsnD+zzpmcvAnVBbeChXNI6Tt53oEp4mMUjAJKPbqaU/Etbur1IQ3UbI9MrtiE68rSIZOWByJRpqrQAvJf31UCErnyTR7LVBw0utBKfAugk3VqQCgQv7Cf4Jw07GgiAVz7c3M+olWBktScYqNKH6+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541581; c=relaxed/simple;
	bh=8gR3mAJVr5wruz3+lrN1CWfP2dHht+Y18OTFdDiNBdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=RfiJkWWpxu9ayZEGlANzDGFgq0X0zCoars7jh16oa4RIrySm+woovXfdjoDxB4HoJ3oC9cciB9ukvKdKPKoDy3Mb/G7OjFWqAZfKjC+UHtxus1O8pYZQSY536fYEeQEKVh3gROfjNK4AEClT1fbMrgoRhSAV4YBDjKOVQpEiLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l17znRXq; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l17znRXq"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260708201251euoutp01dc6ae081b48589783c0a6ad6a92303a5~AaZv9yDYZ1331413314euoutp012
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260708201251euoutp01dc6ae081b48589783c0a6ad6a92303a5~AaZv9yDYZ1331413314euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783541571;
	bh=sWv5LKxiCTQpIMVM+IVYcM4I7ORaawMDktpdHx4zPLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l17znRXqJBIpPf6cjjGr1Q32ku3S781rc6bjt782uZXTBbEmU3c53fkGu8k+TsCC9
	 P0h7MIxa8mP4QLutbd8hUVPvLNwK0yT2/EGv74rIq74fB/xOOYYgflbJ8IHmvBF5wc
	 5Be2k21DK3b0BSfIzh/CqTNx+4hrbPsGswNll2Zs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260708201249eucas1p1cabc72998ab7481e285fda2a90c938dd~AaZuwfJNL2208522085eucas1p1G;
	Wed,  8 Jul 2026 20:12:49 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260708201249eusmtip220a824c2b3b58cd1a50f3f593e7a9924~AaZuEZM9B2195521955eusmtip2B;
	Wed,  8 Jul 2026 20:12:49 +0000 (GMT)
Date: Wed, 8 Jul 2026 22:12:45 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net/stmmac: Check for STMMAC_DOWN flag in
 all XDP paths
Message-ID: <ak6vPffCx2OYqWYW@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707174551.1264558-2-j.raczynski@samsung.com>
X-CMS-MailID: 20260708201249eucas1p1cabc72998ab7481e285fda2a90c938dd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_"
X-RootMTR: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
X-EPHeader: CA
X-CMS-RootMailID: 20260707174556eucas1p141142a61e5669032194f9eedf6393895
References: <20260707174551.1264558-1-j.raczynski@samsung.com>
	<CGME20260707174556eucas1p141142a61e5669032194f9eedf6393895@eucas1p1.samsung.com>
	<20260707174551.1264558-2-j.raczynski@samsung.com>

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 07:45:50PM +0200, Jakub Raczynski wrote:
> Currently STMMAC_DOWN flag is only set/cleared by stmmac_reset_subtask(),
> to notify driver to stop processing of TX/RX frames. One of these processing
> paths is for XDP, but it is only ever checked in stmmac_xdp_xmit(), which
> leaves all other XDP paths vulnerable to processing data while interface is
> restarting.
> 
> Make verification of STMMAC_DOWN flag consistent by applying check to
> all XDP paths.
> 
> Fixes: 8b278a5b69a22 ("net: stmmac: Add support for XDP_REDIRECT action")
> Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
> Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---

Sashiko AI gave review that has valid points, patch needs changes.
Please drop it

--
pw-bot: cr

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad52_--
