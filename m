Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5583EC812;
	Mon,  7 Sep 2026 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788749319; cv=none; b=h0mGK2K06Z65+kz3PkGNCUaHAIJmAz+xxFFGp0ig7aBZb10NnkunPpDpApkX8Ix+6ZDPAIdLNQFhkBICS0+DWUtp67OWGRFtdKWtQ5uMLxYkE0AbJZKcoCcOnrWAdFEEheUTFuQKjnoV2wdhmTWuhj/S67q/5vxQCvz3JnaPirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788749319; c=relaxed/simple;
	bh=SIB5y0b5BJiK2sMA6vZKZaHBvz5A+BmXHsimnrIINZg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiT7ryvB+DiTkmyc4qZQxCCtM7BnObvhEuxYr8to6Utb8AhyWvKbmMAHcuA7jO6cTMT9Oq8SVQ8hkIzPj8Ax3Z8CvHhvGGGUxUeXLu4agthI/f8rAoK5w7LH3cgZuF3mP+xHkzF+VWljq/SH5qzMu7Eyq9tkVQ4gwBQvsF9Bz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ+M2QHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ+M2QHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5221F00A3A;
	Mon,  7 Sep 2026 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788749316;
	bh=1njsgLWHkWK5m8YUZRFQOzkGmZDziNvzRLS04r3u3Bo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JZ+M2QHbQ1O5vN0as94olFWDtE8ZECAOi4xyUxfHvXndXTsITDqbP/2sVAlZVaVBJ
	 HU29LuBo8/0LQdLRWWHIPSb2kR4nnZq4c9WUlCD990cpDh4iLs8es4sElO+jP+5Sgp
	 Mzh23wEQGkjzERl9fAueL0zO3XBkETCbwx8opRucDBIb5Y7lgDdc18FXq13erocAvz
	 pSVhVnm/OOj6GXO7Jd2Eel+ooUGYqtkIDiViKKmW8ic8RvQ81YHPxUyel1sKKHzMvG
	 RZLx83V1a77tJbXXNsYYpwsg6uU2Huq7CbqmxS6UMKVj4zsBkzllnZp2Bwyqamte+/
	 yKowHdA4/yVkQ==
Subject: Re: [PATCH net-next v3 06/10] net: ethernet: ravb: Replace gPTP flags
 with callbacks
From: netdev-bot+sashiko@kernel.org
To: niklas.soderlund+renesas@ragnatech.se
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 sergei.shtylyov@gmail.com, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Date: Mon, 07 Sep 2026 02:48:34 +0000
Message-ID: <178874931491.219967.7169661491703967460@kernel.org>
In-Reply-To: <20260902084703.3228504-7-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-7-niklas.soderlund+renesas@ragnatech.se>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 1 · High: 2 · Medium: 2 · Low: 0 (1)

- [Critical] ravb_get_ts_info() unconditionally dereferences
  priv->ptp.clock via ptp_clock_index() whenever the hardware table…
- [High] For Gen3 (and Gen4, which shares ravb_gen3_ptp_info in this
  commit) the PTP clock is registered by info->ptp->ndev_open()…
- [High] ravb_ptp_stop() does not clear priv->ptp.clock, so the stop
  callback is not idempotent: a second invocation without an intervening…
- [Medium] ravb_dmac_init() now returns the error from
  info->ptp->dmac_start() (ravb_ptp_init() for Gen2/RZ-V2M), creating a…
- [Medium] The commit message presents the change as a mechanical
  refactor ("replacing the flags for Gen2 behavior (info->gptp) and Gen3…

Pre-existing issues:
- [Low] In ravb_ptp_init() the GTI load sequence requests loading with
  GCCR_LTI (0x8) but the following wait — commented "Wait for GIT…

--

net: ethernet: ravb: Replace gPTP flags with callbacks

The gPTP behavior flags info->gptp (Gen2) and info->ccc_gac (Gen3) are
replaced by a new struct ravb_gptp_info holding callbacks for config mode
entry, DMAC start/stop and ndev open/close.  Each hardware info table now
points at a per-generation callback table.  This prepares for adding Gen4
support.

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 0c122a8158409..6603f90b19e15 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h

[ ... ]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 7c7b3ac81e5d6..5d5b9c0e2f450 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -712,8 +712,8 @@ static int ravb_dmac_init(struct net_device *ndev)
>  		return error;
>  
>  	/* Initialise PTP Clock driver */
> -	if (info->gptp)
> -		ravb_ptp_init(ndev);
> +	if (info->ptp && info->ptp->dmac_start)
> +		return info->ptp->dmac_start(ndev);
>  
>  	return 0;
>  }

[Severity: Medium]
Can this leak the descriptor rings and page pools?

For Gen2 and RZ/V2M, .dmac_start is ravb_ptp_init(), which can fail with
the PTR_ERR() from ptp_clock_register().  That error is now returned from
ravb_dmac_init() after info->dmac_init() already allocated the page pools,
rx_buffers, tx_skb arrays, aligned TX buffers and the coherent descriptor
rings, and after the DMAC was switched to CCC_OPC_OPERATION.

