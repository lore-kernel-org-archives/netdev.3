Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6F1D5AC2;
	Tue, 29 Sep 2026 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642323; cv=none; b=lISctLAKBfaTs7s+q7V9NFjbmSCBsogQxVJm4b6TPPgZzNKM6LIGg/pmaE3U/IPdhk12fu3N20mwVvj9qIw7hNxnNZbG3KtF22K/5iAwMt2CQOOj4g5NqvqPYKHkZt0hZlD2BRXqiNnXU3UihbQ2eiuj9l8EXeKjx+kiawefM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642323; c=relaxed/simple;
	bh=Bzytoigw+KSo0HzW4tJdSru7UwQFVevcJV7ecrmJjTo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bpOAE8hSbxaMncipn/CyKEJ24heF1+/fkZA49haomz4WjVA1F2rFB2p5CXm+1szt7KubJn9KfVGeXlyp+yk++0MAsvXW4ZV5TJ8MT4jr4ORxhWASmdTkHFFOTgJ1kDSi2+3ohsjdk+F18ivfmh+q2i+p4JKGhdmy4WNQwXYNUww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNe6mLD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNe6mLD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95301F0089A;
	Tue, 29 Sep 2026 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642317;
	bh=zSK042Zv/4wl3cQKO6z5+RgvkAr6qbZaw0oF3ZmwtUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WNe6mLD/NXuEDI3ofA36hIM3zluyVTI33wdiJUy8nTb8Liy2ozasam5yEh/uxELYm
	 Bsbpcelr2tDWwRrz7lesvfc/oZP0+6OjiZn5RZN5YfWowyyirtdAgzuIEOoaaoO6UB
	 5upw+Ardf5m8NzUb3g5VztzKC4bMJ9XVGM/XnE1tp7ExZMTheFy69oU4x72Gus8esX
	 iWpdqbdekS55Gc4ul3bzrXTrBdbvc3wVXMjOJLsiMr8WWgzr34pi6ePYaJ9EhalLNo
	 CnVp9DF7b4E2FiUzPxPIfwrAJLWh8uiqYs7PzacUgmkedAbBMpxYFHL1PVkq5rTFOR
	 GAf3qWhVYchpA==
