Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D16357D11
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729909; cv=none; b=SmbEv+M7bQhTcQow0nPVYia8bv4WheMEhzBWs+dvKsnyh97LR6X81JVl2Fq/isn6Fsh0zMOiBshEY1cxIzks7x0/aXr/XIYhY0aXDXID6g7Go851KyyHcROVY43BP43nkCXsqY2Ddw/+hdW5XMmkwzjzRVZKn0+reAtWbatedvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729909; c=relaxed/simple;
	bh=Sb+nL/vmZhesJdgKQfRg78V0R8wIeYMsrUthohV5OLw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGtclxH19akEUiVPJyFm1mQqsKE9/kO6rlctTxrdnColffIFiCd4dnK/IunLDY5zv8lAQZ/eGKiZW+HAM0La/D1/koZUkC7n5S2N/5mzTXlAv4/rDQEMe80XZhrwyA+K56nnRvasn4g3l9Sd8lKsLDLqE6oEqesT27jAgyaDBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuEzmgvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuEzmgvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839B11F00893;
	Wed, 30 Sep 2026 00:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729907;
	bh=DH7qzWtMiIToRXgiDRYyX7L2iWfDYSH7GqE2o7uGoFo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DuEzmgvlKxqJ4+PJDJPJX5ejzqHt/hwwY0or+h8OLukB3b9B1F+gUDV5QIARQuQe5
	 VAdFt3fcgI/FFgjd0dWfhJDeX3q0jSt1Q49oVHFe2g9gELOy8wGOMi2x0eeLHiuY3P
	 nQzNayDUBAbBCMQeFN6J4hLLtErAQEhfHKaHeqUgLyw6D0a5ORKVhWWMgCyMFiWjkp
	 rqimNPRzsCdq7WyzpQhT6/ZZkANaXaTCDToAiEsYhCRlknuovvHZg2y5IFnzWJko5Y
	 NRiug0EOxV82QS8rFesBJGINUPcrygceF2cLitJlpIkI8dczh22QY4LPZId60e+9U7
	 EUDml0KCX6dBg==
Subject:
 Re: [PATCH net v2 1/3] i40e: skip unnecessary VF reset when setting trust
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jtornosm@redhat.com, przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 aleksandr.loktionov@intel.com, horms@kernel.org, sdf@fomichev.me,
 rafal.romanowski@intel.com
Date: Wed, 30 Sep 2026 00:58:26 +0000
Message-ID: <179072990609.434549.1214110562725821109@kernel.org>
In-Reply-To: <20260928224454.483072-2-anthony.l.nguyen@intel.com>
References: <20260928224454.483072-2-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 · Medium: 2 (2) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When trust is revoked, filters the VF could only install while
  trusted are no longer removed.
- [Medium] The revoke path has a race (time-of-check/time-of-use) with
  virtchnl handlers and no longer has the reset to clean up after it.
- [Medium] The privilege bit can be lost to a concurrent service-task VF
  reset.

Pre-existing issues:
- [Medium] In the revoke-with-reset branch, CAP_PRIVILEGE is cleared (by
  i40e_alloc_vf_res()) and hardware promisc is dropped (by…
- [Medium] In the revoke reset branch, i40e_del_all_cloud_filters() runs
  after i40e_vc_reset_vf() has released the ADQ channel VSIs…
- [Low] Granting trust does not apply a promiscuous-mode request the PF
  earlier acknowledged but ignored.

--

i40e: skip unnecessary VF reset when setting trust

This commit makes i40e_ndo_set_vf_trust() skip the VF reset in two cases:
when granting trust, and when revoking trust from a VF that has no ADQ,
cloud filters or promiscuous mode configured. In those cases a new
helper, i40e_setup_vf_trust(), only updates I40E_VIRTCHNL_VF_CAP_PRIVILEGE.
The goal is to avoid the ~10 second reset delay during bonding setup.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index a26c3d47ec156..c6732a24b6400 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4943,6 +4943,20 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable)
>  	return ret;
>  }
>  
> +/**
> + * i40e_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no advanced
> + * features configured that need cleanup).
> + */
> +static void i40e_setup_vf_trust(struct i40e_vf *vf, bool setting)
> +{
> +	assign_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, setting);

