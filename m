Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D883E9F9D;
	Fri,  2 Oct 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975661; cv=none; b=PyIGKFxcCXqfrop3aoJftZUjw6vMXSMDi/9IFJZDY0GB/uin4YzLjvglzqLnpH5zqFB9HF4UGZNatbjK7YqsGubeYZG22tGxbQJL435sB8WBlB7tUP7gxvGucpz1favIyWptDaaEfzylv/uVgMfvoMBUGqsHgeWT6K672x2ZvRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975661; c=relaxed/simple;
	bh=+gdLHwnxF6Nrd4LbvEe2ar9qsWkda7pD6S7ZB9Tetjc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ot+5ygLmVtKXdzwDqQe2VB2eTCwbJ9l8mjnZZe/3dgqEyl8U2senXE+45VRpanOxBjdRtnUyBu7jTDPytLtReEp4PWxe96kcKraBrvTar/il6hkDSHqpRJn3ucdKSZiIchDWAnIP2gtWouxOZtMA0HdcoPvMxJYP+bIJv0rjPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNylg776; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNylg776"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937971F000FF;
	Fri,  2 Oct 2026 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975659;
	bh=luREycYJOuYaweXNbg0qEdM4vArHR0AI0QZ7D6DEUH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HNylg776aQjplNb0i2KwMMPIH+4CV+De6iARP6wuWdf0D4Ql44J1Sp/LJq8q4bOV1
	 4tzi98g/5N99+HpKYgw5hn7bMnIyBF7ajDWwxfQYZ26iwQzIHUrxMRrzyDy6EMmU3z
	 kgwi81KvtDav18qLqDaUi9LNSPnDlhbCL2EAKXSVPYhLHxDeAjppM1KiDDhgwuDb6I
	 IjNayxwX4MAUVqm17PoDO4V/Nb/1zKTNVXZcMWuAOaeBi8bdZDhxkmgeGIagXfBE/U
	 3TFTUH2vQcdDXN9W8aCelCjm43I7kSahXwe3RigREgmaENQyco8L9K80noUhJS+sWo
	 YHve5sJFD1pdQ==
Subject: Re: [PATCH net-next v13 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
From: netdev-bot+sashiko@kernel.org
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 woojung.huh@microchip.com, linux@armlinux.org.uk,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Date: Fri, 02 Oct 2026 21:14:18 +0000
Message-ID: <179097565815.434549.1979200609360390707@kernel.org>
In-Reply-To:
 <20260929-dsa_lan9645x_switch_driver_base-v13-4-827c2d3617f2@microchip.com>
References:
 <20260929-dsa_lan9645x_switch_driver_base-v13-4-827c2d3617f2@microchip.com>
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

- [Low] lan9645x_probe() gets every register target (gcb, qs, chip_top,
  rew, sys, hsio, dev0..dev8, qsys, ana) through…
- [Low] The binding microchip,lan96455s-switch.yaml requires reg and reg-
  names (17 windows) on the switch node, but the driver never reads its…
- [Low] The v4 changelog says lan9645x_tag_npi_setup() rejects cascaded
  setups, but it only catches a LAN9645x that sits downstream.
- [Low] In lan9645x_reset_switch(), the decision to skip memory init
  depends on lan_rd(lan9645x, SYS_RESET_CFG).

--

net: dsa: lan9645x: add basic dsa driver for LAN9645X

This adds a basic DSA driver for the Microchip LAN9645x switch. It covers
switch init, NPI and CPU port module setup, front port setup, and phylink
MAC configuration for the internal CuPHYs and the RGMII ports 7-8. Register
targets come from a parent device as named regmaps, and the parent MFD
driver is planned for a later series.

> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> new file mode 100644
> index 0000000000000..c7de3836e6967
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -0,0 +1,456 @@

[ ... ]

> +static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
> +{
> +	struct dsa_port *dp, *first_cpu_dp = NULL;
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct phylink_config c = {};
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->cpu_dp->ds != ds) {
> +			dev_err(ds->dev,
> +				"NPI port on a remote switch is not supported\n");
> +			return -EINVAL;
> +		}

[Severity: Low]
Does this check catch every cascaded setup? The v4 changelog says
"tag_npi_setup: reject cascaded setups". The loop only looks at this
switch's user ports and only rejects when their cpu_dp is on another
switch, so it only covers a LAN9645x that sits downstream.

Take a LAN9645x at the top of a dsa,member cluster that owns the NPI port
and has a link port to a switch from another family. Every local user port
then has a local cpu_dp, so the check passes. The DSA link port and the
remote user ports behind it are never checked.

The DSA core doesn't seem to reject the mixed tree either.
dsa_switch_setup_tag_protocol() in net/dsa/dsa.c goes straight to connect
when the protocol matches the tree default:

	if (tag_ops->proto == dst->default_proto)
		goto connect;

lan9645x_port_setup() then sets up the link port like a normal front
port. lan9645x_setup() zeroes the source mask for every port:

	for (int p = 0; p < lan9645x->num_phys_ports; p++) {
		lan_wr(0, lan9645x, ANA_PGID(PGID_SRC + p));

so frames arriving on the link port are not forwarded. On transmit,
lan9645x_xmit() sets IFH_DSTS = BIT(dp->index) for a remote user port,
which selects the local port with the same index.

The tree would probe successfully, but cascaded traffic would be dropped
or misdirected with nothing logged. Could setup fail instead when a
dsa_switch_for_each_port() loop finds a port where dsa_port_is_dsa(dp) is
true?

[ ... ]

> +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> +{
> +	u32 val = 0;
> +	int err;
> +
> +	/* The parent must reset the whole chip before instantiating its
> +	 * children, so the switch core is disabled when we get here. The
> +	 * sequence below must not run more than once: initializing the
> +	 * memories on a running core corrupts pointers inside the queue
> +	 * system, which eventually fills up and stops passing traffic. If the
> +	 * core is already enabled the chip was not reset, so skip it.
> +	 */
> +	if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
> +		return 0;
> +
> +	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
> +	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);

[Severity: Low]
What happens here if the SYS_RESET_CFG read fails? After the WARN_ON_ONCE,
lan_rd() in lan9645x_main.h returns 0:

	u32 addr, val = 0;
	...
	WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val));

	return val;

