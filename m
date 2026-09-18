Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD794F3EAF
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737670; cv=none; b=HP8vQ/CMFPwbBHvEF1ly07psRZhI7C0cnS/+Jy7HF3XrZ9XF1dx/rPD0WlMZpo1PX1bVPabw/5ISVSkIwnKtbTQN5OJybunPZBnQ3PRVqdgENXZkqV9gWuyoTNL1gtpTGfyZe3ed3hbcujVs8gkPRtUOAP/2vaPmt4KxUDDpYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737670; c=relaxed/simple;
	bh=IA2rsTc+PxLml4S/5TdF0FD6CQXNPkVFWayEW4455Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKrJ9sa4LsOx1ZFVwHcgowbk1bLQu5WmLWcXKJ8Vha1ruP7pztSk9P4zpZM+RGuhcEJa8HVDjDk/6ojimt2Adsyzbz0JM9gXZHI9ZsC0/zX3Q1h1l7Afc+cQsDNGkspENWQ6yk4i5hR7zFcCrOr7Ud8FTYefvJkl5iJ5Be18P1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY/LDeWu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY/LDeWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789737668; x=1821273668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IA2rsTc+PxLml4S/5TdF0FD6CQXNPkVFWayEW4455Wc=;
  b=OY/LDeWuotvhBaAhyVNNkVeKT2xy/6jeePdBFT05KcOg8Z+EilwPYQlw
   vb+MQhVhPnYwv7a65Oyu6t8o2WJvEw2jdqkqNDFwu4ir4DkfQQ6a2L2d7
   1k0+5S+KjqZhzH8GEq7OC7C4T7FS6H7daxl9gU7+dGqxd+B/kMnTIjtu0
   7cGB9YuhmZ0XBGGfauexJwbS1XR8rCRYRCo7bCtwRT/41ymO1izbxCNfI
   +nEd12hB8sfRvZY9tPw4s6Mm1V5EcQpqTaBkodAauPLzvWPczjgor2lRC
   pr3TMNBRc5dsh6DMk9fBuKBy1L9AKfG/iVRX4sZPvp/W3r0PB7IzIt8e6
   g==;
X-CSE-ConnectionGUID: 5dMGyN4EQx+Tz55ruYKS7Q==
X-CSE-MsgGUID: u0qMNnSnTV2ZTfJboFqavA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="107745372"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="107745372"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:21:07 -0700
X-CSE-ConnectionGUID: dLkaI1PsRLO+pPt4TQgJ4w==
X-CSE-MsgGUID: HVtyOs/lQoiW5s7Tm2LZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="268144043"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:21:07 -0700
Received: from [10.246.40.5] (unknown [10.246.40.5])
	by linux.intel.com (Postfix) with ESMTP id EFDB020B5708;
	Fri, 18 Sep 2026 06:21:04 -0700 (PDT)
Message-ID: <f8e03883-d596-409e-ac17-f7e78ea8575b@linux.intel.com>
Date: Fri, 18 Sep 2026 15:21:03 +0200
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
 <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17.09.2026 11:43, Aleksandr Loktionov wrote:

> @@ -220,12 +238,28 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>  	struct ice_pf *pf = priv->pf;
>  	struct ice_hw *hw = &pf->hw;
>  	size_t length;
> +	u8 comp_bit;

Nit: initialize to u8 comp_bit = 0; - harmless as-is since the default: path returns early, but it silences static-analysis warnings about a variable set only inside a switch.

>  	int status;
>  
>  	switch (component->identifier) {
>  	case NVM_COMP_ID_OROM:
> +		comp_bit = ICE_FWU_COMP_OROM;
> +		break;
>  	case NVM_COMP_ID_NVM:
> +		comp_bit = ICE_FWU_COMP_NVM;
> +		break;
>  	case NVM_COMP_ID_NETLIST:
> +		comp_bit = ICE_FWU_COMP_NETLIST;
> +		break;
> +	case NVM_COMP_ID_MANIFEST:
> +		if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
> +			dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
> +				component->identifier);
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Unable to update due to unknown firmware component");
> +			return -EOPNOTSUPP;
> +		}
> +		comp_bit = ICE_FWU_COMP_MANIFEST;
>  		break;
>  	default:
>  		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",



> @@ -676,6 +746,16 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
>  		return -EINVAL;
>  	}
>  
> +	/* ice_send_component_table() is called for every component in the
> +	 * PLDM image before pldmfw_flash_image() ever calls this function,
> +	 * so priv->seen_components is already fully populated by the time
> +	 * the first component reaches ice_flash_component().
> +	 */
> +	if (ice_has_erot_incomplete(priv)) {

This check runs on every call to ice_flash_component(), but pldmfw_ops guarantees all send_component_table() calls finish before any flash_component() call. Since transfer_flag on the last call to ice_send_component_table() carries PLDM_TRANSFER_FLAG_END, the completeness check could run exactly once there instead of being repeated for every component in ice_flash_component().

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
> +		return -EINVAL;

Commit message says "reject with -EPERM", but the code returns -EINVAL. Please align the commit message with the actual errno, or fix the errno if -EPERM was intended.

> +	}
>  	/* Mark this component for activating at the end */
>  	priv->activate_flags |= flag;
>  




Both patches are missing a proper Subject: line — the commit message starts directly with the body text, so git log --oneline shows the From: line instead of a subject, and there is no [PATCH net-next vN x/2] ice: ... tag prefix as listed in the cover letter's shortlog. Please regenerate/resend with git format-patch so each patch carries its own subject line and revision/series tag, matching the titles already given in the cover letter shortlog.


Thanks,
Tomasz

