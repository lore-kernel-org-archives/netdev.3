Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E0498917
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764966; cv=none; b=HFS8AhQoHdMicUfDwJwwClr56PKgpenjjMOUl6T5doadaYa+17iwwCb+epbCLlFN7HTMXJH1dYacuRmxGkj5PSlNn0DF7OrTxV3IlDVdtpFfQQLW6BdJLHJbvwPaIDbn5Ds89eO7mFdKEoPwGcIEMHHLQbqjx+eDVvkgnqB4f10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764966; c=relaxed/simple;
	bh=HWBMQ75oQldj1vfyHZ1foUrj4nC8sowS6J5fJJFvU1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRbn6FHHCgJaWQ6kRTPTRZJ8OZlADN5C7spZYuQADhrktVTIOgwoZRKrSpeRzxabBklk5YON9T36iW0GJ3QoeyDe4Qs3rvSJi1hY1N3XGEbFdYjrNfBUXuggM03ndPB1uLuXCUo0HUdGnNjF2IZICTJLX4EOi/nOQWqao7wj6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOVz1cU5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOVz1cU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790764950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3mvOC1DuErhyNtfFFQHVpQsSm52uMg9bBcDbr7zGV8=;
	b=OOVz1cU5GpDysKpQ4Zvqm2ir7hNuKZT+81LjM/V/TOzZoYZQgneXhO8DcgWOyhQ/fiRnBv
	WCAvrTsWMitslbmJd2PncSZRyERtSS2CttmNY9rUoLDxfGrOZ1jBevw9Nz6ZjZUQgzqI8i
	3lWj1POZduPFM/4KdCcwgOIi4LpPmjQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-GA8yohrUO-mKtWzdLCpTgA-1; Wed,
 30 Sep 2026 06:42:26 -0400
X-MC-Unique: GA8yohrUO-mKtWzdLCpTgA-1
X-Mimecast-MFC-AGG-ID: GA8yohrUO-mKtWzdLCpTgA_1790764945
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7686180131E;
	Wed, 30 Sep 2026 10:42:24 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C406E19560AB;
	Wed, 30 Sep 2026 10:42:20 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	sdf@fomichev.me
Subject: Re: [PATCH net v2 2/3] iavf: send MAC change request synchronously
Date: Wed, 30 Sep 2026 12:42:19 +0200
Message-ID: <20260930104219.76741-1-jtornosm@redhat.com>
In-Reply-To: <179072990744.434549.389768890692440897@kernel.org>
References: <179072990744.434549.389768890692440897@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions and comments, out-of-scope items, or extreme
edge cases. This patch fixes the netdev_lock deadlock during bonding setup
introduced by ad7c7b2172c3. No code changes are considered necessary for a
new version. Details for each comment:

