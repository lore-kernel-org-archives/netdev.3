Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812A149DF1;
	Fri, 31 Jul 2026 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464625; cv=none; b=QC/s5QCvHE7IsbAx5Rv0rRFAQJ5xlJszHnyuBESjNXM1kecwQ+9B6x4F/AigX5CU2jh+HcZxXDboyJASSnX9kfACqfUCgr6cQNhwz4zWH/6vMxX4LFaqsxkLE41kFjy4LJZFZf9BovIZE2RjDnx3U1iwN/hQOD7GR5EOwgNMHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464625; c=relaxed/simple;
	bh=i7ifSDD3e1LoqIYdfA2avENf1KEudBS4xjA+sVYORO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtKOgaAIVM7pzcQXof++qJxIuZwBUvUdq5q0rG/c+Ksx6rcf8/6mRYo5J39xtP8AVSOwGY9Z0E0Eo9SRVvv/M36ip086KezfVCrAobE1dsJviaOd/VyAHHPy3ywUPnkZLQRaC1zdhoczJg58YFjO4janj5uwBgWg0pGFytIqwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzBfDnI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzBfDnI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B411F000E9;
	Fri, 31 Jul 2026 02:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464621;
	bh=7HQKsaLdfKJ6zjFXiB3Q/tUE2fzQh9inUQFVP5GxDaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzBfDnI6VWTek2rPuSUxzXiECnqbXVqNZh5PeLP2PLOYn2KlA93skpgzs4LqdLkUd
	 yQ7BVPzQpZnyJfQrQAnzaEoW6EOn9iwdiEit1DCb/fWiPuOn033Dp03NIFEIm13R83
	 UnmjpDEqvGst7xRFGMOu/pxbURe5Fsg1gsvDv+QIHeXi7ApXgUsGYdbqEpuN+OOKCR
	 Spy3taZLHg/gA/ynjCFzgLHZpzYRS/+PDEJY4qjNC0gRoOPhIM2xbJahQQPAG6Ozjw
	 78GLYovqEBvMg28XKKwfgSM967ipbD8aag5mbzM2FC0f9PNJB2fwdb+kan4s/hPy6B
	 ShGAOvXuFUthg==
From: Jakub Kicinski <kuba@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/10] net: dsa: microchip: implement ksz8463_setup()
Date: Thu, 30 Jul 2026 19:23:40 -0700
Message-ID: <20260731022340.800270-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-ksz-new-ptp-v3-1-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-1-caba39e680e3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [1]: [PATCH net-next v3 01/10] net: dsa: microchip: implement ksz8463_setup() ---
commit 095ca74374f60de415fb4e79da7940e5e376827a
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

net: dsa: microchip: implement ksz8463_setup()

This splits the KSZ8463 out of ksz8_setup()/ksz8_reset_switch() into a
dedicated ksz8463_setup() and ksz8463_reset_switch(), dropping drive
strength configuration, the KSZ87xx global errata workaround and the IRQ
initialization for that chip.  It also removes .teardown from
ksz8463_switch_ops.

A few questions below.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index c4c769028a20c..5ed63f4250136 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -181,6 +181,14 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
>  	return ksz8_ind_write8(dev, table, (u8)(offset), data);
>  }
>  
> +static int ksz8463_reset_switch(struct ksz_device *dev)
> +{
> +	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
> +	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET,
> +		false);
> +	return 0;
> +}
> +

[Severity: Low]
Can ksz8463_reset_switch() ever return anything but 0?  ksz_cfg() throws the
register write status away:

drivers/net/dsa/microchip/ksz8.c:ksz_cfg() {
	ksz_rmw8(dev, addr, bits, set ? bits : 0);
}

So the error handling added in ksz8463_setup() is dead code:

	ret = ksz8463_reset_switch(dev);
	if (ret) {
		dev_err(ds->dev, "failed to reset switch\n");
		return ret;
	}

If the SPI/regmap access to KSZ8463_REG_SW_RESET fails, ksz8463_setup()
continues on to the storm/aging/VLAN-boundary programming and finally sets
SW_START on a switch that was never reset, without any message.

