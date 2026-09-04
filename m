Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42667175A68;
	Fri,  4 Sep 2026 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484639; cv=none; b=BeUpVsDALzxIyyn0Fwxfc3+KmsWO24o4cuSke2IyYfwgjBCGT0/Yfh+FQQhzGoMDpzOBRG1aGpGV5NUnKTW1n3950JTEJvyQXyLEhmZyk5/UrH0/E9SBPv/23Vm6KdWQ7QjKSVTMBZjwJYdxKxYmhKG+HSbFGKFeXSd+efH3d5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484639; c=relaxed/simple;
	bh=2YrBFFMdbIcTssT0wiC7ajMFg52XeoV+T2BcG4sSQWw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tmnLussTRa3E7eypuSo0tWd3y+gL1l3xibirUbzC6AvUHtmETbfnfjO5qoVD5ZQxziUKj2MPilG5Wd4ybrQjNyCCsE4GPJ9w2NP5ul3wKgFeYf6dbvUYLu9/4R97CTMh0+I0x+GVD9sW1CcCEPQOtAC9YZGUWnlSKFYDrOi5U9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNJNWShu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNJNWShu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D6E1F000E9;
	Fri,  4 Sep 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788484638;
	bh=d/o/kXfq5hsapgPLqaE+akwK/Xo70wQ7OE8BbPjIqKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UNJNWShu5iTDsgOXHm/imKBntT0iAgos6mXfVGijDqkxsPMhi00Rct+65kRJGk7pr
	 h6gDwC57BfMDatxYIxBuuyWppFfvRupNYvY1DUoPEBwmfC/O4MkAO527sA/b5/oGuY
	 HE/pnDCq7G4Zo0q8l2UUjQJRaKkhLxYknoHHEM8/IOs72DXFtGjfvp4d/+eyYtQMAN
	 4PwwNCTf4hwl/mVOX8PKZOGcPJPeyBsXJrH04K1Yb+1WjGkPPmSQmYcgfEqJ1EdaQC
	 WRBNEs1S4uNak0yHo1JR8tm7PoieDBdQff5jQ8miSv//6Yd4iM+QGyEqjjn1cXntbV
	 qwAfIG2W9OVRQ==
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: dwxgmac2: add XGMAC
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
Date: Fri, 04 Sep 2026 01:17:16 +0000
Message-ID: <178848463667.4131868.2082471736382241698@kernel.org>
In-Reply-To: <20260902131441.322167-2-zxyan0222@gmail.com>
References: <20260902131441.322167-2-zxyan0222@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] dwxgmac2_timestamp_interrupt()
  (drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:1157) performs an…
- [Medium] dwxgmac2_timestamp_interrupt() samples the pending snapshot
  count from XGMAC_TIMESTAMP_STATUS (dwxgmac2_core.c:1178), reads…
