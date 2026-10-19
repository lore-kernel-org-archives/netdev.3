Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427647;
	b=UDxKcnt+fKlWgPoZ1HKT5jgF750FL2DaGWkMm2WoiZtnsGdOeerXqjhTIHAubE5zeYBR
	 d4ygPKPJbRY0KzJAzh/hWRrzEfOofi5gKZwh1DW20XhYt0c/UTEoW22Ho2Tn0eYIrZt5t
	 vFlE9oItweoHii7voz4PlkwJzp1omYm5Jv3X1Ms8mLwZBsi/GBZCW3JR8VQHMz87Xi2fe
	 emRACF5bTww+eO3VYgvu7/lLJjjNi/QMBV1jJ1WXYj99tzMKjBfX/HXw1XhyLsFzHIbRw
	 GsCBeGU6gQ0eNFt/WIkJLcVl7TRLuA6WdiHMDMfmBSX9DqbQpArub9mv4IK0/27VT+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427647;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tdknUqhDMJzziC2gSM3SmcPdwavdTPIJrKZx0MpO4e4=;
	b=h+Zh9+emw8DSOPvPwm0zACIWoMLLmhRpeJdnk9L2dwNdkbTF1UYdlf75EfS7vQ8JjW35
	 i89pVBlXkisUmNX/+SuS3S0c3K6+fvDNAPouBD+JbhttWIVEmAyDdAPOuIKjKpMBCfudU
	 96daaoAjM+gCjYaryPnme7u0Eyd/lrNZ9Avka9obKj7B0Lfo7juun57hW58TMKkwz+Pqy
	 +9GhqH8EFah1Gx2PNE/x92iYxKs7oUtkMN6riRN6dW7/TpgsBtW78svaHpC6Wg0bmTJ3O
	 yE5Ic/wsVtOM2BtTuBWGKC2tpwVRwYBplpwsf3XePBiBm9OSy5FZKk7m4zPK8QEhdxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1S2HDZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85399606A31B;
	Mon, 19 Oct 2026 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1S2HDZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8AA1F000C4;
	Mon, 19 Oct 2026 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427647;
	bh=tdknUqhDMJzziC2gSM3SmcPdwavdTPIJrKZx0MpO4e4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A1S2HDZIZFpMQpmRaIil+CsdqX9Ho2Rfbt4pUEf57A2SUNPUXpwUawOzp2LZ6xcGy
	 yizrpWuTjKaQ2B22OyNAZb1/bxm1tLT+nv59nF4SzJc305MgMaR+GgrOzzvz4gXqD7
	 55sTjBgiaWrjuLOwitIUIilor0KaDmCeGZL68LdZhUVeaEXFX12p4zfG9f+VexeL9R
	 8ZYNE53iJmU+rOvEj9PXOzbjXUvoLQkfciUBhSiIb52YRXYOOKOrPjZbXrTrCuIZP5
	 NJ16+FvU6wPXtIGliWTc1a+mPRN1OimxLrmiNRjTI4DL+ibUvsPHX8kVxIFzG4F2AS
	 aViku8Yk/4RtA==
Subject: Re: [PATCH net-next v1 2/5] net: lan743x: start phylink last and stop
 it first
From: netdev-bot+sashiko@kernel.org
To: cbabroski@nvidia.com
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, Raju.Lakkaraju@microchip.com,
 davthompson@nvidia.com
Date: Mon, 19 Oct 2026 16:34:05 +0000
Message-ID: <179242764576.3135.4479437969199107753@kernel.org>
In-Reply-To: =?utf-8?q?=3C84c495b24206953fb799d4070c4d99ff27efb829=2E1792008?=
 =?utf-8?q?404=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
