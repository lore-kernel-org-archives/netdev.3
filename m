Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B138758D
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760734; cv=none; b=WTt/++fwGwVRNmXYX2LsigkSILYlb7tbuzA67ZrfNjeAmCZbWTcw04t0QbSG/YiPyAZmGMjHmZymL7AjCjm+BwOA1me5H+GT8ZIrg4ypl3DcyznZi9saYOKQJcedTdnz5eFc2UA0NMARufblcYf/cu9zRDo+xMrs5UIH2R/siew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760734; c=relaxed/simple;
	bh=lvZ4iG1gLymkV473lXOR4e156g0S9Hdjkbp+tj+Mb7c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X58AUBd36tayC9UOirlvBx5bGPpjD0G2qaw2CKEz6u9ZNo6CsRvLvp/6gFYLH1zYYwA2rN8sRL2IDj6ZaGR1F9EdjynlQIGsyz2ebIJTj46fO3KtqGDYUzbsUQf0GJH7dhgAnXVMKAfbBqfPNtc7lWb1DxLS08RM/3BK/wDAbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1UmDmXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1UmDmXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1189F1F00A3D;
	Mon,  7 Sep 2026 05:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760732;
	bh=uGf5tDK5YhXUhyqxdRSQJv/rbRu/K65lzvqikpRmfAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=A1UmDmXUcifK+ssUdm0S/VWpJbXiM6fmvlj/1oY3NYt++w/Y558kFhV47HaGKC8D9
	 QY89fKqnnPbZOX2EQY9kWHgO5RBLY/l/F37o2kcKwhvAaxM5ztMmFKJ7Ur24a9w9Dd
	 E+Nl8C6Uv4B0NA9e5z5c+nYgKVgBzn8XO6t+Fq77JFCVpFPESP+0BNFz9oDH4Tm+uD
	 onFtYQDOEZ/5p+2gyrEeKuvp0kzSL4tdri6IYyJqdRUH2mAKODSlgffhMKxswOrHQu
	 GFXuBCFoijzagPHVFeJexKfoc7rLsh2i+Hu9iRc4XOUNjVCCqiUf2VbDZZkqr3vRRH
	 swSZDxpfvA0TA==
Subject: Re: [net-next PATCH 2/2] fbnic: Remove BMC routing rules when the BMC
 channel is disabled
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 horms@kernel.org
Date: Mon, 07 Sep 2026 05:58:51 +0000
Message-ID: <178876073164.219967.6978528899000855726@kernel.org>
In-Reply-To:
 <178845828588.2787.8575380594560953372.stgit@ahduyck-xeon-server.home.arpa>
References:
 <178845828588.2787.8575380594560953372.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 3

- [High] fbnic_bmc_rpc_check() relies on fbnic_rss_reinit() to converge
  the action TCAM to the "no BMC" layout, but fbnic_rss_reinit()…
- [High] The new teardown clears the DEST_BMC copy bit from the XCAST
  (broadcast/multicast) RSS action entries by calling fbnic_rss_reinit()…
- [Medium] The new branch in fbnic_bmc_rpc_check() reads
  fbd->fw_cap.bmc_present, then performs a destructive multi-step…
- [Medium] The new BMC-disable path mutates the shared filter shadow
  tables and pushes them to hardware while holding only RTNL:…
- [Low] The new kernel-doc on fbnic_bmc_rpc_disable()
  (drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:276-279) claims: "Clear…
