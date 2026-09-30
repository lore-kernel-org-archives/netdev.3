Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1D35AC09
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729910; cv=none; b=TGUdUpBijhXc9vAXaq2II7W/HIz7gD7NPyvYWZiMDbnGJTg5FituwkiVNVQcs5y/G6vTczFlfmrNqrqp0ki2p60KrJUb8HxnZ33+LSAnbJIqvjsx+geWfiOArGI2FlH73ejIuD+qlEA8LGNe4hGXTwYJzj71zJ9HVt0RSezv6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729910; c=relaxed/simple;
	bh=QrOT3KSWkiQCTl+jai5rJ1RXt+SM13Qny/R4C8v/oOI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZ9zeS4JTE/3BMYUhKLUsaGFsx3l4fVbZCLM8y/onN9EGc6+KpXcC3GaVng8WluD5LUzbzYfx0M24+e8aIvD50FjeUVRAQM69JPE+6d51r0dOwfwie9XSw74VJEMmXjZpJaOBS2QZKyrCbNwgMHIVf/G4EqUf/qkz4AC6Y5e30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD76gPOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD76gPOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42961F000FF;
	Wed, 30 Sep 2026 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729908;
	bh=6t0ZEjqpUTbQP8X8hu6DKZvduSWqFW4ni50GXWfnBjU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JD76gPOQxfRotmyLqZmlX66bd0GZn+h3QDprfJGBhh8aTnnDDLcWzJMJI0JrhslPb
	 oQZzR+UF2vr7TmF6rc0Ipae4y/kgkx62hbFP5N/bXomXVmiuDPRx3AYh1GSswtOpJy
	 pZMdoNKQlEZC21k5i5S0iTyS1C1JpDfDu072GG0tODOMM0FcpkiZLm3iFQom/KEsBT
	 TtUQOlYffHtxFlCSDyv8Q3+ikHjAto7x1QOcSbRnL2yCTzEoQ9Ro+50HT6BvMQut0+
	 L0iJlVTDf4JmKe2cbkEKjtgn9Hx6pTPlp0hHOM3q/u/PJuHx6EW4QYhJ65UgKTPHJK
	 UxOxwarWMsjMg==
Subject: Re: [PATCH net v2 2/3] iavf: send MAC change request synchronously
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jtornosm@redhat.com, przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, horms@kernel.org, sdf@fomichev.me,
 rafal.romanowski@intel.com
Date: Wed, 30 Sep 2026 00:58:27 +0000
Message-ID: <179072990744.434549.389768890692440897@kernel.org>
In-Reply-To: <20260928224454.483072-3-anthony.l.nguyen@intel.com>
References: <20260928224454.483072-3-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 11 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 4 · Low: 4 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The MAC change can still fail under netdev_lock, now with -EBUSY
  instead of -EAGAIN.
- [High] The new rollback in iavf_set_mac() frees filters that do not
  belong to this request.
- [High] The new synchronous ndo_set_mac_address path runs outside the
  states the watchdog allowed and can read freed memory.
- [Medium] The MAC change can be reported as finished before the PF has
  replied.
- [Medium] When more filters are pending than fit in one message, the new
  primary MAC is never sent during the poll.
- [Medium] iavf_poll_virtchnl_response() drives the ARQ directly for up
  to 2.5 s while holding the netdev instance lock and RTNL.
- [Medium] Rollback is incomplete when iavf_set_mac_sync() fails before
  the batch is built: -ENOMEM from the event.msg_buf kzalloc, -EBUSY…
- [Low] The commit message says iavf_mac_add_reject() is exported 'to
  enable proper rollback on local failures (timeouts, send errors)'.
- [Low] iavf_poll_virtchnl_response() does not match its kernel-doc.
- [Low] The comment in iavf_set_mac() says -EAGAIN means 'the message was
  sent and PF will eventually respond'.
- [Low] iavf_poll_virtchnl_response() clears the caller's event buffer
  with memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE) instead of…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  iavf_process_aq_command() ignores the error that…

--

iavf: send MAC change request synchronously

This commit changes iavf_set_mac() to send the ADD_ETH_ADDR virtchnl
message itself. It then polls the admin queue for the reply while holding
the netdev instance lock, so it no longer depends on the watchdog and
adminq_task. It adds a generic iavf_poll_virtchnl_response() helper, makes
iavf_add_ether_addrs() return an error code, exports iavf_mac_add_reject()
for rollback, and removes vc_waitqueue.

> To support this, change iavf_add_ether_addrs() to return an error code
> instead of void, allowing callers to detect failures. Additionally,
> export iavf_mac_add_reject() to enable proper rollback on local failures
> (timeouts, send errors) - PF rejections are already handled automatically
> by iavf_virtchnl_completion().

