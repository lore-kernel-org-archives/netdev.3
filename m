Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E89361960
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753404; cv=none; b=sXSo4T50mgYDDSQ0Z51GODnV2rR1qGuQF36RKYXpJPd6HvIsSz813zLNCfGn9YWzNtzLBoP57EFQeQAIjtEqt1JsjwvBL4jQCWtqnkyDWYTfmnhModNTK8V9/4BAuNmMcdJrF/4/YtwCgNFmTKrD+MUR9MuvG9ltQ5j9XndTIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753404; c=relaxed/simple;
	bh=wH8gtjg23MWFP7wjhOMNPqCq2i/wmy16iV1Noiml2kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpcy1nE8h0CkrMOaxO4Ani3uK0ZLfNinlSHX+Odc+Qj19QYP0JeIsu8LCQ5gCSGuqtxpdE8lBrKPVBYatyJ8LtpmYrRiwMF2EzSbs1xa9ZL8AcO3Dpth16bZYzuv9p+Ei5n2roioooMWks5wFtxj7coLat2jmDaWLVLvK3KhmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HMueVvAL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HMueVvAL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CDC971A13C0;
	Mon,  3 Aug 2026 10:36:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90A816029B;
	Mon,  3 Aug 2026 10:36:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6A9911C17E07;
	Mon,  3 Aug 2026 12:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785753394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+pdokkPVzgPFBzVdRB85NfTsXK5/pNBC/XNgzhJoYlo=;
	b=HMueVvALhJHd5ndRo/XSDiXdonqgg5k98nlCnQacw04wIeUmHw1X6yB9AuFmFIVTfGkde6
	WdGRRZOXZ2W57wU+enL62tPzG7IB/CxopJSGvhh/I6mLpRd/oc2ko9eJhM8ahLUCV4cmxl
	CH59sXV3sdNO4ADx4Tw6xRq/cuB2OFU7CvLlfg9bTRV168TII8VJtoKNRviis9Q2ZywtHT
	n8vLmD1de1EYltdHXVSrxwJDANJ5aXNfhoU7U/hy6fKreaQF+4ntLk1TryWIhVKT3vMN1A
	x64VphkxJI7uuf7ZPbcY/hfQxWKkbYEEoltuwmuiGz58gVIS3HEtc+fb5hIwcg==
Message-ID: <2d2cdcea-4ae2-41e2-afcf-713c569da0d8@bootlin.com>
Date: Mon, 3 Aug 2026 12:36:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: resume PHY before hardware setup when
 opening the interface
To: Stefan Agner <stefan@agner.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jakub Raczynski <j.raczynski@samsung.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
References: <20260803095156.132827-1-stefan@agner.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260803095156.132827-1-stefan@agner.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Stefan,

On 8/3/26 11:51, Stefan Agner wrote:
> Since the referenced commit, changing the MTU on a running interface no
> longer disconnects and reconnects the PHY; __stmmac_release() merely
> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
> is not enabled. __stmmac_open() then performs the DMA software reset in
> stmmac_hw_setup() before phylink_start() resumes the PHY again.
> 
> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
> powered down, and stmmac requires a running receive clock for the DMA
> software reset to complete (the phylink config sets mac_requires_rxc).
> On such setups, e.g. the RK3566-based Home Assistant Green with an
> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
> leaves the interface dead:
> 
>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change
> 
> In the field this is triggered by NetworkManager applying an MTU while
> activating the connection, breaking networking entirely. The same
> regression has also been reported on i.MX8MP and reproduced on SoCFPGA
> based systems.
> 
> Resume the PHY in __stmmac_open() before the hardware setup, making it
> the counterpart of the phylink_stop() in __stmmac_release(), like
> stmmac_resume() already does for the same reason. phylink_start() also
> resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
> moved before the hardware setup since it may bring the link up
> immediately from a workqueue, racing with the initialization (see the
> comment in stmmac_resume()). For the regular ndo_open path the PHY has
> just been attached and is not suspended, in which case
> phylink_prepare_resume() does nothing.
> 
> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
> Link: https://github.com/home-assistant/operating-system/issues/4858
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Do you feel confident following-up with the phylink renames, or should
I add that to my todolist ?

Thanks

Maxime
