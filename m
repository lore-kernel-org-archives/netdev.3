Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C43343D64;
	Thu, 19 Feb 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521198; cv=none; b=SD7n7fDgIAazWE+f+HZqKUvzfOlxKKuSOwtIDL6w+NFcsNGnYEq4gmJmVUyxUtE3vzCbFneC0EMxLWblfY8Zr1QsBYYND/biRxI8JM0SFbx33VoG7mczu2cZIBpH00oEWGkP/bBmc9ik0mNw2l04scurZFRP3qT5FOyP8LEDlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521198; c=relaxed/simple;
	bh=KQyrX/4nRonuD7ep0S1AQdj+eEhngN9HecBFazReEtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq7aM2zOQ5ipb18jBQkGvxFfHXm+BOubjF46H37ytXkP0dJF8vLXtAykSYzwj9MIXZnXiHnpn5QQg6vEBo2jbY+vfsanYk8ysKCWuQJIXVFanUnNibSZfdbBiY8iDXI6Bd3n0WQ6nim2SNMSPIwQQJ0FlQRIcNUZyX+rua64j/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jsOLrC1k; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jsOLrC1k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kwii5PhtQiDgJHBhdr912xjePXvLsCHh353/wV7cYNw=; b=jsOLrC1klsYiofgUAhVpkNCnez
	VZPlheTJJPdgMK15EUbUT+LjW22MJLr1CvUwPVhgqaP5Rxy8vkuWaoJQrqbEk4yGIX7VDLNZc6GNb
	OcTcqhOA8OVQxpFzfcnLCNtd9111J+q8tnsAiBnW3STXw/1rHOYYZm9reZ8CNi+anCnaUZOlX/ke1
	PPmx5NYHvPiWntCTNS8Oxh10GwHnaBf8TiRQqclGVB70QCLldiReOPiezJwxH25VYvS4J8C8g1bDO
	1OdviJBoWCDhBe7GDt3GiFaGgWK+UDkEHuyKeBgkjpbKsCjfyb3ysz+YwK9y647xiPZq/TPL+9wry
	up+kkjzQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vt7aM-0000000017F-4C31;
	Thu, 19 Feb 2026 17:13:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vt7aI-000000003Um-3jR3;
	Thu, 19 Feb 2026 17:13:02 +0000
Date: Thu, 19 Feb 2026 17:13:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aZdEnm9Vlb41T_DT@shell.armlinux.org.uk>
References: <20260219170113.1774090-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219170113.1774090-1-charles.perry@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 19, 2026 at 09:01:11AM -0800, Charles Perry wrote:
> @@ -574,6 +574,25 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
>  			   const unsigned long *advertising,
>  			   bool permit_pause_to_mac)
>  {
> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	unsigned long flags;
> +	u32 old, new;
> +
> +	spin_lock_irqsave(&bp->lock, flags);
> +	old = gem_readl(bp, PCSANADV);
> +	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
> +	if (new != -EINVAL && old != new)
> +		gem_writel(bp, PCSANADV, new);
> +
> +	old = gem_readl(bp, PCSCNTRL);
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		new = old | BMCR_ANENABLE;
> +	else
> +		new = old & ~BMCR_ANENABLE;
> +	if (old != new)
> +		gem_writel(bp, PCSCNTRL, new);
> +
> +	spin_unlock_irqrestore(&bp->lock, flags);

What purpose does the spinlock serve?

phylink will call this under the phylink state_mutex lock, which will
guarantee that two threads can't execute this code simultaneously.

>  	return 0;
>  }
>  
> @@ -628,22 +647,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
>  	if (old_ncr ^ ncr)
>  		macb_or_gem_writel(bp, NCR, ncr);
>  
> -	/* Disable AN for SGMII fixed link configuration, enable otherwise.
> -	 * Must be written after PCSSEL is set in NCFGR,
> -	 * otherwise writes will not take effect.

This looks like a key piece of information that is being removed from
the driver. Might be worth keeping it as a note that macb_pcs_config()
will be called after PCSSEL has been set in NCFGR?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