Subject: Re: [PATCH net-next v18 04/10] net: phy: Create SFP phy_port before
 registering upstream
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:35 +0000
Message-ID: <179064231538.3145.11825184122943631312@kernel.org>
In-Reply-To: <20260927133619.955236-5-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-5-maxime.chevallier@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This commit fixes a real, user-visible bug but the commit
  message calls it preparation only ("This will allow passing the…
- [Medium] Now that module_insert can succeed synchronously inside
  phy_sfp_probe() (see the previous finding), it runs before…

--

net: phy: Create SFP phy_port before registering upstream

This commit moves creation of the SFP phy_port in phy_sfp_probe() so that
it happens before sfp_bus_add_upstream() instead of after it. It also
changes phy_setup_sfp_port() to return the port pointer, and reworks the
error path to delete the port and drop the bus reference on failure.

> We can move the port creation before registering the sfp upstream ops,
> as long as we know the SFP bus is there. This will allow passing the
> phy_port along with the upstream information to the SFP bus.

[Severity: Medium]
The message describes this as preparation only. Does the reordering also
fix an existing bug?

Before this patch, phy_sfp_probe() called sfp_bus_add_upstream() before
phy_setup_sfp_port(). Suppose the SFP cage driver has already probed the
module, so sm_mod_state is SFP_MOD_WAITDEV. Two common ways to get there
are a built-in sfp driver with a modular PHY driver loaded later, and an
unbind/rebind of the PHY driver while a module is plugged in. In that
case, registering the upstream runs module_insert synchronously:

phy_sfp_probe()
  sfp_bus_add_upstream()
    sfp_register_bus()
      bus->registered = true;
      bus->socket_ops->attach()
        sfp_attach()
          sfp_sm_event(SFP_E_DEV_ATTACH)
            sfp_sm_module()        /* SFP_MOD_WAITDEV */
              sfp_module_insert()
                phy_sfp_module_insert()

The SFP phy_port did not exist yet at that point, so
phy_sfp_module_insert() returned without printing anything:

	port = phy_get_sfp_port(phydev);
	if (!port)
		return -EINVAL;

sfp_sm_module() then moved the module to SFP_MOD_ERROR. It only leaves
that state on SFP_E_REMOVE or SFP_E_INSERT, so the module stayed unusable
until someone physically re-inserted it.

With the port now created before sfp_bus_add_upstream(), this path
succeeds. Should the commit message describe the fix? Should it also have
a Fixes: tag so that stable kernels with the phy_port SFP infrastructure
pick it up? Possible candidates:

  d7c6082f7e77 ("net: phy: Introduce generic SFP handling for PHY drivers")
  07f3ca9e092c ("net: phy: Create a phy_port for PHY-driven SFPs")

The first made module_insert depend on phy_get_sfp_port(). The second
put the port setup after upstream registration.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index c4d2c03b8282b..3c20d4cc1a79d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1619,30 +1621,46 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
>   */
>  static int phy_sfp_probe(struct phy_device *phydev)
>  {
> +	struct phy_port *port = NULL;
>  	struct sfp_bus *bus;
> -	int ret = 0;
> +	int ret;
>  
> -	if (phydev->mdio.dev.fwnode) {
> -		bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
> -		if (IS_ERR(bus))
> -			return PTR_ERR(bus);
> +	if (!phydev->mdio.dev.fwnode)
> +		return 0;
>  
> -		phydev->sfp_bus = bus;
> +	bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);
>  
> -		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
> -		sfp_bus_put(bus);
> +	phydev->sfp_bus = bus;
>  
> -		if (ret)
> -			phydev->sfp_bus = NULL;
> +	if (bus) {
> +		port = phy_setup_sfp_port(phydev);
> +		if (IS_ERR(port)) {
> +			ret = PTR_ERR(port);
> +			goto out_sfp;
> +		}
>  	}
>  
> -	if (!ret && phydev->sfp_bus) {
> -		ret = phy_setup_sfp_port(phydev);
> -		if (ret) {
> -			sfp_bus_del_upstream(phydev->sfp_bus);
> -			phydev->sfp_bus = NULL;
> -		}
> +	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);

[Severity: Medium]
phy_sfp_module_insert() can now succeed from inside phy_sfp_probe(). What
happens to the phydev->port value it sets there?

Take a PHY whose SFP port is its only port (max_n_ports == 1, such as
at8031, 88e1510 or 88x2222). The synchronous insert does this in
phy_sfp_module_insert():

	if (phydev->n_ports == 1)
		phydev->port = caps->port;

Then phy_sfp_probe() returns, and phy_setup_ports() unconditionally
overwrites the value:

	/* For now, the phy->port field is set as the first active port's type */
	list_for_each_entry(port, &phydev->ports, head)
		if (port->active) {
			phydev->port = phy_port_get_type(port);
			break;
		}

The SFP port has is_mii set and no mediums, so phy_port_get_type()
returns PORT_OTHER for it.

As a result, a module that is already present when the PHY probes reports
PORT_OTHER. The same module hot-plugged after probe keeps caps->port,
for example PORT_FIBRE or PORT_DA.

qca807x in combo mode appears to have the same problem.
qca807x_configure_serdes() sets phydev->port = PORT_FIBRE during the
synchronous insert. phy_setup_ports() then adds the default copper port
and overwrites phydev->port with PORT_TP. The hot-plug path keeps
PORT_FIBRE.

at803x, 88x2222 and qca807x never recompute phydev->port in read_status,
so the port type that ethtool shows stays wrong until the module is
removed. marvell.c and marvell10g recompute it at runtime.

Before this patch, this path failed with -EINVAL, so the overwrite only
becomes reachable with this reordering. Later patches in the series leave
phy_setup_ports() and phy_sfp_module_insert() unchanged, so the behaviour
remains at the end of the series.

Should phy_setup_ports() leave phydev->port alone when an SFP module was
already inserted during phy_sfp_probe()?

> +	if (ret)
> +		goto out_port;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