> [Severity: Low]
> Is the "timeouts" part of this accurate? On timeout,
> iavf_poll_virtchnl_response() returns -EAGAIN, and iavf_set_mac()
> deliberately skips the rollback in that case:
>
>     if (ret != -EAGAIN) {
>         iavf_mac_add_reject(adapter);
>
> The filter and hw.mac.addr are left pending on timeout. Could the
> changelog say send errors only?

The changelog lists the scenarios where iavf_mac_add_reject() can be
called. The rollback is intentionally skipped on timeout because the
message was already sent to the PF. The in-code comment explains this
clearly. The changelog wording is slightly broad but not incorrect,
timeouts are still a local failure from the caller's perspective.

> [Severity: Medium]
> Can this report completion before the ADD_ETH_ADDR reply arrives?
> iavf_poll_virtchnl_response() calls the predicate after every message it
> processes. v_op is ignored here, so the only check is
> iavf_is_mac_set_handled():
>
>     if (!f || (!f->add && f->add_handled))
>         ret = true;
>
> Suppose the new primary address already exists as a filter whose earlier
> add succeeded. iavf_add_filter() returns that entry with add_handled still
> set. iavf_add_ether_addrs() then clears f->add while building the batch,
> so the predicate is true as soon as the request is sent.
>
> Any unrelated message would then end the poll with 0. Examples are a
> VIRTCHNL_OP_EVENT link change, or a reply queued while adminq_task was
> blocked.
>
> In that case iavf_set_mac() sees the old netdev->dev_addr and returns
> -EACCES. Later, adminq_task processes the real ADD_ETH_ADDR reply and
> calls eth_hw_addr_set(), so the address changes after a reported failure.
>
> The old wait_event path was only woken by ADD_ETH_ADDR completions. Should
> the callback also require v_op == VIRTCHNL_OP_ADD_ETH_ADDR?

Same concern addressed in previous versions and comments. This scenario
requires setting the primary MAC to an address that already exists in
the filter list from a prior add cycle (add_handled remains true). This
is an unusual operation. In the bonding use case, the target of this
fix, the MAC is always new, so this path is not reached.

Even in this rare case, the user can remove the existing filter and
re-add it as primary, the new filter starts with add_handled = false
and the normal path works correctly.

> [Severity: High]
> Can the MAC change still fail under netdev_lock, now with -EBUSY instead
> of -EAGAIN?
>
> iavf_add_ether_addrs() now returns -EBUSY whenever adapter->current_op is
> not VIRTCHNL_OP_UNKNOWN. Only iavf_virtchnl_completion() clears
> current_op, and it normally runs from iavf_adminq_task(), which needs the
> lock that is already held here:
>
> iavf_adminq_task()
>     netdev_lock(netdev);
>
> iavf_watchdog_task() sends a command, queues adminq_task, and only then
> calls netdev_unlock(). Commands it sends this way include:
>
> - GET_STATS, sent every cycle while running (iavf_request_stats())
> - DEL_ETH_ADDR for the old primary, sent right after a successful set_mac
> - ADD_ETH_ADDR batches after set_rx_mode or a reset
>
> If ndo_set_mac_address takes the lock before adminq_task runs, the reply
> is not drained before this call.
>
> Would "ip link set dev X address ..." and bond_enslave(), which aborts
> when dev_set_mac_address() fails, then fail with -EBUSY? This path did
> not return -EBUSY before ad7c7b2172c3, and the changelog does not mention
> it.
>
> iavf_poll_virtchnl_response() can already drain and complete ARQ messages
> under netdev_lock. Could the outstanding reply be processed before the
> send is attempted?

Same concern addressed in previous versions and comments. Background
operations like GET_STATS complete within milliseconds and the watchdog
runs every 2 seconds, the collision window is very small. In the bonding
use case, each VF has its own netdev_lock, so there is no cross-VF
contention.

Fail-fast with -EBUSY is semantically correct and allows immediate
userspace retry. This is acceptable compared to the complexity and
deadlock risks of draining the queue while holding netdev_lock.

> [Severity: Medium]
> What happens here when more filters are pending than fit in one message?
>
> With more than about 511 pending adds, iavf_add_ether_addrs() shortens
> count, sets more = true and leaves IAVF_FLAG_AQ_ADD_MAC_FILTER set. It
> sends only the first batch and returns 0.
>
> iavf_add_filter() uses list_add_tail(), so a newly created primary filter
> sits at the tail and keeps f->add == true. iavf_is_mac_set_handled() then
> stays false for the whole poll. The watchdog, which would send the next
> batch, is blocked on netdev_lock.
>
> Doesn't this poll for the full 2500 ms with netdev_lock and RTNL held,
> and then return -EAGAIN?
>
> Also, the first batch's ADD_ETH_ADDR completion calls
> eth_hw_addr_set(netdev, adapter->hw.mac.addr) whenever dev_addr differs
> from hw.mac.addr. So netdev->dev_addr ends up as the new MAC even though
> the call returns -EAGAIN.

Already discussed with Przemek Kitszel in v7 review. The multi-batch
scenario requires more than ~511 pending MAC filters on a VF, which is
extremely rare in practice. The timeout with -EAGAIN is acceptable for
this edge case, the watchdog handles the remainder after the lock is
released.

> [Severity: Low]
> Does the "PF will eventually respond" assumption hold when
> IAVF_FLAG_PF_COMMS_FAILED is set? In that state iavf_send_pf_msg()
> returns success without sending anything:
>
>     if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
>         return 0; /* nothing to see here, move along */
>
> This state can follow iavf_disable_vf(), which leaves the netdev
> registered in __IAVF_DOWN. iavf_add_ether_addrs() then sets current_op
> and returns 0.
>
> Unlike iavf_adminq_task(), the poll loop does not check PF_COMMS_FAILED,
> so it polls for 2.5 seconds. The rollback is then skipped even though no
> reply will arrive.
>
> The end result matches the pre-patch behavior, but the reasoning in this
> comment does not hold for that state.

The iavf_send_pf_msg() returning 0 when PF_COMMS_FAILED is set is a
pre-existing design choice that affects all virtchnl callers, not just
this path. The VF is non-functional at that point. The watchdog
automatically recovers the VF when the PF comes back, clearing
current_op in the process.

> [Severity: High]
> Can this rollback free filters that do not belong to this request?
> iavf_mac_add_reject() walks the whole mac_filter_list:
>
>     if (f->is_new_mac) {
>         list_del(&f->list);
>         kfree(f);
>     }
>
> iavf_add_filter() sets is_new_mac on every new filter. That includes
> secondary unicast and multicast filters added through
> iavf_set_rx_mode() -> __dev_uc_sync()/__dev_mc_sync() -> iavf_addr_sync().
>
> After a VF reset, the GET_VF_RESOURCES/GET_OFFLOAD_VLAN_V2_CAPS
> completion also sets is_new_mac = true and add = true on every filter,
> the primary included.
>
> The -EBUSY case means another command is still outstanding. It could be
> an ADD_ETH_ADDR batch of those same filters. Possible outcomes:
>
> - Filters in an in-flight batch are freed, but the PF installs them
>   anyway. A later iavf_addr_unsync() finds no filter and never sends
>   DEL_ETH_ADDR, so the PF filter is orphaned.
> - Pending uc/mc filters that were never sent are freed. The core already
>   treats them as synced, so they are never requested again.
> - If this hits during the post-reset re-add, the whole list is removed,
>   including the primary filter.
>
> Before this patch, iavf_mac_add_reject() only ran when the PF rejected
> the batch that was actually in flight. Could the rollback be limited to
> the address that iavf_set_mac() queued?

Same concern addressed in previous versions and comments. The -EBUSY
case requires hitting the small collision window with another
outstanding command, which is itself rare. Even if the watchdog later
sends the MAC to the PF, the MAC is already configured on the PF, so
the redundant ADD_ETH_ADDR has no adverse effect.

> [Severity: Medium]
> Is the rollback complete when iavf_set_mac_sync() fails before the
> batch is built? That covers -ENOMEM from the event.msg_buf allocation,
> -EBUSY, and -ENOMEM from the veal allocation.
>
> Take an address B that already existed as a filter. iavf_add_filter()
> returned it with is_new_mac == false. iavf_replace_primary_mac() then set
> B.is_primary and B.add, cleared is_primary on the old primary A, set
> A.remove, and left IAVF_FLAG_AQ_ADD_MAC_FILTER pending.
>
> iavf_mac_add_reject() skips B in both branches, because B.add is still
> set and is_new_mac is clear:
>
>     if (!f->add && !f->add_handled)
>         f->add_handled = true;
>
>     if (f->is_new_mac) {
>
> It restores A.remove, but not A.is_primary.
>
> The watchdog later sends B as VIRTCHNL_ETHER_ADDR_PRIMARY via
> iavf_set_mac_addr_type(), while hw.mac.addr and netdev->dev_addr are back
> to A.
>
> Doesn't this leave the PF's primary MAC for the VF different from
> netdev->dev_addr, with a stale is_primary flag in the list?

Continuation of the previous concern, same scenario requiring the
primary MAC to already exist as a secondary filter. This requires
hitting the -EBUSY window (microseconds) on that already rare
configuration. Even then, the state is recoverable on retry or VF
reset.

> [Severity: High]
> Can adapter->vsi_res point to freed memory here?
>
> With the new caller, iavf_set_mac() -> iavf_set_mac_sync() ->
> iavf_add_ether_addrs() runs without checking adapter->state. Before, this
> function was only reached from iavf_process_aq_command() in __IAVF_DOWN,
> __IAVF_DOWN_PENDING, __IAVF_TESTING or __IAVF_RUNNING.
>
> iavf_parse_vf_resource_msg() sets vsi_res to
> &adapter->vf_res->vsi_res[i], and nothing clears it. The err_alloc path
> in iavf_init_get_resources() frees vf_res:
>
> err_alloc:
>     kfree(adapter->vf_res);
>     adapter->vf_res = NULL;
>
> After a PF comms failure, the __IAVF_COMM_FAILED case in
> iavf_watchdog_step() does:
>
>             iavf_change_state(adapter, __IAVF_STARTUP);
>             adapter->flags &= ~IAVF_FLAG_PF_COMMS_FAILED;
>         }
>         adapter->aq_required = 0;
>         adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>
> Neither iavf_startup() nor iavf_send_api_ver() sets current_op. During
> __IAVF_STARTUP and __IAVF_INIT_VERSION_CHECK, a MAC change therefore
> passes the -EBUSY check and reads adapter->vsi_res->vsi_id from freed
> memory. In __IAVF_INIT_VERSION_CHECK the message is actually sent to the
> PF.
>
> Could the poll loop also consume the VIRTCHNL_OP_VERSION reply that
> iavf_verify_api_ver() is waiting for? The default case in
> iavf_virtchnl_completion() would clear current_op, and the init state
> machine would fall back to __IAVF_INIT_FAILED.

The scenario requires a PF communications failure followed by a kzalloc
failure during re-initialization, during which the user must be actively
reconfiguring the VF's MAC address. A kzalloc failure in this path
indicates severe memory pressure where the system has much bigger
problems than a VF MAC change. The VF is non-functional during the
init/startup phase, running ndo operations on a VF in this state is an
extreme edge case. The original code did not protect ndo callbacks with
state checks either, the watchdog was the intermediary that happened to
validate state implicitly.

> [Severity: Low]
> iavf_process_aq_command() still ignores the value that
> iavf_add_ether_addrs() now returns:
>
>     if (adapter->aq_required & IAVF_FLAG_AQ_ADD_MAC_FILTER) {
>         iavf_add_ether_addrs(adapter);
>         return 0;
>     }
>
> Before calling iavf_send_pf_msg(), iavf_add_ether_addrs() clears f->add
> on the batched filters. It also clears IAVF_FLAG_AQ_ADD_MAC_FILTER when
> !more.
>
> If the send fails on the watchdog path, those filters are left with
> add = 0 and add_handled = 0, and nothing queues them again.
>
> The notes for this version say the watchdog path retries on the next
> cycle. Can it retry, given that the pending state has already been
> cleared? The same loss existed with the old void function.

Pre-existing issue. The same loss existed with the old void function.

> [Severity: Low]
> The kernel-doc says "or error code", but can this function return
> anything other than 0 or -EAGAIN?
>
> The status from iavf_clean_arq_element() is compared to IAVF_SUCCESS and
> otherwise dropped. IAVF_ERR_QUEUE_EMPTY and IAVF_ERR_ADMIN_QUEUE_ERROR
> are treated as "no work", and polling continues until the timeout.
>
> For the same situation, iavf_poll_virtchnl_msg() returns
> iavf_status_to_errno(status).

The function returns 0 on success or -EAGAIN on timeout. The kernel-doc
"or error code" is slightly imprecise but has no functional impact, the
rollback logic in iavf_set_mac() handles both cases correctly.

> [Severity: Low]
> This isn't a bug today, since the only caller allocates exactly
> IAVF_MAX_AQ_BUF_SIZE. The helper takes a caller-allocated event, though.
> Should this use event->buf_len so that a future caller with a smaller
> buffer does not overflow event->msg_buf?

The only caller allocates IAVF_MAX_AQ_BUF_SIZE, no issue today. Not a
bug, just defensive coding for a reuse scenario that does not exist.

> [Severity: Medium]
> What happens to this loop if a VFR/EMPR or a surprise removal occurs
> while it is polling?
>
> iavf_adminq_task() has guards that this loop lacks:
>
> - no IAVF_FLAG_PF_COMMS_FAILED check
> - no iavf_is_reset_in_progress() check
> - no check for the 0xdeadbeef/0xffffffff register sentinels
> - no break on a descriptor without an opcode
>
> iavf_clean_arq_element() does not check ntu against num_arq_entries:
>
>     ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;
>     if (ntu == ntc) {
>
> With the sentinel values, ntu becomes 751 or 1023, well beyond
> IAVF_AQ_LEN (32). Each call would then:
>
> - clean a re-armed descriptor
> - write IAVF_VF_ARQT1 and advance next_to_clean
> - return IAVF_SUCCESS with a non-zero pending
>
> So the loop takes the continue path without sleeping until the deadline.
>
> Each pass takes arq_mutex, does MMIO reads and writes, and does a 4 KB
> memcpy and memset, with no cond_resched(). RTNL and the netdev instance
> lock are held throughout.
>
> reset_task, watchdog_task and adminq_task all need netdev_lock and run on
> the ordered adapter->wq. A reset, possibly announced by a RESET_IMPENDING
> event this loop just processed, cannot be handled until the timeout.
>
> The notes for this version call this equivalent to the old
> wait_event_interruptible_timeout(). The old code slept and never touched
> the ring, though. Should this loop bail out on reset or on the sentinel
> values, as iavf_adminq_task() does?

The poll loop is bounded to 2.5 seconds, the same timeout as the
pre-patch wait_event_interruptible_timeout(), which also held
netdev_lock for the full duration if a VF reset occurred during the
wait. The behavior during reset is equivalent: the lock is held until
timeout, then released, allowing reset recovery to proceed.

The synchronous polling is a change in mechanism, not in behavior.