[Severity: Medium]
Can a VF reset running at the same time in the service task undo this
write?

A reset from a VFLR (i40e_vc_process_vflr_event()), from
VIRTCHNL_OP_RESET_VF or from a request for more queues runs
i40e_alloc_vf_res(). That function reads vf->trusted and then writes the
same bit:

	if (vf->trusted)
		set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
	else
		clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);

Suppose i40e_ndo_set_vf_trust() sets vf->trusted = false and calls
i40e_setup_vf_trust() after that read but before the set_bit(). The bit
then stays set while vf->trusted is false. On the grant path the result
can be the reverse.

Before this patch, the ndo always called i40e_vc_reset_vf(), and
i40e_reset_vf() returns false while the other reset holds the flag:

	if (test_and_set_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
		return false;

So the ndo retried and ran a new reset, which recomputed the bit from the
final value of vf->trusted.

The notes on this version call this race pre-existing, but that
follow-up reset used to fix it up. Now that the reset is skipped, does
anything bring vf->trusted and vf_caps back in line?

> +}
> +
>  /**
>   * i40e_ndo_set_vf_trust
>   * @netdev: network interface device structure of the pf

[ ... ]

> @@ -4987,19 +5001,20 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
>  	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
>  	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
>  
> -	i40e_vc_reset_vf(vf, true);
> +	/* Reset only if revoking trust and VF has advanced features configured */
> +	if (!setting &&
> +	    (vf->adq_enabled || vf->num_cloud_filters > 0 ||
> +	     test_bit(I40E_VF_STATE_UC_PROMISC, &vf->vf_states) ||
> +	     test_bit(I40E_VF_STATE_MC_PROMISC, &vf->vf_states))) {

[Severity: High]
Should this condition also cover MAC and VLAN filters that the VF could
only add because it was trusted?

Trust is only checked when a filter is added. In
i40e_check_vf_permission(), a trusted VF skips the admin MAC restriction
and gets a higher limit:

	if (!vf_trusted && !is_multicast_ether_addr(addr) &&
	    vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
	...
	if (!vf_trusted)
		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
	else
		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);

i40e_vc_add_vlan_msg() only applies the VLAN limit when the bit is
clear:

	if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
	    !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {

Before this patch, the reset went through
i40e_reset_vf()->i40e_cleanup_reset_vf()->i40e_free_vf_res()->
i40e_vsi_release(). That removed every filter on the VSI and set
vf->num_vlan = 0, so the VF had to add its filters again under the
untrusted limits.

Now a VF with no ADQ, no cloud filters and no promisc bits takes the
else branch, which only clears the bit. These filters stay in hardware:

  - extra unicast MACs that differ from the admin-set MAC
  - MAC filters beyond I40E_VC_MAX_MAC_ADDR_PER_VF (18)
  - VLANs beyond I40E_VC_MAX_VLAN_PER_VF (16)

The VF keeps receiving on them. With spoofchk on, it can also still send
from those MACs.

The __I40E_MACVLAN_SYNC_PENDING work only reaches
i40e_correct_vf_mac_vlan_filters(). That function rewrites the VLAN ids
of existing entries and never deletes a MAC filter.

There is also a functional side effect. When mac_add_max drops back to
18 while i40e_count_active_filters(vsi) is still above 18, this check
fails even when mac_add_cnt is 0:

	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||

Does every later VIRTCHNL_OP_ADD_ETH_ADDR from the VF then fail with
-EPERM, for example a new multicast subscription, until the guest
deletes filters itself?

The notes on this version say this is fine because an untrusted VF can
delete its own filters. Doesn't that rely on the guest cooperating, which
can't be assumed when the admin revokes trust?

The bonding case this patch targets is also a typical case for extra MACs
being installed. Are the "clean state" wording in the commit message and
the "no advanced features configured that need cleanup" wording in the
i40e_setup_vf_trust() kernel-doc accurate for that case?

[Severity: Medium]
Can this unlocked check race with a promisc request that is still in
progress?

i40e_vc_config_promiscuous_mode_msg() runs from the service task through
i40e_clean_adminq_subtask()->i40e_vc_process_vf_msg(). It takes neither
rtnl nor __I40E_VIRTCHNL_OP_PENDING. It checks the privilege bit first,
then sends AdminQ commands, and only sets the state bits at the end:

	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
	...
	aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti,
						 alluni);
	...
		if (!test_and_set_bit(I40E_VF_STATE_UC_PROMISC,
				      &vf->vf_states))

A possible interleaving:

service task                          i40e_ndo_set_vf_trust()
privilege test_bit() passes
i40e_config_vf_promiscuous_mode()
  (AdminQ round trip)                 vf->trusted = false
                                      UC/MC_PROMISC still clear,
                                      reset skipped
                                      i40e_setup_vf_trust() clears
                                      the privilege bit
test_and_set_bit(UC_PROMISC)

Would the VF then stay promiscuous while untrusted, with nothing left to
undo it? The window spans a sleeping AdminQ round trip, and the guest can
send promisc requests over and over.

The notes on this version call this race pre-existing. Before this patch,
though, the reset always ran after the vf->trusted write, and
i40e_cleanup_reset_vf() turned promisc off and released the VSI:

	/* disable promisc modes in case they were enabled */
	i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_id, false, false);

