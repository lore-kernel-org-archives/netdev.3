Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C9501F3A;
	Thu,  3 Sep 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463515; cv=none; b=j9PKhLuLbXH7SiHigbWSfiaBlGIBgqInjFqS07M71Z5bkELys4/Qr+sbXHh2VTjGgrb7DRWIaGxzBJhpmbh6M57pnAek3wqwfvPsA/vzahHaHdSqU9k2asBm0XCnRlYI8iPa522LcDvPTiC6FFLo6mxDy46jyc96z+VHOYcsFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463515; c=relaxed/simple;
	bh=VBjfKS/dg5Gs9Z5Z8IjIRz8xyOsKy27bo7itWJh2Ie8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajMayQF6ClWro4fLrphjiuBr+6s21pbBqxrnFkUcKULXacIo+xjENBR0FT7sCN+G2+xdTkF7/ZEXfpHGo2AX0ovFZ+QrUG7EUU51ltcU/+Lhjk9kaWrBQBMyW8BSZspFCwYFn61oBTbEQh15v4rX7XmAlUYYL0mZ8icZ/emULK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+uir+ec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+uir+ec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B156A1F00ADB;
	Thu,  3 Sep 2026 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463492;
	bh=Gc+AES4v3ZifP4cyAa90Og7rOhF4kXKLZrZA9oCtM3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i+uir+ecwW9P4Cu+OzjwQH2IX6iszJPksl2FSpQczNZJKVKOG5bQ6DUmdbpwLD0/O
	 uYbUEK26rsPYw5FzNg/eaHMbolBqMHH1Z9n0ala5g9Z8xow5r0vXYPKOhfUsz7G73N
	 0zZj4HNzoBlkzRFRUeOVtbB4i8ZTNQWqq8YswR93lsfv6HEAuEaN2b2rcrhjFsZ/Jx
	 flnZlJgwRedCOVCiHiKyVA/5pN+62EmwJOhecuhdztuz5NLGRRiizX+oAvS9JHFBFd
	 brgng4E1mcnHMzn8L0JHOGPnPDShUcq5vCRnsAp0CP6PV8QqFaUHUR7B0MmFegpsQo
	 zqwJfVhTwp6MA==
Subject: Re: [v9,net-next,8/8] octeontx2: switch: offload host FIB updates to
 switch via AF mailbox
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:51 +0000
Message-ID: <178846349127.3394541.17394328094952255455@kernel.org>
In-Reply-To: <20260831131944.2649362-9-rkannoth@marvell.com>
References: <20260831131944.2649362-9-rkannoth@marvell.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 14 potential
issue(s) to consider:

Critical: 0 · High: 5 · Medium: 7 · Low: 2

- [High] sw_fib_add_to_list() stores `netdev_priv(dev)` as `struct
  otx2_nic *` in the queued sw_fib_list_entry and the work handler later…
- [High] rvu_sw_l3_offl_rule_push() allocates an af2swdev_notify_req in
  the AF->PF up mailbox, fills it, and then does `rc =…
- [High] The new AF-side FIB queue has no length limit: every accepted
  FIB_NOTIFY kcalloc()s an l3_entry of sizeof(*l3_entry) + cnt*80 bytes…
- [High] Global list `l3_offl_lh` mixes FIB offload entries from multiple
  RVU devices, causing misdirected offloads and cross-device corruption.
- [High] FIB notification retry logic causes out-of-order application of
  routing rules, leading to a stale hardware FIB.
- [Medium] rvu_mbox_handler_fib_notify() (af/switch/rvu_sw_l3.c) stores
  the result of rvu_sw_port_id() without checking the documented failure…
- [Medium] In sw_nb_v4_fib_event() the comment "Point-to-point routes,
  including default routes with no gateway, are not supported for switch…
- [Medium] The new offload path is best-effort and can permanently
  desynchronise the switch FIB from the host FIB:…
- [Medium] sw_nb_v4_fib_event() now iterates
  fib_info_num_path()/fib_info_nhc() and unconditionally does `fib_nh =…
