Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77D4963B2;
	Sat, 10 Oct 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633356; cv=none; b=ig6qU6/owfNaPF6lUmhiC6nrI5eNxZF04T36+naq4+O9mW90XksP2vO0NZPyMf/eAgFczsB7Jd7IANe0Im1eHPR6Wvw/awny2CYwZm+pcJc0GmpX+6bkqx9ngAY83xI6OG4UvqQIJ0TXO3//DjdUteWRwsMoWPIGAoUwq2kWJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633356; c=relaxed/simple;
	bh=/AXIXzh3M8/Zqb3nVHUigVQbUP8DWas6vKO6XBED1mc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kkutGGkxc7uzGXrEj1RAx6hLMRUZHKgGg4Xew+NarcY+aZWvzSFG5UrKrwHDcD9i6Ohiq3JWEnblk8fKse6j/y5VMg/FBX7lWaWhhhn2dePwrHSIx4rXgAEH5XnzLE3QKbyW5y4pulwOFP3SimPsjhQU1qOFDsYxjLV44Z+1ccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKwSqCYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKwSqCYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144211F000FF;
	Sat, 10 Oct 2026 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633350;
	bh=JYSadryjGjCm4oYr8oW5zRSHTnl2sIQvjbsGyQEsW2A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZKwSqCYpaxDvXxhv8+mEFLCFHupL9/Nzhs6bq8k/uIN+p2RPyUR3ATmkpbK/ZxXC7
	 WZFBUeccPEBIy6OphM08yn1hL5n8uevoaiGOSwTqDlBdU+qg4MPSFFdbqkaMiYGYc5
	 8BDwtgC7+6xE8b9fWA6R2ekXNrFU3lhqUCl2aqrOLZFO5u7LhLH54KAkOv6102N/GJ
	 ew+fBGCq08D1Z5b9unQmqSAzYJAcF/j/MKPaKA2YERfOT2c9q+0Jp+4STaw7UYkyHx
	 4JnBbA7RX0Wei+KqHyuOlycrdKQD0CwcxpbaruqqZubU5iHZ7MkO1NZS9ZASS6j80O
	 TLSJ/ywcjZVbw==
Subject: Re: [PATCH net-next 4/5] net: sparx5: Add hardware programming for
 the port policer
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 11:55:49 +0000
Message-ID: <179163334959.434549.9703436533189348032@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-p?=
 =?utf-8?q?olicers-v1-4-4916708a7ea2=40microchip=2Ecom=3E?=
References: =?utf-8?q?=3C20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-po?=
 =?utf-8?q?licers-v1-4-4916708a7ea2=40microchip=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In sparx5_port_policer_conf_set()
  (drivers/net/ethernet/microchip/sparx5/sparx5_police.c), the policer…
- [Medium] The driver now has two readings of the ANA_AC_PORT_SGE_CFG
  global event mask that cannot both be right.
- [Medium] sparx5_port_policer_cnt_get() reads
  ANA_AC_PORT_STAT_LSB_CNT(port, cnt) and then…
- [Medium] SPX5_POLICER_RATE_UNIT is hardcoded to 25040 bit/s for every
  target.
- [Low] Baseline decision: false positive.
- [Low] The ethtool policer-drop counter and the new tc drop counter
  count overlapping port-policer drop events with different…
- [Low] struct sparx5_policer::rate (u64, no unit documented) now means
  different things depending on pol->type.
- [Low] sparx5_port_policer_init() writes fixed event bit positions
  (BIT(4..7) for filter events, BIT(8..11) for pass events) to…
- [Low] On the enable path, sparx5_port_policer_conf_set() programs
  RATE_CFG and THRES_CFG_0 and then sets TRAFFIC_TYPE_MASK, as its…

--

net: sparx5: Add hardware programming for the port policer

This adds programming for the per-port ANA_AC_POL leaky bucket policers.
It also reads back the shared 40-bit pass and drop counters, which the
stats worker accumulates into 64-bit totals. The policers are
force-initialized and the shared counter events are selected at probe;
the policer is not yet reachable from tc.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_police.c b/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
> index c88820e83812c..48d51246699f5 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_police.c
> @@ -4,9 +4,47 @@

[ ... ]

