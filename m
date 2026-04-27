Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE963D6CB6
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308744; cv=none; b=navtfbatZ8Ilksp0auJIeoR+OkfVMnoNbt11evchoCjz8udtBE1gnKZw36FOMG9WPy8htEB6/BLBfqy+llOrqxqonoUJq6JChdhyXzsM2CeBKYyWeOWuJo1F8hdGwxz6mFDPB8qEvZlH9uM4E8ihx540YtOq5huWvxKNC9osCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308744; c=relaxed/simple;
	bh=ETP5cbZBx5BXdzQHP8lPfMRyGrQXvV0TD9QSKFc4srE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJnDtjmymjZePwwKje/u8ow0qIj2pSBHIwKLTfX+vaarQ0AzyCcuyWr+iQujMy/IPFnfesvX3pMbkJtr4leZrpBE6eo7rcH3ssu8Uuuu5OLZvSRVXq76dPvEqbtIx4VAXNcVJz+OVt8rJtFg9EAapaH+5flOzgwUGop5TavOtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMiD9d/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMiD9d/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34AAC19425;
	Mon, 27 Apr 2026 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777308744;
	bh=ETP5cbZBx5BXdzQHP8lPfMRyGrQXvV0TD9QSKFc4srE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMiD9d/gnr+BdZknfY5sngLMZIcEnTQ7MPCD+wG+GIE8sWtujrLosR3Kg76IoB/x4
	 RmbsYiy7jF4ZMGnnZvFHxVGjPtlXmooPqIjl8V71nI7qS701xa+NaB1oE2fC9SWotQ
	 1knxWGrtAjoLGfGNDM1vv/1Mtg5L9p7ISN8ZHrzU7T3IJOOJbEwHwS9Fy7Nr7UwKH+
	 JFNbLDea0DVJLVqZyZKHYMStfzQBVtoZpIvUv4dwLwepdzy5R89xrykQYPHZZua0Nu
	 tskggTbfZ64hOS3Ai4xJypY/TDSf2caO6e3fclKV1/mvW2GDHHaJY5A/VXtMyYowHB
	 eZs1kFyofFi4Q==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v4 4/4] ice: skip unnecessary VF reset when setting trust
Date: Mon, 27 Apr 2026 17:50:45 +0100
Message-ID: <20260427165045.1228721-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423130405.139568-5-jtornosm@redhat.com>
References: <20260423130405.139568-5-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: skip unnecessary VF reset when setting trust

This patch attempts to optimize VF trust setting changes by skipping the VF
reset when granting trust, and only resetting when revoking trust if MAC LLDP
filters are present. It also fixes a race condition by doing the reset before
clearing the LLDP filters.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756ddc..8686c382404f3f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
[ ... ]
> @@ -1399,11 +1427,16 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>  
>  	mutex_lock(&vf->cfg_lock);
>  
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> -
> +	/* Reset only if revoking trust with MAC LLDP filters */
> +	if (!trusted && vf->num_mac_lldp) {
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);

Does ice_reset_vf() clear vf->num_mac_lldp to 0 when it calls
ice_vf_pre_vsi_rebuild() internally?

If so, does this make the following while loop dead code, bypassing the
ice_vf_update_mac_lldp_num() calls that cleanly decrement the count and
trigger ice_vsi_cfg_sw_lldp() to clean up the LLDP software switch rules?

> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> +	} else {
> +		ice_setup_vf_trust(vf, trusted);
> +	}

If we revoke trust (!trusted) and vf->num_mac_lldp > 0, we enter the if block
and skip the else block containing ice_setup_vf_trust().

When ice_reset_vf() rebuilds the VSI, vf->trusted is still true. Will the
rebuild process use this true value to set the ICE_VIRTCHNL_VF_CAP_PRIVILEGE
bit in vf->vf_caps?

Since ice_setup_vf_trust() is skipped, does this fail to explicitly clear the
privilege capability bit? Could a malicious VM add a MAC LLDP filter before
trust is revoked to ensure num_mac_lldp > 0, thereby retaining its privileges?

Furthermore, when revoking trust and vf->num_mac_lldp == 0, we take the else
branch and skip ice_reset_vf().

Trusted VFs are permitted to allocate more than ICE_MAX_MACADDR_PER_VF or
ICE_MAX_VLAN_PER_VF limits. Previously, the unconditional ice_reset_vf()
would tear down the VSI and purge these extra non-default filters.

Without the reset, is there any logic in ice_setup_vf_trust() to prune the
extra MAC and VLAN filters that were added while the VF was trusted? Will
skipping the reset allow an untrusted VF to retain excessive hardware filters
indefinitely and potentially exhaust PF resources?

>  	vf->trusted = trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>
