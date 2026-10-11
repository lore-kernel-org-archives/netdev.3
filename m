Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D792DE702;
	Sun, 11 Oct 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715883; cv=none; b=FQHRC15DNrWDAYo7xOFBwFumLAzz535afd9r2omm3eltb4N6MYq3l4qGLvU9Xhuk8v+2bN7O5uDhjQcAYbcGwG9TcJtVO7NtQ4uOrmmCgAgq4Kup56IpPZDR+gPr/t32xwmGh2HKtwGfrRFDY7Em3H9G/OR+eP+wIVvlYfB0+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715883; c=relaxed/simple;
	bh=lZ6VjPPkJy84wmtn8fpBDbyV21N7QuaSGIkNmicg/0w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGFQkoCksheDcxKCh5rMmjRNZNQUXjRrmX8+EKEU2BFniGLQBiBlAlitIl7lZsFJnUbF6TmRet2uTW8uHj0pkmP254CJcMWbJ1qJHds96J2O4qOjLk2UxpAVyy/ehC9v/a4F/9fYqSD/Slot3AHs46ETcVRVrkzX9mePReI/Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSJ1bjAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSJ1bjAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DFA1F0089B;
	Sun, 11 Oct 2026 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715881;
	bh=zXv64NwPwycsX/d/meaXXiHK7YeWYTYwBy1uFBIblUo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hSJ1bjAKD+lLlYekvf+lifTADY6Mq/T7cXkaO2lf5aKStW7bamZnKzpc2gfhHgf3u
	 IqYs3O54/fcSEN8eqS0CHe1eDdWBMII9YDxdLqPYUT8q8fH9RrehR/HuAqXM+getlC
	 Mi/CvkcLI/cH5Tg/sGwwJpAymF0vAOZ54dMEB3uLp4bYYmze55/28DfKB3ZUDygb7T
	 93/1U8iFm002DdV9aY9/Fe3NE7LHuDakQTXqW2L3iBAiahXchq6z3LmrvtMLAjJcNF
	 PA/5Ykv/rL3qxxnZh+gtfd51MaRlt2eVjATr98RHyleM8Pv2N1U2vansKroiYzA42W
	 laIlxyz3XKu4g==
Subject: Re: [PATCH v31 net-next 1/8] net/nebula-matrix: add channel layer
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 10:51:20 +0000
Message-ID: <179171588047.434549.5836636324740434942@kernel.org>
In-Reply-To: <20261010095939.2230-2-illusion.wang@nebula-matrix.com>
References: <20261010095939.2230-2-illusion.wang@nebula-matrix.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Lock-order inversion (ABBA) between nbl_probe_chip_deps() and
  the PCI core's bus/slot locking.
- [Medium] nbl_probe_chip_deps() in drivers/net/ethernet/nebula-
  matrix/nbl/nbl_main.c changes how every non-function-0 PF probes, but…
- [Medium] nbl_chan_setup_queue() sets chan_info->dma_allocated = true
  before allocating, and the comment says this is so that "a retry must…
- [Medium] nbl_probe_chip_deps() can self-deadlock when the probing
  device is an SR-IOV VF whose devfn has function number 0.
- [Medium] In nbl_probe_chip_deps(), the PF0 checks and the device-link
  creation are not atomic, and the second check does not close the race.
- [Medium] nbl_hw_stop_mailbox_rxq() and nbl_hw_stop_mailbox_txq() write
  the whole 4-dword QINFO_CFG entry through nbl_hw_write_mbx_regs(), one…
- [Low] A comment in nbl_chan_send_msg() says `active` "is published last
  in setup and cleared last in teardown, so a false value here means the…
- [Low] nbl_chan_teardown_queue() waits for inflight_tx_cnt to reach 0
  and then does one mutex_lock()/mutex_unlock() of state_lock.
- [Low] (Baseline: not a defect.) In the external-buffer branch of
  nbl_chan_update_txqueue(), buf_addr and buf_len are programmed even…

--

net/nebula-matrix: add channel layer

