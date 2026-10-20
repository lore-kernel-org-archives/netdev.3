Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484766;
	b=0xej8xtCJS42g49QkECCcE33VaW+NLeLV7iMsFAnc2i55NlP5LDYXoS9zhO5uZtGTw0F
	 Kq1Gzpw4bXOtJR5oKPY71P52cLIpRVJexQuk+zSe2MM8g97nEqEKKHbqHOM6eF8g6N3y6
	 IFTF0UD4Fo0lOVTFpjtKs9eBd4fbXVj/ilk9Kw2ch6OcW09r7FFrd/K9Oq6h7GpsUoDcn
	 aev/QvM9UzyMwdPmHX5JnKn+bvsi8SGFCb9IOmCCVqPWIjvUaynZG46kxBWUIWZrOLKSU
	 yFev+bhiRKTEzaGP1rjre8IMlVAnzUAGbJvki19VydFWz7gs+BzYaFxYeNbbZD0VuVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484766;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4yt2k3OFgO+CSj9psyZ4z8Wras1baWDJX2LjUZnugB4=;
	b=44pGGzecN4sFx4yUxEqmZVCRY0uYU1U02yWPZtkQ1Y5cPsKWRnnvl2Tmyrnd9WFwVI8B
	 imBSfgOkSTBOi6VGnLy2GwWinz2bbNiDa8pqJKkhjJ/Nynq6aulVz5CK9UkyYF2H73GNT
	 k+sdb9kCfEhxsgtbXbYM4Na/voQa7TUsVreL34QLYkU6hixDUhKaMJvgyrRjcayTZNvuD
	 DSASzRV0OiDWMJlZBeQeZHBC46dKJFt20hZXSDyjO/F3aNPWBvnv5e+mralVbgHsL0GyT
	 eHcnwpFe02bT7l5YLdbYayrKPUAVdci7RbSk34InFsL6UgQ3wLtbI94XHBEuX+wrJTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3j5ShE5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF1606A33A;
	Tue, 20 Oct 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3j5ShE5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D0D1F000C9;
	Tue, 20 Oct 2026 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484765;
	bh=4yt2k3OFgO+CSj9psyZ4z8Wras1baWDJX2LjUZnugB4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N3j5ShE51K6FK+gUhDlVTlKzBTysMuYtoGrfcOIFYX5L1yMNfMHXTbpQj1FQCbRMe
	 kzAlZ3dtKPWa3iRsURFzC/mzh286GJuAMceLbJl6uDKWFIwCyW47iBCe8z7S4Rw6oR
	 5LivVR8miL0ONvmCQ+Gew4nJpEbuPB8CqrcLfboIObTU/nss/2khimJfM09ZbP06G1
	 WEj9c0cAkteaVeaYHjYsZAzHgrsqiiPdv+PF7NiHqFibjMk9WPpAP8Ak2GH0jnXyfR
	 y9jopV1sFRrZM2ypG5J6PXwPOtrqFdslTvo0GsT4xlIvkXw5+aDg00+cHpaRGlHYyb
	 4NceTKS4WvysA==
Subject:
 Re: [PATCH net 1/3] enic: retain datapath DMA resources until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com
Date: Tue, 20 Oct 2026 08:26:04 +0000
Message-ID: <179248476476.3135.2097789721461902194@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261016-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v1-1-d27b55f69883=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261016-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v1-1-d27b55f69883=40cisco=2Ecom=3E?=
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On terminal quarantine, enic_remove() skips
  enic_datapath_release(), the only caller of page_pool_destroy() on…
- [Medium] Each vnic_wq_disable() now sleep-polls for up to 500 ms; the
  old loop was 1000 x udelay(10), about 10 ms.
- [Medium] enic_datapath_quarantine() calls pci_clear_master() at runtime
  (enic_main.c:1767), but the driver keeps issuing firmware commands…
