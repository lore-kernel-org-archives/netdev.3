Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078A4248A0;
	Mon,  5 Oct 2026 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202662; cv=none; b=Rrd2Cxf89FvjNPmSgFIOm3u0ZHlq31O0t5UfFaPz+1VZv67zL1FmNohzbs4OMlZfpmBkp7if40xPxAW5eR/mLZUAcxwEN0Di+Zhw5G5Lp6gNsWmuOcXG6EkZsgPpMpdMRuoxVR2mUI4G8B43hHmusmiXKnu6C53fc/YpDh3krSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202662; c=relaxed/simple;
	bh=kSPUjgq2/YhMjn6W4p8s7KIweMcWZC2J5laXzBBjWGk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFoC6K+oN+OaAEYflAOlxeTPz6RoJWJZrrI+iZ+ExItD6KT+MRsNSZcs+kq5kjCMF2kthS5W+PkUx3FAGrhy7HVwep4Bvv0l8HsxTxGLNt02Q+6GU2QVED+GaovGe/A2K/kTsb41DnsFQZm7Y8EPIXFfybFFSaZFoxP17drtfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt31Dn/8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt31Dn/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF11D1F000FF;
	Mon,  5 Oct 2026 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202660;
	bh=DCB7h2l/fhhrhRsOI+6ZZNF0yfPH1xOQDSMte/fi0/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yt31Dn/8va/M+gbS9/rvdDjbvJ1MdjzoVIhqusypGCFSWrmXn96GDvGhtgIwalVCb
	 a16IU/7TB9Uuaxf20AdpRl/UQXue2+8sC/bmo9qchTbKsyd4duHwpLThOSAftkW2u2
	 1WvU07yxbjECSemJ0Y6Cqt8YAq7bqxIYRs3mtEcv2ZaB+8bKAzDU0eoENdgtkLkE3S
	 LYynMJx/yv1s8VOeowVHQ8TpNyu6kg8XaP6porQt2kA/piOTuukqcdhE70X1s56jdq
	 IXZFZPsJAZXCd4OOxSXN+M4Gr3gvDSfcQloEtS+TFmKND8iezq/MeRRzPU0f+5uWWh
	 NzqU3GXPw5wfg==
Subject: Re: [PATCH net-next v7 3/3] net: stmmac: dwxgmac2: add XGMAC
 timestamp interrupt support
From: netdev-bot+sashiko@kernel.org
To: zxyan0222@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, richardcochran@gmail.com,
 maxime.chevallier@bootlin.com, muhammad.nazim.amirul.nazle.asmade@altera.com,
 rohan.g.thomas@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 12:17:39 +0000
Message-ID: <179120265939.434549.8164410150343143172@kernel.org>
In-Reply-To: <20261004120526.2728564-4-zxyan0222@gmail.com>
References: <20261004120526.2728564-4-zxyan0222@gmail.com>
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

Critical: 0 · High: 0 · Medium: 5 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the FIFO-clear poll times out in the EXTTS 'on' path of
  stmmac_enable() (stmmac_ptp.c:262-275), the new rollback only sets…
- [Medium] Auxiliary snapshots are only drained by
  dwxgmac2_timestamp_interrupt(), called from stmmac_common_interrupt()…
- [Medium] dwxgmac2_timestamp_interrupt() (dwxgmac2_core.c:1163-1212)
  reads STMMAC_FLAG_INT_SNAPSHOT_EN (line 1171),…
- [Medium] In stmmac_enable(), the new XGMAC_TSIE arm/disarm call
  (stmmac_ptp.c:269-270, stmmac_mac_timestamp_interrupt_cfg(priv, on))…
- [Medium] The patch arms XGMAC_TSIE on demand
  (dwxgmac2_timestamp_interrupt_cfg, dwxgmac2_core.c:45-49) and re-arms…

Pre-existing issues:
- [Medium] In the PTP_CLK_REQ_EXTTS case of stmmac_enable(), line 231
  clears the ATSEN bits (`acr_value &= ~PTP_ACR_MASK`) before line 234…