> +/* Bit rate unit for the port policer (bits/sec) */
> +#define SPX5_POLICER_RATE_UNIT 25040

[Severity: Medium]
Is 25040 bit/s also the right unit on lan969x?

The rate per LSB looks tied to the policer update interval that
sparx5_init_coreclock() writes to ANA_AC_POL_UPD_INT_CFG. On sparx5,
312, 624 or 780 cycles at 250, 500 or 625 MHz all come to 1.248 us.
25040 bit/s * 1.248 us is exactly 1/32 bit per LSB per update.

lan969x uses a different interval:

sparx5_init_coreclock() {
    ...
	} else {
		pol_upd_int = 820; // SPX5_CORE_CLOCK_328MHZ
	}
    ...
}

820 cycles at 328 MHz is about 2.5 us, roughly twice as long. If the
per-LSB quantum is the same, one LSB on lan969x is worth about
12.5 kbit/s. sparx5_port_policer_conf_set() would then program about half
the requested rate. The max rate check in sparx5_add_port_policer() uses
the same fixed unit.

The lan969x PORT_RATE field is 19 bits instead of 20, which could point
the other way, so this may be fine.

Could the unit be confirmed for lan969x? Alternatively, it could be
derived per target, the way the service policer derives its tokens from
the clock.

> +/* Burst size unit for the port policer (bytes) */
> +#define SPX5_POLICER_BYTE_BURST_UNIT 8192

[ ... ]