- [Medium] The new L3 offload path reads rvu->rswitch.flags
  (RVU_SWITCH_FLAG_FW_READY) in rvu_mbox_handler_fib_notify() and…
- [Medium] rvu_mbox_handler_fib_notify() accepts MBOX_MSG_FIB_NOTIFY from
  any requester reaching the AF mailbox - including VFs, whose messages…
- [Medium] rvu_mbox_handler_fib_notify() re-reads req->cnt from the
  AF<->PF shared mailbox region three times: for the bound check, to…
- [Low] The comment in sw_nb_v4_fib_event() states that external nexthop
  routes (fi->nh set) are "intentionally skipped until…
- [Low] sw_fib_add_to_list() evaluates the queue bound
  `sw_fib_list_count() >= SW_FIB_LIST_MAX` outside sw_fib_llock and…

--

octeontx2: switch: offload host FIB updates to switch via AF mailbox

This queues IPv4/IPv6 FIB-derived updates from the switchdev notifier
path into a per-PF work queue, and adds an AF-side handler for
fib_notify that batches fib_entry records and forwards them to the
switch PF over the AF-to-switchdev FIB_CMD.  The AF path requires
RVU_SWITCH_FLAG_FW_READY before accepting work.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
> index 2b798d5f06446..32735ae68e1d3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c

[ ... ]

> +static struct af2swdev_notify_req __maybe_unused
> +*otx2_mbox_alloc_msg_af2swdev_notify(struct rvu *rvu, int devid)
> +{
> +	struct af2swdev_notify_req *req;
> +
> +	req = (struct af2swdev_notify_req *)
> +		otx2_mbox_alloc_msg_rsp(&rvu->afpf_wq_info.mbox_up, devid,
> +					sizeof(*req), sizeof(struct msg_rsp));
> +	if (!req)
> +		return NULL;
> +	req->hdr.sig = OTX2_MBOX_REQ_SIG;
> +	req->hdr.id = MBOX_MSG_AF2SWDEV;
> +	return req;
> +}

[ ... ]

> +static int rvu_sw_l3_offl_rule_push(struct list_head *lh)
> +{

[ ... ]

> +	rvu = l3_entry->rvu;
> +	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);

[Severity: Medium]
Is rvu->rswitch.pcifunc stable here?  rvu_mbox_handler_fib_notify() tests
RVU_SWITCH_FLAG_FW_READY, but this worker runs at least 10ms later and does
not re-check it.  Both fields are written under the file-static
rvu_sw_l2_state_lock in rvu_sw_l2.c:

rvu_sw_l2_destroy_wqs()
	spin_lock_bh(&rvu_sw_l2_state_lock);
	rvu->rswitch.flags &= ~RVU_SWITCH_FLAG_FW_READY;
	...
	rvu->rswitch.pcifunc = 0;

and the peer reader rvu_mbox_handler_fdb_notify() takes that spinlock before
reading the flag, while the new L3 code reads both fields unlocked.

If firmware goes down between the handler and the worker, does this end up
computing swdev_pf = rvu_get_pf(rvu->pdev, 0) and sending an AF2SWDEV
up-message to an unrelated PF?  rvu_sw_l2_destroy_wqs() also does not drain
l3_offl_lh or cancel l3_offl_work.

> +	mutex_lock(&rvu->mbox_lock);
> +	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
> +	if (!req) {
> +		mutex_unlock(&rvu->mbox_lock);
> +		return -ENOMEM;
> +	}
> +
> +	dst = &req->entry[0];

[ ... ]

