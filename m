Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484767;
	b=5KmTh+JOekMhraYPn1MxrbUjCMhZdJ0Cg2UKpZ7Cvl747MDIgbbX5t9LxQApd9FJqMu8
	 rsntX1WTUWAUqveq1GKFoj6VrOPZAjfrUiZsyU4T/BtDVvuZb4cK/1jlpjcX/Lw97w86I
	 KqdsfzxMbRG57NQBj8dL+Zvkc9WAQS+JjhuMavGW88I8K5H9kw15Xb1DYmgCRo4+eGqPR
	 LJLKQ8TPKdZFAkDtK3vlPLfdfqFKJqGnoqB4sbM2/KGooZllMU2JcVBTAUH1qiT29m9dm
	 6+5VRAKyF/L5VyiaTxpaSINrGRvlWojVU/zeAoISdbtdLU46tiTJFWJJN7/H+V7L4uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484767;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=G2NGub2u3EAG0gIiS6fRuNblk5mM8yDZt5k/Kj252Xk=;
	b=e9OvXIsr02zSJUbleZMUPXvo+xkYkBQcN1o58R470YD9Bl0uQURwykb6YgOtKg5A4FXL
	 kYJCZuXOZBmXYYVPiiQZlAqkY7uUSYl5MWVmgfJJqvwaNMfjacAw9P6/IP4aUm6zBKsvw
	 8WGURFqQR6N9EkRHe1FR7S6tMYsdFpVpmEj/nepUGCsANLp/HZkw0AsfInc5RM4/jeqrz
	 RcgIe05JOcaLeDHRDGjRXVt+ERmqlOX7Ls2wxs07JHlhocuywGozSvXdRugsFn6ksFY6g
	 hPyHFJrkbPlhbqh9vkRBT/jp6YhKwhWXOsG6hbCL+0/WaWBYYQ84vX9jHO9xdTbxt2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJShVjqS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2560A3802;
	Tue, 20 Oct 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TJShVjqS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964271F000C8;
	Tue, 20 Oct 2026 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484767;
	bh=G2NGub2u3EAG0gIiS6fRuNblk5mM8yDZt5k/Kj252Xk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TJShVjqSP5q8lS7p/fGP84dumAYHzPZeWXeYZMT72o9T848qdgVatlOPF6ogqFnnI
	 hHeIkw/Aci5TYP6/oOxQ5iWG/a0Gk3e+QhTkPb9PwHcj7HhD8b2TAFTLt/qGSs4KBk
	 xxGEXrn9I4CGeopSCGuF7/qLkjdiQodC8jwI/dIVH8ei0fi9JJpfdemnvkBh2pW6dl
	 m9xR5DNQePafzKz4QyH2PSOamqBwPemRSg9Two8V0jgEs7xdMelUmgEDQMS1HX3XCE
	 kOesql9yHPnQq54skesRuHNpEyauE71LcjJhUrysREpJ6fb522dnS7vyJ5JylBEclU
	 8LEIElSg3RgPQ==
Subject: Re: [PATCH net 2/3] enic: retain admin-channel DMA until queues stop
From: netdev-bot+sashiko@kernel.org
To: satishkh@cisco.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sebaddel@cisco.com, aradhana@cisco.com,
 rfaucett@cisco.com
Date: Tue, 20 Oct 2026 08:26:06 +0000
Message-ID: <179248476612.3135.14483608638763767032@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261016-b4-enic-dma-vf-index-net-generic-first-v1?=
 =?utf-8?q?-20261010-v1-2-d27b55f69883=40cisco=2Ecom=3E?=
References: =?utf-8?q?=3C20261016-b4-enic-dma-vf-index-net-generic-first-v1-?=
 =?utf-8?q?20261010-v1-2-d27b55f69883=40cisco=2Ecom=3E?=
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The notify DMA target that the patch now keeps while the admin
  graph is quarantined is never unregistered.
- [Medium] After admin quarantine, enic_admin_channel_close() calls
  pci_clear_master() (enic_admin.c:708).
- [Medium] enic_reset() and enic_tx_hang_reset() reopen the admin channel
  without checking whether the enic_open() just before it quarantined…
