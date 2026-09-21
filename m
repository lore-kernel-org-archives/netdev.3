Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86B3D25D7
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020644; cv=none; b=FWY5PxQTIStx1ZTT3bkEyDcbG91nGjA2yCjxlfdt18pAqZNpa3LDTedL5XlxVxPuYwA6rRvkLch0Tza5AyJN50byt+uyH1FaIa1uAVS01pu78Qaf0CsKPUP0b3WcbNBw6rRksVOVJC8h+Sl0Wdm03uwCipN3BD1dySQA+Tn7/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020644; c=relaxed/simple;
	bh=hCk60R+HOG7mMf8TnQfb/8bLBCn6FaUXo+oQcPJpUCc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URjfCDEW7kGgG/O6gM4raGp31moG1XGOZlrtcljaJgbT1SHs3mj0nHWnmY2mmyV5yG71osdpTIrvofPGDNl75vj3L2d9lNoZBZ2LUr+gd+eC1JcmuWkBWEBMbAFgYkv+/dCn3pyBLid+MSTVNunZWp0A6j+8wqc9N0LppX8osXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBUNkVbS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBUNkVbS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3DC1F00898;
	Mon, 21 Sep 2026 19:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020643;
	bh=hyoS1841bofj3h3hLZJZoi9yj1zYoQrb6o1BbYlAaJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RBUNkVbSFQKZ3O8vh9ks0yEZ6Erkoo4KYU4ak2Uz8ek4vliI4LgEZ0pMDfLhKrSms
	 o2SGUlbHvWIlKpsZ/kIOaUasC4VI2Dojns5W4EXPV6aeW53YVdnTgStT1A/556zWYS
	 v7nDEWn+UV14i0Dv4nAn1k02c1h11DInTCJFog7gRy9buGoTKxbmeGHxN26ImQSztJ
	 eLWX3i78jaFlckh2e8whocNVzHZWwlrHNObSGCUJ22YOPtFagrnnnv5p13unt45OVL
	 /utlBKHz/LBPmqoCzN408Mj/9KAw7rWT/c4tBqeuaapA8uQ4ZnXHC7hbXaAg1IENma
	 Q905QxODtd0/Q==
Subject: Re: [PATCH net-next v2 07/12] ice: use plain alloc/dealloc for
 ice_ntuple_fltr
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:21 +0000
Message-ID: <179002064184.2160803.3596499508560580652@kernel.org>
In-Reply-To: <20260917183927.2692068-8-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-8-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ice_add_ntuple_ethtool()
  (drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c:2262) now…

Pre-existing issues:
- [High] hw->fdir_list_head is documented as being protected by
  hw->fdir_fltr_lock (see the comment on ice_fdir_del_all_fltrs(),…

--

ice: use plain alloc/dealloc for ice_ntuple_fltr

This converts struct ice_ntuple_fltr from devm_kzalloc()/devm_kfree() to
kzalloc_obj()/kfree(), on the grounds that the filter objects are always
torn down explicitly on device remove.  Four call sites in
ice_ethtool_ntuple.c are updated.

A couple of questions below about the teardown assumption and about the
readers of hw->fdir_list_head.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index afeda21109409..0c088e6261438 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -1806,7 +1806,7 @@ void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
>  		ice_fdir_write_all_fltr(pf, f_rule, false);
>  		ice_ntuple_update_cntrs(hw, f_rule, false);
>  		list_del(&f_rule->fltr_node);
> -		devm_kfree(ice_pf_to_dev(pf), f_rule);
> +		kfree(f_rule);
>  	}
>  }
>  
> @@ -1907,7 +1907,7 @@ ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
>  			 */
>  			ice_fdir_do_rem_flow(pf, old_fltr->flow_type);
>  		list_del(&old_fltr->fltr_node);
> -		devm_kfree(ice_hw_to_dev(hw), old_fltr);
> +		kfree(old_fltr);

