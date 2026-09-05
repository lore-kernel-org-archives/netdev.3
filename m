Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634D35E926;
	Sat,  5 Sep 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626823; cv=none; b=pNRAhIUSVOFZC7mOlwvzNlwVGSGk/5VbdfokDVcXgO0lVFE5PzDpRmt4YYDlDxcowojEgtCNy6US3L25J4LwPxAG77M0LSUfHS6atV2WkUOme26jRsilxERNf8XE7RgpqDSPlgOntHHdMikH5TUjqNYSLl4WMq1utAI1cC6GeyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626823; c=relaxed/simple;
	bh=g1t0zFKzI4JtwTZki0m0h25T/+wfOW+X+j9Gq5OOu/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckMG2Yn8UK2TyEWX95+wOSUY5elwkVTNW0is74zE/CarZt0OqsfJhp/AVAHyYLDFsCHe5BGy27uv4RqwDYXvA0TjzohUszSQsd0hznOl41wMNKk5ttwwk+pxMpmqqOiPPrvLoKofsqxJvmLg3GYtThhw5E/IJY2lrNDRJgrPyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqWNb3ED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqWNb3ED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D49D1F00A3A;
	Sat,  5 Sep 2026 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788626821;
	bh=9Tjn9kv1hxb46aSkL0y6J6BeizBOSInInYI9R08z21U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EqWNb3EDnTcI/6DXDaeNxh+n9tWBIOmuE79v9CqJiW7vZmVLJS0Csma4b1BSDMe8k
	 Xu1ytVRnn7IaAZfzUj8de2kGCMDaU7ldImjVvXmpkMeSWT2epjINvzT2cZanX4wsbc
	 5MLbok9cMNj3WL1IKu3bmlpWgM3KHxgD3a3voYC7qRj0ErjaBvIhTgwcDhGlvdcf4R
	 G4kr169I4qnchlarD22vurO7zrhYMhlnV3/MxRXCgtcX/vCNNHULV4TM81nSinfiFA
	 FLGLlbcylN0HfXnUps+8y/unif3IzWQkfiGJ1XSQ5FE4mTgpqPK0ivupjersDavtrG
	 BYXaYUU0gfUvQ==
Date: Sat, 5 Sep 2026 17:46:57 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Henry Tieman <henry.w.tieman@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH 2/2] ice: clear Flow Director entries before reset cleanup
Message-ID: <20260905164657.GB40544@horms.kernel.org>
References: <20260903074706.602087-1-aaron.ma@canonical.com>
 <20260903074706.602087-2-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903074706.602087-2-aaron.ma@canonical.com>

On Thu, Sep 03, 2026 at 03:47:06PM +0800, Aaron Ma wrote:
> Flow Director profiles retain handles to generic flow entries. Reset calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow Director
> handles unchanged until replay replaces them.
> 
> If rebuild fails before replay completes, later driver removal follows a
> stale handle and dereferences a freed flow entry in ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
> 
> The failure is reported as:
> 
>   KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>   RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>   ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
> 
> Clear the Flow Director handles before the hardware tables free their
> entries. A successful replay installs new handles, while a failed rebuild
> leaves them invalid for later cleanup.
> 
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 21 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c4..4739ff882b9ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
>  		      u32 *rule_locs);
>  void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);
>  void ice_fdir_release_flows(struct ice_hw *hw);
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw);
>  void ice_fdir_replay_flows(struct ice_hw *hw);
>  void ice_fdir_replay_fltrs(struct ice_pf *pf);
>  int ice_fdir_create_dflt_rules(struct ice_pf *pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index aceec184e89b2..faa16b5a12c0d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -428,6 +428,27 @@ void ice_fdir_release_flows(struct ice_hw *hw)
>  		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);
>  }
>  
> +/**
> + * ice_fdir_clear_flow_handles - clear handles freed during reset
> + * @hw: pointer to HW instance
> + */
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw)
> +{
> +	int flow;
> +
> +	for (flow = 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		struct ice_fd_hw_prof *prof = hw->fdir_prof[flow];
> +		int tun, i;
> +
> +		if (!prof)
> +			continue;
> +
> +		for (tun = 0; tun < ICE_FD_HW_SEG_MAX; tun++)
> +			for (i = 0; i < prof->cnt; i++)
> +				prof->entry_h[i][tun] = 0;
> +	}
> +}
> +
>  /**
>   * ice_fdir_replay_flows - replay HW Flow Director filter info
>   * @hw: pointer to HW instance
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index a97a1941cec6a..7aa1235447310 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>  		netif_device_detach(vsi->netdev);
>  skip:
>  
> +	if (hw->fdir_prof)
> +		ice_fdir_clear_flow_handles(hw);
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
>  	/* disable the VSIs and their queues that are not already DOWN */

Hi Aaron,

There is an AI-generated review of this patch available at
https://sashiko.dev/#/patchset/20260903074706.602087-1-aaron.ma%40canonical.com?part=2

Of that review, the following seems relevant.
And I'd appreciate it if you could comment on it.

  Does calling ice_fdir_clear_flow_handles() here modify prof->entry_h
  locklessly from the reset task?

  If an ethtool command to add or remove a Flow Director rule executes
  concurrently with a PF reset, ice_add_fdir_ethtool() checks the reset flag
  locklessly and then acquires hw->fdir_fltr_lock. Can this result in a data
  race if the reset worker clears the array without holding the lock while the
  ethtool thread updates it?
