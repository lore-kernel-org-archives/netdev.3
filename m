Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3A25B09D;
	Wed, 14 Oct 2026 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950632; cv=none; b=U6614Ca9GmFLGV4uPoo/tZiQ8PWmEalfmP7BEt3xXogSbuU62ccYAtTnOFyBBuKkTL/nHMWzEe03Y2UAb9ybbYa+V8MA+xGWJEMgaIjI63ZQr4uKSkl6Mb56/aktHERPNH7X4uGkLSjfe8WN31/6tPmJ6lAfKXgbuAzuCR+bb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950632; c=relaxed/simple;
	bh=/Rk6Pjt3Ru0rbRTMkEnRHnOQd/AgOkLGm3dtH40MmoI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9uSZKXpwwACP81HtXgYgUDTtD5uyKIrDHzCkKGzpPgYlWzIu4ZRVZ2H4OCeDy9nmKGFhpL1OwPOUOePOz9Q/Dr8kJHTWiRXHNOJRHSP2/9LWo+aiun2bj+N3HjVlLUDIovyq6DWKyfCqnKYLSEBUxi93t5s6fpCN9ZcMTbzcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGqvqDHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGqvqDHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285B01F00893;
	Wed, 14 Oct 2026 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791950631;
	bh=xAALzCeJyz2k0K1AD7EE+ZOgKqM4SXj6v8UkC897EZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MGqvqDHCr9FxyG6CEYBYg01pQr0Xun9F4Gg8GL1ExQ9Dp3ptwHynzDeuVkxssAsxc
	 YvmFuOn+WAjQKv1Jtd2o54lAYzSnFvrg+mYBPmwIL7cKkHosNnQFwlOM+pvYHbJjnS
	 /2lTEB2d1VNMe43RMhYGHQs7Nn9dGNsrN48SrgdfohDwIekn2N8uKYjXCv777mA/js
	 OlNv1lJdE9ouFxzY4l8hSp/cpiy1ev/dmOLEbzARQDdHirCyHHnN02AL5EBrFVxKJ7
	 jmZ6W81lamKbVtpfhER7brPRy90MXY25eJF5mNqte5jvWp5hY7+JqL2nNptl/Y+GOT
	 sUcgLLJtoThoQ==
Subject: Re: [PATCH net-next v8 3/3] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
From: netdev-bot+sashiko@kernel.org
To: zxyan0222@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 04:03:49 +0000
Message-ID: <179195062971.434549.3907170504821168391@kernel.org>
In-Reply-To: <20261013033207.1684328-4-zxyan0222@gmail.com>
References: <20261013033207.1684328-4-zxyan0222@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says dwxgmac2_timestamp_interrupt() cannot
  race a FIFO flush because "PTP_ACR_ATSFC is only ever set while…
- [Medium] In stmmac_enable(PTP_CLK_REQ_EXTTS), the 'already enabled'
  -EBUSY check is dead.
- [Medium] smtg_crosststamp() (dwmac-socfpga) tests
  STMMAC_FLAG_EXT_SNAPSHOT_EN before mutex_lock(&priv->aux_ts_lock), and…
- [Medium] Two handler instances can drain the auxiliary timestamp FIFO
  at the same time.
- [Medium] The commit message says TSIS is a read-to-clear bit that the
  TX timestamp completion path clears.

--

net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support

This adds a DWXGMAC2 timestamp interrupt handler that drains the
auxiliary snapshot FIFO and reports the entries as PTP_CLOCK_EXTTS
events. XGMAC_TSIE is armed on demand from the EXTTS enable path through
a new timestamp_interrupt_cfg() callback. The suspend/resume,
unregister and socfpga cross-timestamp paths are updated to coordinate
FIFO ownership under aux_ts_lock.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index ee79b74bf21b6..93c1092237fc6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -311,6 +311,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  		return -EBUSY;
>  
>  	mutex_lock(&priv->aux_ts_lock);
> +	/* Refuse to arm once the clock has been invalidated by
> +	 * unregister.
> +	 */
> +	if (!priv->ptp_clock) {
> +		mutex_unlock(&priv->aux_ts_lock);
> +		return -ENODEV;
> +	}
> +	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;

[Severity: Medium]
The STMMAC_FLAG_EXT_SNAPSHOT_EN test that guards smtg_crosststamp() still
runs before aux_ts_lock is taken. Under the lock, only ptp_clock is
rechecked:

    if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
        return -EBUSY;

    mutex_lock(&priv->aux_ts_lock);

getcrosststamp doesn't take pincfg_mux. Can a concurrent
PTP_EXTTS_REQUEST run its whole locked section inside that window?

