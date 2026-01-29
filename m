Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F4387370
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685907; cv=none; b=g+thoaWGIwyCO3fDKzRxIcFQLM1uOQttUWDvWo5EVRQnjABDCL1hRzyLWFFJ4Gu1a2xMVKxNXfhpNBMSwH/hwNvsY1Jwi5jvIbikST2ZYWtKbHwd6M7YzG7RsDyjWT8+jZzkaGwaBWb/ApmtyLFhr0jdVMCcQWyqm0Gy+O94MsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685907; c=relaxed/simple;
	bh=hAcVxOH7BXynvR0QexOQJ5luWYMUN1rnOFrg9Uirz44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx31tcu4t5aATCnXZauF8+R88RPzUF1iu6t2u3kH0kOtkwJXQI7+5Y30w3XZBIhl+bTRWKGpiltHZxz7HGyXhi4U54PJ4RuZO6bNs/N6iH93Ry3Nv0FjH4mTD0ig4wr/YqXS/f5qgDpkKYmz3r+mOFdCaUz0n2pmjyDFHYC7UCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfMEOB07; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfMEOB07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769685906; x=1801221906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hAcVxOH7BXynvR0QexOQJ5luWYMUN1rnOFrg9Uirz44=;
  b=MfMEOB07yY03QvA0AoeLD5izIcbGkDomZ6GNLSQMt1tzzUISOnBnTh4S
   Nz+rCR9CfSqOkQ6a8FSNswPWVQAl5yQoWfKl+67aiVvl4dEow00QZtO28
   jzAAVPYYIHsNVlEJy1O3m08+2WhpxTpLlHXMwByd51qRzltKWLClzQKSW
   A99p8UgYXvhyuJa1VXt4Q+5lcU9GReAcA4K9cJ2TQbDj4/NnfZcwYE4kZ
   CUt2KwyTp2+zKG3wPJmULIDu9hGe8jOEMFiwwOKZvnIixft4cfhln15QX
   O1vxbXbg/uZnJ8Z5HsRRaRYRHSBC1eONgYxqlInJ4lgpxKBYgWzXPWXre
   Q==;
X-CSE-ConnectionGUID: 6fm2aHAaTeup0N9LZtHVVg==
X-CSE-MsgGUID: vqLxZh14QVqBXiNPNdSd1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="69937439"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="69937439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:25:05 -0800
X-CSE-ConnectionGUID: ahqjcYT/R1enFlUL/HWdyw==
X-CSE-MsgGUID: ivHFzpodTR2R1raoPfgBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="208912366"
Received: from unknown (HELO [10.217.180.154]) ([10.217.180.154])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:25:03 -0800
Message-ID: <d1fcdfd8-b6c2-4bff-9138-3113084c50cb@linux.intel.com>
Date: Thu, 29 Jan 2026 12:24:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix setting RSS VSI hash for
 E830
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20260109085339.49839-1-marcin.szycik@linux.intel.com>
 <ddd25fe0-a6a8-4ba9-8cb1-3f91ca562928@linux.dev>
 <1e162d79-20a2-4de3-8862-aa4fbe842132@linux.intel.com>
 <979e42ca-66fb-4ca6-b68f-c10b4e441369@linux.dev>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <979e42ca-66fb-4ca6-b68f-c10b4e441369@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12.01.2026 12:15, Vadim Fedorenko wrote:
> On 12/01/2026 09:36, Marcin Szycik wrote:
>>
>>
>> On 09.01.2026 17:44, Vadim Fedorenko wrote:
>>> On 09/01/2026 08:53, Marcin Szycik wrote:
>>>> ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
>>>> function, leaving other VSI options unchanged. However, ::q_opt_flags is
>>>> mistakenly set to the value of another field, instead of its original
>>>> value, probably due to a typo. What happens next is hardware-dependent:
>>>>
>>>> On E810, only the first bit is meaningful (see
>>>> ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
>>>> state than before VSI update.
>>>>
>>>> On E830, some of the remaining bits are not reserved. Setting them
>>>> to some unrelated values can cause the firmware to reject the update
>>>> because of invalid settings, or worse - succeed.
>>>>
>>>> Reproducer:
>>>>     sudo ethtool -X $PF1 equal 8
>>>>
>>>> Output in dmesg:
>>>>     Failed to configure RSS hash for VSI 6, error -5
>>>>
>>>> Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
>>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> index cf8ba5a85384..08268f1a03da 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>>>> @@ -8038,7 +8038,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
>>>>        ctx->info.q_opt_rss |=
>>>>            FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
>>>>        ctx->info.q_opt_tc = vsi->info.q_opt_tc;
>>>> -    ctx->info.q_opt_flags = vsi->info.q_opt_rss;
>>>> +    ctx->info.q_opt_flags = vsi->info.q_opt_flags;
>>>
>>> The very same typo pattern is in ice_vc_handle_rss_cfg() in
>>> ice/virt/rss.c
>>>
>>> I believe both places have to be fixed.
>>
>> Hmm... where exactly? ice_vc_rss_hash_update() (called from ice_vc_handle_rss_cfg()) looks correct.
> 
> Sorry, it was fixed in 3a6d87e2eaac ("ice: implement GTP RSS context
> tracking and configuration") when the logic was moved to
> ice_vc_rss_hash_update(), but this code was never backported, the
> problem exists in 6.18...

Sorry for late reply, I don't know why, but I assumed the patch you
mention would be independently picked up to stable. Now that I've
looked into it, I see it's a feature implementation that accidentally (?)
also fixed that one line in ice_vc_handle_rss_cfg(), so it won't be
backported.

Do we know if the mistake in ice_vc_handle_rss_cfg() is an actual issue?
So far I wasn't even able to enter that branch (rss_cfg->rss_algorithm is
never VIRTCHNL_RSS_ALG_R_ASYMMETRIC, in fact this is the only usage of
VIRTCHNL_RSS_ALG_R_ASYMMETRIC - dead code?). If I understand correctly,
"theoretical" fixes are not welcome in stable.

Thanks,
Marcin

> 
>>
>> Thanks for reviewing,
>> Marcin
>>
>>>
>>>>          err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
>>>>        if (err) {
>>>
>>
> 

