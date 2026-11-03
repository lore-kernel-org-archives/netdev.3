Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703405;
	b=ScLmvDUIL1c9hu1hFrWxF7EJprlTt1S6wv43hggVehaUU/3Gc18Xm3e0DgA9rDDn63Si
	 WdVbwSTMuVm0KxBv6w9vqAnw4mbmNk1nBpGzCX3IdK8/d3Bqs4x6kk8vzS6vD/YHK0uTc
	 B3xt07ADZ7qMe+H7nHBtcQFigei+cHRWsq0m6ZTFrurVzZrqDiKeU5yl10buPgluoyRCi
	 b8Z2eys/sxyDGeKmnTELKkT0wZw0GwMOGiO0S5UpW+wj2OrD6CqP9HMgeA+SAknWsRl+g
	 aYcLPMmhwfOtSRhvkb+UuO9Gre3Z/jPGXWoUxBwGjaXx548eORIwtfG7J81Q7j+5JzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703405;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gwvypKjsF1fhDblmkT/fwH2BxnhVOTpgZ0KAoZnMfsc=;
	b=HtTjUfdA4re1RDGxaX2kJ3IrwgTBHiiWPEHEy3w80aj6i6q8e5Q/DTX/YU6iEKuK1xVz
	 Fnmxc0IENxRj/eBoEqBl+7tKpXAwUPMaGui0qD9Q2MVZqpU89I/oe6NFdDIY3hqrsxgIJ
	 jHzCv/5eBxTviOtuhIEZ0VAC9HVofnnryGi7k3ByNwkKTU4J/WxPqSEweevjYy0MkL4Fp
	 S1oAVcDYpOytKnoLCyM3EMYr1Z9YpeFp6wUEPbFyBT7JkNuf6nT1EbqK023IBFmISicDy
	 bYddt2erbPThZhUjOaZZY+RLJSSF2NCIspP4d4/M+S/c0tiUhTSvhSHPKkiE7NS60YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoULIsqr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893A606BF94;
	Tue,  3 Nov 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoULIsqr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488FB1F00A02;
	Tue,  3 Nov 2026 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703404;
	bh=gwvypKjsF1fhDblmkT/fwH2BxnhVOTpgZ0KAoZnMfsc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BoULIsqrLoy1ZGaBehqp1SGkKKMeT2FyyOdvaFyLz4sbwignpGAR2XngvsHTnnL2S
	 6DQBWTzoe/XgpWIcrj9LGXXICc1/4/PY6pYFMuSu5OiN0RRPbnijQqtydAA2MjxrF9
	 lzMQMexXyErpcul849TdZckJE141QGMfyJ/lndwQZz4iXAOKoLuYdyJH/o7p+ywfER
	 j/lXJT6qUy55aFDyTK78UKtOt+/bOvwFriVLjv1zy9I64OSJyRAMOnJ18JyK7uMr4e
	 UxlOEIzecozbl/svRSa+1LYEoIHD7ySDtF5Ojn/v5aX2K1/W8VFMJa6YRIgVV9oNMO
	 nNWmXHN1oiMhw==
Subject:
 Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip reset
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 10:56:43 +0000
Message-ID: <179370340383.488856.629848665261682901@kernel.org>
In-Reply-To: <20261102101125.3523835-1-mmyangfl@gmail.com>
References: <20261102101125.3523835-1-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "The published stats need no handling;
  every entry is republished from the buffer".
- [Low] net: dsa: motorcomm: port variable shadowing in
  yt921x_dsa_setup()

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it blocks the
  re-setup path the patch is meant to fix.

--

net: dsa: motorcomm: Clear the MIB buffer on chip reset

This patch clears the per-port software MIB buffer (pm->data) in
yt921x_dsa_setup() after the chip reset. Without it, a re-setup of the
DSA tree leaves the buffer holding old values, and the next
yt921x_mib_read() reads the reset counters as a 32-bit wrap.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..ff17233848a80 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -2458,6 +2458,16 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  		return -ENODEV;
>  	}
>  

[Severity: High]
This is a pre-existing issue, but can yt921x_dsa_setup() reach the new
loop on the re-setup path from the commit message? The question applies
when the switch node has an "mdio" child, as in the motorcomm,yt921x.yaml
example.

