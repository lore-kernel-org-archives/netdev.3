Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8935B125
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729911; cv=none; b=Mm8OPD2pzk0RduaHZxG3j1CYPb/mgtUhZjnS7YSYSejPhJQrYfAW/hUHIbXTxBfcdomurv9V3nLObRm7+LL+3lQsdOhiSczj2bM3YLwadVUHE98wPukQa34ZDqV20HZxmzErHbXr6+LGvslwPDMpqOaqUG1rOvNA7CcBqkDvzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729911; c=relaxed/simple;
	bh=g8uQKXvKj9aJwHGrU7uhwYNCgan36E6qtjnu7CyWNTE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dY9ehDuRVTM/ZXhV1Otfi7J7dHcEh2iDiTfhDt+tONNgc3uUjjkNqyqFi/6ZpY53D7CmFwU5F4PGCJqR7CltmN3t8vwu7YOTne3LNpSmoSUAQiTuJMVyb8CzOO/DqK9dzfXvm5pRPV18BWPjqzUF+tPSqgtE/Aq85LWVgXzNK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwIzZe1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwIzZe1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C0A1F00898;
	Wed, 30 Sep 2026 00:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729910;
	bh=t2giTg3lC9xTj6IB4rCZXwhIAQTh4WM7iZopf6jYEPY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KwIzZe1YUmj7LQQqX3GR+K7J0mGiTnwFmxyJBhJzxiyojDYe6qFq4wxJyDI+jmzQq
	 qJMV7wDffKhVF4yvBhAJ03q8eigZ5xld7OA6v7zMrI93Bw73ndAYdlObMEomLVZ4fC
	 0WoJu0ww9kUOkjlDWr7FMwEqp3KGfAa1WRGV4YW83uScPJN2Gb3zgWHNhjlxGN7oT4
	 W15kqZyOkGGRQMgdpgjhvZZYxznjdMxBlGN/D7DygbdLyn5kQAcLO8vfpog27Nityh
	 jthWMCqkcOOAUTl28XB8+T6Pr5pEBxTJLjxuaJImEWBzQDePlndeQ2oe2mO/m6KAGn
	 5DHWslhKSEmEA==
Subject:
 Re: [PATCH net v2 3/3] ice: skip unnecessary VF reset when setting trust
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jtornosm@redhat.com, przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, horms@kernel.org, sdf@fomichev.me,
 rafal.romanowski@intel.com
Date: Wed, 30 Sep 2026 00:58:28 +0000
Message-ID: <179072990876.434549.9916192476144636876@kernel.org>
In-Reply-To: <20260928224454.483072-4-anthony.l.nguyen@intel.com>
References: <20260928224454.483072-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new no-reset branch of ice_set_vf_trust()
  (drivers/net/ethernet/intel/ice/ice_sriov.c:1427-1430) updates…
- [Medium] The reset predicate in ice_set_vf_trust()
  (ice_sriov.c:1419-1422) ignores unicast MAC filters that were only…
- [Medium] The new no-reset path treats the software bits
  ICE_VF_STATE_UC_PROMISC/ICE_VF_STATE_MC_PROMISC as the full record of…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  ice_set_vf_trust() takes a VF kref through ice_get_vf_by_id()…

--

ice: skip unnecessary VF reset when setting trust

This patch makes ice_set_vf_trust() skip ice_reset_vf() in two cases. The
first is granting trust. The second is revoking trust from a VF that has
no LLDP MAC filters and no unicast or multicast promiscuous mode. In
those cases only vf->trusted and the ICE_VIRTCHNL_VF_CAP_PRIVILEGE bit
are updated.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de02155966..f893dff39aac6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c

[ ... ]

> @@ -1401,11 +1415,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>  
>  	mutex_lock(&vf->cfg_lock);
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but the switchdev check
earlier in ice_set_vf_trust() returns without dropping the reference
that ice_get_vf_by_id() took:

	vf = ice_get_vf_by_id(pf, vf_id);
	if (!vf)
		return -EINVAL;

	if (ice_is_eswitch_mode_switchdev(pf)) {
		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
		return -EOPNOTSUPP;
	}

Does each ndo_set_vf_trust call in switchdev mode leak one VF kref? If
so, ice_release_vf() never runs, and the struct ice_vf and its pci_dev
reference are never released.

The notes on this version already call this a pre-existing leak. Setting
ret = -EOPNOTSUPP and jumping to out_put_vf would fix it.

> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> -
> -	vf->trusted = trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	/* Reset only if revoking trust and VF has advanced features configured */
> +	if (!trusted &&
> +	    (vf->num_mac_lldp > 0 ||
> +	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
> +	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {

[Severity: Medium]
Is this predicate enough to decide that a VF is in a clean state? It
does not cover unicast MAC filters that the VF could only add because it
was trusted.

While a VF is trusted, ice_can_vf_change_mac() lets it add unicast
filters even when its MAC was set by the admin:

	if (vf->pf_set_mac && !ice_is_vf_trusted(vf))
		return false;

ice_vc_handle_mac_addr_msg() also skips the per-VF quota for trusted
VFs:

	if (set && !ice_is_vf_trusted(vf) &&
	    (vf->num_mac + al->num_elements) > ICE_MAX_MACADDR_PER_VF) {

Before this patch, revoking trust always ran
ice_reset_vf()->ice_vf_reconfig_vsi()->ice_fltr_remove_all(). The
rebuild then re-added only the broadcast and hw_lan_addr filters.

Now the else branch is taken for a VF with num_mac_lldp == 0 and no
promisc bits. That VF keeps all its extra unicast filters in hardware,
and vf->num_mac can stay above ICE_MAX_MACADDR_PER_VF.

Would a pf_set_mac VF keep receiving traffic for MACs that an untrusted
VF may not add, even though the log says "VF N is now untrusted"?

The notes on this version point out that untrusted VFs can delete their
own filters. A guest that does not delete them keeps them until some
unrelated reset.

[Severity: Medium]
Can ICE_VF_STATE_UC_PROMISC and ICE_VF_STATE_MC_PROMISC both be clear
while promiscuous-related hardware state is still programmed?

ice_vc_cfg_promiscuous_mode_msg() disables VLAN pruning first:

	else
		ret = vlan_ops->dis_rx_filtering(vsi);

In the path without true promisc, the multicast promisc rule can be
installed, and then an ice_set_dflt_vsi() failure exits before either
bit is set:

		if (allmulti)
			mcast_err = ice_vf_set_vsi_promisc(vf, vsi, mcast_m);
		...
		if (ret) {
			...
			goto error_param;
		}

In the true-promisc path, if ucast_err and mcast_err are both non-zero,
neither bit is set. VLAN pruning is already disabled at that point, and
some per-VLAN rules may be installed.

Before this patch, the unconditional ice_reset_vf() rebuilt the VSI
through ice_vsi_decfg() and ice_fltr_remove_all(), whatever the bits
said. Now the else branch is taken. The VF cannot undo this state
itself, because ice_vc_cfg_promiscuous_mode_msg() rejects untrusted VFs
before it reaches ena_rx_filtering().

Would the untrusted VF keep VLAN pruning disabled, and possibly an
allmulti or VLAN promisc rule? Getting into this state needs an admin
queue or firmware failure while the VF was trusted.

> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> +		vf->trusted = trusted;
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	} else {
> +		vf->trusted = trusted;
> +		ice_setup_vf_trust(vf, trusted);
> +	}

[Severity: High]
What happens to the negotiated VLAN_V2 filter limit when this branch
runs? The limit comes from vf->trusted, but it is only computed when the
VF negotiates VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS. In
ice_vc_get_max_vlan_fltrs():

	if (vf->trusted)
		return VLAN_N_VID;
	else
		return ICE_MAX_VLAN_PER_VF;

The result is then cached in ice_vc_get_offload_vlan_v2_caps():

	/* store negotiated caps to prevent invalid VF messages */
	memcpy(&vf->vlan_v2_caps, caps, sizeof(*caps));

Only ice_vf_set_initialized() clears this cache, and it runs on the
reset path that this branch now skips. ice_vc_add_vlan_v2_msg() checks
new filters against the cached value in
ice_vc_validate_add_vlan_filter_list():

	if (num_requested_filters > vfc->max_filters)
		return false;

Granting trust always takes this branch. Does a VLAN_V2 VF then stay
limited to ICE_MAX_VLAN_PER_VF on the PF side?

iavf enforces its own cached copy through iavf_get_max_vlans_allowed(),
so the VF will not try to add more VLANs until it renegotiates. That
seems to contradict this line in the commit message: "we can just set
the capability flag to allow privileged operations".

Revoking trust from a clean VF also takes this branch. Does the
untrusted VF keep the VLAN_N_VID quota? The legacy path in
ice_vf_has_max_vlans() checks ice_is_vf_trusted() at the time of each
request, so the V1 and V2 paths would disagree for the same VF.

The notes on this version describe the cache invalidation as part of
the existing reset/rebuild design. Before this patch, though, every
trust change went through ice_reset_vf(), so the caps were always
renegotiated. The new branch is what lets the cache go stale.

iavf caches max_filters too. Would a VLAN_V2 VF need to renegotiate its
caps (through a reset or something equivalent) whenever its trust
setting changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928224454.483072-1-anthony.l.nguyen%40intel.com
