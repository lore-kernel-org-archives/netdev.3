Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867C3E008F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020651; cv=none; b=F/kOhbExFdj+C6h1qrUbgzn99TAtblHE3uUsr/upGH+M6EOl0hrGeTvb0qAi4Ay+RMGw9Ii9c1/4m9blFE2IZBGh/CEGZgg9BsNQ6Li9pNqM0lZHDtvfwXsGhK+MCA4CKFzckxOOsUJBnuuGyVOmDDCvOYnzm6A4Qbp8y4m/HvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020651; c=relaxed/simple;
	bh=0kgQXZLk6OBjqApNG/AsuvvJpZWogz4VJz6OhXVkSyI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbIhoEOJ7Kl8Z2mJNor/GjvOUoZ5KyAgaUvuk3FT4+im3daqhfOGGvZZTAhELRoAuoZcBpE+ORMulFuiTadeRnke+Onvma3TbvMNKi/3VFiRjS756O6m3rExLA7MNoxJOgd+fsmuyCUegRk2VzAPJo/XfKmjxyxh/p70+sbSYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isMpGoc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isMpGoc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1438C1F00899;
	Mon, 21 Sep 2026 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020648;
	bh=T7mLTM7mRArf6T5qHbZO96GqNJyg1IhoCLzy4oIM77U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=isMpGoc1Q7MF1J0b6Y5Gxc5mV4NQs6O+9WA9KKIA12TiTSkjTIiFYtoMXmC+h9z+J
	 /lIbiygILQDEBBFU2vossHjXJOP/SxChIUx0MfluaAAQHUn2BUH3pKpry5ORCRPVaP
	 G0m5hRVpW7admfXs+Vt/7dFkkd/dyqnTUEnOlXKZNJO8WX8wDXVJbmMPzcnXde3lO5
	 WZIxpJsfHweFWsYjkkXCLBt5U6CIRWNLFe0cw9SrTBzcGUQnJ5fcK4elwLX1TK46gb
	 O9P7dS8++uNkQXPFAKX42w/PPG9P7ERoQVCEuTYrXzA4a2ahAuj97FVsmoEqR0i7X0
	 4S/Q3jepoSSeg==
Subject: Re: [PATCH net-next v2 12/12] ice: use ACL for ntuple rules that
 conflict with FDir
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:27 +0000
Message-ID: <179002064764.2160803.13065389876778124107@kernel.org>
In-Reply-To: <20260917183927.2692068-13-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-13-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice_fdir_has_input_set_conflict()
  (drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c:1543) reports a…
- [High] The new conflict check dereferences a possibly-NULL aRFS counter
  block.
- [Medium] Conflict-routed rules that carry FLOW_EXT are rejected by the
  ACL path with -EINVAL even when they contain no flex match, because…
- [Medium] ice_fdir_has_input_set_conflict() makes the FDir-vs-ACL
  routing decision from state that can change before the decision is…
- [Low] Claimed regression: the new `if (userdata.flex_fltr) return
  -EOPNOTSUPP;` block in ice_add_ntuple_ethtool() sits inside the…
- [Low] The two new messages in the ACL branch of
  ice_add_ntuple_ethtool() describe an offload that may never occur.
- [Low] ice_fdir_has_input_set_conflict() documents `false` as "can use
  FD" and ice_add_ntuple_ethtool() consumes it as permission to skip the…
- [Low] Documentation/networking/device_drivers/ethernet/intel/ice.rst
  (lines 326-345) still states unconditionally that "For each flow-type,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new input-
  set-dependent backend selection makes it reachable for full-mask…

--

ice: use ACL for ntuple rules that conflict with FDir

This adds a pre-check that builds the candidate IP flow segment for an
ethtool ntuple rule, compares it against the active non-tunneled Flow
Director profile, and routes the rule to ACL when the input sets differ.
The IP flow segment setup is factored out into ice_set_fdir_ip_flow_seg()
so both the extraction-sequence path and the new check can use it.

