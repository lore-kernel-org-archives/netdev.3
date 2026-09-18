Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317A330D43
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737106; cv=none; b=OkZRP13H4dQ4FCjvssz6Ay8zXXHfSxPxP0Hd5gXXRLYKCwqOnGv/lPPqyLoZBPBYNJl/JwTr90PJVgHqnRZdeVYvZBQSav+/995ppOZv+zLt+UpBfID1rSyH+bvCmuEyzv1fgyW/TJSFIf4KyXaUCXRobVJxMPI41gbuwOgs3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737106; c=relaxed/simple;
	bh=OrsDueolDB48ZiSn/3OL7AJT7dY/bOm5zXfF8rvHKZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCgVJZUZ3IilQRIJ6uMkiaGsZYpn2jhboCDfCCU2u20/kHClZ3SdYbyYtU2KjrFsltMqO6CjeDzapMgABG8lkC2P41GRj+iFWVOx/N5Q3mhAzFQnOnVwuX9Em5zfY0dktr4qKcYtVpxuUqf2bhh7Kpbm+rkE629cJa/upgpzkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llEe6m1U; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llEe6m1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789737104; x=1821273104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OrsDueolDB48ZiSn/3OL7AJT7dY/bOm5zXfF8rvHKZo=;
  b=llEe6m1UY+d8AFmy1dWuaLNdAkBXbLZcVDgSBaHdvQgSqxx+oPI8ocuV
   lEXkSpu1vxaeVJxLVTayfcXq5RYEmhfw0dD1/WEiZLTnGosb+Rq72QbAz
   eC7kUVSTQUzSQzkNrDEd11M1MweDu9HGiyg/I8tfCnLA4KpkK9BFvz054
   BMYMOdb4Vj+0pZ90Vo0V9QslvZhmvU+QN9vRNljilCTHOl1CPdzf7zcSO
   SBHSKfl2sgl/vpqt5PSe3pB0zJRo+NLXMbN4w/1LyQ+4jM0xbVH6yuUyO
   jNFTZtauJoziIubR6QUG+EtUNc0CBAOlhGvzVjpRxnujqibz5dRhsERo8
   Q==;
X-CSE-ConnectionGUID: gWxiLsiHT8ak7Ez/zJ9Jaw==
X-CSE-MsgGUID: +Mgn2blGTkiJGKLbuZsHJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89377241"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89377241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:11:43 -0700
X-CSE-ConnectionGUID: Hk5X61dyT6+ZX9/9ZYRvrg==
X-CSE-MsgGUID: Uyx18gd7SZKuT071NFmA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270092049"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:11:43 -0700
Received: from [10.246.40.5] (unknown [10.246.40.5])
	by linux.intel.com (Postfix) with ESMTP id 688C120B5708;
	Fri, 18 Sep 2026 06:11:41 -0700 (PDT)
Message-ID: <da315e5f-b71f-4c8c-8705-94f530ff3f25@linux.intel.com>
Date: Fri, 18 Sep 2026 15:11:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
 <20260917094312.1567881-2-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260917094312.1567881-2-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.09.2026 11:43, Aleksandr Loktionov wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
> index 21f3b61..9ae7de2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -1105,6 +1105,45 @@ static int ice_determine_css_hdr_len(struct ice_hw *hw)
>  	return 0;
>  }
>  
> +/**
> + * ice_parse_erot_presence - detect eRoT and populate hw->erot_present
> + * @hw: pointer to the HW struct
> + *
> + * Uses the device capability LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT when
> + * advertised by firmware, falling back to the eRoT Presence fuse only when
> + * the capability is not advertised at all (older firmware).
> + *
> + * Priority:
> + *  1. Device capability external_pqc_rot_present (advertised && == 1)
> + *     => eRoT present
> + *  2. Fuse BIT(0) set (only when capability not advertised)
> + *     => eRoT present
> + *  3. Otherwise => eRoT not present
> + */
> +void ice_parse_erot_presence(struct ice_hw *hw)
> +{
> +	u16 fuse = 0;
> +	int err;
> +
> +	hw->erot_present = false;
> +
> +	if (hw->dev_caps.common_cap.external_pqc_rot_present) {
> +		hw->erot_present = true;
> +	} else if (!hw->dev_caps.common_cap.external_pqc_rot_present_cap_advertised) {
> +		err = ice_read_sr_word(hw, ICE_SR_EROT_PRESENCE_FUSE, &fuse);
> +		if (err)

On a read failure the code assumes erot_present = false, i.e. fails open on a mechanism whose whole purpose is preventing bricking from partial updates. A transient SR read failure on real eRoT hardware silently disables the guard in patch 2. Consider treating a read failure as erot_present = true instead, or justify why fail-open is safe here.

> +			dev_warn(ice_hw_to_dev(hw),
> +				 "Unable to read eRoT presence fuse (SR 0x%04x), err %d; assuming eRoT not present\n",
> +				 ICE_SR_EROT_PRESENCE_FUSE, err);
> +		else if (fuse & ICE_EROT_PRESENCE_FUSE_PRESENT)
> +			hw->erot_present = true;
> +	}
> +
> +	if (hw->erot_present)
> +		dev_info(ice_hw_to_dev(hw),
> +			 "eRoT (external Root of Trust) present\n");
> +}
> +
>  /**
>   * ice_init_nvm - initializes NVM setting
>   * @hw: pointer to the HW struct
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
> index e1d1a11..4b31dfc 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.h
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
> @@ -28,7 +28,12 @@ int ice_get_inactive_nvm_ver(struct ice_hw *hw, struct ice_nvm_info *nvm);
>  int
>  ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *netlist);
>  int ice_read_pba_string(struct ice_hw *hw, u8 *pba_num, u32 pba_num_size);
> +/* eRoT Presence fuse SR offset; BIT(0) set means eRoT present */
> +#define ICE_SR_EROT_PRESENCE_FUSE	0x1016
> +#define ICE_EROT_PRESENCE_FUSE_PRESENT	BIT(0)

Commit message and function doc describe the fuse as "bits[1:0]", but only bit 0 is checked/masked. Please confirm with the fuse spec whether bit 1 is truly unused, or whether this needs GENMASK(1,0) with a specific expected value.

> +
>  int ice_init_nvm(struct ice_hw *hw);
> +void ice_parse_erot_presence(struct ice_hw *hw);
>  int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data);
>  int
>  ice_aq_update_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,


