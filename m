Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C52D7817
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564640; cv=none; b=Ryf/A4BS5/rc1+GCBxKqXBsewqdvaoxwX4Tz2mj6yLuuKE763yLRAyYrUM2JUGQSG5xp0QC3i+j9LVQIqhS+LBsKLW4rFWHYvP+yTgC5JD2VZ+t/WTAf4iRci4RzFt/tHjuUiHDBVgizbWS45/r+9od42VY4sef6xJeYVBQidWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564640; c=relaxed/simple;
	bh=OXCTiYZ/7caImlsv50eWp1ZJeayCZKJU7MD6X5Xk3f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZYPLp+XHGz/e2TCJtgemW2FNnapg3aJWHk6bxiKS2a/t9kR7m0bDAwzv0iEuqnEr+YK9H7OIF+qyZUSr25hliNxtWcyYui/2euU+blHmgIw16awz3a9hQEiq5ASZ54YKrNtJH0Fs8x23itQ7amrEmR9e+WcZMxTix4+KVs97MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdCW9oLp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCgkb3nc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdCW9oLp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCgkb3nc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789564638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
	b=SdCW9oLpFQOHyzlzCsy/Z3WlGmUPyVRycn4QAs4VNzIW9xo7sFUnOzZRQ+85SwsWo3n3iC
	ukrOv0Mlb0VkH9GpeMJbqtFUNLPoGq5gXGCv1V/DInZDsbs5NDE802eZ3nOnZ0XzZBSg+T
	RPLTT6JCXikT0SovHCe0UDTteopvaMM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-zjFBrNtUMIikjmuJO77bOw-1; Wed, 16 Sep 2026 09:17:16 -0400
X-MC-Unique: zjFBrNtUMIikjmuJO77bOw-1
X-Mimecast-MFC-AGG-ID: zjFBrNtUMIikjmuJO77bOw_1789564636
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so49767975e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789564635; x=1790169435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
        b=dCgkb3nc7RiAE7oke44k4wbTny6Zob+lAT/cwDvQwMIGV0PEr/YCUwwvAJ/2OeFKte
         Ojlffzr/Vw9GyrvDrqTLSUjaDJqUCeaCaRALEoFatW/kC43bDNXAa7F1WP6Wx59v11G3
         73EuXUSKEpzGo1p8wNqwOgFwNmSsFiMrM9bCc+flN+WuO3gdoiMt9QpE94SQLKrO8rHC
         LZP3PBIMst2orJ0QlpCUrh3nUKR36zLi/wCmRIhHK8cLRzYBzkvSDNJM9eE6PhAgwnU6
         YnKsqqzg44R6ewgm54+u3JNuuc1tZANvObV7yTrU2ey6Yf552siMOqrEavI/L9hLjtf/
         j8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564635; x=1790169435;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=docZh/8sl7dXFnUbYvGXsVtko0JDj9j3X/6xWphAisg=;
        b=Ya8mA3gohjQQa9xet6HKJKheuP1ib9/ClxbRCZVfaE5FyDCk5o6C+1cES5fUYIbMTl
         Bv4FDURr2/T+ASOqwBXvIHGpC8s+DEGTpi3qqpKXhGe2vraEjin/I7j+Hf7pXEeyqwCD
         Gm5ywhuAEEhJEohS3XW/ARNr4upcr3NT03uFAT27sPxGZZPUIPmgp/bIwBz4TFBvFBzV
         V0TrUr6QWMED5bNJVuti5SXc+Wr1fmqa5QdnZvHwj4PWrYzCL443WF978UGR/HN1KBNC
         FAwUSS9rkwnyFixkvOAiiLAwLU9JqjhLa33DFZZkHfc6GbSa2b6MqR1JYc/jGTKqhvk5
         gfXw==
X-Gm-Message-State: AFuF++ko9wLExm6s7yX90hDF/93LOPkgJzyIWcwYTgD53DMYddf0l9bs
	QfRJbqIUUIdzFbGu+2mqZ7KHXjMJ/NbzmTL/T56xjnMucQRXsbT4LT8HUiT22F4Mm+xqLqd37oy
	oaVsCoyl4t8E88711Yp3jhqdhB0X+2E9xU6o1glN+L28Bh/nd/3DvNCCZIg==
X-Gm-Gg: AYBFou0dMmbEJcKeFHDEKc1s4Kdc2QBizyW1rFQycjj8oQ8ZF49QsKU7fvKNaH+gwOW
	cbblPJK7QG21XfRb88evQkhRRhQYACOT5bAg4/qa0rA27Gq5AbwF5vXXIdZu9mB/dLAIAq1dbOB
	zEQBvSS/uBzybxabOz6o6EbTFq1fK6f2a/gXHzmboc0EQA/2OWHmtTOhlDjWu6s591yytaP0RqR
	iaW17lsWMCC5bgkg6ax8itxpNG7ODr9vnr3NwDaQehKcS9DnF7CFgtAZ0CAoQQSwPRTGABwwZun
	OqAacjmg2gSUYwCb4tUWSp9pNPwP2OL/DiZ2vk8ZFA0Lc2xMBfEbKE08Aew5BL+JaS7Tv/KfHw=
	=
