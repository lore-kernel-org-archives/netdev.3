Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66830674C;
	Fri, 31 Jul 2026 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464629; cv=none; b=q1F6daBUnwxoIJ92J2PIEiweqcr+QBI6Olh+xsJLrN424WBUtcmCIUZSXGysUn8G6v6THb7yWZPbLd60Pr7mKxMIpJ63IZQ7RSb1jERJDcnlpIL9cZN28Qo0ITa7HcugaAI9SAklURxBERvd8deuK0Js21xaWN7xXjDgECaBolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464629; c=relaxed/simple;
	bh=1p9CkoboVX6cSCQuU9f+xIlH6AuFxyBlFtL61A1ig8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU23J4XP7dV4hiPEzDAx5Ug6l7GJ3BhaHTOPSJCvgp2clSrHvvUurybOli4BH2hc2AhvhR7z9NPsFC1BJChS3nLrjrDyyDUjNHSfnho89PO+8SPVMrgz13YO5uxI0slGASZsOHS2gT91dRRtoYM/xy4pFPy3IKNDBvo3/BZ8wM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LATovILZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LATovILZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991EC1F000E9;
	Fri, 31 Jul 2026 02:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464627;
	bh=ZaEm1c5UMepB7WT49Z9d3s05X5VaZIyqZup08wI5VlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LATovILZ9GeRr/g1FiyhKuSsMY/OTc3T8MMChKvfQayM342CvymjgzpXMkfhkU13X
	 vjL2A2VtUiq0Der0QqazMsBNMwNzUj8YEYasf7kyFFpsk8TJOlQKqW/qVsxw9dPt5K
	 fRox36BJ30vRMBkhhaa/nWz3nesWjYiZpI8Bm1SBDc/YbJKsCk2vRhI4lMw+VrQo3U
	 RaqwDO6czH/TBNBFG9w9hphDs/yR8OKGhBJ0S0dA0PT4LYpf/UCTRupPglLZ2FLrol
	 +jWADNtyaIOkbjN6d9YCvGyicSlDBYniLFqR47e457jIz3X7l1FjV2M9mCtPV9+ltG
	 N6bRitenzHpIw==
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
Subject: Re: [PATCH net-next v3 10/10] net: dsa: microchip: add two-steps PTP support for KSZ8463
Date: Thu, 30 Jul 2026 19:23:46 -0700
Message-ID: <20260731022346.800416-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-ksz-new-ptp-v3-10-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-10-caba39e680e3@bootlin.com>
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
--- Patch [10]: [PATCH net-next v3 10/10] net: dsa: microchip: add two-steps PTP support for KSZ8463 ---
commit 17314cc888f74f2fde26bc0da770a948737b2b66
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

net: dsa: microchip: add two-steps PTP support for KSZ8463

This adds L2 two-step PTP timestamping for the KSZ8463 by registering the
generic KSZ PTP clock and adding KSZ8463-specific .get_ts_info and
.port_hwtstamp_set callbacks.  A new per-port last_tx_is_pdelayresp flag is
used to decide which of the two timestamp registers behind the shared
interrupt status bit should be read.

A few questions below.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index ac9e8ef5774a..941ae9f66f70 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -242,8 +242,11 @@ static int ksz8463_girq_setup(struct ksz_device *dev)
>  
>  static int ksz8463_reset_switch(struct ksz_device *dev)
>  {
> -	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
> -	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET,
> +	ksz_cfg(dev, KSZ8463_REG_SW_RESET,
> +		KSZ8463_GLOBAL_SOFTWARE_RESET | KSZ8463_PTP_SOFTWARE_RESET,
> +		true);
> +	ksz_cfg(dev, KSZ8463_REG_SW_RESET,
> +		KSZ8463_GLOBAL_SOFTWARE_RESET | KSZ8463_PTP_SOFTWARE_RESET,
>  		false);
>  	return 0;
>  }

[Severity: Low]
ksz8463_reset_switch() is called unconditionally from ksz8463_setup(),
before and independently of the "if (dev->irq > 0)" block, and
independently of CONFIG_NET_DSA_MICROCHIP_KSZ_PTP.

So the PTP reset domain (BIT(2) of 0x126) is now toggled also on boards
that never register a PTP clock, and in kernels built without the KSZ PTP
support.

The changelog only describes adding two-step PTP support and does not
mention resetting the PTP block.  Could the rationale be added to the
commit message, or the extra reset bit be moved into the PTP setup path?