- [Medium] In enic_reset() and enic_tx_hang_reset(), quarantine is
  checked only after enic_stop().
- [Medium] enic_close_for_reconfigure() (enic_main.c:1982) calls
  enic_stop() directly before dev_close().
- [Low] The comment on enic->datapath_state in enic.h ('Retain the
  complete mapped datapath graph for the remainder of this boot') and…
- [Low] When enic_stop() or the enic_open() unwind quarantines the
  datapath, it returns before enic_datapath_release() →…

--

enic: retain datapath DMA resources until queues stop

The patch makes enic_stop() and the enic_open() unwind try every WQ/RQ
disable. If any queue fails to report RUNNING == 0, the whole datapath
graph is kept in a quarantined state and bus mastering is cleared.
It also switches the queue-disable polls to read_poll_timeout() with a
500 ms bound, and adds a remove-time recheck that either releases or
permanently retains the DMA graph.

> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 7a509a0569900..992ac43d1b0a3 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h

[ ... ]

> @@ -325,6 +333,10 @@ struct enic {
>  	spinlock_t vf_link_state_lock;
>  	enum enic_vf_link_state vf_link_state;
>  	bool vf_link_running;
> +	/* A queue-disable failure leaves DMA ownership unresolved.  Retain the
> +	 * complete mapped datapath graph for the remainder of this boot.
> +	 */
> +	enum enic_dma_state datapath_state;

[Severity: Low]
Is this comment accurate? If every queue reports RUNNING == 0 at removal,
enic_datapath_recheck_on_remove() calls enic_datapath_release(). That
releases the graph and sets the state back to ENIC_DMA_DOWN, and
enic_remove() then does the normal teardown.

The comment in the enic_open() unwind ("for the remainder of this boot")
says the same thing. So do the "remains quarantined until reboot" and
"DMA resources retained until reboot" messages.

Could these mention the remove-time release path?

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..5a205ea3031b9 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1718,11 +1729,51 @@ static void enic_notify_timer_start(struct enic *enic)

[ ... ]

> +static void enic_datapath_quarantine(struct enic *enic)
> +{
> +	WRITE_ONCE(enic->datapath_state, ENIC_DMA_QUARANTINED);
> +	WRITE_ONCE(enic->mbox_send_disabled, true);
> +	netif_device_detach(enic->netdev);
> +	netif_carrier_off(enic->netdev);
> +	/* Bus-master disable contains the failed function but does not return
> +	 * ownership of DMA resources which the device may still reference.
> +	 */
> +	pci_clear_master(enic->pdev);
> +}

[Severity: Medium]
Can devcmds still complete once bus mastering is cleared here? The netdev
is only detached, not unregistered, so ndo_get_stats64 still reaches the
firmware:

enic_get_stats()
  enic_dev_stats_dump()
    vnic_dev_stats_dump()
      vnic_dev_cmd()
        _vnic_dev_cmd2()

_vnic_dev_cmd2() writes the command into a host-memory ring. It then
polls result->color, which the device has to DMA-write. With BME off,
each call looks like it would busy-wait 1000 x udelay(100) under
spin_lock_bh(devcmd_lock) and then log "devcmd timed out".

The device's fetch_index would also stop advancing. After about 31
commands every call would then fail immediately with an unratelimited
"wq is full" error. Since /proc/net/dev and rtnetlink stats can be read
by unprivileged users, can this be used to flood the log?

There is a second case. When enic_datapath_recheck_on_remove() later
succeeds, the release path runs:

enic_datapath_release()
  enic_dev_notify_unset()
    vnic_dev_notify_unset()

vnic_dev_notify_unset() calls dma_free_coherent() on the notify buffer
before it sends CMD_NOTIFY, and that command cannot complete with BME
cleared. Does the firmware then keep the stale notify address? A rebind
calls pci_set_master() in enic_probe() before notify is set up again.
Could the firmware DMA into the freed buffer in that window?

[Severity: Low]
The runtime quarantine path does not free the IRQ or disable INTx. Only
enic_terminal_dma_quarantine() calls pci_intx(pdev, 0) and
enic_free_intr().

In INTx mode the line is IRQF_SHARED, so interrupts from a peer device
still run enic_isr_legacy():

	pba = vnic_intr_legacy_pba(enic->legacy_pba);
	if (!pba) {
		vnic_intr_unmask(&enic->intr[io_intr]);
		return IRQ_NONE;	/* not our interrupt */
	}

Does this unmask io_intr again after enic_stop() masked it?

If the PBA reports the notify bit, enic_notify_check()->enic_link_check()
can call netif_carrier_on() on the detached netdev, which undoes the
netif_carrier_off() above. It can also schedule link_notify_work, and
enic_mtu_check() can schedule change_mtu_work. None of these paths look
at datapath_state.

[ ... ]

> @@ -1870,33 +1954,44 @@ static int enic_stop(struct net_device *netdev)
>  	for (i = 0; i < enic->wq_count; i++) {
>  		err = vnic_wq_disable(&enic->wq[i].vwq);
>  		if (err)
> -			return err;
> +			netdev_err(netdev, "WQ %u did not stop: %d\n", i, err);
> +		if (err && !disable_err)
> +			disable_err = err;
>  	}
>  	for (i = 0; i < enic->rq_count; i++) {
>  		err = vnic_rq_disable(&enic->rq[i].vrq);
>  		if (err)
> -			return err;
> +			netdev_err(netdev, "RQ %u did not stop: %d\n", i, err);
> +		if (err && !disable_err)
> +			disable_err = err;
>  	}

[Severity: Medium]
How long can rtnl_mutex be held here when the device is wedged or
surprise-removed and the RUNNING registers read back as all-ones?

vnic_wq_disable() used to give up after about 10 ms. vnic_rq_disable()
used a tight 20000-read loop. Each now polls for up to 500 ms, and the
early return is gone. A full sweep could therefore take about
(wq_count + rq_count) * 500 ms. With ENIC_WQ_MAX and ENIC_RQ_MAX both
256, that is up to about 256 seconds.

The same sweep runs in the enic_open() unwind, and again in
enic_datapath_recheck_on_remove(). enic_stop() itself is called from
unregister_netdev() during remove, from set_ringparam via
enic_close_for_reconfigure(), from the change_mtu worker, and from both
reset workers. Could this trigger hung-task warnings or starve other
rtnl users for minutes?

Some callers ignore the return value but also get the longer bound:
vnic_wq_alloc()/vnic_rq_alloc(), the vnic_dev_init_devcmd2() error
unwind, vnic_dev_deinit_devcmd2(), and the admin channel close. The later
admin-channel patch also adds a retry around the admin close.

[ ... ]

> +int enic_close_for_reconfigure(struct net_device *netdev)
> +{
> +	int err;
> +
> +	/* dev_close() cannot propagate an ndo_stop() error. */
> +	err = enic_stop(netdev);
> +	if (err)
> +		return err;
> +
> +	dev_close(netdev);
> +	return 0;
> +}

[Severity: Medium]
enic_stop() now runs before dev_close() has called netpoll_poll_disable().
With netconsole active and the device in INTx mode, can another CPU be
in this path?

netpoll_poll_dev()
  enic_poll_controller()
    enic_isr_legacy()
      enic_notify_check()
        vnic_dev_notify_ready()

At the same time this CPU may be running:

enic_stop()
  enic_datapath_release()
    enic_dev_notify_unset()
      vnic_dev_notify_unset()

vnic_dev_notify_unset() calls dma_free_coherent() on vdev->notify but
only clears the pointer after the CMD_NOTIFY devcmd completes.
synchronize_irq() and napi_disable() do not cover handlers called directly
through ndo_poll_controller.

vnic_dev_notify_ready() checks vdev->notify and then memcpy()s from it,
looping while (csum != words[0]). Can it read the freed buffer, or even
spin forever if the freed memory holds a stable but mismatched checksum?

Before this patch, set_ringparam used dev_close(), which excluded netpoll.
The _enic_change_mtu() path already had the same pattern.

[ ... ]

> @@ -2287,7 +2395,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (reopen)
> +		enic_open(enic->netdev);
>  
>  	/* Re-establish the admin/MBOX channel after the data path is back up.
>  	 * It was fully torn down by enic_admin_channel_close() above;
> @@ -2297,19 +2406,27 @@ static void enic_reset(struct work_struct *work)
>  	if (enic_has_admin_chan(enic))
>  		enic_admin_chan_reopen(enic);

[Severity: Medium]
What happens if enic_open() fails here? For example, page_pool_create(),
the RQ fill or enic_dev_enable() fails, and the unwind then cannot stop a
queue. enic_open() calls enic_datapath_quarantine() and returns an error.
The worker checks neither the return value nor datapath_state before it
calls enic_admin_chan_reopen().

enic_admin_channel_open() allocates and enables the admin WQ/RQ, posts RX
buffers and issues QP_TYPE_SET. On success it does:

	WRITE_ONCE(enic->mbox_send_disabled, false);

Does this undo the mbox_send_disabled = true that
enic_datapath_quarantine() just set? It would then go on to the VF
capability check and registration, or the PF link_notify_work, on a
contained function.

In this tree a V2 device can still use DEVCMD1 over MMIO, so QP_TYPE_SET
can succeed with BME cleared. After the later "enic: require DEVCMD2 and
set the V2 VF mailbox source" commit, QP_TYPE_SET would probably time out
instead, and mbox_send_disabled would stay set. Even then, the worker
still enables admin DMA queues and posts buffers on a quarantined
function. It spends devcmd timeouts under rtnl, can push the admin graph
into quarantine too, and still fires NETDEV_REBOOT.

The enic_stop() failure case has a goto reset_out. Should there be a
similar check after enic_open()? enic_tx_hang_reset() has the same
sequence.

[ ... ]

> @@ -3429,14 +3630,25 @@ static void enic_remove(struct pci_dev *pdev)
>  				pci_disable_sriov(pdev);
>  		}
>  #endif
> +		if (enic_datapath_is_quarantined(enic))
> +			enic_datapath_recheck_on_remove(enic);
> +		if (enic_datapath_is_quarantined(enic)) {
> +			dev_err(&pdev->dev,
> +				"Queue DMA ownership unresolved; retaining resources until reboot\n");
> +			enic_terminal_dma_quarantine(enic);
> +			retain_dma = true;
> +			goto disable_device;
> +		}

[Severity: High]
Can the retained RX page pools outlive the struct pci_dev they point to?

enic_open() creates each pool with .dev = &enic->pdev->dev and
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV. This branch skips
page_pool_destroy(). page_pool does not take a reference on the device.
The retained netdev does not pin the parent either, because
unregister_netdev()->device_del() drops its reference on the PCI parent.

The PCI device can then go away entirely, through surprise hot-unplug or
DPC (the all-ones reads make quarantine certain in that case), sysfs
remove, or VF removal when SR-IOV is disabled. After that, an in-flight
RX page still held by a socket or GRO is returned to the retained pool:

page_pool return path
  page_pool_dma_sync_for_device()
    dma_dev_need_sync(pool->p.dev)
  __page_pool_release_page_dma()
    dma_unmap_page_attrs(pool->p.dev, ...)

Does this dereference the freed struct device and its DMA ops or IOMMU
state? Normally page_pool_destroy()->page_pool_scrub() clears dma_sync and
unmaps the pages first, but that step is skipped here.

The commit message only claims safety "while the PCI device remains
enumerated". Should the retained graph hold a reference on the PCI
device?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883%40cisco.com
