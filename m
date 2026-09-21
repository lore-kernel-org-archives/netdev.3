Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495348F00F
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990443; cv=none; b=DfkKU70Wk/EKGQpkE+q80ZzsqP8g4wSx9Tqni3Vqv9+275bw5rYtcvzcVC5y2EflO64kL+shtm9NYEfwj67WByGqB8AYfvBIp5tZYPmLzwPlg1bWS+lEG6oG0u2hslKFSAdlnvIeVIwEefGfKBuvq4UQCur1dSbFyTSNFimLlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990443; c=relaxed/simple;
	bh=+4/pUrCrEAsoMfa0UqzGzEZRrJcEJa2HeEByYqKSunQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKYlDnfVDPdX0RAP7NWzIThWfAC8yHixMmt4o9zZWROLuIWyC7JzvPv7zO39T1PbPdV/DEq0J6qe6lY5BQ/w1kVakqjsg9kI/SxOitdVtUA+G4EITpXaNQAqxtdtaqU20HadJFAcUJTGeHaqMyNpCXHjcRCgZBaAoVa7Kc16Fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bqx/qw2H; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bqx/qw2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789990441; x=1821526441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+4/pUrCrEAsoMfa0UqzGzEZRrJcEJa2HeEByYqKSunQ=;
  b=Bqx/qw2HKIh2d9/MYozOj95D+dHLGSPZTk4afEiW+TXPocbvawTiv36t
   Xjnw6qOfFdTO3lP7Mt3i7Rc2hyIPxTIlv4SmdBGZ1xWVMfC62pcvtIhDC
   L+fmcK6hEI6aKajqvwsOudG8DkURBfxS8e30GMtj3do90UnGV3I6pVz56
   d+zjzFPuE9MEflcvqqVOtAhRtlPGA1uHDtEB/qew6ilGx3JcgCsA4uD2P
   7TEemRJ2StXNytHnbp+RsUb6I61GG/Wm/RifGs5eFJFwixqxMaw3Ruy+g
   lLc4seYfyrqshN8Q/uu+7OR0Mhbrg3wtiLmutCX7Fl/dFNM8LHBujoVn5
   Q==;
X-CSE-ConnectionGUID: Y0XLiybMQUSxJ9OTUErHkg==
X-CSE-MsgGUID: SRBGbjKjR6u4KYBf/NVCQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="999633"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="999633"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:34:00 -0700
X-CSE-ConnectionGUID: +qIGTfE4SjKNk712w0iRXg==
X-CSE-MsgGUID: 4oer0P/OToSO7Fzy8DQpbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="269131831"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:33:59 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id 2D1AD20B5708;
	Mon, 21 Sep 2026 04:33:58 -0700 (PDT)
Message-ID: <e48dad69-8f82-4e50-a016-4dd32b05782c@linux.intel.com>
Date: Mon, 21 Sep 2026 13:33:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 2/3] ice: fix autoneg disable when link partner
 doesn't support AN
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
 <20260918133234.4169074-3-aleksandr.loktionov@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260918133234.4169074-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18.09.2026 15:32, Aleksandr Loktionov wrote:
> From: Konrad Knitter <konrad.knitter@intel.com>
> 
> Disabling autonegotiation was silently ignored when autoneg had not yet
> completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
> unchanged with no error. This could prevent link from forming if the
> link partner requires non-autoneg mode.
> 
> Extend the condition to also allow disabling autoneg when the link
> partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
> ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
> zeroed an_info when link is down does not produce a false positive.
> Introduce the helper ice_autoneg_disable_allowed() to make the check
> explicit.
> 
> Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index a257b7d..4ce198f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2501,6 +2501,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
>  	return adv_link_speed;
>  }
>  
> +/**
> + * ice_autoneg_disable_allowed - check if autoneg can be disabled
> + * @p: port info
> + *
> + * Check if autonegotiation can be disabled based on link state.
> + * ICE_AQ_LP_AN_ABILITY is only valid when the link is up; gate that
> + * check accordingly to avoid false positives from stale link data.
> + *
> + * Return: true if autoneg has completed, or if the link is up and the
> + *         link partner does not advertise autonegotiation capability.
> + */
> +static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
> +{
> +	u8 an_info = p->phy.link_info.an_info;
> +
> +	if (an_info & ICE_AQ_AN_COMPLETED)
> +		return true;
> +	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
> +	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> +	       !(an_info & ICE_AQ_LP_AN_ABILITY);
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


Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
