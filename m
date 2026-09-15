Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB273CB54D;
	Tue, 15 Sep 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436999; cv=none; b=B8VOQ2LXcUa5rqLw9nxKo2Ui9l6NM1Elq105O7zV7DEyTEVJH+UvShRVXEj/PZ8+WDATDF3swE2ObYPXkEFIbJdTO6Fz0/Usz5eueAe1HGZuKO0Ak42ARZpkE0AvTH6z3JMWAJ64sYK7/seSE6IxnrfrylRvjeduCN3eFXdG0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436999; c=relaxed/simple;
	bh=1sN5FyPeI8RgfC9wlaPzqVnv++yeOf+rB15MnndVGM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/CvIF/eFcsTO/LaPZhuL9nSpQWQGY1GhLGVW/3W+j2C9YybqabY1C0SlKGURQTtGradh/n8RT/w/5cKbMcbV6jhYGbSohpS9DF0dLCet3skX4W+ri4kJO9ChtxYPljdTYR3uLyQLiFtkDz50cpqEFV5xLOurltGNsYndAzEi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4Q8UBwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4Q8UBwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F7E1F000FF;
	Tue, 15 Sep 2026 01:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789436995;
	bh=KEjRpuiPoM3YCn07cLeuZo1dk5pw+ZehBoPJPSHAXmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4Q8UBwkTzN2q6d/hTDJ6UT6qaIyZGzQpeJIVOQDW1/QlQJHp0iXYh81gUtBR6ZCr
	 DeMqliK0+BLaIrz0b1xtrmPxJkBatu3LtUdn4mT5PvUz7VGUrd++fVHlPdv6F30azG
	 46eMa7eFZvMN/SojwGw0Mn9IGu2I7LDHsIIFt9LUjokFMuQw8EtYW35hEnTEMXAMem
	 zSjaR7km/rn4BSU5zghblVzQh7cT30qYh1R1eiABHH/s6F6LOaeGgzbcJ4WpdrmBU0
	 f4E/R5hCU7QO2ENZZ/2Q+slBKzsmUshN8JHqbYHAK6YJUjSA7dtSYAGqgnAhkXsQ34
	 +TfM8QIo2TX1w==
From: Jakub Kicinski <kuba@kernel.org>
To: zxyan0222@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	maxime.chevallier@bootlin.com,
	muhammad.nazim.amirul.nazle.asmade@altera.com,
	rohan.g.thomas@altera.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS
Date: Mon, 14 Sep 2026 18:49:32 -0700
Message-ID: <20260915014931.873912-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910081020.86227-2-zxyan0222@gmail.com>
References: <20260910081020.86227-2-zxyan0222@gmail.com>
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
net: stmmac: dwmac-socfpga: complete cross-timestamp on ATSNS

This changes the Agilex5 smtg_crosststamp() handler so that it waits for
the PTP_ACR_ATSFC FIFO clear to finish, then polls the ATSNS count in
XGMAC_TIMESTAMP_STATUS instead of the transient TSIS bit in
XGMAC_INT_STATUS.  The snapshot count used for the FIFO pop loop is now
taken from the value the poll read back rather than from a fresh register
read.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> index 1d7f0a57d2889..ee6f28637878a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
> @@ -340,6 +340,18 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	/* Release the mutex */
>  	mutex_unlock(&priv->aux_ts_lock);
>  
> +	/* Wait for the FIFO clear to complete so a stale ATSNS count from
> +	 * a previous snapshot cannot satisfy the poll below before the new
> +	 * snapshot is latched.
> +	 */
> +	ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
> +				 !(acr_value & PTP_ACR_ATSFC), 10, 10000);
> +	if (ret) {
> +		netdev_err(priv->dev, "%s: Failed to clear snapshot FIFO\n",
> +			   __func__);
> +		return ret;
> +	}
> +
>  	/* Trigger Internal snapshot signal. Create a rising edge by just toggle
>  	 * the GPO0 to low and back to high.
>  	 */
> @@ -349,9 +361,17 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  	gpio_value |= XGMAC_GPIO_GPO0;
>  	writel(gpio_value, ioaddr + XGMAC_GPIO_STATUS);
>  
> -	/* Poll for time sync operation done */
> -	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
> -				 (v & XGMAC_INT_TSIS), 100, 10000);
> +	/* Wait for the auxiliary snapshot to be latched.  TSIS is a
> +	 * transient status bit that is set by any MAC timestamp event and
> +	 * cleared by reading XGMAC_TIMESTAMP_STATUS, so it is not a
> +	 * reliable completion condition.  Poll the persistent ATSNS count
> +	 * instead: it is cleared only by setting PTP_ACR_ATSFC, so
> +	 * nothing can clear it while we wait, and it reflects exactly the
> +	 * snapshot latched by this trigger.
> +	 */

