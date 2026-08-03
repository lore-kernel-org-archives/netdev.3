Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F95279792
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.209.48.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757359; cv=none; b=NhvOjJ09Nu5ZHliRj896hOtpT53JeOOAhXs5KblmlcX/A8qG1JsMSXvPrCy0hRIr3hdOVjtkJ6IIjBPpwwSpZFbD8yM2gjUD6g/ur6LATS+TWFaG3xhYuLdq9iv2lOA7x63g4hx6Oh5XbG0xedD8wgrjpnAR3rni9mP6l5dFFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757359; c=relaxed/simple;
	bh=4uuhAPuJZKcdonDvxmDGk83ekrv0i9PRCcTLq7p0L1g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EVL9rnSytJRDIq/3hUKKSxSxvbWyqmLOB2xadQDD3FTSPlqqfukSZfop9EUDfGg2wdRWE5XHwYmZ/jZN5z24itFONQV5qr/gVqk9DObt0HV+QNYJo4yGeCITKH/clBHPESGXpK8v16Wxn/QAmWO9lV8KgWe++co0KjkjfZ1rBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=ONd7aAcB; arc=none smtp.client-ip=178.209.48.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agner.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ONd7aAcB"
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 965055C2478;
	Mon,  3 Aug 2026 13:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1785757353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1DdxlBwrHhow3M3zV5emyY7loKO7p/X/7X6nqt7mAI=;
	b=ONd7aAcB6Urqy1LY7slTlTyEmPDB/b9NLqK0THmD5GYDWNT6fZ4IP1xPuq1dFQ2vaYVIo5
	zdjkLHFBzW3L8TPWq2Gxc03OfnbP7X2gX5JF9hkunRuVeTOm1DWmBNHuwl/UnjCclpbigx
	0fYOxKgBNggJlDja79HWuyplyyWkhh0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 13:42:31 +0200
From: Stefan Agner <stefan@agner.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Jakub Raczynski
 <j.raczynski@samsung.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v3] net: stmmac: resume PHY before hardware setup when
 opening the interface
In-Reply-To: <2d2cdcea-4ae2-41e2-afcf-713c569da0d8@bootlin.com>
References: <20260803095156.132827-1-stefan@agner.ch>
 <2d2cdcea-4ae2-41e2-afcf-713c569da0d8@bootlin.com>
Message-ID: <4031d44e9ae41bd8be845538d27f41bd@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Maxime,

On 2026-08-03 12:36, Maxime Chevallier wrote:
> Hi Stefan,
> 
> On 8/3/26 11:51, Stefan Agner wrote:
>> Since the referenced commit, changing the MTU on a running interface no
>> longer disconnects and reconnects the PHY; __stmmac_release() merely
>> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
>> is not enabled. __stmmac_open() then performs the DMA software reset in
>> stmmac_hw_setup() before phylink_start() resumes the PHY again.
>> 
>> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
>> powered down, and stmmac requires a running receive clock for the DMA
>> software reset to complete (the phylink config sets mac_requires_rxc).
>> On such setups, e.g. the RK3566-based Home Assistant Green with an
>> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
>> leaves the interface dead:
>> 
>>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
>>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change
>> 
>> In the field this is triggered by NetworkManager applying an MTU while
>> activating the connection, breaking networking entirely. The same
>> regression has also been reported on i.MX8MP and reproduced on SoCFPGA
>> based systems.
>> 
>> Resume the PHY in __stmmac_open() before the hardware setup, making it
>> the counterpart of the phylink_stop() in __stmmac_release(), like
>> stmmac_resume() already does for the same reason. phylink_start() also
>> resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
>> moved before the hardware setup since it may bring the link up
>> immediately from a workqueue, racing with the initialization (see the
>> comment in stmmac_resume()). For the regular ndo_open path the PHY has
>> just been attached and is not suspended, in which case
>> phylink_prepare_resume() does nothing.
>> 
>> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
>> Link: https://github.com/home-assistant/operating-system/issues/4858
>> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> Assisted-by: Claude:claude-fable-5
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for reviewing and testing!

> 
> Do you feel confident following-up with the phylink renames, or should
> I add that to my todolist ?

It takes me quite a bit of time since I am not much into kernel
development (anymore). I'd appreciate if you can do it.

--
Stefan