CPU1 (PTP_SYS_OFFSET_PRECISE)    CPU2 (PTP_EXTTS_REQUEST, on=1)
smtg_crosststamp()
  EXT_SNAPSHOT_EN not set
                                 stmmac_enable()
                                   sets EXT_SNAPSHOT_EN
                                   writes ATSEN(index) | ATSFC
                                   arms XGMAC_TSIE
  mutex_lock(&priv->aux_ts_lock)
  acr_value &= ~PTP_ACR_MASK;
  sets ATSEN(int_snapshot_num)
  ...
  flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN

Would that leave EXT_SNAPSHOT_EN set, TSIE armed and ext_snapshot_num
naming the user's channel, while PTP_ACR enables only the internal
snapshot channel?

If so, the user's EXTTS channel would produce no more events, and every
later smtg_crosststamp() would return -EBUSY. dwxgmac2_timestamp_interrupt()
takes the reported index from the live PTP_ACR, so any events delivered
in that state would carry the internal channel index. On resume,
stmmac_rearm_timestamp_irq() would also program ext_snapshot_num, which
no longer matches the hardware state.

Could the EXT_SNAPSHOT_EN check move under aux_ts_lock, next to the new
ptp_clock check?

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 1a88cbaed70ca..3b98cd82ec2d7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c

[ ... ]

> @@ -1154,6 +1160,59 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
>  	return 0;
>  }
>  
> +void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
> +{

[ ... ]

> +	/* Reading XGMAC_TIMESTAMP_STATUS clears TSIS, so use the ATSNS
> +	 * count to see the pending snapshots.
> +	 */
> +	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);

[Severity: Medium]
The commit message says TSIS is read-to-clear and that the TX timestamp
completion path clears it. On XGMAC that path runs for every TX
timestamp. dwxgmac2_get_tx_timestamp_status() always returns 0, so
stmmac_get_tx_hwtstamp() always falls back to
dwxgmac2_get_mac_tx_timestamp(), which polls the same register from
NAPI:

    if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
                                  value, value & XGMAC_TXTSC, 100, 10000))

Suppose that read lands after an auxiliary snapshot sets TSIS (with
TSIE armed) but before the CPU takes the MAC interrupt. Can a
level-triggered MAC IRQ then be deasserted, so the handler never runs
for that snapshot?

dwxgmac2_timestamp_interrupt() is the only consumer of the aux FIFO, and
its only caller is stmmac_common_interrupt(). Skipping the TSIS gate
only helps once the handler is already running.

Would the snapshot then stay in the FIFO until an unrelated MAC
interrupt arrives, or in single-IRQ mode the next DMA interrupt? In
multi-MSI mode only MAC interrupts reach this handler. For a one-shot
input the event could then be delayed indefinitely, or lost to FIFO
overflow.

> +
> +	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN) || !priv->ptp_clock)
> +		return;
> +
> +	pending_snapshots = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_status);
> +	if (!pending_snapshots)
> +		return;
> +
> +	acr_value = readl(priv->ptpaddr + PTP_ACR);
> +	/* Entries observed while the FIFO is being flushed are stale. */
> +	if (acr_value & PTP_ACR_ATSFC)
> +		return;
> +	channel = FIELD_GET(PTP_ACR_MASK, acr_value);
> +	if (!channel)
> +		return;
> +	channel = ilog2(channel);
> +
> +	for (i = 0; i < pending_snapshots; i++) {
> +		read_lock_irqsave(&priv->ptp_lock, flags);
> +		stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);
> +		read_unlock_irqrestore(&priv->ptp_lock, flags);

[Severity: Medium]
Can two instances of this loop drain the FIFO at the same time?
stmmac_request_irq_single() registers stmmac_interrupt() on dev->irq and
also on a separate wake line:

    if (priv->wol_irq > 0 && priv->wol_irq != dev->irq) {
        ret = request_irq(priv->wol_irq, stmmac_interrupt,
                          IRQF_SHARED, dev->name, dev);

Both lines reach this handler through stmmac_common_interrupt(). The
handler deliberately doesn't gate on TSIS, so two CPUs servicing the two
lines could both read the same ATSNS=N and both loop N times.

read_lock_irqsave() on ptp_lock admits both readers at once. Also,
get_ptptime() consumes each entry with two separate reads:

    ns = readl(ptpaddr + PTP_ATNR);
    ns += (u64)readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;

Would that pop 2N entries for N snapshots? Could one reported EXTTS
timestamp combine the nanosecond and second halves of different entries?

> +
> +		event.type = PTP_CLOCK_EXTTS;
> +		event.index = channel;
> +		event.timestamp = ptp_time;
> +		ptp_clock_event(priv->ptp_clock, &event);
> +	}
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 3bfcc9760dce7..f41988f5927ad 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c