That undid anything set up during the window. The no-reset path has no
such fallback.

> +		i40e_vc_reset_vf(vf, true);

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but
i40e_vc_reset_vf() returns void and can return without doing a reset:

  - it returns early if __I40E_VFS_RELEASING is set
  - i40e_reset_vf() returns true without resetting if
    __I40E_VF_RESETS_DISABLED or __I40E_VF_DISABLE is set
  - the loop gives up after 20 tries while I40E_VF_STATE_RESETTING is
    held

In this branch, only i40e_alloc_vf_res() clears the privilege bit and
only i40e_cleanup_reset_vf() turns promisc off. Both run only if the
reset happens.

When the reset doesn't happen, can the VF stay privileged and promiscuous
while vf->trusted is false, with "VF %u is now untrusted" still logged?

A review of an earlier version suggested calling
i40e_setup_vf_trust(vf, setting) unconditionally, before the branch.
Would that make the bit correct whether or not the reset runs?

> +		i40e_del_all_cloud_filters(vf);

[Severity: Medium]
This is a pre-existing issue (the old code also deleted the cloud filters
after the reset), but does this ordering leak the struct
i40e_cloud_filter entries?

i40e_vc_reset_vf() releases the ADQ channel VSIs in i40e_free_vf_res()
and creates them again in i40e_alloc_vf_res(). cloud_filter_list is kept,
and each cfilter->seid still holds the old seid. When
i40e_find_vsi_from_seid() finds no match, i40e_del_all_cloud_filters()
does this:

		if (!vsi) {
			dev_err(&pf->pdev->dev, "VF %d: no VSI found for matching %u seid, can't delete cloud filter\n",
				vf->vf_id, cfilter->seid);
			continue;
		}

That skips the hlist_del(), the kfree(cfilter) and the
vf->num_cloud_filters decrement.

i40e_vc_del_qch_msg() deletes the filters before tearing down the
channels:

	if (vf->adq_enabled) {
		i40e_del_all_cloud_filters(vf);
		i40e_del_qch(vf);

Would that same order work here?

> +	} else {
> +		i40e_setup_vf_trust(vf, setting);

[Severity: Low]
This isn't a bug introduced by this patch, but granting trust only sets
the capability bit. i40e_vc_config_promiscuous_mode_msg() deliberately
reports success to an unprivileged VF without applying the mode:

		/* Lie to the VF on purpose, because this is an error we can
		 * ignore. Unprivileged VF is not a virtual channel error.
		 */
		aq_ret = 0;
		goto err_out;

iavf_set_promiscuous() caches current_netdev_promisc_flags and skips
duplicate requests. Is a promisc or allmulti request made while the VF
was untrusted then never applied after trust is granted, until the guest
toggles its flags?

The old unconditional reset on grant didn't make iavf resend the request
either, because current_netdev_promisc_flags isn't cleared on reset.

> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928224454.483072-1-anthony.l.nguyen%40intel.com
