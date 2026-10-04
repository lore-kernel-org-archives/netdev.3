Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5083612F1;
	Sun,  4 Oct 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124144; cv=none; b=Eo5MSZ8e3RiUTq+NkHJxs5ENiQ+R9uDg9EXvgson1PcdFeB9ALRPQe7HI6HjKGxsP30FtXX3suQSLVqNfItiN725DKOuSKzLiUTRnp9k2L5I3SHT4VhPY5TmvN4VBo0Py3oT6qQKDjcf5WGpiZMi/usWkr74qamH+bq/GWUUIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124144; c=relaxed/simple;
	bh=jvqY9C1m6k1yvxYxciFGGJEpFETDd/BbrpsZ1TJ7JLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK3Yt+ZQwrKyfkzLRZ6DDgXZ7T2PygglS8aFw3IcfUEgmtUj4z3bDGHhkprn1N5flMKYgW4NnUPViTeR0/A4WiaRlBVAANk4pvQByp+vrHZW16njqbaOqUVIJkxrOGYT3wOdjFnEgn6tl5BbaTBt1dRZURcW4RKXUA30gD+roUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z45qJ78Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z45qJ78Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z245fAs/pbqLMCoe2AJzXBFaiIR+VL+kA1UcOF8wmBM=; b=Z45qJ78Z87eX8yxcJR1ZweWIz0
	NDYg+9t8PKzXSKvddPPlgiXDY9mNDMBLHAK0pPOvaDZRDGDnYb7o2JDRH4AmlVLSePl0VPmagjsWj
	QBildE+FeoWPDmcDwlX8nrPW7hcFQUs88/O8uFoXDG5WCWn58N2UtVKpHYneCM1Q4Wao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDNCs-008tGD-Kn; Sun, 04 Oct 2026 16:28:50 +0200
Date: Sun, 4 Oct 2026 16:28:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Igor Velkov <iav@iav.lv>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukas Wunner <lukas@wunner.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: postpone PHY interrupts during sleep with
 MAC-managed PM
Message-ID: <281b1def-a8ab-4edb-b35f-a30dcdfdd38d@lunn.ch>
References: <20261002043548.1302145-1-iav@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002043548.1302145-1-iav@iav.lv>

On Fri, Oct 02, 2026 at 07:35:48AM +0300, Igor Velkov wrote:
> mdio_bus_phy_suspend() and mdio_bus_phy_resume() return early when the
> MAC driver manages PHY PM

One obvious question. What exactly does it mean when the MAC driver
manages PHY PM. Maybe calling irq_suspend is part of that management?

> interrupt that wakes the system fires as soon as resume_device_irqs()
> re-enables the line, before the MAC driver resumes, and phy_interrupt()
> runs the PHY driver's handler at once. If the MDIO bus was powered down
> in suspend, the MDIO access in that handler stalls the CPU.

Ignoring MAC managed for a minute....

As far as i understand, suspend goes from leaf to root. Resume goes
from root to leaf. With WoL, we leave the PHY unsuspended, and the IRQ
controller as well. But the MDIO bus driver should get suspended and
then the MAC driver. On resume, the MAC driver is resumed, then the
MDIO bus driver, and then the PHY. At this point, during resume we can
handle the interrupt. It can then do MDIO transfers, since everything
towards the root should be up and running.

What exactly is going wrong with the ordering in your case?

     Andrew
