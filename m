Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE74908D9
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990445; cv=none; b=sMbNsdsfCedG0MQY8PSPUbgdmfUybaMFiTJA0R1KwbOlmb/LC7EVLkrR9LlO8mDpnbzrmPRSjuWZ5WBBdFG/P6+1OJ4+CM/Xamy9X184pl9CztLuK5ZG5OiNUlBPcWhHG2EiSG+qtc8IyuJc3yRHlYPI+3dMFFjDh9XjbtNru38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990445; c=relaxed/simple;
	bh=OWarSK6EoT0aqZXoUNieaTaxM5MZdtHgPk3Ij30+lYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnnPktjq4GEztYSiCmcJsTZKy/XhbDXra8xWZfDeGU5vzRBk1UoLRu+3Gx/VGf5mYjPGIXe3rgKk0on0+2H1O4JnmFU8ZX0qxmbc5r/q2gGcg09oscneGpALYneAxO79AMB5KVgq3B/1aWV4BCCsHNVnkmEChSORo1uN437g2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tdqo+wx2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tdqo+wx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789990444; x=1821526444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OWarSK6EoT0aqZXoUNieaTaxM5MZdtHgPk3Ij30+lYw=;
  b=Tdqo+wx2y7yCvM6Y8svN45wGbYTsoVPb5NI2wiuGJgkmsF6EHNh0dDxG
   A6k9yneRSU0fHyFA+bFAkfbxzMz2u8zDPMT9DKKOLNI6ogdcEyJodYdcA
   UMTeXHdyu2xJYrKuGtSXvnGbRmQK+2hLA50OrfcJK3RXPl908//qRYA8q
   CbHQDWZoQ+uo6eMXP0lEiew35ilKt8G5QR0SIdlJFQUdkru12B/EBlIb1
   63gDfDr/VqClMRQPN5n4c3lJE+11CuiU8OYSKpED6JBlAD7B3gKdto0OI
   C4Q3DThgpImtKUPOewxohqgJ9eni64cqJ9KvWCrxA9Utxce49jJhTyc4b
   Q==;
X-CSE-ConnectionGUID: KskcoVodTVaOf1UEbXpEdA==
X-CSE-MsgGUID: bjO3g0sMSTa7B93tpElqMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89423258"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="89423258"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:34:03 -0700
X-CSE-ConnectionGUID: b7zaCkNOSQmuCZlogyh8Zg==
X-CSE-MsgGUID: ibFLg4ziTeWp4WVsY81uBg==
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:34:03 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id D5CCC20B5708;
	Mon, 21 Sep 2026 04:34:01 -0700 (PDT)
Message-ID: <f00e7805-2da6-4124-a90a-ff74bd08896c@linux.intel.com>
Date: Mon, 21 Sep 2026 13:34:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 3/3] ice: support RDMA on 4+-port E830 devices
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
 <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260918133234.4169074-4-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18.09.2026 15:32, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> E810 and E82X devices do not support RDMA on configurations with more
> than 4 ports. This limitation does not apply to E830 devices, which
> have a different hardware design and support RDMA regardless of the
> port count.
> 
> Narrow the RDMA capability disable condition to skip E830 devices.
> Move the 'RDMA functionality is not available' notice inside that same
> condition so it is only printed when RDMA is actually being disabled,
> instead of unconditionally whenever num_funcs > 4 -- otherwise E830
> would log a spurious warning even though RDMA stays enabled.
> 
> Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 0463310..1c4421f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2510,16 +2510,16 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
> -		}
>  
> -		/* print message only when processing device capabilities
> -		 * during initialization.
> -		 */
> -		if (caps == &hw->dev_caps.common_cap)
> -			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
> +			/* print message only when processing device
> +			 * capabilities during initialization.
> +			 */
> +			if (caps == &hw->dev_caps.common_cap)
> +				dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");
> +		}
>  	}
>  }
>  

Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