References: =?utf-8?q?=3C84c495b24206953fb799d4070c4d99ff27efb829=2E17920084?=
 =?utf-8?q?04=2Egit=2Ecbabroski=40nvidia=2Ecom=3E?=
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Moving phylink_stop() to the start of lan743x_netdev_close()
  relies on mac_link_down() (lan743x_phylink_mac_link_down ->…
- [High] On the suspend path, lan743x_pcidev_shutdown() calls
  netif_device_detach() (lockless netif_tx_stop_all_queues) and then…

Pre-existing issues:
- [High] On LAN7431/PCI11x1x boards with no DT node and no PHY on the
  MDIO bus, every open after the first one fails.
- [High] lan743x_pm_resume() ignores the return value of
  lan743x_netdev_open() (line 4063) and always calls…

--

net: lan743x: start phylink last and stop it first

This patch moves lan743x_phylink_connect() to the end of
lan743x_netdev_open() and lan743x_phylink_disconnect() to the start of
lan743x_netdev_close(). The goal is that mac_link_up() can no longer wake
the TX queues while the rings are missing. It also changes the open error
path, which used to leave phylink started and the PHY attached when
lan743x_ptp_open() failed.

> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 9e1276cf313c8..583f631df701b 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3334,6 +3334,8 @@ static int lan743x_netdev_close(struct net_device *netdev)
>  	struct lan743x_adapter *adapter = netdev_priv(netdev);
>  	int index;
>  
> +	lan743x_phylink_disconnect(adapter);
> +
>  	for (index = 0; index < adapter->used_tx_channels; index++)
>  		lan743x_tx_close(&adapter->tx[index]);

[Severity: High]
Can a TX queue get woken again after this point and stay awake while the
rings are freed?

With phylink_stop() moved here, the only thing keeping the queues stopped
during teardown is the netif_tx_stop_all_queues() call in
lan743x_phylink_mac_link_down(). TX NAPI stays live until napi_disable()
in lan743x_tx_close(), and lan743x_tx_napi_poll() wakes the queue whenever
it reclaims descriptors:

lan743x_tx_napi_poll() {
    ...
		if (tx->rqd_descriptors) {
			if (tx->rqd_descriptors <=
			    lan743x_tx_get_avail_desc(tx)) {
				tx->rqd_descriptors = 0;
				netif_tx_wake_queue(txq);
			}
		} else {
			netif_tx_wake_queue(txq);
		}
    ...
}

On the suspend path the qdisc is still attached:

lan743x_pm_suspend()
  lan743x_pcidev_shutdown()
    netif_device_detach()
    lan743x_netdev_close()
      lan743x_phylink_disconnect()   /* queues stopped */
      <TX completion on a channel not yet closed>
        lan743x_tx_napi_poll()
          netif_tx_wake_queue()
      lan743x_tx_close()             /* ring freed */

Could ndo_start_xmit() then reach lan743x_tx_xmit_frame() on the freed
ring?

Before this patch, the phylink_stop() at the end of close stopped the
queues again after the rings were gone (when the link was up). After this
patch, nothing stops a re-woken queue for the rest of suspend.

This looks to be fixed later in the series by "net: lan743x: quiesce TX
before freeing the rings". That commit adds a netif_device_present() check
before the NAPI wake, and adds synchronize_net() plus netif_tx_disable()
after lan743x_phylink_disconnect() in lan743x_netdev_close().

[Severity: High]
Can a transmit that is already in flight also race with the ring
teardown here?

netif_tx_stop_all_queues() in lan743x_phylink_mac_link_down() only sets
DRV_XOFF, just like netif_device_detach(). Neither one waits for an
ndo_start_xmit() that is already running on another CPU under the txq lock
and tx->ring_lock.

lan743x_tx_close()->lan743x_tx_ring_cleanup() then frees head_cpu_ptr,
buffer_info and ring_cpu_ptr without taking tx->ring_lock or the txq lock:

CPU1                                  CPU0
sch_direct_xmit()                     lan743x_pcidev_shutdown()
  lan743x_netdev_xmit_frame()           lan743x_netdev_close()
    lan743x_tx_xmit_frame()               lan743x_tx_close()
      /* uses tx->ring_cpu_ptr */           lan743x_tx_ring_cleanup()

The commit message says that on the suspend path ndo_start_xmit() can run
on a ring that "has just been freed", but the patch only removes the
link-up wake source. Is the in-flight case meant to be covered here too?

This also appears to be fixed later in the series by "net: lan743x:
quiesce TX before freeing the rings", which adds synchronize_net() and
netif_tx_disable() right after lan743x_phylink_disconnect().
netif_tx_disable() takes each txq lock, so it waits for in-flight
transmits.

[ ... ]

> @@ -3387,6 +3383,10 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  			goto close_tx;
>  	}
>  
> +	ret = lan743x_phylink_connect(adapter);
> +	if (ret)
> +		goto close_tx;
> +

[Severity: High]
This is a pre-existing issue, but does every open after the first one
fail on LAN7431/PCI11x1x boards that have no DT node and no PHY on the
MDIO bus?

In that case lan743x_phylink_connect() takes the fallback branch and calls
phylink_set_fixed_link() on every open:

lan743x_phylink_connect() {
    ...
			ret = phylink_set_fixed_link(adapter->phylink, &state);
			if (ret) {
				netdev_err(dev, "Could not set fixed link\n");
				return ret;
			}
    ...
}

phylink_set_fixed_link() only succeeds while the mode is still
MLO_AN_PHY, and it changes the mode for good when it succeeds:

phylink_set_fixed_link() {
	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
		return -EINVAL;
    ...
	pl->cfg_link_an_mode = MLO_AN_FIXED;
    ...
}

lan743x_phylink_disconnect() only calls phylink_stop() and
phylink_disconnect_phy(), and phylink_create() only runs at probe. Nothing
resets cfg_link_an_mode.

So the second ndo_open after ifdown/ifup, and every
lan743x_pm_resume()->lan743x_netdev_open(), would fail with "Could not set
fixed link" (-EINVAL).

Boards with a DT node seem fine, because phylink_fwnode_phy_connect()
returns 0 in fixed mode. The commit message covers a different "every
later open then fails" case (the PHY left attached), not this one.

[Severity: High]
This isn't a bug introduced by this patch, but what happens on resume
when this goto close_tx is taken?

lan743x_pm_resume() ignores the return value and attaches the device
anyway:

lan743x_pm_resume() {
    ...
	if (netif_running(netdev))
		lan743x_netdev_open(netdev);

	netif_device_attach(netdev);
	rtnl_unlock();
    ...
}

The device is still running, so netif_device_attach() calls
netif_tx_wake_all_queues(). That leaves the interface IFF_UP with awake
queues and no rings. Every TX/RX NAPI is disabled and deleted, with
NAPIF_STATE_SCHED and NPSVC still set.

A later ifdown, a second suspend, or a reboot through
lan743x_pcidev_shutdown() then runs:

lan743x_netdev_close()
  lan743x_tx_close()
    napi_disable()
      napi_disable_locked()

which waits on:

		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}

__netif_napi_del_locked() does not clear SCHED, so can this loop run
forever with rtnl held?

A transmit path that bypasses the qdisc and does not check carrier, such
as netpoll, could also reach lan743x_tx_xmit_frame() while ring_cpu_ptr
and buffer_info are NULL.

Together with the fixed-link -EINVAL above, every resume on fixed-link
boards without a DT node would hit this. It still seems to be present at
the end of the series. The lan743x_netdev_stop() wrapper added later only
skips close when !netif_device_present(), and resume has already
re-attached the device by then.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792008404.git.cbabroski%40nvidia.com
