Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903962E2DDD
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518325; cv=none; b=dP6wNUVqgLhOfwBjUo1g5QMLkinNt9/eGXcR5FNKxgiIKFpZrLgZxP/6ILd/2u08Lk/rlXRvqeCmKU4GgmBvGbJ5O9cKXAS0KQLdWDLSmUZwjkrAnSC2YrhZo74ha2pKsFaZUcgO60w1Nv+6UeTXdrOr5eUizEjh2LV/m1qG+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518325; c=relaxed/simple;
	bh=FQjM3ke+E0u3/8yoTbfS/uUg9WQpxNnBig6/NadVlyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwuAHcoqkaTxRPIqjWLVN3rRSzhXFaOU2JHJ+LfaNjIgBw87x3SScH5QwlWlWXZas4TnpLTSWu3X9uL6SxJkQT/eOlJXG+G9sGeYg9WVSbiwZ8z+A+Yr8kLgLSm5LnI+sHdQQTr8vgysZ1N3EOI0463NW1WgtZ0WAe2JjWiC9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG510mW4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG510mW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786518322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XNaGMbOQOq6/13HxVaQVRx7tEbsp1dKtOINBpruIOI=;
	b=WG510mW4vEMZK6FHlkYpN3TT5FkA3zmcg8OwSME7ThGzHeNrZ8dil2PtlUQUimCjicL1JM
	ljeNKbEvyEc/I7qKaBPfU0bs+pxQ8WX2gFqgOhnTvNJhPvkAXiAFVrUejBkoNzxeJqS5/w
	dSKpEcV5Gg+iWI4ioiijFIcfVMG21OA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-Srw0niYhNRCWSiBDWN3P1g-1; Wed,
 12 Aug 2026 03:05:11 -0400
X-MC-Unique: Srw0niYhNRCWSiBDWN3P1g-1
X-Mimecast-MFC-AGG-ID: Srw0niYhNRCWSiBDWN3P1g_1786518309
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24942195609F;
	Wed, 12 Aug 2026 07:05:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.55])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A0D8195DF91;
	Wed, 12 Aug 2026 07:05:03 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org,
	anthony.l.nguyen@intel.com
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	doruk@0sec.ai,
	edumazet@google.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 04/10] ice: skip unnecessary VF reset when setting trust
Date: Wed, 12 Aug 2026 09:05:02 +0200
Message-ID: <20260812070502.10679-1-jtornosm@redhat.com>
In-Reply-To: <20260806172036.2935667-1-kuba@kernel.org>
References: <20260806172036.2935667-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions, out-of-scope items, or extreme edge
cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Low]
> This isn't a bug, but does the kernel-doc match the only call site?  The
> comment says the helper "is only called when it's safe to skip the reset (VF
> has no advanced features configured that need cleanup)", yet
> ice_set_vf_trust() takes the else branch for every trust grant without
> looking at vf->num_mac_lldp, the promiscuous bits, vf->num_mac or the VLAN
> count at all, and on revoke it only consults the LLDP counter and the two
> promiscuous bits.  Would it be clearer to describe the condition the caller
> actually enforces?

Same as the equivalent comment on i40e_setup_vf_trust(). The kernel-doc
describes the primary design intent. The helper is trivial (set/clear one
bit) and safe to call in any context. Not a functional issue.