> +	while ((l3_entry =
> +		list_first_entry_or_null(lh,
> +					 struct l3_entry, list)) != NULL) {
> +		entry = l3_entry->entry;
> +		cnt = l3_entry->cnt;
> +
> +		/* af2swdev_notify_req.entry[] holds RVU_SW_L3_ENTRY_MAX slots;
> +		 * stop before copying the next l3_entry when the mbox buffer
> +		 * would overflow. Leftovers stay on lh and are re-queued.
> +		 */
> +		if (tot_cnt + cnt > RVU_SW_L3_ENTRY_MAX)
> +			break;
> +
> +		sz = sizeof(*entry) * cnt;
> +
> +		memcpy(dst, entry, sz);
> +		for (i = 0; i < cnt; i++)
> +			dst[i].port_id = l3_entry->port_id;

[Severity: Medium]
Correction to the finding id above: the finding is gpt-5-6-sol-2-15.

Should the port id stamped into every fib_entry here be validated first?
rvu_mbox_handler_fib_notify() stores the result of rvu_sw_port_id() without
checking the sentinel:

	l3_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);

rvu_sw_port_id() in af/switch/rvu_sw.c returns RVU_SW_INVALID_PORT_ID
((u32)~0U) when !rvu->rep2pfvf_map || !rvu->rep_cnt, or when the map lookup
misses.  rvu_rep_get_rep_cnt() only populates that map for CGX-mapped PFs
and their VFs, so a route whose nexthop netdev belongs to an LBK/SDP or
otherwise non-CGX-mapped RVU function produces the sentinel.

The peer handler checks it:

af/switch/rvu_sw_l2.c:rvu_mbox_handler_fdb_notify()
	port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
	if (port_id == RVU_SW_INVALID_PORT_ID)
		return -EINVAL;

Should the L3 handler do the same rather than handing 0xFFFFFFFF to switch
firmware as an egress port?

> +		tot_cnt += cnt;
> +		dst += cnt;
> +
> +		list_del_init(&l3_entry->list);
> +		kfree(l3_entry);
> +	}

[Severity: Medium]
Can l3_entry->cnt disagree with the number of fib_entry slots actually
allocated?  rvu_mbox_handler_fib_notify() reads req->cnt from the shared
AF<->PF mailbox region three separate times:

	if (!req->cnt || req->cnt > RVU_SW_L3_ENTRY_MAX)
		return -EINVAL;

	sz = req->cnt * sizeof(struct fib_entry);

	l3_entry = kcalloc(1, sizeof(*l3_entry) + sz, GFP_KERNEL);
	...
	l3_entry->cnt = req->cnt;

The kcalloc() between the second and third fetch forces a reload, so if a
peer raises req->cnt in that window, l3_entry->cnt ends up larger than the
allocated flexible array.  The consumer above then does:

	sz = sizeof(*entry) * cnt;
	memcpy(dst, entry, sz);

guarded only by tot_cnt + cnt > RVU_SW_L3_ENTRY_MAX, which would copy past
the allocation into the outgoing message.  A stale value above 12 instead
makes the loop break every time, leaving an entry that never drains and
re-arms the delayed work every 100ms.

Would a single fetch into a local, used for the bound check, the allocation
size, the memcpy and the stored count, be preferable?

> +	if (!tot_cnt) {
> +		mutex_unlock(&rvu->mbox_lock);
> +		return -EINVAL;
> +	}
> +
> +	req->flags = OTX2_FIB_CMD;
> +	req->cnt = tot_cnt;
> +
> +	rc = otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +	if (rc)
> +		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
> +
> +	mutex_unlock(&rvu->mbox_lock);
> +	return rc ? 0 : -EFAULT;
> +}

[Severity: High]
What happens to the allocated up-message when otx2_mbox_wait_for_zero()
returns false?  The doorbell is skipped, but otx2_mbox_alloc_msg_rsp() has
already advanced mdev->msg_size and mdev->num_msgs, and those are cleared
only by otx2_mbox_msg_send_data() or otx2_mbox_reset().

sizeof(struct af2swdev_notify_req) is 1000, ALIGN'd to 1008, and the usable
up-TX window is MBOX_UP_TX_SIZE(SZ_1K) minus the 16-byte header offset, also
1008.  So one stranded message consumes the entire window and every later
AF->switch-PF up message (further FIB batches, af2swdev FDB notifies, link
events) fails to allocate until an unrelated up-response triggers
otx2_mbox_reset().

