Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8153101C0
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481088; cv=none; b=bQwSFUskRtgb6JjtrYxJG/Cn5Okn9HsmuTWd1xAQR/NlQevffOh0xwP8HQ72YHzuUhdSdaKw1QBCeq1XesdwjD1k1ujGjxUGW7T5j0b7V4x5JZeG8RgPvOJRvqrdg3zwexZ5adPOB2+eal3Ce/6nEq2RUFE35VHYZl1ee6kOP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481088; c=relaxed/simple;
	bh=dzK1wq0l9GvGMZT/rX31L4aEMPndVSEYFJIpI45CqTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+rP0Q7vNxmONdbVkRt04ZvfjIk+S74CoVo5ro1EUwgVW8/hCqljgeIF08AbPl4wj2aYM0Xvo5/PUYJOsY2cDEktX4MRjYxj2CsagUTGLInwxxfFO2SW00dlKjc/M3ye52GFzGsUCNEEnIVXhuVOBjf8GjtuBdqBHWCFO7x184k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SYhs8LKJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SYhs8LKJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0A1581A1342;
	Fri, 31 Jul 2026 06:58:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D08AB6039A;
	Fri, 31 Jul 2026 06:58:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 949DB11C16461;
	Fri, 31 Jul 2026 08:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785481077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gUJ8XlSStb8zUOIsWjNUBfCduY6+D61GY9wEhxLgOgI=;
	b=SYhs8LKJunNDyE3jC1GEkneeQSAtDYeJu8qewt5C/Fd50AaguyzmlwpKotLZHIth4P2mcZ
	XeDnBj+Q7x0Xfn46rMFCdO6B5t2RKM7Waljv+Ujm6qKOKQ5UlEEBmnDJy1vpAc8Y/FUSsf
	uSdZLSS2a9865HIjk1fxNLRKNvD8DV40b3WKWAW5qXkFPTBrvt1VqgdLlbVGyd9WhyEFl8
	8BxReJT1sFPwDLNUeuSVLIEwI6SIL2bd5sX186nzvNiRN5EZkaDegrs/i6AUFFJzEGLG5x
	NXzl6ExMMLb6x5JYstn5yMFu9OE+/lJFGkuAcNiuaUJteBwaIjQiY+0bybMgtg==
Message-ID: <95872f9e-4261-4cb0-b9f0-a82e3bf64fbc@bootlin.com>
Date: Fri, 31 Jul 2026 08:57:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/10] net: dsa: microchip: implement
 ksz8463_setup()
To: Jakub Kicinski <kuba@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, maxime.chevallier@bootlin.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260727-ksz-new-ptp-v3-1-caba39e680e3@bootlin.com>
 <20260731022340.800270-1-kuba@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260731022340.800270-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/31/26 4:23 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [1]: [PATCH net-next v3 01/10] net: dsa: microchip: implement ksz8463_setup() ---
> commit 095ca74374f60de415fb4e79da7940e5e376827a
> Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> 
> net: dsa: microchip: implement ksz8463_setup()
> 
> This splits the KSZ8463 out of ksz8_setup()/ksz8_reset_switch() into a
> dedicated ksz8463_setup() and ksz8463_reset_switch(), dropping drive
> strength configuration, the KSZ87xx global errata workaround and the IRQ
> initialization for that chip.  It also removes .teardown from
> ksz8463_switch_ops.
> 
> A few questions below.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
>> index c4c769028a20c..5ed63f4250136 100644
>> --- a/drivers/net/dsa/microchip/ksz8.c
>> +++ b/drivers/net/dsa/microchip/ksz8.c
>> @@ -181,6 +181,14 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
>>   	return ksz8_ind_write8(dev, table, (u8)(offset), data);
>>   }
>>   
>> +static int ksz8463_reset_switch(struct ksz_device *dev)
>> +{
>> +	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
>> +	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET,
>> +		false);
>> +	return 0;
>> +}
>> +
> 
> [Severity: Low]
> Can ksz8463_reset_switch() ever return anything but 0?  ksz_cfg() throws the
> register write status away:
> 
> drivers/net/dsa/microchip/ksz8.c:ksz_cfg() {
> 	ksz_rmw8(dev, addr, bits, set ? bits : 0);
> }
> 
> So the error handling added in ksz8463_setup() is dead code:
> 
> 	ret = ksz8463_reset_switch(dev);
> 	if (ret) {
> 		dev_err(ds->dev, "failed to reset switch\n");
> 		return ret;
> 	}
> 
> If the SPI/regmap access to KSZ8463_REG_SW_RESET fails, ksz8463_setup()
> continues on to the storm/aging/VLAN-boundary programming and finally sets
> SW_START on a switch that was never reset, without any message.
> 
> Since this helper is new, would it make sense to either declare it void, or
> use ksz_rmw8() directly and propagate the error the way the REG_SW_CTRL_1
> and REG_SW_CTRL_2 writes in ksz8463_setup() already do?
> 
> The same always-return-0 shape exists in ksz8_reset_switch(), so this is not
> a new behaviour, only newly duplicated.
> 

