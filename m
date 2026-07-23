Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431817A31E;
	Thu, 23 Jul 2026 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784768288; cv=none; b=uT1OmjNwwZHwMf0tEGH9RXoWogoIMz9q9ohJeweczPHESpgL1MOBardCe24n0MKbO8h/kr44jaFcc6NjOppXXSsEFgq/NAC4OWG1j7X4zhz3H2ZNP/nhhke5+u3dO6jkk1Y4PuCFf+exjRMo7YRurStgY8gPWh+ZlBue2lTxJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784768288; c=relaxed/simple;
	bh=5BNdw2EXgasG40EOAWt9w2sU+KP+UqWssPywcj+gC/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA80/qzhlNrzVAQLcw/go+2F8Kjo9Fc92OEZyHYTRLNkjKHu0kJk6OYHs3dXDoQKZmY2EkEPNoo7ftUzwrMS01pbokPDCrvu1z0sgjqNRJKq1nMe0lawCir/GIrZ2UDouSFbFxXf+cUqAOCB4LfghJJsVBfgXr3uQ2UdyaLPxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A3LplZ5s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A3LplZ5s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VQsv4Cb6M3k2U1c2wyVmuXApCPwJsa8VXvuN2LpWab0=; b=A3LplZ5s0ulvKRNc0grhCc4bPP
	P6zmvm1aGQBvRXNojCcRP+GPReyHflp7SKaEpq7d0sVuBsi6UZ3ipjt79lOYmsefiCn5pcl8iw+sM
	zJDPlcJaHb6TD4vk52k9x+baEBR/7ekJYjtvb+ai0YWse0dYjTvOTHx2A9lneApq2ctM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmhks-00Dibi-Hw; Thu, 23 Jul 2026 02:57:42 +0200
Date: Thu, 23 Jul 2026 02:57:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v7 2/7] net: phy: phylink: add helper to modify
 pause
Message-ID: <8a90be50-8a45-4a27-a0a7-adfd1156c30e@lunn.ch>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
 <20260722022906.271-3-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722022906.271-3-javen_xu@realsil.com.cn>

> +/**
> + * phylink_update_mac_pause_capabilities() - Dynamically update MAC pause
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + * @mac_pause: the new MAC pause capabilities mask
> + *
> + * This function allows a MAC driver to dynamically change its pause state,
> + * such as losing/gaining Pause frame support based on MTU size.
> + * It recalculates supported link modes and triggers renegotiation if needed.
> + */
> +void phylink_update_mac_pause_capabilities(struct phylink *pl, unsigned long mac_pause)
> +{
> +	struct phylink_link_state *config = &pl->link_config;
> +	unsigned long old_pause;
> +	int pause_state;
> +
> +	ASSERT_RTNL();
> +
> +	if (mac_pause & ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE)) {
> +		phylink_err(pl, "Attempted to dynamically change non-pause MAC capabilities\n");
> +		return;
> +	}
> +
> +	old_pause = pl->config->mac_capabilities & (MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	if (old_pause == mac_pause)
> +		return;
> +
> +	mutex_lock(&pl->state_mutex);
> +
> +	pl->config->mac_capabilities &= ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
> +	pl->config->mac_capabilities |= mac_pause;
> +
> +	phylink_set(pl->supported, Pause);
> +	phylink_set(pl->supported, Asym_Pause);

I don't know the phylink code very well. Could you explain why these
are unconditional? It is not obvious to me.

> +	if (pl->phydev)
> +		linkmode_and(pl->supported, pl->supported, pl->phydev->supported);
> +	else if (pl->sfp_bus)
> +		linkmode_and(pl->supported, pl->supported, pl->sfp_support);

These lines are masking out pause if the PHY or SFP does out support
pause. But where is pause masked out if the MAC does not support
pause? That is what i'm missing here.

	Andrew