The sibling L2 path does not leave this state:

af/switch/rvu_sw_l2.c:rvu_sw_l2_offl_rule_push()
	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);

otx2_mbox_wait_for_zero() polls, sleeps ~1ms, re-reads and returns false if
the peer has not acked, which is routine under load.  Should the L3 path
send unconditionally too?

[Severity: Medium]
The entries are list_del/kfree'd inside the copy loop above, before delivery
is established, so on the -EFAULT return the batch is gone with nothing to
replay.  sw_l3_offl_work_handler() only requeues entries still on the
temporary list:

	if (rvu_sw_l3_offl_rule_push(&l3lh))
		pr_err("%s: Error to push rules\n", __func__);

Combined with rvu_mbox_handler_fib_notify() returning -EAGAIN until
RVU_SWITCH_FLAG_FW_READY (with no FIB re-walk once firmware comes up), the
permanent drop after SW_FIB_NOTIFY_RETRY_MAX in sw_fib_work_handler(), and
the discarded sw_fib_add_to_list() return values in sw_nb_v4.c/sw_nb_v6.c,
can the switch FIB silently diverge from the host FIB?  None of these
limitations are mentioned in the commit message.

[ ... ]

>  int rvu_mbox_handler_fib_notify(struct rvu *rvu,
>  				struct fib_notify_req *req,
>  				struct msg_rsp *rsp)
>  {
> +	struct l3_entry *l3_entry;
> +	int sz, rc;
> +
> +	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
> +		return -EAGAIN;
> +
> +	/* Reject notifies larger than the source fib_notify_req.entry[]. */
> +	if (!req->cnt || req->cnt > RVU_SW_L3_ENTRY_MAX)
> +		return -EINVAL;

[Severity: High]
Should l3_offl_lh, sw_l3_offl_wq and going_down be per-device state
rather than file-static?  struct rvu is allocated once per RVU PCI
function, so on a board with more than one RVU device every AF
instance queues onto this single list and shares one delayed work
item.

rvu_sw_l3_offl_rule_push() then picks its target from whichever
l3_entry happens to be at the head:

	rvu = l3_entry->rvu;
	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);

and the copy loop below batches every following l3_entry into that
device's afpf_wq_info.mbox_up without ever comparing l3_entry->rvu
against the rvu it selected.  Entries that arrived from a second RVU
device would be stamped with a port_id derived from that device's
rep2pfvf_map and programmed into the first device's switch FIB.  The
comment asserting "one octeontx2 AF driver instance, one switch PF
(switchdev), and one sw_l3_offl_wq per SoC" is doing a lot of work
here - is that guaranteed by something in the AF driver, or is it the
single-card configuration that was tested?

The same assumption bites teardown: rvu_sw_l3_shutdown() sets
going_down, NULLs sw_l3_offl_wq, destroys the workqueue and drains
l3_offl_lh, so unbinding one RVU device discards queued work belonging
to the others and leaves them with offload disabled until some later
rvu_sw_l3_clear_shutdown() and rvu_sw_l3_ensure_wq() re-create it.

rvu_sw_l2_clear_shutdown() suggests the L2 path is built on the same
file-static going_down, so this may be a deliberate subsystem-wide
assumption rather than something new here.  If multi-RVU really cannot
happen, could that be stated once (and enforced) instead of relied on
implicitly?  If it can, both the list and the workqueue look like they
belong in struct rvu, or the push loop at minimum needs to stop
batching entries whose l3_entry->rvu differs from the selected one.

[Severity: Medium]
Is any sender authorization intended here?  MBOX_MSG_FIB_NOTIFY is accepted
from any requester that reaches the AF mailbox, including VFs -
otx2_pf.c:otx2_pfvf_mbox_handler() relays them with the VF's pcifunc:

	err = otx2_forward_vf_mbox_msgs(pf, mbox, MBOX_DIR_PFAF, vf_idx,
					vf_mbox->num_msgs);

