Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689141687C;
	Sat, 12 Sep 2026 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202272; cv=none; b=pTVbP3GhJVgfMBjS1Wmez10qHMYjnRZjSCA2Iv7bkSXZHj7zhLpkmTXVXNFJlUyGKDlfv0DPbLQH9gx9T0drfltmZyNZ9WLyoVpOEZ2eTmbX8an+SGDV0W2GXSv8DBXPRi0LNswAPQA9WXXe6DZlF5v7droPFnU09bCvu7LVIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202272; c=relaxed/simple;
	bh=Gj09fJ9V4OZsg5iz7GNjMgtPI9SxAuiQgKDkJgTydR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7BMekrvOz7LpF9/y/oLYh+qZecT8XkcCBoosX6ga43tsP26w8lZNix2fUPodEQZ+TLJ6vQHsIF7tqU5pwOumd10FwpHZq3cL441hxFi/P0tr8ChUf2eBfxbRRKV6l9JVMKAYEfaXrcykmBEPaDWfwv22RsCGIpPRh2nSVTArrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0hcuqMR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0hcuqMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44571F000FF;
	Sat, 12 Sep 2026 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202269;
	bh=jYuQLTMwiyaPE07yAyZPAsztTLqGZd4PsNnTSOMeCMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0hcuqMRhFQD49vP9s9+MnKvk5ZreRqyFPMJbXdEaPn3H0OKuP1csff7WrV/011rx
	 7izYLupgqhPUCn0qldD6oktyMvZJKjH9hh4UyHy6QnAleccklxH0HTsd43a8DabXHt
	 8LVL3wioH3hP4KN20+xU4lXrIXyoijeHyY2MMB7lt337vFZBrRquOT42cWE0eIHhdm
	 AkSdXnnBM51VbadjzuzpV6Yc0aqndzM0SrzkLFLlM1+nIhY/zffG+HM7qWkCMJQi9z
	 ndjgGhRMma1cDRBjuGSVLf2SRqXBAJ/3E0YXtCDzNV1a8D5ziTbBTrhGJktguN5QfB
	 JMBSyJ+2ZLSyg==
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	priyalee.kushwaha@intel.com,
	kiran.patil@intel.com,
	wojciech.drewek@intel.com,
	michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 2/2] ice: don't offload drop filters that bypass higher priority filters
Date: Sat, 12 Sep 2026 09:36:44 +0100
Message-ID: <20260912083645.145790-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910154824.3603687-3-poros@redhat.com>
References: <20260910154824.3603687-3-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260910154824.3603687-2-poros@redhat.com?part=2
---
ice: don't offload drop filters that bypass higher priority filters

This commit tracks software-only TC filters to prevent the hardware from
incorrectly offloading lower priority drop rules that would override them.
It tracks un-offloaded filters within a device block and rejects conflicting
drop offloads.

> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
[ ... ]
> @@ -2269,6 +2269,112 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
[ ... ]
> +static void ice_tc_track_sw_fltr(struct ice_pf *pf,
> +				 struct net_device *filter_dev,
> +				 struct flow_cls_offload *cls_flower,
> +				 enum ice_eswitch_fltr_direction direction)
> +{
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
> +		if (sw_fltr->cookie == cls_flower->cookie)
> +			return;

[Severity: High]
Does this early return break tracking for TC shared blocks?

When a shared block is bound to multiple interfaces, the driver will only
track the cookie for the first interface because this check returns early
when it sees the same cookie.

> +
> +	sw_fltr = kzalloc_obj(*sw_fltr);
[ ... ]
> +static bool
> +ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_dev,
> +			  u32 prio, enum ice_eswitch_fltr_direction direction)
> +{
> +	struct ice_tc_flower_fltr *fltr;
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
> +		if (sw_fltr->filter_dev == filter_dev &&

[Severity: High]
Because the tracking entry is bound strictly to the first interface's
filter_dev, won't this check fail to protect other ports sharing the same
block?

> +		    sw_fltr->direction == direction && sw_fltr->prio < prio &&
> +		    !sw_fltr->is_drop)
> +			return true;
[ ... ]
> @@ -2336,6 +2471,9 @@ ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
>  	struct ice_pf *pf = vsi->back;
>  	int err;
>  
> +	if (ice_tc_untrack_sw_fltr(pf, cls_flower->cookie))
> +		return 0;
> +

[Severity: High]
When deleting a filter from a shared block, the first net_device will delete
the unique tracking entry here. Won't subsequent callback invocations for the
other ports in the shared block fall through to the hardware failure path
and incorrectly return -EINVAL?

>  	/* find filter */
>  	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
>  	if (!fltr) {

Later in ice_del_cls_flower(), the filter is removed and freed:

drivers/net/ethernet/intel/ice/ice_tc_lib.c:ice_del_cls_flower() {
    ...
	/* delete filter from an ordered list */
	hlist_del(&fltr->tc_flower_node);

	/* free the filter node */
	kfree(fltr);
    ...
}

[Severity: High]
This is a pre-existing issue, but is it safe to modify tc_flower_fltr_list
and free the filter here?

While this runs under the rtnl_lock, the background device reset task
(ice_reset_subtask) calls ice_rem_all_chnl_fltrs(), which iterates over
pf->tc_flower_fltr_list and frees filters using kfree() without holding
the rtnl_lock or any driver-specific lock protecting the list.

Could this concurrent access during a hardware reset result in list corruption
or a use-after-free?
