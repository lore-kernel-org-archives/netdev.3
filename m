Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438647;
	b=WqTv8PzJtyvW5i0syvWGS709LYWSb7mi0Q9E/Srr7QTp6MRmGjuvB1NRrYVW2Sf7Qa5v
	 Kph+tz/P8uFfv2uk/PSy/mHdadsmJHhR/NJ36qVNr4mrcI5tZBkVmZ4sDLGvPQpAc3Z7f
	 NcfI0Enps8ZWVM5F9ummKgE67gZCuz9hJ3I2+PL9YnW5KT4XwMH6kZZu+Kkbrc4O71jYy
	 q5rkqWkczOU0qRWEpgPwW+dAUP/H6nZdYC12PcSID8SAqLgDdg2uduAesIoMrnDVWEmT5
	 mwEK3/dfOZs5ANGDi4IWHk1OTgiSyPjuaot0Mu1x3aYCcWiiL4DE2BOxLgC/wLlUL5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438647;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JDx7YnYdWA75CzdxQG3MBo5BJog61seRoKQpYgGQchg=;
	b=sg/bh7ZzQGAMtXc8ui31C6WzvYIBTB2A83CBvJeyT4kRKSJvK0CbR4h/6o2Ob0F9Si5J
	 u2BYJw8RMstrs63i6DsrBbp8Rb+JR+UAbrkCRs0tZbFeC5Ml/YHapYYT5aLMxDBTODOZT
	 OZ4KBGUZs+VQrZtScWQNiNymLFmsB1U/gbDSHm93AeQbPvtWDzi1iDYb0UjpagYnv43ot
	 1M89M/r19/alzT+RBw+5wr3y7JSfprk865o+324vkl2rclAx8POit+UA1huAI0xdVmTf3
	 Wh1eD6Re0/z8tkcdr3FanQMJsS8LaoPGmzkRFSJFVofdfMnv+O8HnhYJtOHA+IecvSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js7XbtAE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E845606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Js7XbtAE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D181F00A05;
	Wed, 11 Nov 2026 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438647;
	bh=JDx7YnYdWA75CzdxQG3MBo5BJog61seRoKQpYgGQchg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Js7XbtAEXN/ASgUWL4dvM7NPnar80TVveMBpUwFyvT/qCVmgT7fZjzh2+2fhVYKEy
	 D2CtYBF11Y/STdFEWxV3CbUq2Dyql6PfrrpsFylbSpOIFY6h/mCEKYIZBk9Ogn9Rje
	 nhiBmPPNsR9HpwInCNkB/mavpVDd9gkZLpjLltcclTs+6t7dHH5qwg2CD3HwUgjpBE
	 vjWiFote50+EsFiVQnjVhuYNfvi2Edft+JsAH27ePwecU6WRhr0bhaI/pO7GO/6Qn0
	 fGztmApub4jd6jK6Mhwknc10JyuSLdA7YHXSS5h6EBiN8kJ/UJeANTc0teVJ7kS1kl
	 DFx4TMGJHCkpg==
Subject: Re: [PATCH net-next v7 02/18] net: ethernet: cortina: Keep ports
 bound for shared IRQ
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 23:10:46 +0000
Message-ID: <179443864614.2199510.5888649170478225602@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-2-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-2-9c32a1a46aec@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In gemini_ethernet_port_probe()
  (drivers/net/ethernet/cortina/gemini.c), the new `if (ret ==…

--

net: ethernet: cortina: Keep ports bound for shared IRQ

The software free queue interrupt is routed through port 1, so this patch
keeps Gemini child ports bound as IRQ-only ports when no PHY is described
or when PHY setup or netdev registration fails. It also publishes a port
to the parent only after it is initialized, under RTNL. Global interrupt
masking moves into the parent probe.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 0b05a15529832..22c3b6b8e2db5 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -2600,17 +2632,41 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto unprepare;
>  
> +	if (!of_property_present(np, "phy-handle") &&
> +	    !of_phy_is_fixed_link(np)) {
> +		dev_info(dev, "no PHY\n");
> +		goto irq_only;
> +	}
> +
>  	ret = gmac_setup_phy(netdev);
>  	if (ret) {
> -		netdev_err(netdev,
> -			   "PHY init failed\n");
> -		goto unprepare;
> +		dev_err(dev, "PHY init failed: %d\n", ret);
> +		if (ret == -EPROBE_DEFER)
> +			goto unprepare;
> +		goto irq_only;
>  	}

[Severity: Medium]
Can gmac_setup_phy() ever return -EPROBE_DEFER here?

It calls of_phy_get_and_connect() and turns any NULL into -ENODEV:

drivers/net/ethernet/cortina/gemini.c:gmac_setup_phy() {
	phy = of_phy_get_and_connect(netdev,
				     dev->of_node,
				     gmac_adjust_link);
	if (!phy)
		return -ENODEV;
	...
}

of_phy_get_and_connect() in drivers/net/mdio/of_mdio.c returns NULL for
every failure. That includes of_phy_register_fixed_link() errors. It also
includes of_phy_connect() returning NULL when of_phy_find_device() has not
found the PHY yet. Apart from -ENODEV, gmac_setup_phy() only returns
-EINVAL, for an unsupported interface mode.

Say the MDIO bus probes after the port. Most Gemini boards reference a
virtual,mdio-gpio bus through phy-handle, and CONFIG_MDIO_GPIO=m makes a
late bus more likely. Wouldn't this path then always go to irq_only, set
port->netdev to NULL and return 0?

After that the port is bound without a netdev, and the driver core won't
retry the probe. suppress_bind_attrs = true blocks rebinding from sysfs.
fw_devlink does not order probes on phy-handle, so nothing holds the port
back until the PHY exists.

The -EPROBE_DEFER check after register_netdevice() looks unreachable in
practice too:

	if (ret) {
		phy_disconnect(netdev->phydev);
		dev_err(dev, "netdev registration failed: %d\n", ret);
		if (ret == -EPROBE_DEFER)
			goto unprepare;
		goto irq_only;
	}

The commit message says:

    Continue to propagate deferred-probe and mandatory resource
    errors.

For PHY setup, though, no deferral value seems to reach these checks.
Could gmac_setup_phy() return -EPROBE_DEFER itself? One way would be to
parse phy-handle and return -EPROBE_DEFER when of_phy_find_device()
returns NULL.

Before this patch, the same case returned -ENODEV and the interface was
also lost. So the outcome is no worse, but the new deferral branches don't
seem to do what the commit message describes.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec%40kernel.org
