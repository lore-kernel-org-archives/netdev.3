Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2892F7F0F;
	Tue,  1 Sep 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280486; cv=pass; b=uy6R8/Tm4jeCzkkOxBXjd7fEGCJ9SWd28s6A+aR6DYt7nkkSIT4H96gvn+HSf27At7BkPK45NAeP2f1sV48RwReiKextA1BYbnHOYMKXPE75E9dostY8WM+bbJ+M0cWUzd8Zvya76AInBj0XSjIj/eJtnNzmQjdpcDbrukzTpbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280486; c=relaxed/simple;
	bh=zOkocXH0i4ruUrdQQi8zQJJT0RhOyE8LbiLmW7dsBqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBxt/4WmStSHyW5+ZXhtlr//AD7jJtJ8hx3nVzgsLNprlMqHlfxws1gbFBKGYGAcYnY/xtOtz5NLxLNF4/pfqV1RE2jwrmIxvAuEht1LGdHfdXx4Ga66YKEFoIPSOufUMCK9l0HDhc+S39QJTDQvHvMVcRuQiptKGh/Xbxicnc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=izm7AwEw; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="izm7AwEw"
ARC-Seal: i=1; a=rsa-sha256; t=1788280429; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jDxfWGQAvL0qTaX362S0GAKT1dNbUHBBeVr8edgQonH6NEK46AXLtAHx0aiOwZzyXXab+Qm44TuU7Fxi9eLpNJTEapcbWmsVYjnFqC5KXx9s6cU2F0H9y/FRmv7Uzh3iYQCKIrz+aNgkAkMlMcKarlWawh/TBDbq9MnhOgevCsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788280429; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aSzSwKdiOyhfRAmkgtryOTqsNj7Y6W/yZ2lJoe+sm1s=; 
	b=XmIgUJoS9mL+tg5zPsiBaeM9U5A6lvUkShybZDACb5DraepsMdvMch2O4vsHu8G3u0qEnPMELnIICJd4u+hvkhcWEiGLPexv24QHCdCcOaOxleXjrdi0hxh1dc6kSEupv+dJwIGBC2jkekV9ALTQNLl4kZLxqOe+4mBgRbXyyDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788280429;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=aSzSwKdiOyhfRAmkgtryOTqsNj7Y6W/yZ2lJoe+sm1s=;
	b=izm7AwEwUZ6Ix97/NfYMiLDMn1TgHl0z2BKTdbaFqJVSrDmvqMjesw+YuMC75pFY
	g6QPLjkL9oCTyynjVdUyNoLzhubLv2jaBeKS0OqCTrLeG7++9JVzX3x+s7UC4zNgCKk
	dbTFGmVe377NH04L7EHEMb0/SxXlzpaCMOOpQHXM=
Received: by mx.zohomail.com with SMTPS id 1788280425896668.4069042560614;
	Tue, 1 Sep 2026 09:33:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 16:33:22 +0000
From: Yao Zi <me@ziyao.cc>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, Yao Zi <me@ziyao.cc>,
	Frank <Frank.Sae@motor-comm.com>
Cc: thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 0/3] net: phy: motorcomm: Enable analog frontend
 DAC on yt8531S
Message-ID: <apb-UvaZYQljYJ5I@pie>
References: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.256.78
X-ZohoMailClient: External

On Mon, Aug 31, 2026 at 09:37:42AM +0200, Maxime Chevallier wrote:
> In the process of getting more stmmac boards to run tests on, I've
> acquired a nice and inexpensive YT6801 PCIe card, that can do
> 10/100/1000BaseT. It uses stmmac's PCI variant dwmac-motorcomm, as well
> as an integrated Motorcomm PHY (the YT8531S).
> 
> However while testing the card, I had link-up maybe once every 10
> reboots, and no traffic whatsoever. Comparing with the out-of-tree
> driver provided by Motorcomm, it was found that some Analog Frontend DAC
> needs a clock to be enabled, and indeed it fixed the issue.

As a side note, this operation was added between v1.0.30 and v1.031 of
the vendor driver, and we haven't observed similar issues with the
current YT8531S driver, so maybe this is a silicon issue only present in
later revisions of the chip.

If interested, you could find v1.028, v1.029, and v1.031 of the YT6801
driver here[1]. And REG_MII_EXT_AFE_CONTROL_CLKDAC_AON_POS was
introduced in this commit[2].

> As I don't know much about this device, this series implements the DAC
> CLK configuration in the YT8531S driver only for the integrated version,
> that uses the GMII interface.
> 
> I split that into 3 commits, the first 2 are splitting-out the YT8521
> and YT8531S config_init(). The third commit adds the DAC configuration.
> 
> This was tested on YT6801, which now reliably reports link up.
> 
> Maxime Chevallier (3):
>   net: phy: motorcomm: Split yt8521_config_init() page management
>   net: phy: motorcomm: Add a dedicated .config_init for YT8531S
>   net: phy: motorcomm: Enable analog frontend on YT8531S
> 
>  drivers/net/phy/motorcomm.c | 76 ++++++++++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 22 deletions(-)
> 
> -- 
> 2.55.0
> 

Regards,
Yao Zi

[1]: https://github.com/deepin-community/kernel/blob/linux-6.6.y/drivers/net/ethernet/motorcomm/yt6801/
[2]: https://github.com/deepin-community/kernel/commit/721c505713d104fe48a817e703936dfe583b8ae4