- [Medium] The admin quarantine path calls pci_clear_master() on the
  whole PCI function (enic_admin.c:708) while the generic datapath WQ/RQ…
- [Low] In the rewritten enic_probe() unwind, `goto
  err_out_disable_sriov;` sits on the line directly before the…
- [Low] Claim: enic_open() has no admin-quarantine gate, so
  enic_change_mtu_work -> _enic_change_mtu() -> enic_open() could re-…
- [Low] The three callers of the newly parameterised
  enic_datapath_release() apply different rules.
- [Low] enic_stop() decides whether to keep the shared notify target from
  a lockless READ_ONCE of admin_chan_state (enic_datapath_release(enic,…

--

enic: retain admin-channel DMA until queues stop

This patch tracks the enic admin channel as DOWN, LIVE or QUARANTINED. The
admin WQ/RQ/CQ graph is released only after both queue disables observe
RUNNING == 0. On a disable timeout the graph is kept and bus mastering is
cleared, and the reset, SR-IOV, probe and remove paths are updated to hold
quarantined graphs until a final recheck at remove time.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index 61c82b48044d0..a5c08cbcb3391 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c

[ ... ]

> @@ -600,68 +612,141 @@ int enic_admin_channel_open(struct enic *enic)

[ ... ]

> +	/* QP_DISABLE does not report every low-level stop failure.  The direct
> +	 * WQ/RQ RUNNING observations own the admin allocation graph.
> +	 */
> +	if (wq_err || rq_err) {
> +		WRITE_ONCE(enic->admin_chan_state, ENIC_DMA_QUARANTINED);
> +		WRITE_ONCE(enic->mbox_tx_poisoned, true);
> +		mutex_unlock(&enic->mbox_lock);
> +		netif_device_detach(enic->netdev);
> +		netif_carrier_off(enic->netdev);
> +		/* Stop new PCIe requests without treating bus-master disable as
> +		 * proof that already-issued DMA has completed.
> +		 */
> +		pci_clear_master(enic->pdev);

[Severity: Medium]
pci_clear_master() here applies to the whole PCI function, and the generic
datapath WQs and RQs may still be enabled. Can a healthy datapath still
drain after this?

In enic_reset() and enic_tx_hang_reset() the admin close runs before
enic_stop(). In a V2 VF enic_remove() it runs before
unregister_netdev()->enic_stop().

enic_stop() then calls vnic_wq_disable() and vnic_rq_disable(), which poll
ctrl->running for 500 ms. With bus mastering cleared, the function can no
longer do the descriptor fetches and completion writes needed to retire
in-flight work. If those polls time out, enic_datapath_quarantine() keeps
the datapath until reboot. That seems to contradict the commit message:

  "Keep the admin and generic datapath ownership graphs independent."

The same question applies to enic_admin_channel_recheck_on_remove(). It
polls the admin WQ/RQ after bus mastering has already been removed. The
commit message says clearing bus mastering does not "prevent the final
remove-time RUNNING recheck from observing a queue which subsequently
drains". Is this behaviour of the VIC queue engine documented anywhere?

> +		return wq_err ?: rq_err;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 5a205ea3031b9..06d76648b420c 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c

[ ... ]

> @@ -1729,11 +1730,15 @@ static void enic_notify_timer_start(struct enic *enic)
>  	}
>  }
>  
> -static void enic_datapath_release(struct enic *enic)
> +static void enic_datapath_release(struct enic *enic, bool release_notify)
>  {
>  	unsigned int i;
>  
> -	enic_dev_notify_unset(enic);
> +	/* The notification allocation is a separate vNIC DMA target.  Keep it
> +	 * with the shared lifetime envelope if another DMA graph is quarantined.
> +	 */
> +	if (release_notify)
> +		enic_dev_notify_unset(enic);

[Severity: Medium]
Once this unset is skipped, does any later path ever do it?

enic_stop() can run while the admin graph is quarantined. Two examples:

  enic_reset()->enic_admin_channel_close() times out, then enic_stop()

  a V2 VF enic_remove()->enic_admin_channel_close() times out, then
  unregister_netdev()->enic_stop()

In both cases release_notify is false. datapath_state becomes
ENIC_DMA_DOWN while vdev->notify is still registered with firmware through
CMD_NOTIFY.

Later in enic_remove(), enic_admin_channel_recheck_on_remove() can succeed
and set admin_chan_state to ENIC_DMA_DOWN. enic_datapath_recheck_on_remove()
is skipped because the datapath is not quarantined, so no caller passes
release_notify=true. enic_dma_quarantined() is then false and the full
teardown runs:

enic_remove()
  enic_dev_deinit()
  vnic_dev_close()
  vnic_dev_unregister()
    dma_free_coherent(..., vdev->notify, vdev->notify_pa)

vnic_dev_unregister() frees the buffer without the CMD_NOTIFY retraction,
which only vnic_dev_notify_unsetcmd() issues. Can this free a coherent
buffer whose bus address firmware still holds as its notify target?

Bus mastering was cleared at quarantine. For this to cause corruption, the
stale registration would have to survive until a later bind, where
enic_probe() calls pci_set_master() before notify is set up again.

The kept block also makes any later enic_open() fail in
vnic_dev_notify_set() with "notify block ... still allocated".

[ ... ]

> @@ -1899,7 +1904,7 @@ static int enic_open(struct net_device *netdev)
>  		enic_datapath_quarantine(enic);
>  		return err;
>  	}
> -	enic_datapath_release(enic);
> +	enic_datapath_release(enic, true);

[Severity: Low]
Should this follow the same rule as enic_stop() and
enic_datapath_recheck_on_remove()? Both pass
!enic_admin_channel_is_quarantined(enic).

The comment in enic_datapath_release() says notify is kept "if another DMA
graph is quarantined".

For a V2 VF, enic_remove() calls enic_admin_channel_close() before
unregister_netdev() and without rtnl. At the same time, enic_open() can be
running under rtnl from a user "ip link set up".

If the admin close quarantines and clears bus mastering mid-open,
enic_dev_enable() can time out. This unwind then releases notify with
release_notify=true and issues a CMD_NOTIFY unset that cannot reach
firmware.

[Severity: Low]
Separately, enic_open() only checks enic_datapath_is_quarantined() before
it proceeds. Can enic_change_mtu_work->_enic_change_mtu()->enic_open()
reach this function after the admin graph has been quarantined and bus
mastering cleared?

In the final state of the series this does not seem to reach ring
enablement. enic_dev_notify_set() fails first, either with -EINVAL from the
kept notify block or with a DEVCMD2 timeout once "enic: require DEVCMD2 and
set the V2 VF mailbox source" makes DEVCMD2 mandatory.

With only this patch applied, though, a devcmd1 V2 VF could get past
CMD_NOTIFY and re-enable the datapath rings on a contained function. Would
an explicit enic_admin_channel_is_quarantined() check here be clearer?

[ ... ]

> @@ -1974,7 +1979,8 @@ static int enic_stop(struct net_device *netdev)
>  		return disable_err;
>  	}
>  
> -	enic_datapath_release(enic);
> +	enic_datapath_release(enic,
> +			      !enic_admin_channel_is_quarantined(enic));