[Severity: High]
This isn't a bug introduced by this patch, but since this patch is now the
code doing the freeing, is the reader side of hw->fdir_list_head safe
against these kfree() calls?

The comment on ice_fdir_del_all_fltrs() states the list is protected by
hw->fdir_fltr_lock, and the writers do take it (ice_ntuple_update_list_entry()
via ice_add_ntuple_ethtool()/ice_del_ntuple_ethtool(), ice_vsi_manage_fdir(),
ice_remove_q_channels()).  But ice_fdir_replay_fltrs() walks the same list with
no lock at all:

drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c:ice_fdir_replay_fltrs() {
	list_for_each_entry(f_rule, &hw->fdir_list_head, fltr_node) {
		int err;

		if (f_rule->acl_fltr)
			continue;

		err = ice_fdir_write_all_fltr(pf, f_rule, true);
		...
	}
}

and it runs from the service task, ice_reset_subtask() -> ice_rebuild() ->
ice_fdir_replay_fltrs(), without rtnl_lock and without hw->fdir_fltr_lock.

The reset-in-progress test in ice_del_ntuple_ethtool() and at the top of
ice_ntuple_update_list_entry() is evaluated before the slow part of the
writer: ice_fdir_write_all_fltr() -> ice_fdir_write_fltr() does GFP_KERNEL
allocations and HW programming and can sleep for an unbounded time, and only
after that does the writer run:

		list_del(&old_fltr->fltr_node);
		kfree(old_fltr);

So can the replay walk end up dereferencing a node that was just kfree()d,
including reading fltr_node.next after list_del() has set it to
LIST_POISON1?

The mirror case exists too: ice_add_ntuple_ethtool() calls
ice_fdir_find_fltr_by_idx(), which walks the list, before
mutex_lock(&hw->fdir_fltr_lock), so it can traverse nodes that
ice_prepare_for_reset() -> ice_remove_q_channels() -> ice_fdir_del_all_fltrs()
is freeing in the service task.

This same shape is still present at the tip of the series, with
ice_fdir_replay_fltrs() still lockless.

> @@ -2259,7 +2259,7 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
>  		return -ENOSPC;
>  	}
>  
> -	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
> +	input = kzalloc_obj(*input);
>  	if (!input)
>  		return -ENOMEM;
>  

[Severity: Medium]
The commit message says:

    All such objects are being removed on device remove via
    ice_deinit_features() -> ice_deinit_fdir() -> ice_vsi_manage_fdir() ->
    ice_fdir_del_all_fltrs()

Is that always true?  ice_deinit_features() bails out first thing in Safe
Mode:

drivers/net/ethernet/intel/ice/ice_main.c:ice_deinit_features() {
	if (ice_is_safe_mode(pf))
		return;

	ice_deinit_lag(pf);
	...
	ice_deinit_fdir(pf);
	...
}

A device that was fully featured when the filters were installed can later
move into Safe Mode at runtime: ice_rebuild() reloads the package after
CORER/GLOBR,

		else
			/* Reload DDP Package after CORER/GLOBR reset */
			ice_load_pkg(NULL, pf);

and when ice_init_pkg() fails, ice_load_pkg() does:

	if (!ice_is_init_pkg_successful(state)) {
		/* Safe Mode */
		clear_bit(ICE_FLAG_ADV_FEATURES, pf->flags);
		return;
	}

with ice_is_safe_mode() defined as !test_bit(ICE_FLAG_ADV_FEATURES,
pf->flags).  ICE_FLAG_FD_ENA is not cleared there, so the entries stay on
hw->fdir_list_head (ice_fdir_replay_fltrs() keeps them, and
ice_fdir_del_all_fltrs() only runs from ice_prepare_for_reset() when ADQ
channels exist).

In that state, does unbind leak every installed struct ice_ntuple_fltr, since
ice_deinit_fdir() -> ice_vsi_manage_fdir() -> ice_fdir_del_all_fltrs() is
never reached and devres no longer reclaims the objects?  The same structure
is present at the tip of the series, so nothing later frees them either.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
