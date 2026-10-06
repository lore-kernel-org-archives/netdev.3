Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA43E5594;
	Tue,  6 Oct 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292696; cv=none; b=SzRaiJNrLN+2AsDKmRMVygMSeF/MvRzjYxFeX35KljOIFzzI9ErHvcY5ozDPiPgd7aqPzqf43G4lBERXb6J2v6RV6MR4/v+wZqDvP1uLoKPUxYydLMErqRh0gGEPmsCFiwk2Ag1IPRudIhgPJ/bbzSDMVGwuJ6MKQuErYppZliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292696; c=relaxed/simple;
	bh=Q6hr1e//NWP3w9MThugtcJDfN/0Qb8J9ZQvzVy5bgLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWbxghj3mC882P7KMEvIAieEPvAg6nqpgasM5F3dbfRVnrS/+AQ/p2MIBrrQ3uATvgZ8k7h2NGtP03b4hBBeK3tHQfLIa96SBGV3+uEUKdQAT36a7zRdzlZ6cWqwMg/mEILrfStg8TOkS1+G+BqqgHh//1uhDgWwocFSckyDcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJGjF317; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJGjF317"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635E41F00893;
	Tue,  6 Oct 2026 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791292695;
	bh=CQWkEbyFeoypLgC86ETxzKIKgUjEbxY7Sx+JR0+C0oQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LJGjF317k7V3P6G9GplpyL92/8Yh5NVHAvmwHiShqwcJnbSgL9Zo1AcWkxT+C45CH
	 zVppVIv7hLKBscwcjrlYdKn18pzizZ2fof7AzTDPz3OvHYlYXFnddprKUNx1a62/Th
	 ipbou2J36b4KHjKsd7G4HCgJ1+H423MLKC2Ac94h1GfPvPGyO9OdOGZfqPBs2J70OG
	 nn8hFsR8rxAtWPzLDL6VL5PcOtJ69gg8yqj2on5B9MiV+v6J97t8o02R4fsJe6zoAu
	 aHwI7CAsQjsZDe1b4ijautavlG8wD9cXYvqsSH2GOTiTrgW1V1T7I6hCDbyoHsL5aC
	 rtCz0eVNyF3ZA==
Subject: Re: [PATCH net v3 1/2] eth: fbnic: Preserve channels across resume
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mike.marciniszyn@gmail.com,
 almasrymina@google.com, netdev-bot+sashiko@kernel.org
Date: Tue, 06 Oct 2026 13:18:13 +0000
Message-ID: <179129269393.434549.14053731707723183539@kernel.org>
In-Reply-To: <20261002125617.409447-2-bjorn@kernel.org>
References: <20261002125617.409447-2-bjorn@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes resume fail outright when fewer MSI-X vectors
  come back than before suspend, and the commit message describes that…
- [High] After one failed resume, num_napi stays 0 for good, and the next
  open divides by zero and oopses.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  __fbnic_pm_attach() calls fbnic_up() without holding rtnl or the…
- [Medium] This problem wasn't introduced by this patch, but
  fbnic_service_task_stop() uses cancel_delayed_work(), which does not…

--

eth: fbnic: Preserve channels across resume

This patch keeps fbn->num_napi across suspend instead of clearing it. It
also drops the fbnic_reset_queues() call from __fbnic_pm_resume(), so the
pre-suspend channel layout is reused on resume. fbnic_stop() gets a new
early return for when the NAPI vectors have already been freed.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index c6698e3002a13..ec916c9f7faa4 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c

[ ... ]

> @@ -442,16 +441,11 @@ static int fbnic_pm_suspend(struct device *dev)
>  	rtnl_lock();
>  	netdev_lock(netdev);
>  
> -	fbn = netdev_priv(netdev);
> -
>  	netif_device_detach(netdev);
>  
>  	if (netif_running(netdev))
>  		netdev->netdev_ops->ndo_stop(netdev);

[Severity: Medium]
This is a pre-existing issue, but should fbnic_service_task_stop() use
cancel_delayed_work_sync() here?

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_service_task_stop() {
	...
	cancel_delayed_work(&fbd->service_task);
}

fbnic_service_task() takes rtnl_lock(), and at the end it re-arms itself:

	if (netif_running(netdev))
		schedule_delayed_work(&fbd->service_task, HZ);

fbnic_pm_suspend() calls ndo_stop directly, so __LINK_STATE_START stays
set. Suppose an instance is already running and blocked on rtnl_lock()
while suspend holds rtnl. The cancel on this path does not wait for it:

fbnic_stop()->fbnic_down()->fbnic_down_noidle()->fbnic_service_task_stop()

Suspend then drops rtnl and goes on to fbnic_fw_free_mbx(),
fbnic_free_irqs() and clearing uc_addr0/uc_addr4. Can the service task
then run fbnic_get_hw_stats32(), fbnic_fw_check_heartbeat() and
fbnic_health_check() against hardware that is being torn down? After that
it would re-arm every HZ while the device is suspended.

The MMIO accessors and the mailbox TX path have their own guards, so no
concrete crash has been shown. With this patch num_napi now stays
non-zero while napi[] is NULL. fbnic_napi_depletion_check() only runs
when netif_carrier_ok(), and phylink_suspend() turns the carrier off, so
that walk does not seem to be reached.

>  
> -	/* The IRQs are about to be freed, so drop the napi vector count */
> -	fbn->num_napi = 0;
> -
>  	netdev_unlock(netdev);
>  	rtnl_unlock();
>  
> @@ -519,9 +513,6 @@ static int __fbnic_pm_resume(struct device *dev)
>  
>  	fbn = netdev_priv(netdev);
>  
> -	/* Reset the queues if needed */
> -	fbnic_reset_queues(fbn, fbn->num_tx_queues, fbn->num_rx_queues);
> -

