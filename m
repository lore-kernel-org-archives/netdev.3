Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA404757EA;
	Wed,  2 Sep 2026 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307782; cv=none; b=C9u0fZ0+psQOrWTrWMpWIS3LpjtWrr/1FfmHsRRpknTzOXW4C258hwguCK4J1GEdNQ49DscxnBiHypmPX51lHdYPVtheXZJbAzG2cpPytGcr+TG4Rkg3lsteQfSYPlqa2Q9RFuo5ahgPA9SCHPfsa0QxeYNNWQhR58jngN2DvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307782; c=relaxed/simple;
	bh=/zwMQ/cAeP5IOyzjNcRGLCbhG9Fe1eiB4J1e2GtDbBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw7NITf6W9ngO7dYANFPh6k+7Lwby+eeSmOyGuNaHX0vKIaRf6UwHYUe2trO4GY863xqPNViFdjmt5ISKgcvsJuuiy/DMHkCAsIg6UFYLokSQuMigK/+sHeKtTgVEfoSyiRk+zhd72OKAOJPCQrSwT58GYmnIDO1ICpHH3iD6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E8zWanVI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E8zWanVI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/k1fv/ioL3A/z/vJhZdCTNI4YevGFMCYnRsJP4axb4g=; b=E8zWanVISqLgUKRN/IAppDsW0H
	KYA1C4I0wfQC7KS1/LZmPDr0mUiUmkbQ/Hg/C2iANhDKCJLHhsrfQI9XkQBxkS9WSJS9FAzujwjct
	qwbhs4INknjuolqAsJTMntt0HNqmEbmZUBb/5GuMejlWaSMTClnKzLb7iFVRGDJqLObQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1YXh-002RXF-0b; Wed, 02 Sep 2026 02:09:29 +0200
Date: Wed, 2 Sep 2026 02:09:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 04/13] net: phy: add phy_detach_internal()
 helper
Message-ID: <8675bbee-4850-4110-a0e8-05169a066a49@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-5-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:30PM +0200, Markus Stockhausen wrote:
> For the upcoming MDIO bus notification enhancements the PHY detach path
> needs to inform the bus about these actions. Until now phy_detach() is
> used for the regular detach path as well as from the phy_attach_direct()
> error paths So in the future there must be a clear indication if a
> notification is needed (normal path) or not (cleanup path).
> 
> Carve out the phy_detach() code into a new helper phy_detach_internal()
> and make phy_detach() a short stub that calls the new helper.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