This adds a mailbox-based channel layer that carries control messages
between PF0 and the other PFs. It has xarray handler lookup, ACK-based
sends, coherent DMA rings and a quiescing teardown. It also hooks
channel init/cleanup into probe/remove, and adds a device link from
each PF other than function 0 to function 0.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 0000000000000..ac3115a3ab55f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,1486 @@

[ ... ]

> +static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
> +				   u8 chan_type)
> +{

[ ... ]

> +	/*
> +	 * Join the last exiting sender through state_lock: it drops
> +	 * inflight_tx_cnt and wakes this drain while still holding
> +	 * state_lock, so observing the counter reach zero does not prove
> +	 * the sender has finished its mutex_unlock(). Acquiring the lock
> +	 * once here guarantees no sender still holds it - mutex_unlock()
> +	 * is the sender's last touch of chan_info - before returning lets
> +	 * devres free chan_info. shutdn blocks new senders, so one
> +	 * acquire/release pair is sufficient.
> +	 */
> +	mutex_lock(&chan_info->state_lock);
> +	mutex_unlock(&chan_info->state_lock);

[Severity: Low]
Does one lock/unlock pair give the guarantee this comment claims?

Documentation/locking/mutex-design.rst says:

  mutex_unlock() may access the mutex structure even after it has
  internally released the lock already - so it's not safe for another
  context to acquire the mutex and assume that the mutex_unlock()
  context is not using the structure anymore.

The last sender exits nbl_chan_send_msg() at out_clean_inflight like
this:

	mutex_lock(&chan_info->state_lock);
	if (atomic_dec_and_test(&chan_info->inflight_tx_cnt))
		wake_up(&chan_info->inflight_wait);
	mutex_unlock(&chan_info->state_lock);

The unlock slowpath of that sender can still be touching state_lock
after teardown has acquired the lock, released it and returned.

Today chan_info is devm-allocated and freed only at detach, so this
series cannot reach a use-after-free. Still, the claim would no longer
hold if chan_info were freed, or mutex_destroy() were called, right
after teardown.

[ ... ]

> +static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
> +{

[ ... ]

> +	if (chan_info->dma_allocated) {
> +		dev_warn(common->dev,
> +			 "channel DMA already allocated, re-setup not supported\n");
> +		return -EBUSY;
> +	}
> +
> +	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
> +				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
> +				  NBL_CHAN_BUF_LEN);
> +	/*
> +	 * Set the flag before the first allocation: if setup fails halfway,
> +	 * the buffers allocated so far already live until detach, so a retry
> +	 * must be rejected instead of allocating a second set and orphaning
> +	 * the first one.
> +	 */
> +	chan_info->dma_allocated = true;
> +	err = nbl_chan_init_queue(common, chan_info);
> +	if (err) {
> +		chan_info->dma_allocated = false;
> +		return err;
> +	}

[Severity: Medium]
Clearing dma_allocated here seems to allow the very retry that the
comment above says must be rejected. Is that intended?

nbl_chan_init_tx_queue() and nbl_chan_init_rx_queue() allocate with
dmam_alloc_coherent() and devm_kcalloc(). Anything allocated before a
failure part-way through stays allocated until detach.

A second setup_queue() call would then pass the dma_allocated check and
allocate a whole new set: about 2 MiB of coherent DMA, plus the
descriptor rings and wait[]. It would overwrite txq/rxq/wait and leave
the first set unreferenced.

A later patch in the series ("add common/ctrl dev init/remove
operation") depends on this guard. Its comment in
nbl_dev_setup_common_dev() says "chan_info->dma_allocated blocks a
re-setup".

Also, nbl_chan_teardown_queue() never clears dma_allocated, so the
channel cannot be set up again after teardown. Does that fit the "init,
configuration, start, stop and teardown" lifecycle described in the
commit message?

[ ... ]

> +	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
> +		if (param->arg)
> +			memcpy(tx_buf->va, param->arg, param->arg_len);
> +		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
> +		tx_desc->buf_len = cpu_to_le16(param->arg_len);

[Severity: Low]
This isn't a bug, but in nbl_chan_update_txqueue() buf_addr and buf_len
are programmed even when param->arg is NULL. A NULL arg with a non-zero
arg_len would send whatever is left in the slot from before. No caller
in the series passes that combination today. Would it be simpler to
reject it up front?

[ ... ]

> +	/*
> +	 * Entry points are only reached after a successful setup_queue()
> +	 * (probe path), but the channel is a dynamic object: fail cleanly
> +	 * instead of dereferencing rings/wait[] that were never allocated
> +	 * (num_txq_entries == 0).  active is published last in setup and
> +	 * cleared last in teardown, so a false value here means the channel
> +	 * was never set up; the teardown window itself is covered by the
> +	 * shutdn check below.
> +	 */
> +	if (!READ_ONCE(chan_info->active))
> +		return -ENODEV;

[Severity: Low]
Is this comment still true once teardown has completed?

nbl_chan_teardown_queue() ends with WRITE_ONCE(chan_info->active, false)
and leaves shutdn set. dma_allocated then stops setup from running
again.

A sender that arrives after teardown takes this branch and gets -ENODEV
instead of -ESHUTDOWN, even though the channel was set up.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> index cf40ddc451921..eeff6216e4aa5 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c

[ ... ]

> +static void nbl_hw_stop_mailbox_rxq(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
> +
> +	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
> +	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
> +	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
> +			      cfg_tbl.data, sizeof(cfg_tbl));

[Severity: Medium]
Is it safe to zero the ring base and size before QUEUE_RST takes effect?

nbl_hw_write_mbx_regs() writes the entry one dword at a time, data[0]
through data[3]:

	for (i = 0; i < len / 4; i++)
		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), data[i]);

