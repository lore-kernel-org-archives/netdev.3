Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322303;
	b=ll4wAihhAlaaFS34c/n9d89m0dZf2Hqrecn8nRj3ZlcTa+QO7JoTDkEzSOpO+AjKQEZE
	 tEVYxT3KCy0+yEYFQghJmMXFmKE1OYH/RErHcENrTZuQ3yvTOIe7lsofndfkvhz/Lznd+
	 GvRcyJ9La9rqQWpqDnPoldWoLxEi73LO1CH0+MUrqU/z9F3zNdIRaDqtie5JB4Nn65W7Z
	 H97IwbvsITCX7l3o3gyntVr/jVPc+L2Rf050XNqmApsOiY0TJhZFQeUZ9p1XTsnPxTJCx
	 itOMn4h2y7NT/bKuSitJc09Cro9UbtjZvTefKDrD1yVm7lGpLb9atQDTfF0GcHHvDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322303;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OpdV358fBauhC4N66nuf/mF1FEDPfD3H4N/uSWpykpA=;
	b=rTGFME/pO/YrEl/sLeI5hrWowKkylHb7Ebql2Qq+sg9yXeBph0cRwTzoC9HCFBAbmj5B
	 +IK/gZD140yGQ8hciEDskRIi8hi4QSQ2Na4BEBCdyIbPEcrgG9GN9IIuPxZMjdlgCTiFS
	 HfZ2s7YFlWuPWLnDATq44Xm9XMhX3YXOLKjqZXJUDkJqNVBhpmLhqFgqPzM/6/C2al3Gv
	 RYu9jdN8HLBPbS5jiSq0JdO8MmR7ds3fMerxWaP9aGuH8G8G+89/YD3IcC3pS5kuQ2CbR
	 Saa95XuJQTUKqFCP7tjwkDzk51WdexaSdrKVbE8hrvJPd6sJIWpcAH6WsCoONthctxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaB79f6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD38606A320;
	Tue, 10 Nov 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YaB79f6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD731F0089F;
	Tue, 10 Nov 2026 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322302;
	bh=OpdV358fBauhC4N66nuf/mF1FEDPfD3H4N/uSWpykpA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YaB79f6uFO+wkNLTJcnAFK3klLmIISaWSdLKm2Ms8cyhc0n7qqP8TqXTruuvf52QH
	 xneIKE3frAoyFKX9HbMNXW1U7I6zkrzih+AJ24uOwxIQP1wfXMxvCwD4Bc2paG5Qel
	 E4A2DxCbjFV2RH6KnNr3CQ31dyYmBcKS1HrQ7IDl7DQmiy/oc+uYksTUskjF2AWfuQ
	 P00R0y01RIB6egav6PZnvn+BCK6KMtVi5o+B7u6ySTJlR3ksa6JZ6xzOakNciI0IJD
	 /XbBbpEHJtRjnsELyEFk4PGkFb56pYsZPx/g0OvPrFQnhh+hjx36c4hC02dGSDUHwF
	 84E+gsrsw5oxg==
Subject: Re: [PATCH v33 net-next 1/8] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 14:51:41 +0000
Message-ID: <179432230184.994134.13173624078262833737@kernel.org>
In-Reply-To: <20261106045631.2224-2-illusion.wang@nebula-matrix.com>
References: <20261106045631.2224-2-illusion.wang@nebula-matrix.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net/nebula-matrix: device_trylock() loop in
  nbl_probe_chip_deps()
- [Medium] Channel lifetime against teardown uses a hand-rolled reader
  count instead of a real lock or refcount primitive.
- [Medium] nbl_chan_clean_queue() treats NBL_CHAN_RX_DESC_USED alone as
  proof that the device delivered a message.
- [Low] The kernel-doc on nbl_hw_ops::get_host_pf_mask (nbl_def_hw.h)
  contradicts the code this patch adds.
- [Low] nbl_common_create_wq() formats the name with snprintf(wq_name,
  ..., "nbl_wq_%s", pci_name(common->pdev)) and then calls…

