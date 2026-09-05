Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21F3822B7
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640650; cv=none; b=ub2bB1RTi7PGXJhcxgEzzp0/fZO0xfDvZOcURajG1FmLq8SDy2+ZTW+w6hSkONCO6Uu77nFHL/4pTLWOMxfDBOVecAzCSaIYH94oZ+NhDGTkrO1XzEn/iMRKI0jmBxi1BITN+bmHFgqLL17jyoRWre7XEvVdeoAQOwJbLYRTaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640650; c=relaxed/simple;
	bh=ICEpzKi6kATJUmvYD8BN4f13AQ+DCneyeypQsPZEY+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwMrb5XwWhiszjlY1xxwvm1HZ+QbE9K5TWWIS1qqA5nEqD7HkkuAQpDhtbYlsvnwDHqgUWNfgA6iG331BSJzhzvxYSNHU2W0Rjm7J0FUv7m3q7CnnJt4yQVnT1JkcAPDpZHyld3yN9RPRlcUcRRlkwsaUIOgeVF7mCoCzHBbTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5NFOFf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5NFOFf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AF51F00A3A;
	Sat,  5 Sep 2026 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640648;
	bh=OhydR+E8iUcPwveYCq2H4pq7lSGRhUqtpCIBsxMPfyY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i5NFOFf7/5gpGPriZp09G2tC5H7LC/FhjWL1siIxU3RT2VQS0f6PCdT64+i+LqACB
	 4zZafKn4y31dUPBMXAmLS7OcpljrunxfPfuECK748EPJ3LnqohcmPK3Bw4M2zl8MHz
	 1Ht/eQBmSiFnJDwp5w74jPy+viVMWtTMHgl9Sj07GqqJgjtuUR0h7Bwm8+ixLC3QTZ
	 LOIPI2gcRiTTpiOT6y6uWeC89t2csLPc0xnbbw8rvn4j4LB8uNnFR8P4pgyBfRMbOO
	 0ldbKDCDTJXQlPGCyGoTdGoOLNT/ObBzQYyQaoetZ7xdSK1EFTKzaOczFHYdGl7TCF
	 oMNtKLr7Y7poA==
Subject:
 Re: [net PATCH 1/4] fbnic: reset num_napi when the IRQ vectors are freed
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Sat, 05 Sep 2026 20:37:27 +0000
Message-ID: <178864064783.219967.6355835755160509945@kernel.org>
In-Reply-To:
 <178838831069.11136.15113954049469090479.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178838831069.11136.15113954049469090479.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

- [Medium] The patch encodes "datapath torn down" as `fbn->num_napi == 0`
  while deliberately leaving `netif_running(netdev)` true…

Pre-existing issues:
- [High] __fbnic_pm_attach()
  (drivers/net/ethernet/meta/fbnic/fbnic_pci.c) drops RTNL after…

--

fbnic: reset num_napi when the IRQ vectors are freed

