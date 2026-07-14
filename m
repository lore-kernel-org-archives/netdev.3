Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78373438BD
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069383; cv=none; b=RH4SsMHhkFAzoojtgp8pzR3lDtW9TJYIeirq/Qw7s6S1mU7fOe/UFq1WAPGaIbMeuEf1EGyH6nBooTxWcdBrFeFEbAEXKqbTkQjqc9+7NU9z1f3+U4+/lFwbpL9u39PUHUPRS4/TGLl1FTZQpMigmv8tC9eRDQiduvQKr65A7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069383; c=relaxed/simple;
	bh=ZDrpHTBUm1Rn6LxWraDOjPohEcFxzPW2bzWVTM5tMRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/HrmfaKu4CUrSpKz+fCRlKyQg0QguhUtL9mXmvvu5W3lntW8GTbcJVc1U9F7+6ie9uGaFBUgEMeLRmFzMdHOI1xgfYwFOci4adsb5lGVrA6128OF4rqlteYxfODayVnmAcmI3FH7yRswQoS75dYn9TTp2Dq6bKLtMUEk/i0+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SrIfeGWJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SrIfeGWJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ITT/4zjN4cVnbt0glFUSDPu5R/RjT52XbGfsiZLD+h8=; b=Sr
	IfeGWJVUGtBhITWOnsFfvyGGnXeaQ1Kk/W+P0h7kpYWgn70HYrsK19a+TZqhpsvFoUZnqfPYcxV1t
	4aC7ni1E5C/SEVagI6joTbTeg2dj3AgQV4C8/Wf2Lfw6IBgaD5wr9asxRq8wWEH2YivzhTn7He2sN
	hLKYxT64Xtwy/4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjlwY-00CGO6-Vm; Wed, 15 Jul 2026 00:49:38 +0200
Date: Wed, 15 Jul 2026 00:49:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
Message-ID: <9593fdad-af6e-411d-ab3e-1f5927bee735@lunn.ch>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>

On Tue, Jul 14, 2026 at 04:09:04PM -0400, Nathan Whitehorn wrote:
> The current PCS code unconditionally uses SGMII autonegotiation, though
> the hardware supports both SGMII and 1000BASE-X modes. Decouple the
> choice of PCS enablement from use of the SGMII mode when running at
> gigabit rates and announce to phylink that 1000BASE-X is a supported
> operating mode. This enables direct attachment of the PCS to e.g. an
> SFP.

linux$ ./scripts/get_maintainer.pl drivers/net/ethernet/cadence/macb_main.c 
"Théo Lebrun" <theo.lebrun@bootlin.com> (maintainer:ATMEL MACB ETHERNET DRIVER)
Conor Dooley <conor.dooley@microchip.com> (reviewer:ATMEL MACB ETHERNET DRIVER)
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)

You did not Cc: the two developers who know the most about this
hardware.

https://docs.kernel.org/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