Since this helper is new, would it make sense to either declare it void, or
use ksz_rmw8() directly and propagate the error the way the REG_SW_CTRL_1
and REG_SW_CTRL_2 writes in ksz8463_setup() already do?

The same always-return-0 shape exists in ksz8_reset_switch(), so this is not
a new behaviour, only newly duplicated.

>  static int ksz8_reset_switch(struct ksz_device *dev)
>  {
>  	if (ksz_is_ksz88x3(dev)) {

[ ... ]

> @@ -2300,6 +2303,110 @@ static void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
>  	spin_unlock(&mib->stats64_lock);
>  }
>  
> +static int ksz8463_setup(struct dsa_switch *ds)
> +{

[Severity: Low]
This isn't a bug, but ksz8463_setup() is a near-verbatim copy of
ksz8_setup(): the vlan_cache allocation, broadcast storm programming,
ksz8_config_cpu_port(), ksz8_enable_stp_addr(), ds->num_tx_queues, the
multicast storm disable, ksz_init_mib_timer(), all the ds->* flag
assignments, the S_LINK_AGING_CTRL / REG_SW_CTRL_1 / REG_SW_CTRL_2 /
S_REPLACE_VID_CTRL / S_MIRROR_CTRL writes, the ksz8_r_vlan_entries() loop,
the CPU port learning setting, ksz_mdio_register(), ksz_dcb_init() and the
final SW_START write are identical.  Only four things differ.

The rest of this family uses one setup function with small chip predicates
(ksz_is_ksz88x3()/ksz_is_ksz8463()).  Could the shared body be factored into
a common helper instead, so a later fix or a new DSA flag does not have to be
applied in two places?

> +	struct ksz_device *dev = ds->priv;
> +	u16 storm_mask, storm_rate;
> +	struct ksz_port *p;
> +	const u16 *regs;
> +	int i, ret;
> +
> +	regs = dev->info->regs;
> +
> +	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
> +				       dev->info->num_vlans, GFP_KERNEL);

[Severity: Low]
The count and size arguments look exchanged here.  The prototype is
devm_kcalloc(dev, n, size, gfp), so this reads as
sizeof(struct vlan_table) elements of dev->info->num_vlans bytes.  The
resulting byte count is the same, so nothing misbehaves, but would
devm_kcalloc(dev->dev, dev->info->num_vlans, sizeof(struct vlan_table),
GFP_KERNEL) be the intended order?

The same swap is present in ksz8_setup(), and this patch copies it into the
new function, which seems like a good moment to correct it.

> +	if (!dev->vlan_cache)
> +		return -ENOMEM;
> +
> +	ret = ksz8463_reset_switch(dev);
> +	if (ret) {
> +		dev_err(ds->dev, "failed to reset switch\n");
> +		return ret;
> +	}
> +

[ ... ]

> +	/* Start with learning disabled on standalone user ports, and enabled
> +	 * on the CPU port. In lack of other finer mechanisms, learning on the
> +	 * CPU port will avoid flooding bridge local addresses on the network
> +	 * in some cases.
> +	 */
> +	p = &dev->ports[dev->cpu_port];
> +	p->learning = true;
> +
> +	ret = ksz_mdio_register(dev);

[Severity: Medium]
ksz8463_setup() deliberately creates no interrupt domains (no
ksz_girq_setup()/ksz_pirq_setup()), but ksz_mdio_register() still runs the
PHY interrupt setup whenever dev->irq is set:

drivers/net/dsa/microchip/ksz_common.c:ksz_mdio_register() {
	...
	if (dev->irq > 0) {
		ret = ksz_irq_phy_setup(dev);
		if (ret)
			goto put_mdio_node;
	}
	...
}

and ksz_irq_phy_setup() resolves the PHY interrupt through the per-port
domain that ksz_pirq_setup() used to create:

			irq = irq_find_mapping(dev->ports[port].pirq.domain,
					       PORT_SRC_PHY_INT);
			if (!irq) {
				ret = -EINVAL;

For KSZ8463 dev->ports[port].pirq.domain is now always NULL, and a NULL
domain is not rejected:

kernel/irq/irqdomain.c:__irq_resolve_mapping() {
	/* Look for default domain if necessary */
	if (domain == NULL)
		domain = irq_default_domain;

On platforms that install an irq_default_domain, can this hand a virq owned
by an unrelated interrupt controller (hwirq 1 of the default domain) to
phylib via ds->user_mii_bus->irq[phy]?

And if devm_of_mdiobus_register() then fails, does ksz_irq_phy_free() call
irq_dispose_mapping() on that foreign virq, tearing down a mapping this
driver never created?

This needs a KSZ8463 node with both an 'interrupts' property (dev->irq =
spi->irq) and an 'mdio' child node with PHY sub-nodes.  On platforms without
a default domain the lookup returns 0 and probe fails with -EINVAL instead;
that outcome matches the pre-patch behaviour, since the KSZ8463 chip entry
sets no .port_nirqs and no per-port mappings were ever created.

Would gating ksz_irq_phy_setup() on the per-port domain actually existing be
preferable to relying on dev->irq alone?

> +	if (ret < 0) {
> +		dev_err(dev->dev, "failed to register the mdio");
> +		return ret;
> +	}
> +
> +	ret = ksz_dcb_init(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* start switch */
> +	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
> +			   SW_START, SW_START);
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -2889,8 +2992,7 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
>  const struct dsa_switch_ops ksz8463_switch_ops = {
>  	.get_tag_protocol	= ksz8463_get_tag_protocol,
>  	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
> -	.setup			= ksz8_setup,
> -	.teardown		= ksz_teardown,
> +	.setup			= ksz8463_setup,

[Severity: High]
This isn't a bug introduced by this patch, but since the commit message says
"PTP and interrupts aren't setup" and this hunk is rewriting exactly this ops
table, it seems worth raising: ksz8463_switch_ops keeps advertising the PTP
callbacks

	.get_ts_info		= ksz_get_ts_info,
	.port_hwtstamp_get	= ksz_hwtstamp_get,
	.port_hwtstamp_set	= ksz_hwtstamp_set,
	.port_txtstamp		= ksz_port_txtstamp,
	.port_rxtstamp		= ksz_port_rxtstamp,

while no PTP clock is ever registered for this chip: the KSZ8463 entry in
ksz_switch_chips[] does not set .ptp_capable, and ksz8463_setup() calls
neither ksz_ptp_clock_register() nor ksz_ptp_irq_setup().  Those are the only
places that run mutex_init(&ptp_data->lock), spin_lock_init(&ptp_data->
clock_lock) and init_completion(&port->tstamp_msg_comp), so dev->ptp_data.
clock stays NULL and those objects stay all-zero.

ksz_get_ts_info() checks for this, but ksz_hwtstamp_set() does not:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_set_hwtstamp_config() {
	...
	return ksz_ptp_enable_mode(dev);
}

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_mode() {
	...
	if (tag_en) {
		ptp_schedule_worker(ptp_data->clock, 0);
	} else {
		ptp_cancel_worker_sync(ptp_data->clock);
	}

	tagger_data->hwtstamp_set_state(dev->ds, tag_en);
}

With CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=y, does a SIOCSHWTSTAMP on a KSZ8463
user port reach ptp_cancel_worker_sync(NULL) here, even for the
HWTSTAMP_TX_OFF / FILTER_NONE combination, followed by an indirect call
through the NULL tagger_data->hwtstamp_set_state (ksz8463_connect_tag_
protocol() only assigns xmit_work_fn)?

Similarly, does the RX path take spin_lock_bh(&ptp_data->clock_lock) in
ksz_tstamp_reconstruct() on a spinlock that was never initialized for this
chip?

Would it make sense to drop these callbacks from ksz8463_switch_ops, or gate
them on dev->info->ptp_capable, while this table is being restructured?  The
same stale callbacks are present in ksz87xx_switch_ops.

>  	.phy_read		= ksz8463_phy_read16,
>  	.phy_write		= ksz8463_phy_write16,
>  	.phylink_get_caps	= ksz8_phylink_get_caps,