A few questions below about the new helper and the ACL dispatch.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index fef8640d23fb6..691b4500e6be6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -1484,6 +1484,120 @@ ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
>  	return 0;
>  }
>  
> +/**
> + * ice_set_fdir_ip_flow_seg - set IP flow segment based on ethtool flow type
> + * @fsp: pointer to ethtool Rx flow specification
> + * @seg: flow segment for programming
> + * @perfect_fltr: valid on success; returns true if perfect fltr, false if not
> + *
> + * Return: 0 on success and errno in case of error.
> + */
> +static int ice_set_fdir_ip_flow_seg(struct ethtool_rx_flow_spec *fsp,
> +				    struct ice_flow_seg_info *seg,
> +				    bool *perfect_fltr)
> +{
> +	switch (fsp->flow_type & ~FLOW_EXT) {

[ ... ]

> +	case TCP_V6_FLOW:
> +		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
> +					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
> +	case UDP_V6_FLOW:
> +		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
> +					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
> +	case SCTP_V6_FLOW:
> +		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
> +					    ICE_FLOW_SEG_HDR_SCTP,
> +					    perfect_fltr);
> +	case IPV6_USER_FLOW:
> +		return ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
> +						perfect_fltr);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

[ ... ]

> +static bool
> +ice_fdir_has_input_set_conflict(struct ice_pf *pf,
> +				struct ethtool_rx_flow_spec *fsp,
> +				const struct ice_rx_flow_userdef *user)
> +{
> +	struct ice_flow_seg_info *test_seg, *old_seg;
> +	bool perfect_fltr = false, conflict = false;
> +	struct ice_fd_hw_prof *hw_prof;
> +	struct ice_hw *hw = &pf->hw;
> +	enum ice_fltr_ptype flow;
> +	int err;
> +
> +	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW)
> +		return false;

[Severity: High]
This gate excludes only ETHER_FLOW, and ice_set_fdir_ip_flow_seg() above
happily builds segments for TCP_V6_FLOW, UDP_V6_FLOW, SCTP_V6_FLOW and
IPV6_USER_FLOW, so a true verdict can be produced for IPv6 rules.

The only consumer of a true verdict is ice_acl_add_rule_ethtool(), which
starts with ice_acl_prof_add_ethtool().  Can ACL program IPv6 flow types
at all?

drivers/net/ethernet/intel/ice/ice_acl_main.c:ice_acl_prof_add_ethtool() {
	switch (fsp->flow_type & ~FLOW_EXT) {
	case TCP_V4_FLOW:
	...
	case IPV4_USER_FLOW:
	...
	default:
		err = -EOPNOTSUPP;
	}
}

With this sequence on an ACL-capable device:

  ethtool -U ethX flow-type tcp6 src-ip A dst-ip B src-port P dst-port Q action 1
  ethtool -U ethX flow-type tcp6 src-ip C action 2

the second rule has a full mask, so ice_is_acl_filter() returns false (it
only inspects the IPv4 specs), while ice_fdir_has_input_set_conflict()
returns true.  Does the rule then end up in ice_acl_prof_add_ethtool()'s
default case and get rejected with -EOPNOTSUPP, instead of being offloaded?

If so, the descriptive rejection that used to come from
ice_fdir_set_hw_fltr_rule():

	dev_err(dev, "Failed to add filter. Flow director filters on each port must have the same input set.\n");
	return -EINVAL;

is no longer reached for these rules.  Since the new gate only tests
pf->hw.acl_tbl (ACL block present) and never "ACL can offload this flow
type", should the conflict detection be restricted to the flow types
ice_acl_prof_add_ethtool() supports?

> +
> +	flow = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
> +	if (flow >= ICE_FLTR_PTYPE_MAX || !hw->fdir_prof ||
> +	    !hw->fdir_prof[flow]) {
> +		return false;
> +	}
> +
> +	hw_prof = hw->fdir_prof[flow];
> +	old_seg = hw_prof->fdir_seg[ICE_FD_HW_SEG_NON_TUN];
> +
> +	/* A profile with no ethtool FDir filters (fdir_fltr_cnt == 0) may
> +	 * still be locked by aRFS perfect (4-tuple) filters, which keep their
> +	 * own active counters separate from fdir_fltr_cnt.
> +	 */
> +	if (!old_seg || (hw->fdir_fltr_cnt[flow] == 0 &&
> +			 !ice_is_arfs_using_perfect_flow(hw, flow)))
> +		return false;