- [Medium] smtg_crosststamp() checks STMMAC_FLAG_EXT_SNAPSHOT_EN (dwmac-
  socfpga.c:310) before it takes aux_ts_lock (line 313), and…

--

net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support

This commit adds a DWXGMAC2-specific timestamp interrupt handler. The
handler reads XGMAC_TIMESTAMP_STATUS and reports pending auxiliary
snapshots as PTP_CLOCK_EXTTS events.

XGMAC_TSIE is armed on demand from the EXTTS path of stmmac_enable()
through a new timestamp_interrupt_cfg() callback. It is re-armed on
resume by stmmac_rearm_timestamp_irq(). smtg_crosststamp() now sets
STMMAC_FLAG_INT_SNAPSHOT_EN while it owns the snapshot FIFO.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index c5f71bfc7cf42..9030cc1cc6778 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -311,6 +311,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  		return -EBUSY;
>  
>  	mutex_lock(&priv->aux_ts_lock);
> +	priv->plat->flags |= STMMAC_FLAG_INT_SNAPSHOT_EN;

[Severity: Medium]
This is a pre-existing issue, but smtg_crosststamp() checks
STMMAC_FLAG_EXT_SNAPSHOT_EN before it takes aux_ts_lock:

	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
		return -EBUSY;

	mutex_lock(&priv->aux_ts_lock);

Also, the enable path of stmmac_enable() never checks
STMMAC_FLAG_INT_SNAPSHOT_EN. ptp_sys_offset_precise() does not take
pincfg_mux, so a concurrent PTP_EXTTS_REQUEST can set
STMMAC_FLAG_EXT_SNAPSHOT_EN and ATSEN(idx) inside that window.
smtg_crosststamp() then overwrites PTP_ACR with the internal channel.

Does that leave STMMAC_FLAG_EXT_SNAPSHOT_EN set, ext_snapshot_num = idx
and TSIE armed, while the user's channel is no longer enabled in
PTP_ACR? Later cross-timestamps would then return -EBUSY until the
channel is disabled and enabled again.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 1a88cbaed70ca..313c24e9a49d7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c

[ ... ]

> @@ -1154,6 +1160,57 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
>  	return 0;
>  }
>  
> +void dwxgmac2_timestamp_interrupt(struct stmmac_priv *priv)
> +{
> +	u32 ts_status, pending_snapshots, acr_value, channel;
> +	struct ptp_clock_event event;
> +	unsigned long flags;
> +	u64 ptp_time;
> +	int i;
> +
> +	if (priv->plat->flags & STMMAC_FLAG_INT_SNAPSHOT_EN) {
> +		/* Read the status to clear the timestamp interrupt source;
> +		 * the FIFO belongs to the cross-timestamp path.
> +		 */
> +		readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);
> +		return;
> +	}
> +
> +	/* Reading XGMAC_TIMESTAMP_STATUS clears the TSIS and AUXTSTRIG
> +	 * bits, so the ATSNS count is the only reliable indication of
> +	 * pending auxiliary snapshots.  TXTSC is cleared by
> +	 * XGMAC_TXTIMESTAMP_SEC and is not affected by this read.
> +	 */
> +	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);

[Severity: Medium]
The commit message says TSIS is "an aggregate, read-to-clear bit that
the TX timestamp completion path (which polls the same register for
TXTSC) clears before the handler can observe it". That covers the case
where this handler runs and finds TSIS already clear. What happens if
the handler never runs?

dwxgmac2_get_mac_tx_timestamp() polls the same register:

	if (readl_poll_timeout_atomic(ioaddr + XGMAC_TIMESTAMP_STATUS,
				      value, value & XGMAC_TXTSC, 100, 10000))

Suppose one of those reads lands after an aux snapshot has set TSIS but
before the CPU takes the MAC interrupt. TSIS was the only enabled
source, so a level-triggered MAC interrupt line would deassert before
stmmac_common_interrupt() runs.