The fib_entry[] contents (the u64 cmd opcode, dst/dst_len, gw, mac and the
host/bridge/vlan/ipv6 bits) are forwarded to switch firmware verbatim; only
port_id is re-derived by the AF.  Can a VF assigned to an untrusted guest
install or delete switch FIB/host-route and neighbour-MAC bindings for other
ports?

For context, rvu_mbox_handler_fdb_notify() has the same exposure today, so
this looks like the existing trust model of this subsystem rather than
something introduced here; the closest authorization precedent is
rvu_sw_swdev2af_sender_check(), which guards the opposite (switch->AF)
direction.

> +
> +	sz = req->cnt * sizeof(struct fib_entry);
> +
> +	l3_entry = kcalloc(1, sizeof(*l3_entry) + sz, GFP_KERNEL);
> +	if (!l3_entry)
> +		return -ENOMEM;
> +
> +	l3_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
> +	l3_entry->rvu = rvu;
> +	l3_entry->cnt = req->cnt;
> +	INIT_LIST_HEAD(&l3_entry->list);
> +	memcpy(l3_entry->entry, req->entry, sz);
> +
> +	/* Host PFs on this RVU share one AF and one switch PF offload path. */
> +	mutex_lock(&l3_offl_llock);

[ ... ]

> +	list_add_tail(&l3_entry->list, &l3_offl_lh);
> +	mutex_unlock(&l3_offl_llock);
> +	rvu_sw_l3_queue_work();
> +
>  	return 0;
>  }

[Severity: High]
Is there a bound on l3_offl_lh?  Each accepted notify kcalloc()s
sizeof(*l3_entry) + cnt * 80 bytes with GFP_KERNEL and appends it
unconditionally, while rvu_sw_l3_offl_rule_push() forwards at most
RVU_SW_L3_ENTRY_MAX (12) records per push and re-arms after 10-100ms.

The sibling L2 handler caps its list:

af/switch/rvu_sw_l2.c:rvu_mbox_handler_fdb_notify()
	if (atomic_read(&l2_offl_list_cnt) >= RVU_SW_L2_LIST_MAX) {
		...
		return -ENOMEM;
	}

Since a PF or VF can emit FIB_NOTIFY directly, the PF-side SW_FIB_LIST_MAX
does not limit growth on the AF.  Can sustained route churn or a buggy VF
grow this list without limit?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
> index f4c47111d7633..318f7b68b8e4e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c

[ ... ]

> +static void sw_fib_list_entry_destroy(struct sw_fib_list_entry *lentry)
> +{
> +	struct net_device *dev = lentry->pf->netdev;
> +
> +	sw_fib_list_cnt_dec(dev);
> +	netdev_put(dev, &lentry->dev_tracker);
> +	kfree(lentry->entry);
> +	kfree(lentry);
> +}
> +
> +static int sw_fib_notify(struct otx2_nic *pf,
> +			 int cnt,
> +			 struct fib_entry *entry)
> +{
> +	struct fib_notify_req *req;
> +	int rc;
> +
> +	if (cnt > RVU_SW_L3_ENTRY_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&pf->mbox.lock);
> +	req = otx2_mbox_alloc_msg_fib_notify(&pf->mbox);

[Severity: High]
Is lentry->pf guaranteed to point at a struct otx2_nic?  sw_fib_add_to_list()
stores it from netdev_priv(dev) and this work-context code dereferences it
for mutex_lock(&pf->mbox.lock) and &pf->mbox, while
sw_fib_list_entry_destroy() uses lentry->pf->netdev as the netdev to
netdev_put() the tracked reference against.

The only vetting is sw_nb_is_valid_dev()/sw_nb_resolve_pf_dev(), which
bottom out in sw_nb_is_cavium_dev() checking just the PCI vendor:

nic/switch/sw_nb.c:sw_nb_is_cavium_dev()
	if (pdev->vendor != PCI_VENDOR_ID_CAVIUM)
		...

drivers/net/ethernet/cavium/liquidio, cavium/thunder/nicvf_main.c and
marvell/octeon_ep/octep_main.c all bind PCI_VENDOR_ID_CAVIUM devices and
register netdevs with SET_NETDEV_DEV().  If such a netdev is used as a route
nexthop or gets an address, does this take a mutex at whatever lies at
struct otx2_nic's mbox offset inside a foreign driver's private area, and
netdev_put() a tracker against the wrong netdev?

Before this patch the mis-typed pointer was only used to read pf->pcifunc
into a record that was freed immediately; this patch stores the pointer and
dereferences it later from work context.

> +	if (!req) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}

