Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24B34F27B;
	Wed, 30 Sep 2026 00:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729905; cv=none; b=GO9q8jOPTan5fM7cgo6obz2qn0XSpeEi8p6p/xIXkMKBMKbx6fB6OJ9v9v9LAL9YfmV4VP87cGvIoBn6/7n0HydWZNclweWYKCFaxHaaQ6doax01BuL6KmbPBgoZsgkQpJk+tPyF5ZLd0oXqT9UO4ArsSbzqQYIfvbwOL/sSKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729905; c=relaxed/simple;
	bh=pmAiggWjL2aGkquvyE/EXXdxNZEvE8tNTrj2rPHn7q8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDZOMiWiSbviXlgU+v7h0t+ET3WkPbdyfCYEpD1tlXFQpniSAuxG9LxZqnupYYRJ0nH7KDMZwal1j4lT/qAz55Te3k38crMvXbGZUuUyTNm/yFDH09GQNaUbhkeeb6wscNfBOpLymjnEQKMZt7U6ti12q+AzJkVO+liYAXaYU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXjC/wR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXjC/wR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1E31F00893;
	Wed, 30 Sep 2026 00:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729903;
	bh=MOM+JKS4bVT4HOxw48Ck+/8D3FhgTqP1AsMCixmrUfk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CXjC/wR/oUPyLpRmo7IohSy4qYQMDhlsvQPPEFWgX0GSuSNZBrMuY5jVdWG+LSC4Q
	 65CUJtmzSN5LNl+4f3FTSVelSvgD+fI8Pk9AKenffBVXkrIhNI+dQJUdf6dVovE6RW
	 pB0WAJDS0tCl0DetrWovdoR2OMSKz6SWzYKSugGKF/wgpzVIx+p7gTJZ3wlq8Y+/EY
	 LTwe888MWO1wsRhM0KywX8WqkDOzSN6ewKrTRWjisLMIL4rEk+FWqSjONd2XmBnAQ8
	 Lf+JN0Ri+7kO1wHihLVQ2ioAw46Fk0jpDVAgwELB2e2sk4ot7LYVn8ttKYLA7wT1A5
	 TmCTjQ8Uc00yA==
Subject: Re: [PATCH net v12 3/4] net: phy: take the interrupt back from the
 bus on detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, f.fainelli@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:58:21 +0000
Message-ID: <179072990181.434549.15084696930848727858@kernel.org>
In-Reply-To: <20260927235733.2619081-4-f@lex.la>
References: <20260927235733.2619081-4-f@lex.la>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In this patch alone ("net: phy: take the interrupt back from the
  bus on detach"), phydev->irq is restored only in phy_detach().

--

net: phy: take the interrupt back from the bus on detach

When a PHY is first bound to the generic driver, phy_probe() replaces
phydev->irq with PHY_POLL, and the value is never put back. After that,
the PHY stays in polling mode even once the real driver binds. This patch
restores phydev->irq from mdiobus->irq[] in phy_detach() before the
genphy driver is released.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..a9c71a2861186 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1965,6 +1965,8 @@ void phy_detach(struct phy_device *phydev)
>  	 * real driver could be loaded
>  	 */
>  	if (phydev->is_genphy_driven) {
> +		/* The release below lets phy_probe() write this field. */
> +		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];

[Severity: Low]
phy_attach_direct() has a second way to undo the genphy bind, and that
path doesn't restore phydev->irq.

This patch only adds the restore to phy_detach(). phy_attach_direct() can
also back out of the genphy bind:

drivers/net/phy/phy_device.c:phy_attach_direct() {
    ...
	if (phydev->is_genphy_driven) {
		err = d->driver->probe(d);
		if (err >= 0)
			err = device_bind_driver(d);

		if (err)
			goto error_module_put;
	}
    ...
error_module_put:
	module_put(d->driver->owner);
	phydev->is_genphy_driven = 0;
	d->driver = NULL;
    ...
}

phy_probe() sets phydev->irq = PHY_POLL before steps that can still fail.
Two examples are an MDIO read error in genphy_read_abilities() and
-ENOMEM in phy_setup_ports(). device_bind_driver() can also fail.

In those cases the error_module_put path clears is_genphy_driven and
d->driver, but phydev->irq keeps the PHY_POLL value. If the PHY device
survives and a real driver binds later, the PHY would still be polled.

The next patch in the series, "net: phy: restore the interrupt when the
generic bind cycle fails", closes this gap. It saves phydev->irq in a local
at the start of phy_attach_direct() and writes it back under
error_module_put. So the gap only exists between these two commits.

Would it be worth folding that change into this patch, so both genphy
unbind paths restore phydev->irq in the same commit?

>  		device_release_driver(&phydev->mdio.dev);
>  		phydev->is_genphy_driven = 0;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927235733.2619081-1-f%40lex.la
