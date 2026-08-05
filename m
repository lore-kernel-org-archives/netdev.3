Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05C3F661D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923375; cv=none; b=l+NHLhrqkOQX5tu4ketAlVGYovFEXkjwp/+O/wGPnwCvhLv51234399OaXza/XRC5h2zlmpuD5XuHFEIYCBc2kSvQVehOr08txv0CfQyLDi7kBNbYdaFRGBvVPG4rxjrjWXskSdAO+2cSrMSBqUK97rAlL69QfZgrPHGOxMgX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923375; c=relaxed/simple;
	bh=5iH3jDtbpElr0PbAtYvR/rW6BHXbMmYMz8Usu24v5RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW/vtS6p+7qHy9sm9IQoBK4sG7/GXUeeTpZYPHpfwtdIdGP64SXMolDpIWkK07BSj3aNA/vupdh4DX2uW85SW9i+M3QXFSwbvmWN+Ve35GS+nAT4QX9U1tGfz0bYSkVTa9nlyitiY7Taee3z3UQjb139clbajSe9AWqNMvuSdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QNgzYa4b; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QNgzYa4b"
Message-ID: <0ba725ce-93a2-4616-a854-f1ff95e7bdd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785923369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NojVNnVq91doXEpC4NRBIsbrB0D73g+roZrJn17Ay9E=;
	b=QNgzYa4bm3diyOBpVbd5u43+x85Lio3jnTMvn5AkRodwQXVqZSFCUdjiF/OsXE3AeM8CZt
	p2Zj7FbghA3UU1LZfNj7fJBScs5nBG2Mpy+tjoL50NifnD4Sj8llBodJxscMSqwfkAfGqU
	IkNJtc1EQB65xJIB7AjuNVWr4MpI6bk=
Date: Wed, 5 Aug 2026 10:49:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work
 handling
To: luoxuanqiang <xuanqiang.luo@linux.dev>, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
 <dce23bb6-138b-4a53-9447-26e81c86c292@linux.dev>
 <ea295e13-6a35-4ce5-b289-f9f37b67dcf8@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ea295e13-6a35-4ce5-b289-f9f37b67dcf8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 05/08/2026 08:13, luoxuanqiang wrote:
> 
> 在 2026/8/5 05:33, Vadim Fedorenko 写道:
>> On 24/07/2026 10:34, xuanqiang.luo@linux.dev wrote:
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/ 
>>> net/ethernet/intel/i40e/i40e_ptp.c
>>> index ff62b5f2c8150..fd51ab8c10c20 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>>> @@ -169,6 +169,17 @@ static void i40e_ptp_extts0_work(struct 
>>> work_struct *work)
>>>       ptp_clock_event(pf->ptp_clock, &event);
>>>   }
>>>   +/**
>>> + * i40e_ptp_init_work - Initialize PTP work for a PF
>>> + * @pf: Board private structure
>>> + *
>>> + * Initialize work which must remain valid for the lifetime of the PF.
>>> + */
>>> +void i40e_ptp_init_work(struct i40e_pf *pf)
>>> +{
>>> +    INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
>>> +}
>>> +
>>
>> why do you need extra function for a single line of code? why cannot 
>> you put it into i40e_ptp_init?
>>
>>
> Thanks for pointing this out.
> 
> i40e_ptp_init() is also called from the reset/rebuild path:
> 
>    i40e_service_task()
>      -> i40e_reset_subtask()
>        -> i40e_reset_and_rebuild()
>          -> i40e_rebuild()
>            -> i40e_setup_pf_switch()
>              -> i40e_ptp_init()
> 
> Putting INIT_WORK() there would reinitialize the work item during reset or
> recovery. If the work is pending or running, this races with the workqueue,
> resets its bookkeeping, and breaks the workqueue's non-reentrance
> guarantee.

ok, but then this driver has bigger problem. the same i40e_ptp_init()
re-inits tmreg_lock mutex and ptp_rx_lock spinlock. While latter might
be ok during reset (hopefully no traffic processed while the nic is in
reset), tmreg_lock mutex can be used for adjfine/adjtime/gettimex64/
settime64 callbacks as ptp device is still visible to user space.

I believe ptp part of the driver has to be redesigned properly.

> 
> The work item is therefore initialized once per PF from i40e_sw_init().
> The helper also keeps the work callback private to i40e_ptp.c.





