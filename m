Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF142BE051;
	Fri, 31 Jul 2026 02:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464626; cv=none; b=XknAt/7Rj0Z1UsdHZcp41tRVigsjTYaHCtj9ufPPXS8UvenaMPIj8enrRV/MXwKJtjNWdaF6ici8wk90ED2jm4pj9S04MNqLcJSlBGHsyvFYKL0+e+PQzjFxrO73RfldJiLmrDVbAUClDkqoMIULHKiRYQUqVMJTfQ+oKj6YDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464626; c=relaxed/simple;
	bh=Af/0Tll/x5MAukh8YYoXnOu76iU/eFGtMVsp59fksGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMKSkgvKxpzneu3dYB0pxHGxCGxorwA+rGK+LEjf2TzV3ApYffsXxWXLDW3Exjxv+pxduTb3gHV1Sal2iQVPQBnQXHMZY/TmlJIfuaacpnX3QGX52WsqKHnC7X3YOfy/k5ybMsy8yEseqMaTBk9IEu4GecouL8YAXT3eoeVuqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efHvK2Bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efHvK2Bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97211F00A3A;
	Fri, 31 Jul 2026 02:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464623;
	bh=Xq5D5D5UBULRT1pQwx3l2JAzpuNpLWOGp61ilHXePPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efHvK2Bl7KuW3knR0AuFevq+HaWZah61aDbydH8Crw6zuN6GXIckgjXVnctVHYAy4
	 t9nMW95nX/ESt1zNv9q9JzAKU8+0NIlCxLU78ULb4KFhw6nt121dO1waU4a20bsVna
	 90VTcrHtE3YjhKBzecJySDFL1i++794ynwMWatklZwAk4CCi6wGrgNGDx+bpbDQ4yV
	 XKQIomhd0PX6NHuNi4lwdB8HX1KjHaso22ptrmVokx5plQdklSr0Bf5rHfJamVWE2S
	 MnycGhMuYst01pyXsFBq874KH2C3Y5V0xPirUeAkH2jeQuE+SAH+mwbjJFVH50/esL
	 XiHi4ddMY0pJg==
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
Subject: Re: [PATCH net-next v3 04/10] net: dsa: microchip: add PTP interrupt handling for KSZ8463
Date: Thu, 30 Jul 2026 19:23:41 -0700
Message-ID: <20260731022341.800305-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-ksz-new-ptp-v3-4-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-4-caba39e680e3@bootlin.com>
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
--- Patch [4]: [PATCH net-next v3 04/10] net: dsa: microchip: add PTP interrupt handling for KSZ8463 ---
commit 0135c84c1b18f8d3665107436a050b472916ca2f
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

net: dsa: microchip: add PTP interrupt handling for KSZ8463

This adds a KSZ8463-specific global interrupt domain (16-bit enable
register, one shared status register, only the high byte used) and
KSZ8463-specific PTP interrupt setup/teardown that reuse the existing
interrupt handlers. A .teardown callback is added to release the
interrupts.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 3bbca6f9cfc5a..c099a7005808b 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -36,6 +36,13 @@
>  #include "ksz8_reg.h"
>  #include "ksz8.h"
>  
> +/*
> + * We use only the high-byte (so odd addresses) of the 16-bits registers to fit
> + * in the common IRQ framework
> + */
> +#define KSZ8463_REG_ISR			0x191
> +#define KSZ8463_REG_IER			0x193
> +
>  /* ksz88x3_drive_strengths - Drive strength mapping for KSZ8863, KSZ8873, ..
>   *			     variants.
>   * This values are documented in KSZ8873 and KSZ8863 datasheets.
> @@ -181,6 +188,58 @@ static int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 dat
>  	return ksz8_ind_write8(dev, table, (u8)(offset), data);
>  }
>  

[ ... ]

> +static int ksz8463_girq_setup(struct ksz_device *dev)
> +{
> +	struct ksz_irq *girq = &dev->girq;
> +
> +	girq->nirqs = 8;
> +	girq->reg_mask = KSZ8463_REG_IER;
> +	girq->reg_status = KSZ8463_REG_ISR;
> +	girq->masked = 0;
> +	snprintf(girq->name, sizeof(girq->name), "ksz8463-girq");
> +
> +	girq->irq_num = dev->irq;
> +
> +	return ksz_irq_common_setup(dev, girq, &ksz8463_irq_domain_ops);
> +}

[Severity: Medium]
ksz_irq_common_setup() requests the generic ksz_irq_thread_fn(), which only
reads the status register and dispatches nested IRQs:

	ret = ksz_read8(dev, kirq->reg_status, &data);
	...
	for (n = 0; n < kirq->nirqs; ++n) {
		if (data & BIT(n)) {
			sub_irq = irq_find_mapping(kirq->domain, n);
			handle_nested_irq(sub_irq);
			++nhandled;

It never writes reg_status back. That is fine for KSZ9477/LAN937x, where
REG_SW_PORT_INT_STATUS__1 is a read-only aggregation of the per-port status
registers. Is the KSZ8463 global status register latched write-1-to-clear
instead? The driver's own handler for the sibling register on this chip
treats it that way, in ksz_ptp_irq_thread_fn():

	/* Clear the interrupts W1C */
	ret = ksz_write16(dev, ptpirq->reg_status, data);

