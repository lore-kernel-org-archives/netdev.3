Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394133;
	b=NDQvfGHF270SOs6mOszSrb2AuQpa/XaVLSYCjG/TZ2HAj8RrFi/PW6XxLDJvKGfrsMyd
	 DJ56N0zQwJmjOiJYfJ35fCXIpyLrDPIHjTYRnZUa8NsWQgcSzhKmlNYHTFst0E9ml52yg
	 EJvV4UY0xxBluRIflRzpR1gFHPxWbd4+XR8+OSRNgTRXikGrUUadFZPzFrKnDrrnbSEKu
	 OiRVcBKPsl3GcqEZf05Q++uKzQ9sJ3sMZAdq/GxUGTxTTpW3WTQUPHl84scc/lvesOJE/
	 KTd03DA8xThOr8P6WXn6Lmz00Wqf4oyoHzq3vXr/32rsnlSHCBNbFP9Rj+9a6BO7CPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394133;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sQ1e5BMHct9CVSkcprSkfgDLFHB7m/4Z7mZC2D1t+LQ=;
	b=mmU2bhDn2GhqPLKaa9TMafP84RYutjcpj2gZebe2obReQeB7NqKbOGjbors7PdxgGlPy
	 eC6S9gPHIQ7AJ7gOMaGKEsdrkcIGZi/BI1G7uzx2PK25NyTxXjwEri/R0OPkQ1OPj2eRl
	 W9wSDtqqyEIzXdR5y6zEDmvj1xg2PDCgQAVFRzVuvl8iTCsXJeNkJ7SWJPXkZKTdJqcNr
	 hVESK3Cb3JWlW9cLpwYL5PwHWp/t0GGCz+iAa8o4UIAXVyuwMoALH+YwZDBm1i2jTl3Uz
	 1VDncSbUxjJneL70xTDVMh+2kdwV4ploOe3qLVGl1AnRyuO5nU15DwFVevpr6oiOYxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWJpuRSS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E268606A8A6
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWJpuRSS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981351F00A06;
	Wed, 11 Nov 2026 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394133;
	bh=sQ1e5BMHct9CVSkcprSkfgDLFHB7m/4Z7mZC2D1t+LQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IWJpuRSSwkC10wRf2WQy7sGTQGuOnelgom9XuFi7lEvWknlg2jIbQ6qymNvglA6iw
	 PLeTThmqlHTmICSLmXkqCjqtB/mqiaQRkMiW3bWxgZ+PYlfMz/GP8YdZO6yl6qPUts
	 EtkweXfuW4Z6aGVR6dO3YQLYnuAZ7TGuJinrcy0J+mrCw2nMtd0TBHGQ8g4ZXYVn6E
	 0pCX5NRnfLTODBgWkjS88+pYDKpx2qWG2o6vyRDlNm2b1DXUEuldyxd881ysqrpSpd
	 EozQ57CwRI0ed1wIU85aoNPEI7dYSMEWCP6c21b3v5Jh0jLp+EDr69OoLxJUiTltcx
	 ohf6B5z3nqiwg==