Only stmmac_common_interrupt() calls this handler, and nothing else
checks ATSNS. Would the snapshot then stay in the FIFO until some
unrelated MAC interrupt arrives? With a 1PPS source that could be about
a second later. In multi-vector/MSI mode, DMA interrupts do not go
through stmmac_common_interrupt(), so it could take much longer.

The trigger is EXTTS enabled together with TX hardware timestamping.
stmmac_get_tx_hwtstamp() falls back to stmmac_get_mac_tx_timestamp()
when the descriptor has no timestamp. Whether the interrupt is really
lost depends on how the interrupt line is triggered.

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
Are these checks enough to keep this loop off the FIFO? Each of
STMMAC_FLAG_INT_SNAPSHOT_EN, STMMAC_FLAG_EXT_SNAPSHOT_EN and
PTP_ACR_ATSFC is read once without a lock. The loop then drains a
pending_snapshots count that was sampled earlier.

Three process-context paths flush or consume the same FIFO:
smtg_crosststamp(), the ATSFC flush in stmmac_enable(), and
stmmac_rearm_timestamp_irq(). They serialize on aux_ts_lock, which this
handler cannot take, and none of them calls synchronize_irq().

ptp_lock does not help, because this loop and smtg_crosststamp() both
take it as readers. Arming TSIE only after the flush does not
synchronize anything either. stmmac_common_interrupt() calls this
handler on every common interrupt whatever the TSIE state.
stmmac_request_irq_single() also registers stmmac_interrupt on the
separate WoL line, so two copies of this drain can run at the same time.

Two windows look possible:

(A) The handler samples a stale ATSNS. A concurrent enable then sets
STMMAC_FLAG_EXT_SNAPSHOT_EN and its flush completes. The handler sees
EXT set and ATSFC clear, and pops entries from the flushed FIFO as
EXTTS events.

(B) The handler is already past the STMMAC_FLAG_INT_SNAPSHOT_EN check
and inside this loop when an EXTTS disable and then smtg_crosststamp()
run. The loop pops the internal cross-timestamp snapshot and reports it
as an EXTTS event, and smtg_crosststamp() gets the wrong device time.

Doesn't this contradict two claims in the commit message, that "a
stale snapshot is never reported as an event" and that the handler
"leaves the snapshot FIFO alone while an internal cross-timestamp owns
it"?

smtg_crosststamp() sets STMMAC_FLAG_INT_SNAPSHOT_EN on entry and clears
it on exit to keep the IRQ handler out, so the flag is acting as a
lock. Would a spinlock shared by the handler and the flush/drain paths,
or a synchronize_irq() after raising the flag, be more robust?

The windows are narrow on non-RT kernels. They are wider on PREEMPT_RT,
where the handler runs as a preemptible thread.

> +
> +		event.type = PTP_CLOCK_EXTTS;
> +		event.index = channel;
> +		event.timestamp = ptp_time;
> +		ptp_clock_event(priv->ptp_clock, &event);
> +	}
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3ad9252bf6aea..53aaf2716c467 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -8418,6 +8467,8 @@ int stmmac_resume(struct device *dev)
>  		ret = stmmac_init_timestamping(priv);
>  		if (ret)
>  			goto error_stop_dma;
> +
> +		stmmac_rearm_timestamp_irq(priv);
>  	}

[Severity: Medium]
TSIE is re-armed here on resume. Is there a matching disarm on suspend?