> @@ -2474,17 +2477,24 @@ static int ksz8463_setup(struct dsa_switch *ds)
>  		ret = ksz8463_ptp_irq_setup(ds);
>  		if (ret)
>  			goto free_girq;
> +
> +		ret = ksz_ptp_clock_register(ds);
> +		if (ret) {
> +			dev_err(dev->dev, "Failed to register PTP clock: %d\n",
> +				ret);
> +			goto free_ptp_irq;
> +		}
>  	}

[Severity: Medium]
Does registering the generic clock here also advertise periodic output and
programmable pins that the KSZ8463 path does not implement?

ksz_ptp_clock_register() fills the capabilities unconditionally for every
chip:

	ptp_data->caps.enable		= ksz_ptp_enable;
	ptp_data->caps.verify		= ksz_ptp_verify_pin;
	ptp_data->caps.n_pins		= KSZ_PTP_N_GPIO;
	ptp_data->caps.n_per_out	= 3;
	...
	ptp_data->caps.pin_config = ptp_data->pin_config;

The trigger-output code behind those callbacks uses absolute KSZ9477 and
LAN937x register literals rather than dev->info->regs[], for example in
ksz_ptp_tou_reset() and ksz_ptp_configure_perout():

	ksz_rmw32(dev, REG_PTP_UNIT_INDEX__4,
		  PTP_GPIO_INDEX | PTP_TOU_INDEX, data32);   /* 0x0520 */
	...
	ksz_write32(dev, REG_TRIG_TARGET_NANOSEC, ...);     /* 0x0530+ */

On KSZ8463 the PTP block lives at 0x600 and above (ksz8463_regs[]:
PTP_CLK_CTRL 0x0600, PTP_MSG_CONF1 0x0620), and ksz8463_get_port_addr()
only relocates offsets >= 0x600, so 0x0520-0x0548 are not KSZ8463 PTP
registers.  The KSZ8463 32-bit regmap declares max_register = BIT(13) - 1
and the KSZ8463 entry in ksz_switch_chips[] has neither wr_table nor
rd_table, so these accesses are not filtered and reach the SPI bus.

ksz_ptp_verify_pin() accepts PTP_PF_PEROUT, and ksz_ptp_tou_gpio() returns
0 for anything that is not LAN937x, so a PTP_PIN_SETFUNC followed by
PTP_PEROUT_REQUEST on the new clock can report success while writing into
unrelated registers.  Should the pin/perout capabilities be left out for
this chip?

> @@ -3129,9 +3143,9 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
>  	.port_max_mtu		= ksz88xx_max_mtu,
>  	.suspend		= ksz_suspend,
>  	.resume			= ksz_resume,
> -	.get_ts_info		= ksz_get_ts_info,
> +	.get_ts_info		= ksz8463_get_ts_info,
>  	.port_hwtstamp_get	= ksz_hwtstamp_get,
> -	.port_hwtstamp_set	= ksz_hwtstamp_set,
> +	.port_hwtstamp_set	= ksz8463_hwtstamp_set,
>  	.port_txtstamp		= ksz_port_txtstamp,
>  	.port_rxtstamp		= ksz_port_rxtstamp,
>  	.port_setup_tc		= ksz8_setup_tc,

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index be6b8240ac03..9d8b78687f53 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -297,6 +297,31 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
>  			 tag_en ? PTP_ENABLE : 0);
>  }
>  
> +int ksz8463_get_ts_info(struct dsa_switch *ds, int port,
> +			struct kernel_ethtool_ts_info *ts)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz_ptp_data *ptp_data;
> +
> +	ptp_data = &dev->ptp_data;
> +
> +	if (!ptp_data->clock)
> +		return -ENODEV;
> +
> +	ts->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> +			      SOF_TIMESTAMPING_RX_HARDWARE |
> +			      SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	ts->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +
> +	ts->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +			 BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT);
> +
> +	ts->phc_index = ptp_clock_index(ptp_data->clock);
> +
> +	return 0;
> +}
> +

[Severity: Low]
This isn't a bug, but this is a near-verbatim copy of ksz_get_ts_info(),
with only tx_types and rx_filters differing, and ksz8463_hwtstamp_set()
below is a byte-for-byte copy of ksz_hwtstamp_set() apart from the inner
helper call.

ksz_get_ts_info() already differentiates chips inline:

	if (is_lan937x(dev))
		ts->tx_types |= BIT(HWTSTAMP_TX_ON);

and ksz_set_hwtstamp_config() does the same with:

	if (!is_lan937x(dev))
		return -ERANGE;