Subject: Re: [PATCH net-next v2 4/5] hv_netvsc: move a new VF to netvsc's
 netns from a work item
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 kameroncarr@linux.microsoft.com, ernis@linux.microsoft.com
Date: Wed, 11 Nov 2026 10:48:52 +0000
Message-ID: <179439413220.2199510.12624366739640158561@kernel.org>
In-Reply-To: <20261109194843.1353592-5-kuba@kernel.org>
References: <20261109194843.1353592-5-kuba@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] netvsc_resume() now always requeues vfns_work, and it does so
  from the vmbus noirq resume phase (vmbus_pm:…
- [Low] netvsc_register_vf() takes a tracked reference on a VF registered
  in another netns (netdev_hold(vf_netdev, &vfns_dev_tracker) and stores…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but netvsc_probe()
  can free the net_device while its embedded vfns_work is still queued.

--

hv_netvsc: move a new VF to netvsc's netns from a work item

The patch stops calling dev_change_net_namespace() directly from the VF's
NETDEV_REGISTER notifier, which deadlocks for ops-locked VFs. Instead it
takes a reference on the VF in vfns_dev and has vfns_work move it, or take
it over if netvsc reached the VF's netns first. Suspend now keeps vfns_dev,
and resume queues the work again.

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 61109ff9927fb..d534e574bcf22 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c

[ ... ]

> @@ -2340,19 +2346,17 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
>  
>  	/* if synthetic interface is a different namespace,
>  	 * then move the VF to that namespace; join will be
> -	 * done again in that context.
> +	 * done again in that context. The VF's lock is held
> +	 * for its registration, so leave the move to vfns_work.
>  	 */
>  	if (!net_eq(dev_net(ndev), dev_net(vf_netdev))) {
> -		ret = dev_change_net_namespace(vf_netdev,
> -					       dev_net(ndev), "eth%d");
> -		if (ret)
> -			netdev_err(vf_netdev,
> -				   "could not move to same namespace as %s: %d\n",
> -				   ndev->name, ret);
> -		else
> -			netdev_info(vf_netdev,
> -				    "VF moved to namespace with: %s\n",
> -				    ndev->name);
> +		if (net_device_ctx->vfns_dev != vf_netdev) {
> +			netvsc_vfns_dev_put(net_device_ctx);
> +			netdev_hold(vf_netdev, &net_device_ctx->vfns_dev_tracker,
> +				    GFP_KERNEL);
> +			net_device_ctx->vfns_dev = vf_netdev;
> +		}

[Severity: Low]
What drops this reference if the VF is unregistered while it is parked
in vfns_dev?

The NETDEV_UNREGISTER handler finds netvsc only through the master upper
device:

drivers/net/hyperv/netvsc_drv.c:netvsc_unregister_vf() {
    ...
	ndev = get_netvsc_byref(vf_netdev);
	if (!ndev)
		return NOTIFY_DONE;
    ...
}

A VF that is held only in vfns_dev has not joined netvsc, so this lookup
returns NULL. Only vfns_work, through netvsc_event_set_vf_ns() and
netvsc_vfns_dev_put(), or netvsc_remove() drops the reference.

Usually the work runs soon and drops it when it sees reg_state !=
NETREG_REGISTERED. But netvsc_suspend() cancels vfns_work and keeps
vfns_dev until netvsc_resume() queues the work again.

If the VF is unregistered in that window, will unregister_netdevice()
wait in netdev_wait_allrefs_any() until thaw_noirq/restore_noirq, with
"waiting for ethX to become free" messages? netvsc ignores the repeated
NETDEV_UNREGISTER that the wait loop sends.

The window looks narrow, since hv_pci and the VF driver have already
suspended by then. Should the unregister path still check vfns_dev and
drop the reference there?

> +		schedule_delayed_work(&net_device_ctx->vfns_work, 0);
>  		return NOTIFY_DONE;
>  	}

[ ... ]

> @@ -2703,6 +2707,7 @@ static void netvsc_remove(struct hv_device *dev)
>  
>  	rtnl_lock();
>  	cancel_delayed_work_sync(&ndev_ctx->vfns_work);
> +	netvsc_vfns_dev_put(ndev_ctx);
>  
>  	nvdev = rtnl_dereference(ndev_ctx->nvdev);
>  	if (nvdev)

[Severity: High]
This isn't a bug introduced by this patch, but netvsc_remove() cancels
vfns_work and the netvsc_probe() error path does not. Can netvsc_probe()
free the net_device while vfns_work is still queued?

register_netdevice(net) sends NETDEV_REGISTER for the netvsc device, and
netvsc_netdev_event() queues the work:

	if (event_dev->netdev_ops == &device_ops && event == NETDEV_REGISTER) {
		ndev_ctx = netdev_priv(event_dev);
		schedule_delayed_work(&ndev_ctx->vfns_work, 0);
		return NOTIFY_DONE;
	}

If a later NETDEV_REGISTER notifier rejects the device, register_netdevice()
calls unregister_netdevice_queue() and returns an error. For example,
mpls_dev_notify() returns an error when mpls_add_dev() fails with -ENOMEM.

netvsc_probe() then goes through register_failed -> rndis_failed -> ... ->
free_netdev(net), and it never calls
cancel_delayed_work_sync(&net_device_ctx->vfns_work).

Probe holds RTNL at this point, so rtnl_trylock() fails in
netvsc_vfns_work() and the work requeues itself with a 1 jiffy delay.

If the work is still pending when free_netdev() frees the netdev_priv
memory, wouldn't the timer and workqueue linkage, and the container_of()
in netvsc_vfns_work(), touch freed memory?

[ ... ]

> @@ -2789,6 +2798,9 @@ static int netvsc_resume(struct hv_device *dev)
>  	netvsc_devinfo_put(device_info);
>  	net_device_ctx->saved_netvsc_dev_info = NULL;
>  
> +	/* pick up whatever netvsc_suspend() stopped vfns_work from doing */
> +	schedule_delayed_work(&net_device_ctx->vfns_work, 0);
> +

[Severity: Medium]
Can this run the VF move or takeover before the VF's own driver has
resumed?

netvsc_resume() is called from the vmbus noirq phase:

drivers/hv/vmbus_drv.c:vmbus_pm {
	.freeze_noirq	= vmbus_suspend,
	.thaw_noirq	= vmbus_resume,
	.poweroff_noirq	= vmbus_suspend,
	.restore_noirq	= vmbus_resume,
}

vfns_work runs on system_percpu_wq, which isn't freezable, and it only
needs rtnl_trylock(). It can therefore run before the VF's PCI driver gets
its normal-phase .thaw/.restore callback. This happens when vfns_dev, or a
netvsc netns move, is still pending when netvsc_suspend() cancels the
work.

netvsc_event_set_vf_ns() then calls one of two paths:

- dev_change_net_namespace(), which closes the VF via ndo_stop
- netif_close() followed by netvsc_register_vf()

The second path calls ndo_bpf, ndo_set_features and netvsc_vf_join(), and
netvsc_vf_join() schedules vf_takeover and dev_open().

Take mana as an example. mana_gd_suspend() -> mana_remove(..., true) ->
mana_detach() saves port_st_save and clears port_is_up. The early
netif_close() then hits:

drivers/net/ethernet/microsoft/mana/mana_en.c:mana_close() {
    ...
	if (!apc->port_is_up)
		return 0;
    ...
}

The core then clears IFF_UP. On resume, mana_attach() brings the port
back up from port_st_save. The hardware port is then up while the netdev
is marked down.

A later dev_open() from vf_takeover would then either fail with -ENODEV
while the device is still detached, or call mana_open() ->
mana_alloc_queues() a second time on a port that is already up.

Before this patch, netvsc_resume() didn't touch the VF. Should this
requeue wait until the VF driver has resumed?

>  	rtnl_unlock();
>  
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109194843.1353592-1-kuba%40kernel.org