[Severity: Low]
Is the "timeouts" part of this accurate? On timeout,
iavf_poll_virtchnl_response() returns -EAGAIN, and iavf_set_mac()
deliberately skips the rollback in that case:

	if (ret != -EAGAIN) {
		iavf_mac_add_reject(adapter);

The filter and hw.mac.addr are left pending on timeout. Could the
changelog say send errors only?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 29b8403a066bc..2f8a80a113362 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1029,6 +1029,60 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,

[ ... ]

> +static bool iavf_mac_change_done(struct iavf_adapter *adapter,
> +				 const void *data, enum virtchnl_ops v_op)
> +{
> +	const u8 *addr = data;
> +
> +	return iavf_is_mac_set_handled(adapter->netdev, addr);
> +}

[Severity: Medium]
Can this report completion before the ADD_ETH_ADDR reply arrives?
iavf_poll_virtchnl_response() calls the predicate after every message it
processes. v_op is ignored here, so the only check is
iavf_is_mac_set_handled():

	if (!f || (!f->add && f->add_handled))
		ret = true;

Suppose the new primary address already exists as a filter whose earlier
add succeeded. iavf_add_filter() returns that entry with add_handled still
set. iavf_add_ether_addrs() then clears f->add while building the batch,
so the predicate is true as soon as the request is sent.

Any unrelated message would then end the poll with 0. Examples are a
VIRTCHNL_OP_EVENT link change, or a reply queued while adminq_task was
blocked.

In that case iavf_set_mac() sees the old netdev->dev_addr and returns
-EACCES. Later, adminq_task processes the real ADD_ETH_ADDR reply and
calls eth_hw_addr_set(), so the address changes after a reported failure.

The old wait_event path was only woken by ADD_ETH_ADDR completions. Should
the callback also require v_op == VIRTCHNL_OP_ADD_ETH_ADDR?

[ ... ]

> +static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
> +{
> +	struct iavf_arq_event_info event;
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf)
> +		return -ENOMEM;
> +
> +	ret = iavf_add_ether_addrs(adapter);
> +	if (ret)
> +		goto out;

[Severity: High]
Can the MAC change still fail under netdev_lock, now with -EBUSY instead
of -EAGAIN?

iavf_add_ether_addrs() now returns -EBUSY whenever adapter->current_op is
not VIRTCHNL_OP_UNKNOWN. Only iavf_virtchnl_completion() clears
current_op, and it normally runs from iavf_adminq_task(), which needs the
lock that is already held here:

iavf_adminq_task()
	netdev_lock(netdev);

iavf_watchdog_task() sends a command, queues adminq_task, and only then
calls netdev_unlock(). Commands it sends this way include:

- GET_STATS, sent every cycle while running (iavf_request_stats())
- DEL_ETH_ADDR for the old primary, sent right after a successful set_mac
- ADD_ETH_ADDR batches after set_rx_mode or a reset

If ndo_set_mac_address takes the lock before adminq_task runs, the reply
is not drained before this call.

Would "ip link set dev X address ..." and bond_enslave(), which aborts
when dev_set_mac_address() fails, then fail with -EBUSY? This path did
not return -EBUSY before ad7c7b2172c3, and the changelog does not mention
it.

iavf_poll_virtchnl_response() can already drain and complete ARQ messages
under netdev_lock. Could the outstanding reply be processed before the
send is attempted?

> +
> +	ret = iavf_poll_virtchnl_response(adapter, &event,
> +					  iavf_mac_change_done, addr, 2500);

[Severity: Medium]
What happens here when more filters are pending than fit in one message?

With more than about 511 pending adds, iavf_add_ether_addrs() shortens
count, sets more = true and leaves IAVF_FLAG_AQ_ADD_MAC_FILTER set. It
sends only the first batch and returns 0.

iavf_add_filter() uses list_add_tail(), so a newly created primary filter
sits at the tail and keeps f->add == true. iavf_is_mac_set_handled() then
stays false for the whole poll. The watchdog, which would send the next
batch, is blocked on netdev_lock.

Doesn't this poll for the full 2500 ms with netdev_lock and RTNL held,
and then return -EAGAIN?

Also, the first batch's ADD_ETH_ADDR completion calls
eth_hw_addr_set(netdev, adapter->hw.mac.addr) whenever dev_addr differs
from hw.mac.addr. So netdev->dev_addr ends up as the new MAC even though
the call returns -EAGAIN.

> +
> +out:
> +	kfree(event.msg_buf);
> +	return ret;
> +}

[ ... ]

> @@ -1046,25 +1100,23 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  

[ ... ]

> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret) {
> +		/* Rollback only if send failed (message never reached PF).
> +		 * Don't rollback on timeout (-EAGAIN) because the message was
> +		 * sent and PF will eventually respond. When the response arrives,
> +		 * iavf_virtchnl_completion() will handle rollback (on PF error)
> +		 * or acceptance (on PF success) automatically.
> +		 */

[Severity: Low]
Does the "PF will eventually respond" assumption hold when
IAVF_FLAG_PF_COMMS_FAILED is set? In that state iavf_send_pf_msg()
returns success without sending anything:

	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
		return 0; /* nothing to see here, move along */

This state can follow iavf_disable_vf(), which leaves the netdev
registered in __IAVF_DOWN. iavf_add_ether_addrs() then sets current_op
and returns 0.

Unlike iavf_adminq_task(), the poll loop does not check PF_COMMS_FAILED,
so it polls for 2.5 seconds. The rollback is then skipped even though no
reply will arrive.

The end result matches the pre-patch behavior, but the reasoning in this
comment does not hold for that state.

> +		if (ret != -EAGAIN) {
> +			iavf_mac_add_reject(adapter);
> +			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
> +		}

[Severity: High]
Can this rollback free filters that do not belong to this request?
iavf_mac_add_reject() walks the whole mac_filter_list:

	if (f->is_new_mac) {
		list_del(&f->list);
		kfree(f);
	}

iavf_add_filter() sets is_new_mac on every new filter. That includes
secondary unicast and multicast filters added through
iavf_set_rx_mode() -> __dev_uc_sync()/__dev_mc_sync() -> iavf_addr_sync().

After a VF reset, the GET_VF_RESOURCES/GET_OFFLOAD_VLAN_V2_CAPS
completion also sets is_new_mac = true and add = true on every filter,
the primary included.

The -EBUSY case means another command is still outstanding. It could be
an ADD_ETH_ADDR batch of those same filters. Possible outcomes:

- Filters in an in-flight batch are freed, but the PF installs them
  anyway. A later iavf_addr_unsync() finds no filter and never sends
  DEL_ETH_ADDR, so the PF filter is orphaned.
- Pending uc/mc filters that were never sent are freed. The core already
  treats them as synced, so they are never requested again.
- If this hits during the post-reset re-add, the whole list is removed,
  including the primary filter.

Before this patch, iavf_mac_add_reject() only ran when the PF rejected
the batch that was actually in flight. Could the rollback be limited to
the address that iavf_set_mac() queued?

[Severity: Medium]
Is the rollback complete when iavf_set_mac_sync() fails before the batch
is built? That covers -ENOMEM from the event.msg_buf allocation, -EBUSY,
and -ENOMEM from the veal allocation.

Take an address B that already existed as a filter. iavf_add_filter()
returned it with is_new_mac == false. iavf_replace_primary_mac() then set
B.is_primary and B.add, cleared is_primary on the old primary A, set
A.remove, and left IAVF_FLAG_AQ_ADD_MAC_FILTER pending.

iavf_mac_add_reject() skips B in both branches, because B.add is still
set and is_new_mac is clear:

	if (!f->add && !f->add_handled)
		f->add_handled = true;

	if (f->is_new_mac) {

It restores A.remove, but not A.is_primary.

The watchdog later sends B as VIRTCHNL_ETHER_ADDR_PRIMARY via
iavf_set_mac_addr_type(), while hw.mac.addr and netdev->dev_addr are back
to A.

Doesn't this leave the PF's primary MAC for the VF different from
netdev->dev_addr, with a stale is_primary flag in the list?

> +		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9db..e6b7e8f82c7c1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -594,8 +598,9 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  
>  	veal = kzalloc(len, GFP_ATOMIC);
>  	if (!veal) {
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
> -		return;
> +		return -ENOMEM;
>  	}
>  
>  	veal->vsi_id = adapter->vsi_res->vsi_id;

[Severity: High]
Can adapter->vsi_res point to freed memory here?

With the new caller, iavf_set_mac() -> iavf_set_mac_sync() ->
iavf_add_ether_addrs() runs without checking adapter->state. Before, this
function was only reached from iavf_process_aq_command() in __IAVF_DOWN,
__IAVF_DOWN_PENDING, __IAVF_TESTING or __IAVF_RUNNING.

iavf_parse_vf_resource_msg() sets vsi_res to &adapter->vf_res->vsi_res[i],
and nothing clears it. The err_alloc path in iavf_init_get_resources()
frees vf_res:

err_alloc:
	kfree(adapter->vf_res);
	adapter->vf_res = NULL;

After a PF comms failure, the __IAVF_COMM_FAILED case in
iavf_watchdog_step() does:

			iavf_change_state(adapter, __IAVF_STARTUP);
			adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
		}
		adapter->aq_required = 0;
		adapter->current_op = VIRTCHNL_OP_UNKNOWN;

Neither iavf_startup() nor iavf_send_api_ver() sets current_op. During
__IAVF_STARTUP and __IAVF_INIT_VERSION_CHECK, a MAC change therefore
passes the -EBUSY check and reads adapter->vsi_res->vsi_id from freed
memory. In __IAVF_INIT_VERSION_CHECK the message is actually sent to the
PF.

Could the poll loop also consume the VIRTCHNL_OP_VERSION reply that
iavf_verify_api_ver() is waiting for? The default case in
iavf_virtchnl_completion() would clear current_op, and the init state
machine would fall back to __IAVF_INIT_FAILED.

> @@ -615,8 +620,15 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  
>  	spin_unlock_bh(&adapter->mac_vlan_list_lock);
>  
> -	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
> +	ret = iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
>  	kfree(veal);
> +	if (ret) {
> +		dev_err(&adapter->pdev->dev,
> +			"Unable to send ADD_ETH_ADDR message to PF, error %d\n", ret);
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
> +	}
> +
> +	return ret;
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but iavf_process_aq_command()
still ignores the value that iavf_add_ether_addrs() now returns:

	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_MAC_FILTER) {
		iavf_add_ether_addrs(adapter);
		return 0;
	}