[Severity: Low]
Is the "cleared only by setting PTP_ACR_ATSFC" part of this comment (and
the matching "ATSNS is cleared only when the FIFO clear bit
(PTP_ACR_ATSFC) is set" in the commit message) accurate?

ATSNS is the auxiliary snapshot FIFO fill level, and popping the FIFO
decrements it.  get_ptptime() in stmmac_hwtstamp.c does the pop:

	ns = readl(ptpaddr + PTP_ATNR);
	ns += (u64)readl(ptpaddr + PTP_ATSR) * NSEC_PER_SEC;

That is also why both timestamp_interrupt() and the loop just below in
smtg_crosststamp() iterate exactly num_snapshot times:

	/* Repeat until the timestamps are from the FIFO last segment */
	for (i = 0; i < num_snapshot; i++) {
		read_lock_irqsave(&priv->ptp_lock, flags);
		stmmac_get_ptptime(priv, ptpaddr, &ptp_time);

Would it be more precise to say only that ATSNS is not cleared by reading
XGMAC_TIMESTAMP_STATUS, rather than that nothing can clear it while the
poll runs?

> +	ret = readl_poll_timeout(ioaddr + XGMAC_TIMESTAMP_STATUS, v,
> +				 FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v),
> +				 100, 10000);
>  	if (ret) {
>  		netdev_err(priv->dev, "%s: Wait for time sync operation timeout\n",
>  			   __func__);
> @@ -364,8 +384,7 @@ static int smtg_crosststamp(ktime_t *device, struct system_counterval_t *system,
>  		.use_nsecs = false,
>  	};
>  
> -	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK,
> -				 readl(ioaddr + XGMAC_TIMESTAMP_STATUS));
> +	num_snapshot = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, v);
>  
>  	/* Repeat until the timestamps are from the FIFO last segment */
>  	for (i = 0; i < num_snapshot; i++) {

[Severity: Medium]
Can this reuse of the polled value hand a fabricated timestamp back to
userspace?

Everything from the ATSFC-clear wait through the GPO0 trigger, the ATSNS
poll and this pop loop runs after aux_ts_lock has been dropped:

	/* Release the mutex */
	mutex_unlock(&priv->aux_ts_lock);

The STMMAC_FLAG_EXT_SNAPSHOT_EN test at the top of smtg_crosststamp():

	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
		return -EBUSY;

is done without that mutex, while stmmac_enable() in stmmac_ptp.c sets the
flag and writes PTP_ACR under it:

	priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;

	/* Enable External snapshot trigger */
	acr_value |= PTP_ACR_ATSEN(rq->extts.index);
	acr_value |= PTP_ACR_ATSFC;

The PTP core does not serialize the callback either:

drivers/ptp/ptp_chardev.c:ptp_ioctl() {
	...
	case PTP_SYS_OFFSET_PRECISE:
	case PTP_SYS_OFFSET_PRECISE2:
		return ptp_sys_offset_precise(ptp, argptr,
					      ptp->info->getcrosststamp);
	...
}

So after the poll observes ATSNS = N, a PTP_CLK_REQ_EXTTS enable or a
second concurrent smtg_crosststamp() can set PTP_ACR_ATSFC and flush the
FIFO, or drain it itself.  The loop then still runs N iterations against an
empty FIFO, sets *device from whatever those reads return, and returns 0.

Note the read_lock_irqsave(&priv->ptp_lock, flags) inside the loop is a
reader lock, so two concurrent drains can interleave pops of the same
FIFO.

Before this patch the count was re-read immediately before the loop, so the
same race produced num_snapshot == 0 and a skipped loop, i.e. a detectable
failure rather than a stale value.  Given that, does the commit message
claim hold?

	"derive the count for the FIFO pop loop from the value the poll read
	back so it is guaranteed non-zero on the success path"

Would holding aux_ts_lock (or another writer-exclusive lock) across the
ATSFC wait, the trigger, the poll and the drain, and re-checking the count
at drain time, be needed to make that guarantee real?
