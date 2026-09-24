Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1747DD50;
	Thu, 24 Sep 2026 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250687; cv=none; b=ZftCQ8H4BnhsFOJoAO/MUaDPgn7OLTlFvf2Hg9+x65UoYtB20XwAYog5RDXtyJRNxDDgML+f5LBC55FwjB8fAtvb2A7AlGe50v1tjhxER2xr5d7tluM5W6FxD2UjX5sZ7o0YxjvVOq9ydO0lP+tFr8w5bGdvpto64xyAP87ff+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250687; c=relaxed/simple;
	bh=MusBnTOChPoV+srNtKakus46vEYEj815g06JD4xfTRU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lO17jADxxR8Ig0rwpgB9/Afqacx2NYmQkCXUA7mnSyXjZilUxX6gHM0arkrvw/8zsPEnCgyCGL4LB7dXL78HtpngkfVbz4Re1OxcZrGK643Dg0nW5JlQGkQJGcjtxIz3xRePuXSikbMQak2qf7UpTzgTa5ahCz/jlQFOrd/qDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUjVm+rE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUjVm+rE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7191F00893;
	Thu, 24 Sep 2026 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790250685;
	bh=k0nMg32DrVUc2NyanW8++liQIKIfpYIw75TtSAlsW0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iUjVm+rETIAGDsgpE6VNkSDgIpwAX1JJ8iQ6GtbeVdk1I0L4pCLD/947ZwqipCHnr
	 t93ABiTC1dR2HlALisW3mDNbufc85xAN4AxIremAZamOaRj+GdRY4L+zndXVCZu6t6
	 IYMepZXIS/ZmO+xQHmhG1BLjSASytpOwvX7PsRws9Xn5Y9Zkv+tRKfuEaU+pAc3bzY
	 Tst3DJGRjddeeYVn3UvfAZuK/uE7ujw+7kdz5/olIzjM1IpLiH9o/MMsHicYX/91Fc
	 BYVXFdlEgyDO4/Eowq36P9A+A3TiJ9Od/ykN7JAnv1ebb9QC9GVtjNRA+s4y0vbDl8
	 E0WJ3EF1QmerQ==
Subject: Re: [PATCH net-next v5 05/10] net: ethernet: ravb: Propagate error
 from ptp_clock_register()
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Thu, 24 Sep 2026 11:51:24 +0000
Message-ID: <179025068426.2160803.13930648223749405503@kernel.org>
In-Reply-To: <20260921175037.4084310-6-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-6-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Replacing the cached PHC index with a live dereference re-
  creates a check-then-use of priv->ptp.clock against clock destruction.
- [High] ravb_ptp_stop() no longer detaches priv->ptp.clock before
  disabling the gPTP interrupt and synchronizing IRQs.
