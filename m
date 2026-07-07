Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836B941D4E7
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444816; cv=none; b=GUUGATUC4nmn3mtDvkN1VxAcPDtk2wGPDzRogBFWeY3wAhOBxDpzenEuZ5YmSytMixfq3mr9VzGb4knyv+5c1SpSJyxSDXG5FzDr6ippaNPS1WxPImRgLJpsM5fvP59avZWBCkihvSnbY1QkJQu7Oih72iquncKt8JnqKZmOYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444816; c=relaxed/simple;
	bh=8xuRa8GR7SNSg7JYkBtRlyuknSDddZS1P21tO0CXB9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=q6ZAGUzrrEiKPLcYRfXxhLI73j19ZcbpRM4PpS+B0HQPl/nKMo6y2nRNZAHUhPJ9xsNB9QRHnD5LqD9DQ+L2aoKxWLRX8eqrgfI89WfxG1CSnU45ot+IA0E/IKMk65qEa/1UePbin3zqX1aoPXpRm7hpX4mz3FokXh7tOggc0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Azih6pt7; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Azih6pt7"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260707172006euoutp02b85f3fd845f1bb4e527578cda6d01058~AEZo_xlAI2821628216euoutp02X
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260707172006euoutp02b85f3fd845f1bb4e527578cda6d01058~AEZo_xlAI2821628216euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783444806;
	bh=QpKQBpchK3a2sxtbJ+PPBE6TQGmnk2auepVRoSpN+HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Azih6pt7xspBi5zObnoHYr9Rk3f+x8nEtqKrALTiBhsv+GkLgmMg1tnMwBOgIb5o3
	 fvMLB/qlt066HDdEIejiQSooyXTbJA7G9VEk/+RDp+yNKY2DXFmtdAfdXSCJxKH6FZ
	 FSd029pA5EK/dpy4qs2EerBqm84WZeWRdX5E4vy4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805~AEZoOc2XK2332823328eucas1p2h;
	Tue,  7 Jul 2026 17:20:05 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260707172005eusmtip17abedc7f5d1d10048fed1712e887393a~AEZniO6pP0262802628eusmtip1S;
	Tue,  7 Jul 2026 17:20:05 +0000 (GMT)
Date: Tue, 7 Jul 2026 19:20:01 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Stefan Agner <stefan@agner.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Ovidiu Panait
	<ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net] net: stmmac: resume PHY before reopening the
 interface on MTU change
Message-ID: <ak01QZhCKkq2FM33@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707162146.73823-1-stefan@agner.ch>
X-CMS-MailID: 20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_12e94a_"
X-RootMTR: 20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805
X-EPHeader: CA
X-CMS-RootMailID: 20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805
References: <20260707162146.73823-1-stefan@agner.ch>
	<CGME20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805@eucas1p2.samsung.com>

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_12e94a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 06:21:46PM +0200, Stefan Agner wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5884,6 +5884,15 @@
>  
>  		__stmmac_release(dev);
>  
> +		/* phylink_stop() in __stmmac_release() suspends the PHY.
> +		 * IEEE 802.3 allows PHYs to stop their receive clock while
> +		 * powered down, but the DMA software reset performed by
> +		 * stmmac_hw_setup() requires a running receive clock.
> +		 * Resume the PHY, as on system resume, to ensure its clocks
> +		 * are running before reopening the interface.
> +		 */
> +		phylink_prepare_resume(priv->phylink);

Does it work without warnings? Nothing in dmesg?
phylink_prepare_resume() does have ASSERT_RTNL() which is not called anywhere.

BR
Jakub Raczynski

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_12e94a_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_12e94a_--