[Severity: High]
Can ice_is_arfs_using_perfect_flow() be called here with
vsi->arfs_fltr_cntrs still NULL?

With CONFIG_RFS_ACCEL=y it dereferences the counter block without a NULL
check:

drivers/net/ethernet/intel/ice/ice_arfs.c:ice_is_arfs_using_perfect_flow() {
	arfs_fltr_cntrs = vsi->arfs_fltr_cntrs;

	/* active counters can be updated by multiple CPUs */
	smp_mb__before_atomic();
	switch (flow_type) {
	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
		return atomic_read(&arfs_fltr_cntrs->active_udpv4_cnt) > 0;
	...
}

ice_set_features() enables Flow Director and ACL before the fallible aRFS
setup:

drivers/net/ethernet/intel/ice/ice_main.c:ice_set_features() {
	ice_vsi_manage_fdir(vsi, ena);
	ice_vsi_manage_acl(vsi, ena);
	ena ? ice_init_arfs(vsi) : ice_clear_arfs(vsi);
}

and ice_init_arfs() swallows the allocation failure:

drivers/net/ethernet/intel/ice/ice_arfs.c:ice_init_arfs() {
	if (ice_init_arfs_cntrs(vsi))
		goto free_arfs_fltr_list;
	...
}

so after "ethtool -K ethX ntuple on" with a failing allocation,
ICE_FLAG_FD_ENA is set, ice_fdir_create_dflt_rules() has already installed
the default perfect tcp4/udp4/tcp6/udp6 profiles, and
vsi->arfs_fltr_cntrs is NULL.  A following "ethtool -U ethX flow-type
tcp4 ..." on a device with hw->acl_tbl set reaches this check with
old_seg != NULL and hw->fdir_fltr_cnt[flow] == 0.  Does that oops inside
atomic_read()?

The missing NULL check in ice_is_arfs_using_perfect_flow() predates this
patch, but previously ice_fdir_set_hw_fltr_rule() compared the segments
first and returned -EEXIST without consulting the aRFS counters, so rules
whose input set matches the existing profile never touched them.  Does
this new call site widen that exposure to the common case?

[Severity: Medium]
Is the state read here stable until it is acted upon?

hw->fdir_prof[flow], hw_prof->fdir_seg[ICE_FD_HW_SEG_NON_TUN],
hw->fdir_fltr_cnt[flow] and the aRFS atomics are all read without
hw->fdir_fltr_lock; ice_add_ntuple_ethtool() takes that mutex only later,
after ice_cfg_fdir_xtrct_seq() has already programmed the profile.  The
aRFS counters are written from contexts that are not serialized against
the ethtool ioctl:

ice_service_task()
  ice_sync_arfs_fltrs()
    ice_arfs_add_flow_rules()
      ice_arfs_update_active_fltr_cntrs()

and also from ice_rx_flow_steer().

So:

CPU0 (ethtool -U)
  ice_fdir_has_input_set_conflict()
    hw->fdir_fltr_cnt[flow] == 0
    aRFS tcpv4 counter == 0  -> returns false, take the FDir path

CPU1 (service task)
  ice_arfs_add_flow_rules()
    ice_arfs_update_active_fltr_cntrs()  -> counter becomes 1

CPU0 continues into ice_fdir_set_hw_fltr_rule(), which re-reads the same
state:

		if (ice_is_arfs_using_perfect_flow(hw, flow)) {
			dev_err(dev, "aRFS using perfect flow type %d, cannot change input set\n",
				flow);
			return -EINVAL;
		}

Can that produce the -EINVAL this patch is meant to avoid, with no ACL
fallback left at that point?  The mirror ordering would route to ACL a
rule Flow Director could have taken.

> +
> +	test_seg = kzalloc_obj(*test_seg);
> +	if (!test_seg)
> +		return false;

[Severity: Low]
The kernel-doc for this helper documents false as "can use FD", and
ice_add_ntuple_ethtool() treats false as permission to skip the ACL
branch.  Here false also means "the comparison could not be performed".

On this allocation failure the rule goes down the Flow Director path and
ice_fdir_set_hw_fltr_rule() rejects the differing input set:

		if (hw->fdir_fltr_cnt[flow]) {
			dev_err(dev, "Failed to add filter. Flow director filters on each port must have the same input set.\n");
			return -EINVAL;
		}

Should this report -ENOMEM (or still take the ACL route) rather than
returning the value that means no conflict?

The other early false path, ice_set_fdir_ip_flow_seg() returning an error,
looks benign since the FDir path re-runs the same builder and produces the
same errno.

> +
> +	err = ice_set_fdir_ip_flow_seg(fsp, test_seg, &perfect_fltr);
> +
> +	if (err) {
> +		kfree(test_seg);
> +		return false;
> +	}
> +
> +	if (user && user->flex_fltr)
> +		ice_flow_add_fld_raw(test_seg, user->flex_offset,
> +				     ICE_FLTR_PRGM_FLEX_WORD_SIZE,
> +				     ICE_FLOW_FLD_OFF_INVAL,
> +				     ICE_FLOW_FLD_OFF_INVAL);
> +
> +	/* Compare the test segment with the existing segment */
> +	if (memcmp(old_seg, test_seg, sizeof(*test_seg)) != 0)
> +		conflict = true;
> +
> +	kfree(test_seg);
> +
> +	return conflict;
> +}
> +
>  /**
>   * ice_cfg_fdir_xtrct_seq - Configure extraction sequence for the given filter
>   * @pf: PF structure

[ ... ]

> @@ -2368,9 +2441,27 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  		return -ENOSPC;
>  	}
>  
> -	/* ACL filter */
> -	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
> +	/* ACL filter, or this filter would cause an input set conflict with
> +	 * existing FD filters
> +	 */
> +	if (pf->hw.acl_tbl &&
> +	    (ice_is_acl_filter(fsp) ||
> +	     ice_fdir_has_input_set_conflict(pf, fsp, &userdata))) {
> +		/* The ACL programming path does not honor flex byte
> +		 * (user-def) constraints. Routing a flex filter to ACL would
> +		 * silently drop the flex match and offload a much broader
> +		 * rule than requested, so reject it explicitly instead.
> +		 */
> +		if (userdata.flex_fltr) {
> +			dev_info(dev, "Failed to add filter. Flex byte (user-def) filters cannot be offloaded to ACL.\n");
> +			return -EOPNOTSUPP;
> +		}

[Severity: Low]
This new rejection sits inside the combined condition, so it also applies
to the pre-existing partial-mask ACL route selected by
ice_is_acl_filter().

Such rules already failed before this patch, just with a different errno:
flex_fltr requires FLOW_EXT (ice_parse_rx_flow_user_data() returns early
when !(fsp->flow_type & FLOW_EXT)), and the ACL decoder strips only
FLOW_MAC_EXT:

drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c:ice_ntuple_set_input_set() {
	else if (blk == ICE_BLK_ACL)
		flow_mask = FLOW_MAC_EXT;
	...
	flow_type = fsp->flow_type & ~flow_mask;
	...
	switch (flow_type) {
	...
	default:
		return -EINVAL;
	}
}

So a command like

  ethtool -U ethX flow-type tcp4 src-ip A m 0.255.255.255 ... user-def 0x4ffff

returned -EINVAL before and returns -EOPNOTSUPP now.  Would it be worth
mentioning that user-visible errno change in the changelog, since it is
not a consequence of the conflict detection being added?

> +
> +		dev_dbg(dev, "ntuple filter at location %d offloaded to ACL instead of Flow Director\n",
> +			fsp->location);

[Severity: Low]
This message is printed before ice_acl_add_rule_ethtool() is called, so it
claims an offload that may never happen.  For flow types that
ice_acl_prof_add_ethtool() rejects:

drivers/net/ethernet/intel/ice/ice_acl_main.c:ice_acl_prof_add_ethtool() {
	default:
		err = -EOPNOTSUPP;
}

the log says the rule was offloaded to ACL while the command failed.
Should it be emitted only after ice_acl_add_rule_ethtool() succeeds?

Similarly, the dev_info above attributes the failure to an ACL flex byte
limitation even for tcp6/udp6/sctp6/ip6, where ACL cannot take the rule at
all and the real blocker is the Flow Director input set conflict.

> +
>  		return ice_acl_add_rule_ethtool(vsi, cmd);
> +	}