> [Severity: High]
> Should this predicate also cover the MAC and VLAN filter quotas that trust
> lifts?  Trust does more than gate LLDP filters and promiscuous mode.
>
> The unicast/multicast MAC budget is only enforced for untrusted VFs, in
> ice_vc_handle_mac_addr_msg() (virt/virtchnl.c):
>
>     if (set && !ice_is_vf_trusted(vf) &&
>         (vf->num_mac + al->num_elements) > ICE_MAX_MACADDR_PER_VF) {
>
> The VLAN budget works the same way, in ice_vf_has_max_vlans():
>
>     static bool ice_vf_has_max_vlans(struct ice_vf *vf, struct ice_vsi *vsi)
>     {
>         if (ice_is_vf_trusted(vf))
>             return false;
>
> and a trusted VF may override an administratively set MAC, in
> ice_can_vf_change_mac():
>
>     if (vf->pf_set_mac && !ice_is_vf_trusted(vf))
>         return false;
>
> All three checks run only at add time, so already-programmed filters are
> never re-audited.  Previously the reset was what removed them, via
> ice_reset_vf() -> ice_vf_reconfig_vsi() -> ice_fltr_remove_all(), and
> ice_vf_pre_vsi_rebuild() -> ice_vf_clear_counters() is what reset the
> accounting:
>
>     if (vsi)
>         vsi->num_vlan = 0;
>
>     vf->num_mac = 0;
>     vf->num_mac_lldp = 0;
>
> So for a VF that added over-quota MAC or VLAN filters while trusted, but
> never enabled promiscuous mode and never added an LLDP MAC, does "ip link
> set <pf> vf N trust off" now report success while the hardware switch
> filters stay programmed?  Since the ice anti-spoof behaviour is driven by
> that filter list, can the now-untrusted guest keep receiving and
> transmitting with addresses and VLANs it was only permitted to program while
> trusted?
>
> There is a second effect of skipping ice_vf_clear_counters(): vf->num_mac
> and vsi->num_vlan stay at their trusted-era values, which are above the
> untrusted limits.  Does that make every subsequent filter add from the
> untrusted VF fail against stale accounting until some unrelated VF reset
> happens?

Same concern addressed in previous versions for both i40e and ice.
Over-limit filters configured while trusted remain after trust revocation,
but this is acceptable because untrusted VFs can freely delete their own
MAC and VLAN filters, there are no trust checks in the deletion path
(ice_vc_handle_mac_addr_msg() only checks trust when set == true). The VF
simply cannot add more over-limit filters.

ice_vc_handle_mac_addr_msg() decrements vf->num_mac on delete, so the
counter reflects actual state after deletions. The no-reset path is only
reached for VFs with no LLDP or promiscuous mode, having excess
MAC/VLAN filters in this state is extremely unlikely.

> [Severity: Medium]
> This isn't a bug introduced by this patch, since the pre-patch loop had the
> same shape, but the unchecked ice_get_vf_vsi(vf) result is handed to a callee
> whose NULL check comes after a dereference, in ice_vf_update_mac_lldp_num()
> (ice_vf_lib.c):
>
>     bool lldp_by_fw = test_bit(ICE_FLAG_FW_LLDP_AGENT, vsi->back->flags);
>     bool was_ena = ice_vf_is_lldp_ena(vf) && !lldp_by_fw;
>     bool is_ena;
>
>     if (WARN_ON(!vsi)) {
>         vf->num_mac_lldp = 0;
>         return;
>     }
>
> vsi->back is read in the initializer, before WARN_ON(!vsi), so both the
> warning and the vf->num_mac_lldp = 0 fallback that terminates this loop are
> unreachable for a NULL VSI.
>
> I could not find a reachable state where vf->num_mac_lldp is non-zero with a
> NULL VF VSI (ice_free_vf_res() and the reset paths all zero the counter),
> so this looks latent rather than triggerable.  Would it be worth computing
> lldp_by_fw after the WARN_ON(!vsi) check so the guard actually guards?

Pre-existing issue, not introduced by this patch. The pre-patch code had
the same loop with the same call. As the review notes, this is latent
rather than triggerable.

> [Severity: Medium]
> This is a pre-existing asymmetry rather than something the patch introduces,
> but now that ice_setup_vf_trust() exists, should it be called on this branch
> too?
>
> On the reset branch, vf->trusted is written but ICE_VIRTCHNL_VF_CAP_PRIVILEGE
> in vf->vf_caps, which is what ice_is_vf_trusted() reads, is only re-derived
> as a side effect of the rebuild:
>
> ice_reset_vf() -> ice_vf_post_vsi_rebuild() -> ice_vf_rebuild_host_cfg() ->
> ice_vf_set_host_trust_cfg()
>
>     static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
>     {
>         assign_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps, vf->trusted);
>     }
>
> ice_reset_vf() has several exits that never reach the rebuild, for example:
>
>     if (test_bit(ICE_VF_RESETS_DISABLED, pf->state)) {
>         dev_dbg(dev, "Trying to reset VF %d, but all VF resets are disabled\n",
>             vf->vf_id);
>         return 0;
>     }
>
> plus the ice_is_vf_disabled() path, the two WARN_ON(!vsi) exits and
> ice_vf_reconfig_vsi() failure.  The return value is discarded here and the
> dev_info() below prints "VF %u is now %strusted" regardless.
>
> On those paths, do vf->trusted and the privilege bit diverge while the
> operation still reports success?  ICE_VF_RESETS_DISABLED is only set in
> ice_remove(), and the other exits leave ICE_VF_STATE_ACTIVE cleared, which
> the privileged virtchnl handlers check first, so this looks like a state and
> reporting inconsistency rather than retained privilege.  Would calling
> ice_setup_vf_trust(vf, trusted) on both branches and propagating
> ice_reset_vf()'s error be worthwhile?

Pre-existing asymmetry, not introduced by this patch. The early-exit paths
in ice_reset_vf() (ICE_VF_RESETS_DISABLED, VF disabled) all leave
ICE_VF_STATE_ACTIVE cleared, so privileged virtchnl handlers reject
messages regardless. This is a state and reporting inconsistency rather
than retained privilege.

Duplicating the trust setup on both branches was explored during
development and introduced additional issues, it would require a broader
redesign of the reset path, which is beyond the scope of this fix.

> [Severity: Medium]
> What happens to the already negotiated VLAN_V2 capabilities when trust
> changes without a reset?  The advertised VLAN filter budget is derived from
> vf->trusted once, in ice_vc_get_max_vlan_fltrs() (virt/virtchnl.c):
>
>     static u16 ice_vc_get_max_vlan_fltrs(struct ice_vf *vf)
>     {
>         if (vf->trusted)
>             return VLAN_N_VID;
>         else
>             return ICE_MAX_VLAN_PER_VF;
>     }
>
> and cached by ice_vc_get_offload_vlan_v2_caps():
>
>     /* store negotiated caps to prevent invalid VF messages */
>     memcpy(&vf->vlan_v2_caps, caps, sizeof(*caps));
>
> VIRTCHNL_OP_ADD_VLAN_V2 is then validated only against that cached copy, in
> ice_vc_validate_add_vlan_filter_list():
>
>     if (num_requested_filters > vfc->max_filters)
>         return false;
>
> with no ice_is_vf_trusted() re-check.  The cache is invalidated only by
> ice_vf_set_initialized():
>
>     memset(&vf->vlan_v2_caps, 0, sizeof(vf->vlan_v2_caps));
>
> which is reached from ice_vf_post_vsi_rebuild(), i.e. only on the reset path
> this branch skips.  The iavf side caches and enforces the advertised limit
> itself as well, in iavf_get_max_vlans_allowed() and iavf_vlan_rx_add_vid().
>
> So for a VLAN_V2 capable VF, is granting trust here a no-op for the VLAN
> path, leaving the VF and PF both at ICE_MAX_VLAN_PER_VF?  And in the other
> direction, if the VF negotiated caps while already trusted and trust is
> revoked through this branch, does it keep the VLAN_N_VID budget while
> untrusted?

The VLAN_V2 caps cache invalidation is part of the reset/rebuild path
by design (ice_vf_set_initialized()). This patch does not change that
architecture, it only adds a conditional to skip the reset when no
advanced features are configured. The cache behavior is inherited from
the existing design and is beyond the scope of this fix.

> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but it is in
> the function being modified.  Earlier in ice_set_vf_trust(), the switchdev
> check returns without releasing the reference taken by ice_get_vf_by_id():
>
>     vf = ice_get_vf_by_id(pf, vf_id);
>     if (!vf)
>         return -EINVAL;
>
>     if (ice_is_eswitch_mode_switchdev(pf)) {
>         dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in switchdev mode\n");
>         return -EOPNOTSUPP;
>     }
>
> ice_get_vf_by_id() documents that "This function takes a reference to the VF,
> which must be released by calling ice_put_vf()", and the out_put_vf label at
> the end of the function is what normally does that.  Does each "ip link set
> <pf> vf N trust on|off" issued while the PF is in switchdev mode leak a VF
> reference, so ice_sriov_free_vf() never runs for that struct ice_vf?  Would
> "ret = -EOPNOTSUPP; goto out_put_vf;" be the right fix while here?

Pre-existing reference leak, not introduced by this patch. This can be
a separate bug fix but not part of this series.