That reads the same as CORE_ENA=0, so the RAM_INIT sequence could run on a
core that is already running. The comment above says that corrupts the
queue system.

In the same way, lan_wr() returns void, so a failed SYS_RAM_INIT write is
ignored. CORE_ENA could then be set on memories that were never
initialized.

This needs both a chip the parent did not reset and a bus error on exactly
this access. There is no in-tree regmap provider yet, so it is unclear
whether these regmap calls can fail in practice.

Should the regmap_read() result be checked before deciding whether to skip
or run the memory init?

[ ... ]

> +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
> +{
> +	const char *resource_name;
> +	struct regmap *tgt_map;
> +
> +	for (int i = 0; i < NUM_TARGETS; i++) {
> +		resource_name = lan9645x_resource_names[i];
> +		if (!resource_name)
> +			continue;
> +
> +		tgt_map = dev_get_regmap(lan9645x->dev->parent, resource_name);
> +		if (IS_ERR_OR_NULL(tgt_map)) {
> +			dev_err(lan9645x->dev, "Failed to get regmap=%s\n",
> +				resource_name);
> +			return -ENODEV;
> +		}

[Severity: Low]
Is there any in-tree configuration where this lookup can succeed? Nothing
under drivers/mfd registers regmaps with these names (gcb, qs, chip_top,
rew, sys, hsio, dev0..dev8, qsys, ana) for a lan9645x or lan96455 parent.

That means lan9645x_probe() returns -ENODEV every time, including for a DT
node placed under simple-bus. None of the setup, NPI, phylink or port code
in this patch can run in-tree until the MFD parent lands.

The commit message does say "The MFD driver will come in a later series",
so this is mostly a question for the maintainers: should the driver be
merged before anything in-tree can bind it?

[Severity: Low]
Should the driver also be able to use the switch node's own register
windows?

Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
requires reg and reg-names on the switch node, with 17 windows. The driver
never reads those resources itself, and only asks dev->parent for named
regmaps.

For comparison, ocelot_regmap_from_resource() tries the device's own
IORESOURCE_MEM first and only then falls back to the parent.

If the plan is for the future MFD parent to build the named regmaps from
the child's reg and reg-names, as with VSC7512, then this matches, since
the binding's reg-names match lan9645x_resource_names[]. Otherwise, would a
fallback to the node's own resources be useful here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip.com
