Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E085349B7;
	Wed, 14 Oct 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994550; cv=none; b=bJGPXkPOn0Zj6tL+2f3EpUt/m6W+jfF1jy1meGUkbho5RNF6efUMuazmfk0bB0ajQC2NCD+QdSgUWgKR127xMPmgdyGRGxn7FkWGsNuYdftFPg+q45m3ijC94728RHW28tLpkWdKwFH7Nucf8OIH2nMLJNh6Dfnn3dS/z3nNKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994550; c=relaxed/simple;
	bh=MPLcZqa6fzuPy9x0waM6ogPIJTXb3ORNchEJ4xtsipg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEPwm9Op1FoEqdFW7/z4dJlysh7VklLSBZpfWeu39USHisgUi1582pfcefURnS+IYMnmSmw7JN6QePUuRAzXBBsYB3KT9BcKUi7PtTJridhfVeHbkopNTu3fXge3oYo06ymuxYr2O631ubGODvm8feHX3lqPTLsMNJWMv8P8rSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mDYdiA0p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mDYdiA0p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dZEA6KooYNG6WjmS3cwTa+yQzouVNKItatf4v7iDCqw=; b=mDYdiA0ppURJUvN8sGS0tk4pM7
	5Ii94YI15Z0hpjF7HL6eo42wiRxIpOuyQFUamW2veF97gO2lsea0l1Dp0C7KqUxH1NdstCEjrtRC/
	4utpxfrD44QZnOTCnMs6p7puHEFVlvM4ki4UqVw7IJjJIPjt0tGPzNssK99XMKjllUL8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH1dg-00AmDl-BK; Wed, 14 Oct 2026 18:15:36 +0200
Date: Wed, 14 Oct 2026 18:15:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v5] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
Message-ID: <6c488dc7-cfcb-4abe-8bbf-fc4e5359a6c7@lunn.ch>
References: <20261014002534.149200-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014002534.149200-1-rosenp@gmail.com>

On Tue, Oct 13, 2026 at 05:25:34PM -0700, Rosen Penev wrote:
> marvell_config_intr() rewrites the whole interrupt enable register, so
> the config_intr call from phy_init_hw() on resume silently cleared
> WOL_EIE on the 88E1318S and 88E1510: m88e1318_get_wol() still reported
> WAKE_MAGIC, but a matched magic packet was no longer routed to INTn and
> the board did not wake.
> 
> Bit 7 of that register is WOL_EIE only on these two PHYs; on others,
> such as the 88E1111, it enables a FIFO error interrupt. So give the
> 88E1318S and 88E1510 their own config_intr and handle_interrupt, and
> leave the shared callbacks unchanged.
> 
> m88e1318_set_wol() now records whether WoL is enabled, and both it and
> the new config_intr derive WOL_EIE from that state under the MDIO bus
> lock. WOL_EIE stays set across config_intr while WoL is enabled, except
> when the PHY has an interrupt line and interrupts are being disabled,
> as in phy_free_interrupt(): INTn is then the PHY IRQ, and nothing would
> read IEVENT after free_irq() to release it. The bit is set again once
> interrupts are re-enabled. phy_probe() still clears a WOL_EIE left by a
> previous boot, since WoL starts out disabled. The new handler also
> claims WoL events, so they do not go unacknowledged when the PHY IRQ is
> in use.
> 
> Helios4 (Armada 388, 88E1512), 7.2.9. With this patch WOL_EIE stays set
> over 3 link down/up cycles, "wol d" clears it, and a magic packet on a
> running board is a handled interrupt. Without it, WOL_EIE is lost on the
> first down/up, survives "wol d", and the magic packet is an unhandled
> interrupt.
> 
> Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Tested-by: Igor Velkov <iav@iav.lv>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
