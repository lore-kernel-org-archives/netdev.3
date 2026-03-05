Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B287335067;
	Thu,  5 Mar 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717865; cv=none; b=MjSKKI4TWwkMAX4MA/lkU40+JQJx+CriIUV83jmL9AcZhcXnAAlremOsZbnh8UlMfmj3xvigwUrjLO8qqEpEi91om7wlF6jj/FzO6k2yqnQyPGYKHuNRpDCHdfHpgxZuA5w4sVNz28AwMngbobogoBV/8+TA0f5UZJK1Bn61Hwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717865; c=relaxed/simple;
	bh=Zoo9K0JCQvryXYqjaMH7ObSDIuIkFy8kKsKhvL8lbUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmmMMO7DQfCJglI6VbvvGWcgR02LlZ8IlAzJU5un43lTp5W8rpJ1Vnk+MboXsXplZg6chafQL5H+MffDcivN29kg2Wp4iTrCazTtqJfpak0VJ04yrgzabQJi2evdWTfxq+WtbBcfWuKo9eILFiMfex6X07bxYZOz1R0dHNCgaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5CnnJAUK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5CnnJAUK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=XESuf6XLwQGyf9m68hasWvWx4OD03kNjZFRHtTDQGNM=; b=5C
	nnJAUK6B1NleH+QjmtKsUk3XPJgdFGepMpci/d/ubbKzf7jmX1XRgvp6FthW3MPmw7Y+OkF5EBcck
	/HqX0u27CH9Sq6hvh4RASqb4oRo/8xxrPfYhm6VHugK3KGTZW46Ltw8nXDULq+nHexzvEiX9Xuvu9
	gIuZ6OKPY2RyGdk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vy8tQ-00AJts-RU; Thu, 05 Mar 2026 14:37:32 +0100
Date: Thu, 5 Mar 2026 14:37:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bcmgenet: fix bcmgenet_get_eee() clobbered by
 phy_ethtool_get_eee()
Message-ID: <d352039f-4cbb-41e6-9aeb-0b4f3941b54c@lunn.ch>
References: <20260303153918.538902-1-nb@tipi-net.de>
 <fd675389-b044-4783-be16-c5ba34163ef2@lunn.ch>
 <a899e5a0addb1e58d47fb7f41e4d8a55@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a899e5a0addb1e58d47fb7f41e4d8a55@tipi-net.de>

On Thu, Mar 05, 2026 at 09:50:29AM +0100, Nicolai Buchwitz wrote:
> On 4.3.2026 22:57, Andrew Lunn wrote:
> > On Tue, Mar 03, 2026 at 04:39:18PM +0100, Nicolai Buchwitz wrote:
> > > bcmgenet_get_eee() sets the MAC-managed tx_lpi_enabled and
> > > tx_lpi_timer
> > > fields, then calls phy_ethtool_get_eee() which internally calls
> > > eeecfg_to_eee() — overwriting eee_enabled, tx_lpi_enabled and
> > > tx_lpi_timer with the PHY's eee_cfg values.  For non-phylink MACs like
> > > GENET, these PHY-level fields are never initialized (they are only set
> > > by phylink via phy_support_eee()), so the ethtool report always shows
> > > eee_enabled=false and tx_lpi_enabled=false regardless of the actual
> > > MAC
> > > state.
> > 
> > I think the MAC driver is missing a call to phy_support_eee() to let
> > phylib know the MAC supports EEE. Have you tried that.
> 
> Thanks for the suggestion. I've incorporated phy_support_eee() and tested it
> with a Raspberry CM4.
> 
> After applying the patch, the PHY correctly advertises EEE, negotiates it
> with
> the link partner, and ethtool reports:
> 
>   EEE status: enabled - active

Great, so we are going in the right direction.

The whole point of the reworking of EEE and putting as much as
possible into the phylib was that many MAC drivers were broken, and
the behaviour between MAC drivers was inconsistent. I had a big
patchset which converted every MAC driver, removing nearly all the EEE
code. Unfortunately, not all the patches got merged, and we ended up
with some MAC drivers in a half way state.

Please look at removing all the state tracking in the MAC driver. When
the adjust_link callback is made, look at the state in phydev, and
configure the hardware based on that. As an example, look at

https://elixir.bootlin.com/linux/v6.19.3/source/drivers/net/ethernet/freescale/fec_main.c#L2129

	Andrew
