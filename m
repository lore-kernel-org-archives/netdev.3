Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AE3CB8F4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637748; cv=none; b=gMdgf2ym3xOhWj6cisD+GR5A57hu2DDpT2qDVB1zqQIolYSZRcyhdKvXQF/ngjwo1BocHm8GisATGXiLTAvst/gVtP1V8k+9MqTxxG8K4DWYblHo8lE/kI79qOf+yzjtdh+vJDTlslXI9AVsKTWOb8R/uUhOzSj/n7l/EBeYPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637748; c=relaxed/simple;
	bh=AV1TJBNzs8Rx6IDeXsnEOhbgxjuLcvQpuzTJRUwdisw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9bztQ9bA1GCGoxQW53HHtc+qhOToJKv0jDAxRKJ2W7l0jyYuN9LCf1dmEPK8izfIIE5+TTIVZ801OeubUSRGm3zsmSy8uhIBQmFcAnIb7Z8+XiaGjeUw4G5OO/plSKF24BTwT5ZiaswKfn6JxKsEdA1MWJgdsVRCXvTOCX/z9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNMeTN48; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNMeTN48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789637737; x=1821173737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AV1TJBNzs8Rx6IDeXsnEOhbgxjuLcvQpuzTJRUwdisw=;
  b=CNMeTN48IVea1iWQTJ84mHerBZq/N4n5boACbeNDEKmda0nnLv5IX5qF
   r15HTW6YDzAra1kTCkavwYdG+aXcc8i2MiWZB8Iaf5e/zhdL5VQKxlSHi
   kN8A5z20ziHGU3FLTYzTbDZUIOvjTKF0oVcOf5u2MNuZqoudUo40Nvs66
   q3yqDD49PPG0SNSiOyW4K8m0vLumG83XPwca17YeF8egZAdaxKY66sM08
   o7zHukLKc3TtQh9ziqd1jwUC8P5uMFOgm09OqEJZMDr9uuiZ5KUaVnviv
   S2ik6Jcv7Mh2xNe+gjIm9FUiBptBFSQsrQxbuKPgdlG1DXV6ctc0VLLOU
   A==;
X-CSE-ConnectionGUID: JI2u1a/qQ5aTHZLiBPJu8w==
X-CSE-MsgGUID: iPFHScRSTB6O5/55NRz8jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107548509"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107548509"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:35:32 -0700
X-CSE-ConnectionGUID: j2D/QbbVTk69Xysud5NNTg==
X-CSE-MsgGUID: efBg71spTW2HiZMM7PbkKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298764816"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:35:32 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id 293B120B5708;
	Thu, 17 Sep 2026 02:35:29 -0700 (PDT)
Message-ID: <5ffcee35-e44e-4c54-978b-42bb79601c3f@linux.intel.com>
Date: Thu, 17 Sep 2026 11:35:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 3/3] ice: support RDMA on 4+-port E830 devices
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
 <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260915125529.3975723-4-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.09.2026 14:55, Aleksandr Loktionov wrote:

> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index ef1ce10..d53307b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -2507,7 +2507,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
>  		caps->maxtc = 4;
>  		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
>  			  caps->maxtc);
> -		if (caps->rdma) {
> +		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
>  			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
>  			caps->rdma = 0;
>  		}


		/* print message only when processing device capabilities
		 * during initialization.
		 */
		if (caps == &hw->dev_caps.common_cap)
			dev_info(ice_hw_to_dev(hw), "RDMA functionality is not available with the current device configuration.\n");


This message is still printed whenever num_funcs > 4, regardless of the new mac_type != ICE_MAC_E830 check above it. On E830 devices with more than 4 ports, RDMA now stays enabled but this log line still claims it's unavailable. Please gate it on the same condition used to actually disable caps->rdma.


Thanks,
Tomasz

