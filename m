Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAE3C98B7
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806344; cv=none; b=PZs3KX2LoT/bHXMiLRWbFZkIaNnRY8ljWpFvI8+Y+EJSzm72j+62i3PDC5uA51c+l4/djZPMQ+n/G3Zlnp3Nf4e5ATcG6lEtKJJSBndEEVpG9pN/AYynH0UMQdaxBjSedqBnrgpu1wlH8MhBl9+t1Efoc9oiVP3EeLvB9DUrHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806344; c=relaxed/simple;
	bh=KSQ79RvinMqQ7ypKIzoRiOlSWMgncWc4ZD6cmIoh3EQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8OBkcwGFI+nZav7k+gWqGxraSZ0+GQjGYZ3UJLVmjQbiIxRRULN9ZgNN1Up+qSpwMWAtggzI2hd1m87TytiUt6gtfpYMo7GI8eD2dhzCZgShZkpXVQ1pgVFlDME7nl2jY1rEB10zCBPjgVe8A4k8WacqFHoDuccoScpfDHBZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMdQLHL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMdQLHL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986DF1F00898;
	Wed, 30 Sep 2026 22:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790806342;
	bh=ywqL3AX3gDnODxBnDV0YgvnmtUqceckMLXwPD0zLm/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jMdQLHL0nRYiXW99kaZCk+JIwysKk0+1PXyhH/fhRorHUJAC9Y1lr/lXGXboy0oy+
	 /LhR1RjgPkyei7jgk4OcY3sWRFj/eKIVHWrO3Hp47kTYmee5Z0l6skR3M/LAFzX6gp
	 MpqSDShRnLqDy4Xb3qNJlTb3MjNtWtb+nSBxuXrkRVaOO4gC4NzmSiSrATUScUyg0V
	 00ZUS987Iu0f5dPcr2xmbqrj5P5BROmY/+UGaw93xjuO3RdWcIZOfco11JgInLScxI
	 iqHQnAYSqo5ViBSa/awC+o07SAaU/jeDO0fw4yvKnZb8yGurr9la4H1NIBTUY8gdk+
	 kBgkBpF5hIyEA==
Subject: Re: [next-next PATCH v2 2/2] fbnic: Remove BMC routing rules when the
 BMC channel is disabled
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Wed, 30 Sep 2026 22:12:21 +0000
Message-ID: <179080634117.434549.9870514324548682506@kernel.org>
In-Reply-To: =?utf-8?q?=3C179061193535=2E414394=2E10077526689774524435=2Estg?=
 =?utf-8?q?it=40ahduyck-xeon-server=2Ehome=2Earpa=3E?=
References: =?utf-8?q?=3C179061193535=2E414394=2E10077526689774524435=2Estgi?=
 =?utf-8?q?t=40ahduyck-xeon-server=2Ehome=2Earpa=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says "The instance lock is the one lock every
  writer of the shadow holds", and fbnic_bmc_rpc_check() now takes…
- [Medium] fbnic_bmc_rpc_check() picks the new teardown only when
  fbnic_bmc_rules_present() finds a MACDA entry carrying…
- [Medium] The new teardown runs only from fbnic_bmc_rpc_check(), which
  only the service task calls.
- [Low] The patch fixes user-visible bugs but has no Fixes: tag, and it
  combines several fixes that could be split out and that come from…

Pre-existing issues:
- [Medium] fbnic_bmc_rpc_check() now calls fbnic_rss_reinit() and then
  __fbnic_set_rx_mode(), which runs…
- [Medium] fbnic_bmc_rpc_init() (fbnic_rpc.c:175-236) writes BMC unicast
  MACs into slots starting at FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX, and…

--

fbnic: Remove BMC routing rules when the BMC channel is disabled

When the firmware reports that the BMC is gone but BMC-tagged rules are
still programmed, fbnic_bmc_rpc_check() now removes the BMC MACDA
entries, the BMC action rule and the host-unicast RSS entries. The patch
also recomputes the RSS actions on every TCAM reinit and deletes action
rules in any live state. It also takes the netdev instance lock across
fbnic_bmc_rpc_check().

> Take the instance lock over the whole of fbnic_bmc_rpc_check() while here.

[Severity: Low]

This isn't a bug, but the patch has no Fixes: tag. It also combines
several fixes that come from different commits:

- the new BMC teardown when NC-SI is disabled while the host is up

- the fbnic_bmc_rpc_all_multi_config() change from "== VALID" to
  "!= DISABLED". This fixes a separate pre-existing leak: ifdown demotes
  the all-multi rule to UPDATE, and fbnic_write_rules() writes it back
  at the next ifup.

- the locking fix in fbnic_bmc_rpc_check(). The commit message traces
  this to commit 60dd9781e9b8 ("fbnic: convert to
  ndo_set_rx_mode_async"). It can be hit on every
  FBNIC_FW_CAP_F_BMC_MACDA_SYNC pass, even if the BMC never disables.
  git blame points at commit 04a230b27d8f3 for the service task reinit
  path.

Could these be split out, each with its own Fixes: tag? Stable could then
take the locking fix without also taking the new teardown logic.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index 51fd0564d33f..939d56585b26 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c

[ ... ]

> @@ -234,10 +236,91 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)

