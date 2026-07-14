Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01A44C67B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058242; cv=none; b=PGXPc2BU9EuS6g7+doeLZWanmYHfmCbSkTWupDFa0vUKTA0bF8LRPgQ6Gr3ZYr1VzfgdoXb7XTquL1N5hzIZuA+EWPYXVjlYnPSxWAnOHa/y9FblYvvNTopRAzYqlRaV0+5mWqG8Ruxf8BNzbDjbGXGtseNDeG0hgrl1RLeTV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058242; c=relaxed/simple;
	bh=hfmIioqGKc/JS/Qmc9V7zR+PnUCk9Rs5YO5oPQWPIo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlTpOfjZIpxjDJTcywp5osTREla5KU2BVgVew37UcEcFL3I80oep2vgtGq0Y/N8F23bEkqzWLu598BnT3PDOrtAFlr1E0odfEqIBlGBS7TsGrkxD4XbaDCMrgwM36C0jIJpYS3DaAzL2mVsfiYY61tqCwQx/fTOD0qdC0r9DSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cw5s2+E2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cw5s2+E2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tXnsQTSTE6NMQEYZcwv56hZqFayJEJ9NJIoO4YvphoA=; b=Cw5s2+E25RD5gMAd2ngvcqdcQV
	Ism2TS4W40+3dwav21aqoTAq3i65YgUabZM+rYKaZdh86cYTmSLBgZu3yYsgWfubX0OWTO4cLAOyk
	mgdihvtepHCSTLi21gOg3Ei+wIzltG3Z5j2nCm1QfbSBD+ItKcsVuMDSDXhoXw97bGJA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjj2h-00CF0X-Kg; Tue, 14 Jul 2026 21:43:47 +0200
Date: Tue, 14 Jul 2026 21:43:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	David Laight <david.laight.linux@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Das, Shubham" <shubham.das@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>,
	"Brandeburg, Jesse" <jbrandeburg@cloudflare.com>
Subject: Re: Ethtool is missing C2C link modes
Message-ID: <20dde8ba-5429-45e2-8071-ce83f1c2d6c0@lunn.ch>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
 <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
 <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR11MB6900984B5FBD60B71B3B8F329AF92@SN7PR11MB6900.namprd11.prod.outlook.com>

> Siddaraju: baseR is an end-to-end physical layer type that clearly defines
> 	the	interface & components stating from MAC RS(Reconciliation Sublayer)
> 	till the PMD + MDI signallings. AUI is an intermediate electrical interface
> 	layer(simplified KR) that connects 2 PMAs (PMA <=== AUI ===> PMA).
> 	AUI is a split function design approach where subfunction implementation
> 	from multiple vendors come together to exploit their domain expertise
> 	to produce a best Ethernet interconnect.

> Andrew: I _think_ ethtool reports the media, not some intermediary format.
> 	Is ETHTOOL_LINK_MODE_25000baseC2C_Full_BIT actually needed? 
> Siddaraju: We are here to find out that Andrew :).
> 	If we are following the strict convention that ethtool link modes
> 	report & represents the end-to-end flow "ONLY", then yes, AUI doesn't
> 	fit there. We are exploring phy_interface_t for intermediate interfaces
> 	and we hope we don't hit any roadblocks. Let's see.

Given these two answer, phy_interface_t is a better fit. I'm however
not sure it is fully correct. Historically, it was used to indicate
the interface between the MAC and base-T PHYs. PCS and PMD either did
not exist, or was an invisible layer, back in those days. At that
point phy_interface_t was the bottom of the reconciliation layer?

The introduction of SGMII and 1000BaseX made PCS a thing, even if
initially it was generally hidden away. PHY_INTERFACE_MODE_SGMII then
corresponds to the bottom of the PCS, with the Base-T PHY also talking
SGMII. phy_interface_t then moves from the reconciliation layer to a
lower layer?

So what exactly does phy_interface_t mean?

And historically, we have only had a single phy_interface_t value. Are
there use cases for needing different C2C values are different layers?
Could you have a single lane 100G C2C split into 4 lanes of 25G C2C?

Another thing we should consider. Most NICs above 10G currently don't
have Linux controlling the hardware. These lower layers are all hidden
away in firmware. For you hardware, is Linux actually controlling any
of this?  Are you adding support to phylink for these intermediary
building blocks? Should Linux currently care about C2C?

	Andrew