[Severity: Medium]
Is FLOW_EXT normalized consistently between the new selector and the ACL
destination?

ice_fdir_has_input_set_conflict() and ice_acl_prof_add_ethtool() both mask
with & ~FLOW_EXT, but ice_ntuple_set_input_set() uses FLOW_MAC_EXT for
ICE_BLK_ACL, so FLOW_EXT survives into its switch and hits
default: return -EINVAL.

A command that sets FLOW_EXT without any flex match, for example

  ethtool -U ethX flow-type tcp4 src-ip C vlan 0x1 m 0xffff action 2

against an existing conflicting tcp4 FDir profile, leaves flex_fltr false
(m_ext.data is zero), so it passes the check above and is routed to ACL,
where it fails with -EINVAL.

By that point ice_acl_prof_add_ethtool() has already created and
programmed a profile for the flow type:

	hw->acl_prof[fltr_type] = hw_prof;

Does the failed command leave that profile registered, so later ACL rules
for the same flow type with a different input set fail the
if (hw_prof->seg) memcmp check?

[Severity: High]
This isn't a bug introduced by this patch, but the new input-set-dependent
backend selection makes it reachable for full-mask rules: replacing an
ACL-backed ntuple rule with an FDir-backed rule at the same location looks
like it leaves the old ACL TCAM entry programmed.