[Severity: Low]
Is this lockless read of admin_chan_state stable against a concurrent
enic_admin_channel_close()?

enic_stop() holds only rtnl here. In enic_remove() for a V2 VF,
enic_admin_channel_close() runs before unregister_netdev() without rtnl. It
publishes ENIC_DMA_QUARANTINED under mbox_lock only:

CPU0 (ip link set down)          CPU1 (enic_remove)
enic_stop()
  reads "not quarantined"
                                 enic_admin_channel_close()
                                   WRITE_ONCE(enic->admin_chan_state,
                                              ENIC_DMA_QUARANTINED)
                                   pci_clear_master()
  enic_datapath_release(enic, true)
    enic_dev_notify_unset()

This releases the notify target while another graph is quarantined, which
release_notify is meant to prevent.

[ ... ]

> @@ -2398,13 +2426,17 @@ static void enic_reset(struct work_struct *work)
>  	if (reopen)
>  		enic_open(enic->netdev);
>  

[ ... ]

>  	if (enic_has_admin_chan(enic))
>  		enic_admin_chan_reopen(enic);

[Severity: Medium]
Should enic_admin_chan_reopen() be skipped when the enic_open() just above
has quarantined the datapath?

The return value of enic_open() is ignored. enic_open() can enable RQs,
fail later, and then time out disabling an RQ. In that case
enic_datapath_quarantine() sets mbox_send_disabled, detaches the netdev and
clears bus mastering.