If the global bit is latched, is there anything in the new path that
acknowledges it? The level-triggered IRQF_ONESHOT parent would stay asserted
and the threaded handler re-entered indefinitely over SPI.

Related to that: girq->nirqs = 8 creates mappings for all eight high-byte
bits while only bit 4 ever gets an action. handle_nested_irq() on a virq
without an action returns immediately, yet nhandled is still incremented, so
the parent always returns IRQ_HANDLED and the "nobody cared" spurious
interrupt detection can never fire. Should the mapping count be limited to
the bits that are actually used?

>  static int ksz8463_reset_switch(struct ksz_device *dev)
>  {
>  	ksz_cfg(dev, KSZ8463_REG_SW_RESET, KSZ8463_GLOBAL_SOFTWARE_RESET, true);
> @@ -2407,21 +2466,50 @@ static int ksz8463_setup(struct dsa_switch *ds)
>  	p = &dev->ports[dev->cpu_port];
>  	p->learning = true;
>  
> +	if (dev->irq > 0) {
> +		ret = ksz8463_girq_setup(dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = ksz8463_ptp_irq_setup(ds);
> +		if (ret)
> +			goto free_girq;
> +	}
> +

[Severity: High]
The PTP interrupt path is enabled here, but the KSZ8463 entry in
ksz_switch_chips[] has no .ptp_capable and ksz8463_setup() never calls
ksz_ptp_clock_register(). Is the PTP state these handlers consume ever
initialized?

ksz_ptp_clock_register() is the only place that runs:

	mutex_init(&ptp_data->lock);
	spin_lock_init(&ptp_data->clock_lock);
	...
	ret = ksz_ptp_start_clock(dev);
	...
	ptp_data->clock = ptp_clock_register(&ptp_data->caps, dev->dev);

The handler requested below, ksz_ptp_msg_thread_fn(), calls
ksz_tstamp_reconstruct(), which does:

	spin_lock_bh(&ptp_data->clock_lock);
	ptp_clock_time = ptp_data->clock_time;
	spin_unlock_bh(&ptp_data->clock_lock);

For KSZ8463 that spinlock is never initialized (spinlock bad magic with
CONFIG_DEBUG_SPINLOCK, "trying to register non-static key" with lockdep) and
clock_time is never advanced by an aux worker, so timestamps produced by the
new interrupt path come from an all-zero clock time.

In the same configuration ptp_data->clock stays NULL while
ksz8463_switch_ops still exports .port_hwtstamp_set = ksz_hwtstamp_set, and
ksz_set_hwtstamp_config() ends in ksz_ptp_enable_mode():

	if (tag_en) {
		ptp_schedule_worker(ptp_data->clock, 0);
	} else {
		ptp_cancel_worker_sync(ptp_data->clock);
	}

ptp_schedule_worker() dereferences ptp->kworker unconditionally, so does a
SIOCSHWTSTAMP on a KSZ8463 user port oops here? Should this hunk also set
.ptp_capable for KSZ8463 and call ksz_ptp_clock_register(), as
ksz8_setup()/ksz9477_setup() do?

>  	ret = ksz_mdio_register(dev);
>  	if (ret < 0) {
>  		dev_err(dev->dev, "failed to register the mdio");
> -		return ret;
> +		goto free_ptp_irq;
>  	}
>  
>  	ret = ksz_dcb_init(dev);
>  	if (ret)
> -		return ret;
> +		goto free_ptp_irq;

[Severity: Medium]
Making dev->irq > 0 a supported configuration for KSZ8463 also makes
ksz_mdio_register() -> ksz_irq_phy_setup() reachable, and that function does:

	irq = irq_find_mapping(dev->ports[port].pirq.domain,
			       PORT_SRC_PHY_INT);
	if (!irq) {
		ret = -EINVAL;

ksz8463_setup() never calls ksz_pirq_setup(), so dev->ports[].pirq.domain
stays NULL. __irq_resolve_mapping() substitutes irq_default_domain when the
domain pointer is NULL. On platforms without a default domain the lookup
returns 0 and KSZ8463 setup fails with -EINVAL for every device tree that has
both an interrupts property and an mdio node with internal PHY handles. On
platforms that install a default host, doesn't the returned virq belong to an
unrelated interrupt controller, which is then stored in
ds->user_mii_bus->irq[phy], request_irq()'ed by phylib and later disposed by
ksz_irq_phy_free()?

Separately, the goto free_ptp_irq taken when ksz_dcb_init() fails runs after
ksz_mdio_register() has succeeded. Does that path leak the PHY IRQ mappings
acquired inside ksz_mdio_register(), since ksz_irq_phy_free() is not called?

>  
>  	/* start switch */
>  	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
>  			   SW_START, SW_START);
>  
>  	return 0;
> +
> +free_ptp_irq:
> +	if (dev->irq > 0)
> +		ksz8463_ptp_irq_free(ds);
> +free_girq:
> +	if (dev->irq > 0)
> +		ksz_irq_free(&dev->girq);
> +
> +	return ret;
> +}

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 8b98039320add..89fbc1253f252 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c

[ ... ]

> @@ -1129,6 +1138,128 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
>  	return ret;
>  }
>  
> +static int ksz8463_ptp_port_irq_setup(struct ksz_irq *ptpirq,
> +				      struct ksz_port *port, int hw_irq)
> +{
> +	u16 ts_reg[] = {KSZ8463_REG_PORT_SYNC_TS, KSZ8463_REG_PORT_DREQ_TS};
> +	static const char * const name[] = {"sync-msg", "delay-msg"};

[Severity: Medium]
This gives ptpmsg_irq[] different index semantics than the rest of the
driver: slot 0 is sync-msg and slot 1 is delay-msg here, and only slots 0 and
1 are mapped. But ksz_ptp_reg.h defines:

	#define KSZ_SYNC_MSG			2
	#define KSZ_XDREQ_MSG			1
	#define KSZ_PDRES_MSG			0

and the shared ksz_set_hwtstamp_config(), reachable for KSZ8463 because
ksz8463_switch_ops sets .port_hwtstamp_set = ksz_hwtstamp_set, indexes the
same array with those constants:

	prt->ptpmsg_irq[KSZ_SYNC_MSG].ts_en  = false;
	prt->ptpmsg_irq[KSZ_XDREQ_MSG].ts_en = true;
	prt->ptpmsg_irq[KSZ_PDRES_MSG].ts_en = false;

So on KSZ8463 the Sync handler in slot 0 is gated by the Pdelay_Resp flag,
and every write to ptpmsg_irq[KSZ_SYNC_MSG] lands in slot 2, which has no
mapping, no handler and no port back-pointer.

In the two TX modes currently accepted for this chip both of those flags end
up false, so no wrong timestamp is observable today. Should KSZ8463-specific
index constants be added, or the shared code taught about this layout, so the
gating does not silently go to the wrong handler once two-step TX
timestamping is supported?

> +	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
> +	struct ksz_ptp_irq *ptpmsg_irq;
> +	int ret;
> +	int i;
> +
> +	init_completion(&port->tstamp_msg_comp);

[Severity: High]
This isn't a bug introduced by this patch, but the initialization of
port->tstamp_msg_comp now happens only on the dev->irq > 0 path. Before this
series it was never initialized for KSZ8463 at all, and a KSZ8463 without an
interrupt keeps that behaviour while ksz8463_switch_ops exports
.port_hwtstamp_set/.port_txtstamp and ksz_set_hwtstamp_config() checks
neither ptp_capable, nor the clock, nor dev->irq.

After HWTSTAMP_TX_ONESTEP_P2P is accepted, the transmit path runs:

ksz_port_deferred_xmit()
	reinit_completion(&prt->tstamp_msg_comp);
	dsa_enqueue_skb(skb, skb->dev);
	ksz_ptp_txtstamp_skb(dev, prt, clone);

ksz_ptp_txtstamp_skb()
	ret = wait_for_completion_timeout(&prt->tstamp_msg_comp,
					  msecs_to_jiffies(100));

on an all-zero struct completion, where x->wait.head has NULL next/prev, so
__add_wait_queue_entry_tail() inside do_wait_for_common() dereferences NULL.

Could the completion be initialized unconditionally, or the hwtstamp
configuration be rejected when the PTP interrupt infrastructure was not set
up?

> +
> +	for (i = 0; i < 2; i++) {
> +		ptpmsg_irq = &port->ptpmsg_irq[i];
> +		ptpmsg_irq->num = irq_create_mapping(ptpirq->domain,
> +						     hw_irq + i);
> +		if (!ptpmsg_irq->num) {
> +			ret = -EINVAL;
> +			goto release_msg_irq;
> +		}
> +
> +		ptpmsg_irq->port = port;
> +		ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[i]);

[Severity: Medium]
The commit message says "xdelay_req and pdresp timestamps share one single
interrupt bit on the KSZ8463", but the single delay-msg handler bound to that
shared bit has its ts_reg hard-wired to KSZ8463_REG_PORT_DREQ_TS, and the
newly added KSZ8463_REG_PORT_DRESP_TS has no user anywhere in the tree.

ksz_ptp_msg_thread_fn() cannot distinguish the two events:

	if (ptpmsg_irq->ts_en) {
		ret = ksz_read_ts(port, ptpmsg_irq->ts_reg, &tstamp_raw);
		...
		complete(&port->tstamp_msg_comp);

In HWTSTAMP_TX_ONESTEP_P2P, ksz_port_txtstamp() returns early for
PTP_MSGTYPE_PDELAY_RESP (correction field update, no clone, no waiter), while
ptpmsg_irq[KSZ_XDREQ_MSG].ts_en stays true. If a transmitted Pdelay_Resp
raises the shared bit inside the window opened by reinit_completion() in
ksz_port_deferred_xmit() and the wait in ksz_ptp_txtstamp_skb(), does the
Pdelay_Req waiter then return early with the value read from DREQ_TS for an
unrelated event?

Since ts_en has to stay true for Delay_Req in the only supported TX mode, is
there any way to filter the pdresp event in software here?

> +
> +		strscpy(ptpmsg_irq->name, name[i]);
> +
> +		ret = request_threaded_irq(ptpmsg_irq->num, NULL,
> +					   ksz_ptp_msg_thread_fn, IRQF_ONESHOT,
> +					   ptpmsg_irq->name, ptpmsg_irq);
> +		if (ret) {
> +			irq_dispose_mapping(ptpmsg_irq->num);
> +			goto release_msg_irq;
> +		}
> +	}
> +
> +	return 0;
> +
> +release_msg_irq:
> +	while (i--)
> +		ksz_ptp_msg_irq_free(port, i);
> +
> +	return ret;
> +}
> +