The only ACL hardware removal in ice_ntuple_update_list_entry() is gated
on the replacement pointer being NULL:

drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c:ice_ntuple_update_list_entry() {
	if (old_fltr->acl_fltr) {
		...
		if (!input) {
			err = ice_del_acl_ethtool(hw, old_fltr);
			if (err)
				return err;
		}
	}
	...
	list_del(&old_fltr->fltr_node);
	kfree(old_fltr);
}

which holds only for ice_acl_add_rule_ethtool() replacing ACL with ACL.
The Flow Director path afterwards calls ice_fdir_write_all_fltr(), which
does not touch the ACL table.

Sequence:

  1. add an FDir rule matching src-ip
  2. add a full-mask dst-ip rule at location L; the new conflict check
     routes it to ACL
  3. re-add at location L a src-ip rule compatible with the active FDir
     profile; it now takes the FDir path

Does the ACL entry for the dst-ip match survive step 3 with no software
record, so it keeps dropping or steering matching packets and is invisible
to ethtool -u?

[Severity: Low]
Should Documentation/networking/device_drivers/ethernet/intel/ice.rst be
updated along with this?  The Flow Director Filters notes still say
unconditionally:

  For each flow-type, the programmed filters must all have the same
  matching input set.

and the example there, showing

  ethtool -U ethX flow-type ip4 src-ip 192.168.0.1 src-port 5300 action 7
  ethtool -U ethX flow-type ip4 dst-ip 192.168.0.5 src-port 55 action 10

"will fail with an error", plus "on one device, you may not program two
tcp4 filters with different matching fields".  On an ACL-capable device
that second rule now succeeds through ACL.  The new flex byte limitation
is also undocumented.

>  
>  	/* Only fdir filters below */
>  	if (!test_bit(ICE_FLAG_FD_ENA, pf->flags))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