- [Low] The commit repairs a live, user-visible packet-steering defect
  (BMC filters and the DEST_BMC action left programmed after the BMC…
- [Low] fbnic_bmc_rpc_disable()
  (drivers/net/ethernet/meta/fbnic/fbnic_rpc.c:281) marks the BMC action…

--

fbnic: Remove BMC routing rules when the BMC channel is disabled

The patch adds a teardown path to fbnic_bmc_rpc_check() that removes the
BMC MACDA entries and the BMC action rule when fw_cap.bmc_present has
dropped while BMC tagged rules are still programmed. It then re-runs
fbnic_rss_reinit() and pushes the filters to hardware via
__fbnic_set_rx_mode().

A few questions below.

[Severity: Low]
Should this carry a Fixes: tag?

The behaviour being repaired is reachable on any tree containing
04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables
channel"), which added the runtime reconciliation in fbnic_bmc_rpc_check()
but only handled the enable direction. fbnic_fw_parse_cap_resp() clears
fw_cap.bmc_present and unconditionally sets fw_cap.need_bmc_tcam_reinit, and
the pre-patch fbnic_bmc_rpc_check() then calls fbnic_bmc_rpc_init(), which
returns immediately on !fbnic_bmc_present(fbd) and removes nothing.

Without the tag stable backporters have no way to tell which releases are
affected.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index bc0f38b6a2b2b..8e53428e35a64 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> @@ -238,10 +238,91 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
>  	act_tcam->state = FBNIC_TCAM_S_UPDATE;
>  }
>  
> +/**
> + * fbnic_bmc_rules_present - is the BMC currently programmed into the filters?
> + * @fbd: Pointer to fbnic device struct
> + *
> + * The BMC tag is only ever set on a MACDA entry while a BMC is present, so its
> + * presence tells us the BMC routing rules are in place without having to keep a
> + * separate state flag.
> + *
> + * Return: true if any MACDA entry carries the BMC tag, false otherwise.
> + */
> +static bool fbnic_bmc_rules_present(struct fbnic_dev *fbd)
> +{
> +	int idx;
> +
> +	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
> +		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
> +
> +		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
> +			continue;
> +
> +		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
> + * @fbd: Pointer to fbnic device struct
> + *
> + * Undo fbnic_bmc_rpc_init(). The BMC can disable its NC-SI channel while the
> + * host interface stays up; when it does its routing rules must be torn down so
> + * we stop directing traffic to a BMC that is no longer there.
> + *
> + * Clear the MAC entries before the action rule. The action rule matches on a
> + * MAC entry index, so removing the entries first ensures the rule is never left
> + * pointing at an entry that is already gone. The hardware is updated by the
> + * __fbnic_set_rx_mode() call that follows this one.
> + */

[Severity: Low]
Is the ordering guarantee described here actually provided?

fbnic_bmc_rpc_disable() performs no register access. It only mutates
fbd->mac_addr[].act_tcam/state through __fbnic_xc_unsync() and
fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET].state, so the order in which it
touches the shadow copies is invisible to hardware.

The hardware order is fixed by the writer the comment names,
__fbnic_set_rx_mode(), whose tail is:

	fbnic_write_rules(fbd);
	fbnic_write_macda(fbd);
	fbnic_write_tce_tcam(fbd);

That programs the action rules before the MACDA entries, which is the
opposite of what the comment says is being established. Could this part of
the kernel-doc be dropped or reworded?

> +static void fbnic_bmc_rpc_disable(struct fbnic_dev *fbd)
> +{
> +	struct fbnic_act_tcam *act_tcam;
> +	int idx;
> +
> +	/* Drop the BMC's claim on each MAC entry. An entry used only by the BMC
> +	 * is deleted; one also used by the host is left in place.
> +	 */
> +	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
> +		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
> +
> +		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
> +			continue;
> +
> +		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_BMC);
> +	}
> +
> +	/* Then remove the action rule that steered traffic to the BMC. */
> +	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET];
> +	if (act_tcam->state == FBNIC_TCAM_S_VALID)
> +		act_tcam->state = FBNIC_TCAM_S_DELETE;

[Severity: Low]
Can this leak act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET] when the entry is in
the FBNIC_TCAM_S_UPDATE state?

The MACDA loop just above handles every state except
FBNIC_TCAM_S_DISABLED, but the action rule is only handled when the state is
exactly FBNIC_TCAM_S_VALID. FBNIC_TCAM_S_UPDATE (same value as
FBNIC_TCAM_S_ADD) is a normal state for that entry: fbnic_bmc_rpc_init()
leaves it as

	act_tcam->state = FBNIC_TCAM_S_UPDATE;

and fbnic_clear_rules()/fbnic_clear_valid_act_tcam() demote it from VALID
back to UPDATE on interface down.

If the disable path runs with the entry at UPDATE, the guard is false, the
rule is never marked DELETE, and the following __fbnic_set_rx_mode() ->
fbnic_write_rules() takes the fbnic_update_act_tcam() branch and programs
the DEST_BMC rule into hardware as VALID.

Since fbnic_bmc_rules_present() keys only off the MACDA
FBNIC_MAC_ADDR_T_BMC tag, which the loop above has just cleared, the disable
path can never fire again for that entry.

Would setting state = FBNIC_TCAM_S_DELETE for any state other than
FBNIC_TCAM_S_DISABLED make this symmetric with the MACDA loop?

