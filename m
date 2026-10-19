Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427649;
	b=wp2BKqiX7NXIOZ1OnadKm95UczH23OPXafiOPK1oU2aSd1v9RqB1LdX41cRR7rXe0nHW
	 q9p/ceg/KNM8gvYAJQmlP5bLFbHp5qgqpmfEcw8kMGI8+DoygpuREk/AEGuhBZ++ZqFd5
	 RZAo5eJpFSLzIR8Wwnedxuh5QrQIHVUQl8OdeElvxTPUO52hNxBr1JJC5488VuA4XjSsY
	 M+LEe/GFVbHuCOjVeHtG9ubxaKb6LIQAWRzt2m1FB9VjtRD0N4jx0XpB/foGFTraxbp2U
	 1ExUgNcgDvgt2pxF6YRt+DjOVtIfWy/BW18laYr28Bt9AzE6JWnIODRAsT40pjLf8Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427649;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=038d+CtBGQcERvUEocIEX4/8hI0OmAJh33SghjiJ4eY=;
	b=fZU4o0ooCnpCTxLvGNP3h7U1VSo7G8x0N21gsI9U1tkajDJsCx1NOyPhzoUoXjOX3AeV
	 o9V/xSCY2D74HCiDXUKpjSnvC9pNDxA1icVG1gtwEj+xNWoh34cmLBuiNU78Mj+K9wdaG
	 8F9+Wg57h74OHSl4nz8jNig0WXClDYjwatibd5H64J4qt3vBt6zDYClUE1/jWi2ajTHot
	 NgM3+34hdEH1ng4RBs25XoYSu+fMvQSD2Wr3YGmNRVY99C4H/3itWcCynPYy8UWaz+pH6
	 jGMgQo1iw+cf+Tt9XYPaIV1PlLKVPxYxI8CXwlwJXY91p7l2IacWjgz+ko9rmDKMIRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faqDeLNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CC606A333;
	Mon, 19 Oct 2026 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faqDeLNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5841F000C6;
	Mon, 19 Oct 2026 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427648;
	bh=038d+CtBGQcERvUEocIEX4/8hI0OmAJh33SghjiJ4eY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=faqDeLNx4PY/DVWXymFr9gKLWzxkTjZW/YfvXDLMVy93ayn57O2cjC7EMhyhmSdRH
	 OFM4KyxrRAUTWFYSb6XHuH+JG8Gi8wTvLN3WkpVeAh0LFZhIgM+bmnnPx18yXP5fJn
	 eSrY5budS19skQLltYzafFdcaUkNej/MhjDm9eZLXShMFQRSX6QgFTanOLxcyZbnoW
	 PdRAErcHRyq5fMclhP23hF1rHoRCtuUeCIX7e9AZciNWfXiWiE4oZ3fuKQDdjq7zX0
	 rVU7lafc1Hl0Y3w0tySN5FEAml0vimNWJIFiajdS7PIyfZ8bXQsM5fOsS0lzCjC/DD
	 uFJpeQ5UqmjjA==
Subject:
 Re: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX timeout
From: netdev-bot+sashiko@kernel.org
To: cbabroski@nvidia.com
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Raju.Lakkaraju@microchip.com,
 davthompson@nvidia.com
Date: Mon, 19 Oct 2026 16:34:07 +0000
Message-ID: <179242764729.3135.6473581413465367257@kernel.org>
In-Reply-To: =?utf-8?q?=3C784a571839d5dd83c2c3e8ea38844159f353de77=2E1792008?=
 =?utf-8?q?404=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
References: =?utf-8?q?=3C784a571839d5dd83c2c3e8ea38844159f353de77=2E17920084?=
 =?utf-8?q?04=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says lan743x_dmac_init() now returns the
  soft-reset poll error so that the work cannot reopen a controller…
- [Medium] Before this patch, lan743x_hardware_init() could never fail.
- [Medium] On boards that use the driver's fixed-link fallback (LAN7431
  or PCI11x1x with no DT node and no PHY on the MDIO bus), the reopen…
- [Medium] lan743x_reset_work() holds rtnl and keeps the device detached
  from netif_device_detach() until netif_device_attach().
- [Medium] lan743x_reset_work() runs the full lan743x_netdev_close() on a
  controller it already treats as wedged.

