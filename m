Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874633CEBBD;
	Tue, 15 Sep 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437282; cv=none; b=EUk97eE7MawmfJNzbmPIalPX5sxwyPOL3w0NR+JqNnAlg/JrlV9Al41VwhvFURjWLroYntyRFbuUxsgdts4v/Dlo1cVGVuFFHxaA5z9HyOaUjdOoZVUfpIoSzcFA57UXXW8uUOK3GjO+JCPls8H4/uO38m0FJ7yAS1Ann7i5hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437282; c=relaxed/simple;
	bh=Qibvi95+PwzOvCjoWi44y+G+FarDBYWp5YRXmGMbuYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlimQl+U6kkSwt5ugGFR8BJ/FotfQ78H9xmjPi5kxclmXcKvaVjXTfSkKsRBeGqLOQCOwX/oU1Lw6CP/Xr8o0DrTMRc7zL0bdEV4sz9R7ePVly5MUGz451Ys5+gXdRDiWbXHnQwyvBHmnB1bdW0iWG74oNOeWjYjWhPINJ3UGZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxXq/M6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxXq/M6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5A11F00898;
	Tue, 15 Sep 2026 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437280;
	bh=0hlHASVWrq9suxSMkNM/88LmdQYWAgdKXXVTBGzMUZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CxXq/M6Vo+2N2D53lazus/SxuQ5OMgUqrhIk9lhZDMm0UNqoPGmms0u6+0ZqiNXV7
	 qNziKXRM9sg1bgMo+QRN4ZHyctuZbCZoNotzg+ZzE3Aie7R1PsM82Oqt3Vg7kYS6Fi
	 qxJT12Z2DGfNoGbPwTtNMc2dxik9FmZKbNk4fCcXjq2v5e/iPvVGYzOtEALuEY72ap
	 /XqI2u6XZ2C2xQMapKDRhSwfH+awcK76nzNQQeJ9gE8ykAgwh2g+HYIPgdvAZ7GAgA
	 zCrOauGB6PACUijy2bOVqJ2DdCu1LZrebIWQeau1zlO/z6fZPrqc7k0hbOPYhNs0Et
	 ZNMXEU2T40UmA==
From: Jakub Kicinski <kuba@kernel.org>
To: niklas.soderlund+renesas@ragnatech.se
Cc: Jakub Kicinski <kuba@kernel.org>,
	paul@pbarker.dev,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/10] net: ethernet: ravb: Propagate error from ptp_clock_register()
Date: Mon, 14 Sep 2026 18:54:38 -0700
Message-ID: <20260915015438.881190-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-6-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-6-niklas.soderlund+renesas@ragnatech.se>
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
net: ethernet: ravb: Propagate error from ptp_clock_register()

ravb_ptp_init() is changed to return an int so that a failing
ptp_clock_register() can be propagated to its callers.  Along with that,
the cached priv->ptp.phc_index field is dropped and ravb_get_ts_info()
now reads the index directly from priv->ptp.clock.

Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1

[Severity: Medium]
The changelog only mentions the error propagation:

    If the PTP clock registration failed the error is silently ignored.
    Before reworking all callers of ravb_ptp_init() handle and propagate the
    error so it can be used.

But the diff also removes the substance of two recent stable-tagged fixes.
git blame on the removed lines points at:

  1f77af0aaf27 ("net: ravb: avoid dereferencing an invalid PTP clock")
      Fixes: a0d2f20650e8, Cc: stable
      -> added priv->ptp.phc_index so ravb_get_ts_info() would not have to
         dereference the clock pointer at all

  1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
      Fixes: a0d2f20650e8, Cc: stable
      -> added the READ_ONCE()/WRITE_ONCE()/xchg() annotations and required
         detaching priv->ptp.clock before disabling the gPTP interrupts and
         unregistering