data[0..2] (base low/high and QUEUE_SIZE_BWID) are therefore written as
zero while QUEUE_EN is still set. QUEUE_RST arrives only with data[3].

Teardown calls nbl_chan_stop_rx_queue() while the peer can still send.
nbl_chan_quiesce_and_reclaim_tx() stops TX while a descriptor is still
outstanding.

If the device applies each dword as it is written, could a transfer in
that window DMA to IOVA 0 or raise PTR_ERR/DIF_ERR? The same applies to
nbl_hw_stop_mailbox_txq(), and to the first {0, 0, 0, RST} write in
nbl_hw_config_mailbox_rxq() and nbl_hw_config_mailbox_txq().

If the hardware does not commit the entry on the data[3] write, would
writing only data[3] with QUEUE_RST set first avoid this?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index f2552bc732937..62484fbf1fef6 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> +static int nbl_probe_chip_deps(struct pci_dev *pdev, bool has_ctrl)
> +{
> +	struct device_link *link;
> +	struct pci_dev *mgt;
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

[Severity: Medium]
The commit message only says:

  This patch also hooks channel init/cleanup into the PF probe/remove
  paths in nbl_main.c.

nbl_probe_chip_deps() also changes how every PF with PCI_FUNC != 0
probes:

  - if function 0 is missing from the slot, probe fails with -ENODEV
  - if function 0 is unbound, or bound to vfio-pci or pci-stub, probe
    returns -EPROBE_DEFER indefinitely
  - a persistent DL_FLAG_AUTOPROBE_CONSUMER link is created, so
    unbinding function 0 force-unbinds every sibling PF

Nothing in this patch uses that ordering yet, because setup_queue and
cfg_chan_qinfo_map_table have no callers. Later patches ("add
common/ctrl dev init/remove operation", "add common dev start/stop
operation") rely on the link but only mention it in passing.

Could this go in its own patch, or at least be described and justified
in this commit message? A setup with PF0 on vfio-pci and PF1..3 on nbl
would now leave the sibling PFs deferred forever.

> +
> +	/*
> +	 * The management PF must have COMPLETED probing with this driver.
> +	 * While func 0 is still PROBING, its chip-global init (mailbox
> +	 * QINFO map programming) can race a sibling's mailbox setup, and a
> +	 * func 0 bound to another driver never ran it at all.  Defer until
> +	 * func 0 is bound to nbl; this also covers the unbound case.
> +	 */
> +	device_lock(&mgt->dev);

[Severity: Medium]
Can this self-deadlock when the probing device is an SR-IOV VF whose
devfn decodes to function 0?

nbl_get_func_param() sets has_ctrl only for a function 0 that is not a
VF:

	if ((PCI_FUNC(pdev->devfn) == 0) && !pdev->is_virtfn)
		param->caps.has_ctrl = 1;

Such a VF therefore gets has_ctrl == 0 and reaches the lookup. With ARI,
for example, a VF at devfn 0x08 decodes to slot 1, function 0, so
pci_get_domain_bus_and_slot() returns pdev itself.

device_lock(&mgt->dev) then takes the same dev->mutex that the driver
core already holds across really_probe(). The probe task would block
forever on a lock it owns. Later unbind, VF removal when SR-IOV is
disabled, and anything else that takes that device lock would then hang
too.

VFs can be created through another PF driver and bound to nbl with
driver_override. Should there be an is_virtfn or mgt == pdev check
before taking the lock?

[Severity: High]
Is there a lock ordering inversion here with the PCI core?

During funcN's probe the driver core holds device_lock(funcN), and this
code then takes device_lock(func0). That is the order N -> 0.

__pci_bus_lock() in drivers/pci/pci.c takes them in the opposite order.
It walks bus->devices in devfn order with the blocking pci_dev_lock():

	if (bridge)
		pci_dev_lock(bridge);
	list_for_each_entry(dev, &bus->devices, bus_list) {
		...
		else
			pci_dev_lock(dev);
	}

AER recovery reaches that blocking path:

aer_root_reset()
  pci_bus_error_reset()
    pci_reset_bridge(bridge, PCI_RESET_NO_RESTORE)
      pci_bus_reset(bus, PCI_RESET_DO_RESET)
        pci_bus_lock()

pci_slot_reset()->pci_slot_lock() reaches it as well.

Suppose the AER thread holds func0's lock and waits for funcN's. At the
same time funcN's probe, for example a deferred probe triggered when
func0 binds, holds funcN's lock and waits here for func0's. Wouldn't
both sides block forever?

dev->mutex uses lockdep_set_novalidate_class(), so lockdep would not
report this.

> +	if (mgt->dev.driver != &nbl_driver.driver ||
> +	    mgt->dev.links.status != DL_DEV_DRIVER_BOUND) {
> +		device_unlock(&mgt->dev);
> +		pci_dev_put(mgt);
> +		return -EPROBE_DEFER;
> +	}
> +	device_unlock(&mgt->dev);
> +
> +	link = device_link_add(&pdev->dev, &mgt->dev,
> +			       DL_FLAG_AUTOPROBE_CONSUMER);

[ ... ]

> +	device_lock(&mgt->dev);
> +	if (mgt->dev.links.status != DL_DEV_DRIVER_BOUND) {
> +		device_unlock(&mgt->dev);
> +		pci_dev_put(mgt);
> +		return -EPROBE_DEFER;
> +	}

[Severity: Medium]
Does this second check close the race described in the comment above
it?

device_lock(func0) is dropped before device_link_add(). If func0
unbinds in that gap, device_link_init_status() creates the managed link
in DL_STATE_DORMANT. If func0 then rebinds before this check,
device_links_driver_bound() on the supplier moves the link to
DL_STATE_AVAILABLE, not DL_STATE_CONSUMER_PROBE.

This check reads only mgt->dev.links.status == DL_DEV_DRIVER_BOUND, so
it accepts that state. device_links_busy() does not treat AVAILABLE as
busy, so another func0 unbind can run during the sibling's probe. When
the consumer finishes binding, device_links_driver_bound() hits:

	WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);

In a related interleaving func0 is rebound to pci-stub or vfio-pci. This
check does not re-test mgt->dev.driver against &nbl_driver.driver, so
the sibling carries on against a PF0 that never ran nbl's chip-global
setup.

Should this check also verify the bound driver, as the first check
does?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010095939.2230-1-illusion.wang%40nebula-matrix.com