[ ... ]

> +int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	struct ksz_port *port1, *port2;
> +	struct ksz_irq *ptpirq;
> +	int ret;
> +
> +	port1 = &dev->ports[0];
> +	port2 = &dev->ports[1];
> +	ptpirq = &port1->ptpirq;

[Severity: Low]
This isn't a bug, but the domain and all of its bookkeeping (irq_num, nirqs,
reg_mask, reg_status, irq0_offset, name) are switch-global for the KSZ8463
while being stored in dev->ports[0].ptpirq, and both this function and
ksz8463_ptp_irq_free() hardcode port indices 0 and 1 instead of iterating
with dsa_switch_for_each_user_port(), which is what
ksz8_setup()/ksz9477_setup()/lan937x_setup() use.

dev->ports[1].ptpirq stays all-zero while ports[1].ptpmsg_irq[] is populated
from a domain owned by port 0, so struct ksz_port::ptpirq means something
different depending on the chip, and generic code that assumed it was valid
per port would end up calling irq_domain_remove(NULL) or free_irq(0).

Would placing the shared domain in struct ksz_device next to girq, and
iterating user ports for the per-port message IRQs, be preferable?

> +
> +	ptpirq->irq_num = irq_find_mapping(dev->girq.domain,
> +					   KSZ8463_SRC_PTP_INT);
> +	if (!ptpirq->irq_num)
> +		return -EINVAL;
> +

[ ... ]