--

net/nebula-matrix: add channel layer

This commit adds a mailbox-based channel layer that carries control
messages between PF0 and the other PFs. It also adds hw_ops for the
mailbox queue registers, and nbl_probe_chip_deps() to order sibling PF
probes behind function 0 using a device link.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..5b528cc6efc45
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c

[ ... ]

> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{

[ ... ]

> +	while (wait_event_timeout(chan_info->inflight_wait,
> +				  atomic_read(&chan_info->inflight_tx_cnt) == 0,
> +				  msecs_to_jiffies(5000)) == 0)
> +		dev_warn(chan_mgt->common->dev,
> +			 "teardown: still waiting for %d inflight sender(s)\n",
> +			 atomic_read(&chan_info->inflight_tx_cnt));
> +
> +	/*
> +	 * Join the last exiting sender through state_lock.  A sender drops

[ ... ]

> +	 * That trailing unlock is why this is one acquire/release pair and
> +	 * not a handshake that ends the sender: mutex_unlock() may still be
> +	 * touching the mutex structure after it has released it, so this does
> +	 * not prove the sender has returned from it (see
> +	 * Documentation/locking/mutex-design.rst).  It is safe only because
> +	 * chan_info - mutexes included - is devm-allocated and released at
> +	 * detach, long after this teardown, and because nothing frees it
> +	 * here.  Freeing chan_info or calling mutex_destroy() at this point
> +	 * would need a sender-exit completion the channel does not have.
> +	 *
> +	 * shutdn blocks new senders, so one acquire/release pair is
> +	 * sufficient.
> +	 */
> +	mutex_lock(&chan_info->state_lock);
> +	mutex_unlock(&chan_info->state_lock);

[Severity: Medium]
Should this drain use a real lock or refcount primitive instead of a
hand-rolled reader count?

nbl_chan_send_msg() checks shutdn and then calls
atomic_inc(&chan_info->inflight_tx_cnt) on entry. On exit it calls
atomic_dec_and_test() and wake_up() in out_clean_inflight. Teardown polls
that counter in a loop with no upper bound, then uses an empty
lock/unlock of state_lock as the join.

Lockdep cannot see the counter. As the comment above says, the join does
not prove the last sender has left mutex_unlock(). If teardown ever freed
chan_info or called mutex_destroy() here, that would become a
use-after-free.

An rwsem held for read across nbl_chan_send_msg() and taken for write
here would give the same semantics with lockdep coverage and a real exit
handshake. So would a refcount plus a completion. Would either of those
work here?

[ ... ]

> +static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
> +				 struct nbl_chan_info *chan_info)
> +{

[ ... ]

> +	while (le16_to_cpu(READ_ONCE(rx_desc->flags)) &
> +	       BIT(NBL_CHAN_RX_DESC_USED)) {
> +		flags = le16_to_cpu(READ_ONCE(rx_desc->flags));
> +
> +		if (READ_ONCE(chan_info->shutdn))
> +			break;
> +		if (!(flags & BIT(NBL_CHAN_RX_DESC_WRITE)))
> +			dev_dbg(dev,
> +				"mailbox rx flag 0x%x missing NBL_CHAN_RX_DESC_WRITE\n",
> +				flags);
> +
> +		/* Make sure hardware written descriptor visible to CPU */
> +		dma_rmb();
> +		nbl_chan_recv_msg(chan_mgt, rx_buf->va);

[Severity: Medium]
What happens if the device completes a descriptor with
NBL_CHAN_RX_DESC_USED set but NBL_CHAN_RX_DESC_WRITE clear?

This path only logs at dev_dbg and still passes rx_buf->va to
nbl_chan_recv_msg(). The RX buffers are fixed slots in one coherent
block, and nbl_chan_advance_rx_ring() does not clear a slot when it
recycles it.

The driver would then parse the message left in the slot from the
previous ring lap: the old msg_type, srcid and msgid, with the payload
taken from the old data_len/buf_len. That message would go to its
handler a second time. Would it be safer to recycle such a descriptor
without dispatching it?

Also, nbl_chan_recv_msg() takes the message length only from the header
inside the buffer. It never compares it with the length the device
writes back into the RX descriptor. NBL_CHAN_BUF_LEN bounds both lengths,
so there is no out-of-bounds access, but a short DMA would go unnoticed.

The tree does not document whether the hardware can post USED without
WRITE.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
> new file mode 100644
> index 0000000000000..181da46b446b3
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c

[ ... ]

> +int nbl_common_create_wq(struct nbl_common_info *common)
> +{
> +	char wq_name[32];
> +
> +	snprintf(wq_name, sizeof(wq_name), "nbl_wq_%s", pci_name(common->pdev));
> +	common->wq = alloc_workqueue(wq_name, WQ_UNBOUND, 0);

[Severity: Low]
alloc_workqueue_noprof() is declared __printf(1, 4), so wq_name is used
as a format string here with no arguments. pci_name() never contains '%'
today, so this works.

Could the format be passed directly instead?

	common->wq = alloc_workqueue("nbl_wq_%s", WQ_UNBOUND, 0,
				     pci_name(common->pdev));

That also removes the wq_name[] stack buffer and the snprintf()
truncation step.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> index ecbf440e43666..6cb843716cbba 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

[ ... ]

> +	 * This op only returns the raw register value and does not validate
> +	 * it.  Neither consumer exists yet at the commit that introduces it:
> +	 * the resource layer, which validates the value, and the channel
> +	 * layer, which programs the mailbox QINFO table from it, both arrive
> +	 * later in this series, and validation runs before the channel layer
> +	 * reads the mask.
> +	 */
> +	void (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt, u32 *pf_mask);

[Severity: Low]
This isn't a bug, but is this kernel-doc accurate? This same commit adds
the channel layer. nbl_chan_cfg_qinfo_map_table() already calls
hw_ops->get_host_pf_mask() and calls cfg_mailbox_qinfo() for every clear
bit. At this commit nothing validates the mask.

The comment in nbl_chan_cfg_qinfo_map_table() also says the validator and
every caller "arrive in later patches of this series". Once the series is
applied, nbl_res_init_pf_num() and nbl_dev_setup_chan_qinfo() both exist,
so both comments will be out of date in the merged tree.

Could they describe the final code instead of the order of the series?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -67,6 +84,164 @@ static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
>  		param->caps.has_ctrl = 1;
>  }
>  
> +/*
> + * Establish chip-wide dependencies for this PF:
> + *  - for every non-management PF, add a consumer->management PF device
> + *    link. The driver core then guarantees (sysfs unbind, driver
> + *    unregister, hot-unplug alike) that this consumer is released
> + *    BEFORE the func 0 supplier, which is the only teardown order in
> + *    which the chip-global firmware deinit is safe.
> + *
> + * The management PF is addressed by the deterministic identity
> + * (domain, bus, slot, func 0) instead of any name-based scan: hardware
> + * guarantees PFs are contiguous from func 0 in the same slot.
> + *
> + * The func 0 device must already be bound to this driver.  While func 0
> + * is still probing, its chip-global init (mailbox QINFO map programming,
> + * datapath setup) can race a sibling's mailbox setup, and a link created
> + * while the supplier has no driver starts DORMANT and is force-promoted
> + * (with a WARN backtrace) by device_links_driver_bound() when this probe
> + * ends, so it never delivers the unbind-order guarantee.
> + *
> + * The link is a persistent managed link with DL_FLAG_AUTOPROBE_CONSUMER:
> + * the core force-unbinds this consumer when func 0 unbinds (keeping the
> + * teardown order) and re-queues it for probe when func 0 binds again, so
> + * the sibling PFs and their ports come back without a manual rebind.
> + * AUTOREMOVE_CONSUMER would delete the link on unbind and cannot be
> + * combined with AUTOPROBE_CONSUMER (device_link_add() returns NULL for
> + * that pair).  The link is therefore not auto-purged on a failed probe:
> + * it lives with the two devices and is dropped when either is removed.
> + * The pointer device_link_add() returns is never dereferenced.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int nbl_probe_chip_deps(struct pci_dev *pdev, bool has_ctrl)
> +{
> +	struct pci_dev *mgt;
> +	int retries;
> +
> +	if (has_ctrl)
> +		return 0;
> +
> +	mgt = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +					  pdev->bus->number,
> +					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
> +	if (!mgt) {
> +		dev_err(&pdev->dev,
> +			"management PF (func 0) not found on this chip\n");
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * That identity is meaningless for a VF: under ARI a VF's devfn
> +	 * decodes to function 0 of a slot, so the lookup can resolve to the
> +	 * VF itself.  A VF is never the management PF, so stop here instead
> +	 * of taking our own device lock below.
> +	 */
> +	if (mgt == pdev) {
> +		dev_err(&pdev->dev,
> +			"management PF lookup matched this device\n");
> +		pci_dev_put(mgt);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * func 0's device lock is taken with a trylock.  This probe already
> +	 * runs under device_lock(funcN), so a blocking device_lock(func0)
> +	 * would establish the N -> 0 order, while __pci_bus_lock() (AER
> +	 * recovery, slot reset) walks the bus in devfn order, i.e. 0 -> N,
> +	 * and dev->mutex is lockdep_set_novalidate_class(), so lockdep
> +	 * cannot report that inversion.  A trylock never blocks, so it
> +	 * cannot take part in a deadlock cycle.
> +	 *
> +	 * Holding the lock is what makes the check and the link creation
> +	 * below atomic with respect to func 0: it both gains its driver
> +	 * (driver_bound() -> device_links_driver_bound()) and loses it
> +	 * (__device_release_driver() -> device_links_driver_cleanup())
> +	 * under device_lock(func0), so func 0 can change neither driver nor
> +	 * links.status while we hold it.
> +	 *
> +	 * One failed trylock is nevertheless not enough to defer on.  Func 0
> +	 * binds with device_lock(func0) held, and driver_bound() calls
> +	 * driver_deferred_probe_trigger() before it releases that lock, so
> +	 * the deferred probe work it queues can re-probe this PF while func
> +	 * 0's lock is still taken.  driver_probe_device() only re-arms that
> +	 * work when deferred_trigger_count changes *during* the probe, which
> +	 * it does not here: func 0's increment happened before this probe
> +	 * read the count.  A bare -EPROBE_DEFER would therefore leave this
> +	 * PF on deferred_probe_pending_list with nothing scheduled to run
> +	 * it again.  Retrying closes that window - driver_bound() has only a
> +	 * bus_notify() and a kobject_uevent() left before it drops the lock.
> +	 *
> +	 * The retry budget is what keeps this safe.  device_lock(funcN) is
> +	 * held for the whole loop, so waiting indefinitely would deadlock
> +	 * against __pci_bus_lock(); giving up and deferring releases it and
> +	 * lets the other side make progress.  A holder that is not part of a
> +	 * bind - __pci_bus_lock() during AER recovery or a bus/slot reset,
> +	 * pci_reset_function() through sysfs, an sriov_numvfs write - can
> +	 * outlast the budget, and no bind event follows those, so this PF
> +	 * then stays deferred until some later deferred-probe trigger from
> +	 * anywhere in the system.  There is no way to force one from here.
> +	 */
> +	for (retries = 0; !device_trylock(&mgt->dev); retries++) {
> +		if (retries == NBL_MGT_LOCK_MAX_RETRIES) {
> +			dev_dbg(&pdev->dev,
> +				"management PF device lock busy after %u retries, deferring probe\n",
> +				retries);
> +			pci_dev_put(mgt);
> +			return -EPROBE_DEFER;
> +		}
> +		usleep_range(NBL_MGT_LOCK_RETRY_MIN_US,
> +			     NBL_MGT_LOCK_RETRY_MAX_US);
> +	}
> +
> +	/*
> +	 * The management PF must be bound to *this* driver, with its probe
> +	 * completed.  links.status == DL_DEV_DRIVER_BOUND alone only says
> +	 * "bound to some driver", so func 0 on vfio-pci or pci-stub
> +	 * (driver_override) would pass it and this PF would run with func
> +	 * 0's chip-global init never performed.  pdev->dev.driver is our
> +	 * own driver, set by the core before ->probe() is called.
> +	 *
> +	 * Deferring is what recovers from this: a successful bind
> +	 * re-triggers deferred probing for every pending device
> +	 * (driver_bound() -> driver_deferred_probe_trigger()), so this PF is
> +	 * retried once func 0 is bound to this driver.  That covers a func 0
> +	 * that is not bound yet.  It does not cover a func 0 that is bound
> +	 * while something else holds its device lock, which is what the
> +	 * retry loop above is for and what its budget cannot fully rule out.
> +	 */
> +	if (mgt->dev.driver != pdev->dev.driver ||
> +	    mgt->dev.links.status != DL_DEV_DRIVER_BOUND) {
> +		device_unlock(&mgt->dev);
> +		pci_dev_put(mgt);
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/*
> +	 * Create the link while func 0's lock is still held, so that func 0
> +	 * cannot change state in between.  With the supplier bound and this
> +	 * consumer PROBING, device_link_init_status() starts the link in
> +	 * DL_STATE_CONSUMER_PROBE: that is the state
> +	 * device_links_driver_bound() expects when this probe finishes, and
> +	 * it is what device_links_busy() reports to func 0's own unbind, so
> +	 * func 0 cannot be released underneath this PF.
> +	 */
> +	if (!device_link_add(&pdev->dev, &mgt->dev,
> +			     DL_FLAG_AUTOPROBE_CONSUMER)) {
> +		device_unlock(&mgt->dev);
> +		dev_err(&pdev->dev,
> +			"failed to create device link to management PF\n");
> +		pci_dev_put(mgt);
> +		return -ENOMEM;
> +	}
> +
> +	device_unlock(&mgt->dev);
> +	pci_dev_put(mgt);
> +
> +	return 0;
> +}
> +
>  static int nbl_probe(struct pci_dev *pdev,
>  		     const struct pci_device_id *id)
>  {

[Severity: High]
Is a sleeping trylock loop on another device's mutex the right way to
order these probes?

nbl_probe_chip_deps() runs under device_lock(funcN). It polls
device_trylock(&mgt->dev) up to NBL_MGT_LOCK_MAX_RETRIES times with
usleep_range() in between, only to avoid the funcN -> func0 order
against __pci_bus_lock(). A trylock retry loop that sidesteps a lock
ordering problem usually means the locking design needs to change.
Here it also does not fully close the window.

When the budget runs out, the probe returns -EPROBE_DEFER. Nothing
guarantees a later driver_deferred_probe_trigger() after that. Func0's
dev->mutex can be held for more than roughly 50-100 ms by something
that is not a bind:

  - __pci_bus_lock() during AER recovery or a slot reset
  - a sysfs reset of func0
  - an sriov_numvfs write

In that case the sibling PF is left on deferred_probe_pending_list with
nothing scheduled to retry it. It stays unbound until some unrelated
driver binds elsewhere in the system, and the only trace is a
dev_dbg(). The commit message describes this case, but a PF that
silently never comes back after a reset is still a user-visible
failure.

The readiness check under that lock also reads mgt->dev.links.status.
That is driver core internal state, not something a driver is expected
to inspect.

Could the dependency be expressed without taking func0's lock from a
sibling's probe at all? For example:

  - func0 could set up the ordering from its own probe, once its
    chip-global init has finished, so the driver core's supplier
    handling does the deferral and re-probe;
  - or the siblings could learn over the mailbox that func0 is ready.

Whichever approach fits, the sibling should not rely on a
deferred-probe retrigger that may never come.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106045631.2224-1-illusion.wang%40nebula-matrix.com
