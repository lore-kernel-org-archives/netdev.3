Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC4218845;
	Wed, 15 Apr 2026 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242293; cv=none; b=cFktHZ3DlDquV+z7ic6oQoCzV8p4S1Yl7LuCrrrRVVDxRebQkd5zMCjW+CnhodQEC0FHLQwUjj4dbMEYA1ZUp/W4w+NDPKhuIezR/mo4aUNcPWk9W1NFPB2AtKnNl83+UhsXbWVZ+fQuClfYvYR6dl+JJjwSFoQxlwSrSZOc70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242293; c=relaxed/simple;
	bh=+E24YrPrdzJ1ya9Ikgcx0KKiXJaJ4AYDwwErZxu5fG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7wIzyfCS7bGeNe+H6BSsOrv70spYJdtt+k1fzB5sAhChpiTl1FbQUraqobB+/SpA6iTLFNCFrVULba03XWwnLl6JKDepdePKZe5h8IQ9aDixKwi+g29UfYhQCSpJ5rYyH3H5VMz/JvyzDE4m0IYiNCaTTopk0TphZfjgplKYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB4Rty8R; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB4Rty8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776242292; x=1807778292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+E24YrPrdzJ1ya9Ikgcx0KKiXJaJ4AYDwwErZxu5fG0=;
  b=WB4Rty8REWJYIHweme5mBnXmrcnwcaDDRIPu+fkQKIh74+9fG6jC9hzR
   yh7ce+lRmUtO88cZq7GkKdTYEjJD2mmTCj3tNJS7DwNzqzvvPscSn/kCC
   9/2tNjJV45rhGjt3sDEkYLmSL2MHqEKk98LYlRDN4npkuiJdvLKATrgIh
   rX8KVDEfVW9LPBRFYrKTLACmpAG9vVVY+Ojfr5pyzj6bMYidIAuyWwurg
   iARpIEQ9GXrlfCaWjSDcEWlc65I9/qELy7hP0hWqkcyRp4cnjbXRJJ+hv
   CyDFw1sAeALbiRbfk+0M6gN8W+f20liplklUhLxSwutwUhj3UuRoPCzVo
   A==;
X-CSE-ConnectionGUID: YdYuSVWvTQOWnRg20Z+vCA==
X-CSE-MsgGUID: n2HNbwCOSgipVsaO2mgfwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87914967"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87914967"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:38:11 -0700
X-CSE-ConnectionGUID: T4ArbB4xS227m+HZRmDGeQ==
X-CSE-MsgGUID: DIzosRa5RXmyFA6P+VAa2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223857364"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.20.182]) ([10.247.20.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:38:06 -0700
Message-ID: <f1c6f5d0-61a7-4866-b122-ce18933d92eb@linux.intel.com>
Date: Wed, 15 Apr 2026 16:37:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/1] igc: add support for forcing link speed
 without autonegotiation
To: Simon Horman <horms@kernel.org>, khai.wen.tan@linux.intel.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hector.blanco.alcaine@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260409072747.217836-1-khai.wen.tan@linux.intel.com>
 <20260413145215.718532-1-horms@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260413145215.718532-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/4/2026 10:52 pm, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> igc: add support for forcing link speed without autonegotiation
> 
> This commit allows forcing 10/100 Mb/s link speed and duplex settings via
> ethtool when autonegotiation is disabled. It configures the MAC CTRL and
> PHY registers to bypass autonegotiation and apply the requested settings.
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index 0122009bedd03..e14771532dad8 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> [ ... ]
>> +static int igc_handle_autoneg_disabled(struct net_device *netdev, u32 speed,
>> +				       u8 duplex)
>> +{
>> +	struct igc_adapter *adapter = netdev_priv(netdev);
>> +	struct igc_mac_info *mac = &adapter->hw.mac;
>> +	enum igc_forced_speed_duplex forced_speed_duplex;
>>   
>> +	switch (speed) {
>> +	case SPEED_10:
>> +		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_10F : IGC_FORCED_10H;
>> +		break;
>> +	case SPEED_100:
>> +		forced_speed_duplex = (duplex == DUPLEX_FULL) ? IGC_FORCED_100F : IGC_FORCED_100H;
>> +		break;
> 
> Does forcing a half-duplex configuration here also require setting flow
> control to none (e.g., hw->fc.requested_mode = igc_fc_none)?
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
>> index 7ac6637f8db73..16b0f2db06896 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
>> @@ -452,7 +452,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>   	 * so we had to force link.  In this case, we need to force the
>>   	 * configuration of the MAC to match the "fc" parameter.
>>   	 */
>> -	if (mac->autoneg_failed)
>> +	if (mac->autoneg_failed || !mac->autoneg_enabled)
>>   		ret_val = igc_force_mac_fc(hw);
> 
> If mac->autoneg_enabled is false, igc_force_mac_fc() will configure the MAC
> using the existing hw->fc.current_mode. If current_mode defaults to full flow
> control, this will enable PAUSE frames.
> 
> Since autonegotiation is disabled, the MII status check further down in this
> same function will fail and return early:
> 
> drivers/net/ethernet/intel/igc/igc_mac.c:igc_config_fc_after_link_up() {
>      ...
>      if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
>          hw_dbg("Copper PHY and Auto Neg has not completed.\n");
>          goto out;
>      }
>      ...
> }
> 
> This early return skips the half-duplex safety check at the end of
> igc_config_fc_after_link_up() which would normally clear the flow control
> settings:
> 
> drivers/net/ethernet/intel/igc/igc_mac.c:igc_config_fc_after_link_up() {
>      ...
>      if (duplex == HALF_DUPLEX)
>          hw->fc.current_mode = igc_fc_none;
> 
>      ret_val = igc_force_mac_fc(hw);
>      ...
> }
> 
> Does this leave the MAC incorrectly configured to send and receive PAUSE
> frames on a half-duplex link, violating the IEEE 802.3 specification?

Hi Simon,
Thanks for the review.

Yes, you're right, I missed that interaction.

I’ll update the code to also set the following in 
igc_handle_autoneg_disabled() when forcing half‑duplex:
hw->fc.requested_mode = igc_fc_none

I’ll test it and, if everything looks good, send out v2.

Thanks again!