[ ... ]

> +/**
> + * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
> + * @fbd: Pointer to fbnic device struct
> + *
> + * Undo fbnic_bmc_rpc_init() when the BMC drops its NC-SI channel while the
> + * host interface stays up. Only marks shadow state; the caller's
> + * __fbnic_set_rx_mode() pushes it to hardware, so ordering here is moot.
> + */

[Severity: Medium]

What happens if the BMC disables its NC-SI channel while the host
interface is down?

Only the service task calls fbnic_bmc_rpc_check(), and the service task
re-arms itself only while the netdev is running:

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_service_task() {
    ...
	if (netif_running(netdev))
		schedule_delayed_work(&fbd->service_task, HZ);
}

The last ifdown ran with the BMC present, so it left three things behind:

- fbnic_clear_rules() left rule 63 as a DEST_BMC catch-all
- fbnic_clear_macda() left the BMC-tagged MACDA entries valid
- fbnic_rss_disable_hw() left RMI_CONFIG enabled

On the next ifup, __fbnic_open() calls fbnic_bmc_rpc_init(), which
returns early. It then calls fbnic_rss_reinit(), which only touches the
mc/bc entries.

After that, fbnic_up()->__fbnic_set_rx_mode() writes the stale state to
hardware:

- fbnic_write_rules() writes act rule 0 back, since ifdown demoted it to
  UPDATE
- fbnic_write_tce_tcam() programs TCE loopback again for the BMC MACs
  that are still tagged
- the leftover host-unicast RSS entries are written as well

This only converges at the first service pass, at least HZ after ifup.

If the interface goes down again inside that window, won't
fbnic_clear_macda() still print "Found BMC MAC address w/ BMC not
present"? The commit message says that warning is what this patch
removes.

[ ... ]

