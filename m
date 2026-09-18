Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D33E411D;
	Fri, 18 Sep 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700592; cv=none; b=ZaOVMdGGvZGi8uEukqRGH5gsXqvIWLaIiDU2lE5xkN12OiVnweQUft56q6fG97/AM1+Kzty7XCGQpYHUb8nT7znq3zjVnzaqey6o/k9aK7YtnnkJojR8ECnlhS2X/B5t8hdD7Wg7QA2VF0ZLkwasNiRCoC5BOqfweEH9Mvq8rvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700592; c=relaxed/simple;
	bh=PcwnV7R3yYV0WGALdWysB3Z66/k1yaqYkRv1b4gOXWk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDHCmwED/pnOHfwatpxphXHLAO4T9HrPSRaJAB/mc1icIdToDwPhgCmtGhkZX3nUs63XFaxWa8w/bFoHrKdtzmHkvx72nNS3vahu0Zo65oKHuJziuJ7WFIUQO1reMhvNsOP9M3HGKdkZbcy3qxpTnn1BTmw7Y1Bp5D6GhZ6GDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeECrLPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeECrLPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4771F000FF;
	Fri, 18 Sep 2026 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789700585;
	bh=ndcj20jBBc74kV0f9eNFleRD6GYTgS+N61/h4D9SdRY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CeECrLPhtFik9G915SWC95sQDKwa7ZNuSGpLYhbXJXHaVNf9SYoonFlU0Qd+TOo/Z
	 XfBWC94rcLNkE2KMbQ9lXNxy25vHnsA1/LFtNOrOTxSmY9gX2FSJIFGqTVTWR/dshQ
	 ql4BpBVX6EeCWaK0dYfVxOpaQ7RajQiR8eHnriRLixr7tdsl9s6W4Xpw6rxZ4Ah3au
	 LPwcNpw/a47s5MufnVmRZ+NrYtYz2Z/VKQd4AC6YMMKSynOMdiIyC37y2eYEWg7wzS
	 tTzg6D8BeV85a/2TO+2vHsMODeQzlZzCabBs9NsysBBZy0c1rwMAjXGbS57ivofpmB
	 l6Aws1v3iaWyg==
Subject: Re: [PATCH net-next v3 1/3] net: phy: realtek: use C45 for
 RTL8365MB-VC internal PHY MMD access
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, a.fatoum@pengutronix.de,
 alvin.sipraga@analog.com, netdev@vger.kernel.org
Date: Fri, 18 Sep 2026 03:03:04 +0000
Message-ID: <178970058465.22033.7422146351349952960@kernel.org>
In-Reply-To: <20260916090102.349157-2-o.rempel@pengutronix.de>
References: <20260916090102.349157-2-o.rempel@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The RTL8365MB-VC phy_driver entry (PHY ID 0x001cc942) is pointed
  at genphy_read_mmd_c45()/genphy_write_mmd_c45(), which go straight to…

--

net: phy: realtek: use C45 for RTL8365MB-VC internal PHY MMD access

This points the RTL8365MB-VC phy_driver entry (PHY ID 0x001cc942) at
genphy_read_mmd_c45()/genphy_write_mmd_c45() so that phylib MMD accesses
are issued as C45 transfers to the Realtek DSA driver, which maps them
onto the switch OCP registers.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 97b0b67b9900c..b55691681df6e 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -3338,6 +3338,8 @@ static struct phy_driver realtek_drvs[] = {
>  	}, {
>  		PHY_ID_MATCH_EXACT(0x001cc942),
>  		.name		= "RTL8365MB-VC Gigabit Ethernet",
> +		.read_mmd	= genphy_read_mmd_c45,
> +		.write_mmd	= genphy_write_mmd_c45,

[Severity: Low]
This isn't a bug, but the commit message describes the DSA-side mapping in
the present tense:

  "the realtek DSA driver maps those MMD requests onto OCP and exposes them
   over C45"

At this commit, rtl83xx_setup_user_mdio() in
drivers/net/dsa/realtek/rtl83xx.c only installs the C22 accessors:

	bus->read = rtl83xx_user_mdio_read;
	bus->write = rtl83xx_user_mdio_write;

The read_c45/write_c45 callbacks and the MMD to OCP mapping arrive later in
the series, in "net: dsa: realtek: rtl8365mb: add EEE support".

genphy_read_mmd_c45()/genphy_write_mmd_c45() go straight to
__mdiobus_c45_read()/__mdiobus_c45_write() with no C22 fallback, and those
return -EOPNOTSUPP when bus->read_c45 is NULL:

	if (bus->read_c45)
		retval = bus->read_c45(bus, addr, devad, regnum);
	else
		retval = -EOPNOTSUPP;

so every MMD access on these ports fails until the later patch lands.

The effect at this intermediate commit looks benign: the only MMD access
that actually runs is genphy_c45_read_eee_abilities() from
genphy_read_abilities(), whose error is explicitly discarded:

	/* This is optional functionality. If not supported, we may get an error
	 * which should be ignored.
	 */
	genphy_c45_read_eee_abilities(phydev);

and phy_check_link_status() only treats genphy_c45_eee_is_active() as a
boolean (err > 0), so a failure just leaves eee_active/enable_tx_lpi false.

Would it be worth wording that sentence as a forward reference to the later
patch, so the commit does not claim an in-tree mapping that only exists
after the following patch in the series?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916090102.349157-1-o.rempel%40pengutronix.de