[ ... ]

> +int sw_fib_add_to_list(struct net_device *dev,
> +		       struct fib_entry *entry, int cnt)
> +{
> +	struct otx2_nic *pf = netdev_priv(dev);
> +	struct sw_fib_list_entry *lentry;
> +	struct workqueue_struct *wq;

[ ... ]

> +	if (sw_fib_list_count() >= SW_FIB_LIST_MAX) {
> +		kfree(entry);
> +		return -ENOMEM;
> +	}

[Severity: Low]
This bound is evaluated outside sw_fib_llock while the matching
sw_fib_list_cnt_inc()/list_add_tail() happen inside the lock a few lines
below, and sw_fib_list_entry_destroy() decrements outside the lock too.
Concurrent producers (the RTNL-context notifiers versus the netevent-driven
sw_nb_net_v4_neigh_update()/sw_nb_net_v6_neigh_update() on another CPU) can
all pass the check and push past the cap.

The added sw_fib_list_cnt_warn() "FIB list count overflow" branch seems to
acknowledge this.  Would testing and incrementing inside the existing
spin_lock_bh() region avoid it?

> +
> +	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
> index 31009e00121f6..7ee3a98fc50d5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c

[ ... ]

> @@ -69,6 +76,10 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
>  		entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
>  	}
>  
> +	/* Switch offload is only enabled on OcteonTX2/CN10K SoCs. pf_dev is an
> +	 * octeontx2 PF or representor netdev, so netdev_priv() is otx2_nic even
> +	 * though sw_nb_is_cavium_dev() matches the shared Cavium PCI vendor ID.
> +	 */

[Severity: High]
Is the representor half of this comment accurate?  rep.c allocates
representor netdevs with alloc_etherdev(sizeof(struct rep_dev)), so
netdev_priv() there is struct rep_dev, not struct otx2_nic.  (In practice
representors do not reach here because they only call
SET_NETDEV_DEVLINK_PORT, leaving dev.parent NULL so sw_nb_is_cavium_dev()
rejects them - but the comment states the opposite and is used to justify
the unchecked cast discussed in sw_fib_notify() above.)

[ ... ]

> @@ -186,19 +205,16 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
>  	 * are walked below; nhid and nexthop-group installs are intentionally
>  	 * skipped until fib_info_num_path()/fib_info_nhc() handling is added.
>  	 */
> -	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
> -	if (!entries)
> +	if (!nhs)
>  		return NOTIFY_DONE;

[Severity: Low]
The retained comment says nhid and nexthop-group installs are "intentionally
skipped until fib_info_num_path()/fib_info_nhc() handling is added", but this
hunk switches the function to exactly those helpers.  include/net/nexthop.h
dispatches them to nexthop_num_path(fi->nh)/nexthop_fib_nhc(fi->nh, i) when
fi->nh is set, so external nexthop routes are now walked.  Should the comment
be updated?

[ ... ]