Before calling iavf_send_pf_msg(), iavf_add_ether_addrs() clears f->add
on the batched filters. It also clears IAVF_FLAG_AQ_ADD_MAC_FILTER when
!more.

If the send fails on the watchdog path, those filters are left with
add = 0 and add_handled = 0, and nothing queues them again.

The notes for this version say the watchdog path retries on the next
cycle. Can it retry, given that the pending state has already been
cleared? The same loss existed with the old void function.

[ ... ]

> @@ -2950,3 +2960,72 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,

[ ... ]

> + * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
> + */

[Severity: Low]
The kernel-doc says "or error code", but can this function return
anything other than 0 or -EAGAIN?

The status from iavf_clean_arq_element() is compared to IAVF_SUCCESS and
otherwise dropped. IAVF_ERR_QUEUE_EMPTY and IAVF_ERR_ADMIN_QUEUE_ERROR are
treated as "no work", and polling continues until the timeout.

For the same situation, iavf_poll_virtchnl_msg() returns
iavf_status_to_errno(status).

> +int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,

[ ... ]

> +	timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	do {
> +		if (!pending)
> +			usleep_range(50, 75);
> +
> +		if (iavf_clean_arq_element(hw, event, &pending) == IAVF_SUCCESS) {

[ ... ]

> +			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);

[Severity: Low]
This isn't a bug today, since the only caller allocates exactly
IAVF_MAX_AQ_BUF_SIZE. The helper takes a caller-allocated event, though.
Should this use event->buf_len so that a future caller with a smaller
buffer does not overflow event->msg_buf?

> +
> +			if (pending)
> +				continue;
> +		}
> +	} while (time_before(jiffies, timeout));

[Severity: Medium]
What happens to this loop if a VFR/EMPR or a surprise removal occurs
while it is polling? iavf_adminq_task() has guards that this loop lacks:

- no IAVF_FLAG_PF_COMMS_FAILED check
- no iavf_is_reset_in_progress() check
- no check for the 0xdeadbeef/0xffffffff register sentinels
- no break on a descriptor without an opcode

iavf_clean_arq_element() does not check ntu against num_arq_entries:

	ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;
	if (ntu == ntc) {

With the sentinel values, ntu becomes 751 or 1023, well beyond
IAVF_AQ_LEN (32). Each call would then:

- clean a re-armed descriptor
- write IAVF_VF_ARQT1 and advance next_to_clean
- return IAVF_SUCCESS with a non-zero pending

So the loop takes the continue path without sleeping until the deadline.

Each pass takes arq_mutex, does MMIO reads and writes, and does a 4 KB
memcpy and memset, with no cond_resched(). RTNL and the netdev instance
lock are held throughout.

reset_task, watchdog_task and adminq_task all need netdev_lock and run on
the ordered adapter->wq. A reset, possibly announced by a RESET_IMPENDING
event this loop just processed, cannot be handled until the timeout.

The notes for this version call this equivalent to the old
wait_event_interruptible_timeout(). The old code slept and never touched
the ring, though. Should this loop bail out on reset or on the sentinel
values, as iavf_adminq_task() does?

> +
> +	return ret;
> +}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928224454.483072-1-anthony.l.nguyen%40intel.com