Pre-existing issues:
- [Medium] After the automatic TX-timeout reset, tx->ts_flags still
  contains TX_TS_FLAG_ONE_STEP_SYNC.

--

net: lan743x: reset the device on TX timeout

This adds an ndo_tx_timeout handler. The handler schedules a work item
that, under rtnl, detaches the netdev, closes it, soft-resets the DMA
controller, reopens it and reattaches it. It also makes
lan743x_dmac_init() return the soft-reset poll error, and routes
ndo_stop through a wrapper that skips the hardware close while the device
is detached.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 8d256a80dac64..2545a846478d6 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1516,10 +1516,14 @@ static void lan743x_rfe_set_multicast(struct lan743x_adapter *adapter)
>  static int lan743x_dmac_init(struct lan743x_adapter *adapter)
>  {
>  	u32 data = 0;
> +	int ret;
>  
>  	lan743x_csr_write(adapter, DMAC_CMD, DMAC_CMD_SWR_);
> -	lan743x_csr_wait_for_bit(adapter, DMAC_CMD, DMAC_CMD_SWR_,
> -				 0, 1000, 20000, 100);
> +	ret = lan743x_csr_wait_for_bit(adapter, DMAC_CMD, DMAC_CMD_SWR_,
> +				       0, 1000, 20000, 100);
> +	if (ret)
> +		return ret;

[Severity: Medium]
The commit message only talks about probe here. However,
lan743x_hardware_init() is also called from lan743x_pm_resume().

Before this change lan743x_hardware_init() could not fail in practice,
so the resume error branch was dead code. Does this new return make that
branch reachable?

lan743x_pm_resume() {
    ...
	ret = lan743x_hardware_init(adapter, pdev);
	if (ret) {
		netif_err(adapter, probe, adapter->netdev,
			  "lan743x_hardware_init returned %d\n", ret);
		lan743x_pci_cleanup(adapter);
		return ret;
	}
    ...
}

If that branch runs, the netdev stays registered and detached. A later
unbind then runs:

lan743x_pcidev_remove()
  lan743x_full_cleanup()
    lan743x_hardware_cleanup()   <- INT_EN_CLR write to a disabled device
    lan743x_pci_cleanup()        <- second region release and disable

Would that release the PCI regions twice and trigger the "disabling
already-disabled device" warning?

> +
>  	switch (DEFAULT_DMA_DESCRIPTOR_SPACING) {
>  	case DMA_DESCRIPTOR_SPACING_16:
>  		data = DMAC_CFG_MAX_DSPACE_16_;

[ ... ]

> @@ -3431,6 +3441,61 @@ static int lan743x_netdev_open(struct net_device *netdev)

[ ... ]

> +static void lan743x_reset_work(struct work_struct *work)
> +{
> +	struct lan743x_adapter *adapter =
> +		container_of(work, struct lan743x_adapter, reset_work);
> +	struct net_device *netdev = adapter->netdev;
> +	int ret;
> +
> +	rtnl_lock();
> +
> +	if (!netif_running(netdev) || !netif_device_present(netdev))
> +		goto unlock;
> +
> +	netdev_warn(netdev, "resetting after TX timeout\n");
> +
> +	netif_device_detach(netdev);
> +	lan743x_netdev_close(netdev);

[Severity: Medium]
Here lan743x_netdev_close() runs on a controller that is already assumed
to be wedged. The controller-wide DMAC_CMD_SWR_ reset only happens later,
in lan743x_dmac_init().

In lan743x_tx_close(), suppose the channel does not stop and the
per-channel reset also times out. The error is only logged, and the ring
is freed anyway:

lan743x_tx_close() {
    ...
		ret = lan743x_dmac_tx_reset(adapter, tx->channel_number);
		if (ret)
			netdev_err(adapter->netdev,
				   "TX channel %d reset timed out\n",
				   tx->channel_number);
    ...
	lan743x_tx_release_all_descriptors(tx);
    ...
	lan743x_tx_ring_cleanup(tx);
}

lan743x_rx_close() does the same for the RX ring, the head write-back
buffer and the RX skbs.

If the engine is still running at that point, could it write head indices
or received frames into memory that was already freed and maybe reused?
Should the DMAC soft reset happen before the rings are torn down?

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. The same
close/open sequence leaves the TX one-step state inconsistent, and with
this patch the watchdog can trigger that sequence automatically.

lan743x_ptp_open() calls lan743x_ptp_reset() and sets the RX filter back
to HWTSTAMP_FILTER_NONE. However, tx->ts_flags still has
TX_TS_FLAG_ONE_STEP_SYNC, and nothing turns one-step Sync insertion back
on in the hardware.

After the reset, lan743x_ptp_hwtstamp_get() still reports:

	if (tx->ts_flags & TX_TS_FLAG_ONE_STEP_SYNC)
		config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;

and lan743x_tx_xmit_frame() still sets ignore_sync for Sync frames:

		if (tx->ts_flags & TX_TS_FLAG_ONE_STEP_SYNC)
			ignore_sync = true;

Can Sync frames go out without a hardware-inserted origin timestamp until
the application sets up timestamping again?

Admin down/up and suspend/resume already have the same mismatch. The
commit message also documents it ("one-step sync insertion is disabled,
while the driver keeps its TX timestamping flags"). The PHC is
unregistered and registered again, so applications have to reconfigure.
Reconfiguring applies one-step mode again through
lan743x_ptp_hwtstamp_set().

> +
> +	ret = lan743x_dmac_init(adapter);
> +	if (ret) {
> +		netdev_err(netdev, "DMA controller reset failed: %d\n", ret);
> +		goto close;
> +	}

[Severity: Medium]
According to the commit message, lan743x_dmac_init() now returns the poll
error so the work does not reopen a controller whose reset timed out. It
also says the interface is taken down "so it can be brought back up
later".

lan743x_netdev_open() never calls lan743x_dmac_init(). That function is
only called from lan743x_hardware_init() (probe and resume) and from this
work.

So if the user runs "ip link set up" after this failure, does
lan743x_netdev_open() reopen the same controller that never came out of
reset?

The early return in lan743x_dmac_init() also skips the DMAC_CFG,
DMAC_COAL_CFG and DMAC_OBFF_CFG writes. Nothing on the open path writes
them again.

Should the open path retry the DMAC reset, or should the device be kept
from coming back up in this case?

> +
> +	ret = lan743x_netdev_open(netdev);
> +	if (ret) {
> +		netdev_err(netdev, "failed to reopen after reset: %d\n", ret);
> +		goto close;
> +	}

[Severity: Medium]
Some boards use the fixed-link fallback in lan743x_phylink_connect():
LAN7431 or PCI11x1x with no DT node and no PHY on the MDIO bus. Can this
reopen ever succeed on those boards?

On the first open, phylink_set_fixed_link() sets
pl->cfg_link_an_mode = MLO_AN_FIXED. Neither phylink_stop() nor
phylink_disconnect_phy() resets it. So on the reopen:

phylink_set_fixed_link() {
	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
		return -EINVAL;
    ...
}

lan743x_phylink_connect() then logs "Could not set fixed link" and
lan743x_netdev_open() fails. The work jumps to close: and calls
dev_close(). Every later attempt to bring the interface up fails the same
way.

The fixed-link handling is existing code. On these boards, though, the
new recovery turns a stalled TX queue into an interface that cannot come
back up until the driver is probed again.

> +
> +	goto attach;
> +
> +close:
> +	dev_close(netdev);
> +attach:
> +	netif_device_attach(netdev);

[Severity: Medium]
While the device is detached under rtnl here, multicast list writers that
do not take rtnl can still change dev->mc. The IPv6 socket join path is
one example:

ipv6_sock_mc_join()
  igmp6_group_added()
    dev_mc_add()
      __dev_set_rx_mode()
	if (!netif_device_present(dev))
		return;

These changes never reach the hardware. After netif_device_attach(),
nothing reprograms the filter. lan743x_rfe_open() only programs RSS, and
lan743x_rfe_set_multicast() is only called from ndo_set_rx_mode.

The normal open path resyncs because __dev_open() calls dev_set_rx_mode()
after ndo_open. This path has nothing equivalent.

Can the RFE filter get out of sync with dev->mc? Groups joined during the
reset would not be received, and groups left would stay in the filter,
until the next rx_mode change. Would a call to dev_set_rx_mode() after
the reopen fix this?

> +unlock:
> +	rtnl_unlock();
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792008404.git.cbabroski%40nvidia.com
