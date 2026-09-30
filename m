Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32F490C01
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764826; cv=none; b=meJnzaWWhXV8zcbO+TqTzKUo5eU99caKswof8VpYuhvtJpLQ7Rq4mGSTjatzoH6F7FTEYJlcwTyMXg7nQPoKJqnVfdH+r7k/7dlJ+gUCf0mpnsxzWyAkTbo8FhpREIGoRIPeA11FgiE0jWPiT1aUlDfMivXZxMuM11G3bhVRt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764826; c=relaxed/simple;
	bh=Qq6zlYdZJ0Ypt1ifIS0OVhvhgDsFm4PDEY+Pkn6dIm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdcJ0bCFOsbSwUoS6LkWOnPQih/WGTq56bySQOLgi5zU/tK4MJS3nwk/V1R3wsrlJmnNV3yLzKQG49G22LQGJvdW1kmApOfTD6sVt7qrY1+Od9ZKbDLNzQq0eCCXf3cnYCGBX9W1TugexRc2A7QdjzGnKV/eLonf68N4sC1ra4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwCECjqe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwCECjqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790764806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsVJB2LJEh2mKZk2wZt7PB+h2LlvtCc9j8GQjyoAM2s=;
	b=HwCECjqeQEjVKyvRyEX134IV6tUd1rNN35Iv9Kyfr0mFjLTVwkwuKBogKsmImHsFAKi8rT
	qjzRCgrGftfK9+JC4IJ6d7gBmsycoYOKaMaKBDxua1uscP8oZDBr2ULFlM43O0tR+ZpZwQ
	e5+/fDkLs9oI5ME+8CBB7pvvtia+4zY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-kgNzJqALML2H686yCqVGFw-1; Wed,
 30 Sep 2026 06:40:01 -0400
