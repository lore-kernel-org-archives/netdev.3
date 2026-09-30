Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF354705E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765067; cv=none; b=A11YQv46e0mHuBvV2hYab19ItpYuBxxPqA7TOvbRur15nPfKAE5wJW7Xa/0y6+IpOxjrno14XL16zitwZAUvtND2h3EilBNY6VlRBUi4jRVAN1LZywukfnaH991C9qLP05nw+Rm98qLYjMMW+xtgdCcpRnCTEJ77G/RKH1cmrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765067; c=relaxed/simple;
	bh=DzJIdXhnqUe5XPGobcPp3Jn4nrDHC3toODtwCeIwPq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO+Pu/ZQSX+VHU/OvOp9fgprrZDrU6dygJnPiPjPFFfLthVwroAMl9CWflA1MLKjCQSZ5POhUavSEr7a+vACWwpHvqXT0G503ys7PhjWXn51zhIaOnMuaZUb5pL6niK5rLS+K4x57F64D0uuIQnvfSOWoyY0QgWHvsWTA88AflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9nUqjxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9nUqjxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790765057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWI/VwybUQf8ZupgwVvA5lIeE0XCjbEnzM0rlwenFjs=;
	b=K9nUqjxWosA5gAdmP0bHtuMS5k/tt4YzI8bo03nF2p78uE7u+KB9oDoftL9R/ZTe/YZgsR
	a7ykPfRAfuy3HYt6Bl4yP0dvrxOMRdC3DZSHZbmz2VPFIyySNYvOvI/xR+tC921SpNvaqa
	WXZpIEVZTRtsU85qbjdTR6eXPXfxNWs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-sSRaeOl1PPiekV6lzKk13g-1; Wed,
 30 Sep 2026 06:44:13 -0400
X-MC-Unique: sSRaeOl1PPiekV6lzKk13g-1
X-Mimecast-MFC-AGG-ID: sSRaeOl1PPiekV6lzKk13g_1790765052
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EE891955DA7;
	Wed, 30 Sep 2026 10:44:12 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94B62768;
	Wed, 30 Sep 2026 10:44:08 +0000 (UTC)
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
Subject: Re: [PATCH net v2 3/3] ice: skip unnecessary VF reset when setting trust
Date: Wed, 30 Sep 2026 12:44:07 +0200
Message-ID: <20260930104407.76880-1-jtornosm@redhat.com>
In-Reply-To: <179072990876.434549.9916192476144636876@kernel.org>
References: <179072990876.434549.9916192476144636876@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions and comments, out-of-scope items, or extreme
edge cases. This patch mirrors the i40e fix (patch 1/3), improving the
overall behavior by eliminating unnecessary VF resets that could add delay
during bonding setup. The no-reset path is narrowly scoped to VFs with no
LLDP filters and no promiscuous mode. No code changes are considered
necessary for a new version. Details for each comment:

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the switchdev check
> earlier in ice_set_vf_trust() returns without dropping the reference
> that ice_get_vf_by_id() took:
>
>     vf = ice_get_vf_by_id(pf, vf_id);
>     if (!vf)
>         return -EINVAL;
>
>     if (ice_is_eswitch_mode_switchdev(pf)) {
>         dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in
>         switchdev mode\n");
>         return -EOPNOTSUPP;
>     }
>
> Does each ndo_set_vf_trust call in switchdev mode leak one VF kref? If
> so, ice_release_vf() never runs, and the struct ice_vf and its pci_dev
> reference are never released.
>
> The notes on this version already call this a pre-existing leak. Setting
> ret = -EOPNOTSUPP and jumping to out_put_vf would fix it.

Pre-existing reference leak, not introduced by this patch.