In ravb_open() that error goes to out_set_reset:

out_set_reset:
	ravb_set_opmode(ndev, CCC_OPC_RESET);

so ravb_stop_dma() is skipped and ravb_ring_free() is never called.  Since
ndo_open failed, ravb_close() will not run either, and the next open
re-runs ravb_ring_init() which overwrites priv->rx_pool[], priv->rx_buffers[],
priv->tx_skb[], priv->rx_ring[] and priv->tx_ring[] unconditionally, so the
previous allocations can never be freed.

The other two callers see the same new late failure.  ravb_set_ringparam()
returns the error with the netdev still detached and the DMAC in operation
mode, and ravb_tx_timeout_work() returns with all TX queues stopped, which
seems to contradict its own comment:

	/* If ravb_dmac_init() fails, descriptors are freed. So, this
	 * should return here to avoid re-enabling the TX and RX in
	 * ravb_emac_init().
	 */

Would it make sense to roll back inside ravb_dmac_init() when the gPTP start
callback fails (stop the DMA, return to CONFIG mode and free the rings) so
that the documented post-condition of a failed ravb_dmac_init() still holds
for every generation?

[Severity: Medium]
The commit message describes this as replacing "the flags for Gen2 behavior
(info->gptp) and Gen3 behavior (info->ccc_gac) with callbacks", which reads
as a mechanical refactor.

The patch also changes failure behaviour.  Before, both call sites discarded
the ravb_ptp_init() return value:

	if (info->gptp)
		ravb_ptp_init(ndev);

	return 0;

Now ravb_dmac_init() propagates it for Gen2/RZ-V2M, and ravb_open() aborts
when the Gen3/Gen4 .ndev_open callback fails, so a PTP clock registration
failure turns into a failed ndo_open (and a failed ethtool ring resize or
TX timeout recovery) where it previously left the interface fully usable.

Only the v2 changelog below the '---' line mentions this ("Handle error from
starting the PTP clock"), and that text is dropped when the patch is applied.
Could the commit message itself mention the behaviour change?

> @@ -1124,8 +1124,8 @@ static int ravb_stop_dma(struct net_device *ndev)
>  	}
>  
>  	/* Stop PTP Clock driver */
> -	if (info->gptp)
> -		ravb_ptp_stop(ndev);
> +	if (info->ptp && info->ptp->dmac_stop)
> +		info->ptp->dmac_stop(ndev);
>  
>  	/* Stop AVB-DMAC process */
>  	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);

[Severity: High]
Can this end up calling ptp_clock_unregister() twice on the same clock?

ravb_ptp_stop() no longer clears priv->ptp.clock:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_stop() {
	...
	if (priv->ptp.clock)
		ptp_clock_unregister(priv->ptp.clock);
}

so the callback is not idempotent.  With .dmac_stop = ravb_ptp_stop for Gen2
and RZ/V2M, ravb_stop_dma() is reachable from ravb_close(),
ravb_set_ringparam(), ravb_tx_timeout_work() and the ravb_open() error path,
and two stops with no ravb_ptp_init() in between look possible:

ethtool -G eth0 rx 4096
  ravb_set_ringparam()
    ravb_stop_dma()
      info->ptp->dmac_stop()   -> ravb_ptp_stop() -> ptp_clock_unregister()
                                  priv->ptp.clock left dangling
    ravb_dmac_init()           -> fails (ravb_ring_init() -ENOMEM, or
                                  ravb_set_opmode() timeout), so dmac_start
                                  and ravb_ptp_init() never run
    return error               -> netdev still running

ip link set eth0 down
  ravb_close()
    ravb_stop_dma()
      info->ptp->dmac_stop()   -> ravb_ptp_stop()
                                  if (priv->ptp.clock) still true
                                  ptp_clock_unregister() on freed memory

The same interleaving looks reachable through ravb_tx_timeout_work(), where a
successful ravb_stop_dma() is followed by a failing ravb_dmac_init() and
'goto out_unlock' with the interface still up.

The xchg(&priv->ptp.clock, NULL) that used to make this idempotent was
removed by the earlier series commit "net: ethernet: ravb: Propagate error
from ptp_clock_register()", and ravb_ptp_stop() is still non-idempotent at
the end of the series.  Should priv->ptp.clock be cleared in
ravb_ptp_stop()?

