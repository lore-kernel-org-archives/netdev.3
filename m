Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5257493657;
	Sat, 22 Aug 2026 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426940; cv=none; b=b9yXjrSZFA5wunxHu8iOqwursPnS1k0cCITMc0E3dSBQQnBMpmtITvbKXjfBu6LEqGzKHJUDQq/tIhdV8e69cmxWJsnuHQkpHGWYHz75vt6a1WvrisuR3uH7FerddIEUu2ZqAnydhlhvLlGk2YHKgGKT+zuWdnTpjfD1te/4lYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426940; c=relaxed/simple;
	bh=svzjsnXgaFonvlh2oA+OwPsyNa0I4WcvqW0r8g/u76o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeNjjAjStFoj0GJNevTWdiN7NnpVDba0s2iIDlcsE4YjXh57ybid0+m5swgiElKhgQCpU/F/2ovQUyNkuWOivM292dUnCLJmbTvPZnMUXs95C6u1NyT8/WbAgS6xCHfklNqL1auHDvzhnRkOWrFHPhElyeZPOVK913QrMdXsOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2nzkzaHQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2nzkzaHQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O+zplZxnc98hRCdVhAKqfcz3guOS6bNd8u7eRHP5kbw=; b=2nzkzaHQok1o3VlCOVuBwZ46+C
	u7qIGBo9SrQrBjua+tLjwRO1Rd1Z32/9nWE8oY14xbyjHwQnNQynfJB2snxQwdn3o4Nrrw4Eh4rMP
	1r1iR6UTm+OlbTlTl/9Er+Fnft8afZ4uqyCOEeyEQ4+3YtgpGNaNiRZCx121iGtxl8FQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxrOa-0013Of-Gu; Sat, 22 Aug 2026 21:28:48 +0200
Date: Sat, 22 Aug 2026 21:28:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: phy: restore the interrupt after a
 generic-driver bind cycle
Message-ID: <7e23f6a3-0fc0-4a6b-b80f-4bf70455e29b@lunn.ch>
References: <20260822155259.87146-1-f@lex.la>
 <20260822155259.87146-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822155259.87146-3-f@lex.la>

>  	if (phydev->is_genphy_driven) {
> +		/* Give back the interrupt phy_probe() parked when the generic
> +		 * driver bound, before the device becomes bindable again. A
> +		 * PHY that was in polling mode for any other reason had
> +		 * PHY_POLL saved, and the restore is skipped.
> +		 */
> +		if (phydev->genphy_saved_irq > 0 && phydev->irq == PHY_POLL)
> +			phydev->irq = phydev->genphy_saved_irq;
> +		phydev->genphy_saved_irq = 0;
> +

I _think_ it can be simpler:

int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
				       struct phy_device *phy,
				       struct fwnode_handle *child, u32 addr)
{
	int rc;

	rc = fwnode_irq_get(child, 0);
	/* Don't wait forever if the IRQ provider doesn't become available,
	 * just fall back to poll mode
	 */
	if (rc == -EPROBE_DEFER)
		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
	if (rc == -EPROBE_DEFER)
		return rc;

	if (rc > 0) {
		phy->irq = rc;
		mdio->irq[addr] = rc;
	} else {
		phy->irq = mdio->irq[addr];
	}

So if there was an interrupt in DT, mdio->irq[addr] has been set to
it. So all i think you need is

    phydev->irq = mdio->irq[addr];

And a comment.

    Andrew

---
pw-bot: cr