> @@ -40,10 +78,65 @@ static int sparx5_policer_service_conf_set(struct sparx5 *sparx5,
>  	return 0;
>  }
>  
> +static int sparx5_port_policer_conf_set(struct sparx5 *sparx5,
> +					struct sparx5_policer *pol)
> +{
> +	u32 portno = pol->idx / SPX5_POLICERS_PER_PORT;
> +	u32 polidx = pol->idx % SPX5_POLICERS_PER_PORT;
> +	u32 rate, burst, mask, cfg;
> +	int cnt;
> +
> +	rate = DIV_ROUND_UP_ULL(pol->rate, SPX5_POLICER_RATE_UNIT);
> +	burst = DIV_ROUND_UP(pol->burst, SPX5_POLICER_BYTE_BURST_UNIT);
> +
> +	/* Disable the policer when rate and burst are both zero, otherwise
> +	 * apply it to known/unknown BUM traffic, CPU queues and learn frames.
> +	 */
> +	mask = (rate == 0 && burst == 0) ? 0 : 0x7f;

[Severity: Medium]
Does 0x7f cover every traffic type the comment lists?

ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK is GENMASK(7, 0). The comment
names known/unknown BUM traffic (six classes), CPU queues and learn
frames, which makes eight classes. 0x7f only sets bits 0-6, so bit 7 is
never enabled.

If bit 7 is the learn frame class, frames classified only under bit 7
would bypass the port policer. Should this be 0xff, or should the comment
be updated?

> +	if (mask) {
> +		/* Program the bucket before enabling the policer */
> +		spx5_wr(rate, sparx5, ANA_AC_POL_PORT_RATE_CFG(pol->idx));
> +		spx5_wr(burst, sparx5, ANA_AC_POL_PORT_THRES_CFG_0(pol->idx));
> +		spx5_rmw(ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK_SET(mask),
> +			 ANA_AC_POL_PORT_CFG_TRAFFIC_TYPE_MASK,
> +			 sparx5, ANA_AC_POL_PORT_CFG(portno, polidx));
> +	} else {

[ ... ]

> +	/* Count policer events, not bytes, for all eight priorities on the
> +	 * port's filter and pass counters, which are shared by all of the
> +	 * port's policer instances.
> +	 */
> +	cfg = ANA_AC_PORT_STAT_CFG_CFG_PRIO_MASK_SET(0xff) |
> +	      ANA_AC_PORT_STAT_CFG_CFG_CNT_FRM_TYPE_SET(SPX5_PPEM_EVENT) |
> +	      ANA_AC_PORT_STAT_CFG_CFG_CNT_BYTE_SET(0);

[Severity: Low]
The existing ethtool counter for port policer drops is set up with a
different frame type qualifier:

sparx5_config_port_stats() {
    ...
	/* Use counter for port policer drop count */
	spx5_rmw(ANA_AC_PORT_STAT_CFG_CFG_CNT_FRM_TYPE_SET(1) |
    ...
}

In the new enum, 1 is SPX5_PPEM_EVENT_NO_ERROR. Counters 1 and 2 here
use SPX5_PPEM_EVENT.

Is the difference intentional? If not, ethtool rx_port_policer_drop and
the tc drop count could disagree for the same policer when dropped frames
also carry the error qualifier.

> +
> +	for (cnt = SPX5_PORT_POLICER_FILTER_COUNTER;
> +	     cnt <= SPX5_PORT_POLICER_PASS_COUNTER; cnt++)
> +		spx5_rmw(cfg,
> +			 ANA_AC_PORT_STAT_CFG_CFG_PRIO_MASK |
> +			 ANA_AC_PORT_STAT_CFG_CFG_CNT_FRM_TYPE |
> +			 ANA_AC_PORT_STAT_CFG_CFG_CNT_BYTE,
> +			 sparx5, ANA_AC_PORT_STAT_CFG(portno, cnt));
> +
> +	spx5_rmw(ANA_AC_POL_PORT_GAP_GAP_VALUE_SET(SPX5_POLICER_LINE_RATE_GAP),
> +		 ANA_AC_POL_PORT_GAP_GAP_VALUE,
> +		 sparx5, ANA_AC_POL_PORT_GAP(portno));

[Severity: Low]
On the enable path the comment says the bucket is programmed before the
policer is enabled. However, ANA_AC_PORT_STAT_CFG and ANA_AC_POL_PORT_GAP
are only written after TRAFFIC_TYPE_MASK has been set.

For the first policer on a port, does this leave a short window where
the policer meters without the 20 byte gap? Counters 1 and 2 would also
run with their reset STAT_CFG during that window.

The raw snapshot in sparx5_init_port_policer_stats() is also taken
before STAT_CFG is programmed.

Would it make sense to write the GAP and STAT_CFG registers before
enabling the traffic type mask?

> +
> +	return 0;
> +}

[ ... ]

> @@ -52,3 +145,312 @@ int sparx5_policer_conf_set(struct sparx5 *sparx5, struct sparx5_policer *pol)
>  
>  	return 0;
>  }
> +
> +static u64 sparx5_port_policer_cnt_get(struct sparx5_port *port, u32 cnt)
> +{
> +	struct sparx5 *sparx5 = port->sparx5;
> +	u32 lsb, msb;
> +
> +	/* The MSB is latched when the LSB is read, so read the LSB first */
> +	lsb = spx5_rd(sparx5, ANA_AC_PORT_STAT_LSB_CNT(port->portno, cnt));
> +	msb = spx5_rd(sparx5, ANA_AC_PORT_STAT_MSB_CNT(port->portno, cnt));

[Severity: Medium]
Is the MSB latch per counter, or is it shared by all of the port's
STAT_CNT counters?

All the new readers hold queue_stats_lock. sparx5_get_ana_ac_stats_stats()
reads the LSB of counter 0 on the same port without that lock:

sparx5_get_ana_ac_stats_stats() {
	...
	sparx5_update_counter(&portstats[spx5_stats_ana_ac_port_stat_lsb_cnt],
			      spx5_rd(sparx5, ANA_AC_PORT_STAT_LSB_CNT(portno,
								       SPX5_PORT_POLICER_DROPS)));
}

That read can be reached from sparx5_get_sset_data() for ethtool -S. It
can run at the same time as:

sparx5_check_stats_work()
  sparx5_update_port_stats()
    sparx5_port_policer_stats_poll()

If the latch is shared, could the ethtool LSB read land between the LSB
and MSB reads here and overwrite the latched MSB?

sparx5_port_policer_cnt_accum() would then compute
"(cur - *raw) & SPX5_PORT_STAT_CNT_MASK" with a wrong cur. Once the
counter MSBs differ, that would leave a permanent 2^40 error in the
64-bit total reported to tc.

> +
> +	return (u64)msb << 32 | lsb;
> +}

[ ... ]

> +int sparx5_add_port_policer(struct sparx5_mall_entry *entry,
> +			    struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (police->burst > ANA_AC_POL_PORT_THRES_CFG_0_PORT_THRES0 *
> +			    SPX5_POLICER_BYTE_BURST_UNIT) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Policer parameters are not supported");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]
This may be fine, but burst is only checked against the upper bound. A
burst of 0 with a non-zero rate is accepted, and the policer is enabled
with PORT_THRES0 = 0.

As far as I can tell, software act_police also drops every packet when
the burst is 0, since tcf_police_act() never builds up positive tokens.
That would make the offload match software. lan966x and ocelot clamp a
zero burst instead.

Is the different behaviour here intentional?

[ ... ]

> +	pol.type = SPX5_POL_PORT;
> +	pol.rate = police->rate_bytes_ps * BITS_PER_BYTE;

[Severity: Low]
This isn't a bug, but struct sparx5_policer::rate now holds bit/s for
SPX5_POL_PORT. The service policer path in sparx5_tc_flower.c stores
kbit/s in the same field:

	pol->rate = div_u64(act->police.rate_bytes_ps, 1000) * 8;

sparx5_policer_service_conf_set() then multiplies it by 1000. Each path
is consistent today.

Could the unit be made the same for both types, or at least documented
per type? Otherwise a future caller of sparx5_policer_conf_set() could
end up off by a factor of 1000.

> +	pol.burst = police->burst;
> +	pol.idx = port->portno * SPX5_POLICERS_PER_PORT + idx;

[ ... ]

> +int sparx5_port_policer_init(struct sparx5 *sparx5)
> +{

[ ... ]

> +	/* Configure the port policer filter and pass statistics counters.
> +	 * Counter 0 is owned by sparx5_ethtool.c (SPX5_PORT_POLICER_DROPS).
> +	 */
> +	spx5_wr(SPX5_PORT_POLICER_0_FILTER_EVENT |
> +		SPX5_PORT_POLICER_1_FILTER_EVENT |
> +		SPX5_PORT_POLICER_2_FILTER_EVENT |
> +		SPX5_PORT_POLICER_3_FILTER_EVENT,
> +		sparx5, ANA_AC_PORT_SGE_CFG(SPX5_PORT_POLICER_FILTER_COUNTER));

[Severity: Medium]
How does this event layout fit with the existing setup of counter 0?

sparx5_config_stats() {
	/* Enable global events for port policer drops */
	spx5_rmw(ANA_AC_PORT_SGE_CFG_MASK_SET(0xf0f0),
		 ANA_AC_PORT_SGE_CFG_MASK,
		 sparx5,
		 ANA_AC_PORT_SGE_CFG(SPX5_PORT_POLICER_DROPS));
}

That code treats bits 4-7 and 12-15 as port policer drop events. The new
defines treat bits 4-7 as filter events and bits 8-11 as pass events.
Only bits 4-7 are routed to the tc drop counter.

If bits 12-15 are also policer drop events, would the drop count
reported by sparx5_update_port_policer_stats() miss drops? If they are
not, does the existing rx_port_policer_drop counter include unrelated
events?

Also, the new writes use spx5_wr() with raw bits instead of
ANA_AC_PORT_SGE_CFG_MASK_SET() as the existing code does.

> +
> +	spx5_wr(SPX5_PORT_POLICER_0_PASS_EVENT |
> +		SPX5_PORT_POLICER_1_PASS_EVENT |
> +		SPX5_PORT_POLICER_2_PASS_EVENT |
> +		SPX5_PORT_POLICER_3_PASS_EVENT,
> +		sparx5, ANA_AC_PORT_SGE_CFG(SPX5_PORT_POLICER_PASS_COUNTER));

[Severity: Low]
The same event bit positions are written on every target, but the
SGE_CFG mask width is different between the two families:

sparx5_regs.c:
	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 16,

lan969x/lan969x_regs.c:
	[FW_ANA_AC_PORT_SGE_CFG_MASK] = 17,

Is the lan969x event layout the same for bits 4-11, with the extra event
added at bit 16? If not, the tc pass and drop counters on lan969x would
count different events.

The existing 0xf0f0 mask in sparx5_config_stats() relies on the same
layout, so this may be fine.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v1-0-4916708a7ea2%40microchip.com