Both mechanisms are undone here.  The only rationale given is below the ---
line ("Rework to remove the caching of phc_index added by LLM without
access to hardware"), which is dropped when the patch is applied, so git
history will not record that two stable fixes were reverted.

Could the commit message say that these two fixes are being reverted and
explain why the new form is safe?

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
> index e44d065f77cc8..5ba322593a014 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1774,7 +1774,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *hw_info = priv->info;
>  
> -	if (hw_info->gptp || hw_info->ccc_gac) {
> +	if (priv->ptp.clock && (hw_info->gptp || hw_info->ccc_gac)) {

[Severity: Medium]
Does this change what ethtool -T reports for a closed interface?

priv->ptp.clock is only non-NULL between ravb_ptp_init() (called from
ravb_dmac_init() for gptp parts and from ravb_open() for ccc_gac parts) and
ravb_ptp_stop(), so it is NULL whenever the interface is down.  It is also
always NULL with CONFIG_PTP_1588_CLOCK=n, since ravb only depends on
PTP_1588_CLOCK_OPTIONAL and the stub ptp_clock_register() returns NULL
(IS_ERR() is false in that case).

Previously the capability bits were reported unconditionally and only
info->phc_index was -1.  Now the whole block is skipped, so
so_timestamping, tx_types and rx_filters all come back empty, while
ravb_hwtstamp_set() still accepts HWTSTAMP_TX_ON and
HWTSTAMP_FILTER_PTP_V2_L2_EVENT and ravb_hwtstamp_get() still reports them:

	priv->tstamp_tx_ctrl = tstamp_tx_ctrl;
	priv->tstamp_rx_ctrl = tstamp_rx_ctrl;

Should the capability bits stay gated on the hardware feature flags, with
only phc_index depending on a registered clock?

This behaviour is still present at the end of the series, where
ravb_get_ts_info() gates everything on hw_info->ptp->clock_index(ndev) >= 0
and ravb_gen2_ptp_clock_index() returns -ENODEV when priv->ptp.clock is
NULL.

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
Can this dereference a freed struct ptp_clock?

There are now two unsynchronized loads of priv->ptp.clock in
ravb_get_ts_info(): the NULL test and the dereference inside
ptp_clock_index(), which is just:

drivers/ptp/ptp_clock.c:
    int ptp_clock_index(struct ptp_clock *ptp)
    {
	    return ptp->index;
    }

ravb_get_ts_info() is not always called under rtnl.  __ethtool_get_ts_info()
calls ops->get_ts_info(dev, info) with only rcu_read_lock() held, and it is
reached from the setsockopt path:

  sock_timestamping_bind_phc()
    -> ethtool_get_phc_vclocks()
      -> __ethtool_get_ts_info()
        -> ravb_get_ts_info()

So a plain user process with a socket bound to the interface can be inside
the if () block while another CPU runs ip link set down:

  ravb_close()/ravb_stop_dma()
    -> ravb_ptp_stop()
      -> ptp_clock_unregister()
        -> put_device(&ptp->dev)
          -> ptp_clock_release()   /* object freed here */

rcu_read_lock() does not help, because ptp_clock_unregister() frees
synchronously without a grace period.  If the compiler reloads the field
between the test and the call, the same window yields a NULL dereference
instead.

The old code read a single cached int that had already been invalidated to
-1 before unregistering, which is what 1f77af0aaf27 ("net: ravb: avoid
dereferencing an invalid PTP clock") was for.  The same two-load pattern
appears at the end of the series in ravb_gen2_ptp_clock_index(), so it is
not addressed later.

>  	}
>  
>  	return 0;

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
> index f70b616ac847c..37161c0579ce7 100644
> --- a/drivers/net/ethernet/renesas/ravb_ptp.c
> +++ b/drivers/net/ethernet/renesas/ravb_ptp.c
> @@ -313,11 +313,11 @@ void ravb_ptp_interrupt(struct net_device *ndev)
>  	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
>  }
>  
> -void ravb_ptp_init(struct net_device *ndev)
> +int ravb_ptp_init(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	struct ptp_clock *clock;
>  	unsigned long flags;
> +	int ret = 0;
>  
>  	priv->ptp.info = ravb_ptp_info;
>  
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
Is it safe to store the ERR_PTR into the shared field before normalizing it?

On failure, priv->ptp.clock briefly holds an error pointer such as
(void *)-ENOMEM before the next statement sets it to NULL.  Neither
consumer validates for error pointers: ravb_ptp_interrupt() passes the
value straight to ptp_clock_event() after a NULL check only, and
ravb_get_ts_info() calls ptp_clock_index() on it after a NULL check only.

The reader that can hit this window without rtnl is the one described
above:

  setsockopt(SO_TIMESTAMPING | SOF_TIMESTAMPING_BIND_PHC)
    -> sock_timestamping_bind_phc()
      -> ethtool_get_phc_vclocks()
        -> __ethtool_get_ts_info()
          -> ravb_get_ts_info()
            -> ptp_clock_index(priv->ptp.clock)

The baseline registered into a local, normalized IS_ERR() to NULL and only
then published with WRITE_ONCE(), which 1f77af0aaf27 justified with
"Registration failures can also leave an error pointer in
priv->ptp.clock."  Would registering into a local and publishing only the
normalized value keep that property?  The publish-then-normalize sequence
is unchanged at the end of the series.

[Severity: Low]
At this commit the netdev_err() is gone but nothing consumes the new return
value yet:

drivers/net/ethernet/renesas/ravb_main.c:ravb_dmac_init() {
	/* Initialise PTP Clock driver */
	if (info->gptp)
		ravb_ptp_init(ndev);

	return 0;
}

drivers/net/ethernet/renesas/ravb_main.c:ravb_open() {
	/* Initialise PTP Clock driver */
	if (info->ccc_gac)
		ravb_ptp_init(ndev);

	/* PHY control start */
	error = ravb_phy_start(ndev);
	...
}

So a ptp_clock_register() failure is more silent at this commit than
before: no log message, no propagated error, and both callers continue as
if PTP had been set up.  This is resolved later in the series by "net:
ethernet: ravb: Replace gPTP flags with callbacks", where ravb_dmac_init()
returns info->ptp->dmac_start(ndev) and ravb_open() jumps to out_ptp_stop
on failure, so it may only be worth a note in the changelog that the
diagnostic disappears for one commit.

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
Can ravb_ptp_interrupt() still see the clock while it is being freed?

The new order in ravb_ptp_stop() is GIC=0/GIS=0, synchronize_irq(),
ptp_clock_unregister(), and only then the NULL store.  The pointer stays
published to the hardirq handler, which still reads it locklessly, for the
whole duration of the unregister:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_interrupt() {
	struct ptp_clock *clock = READ_ONCE(priv->ptp.clock);
	u32 gis = ravb_read(ndev, GIS);

	gis &= ravb_read(ndev, GIC);
	if ((gis & GIS_PTCF) && clock) {
		...
		ptp_clock_event(clock, &event);
	}
	...
}

The only remaining guard is GIC being zero, but GIC is not a write-once
teardown latch.  The PTP core .enable callbacks re-arm it from /dev/ptpN
ioctls:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_extts() {
	if (!info->irq_en_dis)
		ravb_modify(ndev, GIC, GIC_PTCE, on ? GIC_PTCE : 0);
	else if (on)
		ravb_write(ndev, GIE_PTCS, GIE);
}

Those run under priv->lock, which ravb_ptp_disable() does not take, and
there is no teardown flag.  So a PTP_EXTTS_REQUEST or PTP_PEROUT_REQUEST
landing after ravb_ptp_disable()/synchronize_irq() re-enables the gPTP
interrupt, and a following interrupt sees gis & GIC non-zero and hands the
clock that is being unregistered to ptp_clock_event(), which takes
ptp->tsevqs_lock and walks ptp->tsevqs.  ptp_clock_unregister() drops the
last device reference:

drivers/ptp/ptp_clock.c:ptp_clock_unregister() {
	...
	/* The final put, normally here, will invoke ptp_clock_release(). */
	put_device(&ptp->dev);
}

The xchg() that this hunk removes made the handler observe NULL before GIC
was touched, which is what 1cb9663789c5 described: "Atomically detach it
with xchg() before disabling PTP interrupts, then synchronize all IRQs ...
before unregistering the detached clock."

A secondary effect of the same window: the re-armed enable bit is never
cleared again, so the gPTP capture/compare interrupt stays enabled with no
registered clock and the GIS_PTMF branch keeps advancing
priv->ptp.perout->target.

Would keeping the detach-before-disable ordering, or adding explicit
serialization against the .enable callbacks, close this?  This code is
unchanged at the end of the series.

[Severity: Medium]
This one is not introduced by this patch but by the earlier series patch
"net: ethernet: ravb: Simplify gPTP start and stop"; mentioning it here
since it concerns the same teardown path.

On gptp parts, ravb_stop_dma() tears down PTP before a step that can fail:

drivers/net/ethernet/renesas/ravb_main.c:ravb_stop_dma() {
	...
	/* Stop PTP Clock driver */
	if (info->gptp)
		ravb_ptp_stop(ndev);

	/* Stop AVB-DMAC process */
	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
}

If that final opmode transition times out waiting for CSR_OPS, the tx
timeout worker takes the "hardware is still operating" branch:

drivers/net/ethernet/renesas/ravb_main.c:ravb_tx_timeout_work() {
	if (ravb_stop_dma(ndev)) {
		/* ... this just re-enables the TX and RX and skip the following
		 * re-initialization procedure. */
		ravb_rcv_snd_enable(ndev);
		goto out;
	}
	...
out:
	netif_tx_start_all_queues(ndev);
}

That path skips ravb_dmac_init(), the only remaining caller of
ravb_ptp_init() for these parts, so the interface resumes traffic with
/dev/ptpN removed and GIC/GIS zeroed until the interface is taken down and
up again.  Before the series, the timeout path re-ran ravb_ptp_init() at
its common out: label.  Should the stop path leave PTP alone until the
opmode change has succeeded, or should the recovery branch re-register the
clock?
