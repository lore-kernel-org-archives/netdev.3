Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646525;
	b=jzAAnB3xG7IIOUqwe4kkG3ZIYfvn/29UbaMYEsUsBhGFQpmQDF7sDak0vHGyEZJZEMva
	 o+6J6I4gqnARqmS62nKlyA0BBifYRzlCSGpzKiKtdNfbzteRO9dghtfit8CgoPXgUIUri
	 NANL19d2ETeO6gOHmcA+u0soBD6POHxst4Rg7OoyaZbJQYokLPS5x1FHwKDwuLonhNoii
	 YooMA+XQeo1WoIJb3Zg2L6kyjqtQTOZYlh3iJW3hd+KrJ1keByuUqp/Muig400J4iNMku
	 AwKcz2MMrCj2sCgo9J9AN5ydOHOkQhZU9eJgWI1WHPxMwdGANRW/x3HjNE4lgXs/bWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646525;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=53G2lhci2sOFi5T67Z9EF1k5wiE9HGXpn0UaUBa2ATE=;
	b=d/EAQ4q6gVUi/7zXynK7pV8rAb0BMENI4gmLA7NOjubM9UUkePP1sU/5liQ+RJQbu8uD
	 1zz/H4eyfttxZsAi4cOUOxqjb44N/asI6D8ipV+CTse6MV0dYHE8RciFl/8CagZHQnlXW
	 b5Ry4zK56WbCSXQbYrXpc2j9rnemjRTaqEXt/7ioqf9Za9g4jNOzFB7wJskrDQw5OGcz3
	 yuLOhyKXBSQMMGJTvp9QSkZUr9ye+SL6r86AlCWd9WPQOjHC+DL+dCyAWaQIbZIj4RWo+
	 ZBILXGovZeSG7zpyLd2xd+OsnkER0vCpyDCmDnu3kszW0Uh9/h4JjStFkFZ3Le29CFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JLDm1/hq";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E4606A337
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JLDm1/hq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69AA1F00A16;
	Mon,  2 Nov 2026 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793646524;
	bh=53G2lhci2sOFi5T67Z9EF1k5wiE9HGXpn0UaUBa2ATE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JLDm1/hqBHkO95dQsv8ssKhVo9Bt2o7S5Zehi5zFNv1zlfqAcaCcYbyj9dZNM2l/U
	 zrpF6AUvcO07pq5wSIlqYc7rCl3bQfnkEMarbyagJeY0cE2cSnwJ+FerdM7muGxAtX
	 vqXCBOampnf16wJFAYFbmPUAqDxObEdZCbL051dQgUZ541k8c2CMBj6d33hLu1YCX9
	 vVlP0rH0VHkmcHCE85qpYEafrCKBRRV0yJ7iRup8WAk3hlOA3GK665HxyWt+OVstR8
	 tw5m/MhAZ0vo0MzG2nv6vUt7+jrOjrb42R8sbQuD/M8G+1e63hYo2lQcamWdbv+ZHt
	 J0TAWf+PQ8Ulw==
Subject:
 Re: [PATCH net v4 1/2] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: netdev@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Date: Mon, 02 Nov 2026 19:08:43 +0000
Message-ID: <179364652343.3131.12378421260627827008@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261101-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v4-1-a7e209210453=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261101-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v4-1-a7e209210453=40cisco=2Ecom=3E?=
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When probe fails, enic_probe() keeps a quarantined admin graph
  permanently without ever re-checking the admin queues.
