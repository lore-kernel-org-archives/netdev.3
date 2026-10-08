Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1EC40F721;
	Thu,  8 Oct 2026 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460861; cv=none; b=JVp0LM6KA89a5iSN+9y8r++oiYUp3tkM0v/iblUH9gOW8RLQ5nUebG69QgjjNoi5lEnnyL5ig1LjI9r2h/DOq5z9l1TcqQkcLl6+muuVEWn564F2SyH0fSy02aYY5KzP/u61pusODU0ClQzS6N5t1eTQDFLBABtbmtKjnK9+YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460861; c=relaxed/simple;
	bh=Hb36kFskHaahcRk8dek5fMrGjCsoNlLRLItDtpm6Gcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRWulxks33PpeN4Em7QP1j3FdwiqiSUt454gkNM0HpKJ0DKduEOUIGghNLCidyRnmRKEmnY4NB//Ee+/fWt+w0uFkuljBiO9+LLcAPsV79g3+sKipPMgsUgU/z8N5qgcUmYZTmR2f5Y3MQheQiG/KjT2cxOszVqm8/VEmRMoxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VdjRRaQ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VdjRRaQ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oShXdMoEXBcIjF76ZeZ7Tr5vt14coB3TSGREebLKc08=; b=VdjRRaQ5tZWcg3nN2EDWsu/mht
	IBAfs/Xj0fw+ojMXtiG1W/bP9eEpNUsrEmS6bsuJcLicn3CnFGoWNg6fYLVkaBr8wgmp2Ly5CNPHQ
	CeoQV5ylVLGjPjOLDNDpBBBl+qvxc9vQDLQg34hS2ApMjhUXVWJmJnN6RbhMBVDkG1oQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEmni-009cUo-7M; Thu, 08 Oct 2026 14:00:42 +0200
Date: Thu, 8 Oct 2026 14:00:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQw==?= =?utf-8?Q?H?= net-next v2 3/6]
 net: ftgmac100: Enable AST2700 RMII support
Message-ID: <3eff4d4c-7376-4fc1-983e-396ccda08ef8@lunn.ch>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
 <20261006-support_ast2700-v2-3-36de51fb8066@aspeedtech.com>
 <268b6bc5-40a5-47b4-99a2-68d9f56b359a@lunn.ch>
 <SEYPR06MB513454E3CF42CCB62402E7F59D932@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513454E3CF42CCB62402E7F59D932@SEYPR06MB5134.apcprd06.prod.outlook.com>

> The applications of device tree in ftgmac100 have 'use-ncsi', 'fixed-link'/'phy-handle'
> and legacy mdio probing for AST2400/2500.
> 
> The 'use-ncsi' will bind a fixed-link phy device on speed 100 and RMII, so it will include
> phydev for netdev.
> The 'fixed-link' also bind a fixed-link phy device for phydev in netdev.
> The 'phy-handle' will return the actual phy device instance for phydev.
> The legacy mdio method also returns phydev if the MAC node includes mdio in dts
> and find the phy device by mdc/mdio.
> 
> Therefore, in the current code, the devices tree does not include 'phy-handle', 'use-ncsi', 
> 'fixed-link and 'mdio' properties, the ftgmac100_probe_dt() still returns 0 as success at the 
> end, and the phydev in netdev will be NULL.
> 
> All applications in ftgmac100 must get the phy device handle, regardless of the actual
> phy device or the virtual fixed-link phy device.
> 
> I would like to add a patch to adjust the ftgmac100_probe_dt(), once the
> device tree lacks one of them will return the corresponding error or no device error to 
> make probing failed.

You cannot cause regressions with existing device, e.g.

aspeed-ast2500-evb.dts

&mac0 {
        status = "okay";

        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
};

No phy-handle, no use-ncsi.

So enforcing these must be limited to 2700.

It looks like you can test that some sort of PHY has been found. But
then please remove all tests which check that phydev is not NULL. And
include a good commit message why this is safe and will not cause
regressions.

	Andrew