[Severity: High]
Wasn't this call the only place where the channel layout was clamped to
the MSI-X vectors actually granted on resume?

Earlier in __fbnic_pm_resume(), fbnic_alloc_irqs() renegotiates
fbd->num_irqs from the current online CPU count. It accepts as few as
FBNIC_NON_NAPI_VECTORS + 1:

	wanted_irqs += min_t(unsigned int, num_online_cpus(), FBNIC_MAX_RXQS);
	num_irqs = pci_alloc_irq_vectors(pdev, FBNIC_NON_NAPI_VECTORS + 1,
					 wanted_irqs, PCI_IRQ_MSIX);
	...
	fbd->num_irqs = num_irqs;

Before this patch, fbnic_reset_queues() clamped tx/rx to max_napis =
fbd->num_irqs - FBNIC_NON_NAPI_VECTORS and set num_napi = max(tx, rx).
The interface came back with fewer queues but still worked.

Fewer vectors can come back if CPUs went offline after probe or the
MSI-X grant is smaller. With this call removed, num_napi can then be
larger than num_irqs - FBNIC_NON_NAPI_VECTORS, which breaks the bound
fbnic_set_channels() enforces. In that case:

__fbnic_open()
  fbnic_alloc_napi_vectors()
    fbnic_alloc_napi_vector()
      fbnic_napi_request_irq()
        fbnic_request_irq()
          pci_irq_vector()   <- -EINVAL for an unallocated MSI-X index

__fbnic_open() then fails, and __fbnic_pm_resume() unwinds through
err_free_mbx. netif_device_attach() is never called, so the NIC stays
unusable until the driver is reloaded.

The AER path also goes through __fbnic_pm_resume(). There,
fbnic_err_slot_reset() now returns PCI_ERS_RESULT_DISCONNECT where it
used to return PCI_ERS_RESULT_RECOVERED.

The commit message says:

    If fewer IRQs return, reopening still fails. Handle that separately.

Is that accurate for the code before this patch? The removed
fbnic_reset_queues() call seems to have handled exactly this case, so
this failure looks like it comes from this patch. The follow-up "eth:
fbnic: Publish real queue counts" does not touch the resume path, so the
problem is still present at the end of the series.

>  	if (netif_running(netdev)) {
>  		err = __fbnic_open(fbn);
>  		/* On failure the vectors are freed, so drop the count */

[Severity: High]
With fbnic_reset_queues() gone from resume, what restores num_napi after
this failure path?

Right below this comment, the error path still does:

		if (err)
			fbn->num_napi = 0;

Before this patch, the fbnic_reset_queues() call on the next resume
rebuilt num_napi from num_tx_queues/num_rx_queues. fbnic_reset_queues()
is now static and only called from fbnic_netdev_alloc(). So num_napi
stays 0 while the queue counts stay non-zero and netif_running() stays
set. ethtool can't repair it either, because the device is detached.

On the next suspend, the new guard in fbnic_stop() returns early:

	if (!fbn->napi[0])
		return 0;

On the next resume, num_napi == 0 does not match num_tx + num_rx, so
fbnic_alloc_napi_vectors() skips the 1:1 branch and reaches:

	while (num_rx | num_tx) {
		int tqpv = DIV_ROUND_UP(num_tx, num_napi - txq_idx);

Here num_napi == 0 and txq_idx == 0. Can this divide by zero while
rtnl_lock and the netdev instance lock are held?

There is also a second path. After the failed resume, run ip link set
down: fbnic_stop() takes the early return. A later suspend/resume then
succeeds and re-attaches the device. Then ip link set up calls
fbnic_open()->__fbnic_open() with num_napi still 0.

The first failure doesn't need fewer MSI-X vectors (see above). It can
also come from -ENOMEM in fbnic_alloc_resources(), a FW ownership message
failure, a heartbeat init failure, or a fbnic_mac_request_irq() failure.

This also seems to contradict the new comment in fbnic_stop(), which says
suspend "keeps num_napi for resume". fbnic_get_channels() would also
derive its combined/standalone split from num_napi == 0, not from what
the user configured.

[Severity: Medium]
This isn't a bug introduced by this patch, but on the same resume path,
__fbnic_pm_attach() calls fbnic_up() without rtnl or the netdev instance
lock:

	rtnl_lock();
	fbnic_reset_hw_stats(fbd);
	rtnl_unlock();
	...
	if (netif_running(netdev))
		fbnic_up(fbn);

fbnic_up()->fbnic_napi_enable() walks fbn->napi[0..num_napi) and calls
napi_enable_locked(). Everywhere else (ndo_open, set_channels) this runs
under rtnl + netdev_lock.

During AER recovery the two halves are separate callbacks.
fbnic_err_slot_reset()->__fbnic_pm_resume() allocates the NAPI vectors
under rtnl + netdev_lock and then drops both locks.
fbnic_err_resume()->__fbnic_pm_attach() runs later. Userspace is not
frozen in between.

Could an ip link set down in that window reach
fbnic_stop()->fbnic_down()->fbnic_napi_disable() on NAPIs that were never
enabled? NAPI_STATE_SCHED is still set from netif_napi_add(), so
napi_disable_locked() would keep looping in its usleep_range() wait with
rtnl held.

And if the close overlaps fbnic_up() instead, can fbnic_free_napi_vectors()
free fbn->napi[i] while fbnic_up() is still using it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002125617.409447-1-bjorn%40kernel.org