> @@ -1774,7 +1774,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *hw_info = priv->info;
>  
> -	if (hw_info->gptp || hw_info->ccc_gac) {
> +	if (hw_info->ptp) {
>  		info->so_timestamping =

[Severity: Critical]
Is this guard sufficient for the ptp_clock_index() call in the body?

hw_info->ptp is a static hardware capability, but the body still does:

	info->phc_index = ptp_clock_index(priv->ptp.clock);

and with CONFIG_PTP_1588_CLOCK enabled that is:

drivers/ptp/ptp_clock.c:ptp_clock_index() {
	return ptp->index;
}

priv->ptp.clock is NULL until the interface is opened (Gen3/Gen4 register in
the .ndev_open callback, Gen2/RZ-V2M in .dmac_start), and it is left dangling
after ravb_ptp_stop() because that function no longer clears it.  So:

ethtool -T eth0        # device probed, never brought up
  ravb_get_ts_info()
    hw_info->ptp != NULL   # all ravb tables set .ptp
    ptp_clock_index(NULL)  # NULL dereference

ip link set eth0 up; ip link set eth0 down; ethtool -T eth0
  ravb_get_ts_info()
    ptp_clock_index(<freed ptp_clock>)  # value returned in phc_index

ETHTOOL_GET_TS_INFO is listed in net/ethtool/ioctl.c among the commands that
fall through before the ns_capable(CAP_NET_ADMIN) check, so this is reachable
by an unprivileged local user.

This is still broken at the end of the series, where ravb_get_ts_info() calls
hw_info->ptp->clock_index() and ravb_gen2_ptp_clock_index() is just
'return ptp_clock_index(priv->ptp.clock);'.  The cached priv->ptp.phc_index
(reset to -1 in ravb_ptp_stop()) plus the xchg() clearing of the pointer that
used to make this safe were removed by the earlier series commit "net:
ethernet: ravb: Propagate error from ptp_clock_register()".  Should the
phc_index only be reported when a clock is actually registered?

[ ... ]

> @@ -1967,8 +1957,11 @@ static int ravb_open(struct net_device *ndev)
>  	ravb_emac_init(ndev);
>  
>  	/* Initialise PTP Clock driver */
> -	if (info->ccc_gac)
> -		ravb_ptp_init(ndev);
> +	if (info->ptp && info->ptp->ndev_open) {
> +		error = info->ptp->ndev_open(ndev);
> +		if (error)
> +			goto out_ptp_stop;
> +	}
>  
>  	/* PHY control start */
>  	error = ravb_phy_start(ndev);

[Severity: High]
Does the out_ptp_stop label still stop the PTP clock for Gen3 and Gen4?

For ravb_gen3_ptp_info (which ravb_gen4_hw_info also uses in this commit) the
clock is registered from .ndev_open = ravb_ptp_init, and the only teardown is
.ndev_close = ravb_ptp_stop.  The label reachable from here is:

out_ptp_stop:
	ravb_stop_dma(ndev);
out_set_reset:
	ravb_set_opmode(ndev, CCC_OPC_RESET);

and ravb_stop_dma() only calls dmac_stop:

	if (info->ptp && info->ptp->dmac_stop)
		info->ptp->dmac_stop(ndev);

.dmac_stop is NULL in ravb_gen3_ptp_info, so ravb_ptp_stop() never runs.  If
ravb_phy_start() fails after a successful ndev_open, ndo_open returns an error
with the PHC still registered while the DMAC is forced to CCC_OPC_RESET and
the device is runtime suspended.  ndo_stop is not called for a failed open, so
nothing ever calls ndev_close for that registration, and each retried open
re-registers over priv->ptp.clock.

ravb_remove() does no PTP teardown:

	of_node_put(priv->of_gptp);
	reset_control_assert(priv->rstc);
	free_netdev(ndev);

Since ptp_clock_register() keeps the caller's struct ptp_clock_info pointer
(priv->ptp.info, inside the netdev private data), can the orphaned /dev/ptpN
outlive free_netdev() and dereference freed memory on a later ioctl?

The symmetric teardown existed at the series baseline as
'if (info->gptp || info->ccc_gac) ravb_ptp_stop(ndev);' at this label and was
dropped by the earlier series commit "net: ethernet: ravb: Simplify gPTP start
and stop"; the label is still just ravb_stop_dma() at the end of the series.
Should the open error path call info->ptp->ndev_close()?  The failing
ndev_open case itself is already cleaned up inside ravb_ptp_init().

[ ... ]

One more observation, unrelated to the diff itself:

[Severity: Low]
This isn't a bug introduced by this patch, but the GTI load sequence in
ravb_ptp_init() waits on the wrong field:

drivers/net/ethernet/renesas/ravb_ptp.c:ravb_ptp_init() {
	...
	/* Request GTI loading. */
	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);

	/* Wait for GIT loading to complete. */
	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
}

GCCR_TCR and GCCR_LTI are distinct fields:

drivers/net/ethernet/renesas/ravb.h:
	GCCR_TCR	= 0x00000003,
	...
	GCCR_LTI	= 0x00000008,

so the wait cannot observe LTI completion, and ravb_wait()'s return value is
discarded as well.  The worst effect I can see is a transient unloaded timer
increment or an -EBUSY from a very early ravb_ptp_adjfine(), which treats a
set GCCR_LTI as busy.

The pre-existing baseline had no LTI poll at all in ravb_set_gti(); the
misleading comment came from the earlier series commit "net: ethernet: ravb:
Move programming of gPTP timer interval", whose message also states that the
init function waits for the interval programming to be acknowledged.  Should
the wait poll GCCR_LTI and check the result?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902084703.3228504-1-niklas.soderlund%2Brenesas%40ragnatech.se