- [Medium] The new admin disable helpers accept only RUNNING == 0 as
  proof that the queue stopped: `read_poll_timeout(ioread32, running,…
- [Low] The 'Refusing to reopen poisoned admin channel' (-EIO) branch in
  enic_admin_channel_open() can never run.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is severe
  and sits on a path the patch edits.

--

enic: retain admin-channel DMA until queues stop

This commit tracks the admin channel as DOWN, LIVE or QUARANTINED. It
keeps the admin WQ/RQ/CQ allocations when the admin queues cannot be shown
to have stopped (RUNNING == 0) after disable. Reset workers close the
netdev instead of reopening a quarantined channel. Probe failure and remove
keep the netdev, vnic_dev, admin DMA and BAR reservation until reboot when
the queues still cannot be shown to have stopped.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..4325c6d9c30e3 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -530,11 +531,22 @@ static void enic_admin_msg_drain(struct enic *enic)
>  
>  int enic_admin_channel_open(struct enic *enic)
>  {
> +	int close_err;
>  	int err;
>  
>  	if (!enic->has_admin_channel)
>  		return -ENODEV;
> -
> +	if (READ_ONCE(enic->admin_chan_state) != ENIC_ADMIN_CHAN_DOWN) {
> +		netdev_err(enic->netdev,
> +			   "Refusing to open non-down admin channel (%u)\n",
> +			   READ_ONCE(enic->admin_chan_state));
> +		return -EBUSY;
> +	}
> +	if (READ_ONCE(enic->mbox_tx_poisoned)) {
> +		netdev_err(enic->netdev,
> +			   "Refusing to reopen poisoned admin channel\n");
> +		return -EIO;
> +	}

[Severity: Low]
Can this mbox_tx_poisoned check ever fire?

mbox_tx_poisoned appears to be set in only two places. One is
enic_mbox_send_msg_id() on a send timeout, which needs a LIVE channel. The
other is enic_admin_channel_close() when it moves to QUARANTINED.

Both transitions back to DOWN clear the flag under mbox_lock. These are the
tail of enic_admin_channel_close() and
enic_admin_channel_recheck_on_remove():

	enic_admin_channel_release(enic);
	WRITE_ONCE(enic->mbox_tx_poisoned, false);
	mutex_unlock(&enic->mbox_lock);

Close takes mbox_lock before it decides, so an in-flight sender's timeout
is always resolved first. That means mbox_tx_poisoned should already be
false whenever the admin_chan_state check just above passes.

The field comment in enic.h ("A send timed out or channel shutdown left
queue ownership unresolved.") and the commit message present this flag as
a separate guard. Is there a path that leaves the state DOWN with the flag
still set? If not, can the flag and this -EIO branch be dropped?

[ ... ]

> -void enic_admin_channel_close(struct enic *enic)
> +static int enic_admin_wq_disable(struct enic *enic)
>  {

[ ... ]

> +	struct vnic_wq *wq = &enic->admin_wq;
> +	u32 running;
>  
> -	netdev_dbg(enic->netdev, "admin channel close\n");
> +	iowrite32(0, &wq->ctrl->enable);
> +	return read_poll_timeout(ioread32, running, !running, 10, 500000,
> +				 false, &wq->ctrl->running);
> +}

[Severity: Medium]
What happens here if the function has been surprise removed, has lost its
link, or is DPC-contained? In those cases ioread32() of wq->ctrl->running
returns 0xFFFFFFFF, and this poll treats that as still running. The poll in
enic_admin_rq_disable() behaves the same way.

On remove of such a V2 VF the sequence looks like this:

enic_remove()
  enic_mbox_vf_unregister()               /* times out */
  enic_admin_channel_close()
    enic_admin_wq_disable()               /* 2 x 500 ms, -ETIMEDOUT */
    enic_admin_rq_disable()               /* 2 x 500 ms, -ETIMEDOUT */
    admin_chan_state = QUARANTINED
  enic_admin_channel_recheck_on_remove()  /* fails again */
  "Control DMA unresolved; retaining resources until reboot"

This leaks the unregistered netdev, the vnic_dev, the BAR mappings, the
admin DMA rings and buffers, the region reservation and a pci_dev
reference. Before this patch the timeout only produced a warning and the
graph was freed.

A function that is gone cannot master the bus. The driver already treats
all-ones as "device gone" elsewhere, for example in _vnic_dev_cmd2():

	if (fetch_index == 0xFFFFFFFF)
		return -ENODEV;

Should these helpers check for an all-ones read, or consult
pci_channel_offline() or pci_dev_is_disconnected(), before deciding that
queue ownership is unresolved?

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 6b5824f45a14c..04e4248d48725 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -2287,7 +2311,8 @@ static void enic_reset(struct work_struct *work)
>  	enic_dev_set_ig_vlan_rewrite_mode(enic);
>  	enic_ext_cq(enic);
>  
> -	enic_open(enic->netdev);
> +	if (enic_open(enic->netdev))
> +		goto reset_out;

[Severity: High]
This isn't a bug introduced by this patch, but this path is being changed
here. What state is the netdev left in when enic_open() fails?

enic_stop() has already disabled NAPI, freed the IRQs, destroyed the page
pools and unset the notify buffer. enic_open() can fail in
enic_request_intr(), enic_dev_notify_set(), page_pool_create(), the RQ
fill or enic_dev_enable(). Its error unwind leaves NAPI disabled and those
resources freed.

The goto reset_out only skips the admin reopen. __LINK_STATE_START stays
set, so the device still looks running.

The next ndo_stop then runs enic_stop() a second time. That can come from
a user ifdown, dev_close(), or unregister_netdev() in enic_remove():

enic_stop()
    for (i = 0; i < enic->rq_count; i++)
        napi_disable(&enic->napi[i]);

napi_disable_locked() then waits on a context that is already disabled:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

The first disable left SCHED/NPSVC set. Can this loop forever while
holding RTNL and the netdev instance lock?

enic_tx_hang_reset() has the same exit after its enic_open() call. The
baseline ignored enic_open()'s return value and had the same double stop.
This patch handles the admin side of a failed open but leaves the datapath
state unchanged.

Should this failure path record that the datapath is down, so that a later
enic_stop() does not run against it again?

[ ... ]

> @@ -3374,6 +3422,17 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  #endif
>  err_out_vnic_unregister:
> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		/* Normal generic cleanup and CMD_CLOSE have already run. Retain
> +		 * only the inert admin/control owners and their PCI reservation.
> +		 */
> +		pci_dev_get(pdev);
> +		pci_clear_master(pdev);
> +		pci_disable_device(pdev);
> +		pci_set_drvdata(pdev, NULL);
> +		dev_err(dev, "Control DMA unresolved; retaining resources until reboot\n");
> +		return err;
> +	}
>  	vnic_dev_unregister(enic->vdev);

[Severity: Medium]
Should this path recheck the admin queues before keeping everything until
reboot, the way enic_remove() does?

enic_remove() runs the recheck after SR-IOV teardown and keeps resources
only if the RUNNING check still fails:

		if (enic_admin_channel_is_quarantined(enic))
			enic_admin_channel_recheck_on_remove(enic);

Here the quarantined case returns immediately. That skips
vnic_dev_unregister(), enic_iounmap(), pci_release_regions() and
free_netdev(). Since drvdata is NULL and the driver never binds,
enic_remove() never runs for this instance. The "final remove-time
recheck" promised by the enic.h comment on admin_chan_state therefore
never happens:

	/* QUARANTINED retains admin DMA until the final remove-time recheck. */

Two V2 VF probe failures reach this point. One is enic_admin_channel_open()
failing after LIVE, with the close in disable_queues timing out. The other
is err_out_admin_close after a failed capability check, registration,
set_mac_addr or register_netdev(), again with the close timing out.

The admin queues may stop later, for example during enic_dev_deinit() or
CMD_CLOSE in the unwind. This path would still leak the netdev, vnic_dev,
BAR mappings, admin DMA rings and buffers and a pci_dev reference. It also
keeps the BAR reservation, so a rebind fails with -EBUSY until reboot. The
remove path would have released the same state.

The commit message only describes the remove-time recheck. The next patch
in the series, "enic: require DEVCMD2 and set the V2 VF mailbox source",
widens this condition to enic_control_dma_unresolved() but still adds no
recheck.

Is the weaker policy at probe time intended?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v4-0-a7e209210453%40cisco.com
