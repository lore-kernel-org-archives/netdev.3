Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729F3CA4AF;
	Wed, 17 Jun 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689733; cv=none; b=cLTbDkDDI0wGb7MzHcEhrBR1ywbfhQPHPGMXxHIv3sP7ZXwpumLMVUp7TfUdfIckseu+c/6kGogUQaRNPWHmbIDaSxgtKQqL03+Fb5/ca28bIWs/FyMc/tuN8HIKYEHjZoEKABscPM3TzrNHVyQHLBVoC9x9uc75r4/cudFZnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689733; c=relaxed/simple;
	bh=ivBiPZmg74a5nDxxY+eIGpOjAe64flnPwAUTBI4BEAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlEtvUCwQMiCRz39hon3lW+kZzwlG4K5TNe4Kmv9FvC0yhkfJb9qWsy3eKKekCXV3S4wGn27XARKVx+lgNZVKnjqkdxgQSqupvqrZD05XWuc0y+3PQ9ayGNejXz2e5kFEo9notzSweMW9MrcSGJSpRxY4t9ZGBXhw94vUosX1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JhvsVpN6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JhvsVpN6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=51ctbLbHVsJZs66mKQaf/nxm/2hILs7lsh5HQTHfg+A=; b=JhvsVpN6ej2IBuFi+FcvUae3RP
	zJMn/wPTk55BILjvxpq/pWgh/RklBIZWU6pLfZ+Y3ns4Ra4TpC/QRfoXWVHYMwQlgfcl1WCbKwvL6
	U+VelxK06ddcOUHXFtm8pzgMnKoc0HBQDeX8lN3DfcsIqH3vdApWIcUEv0lQiVcBRDR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmsy-0089wF-9C; Wed, 17 Jun 2026 11:48:40 +0200
Date: Wed, 17 Jun 2026 11:48:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 8/9] arm64: dts: qcom: shikra-cqs-evk: Enable
 ethernet0
Message-ID: <621cd205-997f-49f0-bcc9-fa72ba1835a7@lunn.ch>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-8-f0f4a1d19929@oss.qualcomm.com>
 <2cb658f3-f564-4396-884d-d025eaa674a1@oss.qualcomm.com>
 <ajF+xlipLuZtf4HL@oss.qualcomm.com>
 <4f3c6bee-3ccb-467e-a466-89fece0e6a7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3c6bee-3ccb-467e-a466-89fece0e6a7f@oss.qualcomm.com>

> >>> +	emac0_phy_en_hog: emac0-phy-en-hog {
> >>> +		gpio-hog;
> >>> +		gpios = <149 GPIO_ACTIVE_HIGH>;
> >>> +		output-high;
> >>> +		line-name = "emac0-phy-en";
> >>> +	};
> >>
> >> This looks like a hack - what does this pin actually do?
> >>
> > 
> > The power supply to both PHYs on Shikra is gated by a GPIO pin. I am
> > unsure whether they should be modelled as a fixed, enable-on-boot
> > regulator or just like this. They need to be powered on early so that
> > MDIO can detect them.
> 
> If it's a regulator, then it should be described as a regulator.

Agreed.

> There
> was some discussion regarding the power resources of PHYs over here:
> 
> https://lore.kernel.org/linux-arm-msm/SN7PR19MB67369F7DD02F702437C0F1919D1B2@SN7PR19MB6736.namprd19.prod.outlook.com/

MDIO detection is nice to have, but only works well on simple
boards. I would suggest hard coding the PHY ID in the compatible.

	Andrew
