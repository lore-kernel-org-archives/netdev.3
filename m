Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF73C3456
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020639; cv=none; b=MPfCHR0irruVzoKdiB9IWwMPS/y4vzQRFWPN9szT0hF0WgixwP/vXsag/hLoTm86TQBMq6wP/cy65UhIQc6eM07r26v6ykqHqXq/9ykcVxEEA/RfkzKWM1xqVKMcAWq/CPOmhJUslFJJjgn51Y3f4/BWSQ1E69fCqZitQSP2FC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020639; c=relaxed/simple;
	bh=bbTMMP0+5XoF+YEwTEj6kNz4bx4K8twk2twWvcI9unI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vC2u+dv5mbPmdm61gefZcofdue/5iGrwVCy4aKC7fFOylLtD4W3dzfIfXz0uI8gBzrNIDQI0+hUPsMo6B4IrnC1azCKKIaUdBQYUI1ue1BGirwKPJD2zHuwL5ptuOy2a5TgaT7/3KqMH6U0sk1tYR5l4l5sdwK2RIyRq40s+CUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOPJ5MO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOPJ5MO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E81F00893;
	Mon, 21 Sep 2026 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020637;
	bh=e4zKNBstCmYZ7OxO5x16a0aPsoip0NhF6FLCaDMcKf8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AOPJ5MO2NHU3r8j8Aw9dnpvA9Xgx5YagFgco/w1EbthvpON2V8BSr68bnBae4e3dr
	 0/aOjfO1PouQQhZgZskH8NDxlZnLQkd0nnuTojqLygEUWhzrCYrHzHYRRcwuR9uVPr
	 ugWM9mna4ySMDpZaYhvBPu90dcz9pwbrp6Bld/GsLACzW1QWbAZ3d8D8KtAER0oR+F
	 /+RsYsrc+0LN5uSdqEDZOyasZXKHIs2UQIf/g5/m+ECih4+BbHTpSU1bIb5iPmfDZ+
	 kfhppeVmhYhcJ/EajNgT/7gy6RaOmgz+MuG014pRg8EtxEDDcwjVUSdtwyMJ74Tmgb
	 KP1d8NIpgiXdA==
Subject: Re: [PATCH net-next v2 01/12] ice: rename shared Flow Director
 functions and structs
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 lukasz.czapnik@intel.com, marcin.szycik@linux.intel.com,
 aleksandr.loktionov@intel.com, sandeep.penigalapati@intel.com,
 ananth.s@intel.com, alexander.duyck@gmail.com, sx.rinitha@intel.com
Date: Mon, 21 Sep 2026 19:57:16 +0000
Message-ID: <179002063608.2160803.374435720092544073@kernel.org>
In-Reply-To: <20260917183927.2692068-2-anthony.l.nguyen@intel.com>
References: <20260917183927.2692068-2-anthony.l.nguyen@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Kernel-doc for the renamed ethtool entry points advertises
  functionality this patch does not implement: ice_add_ntuple_ethtool()…

--

ice: rename shared Flow Director functions and structs

This renames the shared Flow Director helpers and struct ice_fdir_fltr to
use an 'ntuple' prefix, moves ice_fdir_update_cntrs() into the ethtool
file as a static ice_ntuple_update_cntrs(), and renames
ice_ethtool_fdir.c to ice_ethtool_ntuple.c.  The stated goal is to prepare
these entities for also handling ACL filters.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> similarity index 96%
> rename from drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> rename to drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index aceec184e89b2..744cd0b824703 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c

[ ... ]

> @@ -1746,18 +1765,18 @@ ice_fdir_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
>  	ice_fdir_list_add_fltr(hw, input);
>  	/* update sb-filters count, specific to ring->channel */
>  	ice_update_per_q_fltr(vsi, input->orig_q_index, true);
> -	ice_fdir_update_cntrs(hw, input->flow_type, true);
> +	ice_ntuple_update_cntrs(hw, input->flow_type, true);
>  	return 0;
>  }
>  
>  /**
> - * ice_del_fdir_ethtool - delete Flow Director filter
> + * ice_del_ntuple_ethtool - delete Flow Director or ACL filter
>   * @vsi: pointer to target VSI
> - * @cmd: command to add or delete Flow Director filter
> + * @cmd: command to add or delete the filter
>   *
> - * Returns 0 on success and negative values for failure
> + * Return: 0 on success and negative values for failure
>   */
> -int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
> +int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)

[Severity: Low]
This isn't a bug, but should the kernel-doc here describe only what this
commit implements?

At this commit ice_del_ntuple_ethtool() returns -EOPNOTSUPP unless
ICE_FLAG_FD_ENA is set, and the only programming path is
ice_ntuple_update_list_entry() -> ice_fdir_write_all_fltr(), which
unconditionally does Flow Director programming and maintains
hw->fdir_fltr_cnt[]:

	if (old_fltr) {
		err = ice_fdir_write_all_fltr(pf, old_fltr, false);
		if (err)
			return err;
		ice_ntuple_update_cntrs(hw, old_fltr->flow_type, false);

There is also no discriminator in struct ice_ntuple_fltr at this commit for
telling an ACL-backed rule from a Flow Director rule; the bool acl_fltr
field and the ice_del_acl_ethtool() dispatch only appear in later patches of
the series (ending with "ice: use ACL for ntuple rules that conflict with
FDir").  Would it be clearer to keep the wording Flow Director here and
update it in the patch that actually adds ACL handling?

[ ... ]

> @@ -1968,17 +1989,17 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
>  }
>  
>  /**
> - * ice_add_fdir_ethtool - Add/Remove Flow Director filter
> + * ice_add_ntuple_ethtool - Add/Remove Flow Director or ACL filter
>   * @vsi: pointer to target VSI
> - * @cmd: command to add or delete Flow Director filter
> + * @cmd: command to add or delete the filter
>   *
> - * Returns 0 on success and negative values for failure
> + * Return: 0 on success and negative values for failure
>   */
> -int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
> +int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)

[Severity: Low]
Same question for ice_add_ntuple_ethtool().  The body at this commit only
builds a Flow Director extraction sequence via ice_cfg_fdir_xtrct_seq(),
checks Flow Director capacity with ice_fdir_num_avail_fltr(), and programs
via ice_fdir_write_all_fltr(), so the "or ACL filter" part of the summary
line has no corresponding code yet.

The ACL dispatch (ice_acl_add_rule_ethtool()) arrives in a later patch of
this series, so by the end of the series the wording is accurate; is the
forward-looking wording here intentional?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
> index 820023c0271fd..54f51ae31b402 100644
> --- a/drivers/net/ethernet/intel/ice/ice_fdir.h
> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
> @@ -160,7 +160,7 @@ struct ice_fdir_extra {
>  	__be16 vlan_tag;	/* VLAN tag info */
>  };
>  
> -struct ice_fdir_fltr {
> +struct ice_ntuple_fltr {
>  	struct list_head fltr_node;
>  	enum ice_fltr_ptype flow_type;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917183927.2692068-1-anthony.l.nguyen%40intel.com