The new checks in enic_admin_channel_open() test only admin_chan_state and
mbox_tx_poisoned (and, later in the series, sriov_stats_dma_unresolved).
The reopen therefore still allocates admin resources, requests the admin
IRQ, enables the admin WQ/RQ, fills the admin RQ with freshly mapped
buffers and sends QP_ENABLE.

On a devcmd1 device QP_ENABLE succeeds and mbox_send_disabled is cleared
again, which undoes enic_datapath_quarantine(). With DEVCMD2, QP_ENABLE
times out and the partial-open close polls admin queues that cannot
complete DMA. That could quarantine the admin graph too.

enic_tx_hang_reset() has the same sequence.

> +	if (enic_admin_channel_is_quarantined(enic)) {
> +		stop_err = enic_stop(enic->netdev);
> +		netdev_err(enic->netdev,
> +			   "Admin queue did not stop after reopen failure (datapath stop %d); resources retained until reboot\n",
> +			   stop_err);
> +	}

[ ... ]

> @@ -2422,30 +2454,39 @@ static void enic_tx_hang_reset(struct work_struct *work)

[ ... ]

> -	if (enic_has_admin_chan(enic))
> -		enic_admin_channel_close(enic);
> +	if (enic_has_admin_chan(enic)) {
> +		err = enic_admin_channel_close(enic);
> +		if (err && enic_admin_channel_is_quarantined(enic))
> +			netdev_err(enic->netdev,
> +				   "Admin queue did not stop: %d\n", err);
> +		else if (err)
> +			netdev_warn(enic->netdev,
> +				    "Admin QP disable returned: %d\n", err);
> +	}
>  
>  	enic_dev_hang_notify(enic);
>  	if (reopen)
>  		stop_err = enic_stop(enic->netdev);

[Severity: Medium]
If enic_admin_channel_close() has just quarantined and called
pci_clear_master(), can the devcmds that follow still be delivered?

Later in the series ("enic: require DEVCMD2 and set the V2 VF mailbox
source") DEVCMD2 becomes mandatory for admin-channel functions.
_vnic_dev_cmd2() writes into the host-memory cmd_ring, bumps posted_index,
and then busy-polls result->color. Only a device DMA write can update
result->color.

With bus mastering off, each of these commands would spin for its full
timeout under devcmd_lock with BH disabled, then return -ETIMEDOUT:

enic_tx_hang_reset()
  enic_dev_hang_notify()          HANG_NOTIFY
  enic_stop()
    enic_rfs_flw_tbl_free()       filter deletes
    enic_dev_disable()            CMD_DISABLE

enic_reset()->enic_stop() runs into the same thing.

dc2c->posted, next_result and color keep advancing while the hardware
fetch_index does not. Once the ring fills, commands fail with -EBUSY.

At remove, after a successful admin recheck, the CMD_NOTIFY unset,
enic_dev_deinit() and vnic_dev_close() are lost the same way. Then
vnic_dev_deinit_devcmd2() frees the results ring before it disables a
DEVCMD2 WQ that still holds unfetched descriptors. Does this leave firmware
with the vNIC open and a stale results-ring address?

[ ... ]

> @@ -3499,12 +3564,24 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

[ ... ]

> -err_out_dev_deinit:
>  	enic_dev_deinit(enic);
>  err_out_dev_close:
>  	vnic_dev_close(enic->vdev);
> +	goto err_out_disable_sriov;
>  err_out_disable_sriov:

[Severity: Low]
This isn't a bug, but this goto jumps to the label on the very next line.
Was it meant to be removed?

>  	kfree(enic->pp);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-b4-enic-dma-vf-index-net-generic-first-v1-20261010-v1-0-d27b55f69883%40cisco.com