[ ... ]

> @@ -239,22 +246,49 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>  				return -EBUSY;
>  			}
>  
> +			if (rq->extts.index >= PTP_ACR_ATSEN_NUM) {
> +				mutex_unlock(&priv->aux_ts_lock);
> +				return -EINVAL;
> +			}
> +
>  			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +			priv->plat->ext_snapshot_num = rq->extts.index;
>  
>  			/* Enable External snapshot trigger */
>  			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
>  			acr_value |= PTP_ACR_ATSFC;
>  		} else {
>  			priv->plat->flags &= ~STMMAC_FLAG_EXT_SNAPSHOT_EN;
> +			priv->plat->ext_snapshot_num = -1;
>  		}

[Severity: Medium]
The "already enabled" check just above this hunk can never fire, because
the mask is cleared before it is tested:

    acr_value = readl(ptpaddr + PTP_ACR);
    channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
    acr_value &= ~PTP_ACR_MASK;

    if (on) {
        if (FIELD_GET(PTP_ACR_MASK, acr_value)) {
            ...
            return -EBUSY;
        }

Before calling ops->enable(), ptp_extts_request() only checks
req.extts.index >= ops->n_ext_ts. With the new single-slot
ext_snapshot_num, what happens for the sequence enable(A), enable(B),
disable(A)?

enable(B) would clear ATSEN(A), set ATSEN(B) and overwrite
ext_snapshot_num.

disable(A) doesn't look at rq->extts.index. It clears EXT_SNAPSHOT_EN,
sets ext_snapshot_num to -1, writes an empty ACR mask and disarms
XGMAC_TSIE. That stops channel B while userspace still thinks it is
enabled.

The dead check predates this patch. However, the new ext_snapshot_num
tracking, the resume rearm and the ATSFC/TSIE invariant in the commit
message all assume only one channel is ever active.

Should the busy test happen before the mask is cleared? And should the
disable path check that rq->extts.index matches ext_snapshot_num?

>  		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
>  			   rq->extts.index, on ? "enabled" : "disabled");
>  		writel(acr_value, ptpaddr + PTP_ACR);
> -		mutex_unlock(&priv->aux_ts_lock);
> -		/* wait for auxts fifo clear to finish */
> +		/* Keep the lock across the FIFO clear so the arm below
> +		 * cannot interleave with a suspend.
> +		 */
>  		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
>  					 !(acr_value & PTP_ACR_ATSFC),
>  					 10, 10000);

[ ... ]

> +		/* Arm the timestamp interrupt only after the FIFO clear,
> +		 * so the handler cannot see a snapshot that is about to be
> +		 * discarded.
> +		 */
> +		stmmac_mac_timestamp_interrupt_cfg(priv, on && !ret);
> +		/* Drain an in-flight handler before the channel is freed. */
> +		if (!on)
> +			stmmac_sync_timestamp_irq(priv);
> +		mutex_unlock(&priv->aux_ts_lock);

[Severity: Medium]
The commit message says:

  "PTP_ACR_ATSFC is only ever set while XGMAC_TSIE is disabled, so this
  both keeps it off the FIFO on unrelated interrupts and stops it racing
  a FIFO flush."

Does that hold when a second PTP_CLK_REQ_EXTTS enable arrives while a
channel is already enabled? This can come from the ioctl or from the
extts_enable sysfs attribute.

Because of the dead -EBUSY check above, the request gets through. The
writel() above then sets ATSEN(new) | PTP_ACR_ATSFC while XGMAC_TSIE is
still armed from the first enable. TSIE is not disarmed and
stmmac_sync_timestamp_irq() is not called before the flush; the sync
only happens for !on.

dwxgmac2_timestamp_interrupt() runs on any MAC interrupt, or in
single-IRQ mode any DMA interrupt. It shares no lock with this path, and
it samples the FIFO level and the flush state at different times:

    ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
    ...
    acr_value = readl(priv->ptpaddr + PTP_ACR);
    if (acr_value & PTP_ACR_ATSFC)
        return;
    ...
    for (i = 0; i < pending_snapshots; i++) {
        ...
        stmmac_get_ptptime(priv, priv->ptpaddr, &ptp_time);

If that PTP_ACR read happens before the ATSFC write, or after the
self-clearing flush completes, ATSFC reads as 0.

Could the handler then pop N entries from a FIFO that is being flushed
or is already empty? It would report N stale or bogus PTP_CLOCK_EXTTS
events, tagged with either the old or the new channel index.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013033207.1684328-1-zxyan0222%40gmail.com