This clears fbn->num_napi in fbnic_pm_suspend() after the datapath has
been torn down and the IRQs are about to be freed, and also clears it in
__fbnic_pm_resume() when __fbnic_open() fails, so the count-bounded
consumers such as fbnic_dbg_down() no longer walk freed napi vectors.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index 8b9bc9e8ea56..c6698e3002a1 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -434,6 +434,7 @@ static int fbnic_pm_suspend(struct device *dev)
>  {
>  	struct fbnic_dev *fbd = dev_get_drvdata(dev);
>  	struct net_device *netdev = fbd->netdev;
> +	struct fbnic_net *fbn;
>  
>  	if (fbnic_init_failure(fbd))
>  		goto null_uc_addr;
> @@ -441,11 +442,16 @@ static int fbnic_pm_suspend(struct device *dev)
>  	rtnl_lock();
>  	netdev_lock(netdev);
>  
> +	fbn = netdev_priv(netdev);
> +
>  	netif_device_detach(netdev);
>  
>  	if (netif_running(netdev))
>  		netdev->netdev_ops->ndo_stop(netdev);
>  
> +	/* The IRQs are about to be freed, so drop the napi vector count */
> +	fbn->num_napi = 0;
> +

[Severity: Medium]
This makes num_napi == 0 the marker for "datapath torn down" while
netif_running(netdev) is deliberately left true (ndo_stop is called
directly, so __LINK_STATE_START stays set).  Do the netdev queue
management ops cope with that combination?

fbnic_queue_mem_alloc() in fbnic_txrx.c uses netif_running() as the test
for "the napi vectors exist" and then divides by the count:

	if (!netif_running(dev))
		return fbnic_alloc_qt_page_pools(fbn, qt, idx);

	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
	nv = fbn->napi[idx % fbn->num_napi];

fbnic_queue_start() and fbnic_queue_stop() do the same modulo with no
guard at all:

	real = container_of(fbn->rx[idx], struct fbnic_q_triad, cmpl);
	nv = fbn->napi[idx % fbn->num_napi];

With num_napi == 0, is idx % fbn->num_napi a divide error oops?

These ops look reachable in that state.  fbnic_netdev_alloc() sets
netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops, so a memory provider can
be bound to an fbnic Rx queue (io_uring zcrx via netif_mp_open_rxq(), or
devmem).  On teardown of the io_uring fd or the netlink socket,
__netif_mp_close_rxq() -> netdev_rx_queue_reconfig() in
net/core/netdev_rx_queue.c calls ndo_queue_mem_alloc unconditionally and
ndo_queue_stop/ndo_queue_start under netif_running(dev), holding only the
netdev instance lock and doing no netif_device_present() check, unlike
the netdev-genl bind entry points.  real_num_rx_queues is not reset by
ndo_stop, so the index checks still pass.

The window is not short: userspace is not frozen during PCIe error
recovery, and the state persists indefinitely when __fbnic_open() fails
on resume or when fbnic_err_slot_reset() returns
PCI_ERS_RESULT_DISCONNECT so .resume and __fbnic_pm_attach() never run.

For completeness, the same sequence already oopsed before this patch,
since fbnic_free_napi_vector() sets fbn->napi[i] = NULL and
fbnic_remove_rx_ring() sets fbn->rx[q_idx] = NULL, so the pre-patch
crash was a NULL dereference rather than a divide error.  The question is
whether the torn-down state can be made unambiguous for all consumers,
for example by gating the queue management ops on
netif_device_present() or on an explicit datapath-up flag, rather than
only fixing the count-bounded consumers.

>  	netdev_unlock(netdev);
>  	rtnl_unlock();
>  
> @@ -508,16 +514,20 @@ static int __fbnic_pm_resume(struct device *dev)
>  	if (fbnic_init_failure(fbd))
>  		return 0;
>  
> +	rtnl_lock();
> +	netdev_lock(netdev);
> +
>  	fbn = netdev_priv(netdev);
>  
>  	/* Reset the queues if needed */
>  	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
>  
> -	rtnl_lock();
> -	netdev_lock(netdev);
> -
> -	if (netif_running(netdev))
> +	if (netif_running(netdev)) {
>  		err = __fbnic_open(fbn);
> +		/* On failure the vectors are freed, so drop the count */
> +		if (err)
> +			fbn->num_napi = 0;
> +	}
>  
>  	netdev_unlock(netdev);
>  	rtnl_unlock();

[Severity: High]
This isn't a bug introduced by this patch, but while the resume path is
being reworked to take rtnl_lock() plus netdev_lock() around the
netif_running() test, __fbnic_pm_attach() in the same file still does the
equivalent test with neither lock held:

	rtnl_lock();
	fbnic_reset_hw_stats(fbd);
	rtnl_unlock();
	...
	fbn = netdev_priv(netdev);

	if (netif_running(netdev))
		fbnic_up(fbn);

	netif_device_attach(netdev);

Can a close slip in between the netif_running() test and fbnic_up()?
__dev_close_many() in net/core/dev.c explicitly allows ndo_stop after a
detach:

		/*
		 *	Call the device specific close. This cannot fail.
		 *	Only if device is UP
		 *
		 *	We allow it to be called even after a DETACH hot-plug
		 *	event.
		 */
		if (ops->ndo_stop)
			ops->ndo_stop(dev);

so fbnic_stop() -> fbnic_free_napi_vectors() can NULL and kfree() every
entry of fbn->napi[] while fbn->num_napi keeps the normal queue count.
fbnic_up() -> fbnic_napi_enable() then walks that array:

	for (i = 0; i < fbn->num_napi; i++) {
		struct fbnic_napi_vector *nv = fbn->napi[i];

		napi_enable_locked(&nv->napi);

Is that a NULL dereference, or a use-after-free of the vector, when the
close won the race?

The path is fbnic_err_slot_reset() succeeding -> fbnic_err_resume() ->
__fbnic_pm_attach(), which runs from the PCI recovery context with
userspace not frozen, and that context takes only device_lock, never
rtnl or netdev->lock, so an "ip link set dev X down" on another CPU is
free to run concurrently.  Would it make sense to serialize the
netif_running() check and the dependent fbnic_up() under the same
rtnl_lock() and netdev_lock() pair now used by suspend and resume?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178838795612.11136.15512516427273655916.stgit%40ahduyck-xeon-server.home.arpa
