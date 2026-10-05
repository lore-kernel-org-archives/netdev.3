Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82E344780F;
	Mon,  5 Oct 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206833; cv=none; b=h2Sx+qYhEs+G9IWHqXuCPaCPHi6wfcSuUt89GyOYGl+IkLTq/1nvbuY7cxW2Mpyi1s5Pncv8Ieh6JcJma1WBcnTsR1jlz3R1GyWPtiiBkfX+FLDgjg90ML4GR8tFapzEyNE4otO2dgD5NLE6DzjbjifZnvIUsN+gYVEl/wb2Bng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206833; c=relaxed/simple;
	bh=cOQRX7zlYK29AazHSlnsUCFvh5fQjnyuPjUrCAziMeY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qkMX1n+UnnLnBh/dl2FKCPT+ULbGx71QhQ+ARhdqTDnDBScpL+TQyyaLPCwbyQyIDGZlthBmDSXRCJHFgrMXLLRlpKkKF8Syu9A2y0AFMtQRgnUsi6eanUQ3jHERBtSLhG4iFwWBx1CMtVVjddnCPZfLhowxyNy1vwHIS82VMxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MatDQ2TZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MatDQ2TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121071F000FF;
	Mon,  5 Oct 2026 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206798;
	bh=tagE5Gg1FsrS7WWoiusWHMWvZZqHJEgLVoBN0QGwgR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MatDQ2TZQ3oBTlwLl4wRmWtXYSHAPKfWoCutznQnaLm/4B0TbOiNkvrXGSZMuqIxL
	 oqedWYwl9/j1Xlkb178ruCKbbwthUw4Y7fd/EKjaQ44JtM0C8mgR2y8cHmNZu31VXb
	 mVeKr5h8J+ksZhn56QilKDLm0pbL+7KFC+ukaLtokeyEssc18R89A6PK9iEG2GSBFt
	 dAQqdaEY2EO+7313QH/R01ZXZycFXWKtcskxM7RqntLkKdihjxG65w76LSnfIRJqgm
	 VVgtu3oeOp7Tu2cwhuPsSmE4tgyl9UCRxu01GhGduUvw1wBG9qZCkzmYiF+cGDzFY7
	 jCcQkZEjNJgRQ==
Subject: Re: [PATCH net v13 3/4] net: phy: take the interrupt back from the
 bus on detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, f.fainelli@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 13:26:37 +0000
Message-ID: <179120679761.434549.12466957475136887665@kernel.org>
In-Reply-To: <20261001130236.106059-4-f@lex.la>
References: <20261001130236.106059-4-f@lex.la>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this commit only, the interrupt restore lives only in
  phy_detach() (drivers/net/phy/phy_device.c:1969).

--

net: phy: take the interrupt back from the bus on detach

This commit makes phy_detach() restore phydev->irq from the bus table
(mdio.bus->irq[]) when the generic driver was bound by
phy_attach_direct(). It undoes the PHY_POLL substitution done by
phy_probe() for genphy, so that a real driver bound later can use the
interrupt.

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

[Severity: Medium]
This patch only restores the irq in phy_detach(). Is there a second way
out of the genphy bind cycle that still leaves phydev->irq at PHY_POLL?

In phy_attach_direct(), the generic probe and bind failures go straight
to error_module_put. That path never reaches the error label that calls
phy_detach():

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

phy_probe() overwrites the irq before any of its steps that can fail:

drivers/net/phy/phy_device.c:phy_probe() {
    ...
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
    ...
}

The later steps include get_features, genphy_read_abilities() and
genphy_c45_pma_read_abilities() (all MDIO reads), phy_setup_ports() and
genphy_c45_read_eee_adv(). If one of them fails, or device_bind_driver()
fails, error_module_put clears is_genphy_driven and d->driver but does
not touch phydev->irq. A real driver that binds later would then still
poll, which is the symptom the commit message describes.

The last patch of this series, "net: phy: restore the interrupt when the
generic bind cycle fails", appears to close this gap. It saves
phydev->irq at the start of phy_attach_direct() and restores it under
error_module_put. At this commit on its own, though, the restore covers
only the phy_detach() path.

>  		device_release_driver(&phydev->mdio.dev);
>  		phydev->is_genphy_driven = 0;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130236.106059-1-f%40lex.la
