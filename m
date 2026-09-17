Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C64A3F37
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636936; cv=none; b=sIiBd6ig95q3qvPirN+7O4n8Q1lhelNsd94wgKuDMJWtYGcIRZC9xAJvbEk3RD7O0Qa2HCkUQKLQJh7vg2zfWPf+1ZShiL9UWtbkZsZk7dFdUyo7Hfnl3vjxb6Vq8eQISb8EKDtUfsp/a/ofv8AVIZmyipH65sU/TXiY3pHpHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636936; c=relaxed/simple;
	bh=XizrKC03PF6PblcGiGCjeGlG2cS3W1oVronU2P/cWf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3lDPMB8keTb+CycnwLDbs+PfVX6DjTXatqtk9hgdgidjF6bcLjkWcgFMShxRfaxCcS6uXNiJOQs4XjlXjbqX34uq2jzNx6JHaeI2AibN9I4RyNWdF5HwTtbZBW7T0xrjDYOGnLeP9u8chMAhnIQTbpSzyneXVBdj6rQZSIxfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCGdc1lX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCGdc1lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789636934; x=1821172934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XizrKC03PF6PblcGiGCjeGlG2cS3W1oVronU2P/cWf4=;
  b=dCGdc1lXCUUavfS4jKM6/yF7FHt5JB8ud5mHNvRi1LzXtBOPXVcRnIXA
   AYiP0aE1jYjZRt5vEdnfr5ERqOA0c17v4HHfW+nJgPzZdzFB3iVCJc7qb
   21MKVp1k//rzNhbbgegtn5osQYDd5G92KeZlVq9LThre3yKaCA4rL+Kza
   m9k2TrVsE28CLaJiH1sZiu60deNEr1xWXR9sxFAu5AbzCFvq/mVYqjzBu
   zHay0tiI2NT4H8SlIpAuBe6xPwZNeoR2VFpgJ9N7JYrhaS5Nj/j+P2BVh
   oiA02faSPHQca3pOyX54eDJNAjdVbf1ojdy7ckDxDtvYXq9RV2CM/kev7
   g==;
X-CSE-ConnectionGUID: yZC0pugcRfmxAhZx7zWuXA==
X-CSE-MsgGUID: zXDRBhIlRcufvN5Nc2P0HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92549912"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92549912"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:22:14 -0700
X-CSE-ConnectionGUID: zIvLWTLTRlWGA3o8oVBj0A==
X-CSE-MsgGUID: tUC/x3aLRY+kYzd5R0F8aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267451472"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:22:14 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id 86CA020B5708;
	Thu, 17 Sep 2026 02:22:12 -0700 (PDT)
Message-ID: <7df5cf3e-b4f7-407f-8da4-c0abdc7752ce@linux.intel.com>
Date: Thu, 17 Sep 2026 11:22:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/3] ice: fix autoneg disable when link partner
 doesn't support AN
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.09.2026 14:55, Aleksandr Loktionov wrote:

> +static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
> +{
> +	u8 an_info = p->phy.link_info.an_info;
> +
> +	if (an_info & ICE_AQ_AN_COMPLETED)
> +		return true;
> +	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
> +	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> +	       !(an_info & ICE_AQ_LP_AN_ABILITY);

When link is down and AN hasn't completed, this still silently no-ops the disable request (unchanged from before). Worth confirming that's the intended UX, or returning -EINVAL here too.

> +}
> +
>  /**
>   * ice_setup_autoneg
>   * @p: port info
> @@ -2539,8 +2561,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
>  			}
>  		}
>  	} else {
> -		/* If autoneg is currently enabled */
> -		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
> +		/* If autoneg completed or link partner does not support AN */
> +		if (ice_autoneg_disable_allowed(p)) {
>  			/* If autoneg is supported 10GBASE_T is the only PHY
>  			 * that can disable it, so otherwise return error
>  			 */

Thanks,
Tomasz