With Wake-on-LAN configured, stmmac_suspend() does:

	if (priv->wolopts) {
		stmmac_pmt(priv, priv->hw, priv->wolopts);
		priv->irq_wake = 1;

It leaves XGMAC_INT_EN and PTP_ACR as they are, and dwxgmac2_pmt() only
writes XGMAC_PMT and RX_CONFIG. Clocks stay on for WoL, so each
external trigger edge, for example a GNSS 1PPS, sets TSIS and asserts
the MAC interrupt. stmmac_common_interrupt() then does:

	if (priv->irq_wake)
		pm_wakeup_event(priv->device, 0);

Could this abort system suspend? Could it also wake the system after
the noirq phase when the MAC IRQ is the wake IRQ? stmmac_pci uses
pdev->irq, and stmmac_platform falls back to the MAC IRQ.

Before this patch XGMAC_TSIE was never set on XGMAC, so this would be a
new wake source. Whether the wake after noirq happens depends on how
the platform wires the wake IRQ and gates clocks.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 3bfcc9760dce7..19fa79839e465 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -239,13 +239,20 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
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
This isn't a bug introduced by this patch, but can the -EBUSY branch
above ever be taken? Earlier in this case:

		acr_value = readl(ptpaddr + PTP_ACR);
		channel = ilog2(FIELD_GET(PTP_ACR_MASK, acr_value));
		acr_value &= ~PTP_ACR_MASK;

		if (on) {
			if (FIELD_GET(PTP_ACR_MASK, acr_value)) {

The ATSEN bits are cleared before they are tested, so the test is
always false.

The disable branch also ignores rq->extts.index. ptp_extts_request()
and extts_enable_store() only check index < n_ext_ts. So an enable or
disable request for one channel can silently retarget or tear down a
different active channel.

After this patch that teardown also resets ext_snapshot_num and
disarms XGMAC_TSIE.

>  		netdev_dbg(priv->dev, "Auxiliary Snapshot %d %s.\n",
>  			   rq->extts.index, on ? "enabled" : "disabled");
> @@ -255,6 +262,17 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
>  		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
>  					 !(acr_value & PTP_ACR_ATSFC),
>  					 10, 10000);
> +		/* Arm or disarm the timestamp interrupt only once the FIFO
> +		 * clear has completed, so the handler does not observe a
> +		 * snapshot that the clear is about to discard.
> +		 */
> +		if (!ret) {
> +			stmmac_mac_timestamp_interrupt_cfg(priv, on);

[Severity: Medium]
This call runs after aux_ts_lock was dropped just before the poll:

		writel(acr_value, ptpaddr + PTP_ACR);
		mutex_unlock(&priv->aux_ts_lock);

extts_enable_store() calls ops->enable() without pincfg_mux, so it can
race with the ioctl path or with another sysfs writer. Can a stale on
or off value be applied here?

disable request A                  enable request B
  clear flag and ATSEN
  mutex_unlock()
  <preempted>
                                     mutex_lock()
                                     set flag, ATSEN|ATSFC
                                     mutex_unlock()
                                     poll completes
                                     timestamp_interrupt_cfg(true)
  poll completes
  timestamp_interrupt_cfg(false)

That would leave the channel B enabled with XGMAC_TSIE disarmed.

The timeout branch below has the same problem. It re-takes the lock and
sets ext_snapshot_num = -1 unconditionally, which could overwrite the
channel recorded by a newer successful enable.

> +		} else if (on) {
> +			mutex_lock(&priv->aux_ts_lock);
> +			priv->plat->ext_snapshot_num = -1;
> +			mutex_unlock(&priv->aux_ts_lock);
> +		}

[Severity: Medium]
When the ATSFC poll times out on enable, only ext_snapshot_num is
rolled back. STMMAC_FLAG_EXT_SNAPSHOT_EN and the PTP_ACR ATSEN(index)
bit that were set earlier stay set. Is that intended?

The readers of this state now disagree with each other:

dwxgmac2_timestamp_interrupt() gates on the flag and on PTP_ACR. It runs
from every stmmac_common_interrupt() even with TSIE disarmed. If ATSFC
clears later, it can report PTP_CLOCK_EXTTS events for a request that
returned an error.

stmmac_rearm_timestamp_irq() sees the flag set but ext_snapshot_num < 0
and skips the restore, so the behaviour changes across suspend and
resume.

smtg_crosststamp() keeps returning -EBUSY until an explicit disable or
close.

Should the failure path roll back the flag, the ATSEN bit and
ext_snapshot_num together?

>  		break;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004120526.2728564-1-zxyan0222%40gmail.com
