Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F13BBFBF;
	Sun, 27 Sep 2026 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512113; cv=none; b=cQGm1eiO3wgWZkxl3QInj9uWXBTfWB/1JFFrkO43Jw8k11STrPnhjVQJqhoOqfLQ6AS2XgYN5zrBRyen4gcMiLiyrRpYa0RBKkYApW3UmW3o5SSnjmcv58fm6WrxJCiS0OoTJBjFTA4mUn7g5KyVAmygL39102cp2TxHfvjyZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512113; c=relaxed/simple;
	bh=7GorxFrhN1Qh9ImeEEttuYcqKMAG04guhLuaTF5vzJU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vl2xZ4sayN+kpjv8QEoiv33r394Mq4d9pxM8rjkMSML+H55XXUn6Z22XKtbbNcJ8YbTExOoTX4OmG54nJUxJZWUA7a+GBXMR7MedVA+TZJpMTnUABvgXlTC21laXKBIyE9uwMO9EPf2nNeUdYfnnhCBW1+LvAO1LLC6HQRAWQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw4uDSZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw4uDSZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAED1F00893;
	Sun, 27 Sep 2026 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512112;
	bh=aozkiCaY4t1cE5dbFPT+0Do9Io81/Nf2L04JYawvlx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gw4uDSZAnA2RFLuVirPiAP8GVmV9+A6vj3BRvikI0uNdLGwz/gud2+5KveTLud9sV
	 7ah04YvzGOHfPWyqeq24BXCMQjCeVtP0bq1Dks6BxtE20mnOuRxVDP1IAYCfnD1K8z
	 p5o18RXxc2V+hU9pLZO2yw8aKw6x6Ss2S1mY+VEJdWy98zqlG1gNdCwhrnS1Z9rsk4
	 e36zfImr1sqUMjTh/LZ/jkOJrT57MySPOVaEzs7Il5/dmqL21mo83xNKRYls2qQSVs
	 5rcSOaSW2QfOJyh6bBSckcZm2KYp5MvnXXw80uJzqWGp66qlfF4CCu4S4U2chancmu
	 LZAvIv6SV2jKA==
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:30 +0000
Message-ID: <179051211083.2160803.7671691444003694031@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In soce_sw_probe() (drivers/net/dsa/soce/soce_dsa_core.c), child
  platform devices are created with devm_of_platform_populate() at line…
- [Medium] soce_setup() never puts the per-port INGR_EN/EGR_EN bits into
  a known state for user ports, and probe does not reset the core.

--

net: dsa: soce: Add basic support for SoC-e switch IP cores

This adds a DSA driver for SoC-e FPGA-based Ethernet switch IP cores. It
reads the core version and feature registers at probe and enables DSA
custom rules tagging during setup. The DSA port callbacks control port
ingress and egress, and probe populates the MDIO controller and mux child
devices.

> diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
> new file mode 100644
> index 0000000000000..d391b11b94ad6
> --- /dev/null
> +++ b/drivers/net/dsa/soce/soce_dsa_core.c

[ ... ]

> +static int soce_setup(struct dsa_switch *ds)
> +{
> +	struct soce_priv *priv = ds->priv;
> +
> +	soce_sw_enable_tagging(&priv->local);
> +
> +	return 0;
> +}

[Severity: Medium]
Is there anything that sets SOCE_PORTS_CTRL_INGR_EN and
SOCE_PORTS_CTRL_EGR_EN to a known state on user ports before tagging is
enabled here?

Probe does not reset the core. At setup time the DSA core calls
port_disable only for unused ports:

net/dsa/dsa.c:dsa_port_setup() {
    ...
	case DSA_PORT_TYPE_UNUSED:
		dsa_port_disable(dp);
		break;
    ...
}

User ports get no port_enable or port_disable call until their netdev is
opened or closed.

Suppose the IP comes out of reset with ports enabled, or a bootloader left
them enabled. Once soce_setup() turns on tag all frames and custom rules
tagging, could a user port that is administratively down still receive
frames and forward them tagged to the CPU port?

At the end of the series, soce_setup() resets VLAN, disables STP and
enables tagging. It still doesn't seem to change the per-port enable bits.
Would it make sense to clear them for all user ports here?

[ ... ]

> +	ds->ops = &soce_switch_ops;
> +	ds->num_ports = hw_numports;
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to populate child devices\n");
> +
> +	dev_set_drvdata(dev, priv);
> +
> +	ret = dsa_register_switch(ds);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register DSA switch\n");

[Severity: High]
Can this probe loop without end when dsa_register_switch() returns
-EPROBE_DEFER?

devm_of_platform_populate() creates the child devices before
dsa_register_switch() runs. dsa_register_switch() can defer in fairly
common situations. One is a conduit netdev that isn't registered yet:

net/dsa/dsa.c:dsa_port_parse_of() {
    ...
		conduit = of_find_net_device_by_node(ethernet);
		of_node_put(ethernet);
		if (!conduit) {
			rtnl_unlock();
			return -EPROBE_DEFER;
    ...
}

It can also defer when dev_find_class() fails, or when the tagger lookup
in dsa_switch_setup_tag_protocol() fails:

		if (PTR_ERR(tag_ops) == -ENOPROTOOPT)
			return -EPROBE_DEFER;

Documentation/driver-api/driver-model/driver.rst says:

  -EPROBE_DEFER must not be returned if probe() has already created child
  devices ... it may result in an infinite loop of .probe() calls

The sequence looks like this:

soce_sw_probe()
  devm_of_platform_populate()
    mdio-soce, mdio-mux-mmioreg and the PHY devices bind
      driver_bound()->driver_deferred_probe_trigger()
        deferred_trigger_count++
  dsa_register_switch()
    returns -EPROBE_DEFER
really_probe()
  sees the trigger count changed and triggers deferred probing again
devres removes the child devices
soce_sw_probe() runs again and creates them again

The children bind synchronously because MODULE_SOFTDEP loads their drivers
first. The DSA ethernet phandle is not a fw_devlink supplier property, so
nothing makes the switch probe wait for the conduit.

If the conduit never appears, for example because its driver is missing
or fails, would a kworker keep creating and removing the MDIO bus and PHY
devices indefinitely?

This still appears to be present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