- [High] For gptp (Gen2/RZ-V2M) hardware the only gPTP teardown call now
  sits at the end of ravb_stop_dma() (`/* Stop PTP Clock driver */ if…
- [Medium] ravb_get_ts_info() now gates the *static* hardware-
  timestamping capability report on the runtime presence of a registered…
- [Medium] ravb_ptp_init() now publishes the raw ptp_clock_register()
  result — possibly an ERR_PTR — into the shared field priv->ptp.clock…
- [Low] Concern: ravb_ptp_init() is converted to return an errno (and
  drops the previous netdev_err() diagnostic), but both callers in this…

--

net: ethernet: ravb: Propagate error from ptp_clock_register()

This changes ravb_ptp_init() from void to int so that a failing
ptp_clock_register() can be reported to callers, stores the clock pointer
directly in priv->ptp.clock, and drops the cached phc_index in favour of
calling ptp_clock_index() from ravb_get_ts_info().

Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1

I have a few questions about the interaction with the two recent PTP
fixes in this driver.

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index aa45f5466001d..0c122a8158409 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1028,7 +1028,6 @@ struct ravb_ptp_perout {
>  struct ravb_ptp {
>  	struct ptp_clock *clock;
>  	struct ptp_clock_info info;
> -	int phc_index;
>  	u32 default_addend;
>  	u32 current_addend;
>  	int extts[N_EXT_TS];
> @@ -1163,7 +1162,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
>  int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
>  
>  void ravb_ptp_interrupt(struct net_device *ndev);
> -void ravb_ptp_init(struct net_device *ndev);
> +int ravb_ptp_init(struct net_device *ndev);
>  void ravb_ptp_stop(struct net_device *ndev);
>  
>  #endif	/* #ifndef __RAVB_H__ */
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 1dfe905832a0e..db3ef87f09912 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1774,7 +1774,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *hw_info = priv->info;
>  
> -	if (hw_info->gptp || hw_info->ccc_gac) {
> +	if (priv->ptp.clock && (hw_info->gptp || hw_info->ccc_gac)) {

[Severity: Medium]
Is it intentional that the runtime clock check now gates the whole static
capability block in ravb_get_ts_info(), and not just the phc_index lookup?

so_timestamping, tx_types and rx_filters are all inside this if (), so
ethtool -T reports zeroes whenever no PHC happens to be registered:

  - before the first open and after ravb_close()
  - for gptp (Gen2) parts the clock only exists between ravb_dmac_init()
    and ravb_stop_dma(), so also during the stop/re-init window used by
    ravb_set_ringparam() and ravb_tx_timeout_work()
  - permanently on CONFIG_PTP_1588_CLOCK=n builds, since ravb only
    depends on PTP_1588_CLOCK_OPTIONAL and the stub
    ptp_clock_register() returns NULL

The ethtool core only ORs in the software bits it owns:

net/ethtool/common.c:__ethtool_get_ts_info() {
	...
	info->so_timestamping |= SOF_TIMESTAMPING_RX_SOFTWARE |
				 SOF_TIMESTAMPING_SOFTWARE;
	...
}

so SOF_TIMESTAMPING_TX_SOFTWARE disappears from the report on a down
interface, even though ravb_start_xmit() calls skb_tx_timestamp()
unconditionally.

The peer ABI also disagrees with the new report: ravb_hwtstamp_set()
still accepts HWTSTAMP_TX_ON and coerces unknown filters to
HWTSTAMP_FILTER_ALL without looking at priv->ptp.clock or hw_info.

This looks like a partial revert of commit 1f77af0aaf27 ("net: ravb:
avoid dereferencing an invalid PTP clock"), whose changelog says the
cached index was added to preserve the static timestamping capabilities.
Could the commit message mention this user-visible change, since it
currently only describes propagating the registration error?

Note this behaviour also remains at the end of the series, where
ravb_gen2_ptp_clock_index() returns -ENODEV with no clock and
ravb_get_ts_info() fills the block only if (index >= 0).

>  		info->so_timestamping =
>  			SOF_TIMESTAMPING_TX_SOFTWARE |
>  			SOF_TIMESTAMPING_TX_HARDWARE |
> @@ -1785,7 +1785,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  			(1 << HWTSTAMP_FILTER_NONE) |
>  			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
>  			(1 << HWTSTAMP_FILTER_ALL);
> -		info->phc_index = READ_ONCE(priv->ptp.phc_index);
> +		info->phc_index = ptp_clock_index(priv->ptp.clock);

[Severity: High]
Can this dereference a freed ptp_clock?

priv->ptp.clock is loaded twice here with plain loads, once for the
non-NULL test and once as the argument of the out-of-module call
ptp_clock_index(), which is just:

drivers/ptp/ptp_clock.c:ptp_clock_index() {
	return ptp->index;
}

Nothing keeps the object alive between the test and the dereference, and
with this patch ravb_ptp_stop() leaves the pointer published for the
whole duration of the freeing unregister:

	if (priv->ptp.clock) {
		ptp_clock_unregister(priv->ptp.clock);
		priv->ptp.clock = NULL;
	}

drivers/ptp/ptp_clock.c:ptp_clock_unregister() {
	...
	/* The final put, normally here, will invoke ptp_clock_release(). */
	put_device(&ptp->dev);
}

ravb_get_ts_info() can run without RTNL. An unprivileged task can bind
an AF_INET6 socket to a link-local address with sin6_scope_id
(__inet6_bind() sets sk->sk_bound_dev_if with no capability check) and
then loop:

setsockopt(SO_TIMESTAMPING, SOF_TIMESTAMPING_BIND_PHC)
  sock_timestamping_bind_phc()
    ethtool_get_phc_vclocks()
      __ethtool_get_ts_info()
        ravb_get_ts_info()

holding only a netdevice reference. The RCU section in
__ethtool_get_ts_info() protects dev->hwprov, and a ptp_clock is not
RCU-freed. Meanwhile ravb_ptp_stop() runs from ravb_close() (ip link set
down, PM suspend) or from ravb_stop_dma() on tx-timeout recovery.

Commit 1f77af0aaf27 ("net: ravb: avoid dereferencing an invalid PTP
clock") removed exactly this by caching phc_index and reading it with
READ_ONCE(). Would keeping the cached index, or at least loading the
pointer once and detaching it before unregistering, be preferable here?

The same check-then-dereference is still present at the end of the
series in ravb_gen2_ptp_clock_index():

	if (!priv->ptp.clock)
		return -ENODEV;

	return ptp_clock_index(priv->ptp.clock);

>  	}
>  
>  	return 0;

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index 6817e94721b57..407ae97b76bbb 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -338,15 +338,14 @@ void ravb_ptp_init(struct net_device *ndev)
>  	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
> -	if (IS_ERR(clock)) {
> -		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
> -		clock = NULL;
> +	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
> +	if (IS_ERR(priv->ptp.clock)) {
> +		ret = PTR_ERR(priv->ptp.clock);
> +		priv->ptp.clock = NULL;
> +		ravb_ptp_stop(ndev);
>  	}

[Severity: Medium]
Is publishing the raw ptp_clock_register() result into priv->ptp.clock
safe, given that an ERR_PTR is visible until the following assignment
normalizes it to NULL?

The previous code normalized first and published afterwards:

	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
	if (IS_ERR(clock)) {
		...
		clock = NULL;
	}
	WRITE_ONCE(priv->ptp.clock, clock);

Commit 1f77af0aaf27 describes that ordering as deliberate: "Registration
failures can also leave an error pointer in priv->ptp.clock ... Normalize
registration errors to NULL".

All consumers only test for NULL, so an ERR_PTR passes:

ravb_ptp_interrupt():
	struct ptp_clock *clock = READ_ONCE(priv->ptp.clock);
	...
	if ((gis & GIS_PTCF) && clock)
		ptp_clock_event(clock, &event);

ravb_get_ts_info():
	if (priv->ptp.clock && (hw_info->gptp || hw_info->ccc_gac)) {
		...
		info->phc_index = ptp_clock_index(priv->ptp.clock);

A reader landing in that window would dereference something like
0xfffffffffffffff4. The window is narrow and requires
ptp_clock_register() to fail, but would assigning to a local and
publishing the normalized value keep the property that commit installed?

As a side note, the WRITE_ONCE() on the store side is gone while
ravb_ptp_interrupt() still uses READ_ONCE(), so the annotations are no
longer paired.

[Severity: Low]
The netdev_err() message is dropped here, and in this commit both
callers still discard the new return value: ravb_dmac_init() calls
ravb_ptp_init(ndev) and then returns 0, and ravb_open() calls it and
continues to ravb_phy_start()/netif_tx_start_all_queues().

The commit message explains this is preparatory, and the later patch
"net: ethernet: ravb: Replace gPTP flags with callbacks" does consume the
error via info->ptp->dmac_start() and info->ptp->ndev_open(), so the only
lasting change appears to be the lost diagnostic. Would it be worth
keeping a message on the failure path, or mentioning its removal?

>  
> -	WRITE_ONCE(priv->ptp.clock, clock);
> -	if (clock)
> -		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
> +	return ret;
>  }
>  
>  static void ravb_ptp_disable(struct net_device *ndev)
> @@ -369,14 +368,12 @@ static void ravb_ptp_sync_irqs(struct net_device *ndev)
>  void ravb_ptp_stop(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	struct ptp_clock *clock;
> -
> -	WRITE_ONCE(priv->ptp.phc_index, -1);
> -	clock = xchg(&priv->ptp.clock, NULL);
>  
>  	ravb_ptp_disable(ndev);
>  	ravb_ptp_sync_irqs(ndev);
>  
> -	if (clock)
> -		ptp_clock_unregister(clock);
> +	if (priv->ptp.clock) {
> +		ptp_clock_unregister(priv->ptp.clock);
> +		priv->ptp.clock = NULL;
> +	}
>  }

[Severity: High]
Dropping the xchg() means the pointer stays published across
ptp_clock_unregister(). Can ravb_ptp_interrupt() still pick it up and
use a freed clock?

Commit 1cb9663789c5 ("net: ravb: serialize PTP clock teardown") added
that detach for this reason: "ravb_ptp_interrupt() can race with
ravb_ptp_stop() and pass the clock to ptp_clock_event() while
ptp_clock_unregister() is freeing it."

The remaining protection is the hardware state (GIC = 0 plus
gis &= ravb_read(ndev, GIC) in the handler), but the PTP chardev stays
live until posix_clock_unregister() completes inside
ptp_clock_unregister(), so a concurrent ioctl can re-arm the interrupt
after ravb_ptp_disable() ran:

ravb_ptp_extts() {
	...
	if (!info->irq_en_dis)
		ravb_modify(ndev, GIC, GIC_PTCE, on ? GIC_PTCE : 0);
	else if (on)
		ravb_write(ndev, GIE_PTCS, GIE);
}

ravb_ptp_perout() does the same for GIC_PTME. Note also that
ravb_ptp_disable() writes GIC without priv->lock, so the locked
read-modify-write in ravb_ptp_extts() can simply undo it.

The generic cleanup does not cover ravb either, since
ptp_disable_all_events() only touches pin-configured EXTTS sources and
PPS:

drivers/ptp/ptp_chardev.c:ptp_disable_all_events() {
	for (i = 0; i < info->n_pins; i++)
		if (info->pin_config[i].func == PTP_PF_EXTTS)
			ptp_disable_pinfunc(...);
	...
}

and ravb registers no pins and no PPS.

The resulting sequence would be:

CPU0 ravb_close() -> ravb_ptp_stop()
	ravb_ptp_disable();		/* GIC = 0 */
	ravb_ptp_sync_irqs();
	ptp_clock_unregister(priv->ptp.clock);	/* -> kfree(ptp) */

CPU1 PTP_EXTTS_REQUEST on a still-open /dev/ptpN
	ravb_ptp_extts() -> GIC |= GIC_PTCE

CPU2 ravb_ptp_interrupt()
	clock = READ_ONCE(priv->ptp.clock);	/* still published */
	ptp_clock_event(clock, &event);		/* writes ptp->tsevqs */

Would restoring the detach before disabling, for example
clock = xchg(&priv->ptp.clock, NULL) ahead of ravb_ptp_disable(), keep
the guarantee that commit added? The clearing store is also a plain
assignment now while the hardirq reader still uses READ_ONCE().

[Severity: High]
While looking at the teardown side, a related question about the gptp
path: this is not introduced by this commit but by the earlier series
patch "net: ethernet: ravb: Simplify gPTP start and stop", whose
changelog says "There are no functional change".

For gptp (Gen2/RZ-V2M) parts the only ravb_ptp_stop() call is now at the
end of ravb_stop_dma():

	error = ravb_wait(ndev, TCCR, info->tccr_mask, 0);
	if (error)
		return error;
	error = ravb_wait(ndev, CSR, CSR_TPO0 | ... , 0);
	if (error)
		return error;
	...
	error = ravb_wait(ndev, CSR, CSR_RPO, 0);
	if (error)
		return error;
	...
	/* Stop PTP Clock driver */
	if (info->gptp)
		ravb_ptp_stop(ndev);

and ravb_close() only unregisters directly for ccc_gac, then continues
after a ravb_stop_dma() failure:

	if (info->ccc_gac)
		ravb_ptp_stop(ndev);

	if (ravb_stop_dma(ndev) < 0)
		netdev_err(ndev,
			   "device will be stopped after h/w processes are done.\n");

If the DMAC does not quiesce and ravb_wait() times out, does a Gen2
interface end up closed with its PHC still registered? A following
ravb_open() -> ravb_dmac_init() -> ravb_ptp_init() then registers
&priv->ptp.info a second time and overwrites priv->ptp.clock, and unbind
later reaches free_netdev() with a registered clock still pointing at the
ptp_clock_info embedded in ravb_private.

Before this series ravb_close(), ravb_tx_timeout_work() and
ravb_set_ringparam() called ravb_ptp_stop() unconditionally before
ravb_stop_dma(), so the error path could not skip it. The ordering is
unchanged at the end of the series, where
if (info->ptp && info->ptp->dmac_stop) info->ptp->dmac_stop(ndev); sits
after the same early returns.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921175037.4084310-1-niklas.soderlund%2Brenesas%40ragnatech.se