Earlier in yt921x_dsa_setup(), every .setup() call does this:

	child = of_get_child_by_name(np, "mdio");
	if (child) {
		res = yt921x_mbus_int_init(priv, child);
		...

yt921x_mbus_int_init() registers a devm managed bus with the same id
each time:

	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
	...
	mbus->parent = dev;
	...
	res = devm_of_mdiobus_register(dev, mbus, mnp);

devm only releases the bus when the yt921x device unbinds.
yt921x_dsa_teardown() only calls yt921x_leds_remove(). So the first bus
is still registered when the tree is set up again, for example after
another member switch is removed and re-probed.

The second registration would then hit this in __mdiobus_register(),
with a duplicate name under the same parent:

	dev_set_name(&bus->dev, "%s", bus->id);
	...
	err = device_register(&bus->dev);
	if (err) {
		pr_err("mii_bus %s failed to register\n", bus->id);
		return -EINVAL;
	}

In that case yt921x_dsa_setup() returns before the MIB clear and before
yt921x_chip_setup(). dsa_switch_setup() then fails, and the whole tree
is torn down.

Would the tree then stay down until the yt921x driver is unbound, so
that this fix never runs? Should the internal MDIO bus be registered
outside .setup(), or unregistered in .teardown()?

> +	for (int port = 0; port < YT921X_PORT_NUM; port++) {
> +		struct yt921x_port *pp = &priv->ports[port];
> +		struct yt921x_mib *pm = pp->mib;
> +
> +		if (!pm)
> +			continue;
> +
> +		memset(&pm->data, 0, sizeof(pm->data));
> +	}

[Severity: Low]
This loop declares its own int port, but yt921x_dsa_setup() already
has an int port at function scope. The serdes_mask for_each_set_bit()
loop just below uses that outer variable.

The inner declaration shadows the outer one. A W=2 build, which
enables -Wshadow, warns about this. With W=e or CONFIG_WERROR=y the
warning becomes a build failure in chip.c.

There is no runtime problem, because for_each_set_bit() assigns the
outer port before reading it. Could the new loop reuse the existing
variable instead of declaring a new one, as in:

	for (port = 0; port < YT921X_PORT_NUM; port++) {

That would also match how the rest of yt921x_dsa_setup() walks the
ports.

[Severity: Medium]
This loop only clears pm->data. What happens to the published copies in
the same MIB block (pm->stats, pm->rx_frames and pm->tx_frames)?

The commit message says:

  The published stats need no handling; every entry is republished from
  the buffer.

That seems true only after yt921x_mib_read() runs again. On re-setup,
yt921x_dsa_port_setup() keeps the existing pm and only does this, which
does not queue the poll:

	if (pm)
		enable_delayed_work(&pm->work);

The only place that queues the poll is yt921x_phylink_mac_link_up():

	pm = priv->ports[port].mib;
	if (pm)
		schedule_delayed_work(&pm->work, 0);

Meanwhile, yt921x_dsa_get_stats64() in mib.c reads the published copies
under syncp and never calls yt921x_mib_read():

		stats->rx_packets = u64_stats_read(&pm->rx_frames);
		stats->tx_packets = u64_stats_read(&pm->tx_frames);
		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
				  ETH_FCS_LEN * stats->rx_packets;

Take a port whose link stays down after the tree is set up again. Would
its new user netdev keep reporting the old packet, byte and error
counters in ip -s link and /proc/net/dev indefinitely?

The next mib_read could come from the link-up poll or from an ethtool
-S, eth-mac, eth-ctrl, rmon or pause query. At that point every counter
would drop to the small post-reset value, so the counters would go
backwards.

Could this loop also clear or republish the syncp-protected copies,
inside u64_stats_update_begin_irqsave() and
u64_stats_update_end_irqrestore()?

>  	mask = priv->info->serdes_mask;
>  	for_each_set_bit(port, &mask, YT921X_PORT_NUM) {
>  		struct yt921x_port *pp = &priv->ports[port];

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102101125.3523835-1-mmyangfl%40gmail.com
