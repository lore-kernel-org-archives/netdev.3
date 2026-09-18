Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2673E315C;
	Fri, 18 Sep 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700593; cv=none; b=ez5gCNrklTtVMFeGEkotsin6DpoI6ZtbMruxfTi6Zx/QHiaNn+qrpCLThju/rH1g1rFMOBZDtt7FdNLl/BuhaC/SAqiAs3k7Gihc/poLHYQaY/0KKBIDV0dz3nXOw1O/gzPDqLaFu9z7C1iMk2kz+65mlakAh4FRX5dP/039uKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700593; c=relaxed/simple;
	bh=phfKTK89yXYoN1vqP8PupXLzAYeUaILRCPQi8P0DxyY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH1rSRW51noI6kJ/Ga3yI7bnRb3AsGdJn/j5Hr4S0qzLaKLqrnVwy2kkZAd6lSZt2tR1H+xop1GxqvgFVwBdQf3WfMFggZU4PG9kSjq84Khrg2twnFpvb7B6sML0WvKADUAAC8mhG4YPFqaI7jlyK6MtDofkBz72fTLbQMhMJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa45Hekq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa45Hekq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819EF1F00893;
	Fri, 18 Sep 2026 03:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789700587;
	bh=yJfUQzAl9w/ne0lucI5TQjlhh0dqxZceTmzZVZS+z+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Fa45HekqB7PZmxCNHO+tR1h/IQoqoBOfKFm8KrosAVvgZj681hJLv+j2I9csqQdJp
	 v9J/5gnjXj8/sMlAlbOpqsMQ88yGpKjCDRDlyb8KxauFYFfI9eZTtKeFwXzQavAL3t
	 2dnCFxlfzBtQbifpNI7j1WIhmHrtLaIuCQuoS1NeSg5SfAIDYqoxMZRYTWBUW+jH5H
	 ZN0ug67vW8H95opqDzOWcV/mZGuw8OAqSnd2ElI4gmNo0yz2XfD1n0v6FDA6hJiJCY
	 Q4sZyXz3WCDz8fHZbsvKmBwNpKLPCSFaw12E3SPM1vKJYMCaogU7tBUZkMfvxCrygf
	 1iEgBYKxCn1xw==
Subject:
 Re: [PATCH net-next v3 3/3] net: dsa: realtek: rtl8365mb: add EEE support
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, a.fatoum@pengutronix.de,
 alvin.sipraga@analog.com, netdev@vger.kernel.org
Date: Fri, 18 Sep 2026 03:03:06 +0000
Message-ID: <178970058611.22033.11415018471944881506@kernel.org>
In-Reply-To: <20260916090102.349157-4-o.rempel@pengutronix.de>
References: <20260916090102.349157-4-o.rempel@pengutronix.de>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] config->eee_enabled_default = true (rtl8365mb_main.c:1724)
  turns EEE on out of the box for every integrated-PHY port; no user…

--

net: dsa: realtek: rtl8365mb: add EEE support

This adds EEE support for the integrated-PHY ports of rtl8365mb by mapping
the EEE MMD registers onto the switch OCP address space through new
phy_{read,write}_c45 realtek_ops. It also advertises LPI awareness to
phylink with no-op mac_{en,dis}able_tx_lpi callbacks and rejects the
per-port TX LPI knobs in .set_mac_eee.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index efde1f3b604e1..87ec924a06118 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1649,6 +1714,14 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
>  		 */
>  		__set_bit(PHY_INTERFACE_MODE_GMII,
>  			  config->supported_interfaces);
> +
> +		/* Integrated PHYs support EEE at 100M/1G; the hardware manages
> +		 * LPI on its own, so just advertise LPI awareness to phylink.
> +		 */
> +		memcpy(config->lpi_interfaces, config->supported_interfaces,
> +		       sizeof(config->lpi_interfaces));
> +		config->lpi_capabilities = MAC_100FD | MAC_1000FD;
> +		config->eee_enabled_default = true;
                ^^^^

[Severity: Medium]
Should the commit message mention that this line changes the default
behaviour of already-supported boards?

The commit message says:

    Add EEE support on the integrated-PHY ports, controllable per port via
    ethtool.

and:

    The hardware manages LPI on its own, so advertise EEE to phylink with
    no-op mac_{en,dis}able_tx_lpi callbacks.

That reads as opt-in, but setting config->eee_enabled_default in
rtl8365mb_phylink_get_caps() makes EEE active without any ethtool command.
phylink_create() copies the flag into its own configuration:

drivers/net/phy/phylink.c:phylink_create() {
	...
	pl->eee_cfg.eee_enabled = pl->config->eee_enabled_default;
	pl->eee_cfg.tx_lpi_enabled = pl->eee_cfg.eee_enabled;
	...
}

and the advertisement is then written at the first link bring-up:

drivers/net/phy/phylink.c:phylink_bringup_phy() {
	...
	if (pl->eee_cfg.eee_enabled)
		phy_support_eee(phy);
	...
}

So after a kernel upgrade every integrated-PHY port on every supported
rtl8365mb board starts advertising EEE and entering LPI, where previously it
did not. EEE enabled by default is known to cause link instability with some
link partners.

Could the commit message state this default change explicitly, so that
maintainers and backporters see it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916090102.349157-1-o.rempel%40pengutronix.de