- [Low] The commit message asserts a concrete pre-existing user-visible
  defect ("the generic stmmac PTP handler reads the dwmac4 offset…

--

net: stmmac: dwxgmac2: add XGMAC timestamp interrupt support

This adds a DWXGMAC2 specific timestamp interrupt handler that reads
XGMAC_TIMESTAMP_STATUS (0xd20), derives the pending auxiliary snapshot
count from ATSNS and emits PTP_CLOCK_EXTTS events.  It also adds
XGMAC_TSIE to XGMAC_INT_DEFAULT_EN and points the DWXGMAC2 and DWXLGMAC2
hwif entries at the new dwxgmac2_ptp ops instead of &stmmac_ptp.

A couple of questions below, starting with the changelog.

> DWXGMAC2 uses XGMAC_TIMESTAMP_STATUS at offset 0xd20, while the
> generic stmmac PTP handler reads the dwmac4 offset GMAC_TIMESTAMP_STATUS
> (0xb20).
[ ... ]
> As a result, auxiliary snapshot events were never reported on XGMAC
> platforms.

[Severity: Low]
The description here is of previously broken functionality (wrong register
offset, timestamp interrupt never unmasked), but the patch is titled "add
... support" and carries no Fixes: tag.  Should one be added so that PTP
EXTTS breakage on DWXGMAC2/DWXLGMAC2 is bisectable and stable selection is
unambiguous?

Two candidates that exist in the tree:

  f4da56529da6 ("net: stmmac: Add support for external trigger timestamping")
  bd7f77dae695 ("net: stmmac: fix incorrect flag check in timestamp interrupt")

Is this intended for net or net-next?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index f8ab347f7b5b..03cbae326995 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -87,7 +87,7 @@
>  #define XGMAC_TSIE			BIT(12)
>  #define XGMAC_LPIIE			BIT(5)
>  #define XGMAC_PMTIE			BIT(4)
> -#define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE)
> +#define XGMAC_INT_DEFAULT_EN		(XGMAC_LPIIE | XGMAC_PMTIE | XGMAC_TSIE)
>  #define XGMAC_Qx_TX_FLOW_CTRL(x)	(0x00000070 + (x) * 4)
>  #define XGMAC_PT			GENMASK(31, 16)
>  #define XGMAC_TFE			BIT(1)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 1a88cbaed70c..891b7ceea2d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -1154,6 +1154,49 @@ static int dwxgmac2_get_mac_tx_timestamp(struct mac_device_info *hw, u64 *ts)
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
> +	/* Read XGMAC_TIMESTAMP_STATUS to get the AUX snapshot
> +	 * count.  This read also clears the TSIS bit in
> +	 * XGMAC_INT_STATUS.
> +	 * TX timestamp polling may have already cleared TSIS
> +	 * and AUXTSTRIG, so rely on ATSNS instead.
> +	 * TXTSC is cleared by XGMAC_TXTIMESTAMP_SEC, not by
> +	 * this register, so there is no conflict.
> +	 */
> +	ts_status = readl(priv->ioaddr + XGMAC_TIMESTAMP_STATUS);

[Severity: High]
This read of the clear-on-read status register is unconditional, unlike the
generic handler in stmmac_hwtstamp.c which first checks whether a timestamp
interrupt is actually pending:

	tsync_int = readl(priv->ioaddr + GMAC_INT_STATUS) & GMAC_INT_TSIE;
	if (!tsync_int)
		return;

stmmac_common_interrupt() invokes stmmac_timestamp_interrupt(priv, priv) for
every xmac core interrupt, and on platforms that do not set
STMMAC_FLAG_MULTI_MSI_EN the single shared handler runs it ahead of DMA
processing:

stmmac_interrupt()
	stmmac_common_interrupt();   /* -> readl(0xd20), clears TSIS */

	/* To handle DMA interrupts */
	stmmac_dma_interrupt(priv);

The Agilex5 XGMAC is such a platform: socfpga_agilex5_setup_plat_dat() sets

	plat_dat->core_type = DWMAC_CORE_XGMAC;

and never sets STMMAC_FLAG_MULTI_MSI_EN, so it uses the single-IRQ path and
is one of the two hwif entries switched to &dwxgmac2_ptp here.  Its
cross-timestamp path detects snapshot completion by polling the very bit
that this read clears:

drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:smtg_crosststamp() {
	...
	ret = readl_poll_timeout(priv->ioaddr + XGMAC_INT_STATUS, v,
				 (v & XGMAC_INT_TSIS), 100, 10000);
	...
}

Can this handler consume TSIS behind smtg_crosststamp(), so that
PTP_SYS_OFFSET_PRECISE fails with -ETIMEDOUT and a netdev_err, or reads
ATSNS == 0 and returns a zero device timestamp?  With the TSIE unmasking in
XGMAC_INT_DEFAULT_EN above, plus one handler run per RX/TX interrupt on the
shared IRQ, this looks like it would happen under ordinary traffic.

The later patch in the series ("net: stmmac: dwmac-socfpga: mask XGMAC_TSIE
during cross-timestamp") masks XGMAC_TSIE around the snapshot, but at the
end of the series dwxgmac2_timestamp_interrupt() still reads 0xd20
unconditionally, so any other MAC or DMA interrupt during the up-to-10 ms
poll window still clears TSIS.

Would gating this read on XGMAC_INT_STATUS & XGMAC_INT_TSIS, as the dwmac4
handler does, close that window instead?

> +
> +	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
> +		return;
> +
> +	pending_snapshots = FIELD_GET(XGMAC_TIMESTAMP_ATSNS_MASK, ts_status);
> +	if (!pending_snapshots)
> +		return;
> +
> +	acr_value = readl(priv->ptpaddr + PTP_ACR);
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
The ATSNS count and the PTP_ACR channel mask are sampled once, and the
auxiliary snapshot FIFO is then popped pending_snapshots times while holding
only a read lock on priv->ptp_lock, which protects the systime/addend
registers and does not exclude other readers.

struct stmmac_priv documents a different lock for these registers:

	/* Protects auxiliary snapshot registers from concurrent access. */
	struct mutex aux_ts_lock;

The process-context writer publishes the enable flag and issues the FIFO
clear under that mutex, then waits for completion after dropping it:

drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:stmmac_enable() {
	...
			priv->plat->flags |= STMMAC_FLAG_EXT_SNAPSHOT_EN;

			/* Enable External snapshot trigger */
			acr_value |= PTP_ACR_ATSEN(rq->extts.index);
			acr_value |= PTP_ACR_ATSFC;
	...
		mutex_unlock(&priv->aux_ts_lock);
		/* wait for auxts fifo clear to finish */
		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,
					 !(acr_value & PTP_ACR_ATSFC),
					 10, 10000);
	...
}

Since aux_ts_lock is a mutex and this handler runs in hardirq, the two paths
share no lock at all.  If a timestamp interrupt lands in that window, can it
see the already-published STMMAC_FLAG_EXT_SNAPSHOT_EN together with a stale
ATSNS count or channel mask and drain a FIFO that is being flushed or
re-channelled, reporting stale or mis-indexed PTP_CLOCK_EXTTS events?

PTP_ACR is also read only once outside the loop, so a channel change part
way through the loop would be reported under the old index.

The same unlocked pattern exists in the dwmac4 and dwmac1000 handlers, but
this patch creates the new code and makes the path reachable on DWXGMAC2 and
DWXLGMAC2 by unmasking XGMAC_TSIE and wiring the handler in.

> +
> +		event.type = PTP_CLOCK_EXTTS;
> +		event.index = channel;
> +		event.timestamp = ptp_time;
> +		ptp_clock_event(priv->ptp_clock, &event);
> +	}
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902131441.322167-1-zxyan0222%40gmail.com