>  void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
>  {
> +	struct fbnic_net *fbn = netdev_priv(fbd->netdev);
>  	int err;
>  
> +	/* Nothing to do unless the firmware raised one of the flags. Test
> +	 * before taking the lock to keep it off the common path; one raised
> +	 * after this is picked up on the next pass.
> +	 */
> +	if (!(READ_ONCE(fbd->fw_cap.state) & FBNIC_FW_CAP_BMC_PENDING))
> +		return;
> +
> +	/* The rx mode work and the ethtool paths rewrite the MACDA and action
> +	 * TCAM shadows under the instance lock, and this runs from the service
> +	 * task under RTNL only, so the two do not exclude each other.
> +	 */
> +	netdev_lock(fbd->netdev);

[Severity: High]

The commit message says "The instance lock is the one lock every writer
of the shadow holds." Is that true across the whole service task?

fbnic_service_task() in fbnic_pci.c holds only rtnl_lock(). It calls
fbnic_health_check() just before fbnic_bmc_rpc_check(). After a heartbeat
loss, fbnic_health_check() calls fbnic_fw_config_after_crash(). That
function rewrites the same shadow and the hardware without taking the
instance lock:

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_fw_config_after_crash() {
    ...
	fbnic_rpc_reset_valid_entries(fbd);
	netif_addr_lock_bh(fbd->netdev);
	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
	netif_addr_unlock_bh(fbd->netdev);
    ...
}

fbnic is ops-locked, so netdev_work_proc() runs netif_rx_mode_run()
under the instance lock alone. netif_rx_mode_run() drops addr_list_lock
before calling fbnic_set_rx_mode()->__fbnic_set_rx_mode() on the uc/mc
snapshots.

Can these two paths run at the same time on different CPUs? If so:

- both could allocate MACDA slots through
  __fbnic_uc_sync()/__fbnic_mc_sync()
- fbnic_write_macda() could memset() an entry that the other side is
  still filling in
- one side could clear hardware entries the other side has just written

There may also be a sync_cnt problem. The crash path syncs the live
lists with __hw_addr_sync_dev(). __hw_addr_list_reconcile() then adds
the snapshot delta on top:

net/core/dev_addr_lists.c:__hw_addr_list_reconcile() {
    ...
		real_ha->sync_cnt += delta;
		real_ha->refcount += delta;
    ...
}

Would that leave sync_cnt/refcount inflated, so that a removed address
is never unsynced from hardware?

Should fbnic_fw_config_after_crash() also run under netdev_lock()? The
other option is to take the lock around every part of the service task
that writes the shadow.

> +
>  	/* Consume the flag before the state it advertises. The ordering
>  	 * implied by test_and_clear_bit() pairs with the barrier in
>  	 * fbnic_fw_parse_bmc_cap(), and claiming it atomically means a set
> @@ -245,7 +328,15 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
>  	 */
>  	if (test_and_clear_bit(FBNIC_FW_CAP_F_BMC_TCAM_REINIT,
>  			       &fbd->fw_cap.state)) {
> -		fbnic_bmc_rpc_init(fbd);
> +		if (!fbnic_bmc_present(fbd) && fbnic_bmc_rules_present(fbd))

[Severity: Medium]

Does fbnic_bmc_rules_present() reliably tell us whether the host-unicast
RSS entries are programmed?

fbnic_rss_reinit() programs the host-unicast entries based only on
fbnic_bmc_present(). It is also called from fbnic_set_rss_hash_opts()
and fbnic_hwtstamp_set(), and neither of those sets a MACDA BMC tag.

Take this sequence:

1. The BMC goes from absent to present. FW sets PRESENT and
   TCAM_REINIT.
2. Before the next service pass, ethtool rx-flow-hash or SIOCSHWTSTAMP
   calls fbnic_rss_reinit(). It sees the BMC present and programs the
   host-unicast entries.
3. The BMC goes absent again.
4. The service pass sees !present && !rules_present and takes the else
   branch. fbnic_bmc_rpc_init() returns early, and fbnic_rss_reinit()
   skips the unicast entries:

	for (i = fbnic_bmc_present(fbd) ? 0 : FBNIC_RSS_EN_NUM_UNICAST;
	     i < FBNIC_RSS_EN_NUM_ENTRIES; i++) {

The host-unicast entries are then never deleted.

The same result looks possible within a single pass.
fbnic_fw_parse_bmc_cap() sets PRESENT from mailbox context without the
instance lock. It can land after fbnic_bmc_rpc_disable() has marked the
entries DELETE and before fbnic_rss_reinit() runs. fbnic_rss_reinit()
then turns them back into UPDATE, with no BMC tags left.

These entries match ahead of the mc/bc RSS entries. Unicast traffic would
keep the old rss_en_mask, RXH_DISCARD and TS_ENA settings.
fbnic_clear_valid_act_tcam() also demotes them to UPDATE, so they get
written again at every ifup.

Doesn't this leave the "stale and valid in hardware" case from the
commit message still reachable?

> +			fbnic_bmc_rpc_disable(fbd);
> +		else
> +			fbnic_bmc_rpc_init(fbd);

[Severity: Medium]

This is a pre-existing issue, but what happens here if the BMC MAC set
changes between two TCAM_REINIT passes while fbnic_bmc_present() stays
true?

fbnic_bmc_rpc_init() writes the new BMC unicast MACs starting at
FBNIC_RPC_TCAM_MACDA_BMC_ADDR_IDX and adds the multicast ones via
__fbnic_mc_sync(). It never clears FBNIC_MAC_ADDR_T_BMC from entries
left over from the previous set:

		if (is_multicast_ether_addr(bmc_mac))
			mac_addr = __fbnic_mc_sync(fbd, bmc_mac);
		else
			mac_addr = &fbd->mac_addr[i++];

The same happens if a disable and a re-enable with different MACs both
arrive before one service pass. The new disable branch is skipped in
that case.

Would the MACs the BMC no longer reports stay BMC-tagged and valid? Act
rule 0 would keep steering their Rx traffic to the BMC, and
fbnic_write_tce_tcam() would keep looping host Tx for them to the BMC.

> +
> +		/* Neither path touches the RSS actions, which carry the mc/bc
> +		 * copy to the BMC, so recompute them alongside.
> +		 */
> +		fbnic_rss_reinit(fbd, fbn);
>  		netif_addr_lock_bh(fbd->netdev);
>  		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
>  		netif_addr_unlock_bh(fbd->netdev);

[Severity: Medium]

This isn't a bug introduced by this patch, but can this pass run after
the interface has been brought down?

fbnic_service_task_stop() uses the non-sync cancel:

	cancel_delayed_work(&fbd->service_task);

A service task that has already started and is waiting in rtnl_lock()
while fbnic_stop() runs will carry on afterwards. The other
fbnic_rss_reinit() callers check netif_running(), but this path does
not:

drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c:fbnic_set_rss_hash_opts() {
    ...
	if (netif_running(fbn->netdev)) {
		fbnic_rss_reinit(fbn->fbd, fbn);
		fbnic_write_rules(fbn->fbd);
	}
    ...
}

By that point fbnic_down_noidle() has demoted the host entries to UPDATE,
and fbnic_disable() has shut down the host queues. If TCAM_REINIT is
pending, __fbnic_set_rx_mode() writes the host RSS actions and MACDA
entries back to hardware. Host traffic is then steered to disabled Rx
queues until the next open/close.

The hole existed before this patch, because __fbnic_set_rx_mode() on
this path already rewrote the demoted entries. The added
fbnic_rss_reinit() now also writes the host-unicast entries when the BMC
has just become present.

Should fbnic_bmc_rpc_check() return early when the netdev is not
running?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179061185153.414394.13396934246780284806.stgit%40ahduyck-xeon-server.home.arpa
