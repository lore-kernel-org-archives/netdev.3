Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017A3EE1E0;
	Mon, 27 Jul 2026 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145569; cv=none; b=t6oPQtI9VY5VrMKjhqExUUf40GIsLcNfci2Ndn0X9snfx4I7gAnRJ/NAZrobnPU+vqxYVtxhX8wr90yPs3i0yTi+F5gQSJRKv0JqHFDYHpiREM0Ap7VDfI9hjQpltx0hN7/RxLQ1cM/hBHrI8+VqtuqhxFXNLrXSIwZ9eD6SLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145569; c=relaxed/simple;
	bh=CAANQ8JwqOdCbVfDdGusJsGbBaNEb10o4VqN1uAhUbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdiqQbJwPjSnN/SqYzs24idVIEISWZXsUy0clkEeqQUCpq5rYK/jJ9miG0CJF1Le+ZlPU93hwV8cOKz8Ki87IDYdecSyIVkJzpLpptvkhp0k+sGhn/zQO9qyCGuVmbiCYspcxOKg3aFViDmrPMcGjJCE4xV+wIv7knu0GYgq82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXMkKWOD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXMkKWOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145568; x=1816681568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CAANQ8JwqOdCbVfDdGusJsGbBaNEb10o4VqN1uAhUbM=;
  b=UXMkKWODu/k4OYXVusorklBYo0loRDiPwKs5Xsw/TYU0H7jVfZ7SDcys
   HHPqhIC1s1MV9IA1Tg+xcmT0VeEsP6Ta7W2Js3tsr+sHT5w47bI95a7ZE
   djCB13gcfeHxr8GQS+Em1RWEXUYVsLNAzIgZojmVnYgXy7gsp6uRYjHgT
   V8fZxuXaM3ULjaexHcweQbsy38fjNlxDkfETRNX/Y0lUE8Xc/UG/Yn8+c
   svJgROhC/bp/He61do3jHIHEAvE/Sr0MpF1rIu2ZmN+jn/Vh1zqfm2cvl
   alowb1I4GTc/DHiUZYEkIiGy31GAIH8A5dae5gfMSFQ1GTnFWXR+mJkc5
   w==;
X-CSE-ConnectionGUID: 0C37NOakQ5Ox7hKmG6XC7g==
X-CSE-MsgGUID: /vsc+DtUR0ym01PQpzMR9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="103250900"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="103250900"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:46:07 -0700
X-CSE-ConnectionGUID: JamNl8+GSV6UQNknkzi9vQ==
X-CSE-MsgGUID: v9NvPtl0RK+K72O1j2Vd4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="263148737"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239]) ([10.217.160.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:46:05 -0700
Message-ID: <cb66f729-2869-4116-bac0-15bb6557a7dd@linux.intel.com>
Date: Mon, 27 Jul 2026 11:45:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 4/4] net: intel: remove
 conditional return with no effect
To: Sang-Heon Jeon <ekffu200098@gmail.com>, kuba@kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260725150852.859188-1-ekffu200098@gmail.com>
 <20260725150852.859188-5-ekffu200098@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260725150852.859188-5-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/07/2026 17:08, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Nice cleanup.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +-------
>  drivers/net/ethernet/intel/igb/e1000_i210.c | 6 +-----
>  drivers/net/ethernet/intel/igc/igc_phy.c    | 6 +-----
>  3 files changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a56..0cd0e5597c90 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -4864,16 +4864,10 @@ static void i40e_control_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
>   **/
>  int i40e_control_wait_rx_q(struct i40e_pf *pf, int pf_q, bool enable)
>  {
> -	int ret = 0;
> -
>  	i40e_control_rx_q(pf, pf_q, enable);
>  
>  	/* wait for the change to finish */
> -	ret = i40e_pf_rxq_wait(pf, pf_q, enable);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return i40e_pf_rxq_wait(pf, pf_q, enable);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
> index 9db29b231d6a..784f9a7bcbed 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_i210.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
> @@ -756,11 +756,7 @@ static s32 __igb_access_xmdio_reg(struct e1000_hw *hw, u16 address,
>  		return ret_val;
>  
>  	/* Recalibrate the device back to 0 */
> -	ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
> -	if (ret_val)
> -		return ret_val;
> -
> -	return ret_val;
> +	return hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
> index 4cf737fb3b21..b758a7e0f013 100644
> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
> @@ -675,11 +675,7 @@ static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
>  		return ret_val;
>  
>  	/* Recalibrate the device back to 0 */
> -	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
> -	if (ret_val)
> -		return ret_val;
> -
> -	return ret_val;
> +	return hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
>  }
>  
>  /**