X-MC-Unique: kgNzJqALML2H686yCqVGFw-1
X-Mimecast-MFC-AGG-ID: kgNzJqALML2H686yCqVGFw_1790764799
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F4A11944EBE;
	Wed, 30 Sep 2026 10:39:59 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2341119560AB;
	Wed, 30 Sep 2026 10:39:54 +0000 (UTC)
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
Subject: Re: [PATCH net v2 1/3] i40e: skip unnecessary VF reset when setting trust
Date: Wed, 30 Sep 2026 12:39:53 +0200
Message-ID: <20260930103953.76497-1-jtornosm@redhat.com>
In-Reply-To: <179072990609.434549.1214110562725821109@kernel.org>
References: <179072990609.434549.1214110562725821109@kernel.org>
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
edge cases. The key fix in this series is patch 2/3. This patch improves
the overall behavior by eliminating unnecessary VF resets that could add
~10 second delay during bonding setup. The no-reset path is narrowly
scoped to VFs with no ADQ, no cloud filters, and no promiscuous mode, a
basic configuration where the edge cases below are extremely difficult to
reproduce. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Medium]
> Can a VF reset running at the same time in the service task undo this
> write?
>
> A reset from a VFLR (i40e_vc_process_vflr_event()), from
> VIRTCHNL_OP_RESET_VF or from a request for more queues runs
> i40e_alloc_vf_res(). That function reads vf->trusted and then writes the
> same bit:
>
>     if (vf->trusted)
>         set_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
>     else
>         clear_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
>
> Suppose i40e_ndo_set_vf_trust() sets vf->trusted = false and calls
> i40e_setup_vf_trust() after that read but before the set_bit(). The bit
> then stays set while vf->trusted is false. On the grant path the result
> can be the reverse.
>
> Before this patch, the ndo always called i40e_vc_reset_vf(), and
> i40e_reset_vf() returns false while the other reset holds the flag:
>
>     if (test_and_set_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
>         return false;
>
> So the ndo retried and ran a new reset, which recomputed the bit from the
> final value of vf->trusted.
>
> The notes on this version call this race pre-existing, but that
> follow-up reset used to fix it up. Now that the reset is skipped, does
> anything bring vf->trusted and vf_caps back in line?

The race requires a VFLR-initiated reset to read vf->trusted and be
preempted between the read and the assign_bit, while the ndo changes
trust in that exact window. The follow-up reset in the old code was not
a deliberate synchronization mechanism, it was a side effect of always
resetting. The window is extremely small and difficult to reproduce in
practice: it requires an admin trust change and a VFLR reset on the
same VF at the same instant, with preemption between two consecutive
instructions in i40e_alloc_vf_res(). The admin would be performing a
very unusual operation, and even if the mismatch occurred, it is not
breaking anything and can be corrected by toggling trust again.

> [Severity: High]
> Should this condition also cover MAC and VLAN filters that the VF could
> only add because it was trusted?
>
> Trust is only checked when a filter is added. In
> i40e_check_vf_permission(), a trusted VF skips the admin MAC restriction
> and gets a higher limit:
>
>     if (!vf_trusted && !is_multicast_ether_addr(addr) &&
>         vf->pf_set_mac && !ether_addr_equal(addr,
>         vf->default_lan_addr.addr)) {
>     ...
>     if (!vf_trusted)
>         mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>     else
>         mac_add_max =
>         I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
>         hw->num_ports);
>
> i40e_vc_add_vlan_msg() only applies the VLAN limit when the bit is
> clear:
>
>     if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
>         !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
>
> Before this patch, the reset went through
> i40e_reset_vf()->i40e_cleanup_reset_vf()->i40e_free_vf_res()->
> i40e_vsi_release(). That removed every filter on the VSI and set
> vf->num_vlan = 0, so the VF had to add its filters again under the
> untrusted limits.
>
> Now a VF with no ADQ, no cloud filters and no promisc bits takes the
> else branch, which only clears the bit. These filters stay in hardware:
>
>   - extra unicast MACs that differ from the admin-set MAC
>   - MAC filters beyond I40E_VC_MAX_MAC_ADDR_PER_VF (18)
>   - VLANs beyond I40E_VC_MAX_VLAN_PER_VF (16)
>
> The VF keeps receiving on them. With spoofchk on, it can also still send
> from those MACs.
>
> The __I40E_MACVLAN_SYNC_PENDING work only reaches
> i40e_correct_vf_mac_vlan_filters(). That function rewrites the VLAN ids
> of existing entries and never deletes a MAC filter.
>
> There is also a functional side effect. When mac_add_max drops back to
> 18 while i40e_count_active_filters(vsi) is still above 18, this check
> fails even when mac_add_cnt is 0:
>
>     if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
>
> Does every later VIRTCHNL_OP_ADD_ETH_ADDR from the VF then fail with
> -EPERM, for example a new multicast subscription, until the guest
> deletes filters itself?
>
> The notes on this version say this is fine because an untrusted VF can
> delete its own filters. Doesn't that rely on the guest cooperating, which
> can't be assumed when the admin revokes trust?
>
> The bonding case this patch targets is also a typical case for extra MACs
> being installed. Are the "clean state" wording in the commit message and
> the "no advanced features configured that need cleanup" wording in the
> i40e_setup_vf_trust() kernel-doc accurate for that case?

The no-reset path is only reached for VFs with no ADQ, no cloud filters,
and no promiscuous mode, a basic configuration where having excess
MAC/VLAN filters beyond untrusted limits is extremely unlikely. In the
bonding use case targeted by this fix, trust changes happen during setup
and VFs typically have 1-2 MAC filters, well within the untrusted limit
of 18.

Even in this rare scenario, the consequence is minor: the VF cannot add
more filters until it deletes some. No crash, no data corruption, no
security breach. Existing filters keep working. This does not rely on
guest cooperation, the PF enforces the limit at the virtchnl level. The
VF simply cannot add more filters beyond the untrusted limit, regardless
of its behavior.

For the functional side effect (later ADD_ETH_ADDR failing with -EPERM):
untrusted VFs can delete their own excess filters without trust checks
(i40e_vc_del_mac_addr_msg() and i40e_vc_remove_vlan_msg() have no trust
checks in the deletion path). Deletions reduce the count via
i40e_count_active_filters() immediately.

> [Severity: Medium]
> Can this unlocked check race with a promisc request that is still in
> progress?
>
> i40e_vc_config_promiscuous_mode_msg() runs from the service task through
> i40e_clean_adminq_subtask()->i40e_vc_process_vf_msg(). It takes neither
> rtnl nor __I40E_VIRTCHNL_OP_PENDING. It checks the privilege bit first,
> then sends AdminQ commands, and only sets the state bits at the end:
>
>     if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
>     ...
>     aq_ret = i40e_config_vf_promiscuous_mode(vf, info->vsi_id, allmulti,
>                          alluni);
>     ...
>         if (!test_and_set_bit(I40E_VF_STATE_UC_PROMISC,
>                       &vf->vf_states))
>
> A possible interleaving:
>
> service task                          i40e_ndo_set_vf_trust()
> privilege test_bit() passes
> i40e_config_vf_promiscuous_mode()
>   (AdminQ round trip)                 vf->trusted = false
>                                       UC/MC_PROMISC still clear,
>                                       reset skipped
>                                       i40e_setup_vf_trust() clears
>                                       the privilege bit
> test_and_set_bit(UC_PROMISC)
>
> Would the VF then stay promiscuous while untrusted, with nothing left to
> undo it? The window spans a sleeping AdminQ round trip, and the guest can
> send promisc requests over and over.
>
> The notes on this version call this race pre-existing. Before this patch,
> though, the reset always ran after the vf->trusted write, and
> i40e_cleanup_reset_vf() turned promisc off and released the VSI:
>
>     /* disable promisc modes in case they were enabled */
>     i40e_config_vf_promiscuous_mode(vf, vf->lan_vsi_id, false, false);
>
> That undid anything set up during the window. The no-reset path has no
> such fallback.

The same race exists in the original code, the promisc setup can
complete after vf->trusted is set to false but before the reset runs.
During the entire reset duration (~10 seconds), the VF was promiscuous
while untrusted. The race window itself is the same (an AdminQ round
trip) and requires the VF to be actively sending promisc requests at
the exact moment trust is revoked.

If this race does occur, the VF ends up with the UC/MC_PROMISC bits
set. Any subsequent trust operation that observes those bits takes the
reset path with full promisc cleanup via
i40e_config_vf_promiscuous_mode().

> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch, but
> i40e_vc_reset_vf() returns void and can return without doing a reset:
>
>   - it returns early if __I40E_VFS_RELEASING is set
>   - i40e_reset_vf() returns true without resetting if
>     __I40E_VF_RESETS_DISABLED or __I40E_VF_DISABLE is set
>   - the loop gives up after 20 tries while I40E_VF_STATE_RESETTING is
>     held
>
> In this branch, only i40e_alloc_vf_res() clears the privilege bit and
> only i40e_cleanup_reset_vf() turns promisc off. Both run only if the
> reset happens.
>
> When the reset doesn't happen, can the VF stay privileged and promiscuous
> while vf->trusted is false, with "VF %u is now untrusted" still logged?
>
> A review of an earlier version suggested calling
> i40e_setup_vf_trust(vf, setting) unconditionally, before the branch.
> Would that make the bit correct whether or not the reset runs?

Pre-existing issue, not introduced by this patch. Calling
i40e_setup_vf_trust() unconditionally before the branch would change
the behavior for the reset path, setting the bit before reset, then
having the reset recompute it from vf->trusted. A reasonable
improvement but a separate change from this fix.

> [Severity: Medium]
> This is a pre-existing issue (the old code also deleted the cloud filters
> after the reset), but does this ordering leak the struct
> i40e_cloud_filter entries?
>
> i40e_vc_reset_vf() releases the ADQ channel VSIs in i40e_free_vf_res()
> and creates them again in i40e_alloc_vf_res(). cloud_filter_list is kept,
> and each cfilter->seid still holds the old seid. When
> i40e_find_vsi_from_seid() finds no match, i40e_del_all_cloud_filters()
> does this:
>
>         if (!vsi) {
>             dev_err(&pf->pdev->dev, "VF %d: no VSI found for matching
>             %u seid, can't delete cloud filter\n",
>                 vf->vf_id, cfilter->seid);
>             continue;
>         }
>
> That skips the hlist_del(), the kfree(cfilter) and the
> vf->num_cloud_filters decrement.
>
> i40e_vc_del_qch_msg() deletes the filters before tearing down the
> channels:
>
>     if (vf->adq_enabled) {
>         i40e_del_all_cloud_filters(vf);
>         i40e_del_qch(vf);
>
> Would that same order work here?

Pre-existing ordering issue. The same sequence (reset before cloud
filter deletion) existed in the original code. This patch restructures
the control flow but preserves the same sequence.

> [Severity: Low]
> This isn't a bug introduced by this patch, but granting trust only sets
> the capability bit. i40e_vc_config_promiscuous_mode_msg() deliberately
> reports success to an unprivileged VF without applying the mode:
>
>         /* Lie to the VF on purpose, because this is an error we can
>          * ignore. Unprivileged VF is not a virtual channel error.
>          */
>         aq_ret = 0;
>         goto err_out;
>
> iavf_set_promiscuous() caches current_netdev_promisc_flags and skips
> duplicate requests. Is a promisc or allmulti request made while the VF
> was untrusted then never applied after trust is granted, until the guest
> toggles its flags?
>
> The old unconditional reset on grant didn't make iavf resend the request
> either, because current_netdev_promisc_flags isn't cleared on reset.

Pre-existing issue. The old unconditional reset on grant did not fix
this either, because current_netdev_promisc_flags is not cleared on
reset.