> -	iter = entries;
> -	fib_nh = fi->fib_nh;
> -	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
> +	for (i = 0; i < nhs; i++) {
> +		nhc = fib_info_nhc(fi, i);
> +		fib_nh = container_of(nhc, struct fib_nh, nh_common);
>  		dev = fib_nh->fib_nh_dev;

[Severity: Medium]
Can nhc here belong to a struct fib6_nh?  For a route installed as:

	ip nexthop add id N via <v6addr> dev X
	ip route add <v4prefix> nhid N

fib_info_nhc() -> nexthop_fib_nhc() returns the nh_common of a struct
fib6_nh.  The existing fi->fib_nh_is_v6 guard above cannot catch it because
net/ipv4/fib_semantics.c sets that flag only inside the if (!fi->nh) branch.

The loop then reads fib_nh->nh_saddr, which exists only in struct fib_nh:

		if (fib_nh->nh_saddr)
			haddr[hcnt++] = fib_nh->nh_saddr;

and treats the first 4 bytes of nhc_gw.ipv6 as an IPv4 gateway, setting
gw_valid, programming it into the switch and passing it to:

		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);

ip_neigh_gw4() calls __neigh_create(), so does this create a real ARP
neighbour entry (with ARP probes on the wire) for a fabricated IPv4 address?

Pre-patch the loop walked fi->fib_nh/fi->fib_nhs, which is empty for nhid
routes, so this looks newly reachable.  Note nh_info is kzalloc'd and
nh_saddr sits past the end of struct fib6_nh, so the bytes read there are
zeros rather than leaked heap contents.

[ ... ]

> @@ -210,107 +226,118 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
>  		/* Point-to-point routes, including default routes with no
>  		 * gateway, are not supported for switch offload.
>  		 */
> -		if (!fib_nh->fib_nh_gw4)
> +		if (!fib_nh->fib_nh_gw4) {
> +			if (!entry->dst && !entry->dst_len) {
> +				kfree(entry);
> +				continue;
> +			}
> +			sw_fib_add_to_list(nh_pf_dev, entry, 1);
>  			continue;
> -		iter->gw_valid = 1;
> +		}

[Severity: High]
The added TODO already describes this, but should a known
kernel-versus-hardware FIB divergence be merged in this state?

sw_fib_work_handler() splices the whole of sw_fib_lh into tlist and
walks it in order.  When sw_fib_notify() fails - otx2_sync_mbox_msg()
returning an error while the AF mailbox is busy, or the AF handler
rvu_mbox_handler_fib_notify() returning -EAGAIN because
RVU_SWITCH_FLAG_FW_READY is not set yet - the failed lentry is put on
the tail of sw_fib_lh and the loop continues draining the rest of
tlist.  Every subsequent entry, including a DEL for the same prefix
that the kernel generated after the failed ADD, is now applied before
the retry.  When the ADD eventually succeeds the hardware keeps a
route the kernel has already withdrawn, and nothing later reconciles
it; after SW_FIB_NOTIFY_RETRY_MAX the entry is simply dropped, which
has the same effect in the opposite direction.

Since every producer in sw_nb_v4.c and sw_nb_v6.c funnels
single-entry records through sw_fib_add_to_list() into this one list,
the list order is the only thing carrying FIB event ordering to the
ASIC, so losing it is not a corner case under mailbox contention.

Would it work to keep the batch strictly in order on failure - put the
failed lentry back at the head of tlist, splice tlist in front of
sw_fib_lh, re-arm the delayed work and break out of the loop - so that
nothing behind the failed entry is applied early?  If there is a
reason retries must not block later entries, could that reasoning go
in the commit message together with the divergence it implies?

[Severity: Medium]
The comment directly above says gateway-less routes are not supported for
switch offload, but this now offloads them for any prefix other than
0.0.0.0/0, with gw_valid and mac_valid left at 0.  Should the comment be
updated, and should the commit message mention that directly connected IPv4
routes are now programmed into the ASIC?

The IPv6 side in sw_nb_v6_fib_event() leaves the same case as an explicit
TODO:

	/*
	 * TODO: Offload directly connected IPv6 subnets without an IPv6
	 * gateway. ...
	 */

so the two families now behave differently.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