> [Severity: Medium]
> Is this predicate enough to decide that a VF is in a clean state? It
> does not cover unicast MAC filters that the VF could only add because it
> was trusted.
>
> While a VF is trusted, ice_can_vf_change_mac() lets it add unicast
> filters even when its MAC was set by the admin:
>
>     if (vf->pf_set_mac && !ice_is_vf_trusted(vf))
>         return false;
>
> ice_vc_handle_mac_addr_msg() also skips the per-VF quota for trusted
> VFs:
>
>     if (set && !ice_is_vf_trusted(vf) &&
>         (vf->num_mac + al->num_elements) > ICE_MAX_MACADDR_PER_VF) {
>
> Before this patch, revoking trust always ran
> ice_reset_vf()->ice_vf_reconfig_vsi()->ice_fltr_remove_all(). The
> rebuild then re-added only the broadcast and hw_lan_addr filters.
>
> Now the else branch is taken for a VF with num_mac_lldp == 0 and no
> promisc bits. That VF keeps all its extra unicast filters in hardware,
> and vf->num_mac can stay above ICE_MAX_MACADDR_PER_VF.
>
> Would a pf_set_mac VF keep receiving traffic for MACs that an untrusted
> VF may not add, even though the log says "VF N is now untrusted"?
>
> The notes on this version point out that untrusted VFs can delete their
> own filters. A guest that does not delete them keeps them until some
> unrelated reset.

Same concern addressed in previous versions and comments for both i40e
and ice. The no-reset path is only reached for VFs with no LLDP filters
and no promiscuous mode, a basic configuration where having excess MAC
filters beyond untrusted limits is extremely unlikely.

Even in this rare scenario, the consequence is minor: the VF cannot add
more filters until it deletes some. No crash, no data corruption, no
security breach. Existing filters keep working. This does not rely on
guest cooperation, the PF enforces the limit at the virtchnl level
(ice_vc_handle_mac_addr_msg() checks the quota on every add request).
The VF simply cannot add more filters beyond the untrusted limit,
regardless of its behavior.

> [Severity: Medium]
> Can ICE_VF_STATE_UC_PROMISC and ICE_VF_STATE_MC_PROMISC both be clear
> while promiscuous-related hardware state is still programmed?
>
> ice_vc_cfg_promiscuous_mode_msg() disables VLAN pruning first:
>
>     else
>         ret = vlan_ops->dis_rx_filtering(vsi);
>
> In the path without true promisc, the multicast promisc rule can be
> installed, and then an ice_set_dflt_vsi() failure exits before either
> bit is set:
>
>         if (allmulti)
>             mcast_err = ice_vf_set_vsi_promisc(vf, vsi, mcast_m);
>         ...
>         if (ret) {
>             ...
>             goto error_param;
>         }
>
> In the true-promisc path, if ucast_err and mcast_err are both non-zero,
> neither bit is set. VLAN pruning is already disabled at that point, and
> some per-VLAN rules may be installed.
>
> Before this patch, the unconditional ice_reset_vf() rebuilt the VSI
> through ice_vsi_decfg() and ice_fltr_remove_all(), whatever the bits
> said. Now the else branch is taken. The VF cannot undo this state
> itself, because ice_vc_cfg_promiscuous_mode_msg() rejects untrusted VFs
> before it reaches ena_rx_filtering().
>
> Would the untrusted VF keep VLAN pruning disabled, and possibly an
> allmulti or VLAN promisc rule? Getting into this state needs an admin
> queue or firmware failure while the VF was trusted.

This scenario requires an admin queue or firmware failure during
promiscuous mode setup while the VF was trusted, leaving hardware state
programmed without the corresponding software bits set. Then trust must
be revoked before any reset cleans up the state. This is an extremely
unlikely chain of events requiring multiple failures. The VF is in a
partially broken state at that point regardless of whether trust changes.

> [Severity: High]
> What happens to the negotiated VLAN_V2 filter limit when this branch
> runs? The limit comes from vf->trusted, but it is only computed when the
> VF negotiates VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS. In
> ice_vc_get_max_vlan_fltrs():
>
>     if (vf->trusted)
>         return VLAN_N_VID;
>     else
>         return ICE_MAX_VLAN_PER_VF;
>
> The result is then cached in ice_vc_get_offload_vlan_v2_caps():
>
>     /* store negotiated caps to prevent invalid VF messages */
>     memcpy(&vf->vlan_v2_caps, caps, sizeof(*caps));
>
> Only ice_vf_set_initialized() clears this cache, and it runs on the
> reset path that this branch now skips. ice_vc_add_vlan_v2_msg() checks
> new filters against the cached value in
> ice_vc_validate_add_vlan_filter_list():
>
>     if (num_requested_filters > vfc->max_filters)
>         return false;
>
> Granting trust always takes this branch. Does a VLAN_V2 VF then stay
> limited to ICE_MAX_VLAN_PER_VF on the PF side?
>
> iavf enforces its own cached copy through iavf_get_max_vlans_allowed(),
> so the VF will not try to add more VLANs until it renegotiates. That
> seems to contradict this line in the commit message: "we can just set
> the capability flag to allow privileged operations".
>
> Revoking trust from a clean VF also takes this branch. Does the
> untrusted VF keep the VLAN_N_VID quota? The legacy path in
> ice_vf_has_max_vlans() checks ice_is_vf_trusted() at the time of each
> request, so the V1 and V2 paths would disagree for the same VF.
>
> The notes on this version describe the cache invalidation as part of
> the existing reset/rebuild design. Before this patch, though, every
> trust change went through ice_reset_vf(), so the caps were always
> renegotiated. The new branch is what lets the cache go stale.
>
> iavf caches max_filters too. Would a VLAN_V2 VF need to renegotiate its
> caps (through a reset or something equivalent) whenever its trust
> setting changes?

The VLAN_V2 caps cache invalidation is part of the reset/rebuild path
by design (ice_vf_set_initialized()). This patch does not change that
architecture, it only adds a conditional to skip the reset when no
advanced features are configured.

On the grant path: the VF stays limited to ICE_MAX_VLAN_PER_VF until
the next reset or renegotiation. This is conservative behavior, the VF
is more restricted than expected, not less. No security or stability
issue. The iavf driver also caches its own limit and will not try to
add more VLANs, so both sides are consistent.

On the revoke path from a clean VF: the stale VLAN_N_VID cache would
allow more VLANs on the PF side, but the iavf driver enforces its own
cached limit and will not attempt to exceed ICE_MAX_VLAN_PER_VF. The
V1 path checks trust at request time, which is correct.