Could the KSZ8463 differences be expressed the same way, or through
ksz_chip_data fields, instead of a second pair of callbacks plus a second
set of "#define ... NULL" stubs in ksz_ptp.h?  As it stands the missing
clock check discussed below has to be fixed in two places.

> @@ -341,6 +366,72 @@ int ksz_hwtstamp_get(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static int ksz8463_set_hwtstamp_config(struct ksz_device *dev,
> +				       struct ksz_port *prt,
> +				       struct kernel_hwtstamp_config *config)
> +{
> +	const u16 *regs = dev->info->regs;
> +	int ret;
> +
> +	if (config->flags)
> +		return -EINVAL;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = false;
> +		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = false;
> +		prt->hwts_tx_en = false;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		prt->ptpmsg_irq[KSZ8463_SYNC_MSG].ts_en  = true;
> +		prt->ptpmsg_irq[KSZ8463_XDREQ_PDRES_MSG].ts_en = true;
> +		prt->hwts_tx_en = true;
> +
> +		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, 0);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		prt->hwts_rx_en = false;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
> +		prt->hwts_rx_en = true;
> +		break;
> +	default:
> +		config->rx_filter = HWTSTAMP_FILTER_NONE;
> +		return -ERANGE;
> +	}
> +
> +	return ksz_ptp_enable_mode(dev);
> +}

[Severity: Medium]
Only L2 filters are accepted here and the changelog says "IPv4 and IPv6
layers aren't supported", but should PTP_IPV4_UDP_ENABLE (BIT(4)) and
PTP_IPV6_UDP_ENABLE (BIT(3)) of PTP_MSG_CONF1 be cleared somewhere?

The only writes to that register are the set-only rmw in
ksz_ptp_clock_register():

	ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1],
			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE,
			PTP_TC_P2P | PTP_802_1AS | PTP_ETH_ENABLE);

and the PTP_1STEP clear above, so the transport-detect bits keep their
reset value.  With the new PTP soft reset in ksz8463_reset_switch() the
register is back at its hardware default, and the existing comment in
ksz8463_config_cpu_port() suggests the default is not zero on this chip:

	/* Turn off PTP function as the switch enables it by default */
	regmap_update_bits(ksz_regmap_16(dev), KSZ8463_PTP_MSG_CONF1,
			   PTP_ENABLE, 0);

If BIT(3)/BIT(4) are set after reset, UDP-encapsulated PTP frames are
detected too, and since PTP_802_1AS forwards detected PTP frames to the
host port only, L4 PTP traffic crossing the switch would be trapped and
could raise timestamp interrupts the driver does not expect.

> +
> +int ksz8463_hwtstamp_set(struct dsa_switch *ds, int port,
> +			 struct kernel_hwtstamp_config *config,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz_port *prt;
> +	int ret;
> +
> +	prt = &dev->ports[port];
> +
> +	ret = ksz8463_set_hwtstamp_config(dev, prt, config);
> +	if (ret)
> +		return ret;
> +
> +	prt->tstamp_config = *config;
> +
> +	return 0;
> +}
> +

[Severity: High]
This isn't a bug introduced by this patch, but can this path be reached on
a KSZ8463 without a PTP clock and oops?

ksz8463_get_ts_info() added above returns -ENODEV when ptp_data->clock is
NULL, while ksz8463_hwtstamp_set() has no such check and always ends in
ksz_ptp_enable_mode(), which does:

	if (tag_en)
		ptp_schedule_worker(ptp_data->clock, 0);
	else
		ptp_cancel_worker_sync(ptp_data->clock);

ksz8463_setup() only calls ksz_ptp_clock_register() (the sole place where
ptp_data->lock, ptp_data->clock_lock and ptp_data->clock are initialized)
inside "if (dev->irq > 0)", but ksz8463_switch_ops installs
.port_hwtstamp_set unconditionally, and dsa_user_hwtstamp_set() only
checks that the op pointer exists.

dev->irq comes from spi->irq in ksz_spi_probe() and is 0 when the DT node
describes no interrupt, which the driver supports.  In that case even a
trivial HWTSTAMP_TX_OFF plus HWTSTAMP_FILTER_NONE request ends in
ptp_cancel_worker_sync(NULL), which passes &ptp->aux_work to
kthread_cancel_delayed_work_sync().

The same hole existed before with the generic ksz_hwtstamp_set(), but the
new KSZ8463-specific copy keeps it while making the clock and lock
initialization conditional.  Would a "!ptp_data->clock" check, as done in
the new ksz8463_get_ts_info(), be appropriate here?