X-Received: by 2002:a05:600c:1986:b0:49e:70b2:66ab with SMTP id 5b1f17b1804b1-49eac40f67emr32595395e9.0.1789564635524;
        Wed, 16 Sep 2026 06:17:15 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:49e:70b2:66ab with SMTP id 5b1f17b1804b1-49eac40f67emr32595095e9.0.1789564635086;
        Wed, 16 Sep 2026 06:17:15 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf413dcsm7232759f8f.31.2026.09.16.06.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:17:13 -0700 (PDT)
Message-ID: <c93e917a-6c66-44f1-a3c1-5c5f5b3930da@redhat.com>
Date: Wed, 16 Sep 2026 15:17:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/2] ice: don't offload drop filters that bypass
 higher priority filters
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 priyalee.kushwaha@intel.com, kiran.patil@intel.com,
 wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260910154824.3603687-3-poros@redhat.com>
 <20260912083645.145790-1-horms@kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260912083645.145790-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/12/26 10:36, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/#/patchset/20260910154824.3603687-2-poros@redhat.com?part=2
> ---
> ice: don't offload drop filters that bypass higher priority filters
>
> This commit tracks software-only TC filters to prevent the hardware from
> incorrectly offloading lower priority drop rules that would override them.
> It tracks un-offloaded filters within a device block and rejects conflicting
> drop offloads.
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> [ ... ]
>> @@ -2269,6 +2269,112 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
> [ ... ]
>> +static void ice_tc_track_sw_fltr(struct ice_pf *pf,
>> +				 struct net_device *filter_dev,
>> +				 struct flow_cls_offload *cls_flower,
>> +				 enum ice_eswitch_fltr_direction direction)
>> +{
>> +	struct ice_tc_sw_fltr *sw_fltr;
>> +
>> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
>> +		if (sw_fltr->cookie == cls_flower->cookie)
>> +			return;
> [Severity: High]
> Does this early return break tracking for TC shared blocks?
>
> When a shared block is bound to multiple interfaces, the driver will only
> track the cookie for the first interface because this check returns early
> when it sees the same cookie.
Correct. For a block bound to multiple devices of one PF only the first
binding's filter_dev is remembered, so the guard protects the first
binding only. The impact is a missed refusal on the other bindings,
never a false refusal, but it is easy to do better. I will rework the
tracking in v2 to keep one entry per cookie and filter_dev pair, so
every binding replay creates its own entry and the guard covers all of
them.
>
>> +
>> +	sw_fltr = kzalloc_obj(*sw_fltr);
> [ ... ]
>> +static bool
>> +ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_dev,
>> +			  u32 prio, enum ice_eswitch_fltr_direction direction)
>> +{
>> +	struct ice_tc_flower_fltr *fltr;
>> +	struct ice_tc_sw_fltr *sw_fltr;
>> +
>> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
>> +		if (sw_fltr->filter_dev == filter_dev &&
> [Severity: High]
> Because the tracking entry is bound strictly to the first interface's
> filter_dev, won't this check fail to protect other ports sharing the same
> block?
Yes, same root cause as above, fixed by the same v2 rework. The
per device comparison itself has to stay because TC priorities are not
ordered across blocks, only the tracking granularity was wrong.
>
>> +		    sw_fltr->direction == direction && sw_fltr->prio < prio &&
>> +		    !sw_fltr->is_drop)
>> +			return true;
> [ ... ]
>> @@ -2336,6 +2471,9 @@ ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
>>   	struct ice_pf *pf = vsi->back;
>>   	int err;
>>   
>> +	if (ice_tc_untrack_sw_fltr(pf, cls_flower->cookie))
>> +		return 0;
>> +
> [Severity: High]
> When deleting a filter from a shared block, the first net_device will delete
> the unique tracking entry here. Won't subsequent callback invocations for the
> other ports in the shared block fall through to the hardware failure path
> and incorrectly return -EINVAL?
They will, though that is what every DESTROY for an unknown cookie
returned before this patch too, so nothing gets worse. With the v2
per binding tracking each DESTROY invocation removes its own entry and
returns 0, which fixes this for tracked filters as a side effect.
>
>>   	/* find filter */
>>   	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
>>   	if (!fltr) {
> Later in ice_del_cls_flower(), the filter is removed and freed:
>
> drivers/net/ethernet/intel/ice/ice_tc_lib.c:ice_del_cls_flower() {
>      ...
> 	/* delete filter from an ordered list */
> 	hlist_del(&fltr->tc_flower_node);
>
> 	/* free the filter node */
> 	kfree(fltr);
>      ...
> }
>
> [Severity: High]
> This is a pre-existing issue, but is it safe to modify tc_flower_fltr_list
> and free the filter here?
>
> While this runs under the rtnl_lock, the background device reset task
> (ice_reset_subtask) calls ice_rem_all_chnl_fltrs(), which iterates over
> pf->tc_flower_fltr_list and frees filters using kfree() without holding
> the rtnl_lock or any driver-specific lock protecting the list.
>
> Could this concurrent access during a hardware reset result in list corruption
> or a use-after-free?
Confirmed, this race is real and pre-existing. ice_prepare_for_reset()
runs from the service task without RTNL and for a non PFR reset with
mqprio active it calls ice_remove_q_channels() with rem_fltr true,
which walks and frees tc_flower_fltr_list entries concurrently with
the RTNL serialized cls_flower paths. It predates this series and the
list reader added here runs in the same RTNL context as the existing
readers, so this series does not widen it. I will address it in a
separate fix.

I will send v2 of this series with the per binding tracking rework.

Regards,

Petr