As it says, the behaviour is the same in ksz8_reset_switch(), I only 
extracted the functions from it to have a better split between KSZ8463 
and others KSZ8.
IMO, the real issue here is that the ksz_cfg() helper ignores the 
ksz_rmw8() return value.

>>   static int ksz8_reset_switch(struct ksz_device *dev)
>>   {
>>   	if (ksz_is_ksz88x3(dev)) {
> 
> [ ... ]
> 
>> @@ -2300,6 +2303,110 @@ static void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port)
>>   	spin_unlock(&mib->stats64_lock);
>>   }
>>   
>> +static int ksz8463_setup(struct dsa_switch *ds)
>> +{
> 
> [Severity: Low]
> This isn't a bug, but ksz8463_setup() is a near-verbatim copy of
> ksz8_setup(): the vlan_cache allocation, broadcast storm programming,
> ksz8_config_cpu_port(), ksz8_enable_stp_addr(), ds->num_tx_queues, the
> multicast storm disable, ksz_init_mib_timer(), all the ds->* flag
> assignments, the S_LINK_AGING_CTRL / REG_SW_CTRL_1 / REG_SW_CTRL_2 /
> S_REPLACE_VID_CTRL / S_MIRROR_CTRL writes, the ksz8_r_vlan_entries() loop,
> the CPU port learning setting, ksz_mdio_register(), ksz_dcb_init() and the
> final SW_START write are identical.  Only four things differ.
> 
> The rest of this family uses one setup function with small chip predicates
> (ksz_is_ksz88x3()/ksz_is_ksz8463()).  Could the shared body be factored into
> a common helper instead, so a later fix or a new DSA flag does not have to be
> applied in two places?
> 

The goal of this patch is to introduce a dedicated ksz8463_setup() 
function so that its specific IRQ configuration (and, in an upcoming 
series, its specific periodic output configuration) can be handled 
without adding ksz8463-specific branches to the common ksz8_setup() 
function.
Indeed it comes with some code duplication. I considered adding some 
'sub-setup()' helpers shared between the ksz8xxx_setup() to avoid the 
copies. However, the differences are spread accross the setups(). At the 
beginning, the reset() and the storm configuration differ; in the 
middle, the ksz87xx()/ksz_is_ksz88x3() belong only to ksz8_setup(); at 
the end, the IRQ setup (added in PATCH 4) is completely different. So I 
came to the conclusion that the ksz8463_setup() could live a bit of code 
duplication.

>> +	struct ksz_device *dev = ds->priv;
>> +	u16 storm_mask, storm_rate;
>> +	struct ksz_port *p;
>> +	const u16 *regs;
>> +	int i, ret;
>> +
>> +	regs = dev->info->regs;
>> +
>> +	dev->vlan_cache = devm_kcalloc(dev->dev, sizeof(struct vlan_table),
>> +				       dev->info->num_vlans, GFP_KERNEL);
> 
> [Severity: Low]
> The count and size arguments look exchanged here.  The prototype is
> devm_kcalloc(dev, n, size, gfp), so this reads as
> sizeof(struct vlan_table) elements of dev->info->num_vlans bytes.  The
> resulting byte count is the same, so nothing misbehaves, but would
> devm_kcalloc(dev->dev, dev->info->num_vlans, sizeof(struct vlan_table),
> GFP_KERNEL) be the intended order?
> 
> The same swap is present in ksz8_setup(), and this patch copies it into the
> new function, which seems like a good moment to correct it.
>

Yes once again, I only copied what was needed from ksz8_setup() so this 
kind of tiny mistakes are copied.
>> +	if (!dev->vlan_cache)
>> +		return -ENOMEM;
>> +
>> +	ret = ksz8463_reset_switch(dev);
>> +	if (ret) {
>> +		dev_err(ds->dev, "failed to reset switch\n");
>> +		return ret;
>> +	}
>> +
> 
> [ ... ]
> 
>> +	/* Start with learning disabled on standalone user ports, and enabled
>> +	 * on the CPU port. In lack of other finer mechanisms, learning on the
>> +	 * CPU port will avoid flooding bridge local addresses on the network
>> +	 * in some cases.
>> +	 */
>> +	p = &dev->ports[dev->cpu_port];
>> +	p->learning = true;
>> +
>> +	ret = ksz_mdio_register(dev);
> 
> [Severity: Medium]
> ksz8463_setup() deliberately creates no interrupt domains (no
> ksz_girq_setup()/ksz_pirq_setup()), but ksz_mdio_register() still runs the
> PHY interrupt setup whenever dev->irq is set:
> 
> drivers/net/dsa/microchip/ksz_common.c:ksz_mdio_register() {
> 	...
> 	if (dev->irq > 0) {
> 		ret = ksz_irq_phy_setup(dev);
> 		if (ret)
> 			goto put_mdio_node;
> 	}
> 	...
> }
> 
> and ksz_irq_phy_setup() resolves the PHY interrupt through the per-port
> domain that ksz_pirq_setup() used to create:
> 
> 			irq = irq_find_mapping(dev->ports[port].pirq.domain,
> 					       PORT_SRC_PHY_INT);
> 			if (!irq) {
> 				ret = -EINVAL;
> 
> For KSZ8463 dev->ports[port].pirq.domain is now always NULL, and a NULL
> domain is not rejected:
> 
> kernel/irq/irqdomain.c:__irq_resolve_mapping() {
> 	/* Look for default domain if necessary */
> 	if (domain == NULL)
> 		domain = irq_default_domain;
> 
> On platforms that install an irq_default_domain, can this hand a virq owned
> by an unrelated interrupt controller (hwirq 1 of the default domain) to
> phylib via ds->user_mii_bus->irq[phy]?
> 
> And if devm_of_mdiobus_register() then fails, does ksz_irq_phy_free() call
> irq_dispose_mapping() on that foreign virq, tearing down a mapping this
> driver never created?
> 
> This needs a KSZ8463 node with both an 'interrupts' property (dev->irq =
> spi->irq) and an 'mdio' child node with PHY sub-nodes.  On platforms without
> a default domain the lookup returns 0 and probe fails with -EINVAL instead;
> that outcome matches the pre-patch behaviour, since the KSZ8463 chip entry
> sets no .port_nirqs and no per-port mappings were ever created.
> 
> Would gating ksz_irq_phy_setup() on the per-port domain actually existing be
> preferable to relying on dev->irq alone?
> 

Proper IRQ handling for the KSZ8463 is added in PATCH 4. Current IRQ 
framework doesn't work for the KSZ8463 anyway, so IMO this patch doesn't 
introduce any regression.

>> +	if (ret < 0) {
>> +		dev_err(dev->dev, "failed to register the mdio");
>> +		return ret;
>> +	}
>> +
>> +	ret = ksz_dcb_init(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* start switch */
>> +	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
>> +			   SW_START, SW_START);
>> +
>> +	return 0;
>> +}
>> +
> 
> [ ... ]
> 
>> @@ -2889,8 +2992,7 @@ const struct ksz_dev_ops ksz88xx_dev_ops = {
>>   const struct dsa_switch_ops ksz8463_switch_ops = {
>>   	.get_tag_protocol	= ksz8463_get_tag_protocol,
>>   	.connect_tag_protocol   = ksz8463_connect_tag_protocol,
>> -	.setup			= ksz8_setup,
>> -	.teardown		= ksz_teardown,
>> +	.setup			= ksz8463_setup,
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since the commit message says
> "PTP and interrupts aren't setup" and this hunk is rewriting exactly this ops
> table, it seems worth raising: ksz8463_switch_ops keeps advertising the PTP
> callbacks
> 
> 	.get_ts_info		= ksz_get_ts_info,
> 	.port_hwtstamp_get	= ksz_hwtstamp_get,
> 	.port_hwtstamp_set	= ksz_hwtstamp_set,
> 	.port_txtstamp		= ksz_port_txtstamp,
> 	.port_rxtstamp		= ksz_port_rxtstamp,
> 
> while no PTP clock is ever registered for this chip: the KSZ8463 entry in
> ksz_switch_chips[] does not set .ptp_capable, and ksz8463_setup() calls
> neither ksz_ptp_clock_register() nor ksz_ptp_irq_setup().  Those are the only
> places that run mutex_init(&ptp_data->lock), spin_lock_init(&ptp_data->
> clock_lock) and init_completion(&port->tstamp_msg_comp), so dev->ptp_data.
> clock stays NULL and those objects stay all-zero.
> 
> ksz_get_ts_info() checks for this, but ksz_hwtstamp_set() does not:
> 
> drivers/net/dsa/microchip/ksz_ptp.c:ksz_set_hwtstamp_config() {
> 	...
> 	return ksz_ptp_enable_mode(dev);
> }
> 
> drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_mode() {
> 	...
> 	if (tag_en) {
> 		ptp_schedule_worker(ptp_data->clock, 0);
> 	} else {
> 		ptp_cancel_worker_sync(ptp_data->clock);
> 	}
> 
> 	tagger_data->hwtstamp_set_state(dev->ds, tag_en);
> }
> 
> With CONFIG_NET_DSA_MICROCHIP_KSZ_PTP=y, does a SIOCSHWTSTAMP on a KSZ8463
> user port reach ptp_cancel_worker_sync(NULL) here, even for the
> HWTSTAMP_TX_OFF / FILTER_NONE combination, followed by an indirect call
> through the NULL tagger_data->hwtstamp_set_state (ksz8463_connect_tag_
> protocol() only assigns xmit_work_fn)?
> 
> Similarly, does the RX path take spin_lock_bh(&ptp_data->clock_lock) in
> ksz_tstamp_reconstruct() on a spinlock that was never initialized for this
> chip?
> 
> Would it make sense to drop these callbacks from ksz8463_switch_ops, or gate
> them on dev->info->ptp_capable, while this table is being restructured?  The
> same stale callbacks are present in ksz87xx_switch_ops.
> 
As it says, this isn't introduced by this patch and it will be fixed on 
PTP support is added on PATCH 10.


Best regards,
Bastien