> @@ -571,6 +662,31 @@ static void ksz_ptp_txtstamp_skb(struct ksz_device *dev,
>  	skb_complete_tx_timestamp(skb, &hwtstamps);
>  }
>  
> +static void ksz8463_set_pdelayresp_flag(struct ksz_port *prt,
> +					struct sk_buff *skb)
> +{
> +	struct ptp_header *hdr;
> +	unsigned int type;
> +	u8 ptp_msg_type;
> +
> +	if (!ksz_is_ksz8463(prt->ksz_dev))
> +		return;
> +
> +	if (skb_linearize(skb))
> +		return;
> +
> +	type = ptp_classify_raw(skb);
> +	if (type == PTP_CLASS_NONE)
> +		return;
> +
> +	hdr = ptp_parse_header(skb, type);
> +	if (!hdr)
> +		return;
> +
> +	ptp_msg_type = ptp_get_msgtype(hdr, type);
> +	prt->last_tx_is_pdelayresp = (ptp_msg_type == PTP_MSGTYPE_PDELAY_RESP);
> +}
> +
>  void ksz_port_deferred_xmit(struct kthread_work *work)
>  {
>  	struct ksz_deferred_xmit_work *xmit_work = work_to_xmit_work(work);
> @@ -587,6 +703,8 @@ void ksz_port_deferred_xmit(struct kthread_work *work)
>  
>  	reinit_completion(&prt->tstamp_msg_comp);
>  
> +	ksz8463_set_pdelayresp_flag(prt, skb);
> +
>  	dsa_enqueue_skb(skb, skb->dev);
>  
>  	ksz_ptp_txtstamp_skb(dev, prt, clone);

[Severity: Medium]
Can a late timestamp interrupt observe the flag of the following packet?

prt->last_tx_is_pdelayresp is written here from the deferred-xmit kthread
and read from the threaded PTP interrupt in ksz_ptp_msg_thread_fn() ->
ksz_read_ts(), with no lock, no READ_ONCE()/WRITE_ONCE() and no barrier.

Correctness seems to depend on the interrupt for packet N always being
consumed before packet N+1 is queued, but ksz_ptp_txtstamp_skb() gives up
after a timeout:

	ret = wait_for_completion_timeout(&prt->tstamp_msg_comp,
					  msecs_to_jiffies(100));
	if (!ret)
		return;

So for a Pdelay_Resp whose interrupt is late, the worker can proceed to
the next frame (say a Pdelay_Req) and set the flag to false; the delayed
interrupt for the Pdelay_Resp then reads KSZ8463_REG_PORT_DREQ_TS instead
of DREQ_TS + KSZ8463_DRESP_TS_OFFSET and completes tstamp_msg_comp, so
that value is handed to skb_complete_tx_timestamp() for the next packet.

reinit_completion() is a plain "x->done = 0" while complete() takes
x->wait.lock, so it cannot discard the stale completion either.  Is there
something that ties an interrupt to the packet it belongs to?

> @@ -979,7 +1097,22 @@ void ksz_ptp_clock_unregister(struct dsa_switch *ds)
>  
>  static int ksz_read_ts(struct ksz_port *port, u16 reg, u32 *ts)
>  {
> -	return ksz_read32(port->ksz_dev, reg, ts);
> +	u16 ts_reg = reg;
> +
> +	/**
      ^^^^

[Severity: Low]
This isn't a bug, but "/**" is the kernel-doc marker and this is an
ordinary comment inside a function body, so plain "/*" would be better.

> +	 * On KSZ8463 DREQ and DRESP timestamps share one interrupt line
                                                          ^^^^^^^^^^^^^^

[Severity: Low]
The commit message says the two timestamps "share one interrupt bit
status", which matches the hardware: KSZ8463_REG_PORT_DREQ_TS and
KSZ8463_REG_PORT_DRESP_TS share a single status bit in
KSZ8463_PTP_TS_ISR rather than sitting on separate interrupt lines.  The
sentence is also missing a terminating period.

> +	 * so we have to check the nature of the latest event sent to know
> +	 * where the timestamp is located
> +	 */
> +	if (ksz_is_ksz8463(port->ksz_dev)) {
> +		const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
> +
> +		if (port->last_tx_is_pdelayresp &&
> +		    ts_reg == ops->get_port_addr(port->num, KSZ8463_REG_PORT_DREQ_TS))
> +			ts_reg += KSZ8463_DRESP_TS_OFFSET;
> +	}
> +
> +	return ksz_read32(port->ksz_dev, ts_reg, ts);
>  }

[ ... ]