> +}
> +
>  void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
>  {
>  	int err;
>  
> +	/* The BMC went away while its rules are still programmed; remove them
> +	 * now instead of waiting until the interface goes down. The enable
> +	 * direction is handled by the need_bmc_tcam_reinit path below.
> +	 */
> +	if (!fbnic_bmc_present(fbd) && fbnic_bmc_rules_present(fbd)) {
> +		struct fbnic_net *fbn = netdev_priv(fbd->netdev);
> +
> +		fbnic_bmc_rpc_disable(fbd);
> +		/* Recompute the RSS actions so the multicast/broadcast copies
> +		 * to the now absent BMC are cleared as well.
> +		 */
> +		fbnic_rss_reinit(fbd, fbn);

[Severity: High]
Can fbnic_rss_reinit() actually converge the action table to the no-BMC
layout here?

Its loop skips the unicast half entirely once the BMC is gone:

	for (i = fbnic_bmc_present(fbd) ? 0 : FBNIC_RSS_EN_NUM_UNICAST;
	     i < FBNIC_RSS_EN_NUM_ENTRIES; i++) {

So the FBNIC_RSS_EN_NUM_UNICAST host-unicast RSS action entries at
act_tcam[FBNIC_RPC_ACT_TBL_RSS_OFFSET ...] that were programmed while the
BMC was present are neither rewritten nor marked FBNIC_TCAM_S_DELETE. They
stay at FBNIC_TCAM_S_VALID, and fbnic_write_rules() only touches entries
that have the UPDATE bit:

	if (!(act_tcam->state & FBNIC_TCAM_S_UPDATE))
		continue;

VALID is 1 and UPDATE is 2, so those entries are skipped and remain armed in
hardware. They sit at lower action TCAM indices than the wildcard xcast set,
so they still win the match for host unicast traffic (MACDA index
mac_addr_boundary and above), yet every later fbnic_rss_reinit() while the
BMC stays absent keeps skipping them.

Does that mean an `ethtool -N ethX rx-flow-hash ...` request, an
RXH_DISCARD request via fbnic_set_rss_hash_opts(), and an rx_filter change
via fbnic_hwtstamp_set() silently do not take effect for host unicast
traffic after a BMC channel disable, until the interface is bounced?

Since fbnic_rss_reinit() can only add entries and never mark them DELETE,
would this path need to explicitly set state = FBNIC_TCAM_S_DELETE on
act_tcam[FBNIC_RPC_ACT_TBL_RSS_OFFSET .. + FBNIC_RSS_EN_NUM_UNICAST - 1]?

[Severity: Medium]
Which lock protects fbd->act_tcam[] and the FBNIC_RPC_TCAM_ACT registers
here?

fbnic_service_task() takes rtnl_lock() around fbnic_bmc_rpc_check() but not
netdev_lock(). The userspace RSS path is serialized by the per-netdevice
operations lock instead: fbnic sets netdev->queue_mgmt_ops so
netdev_need_ops_lock() is true, and fbnic_ethtool_ops.op_needs_rtnl does not
include ETHTOOL_OP_NEEDS_RTNL_RSS, so __dev_ethtool() computes need_rtnl ==
false for ETHTOOL_SRXFH/ETHTOOL_SRSSH and reaches:

fbnic_ethtool.c:fbnic_set_rss_hash_opts() {
	if (netif_running(fbn->netdev)) {
		fbnic_rss_reinit(fbn->fbd, fbn);
		fbnic_write_rules(fbn->fbd);
	}
}

with only netdev_lock_ops(dev) held. RTNL and the ops lock do not exclude
each other.

Can the two contexts then run fbnic_rss_reinit() and fbnic_write_rules() on
the same act_tcam[] entries concurrently? fbnic_update_act_tcam() writes
ACT_TBL0/ACT_TBL1, then the TCAM words, then the validate word, so an
interleave looks like it could leave a rule built from two different
configurations, plus lost UPDATE/VALID/DELETE transitions in the shadow copy.

The pre-existing branch already called __fbnic_set_rx_mode() under RTNL
only; this patch newly adds mutation of the RSS action entries that the
ethtool path owns. Should the teardown plus flush run under netdev_lock,
the same lock as the ethtool writers?

> +		netif_addr_lock_bh(fbd->netdev);
> +		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
> +		netif_addr_unlock_bh(fbd->netdev);
> +		fbd->fw_cap.need_bmc_tcam_reinit = false;

[Severity: Medium]
Can this clear of need_bmc_tcam_reinit swallow a reinit request posted
during the teardown?

fbnic_bmc_rpc_check() runs from fbnic_service_task() under rtnl_lock()
only, while fbnic_fw_parse_cap_resp() runs from the firmware mailbox
threaded IRQ and takes neither rtnl nor any lock shared with the service
task:

fbnic_fw.c:fbnic_fw_parse_cap_resp() {
	fbd->fw_cap.bmc_present = bmc_present;
	...
	/* Always assume we need a BMC reinit */
	fbd->fw_cap.need_bmc_tcam_reinit = true;
}

After the branch condition has evaluated !bmc_present as true, the IRQ
thread can set bmc_present and need_bmc_tcam_reinit while the teardown is
still in progress. The teardown window spans the full fbnic_write_rules()
and fbnic_write_macda() loops, so it is not narrow.

In that interleaving:

  - fbnic_bmc_rpc_disable() strips FBNIC_MAC_ADDR_T_BMC from every MACDA
    entry and marks act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET] for deletion
  - fbnic_rss_reinit() re-reads fbnic_bmc_present(fbd), now true, and
    re-arms the DEST_BMC copies on the xcast actions
  - __fbnic_set_rx_mode() -> fbnic_bmc_rpc_all_multi_config() likewise
    re-arms the BMC all-multi rule
  - the line above then discards the reinit request

Does that leave a filter set advertising BMC destinations while the BMC's
unicast MACDA entries and its steering rule have been deleted, with nothing
scheduling a repair until the next firmware capability event?

Separately, bmc_present, need_bmc_tcam_reinit, need_bmc_macda_sync and
all_multi are 1-bit bitfields packed into the same byte of struct
fbnic_fw_cap:

fbnic_fw.h:
	u8	bmc_present		: 1;
	u8	need_bmc_tcam_reinit	: 1;
	u8	need_bmc_macda_sync	: 1;
	u8	all_multi		: 1;

so this store is a read-modify-write of that byte. Can it drop a concurrent
`bmc_present = true` store from the IRQ thread?

> +	}
> +
>  	if (fbd->fw_cap.need_bmc_tcam_reinit) {
>  		fbnic_bmc_rpc_init(fbd);
>  		netif_addr_lock_bh(fbd->netdev);

[Severity: High]
Does anything restore the DEST_BMC copy bit when the BMC re-enables its
channel?

Broadcast and host-shared multicast delivery to the BMC is programmed only
in fbnic_rss_reinit():

	if (i >= FBNIC_RSS_EN_NUM_UNICAST && fbnic_bmc_present(fbd))
		dest |= FIELD_PREP(FBNIC_RPC_ACT_TBL0_DEST_MASK,
				   FBNIC_RPC_ACT_TBL0_DEST_BMC);

The re-enable branch here runs fbnic_bmc_rpc_init() + __fbnic_set_rx_mode()
only, and neither touches the xcast RSS entries. fbnic_rss_reinit() has no
other call site on that path; its callers are __fbnic_open(),
fbnic_hwtstamp_set(), fbnic_set_rss_hash_opts() and the new code above.

The action rule restored by fbnic_bmc_rpc_init() cannot cover broadcast
either, since it matches only MACDA indices 0-3:

	act_tcam->value.tcam[1] = FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;
	act_tcam->mask.tcam[1] = 0xffff &
			~FIELD_PREP(FBNIC_RPC_TCAM_ACT1_L2_MACDA_IDX, 0x1c) &
			~FBNIC_RPC_TCAM_ACT1_L2_MACDA_VALID;

while broadcast lives at FBNIC_RPC_TCAM_MACDA_BROADCAST_IDX, and the BMC
all-multi rule matches only MACDA index mac_addr_boundary - 1 and only when
fw_cap.all_multi is set.

So after a disable/re-enable cycle the xcast entries stay
FBNIC_TCAM_S_VALID with dest = DEST_HOST. Does that mean the BMC
permanently stops receiving broadcast (ARP, for example) and shared
multicast until the host interface is bounced?

Before this patch the DEST_BMC bits were never cleared while the interface
was up, so a BMC channel bounce kept working. Commit 04a230b27d8f describes
channel flapping as an expected scenario, so should the enable branch call
fbnic_rss_reinit() as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/178845766796.2787.6001399537275460493.stgit%40ahduyck-xeon-server.home.arpa
