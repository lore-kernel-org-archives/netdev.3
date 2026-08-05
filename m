Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AB3E2ACC
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914064; cv=none; b=O7W2/9W+y1mf/doTDLDU8beP27mB0CveB80MMSPK+GS6afyQ8UqphwJX+DJA+8Y83nvSutFJSAI0Pled7Kw+rRKbrnVFrasPJPmH5MFvGnD43mfhZmV7IdJOQIjJi2pzeYOVQvm4HZB6BlhCGZYkM3f3EKC3yqUkXwO89c34HO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914064; c=relaxed/simple;
	bh=ytwOjPgHYyEqUYW8hceXfjpOk1xApcGo5nIcext/X38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7E9ztVy92UIbp2507q+fstnhnap/jVpWML4zsDtoHqAw35sB9793Q6ndHPmrPkylGFivM1LJUsOKscd41gZ15ZGj9TdyXe7NlyuHAQuYcO3AyK+sd/tsJBy9s+EjjUfmG3cll+LDEIRXk8Yb8jdRJWSL2u+67avCCxeC469yLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdG+1kZu; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdG+1kZu"
Message-ID: <ea295e13-6a35-4ce5-b289-f9f37b67dcf8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785914059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iE8P5i6dNkY2N+rYQAPGMKbtmyfqhFSU1QA1e4z6N20=;
	b=YdG+1kZu2iRRZH8Dx2Ap0LBid8j8ITj1M/Fl80ZM1dXwxntS/w0ZsjR9JL/PLvjYe2tzFF
	XMpns8qf7eKDTeXYd9phMaNjj8pvpfvMtuF7MkyVS9pm4uRneQb55g1xaOcG7GiJVxeiBj
	wCNNBI1PMAfCPmaU4GIIWtA19aeQv8g=
Date: Wed, 5 Aug 2026 15:13:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work
 handling
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com, piotr.kwapulinski@intel.com,
 arkadiusz.kubalewski@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
 <dce23bb6-138b-4a53-9447-26e81c86c292@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <dce23bb6-138b-4a53-9447-26e81c86c292@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/5 05:33, Vadim Fedorenko 写道:
> On 24/07/2026 10:34, xuanqiang.luo@linux.dev wrote:
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c 
>> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>> index ff62b5f2c8150..fd51ab8c10c20 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
>> @@ -169,6 +169,17 @@ static void i40e_ptp_extts0_work(struct 
>> work_struct *work)
>>       ptp_clock_event(pf->ptp_clock, &event);
>>   }
>>   +/**
>> + * i40e_ptp_init_work - Initialize PTP work for a PF
>> + * @pf: Board private structure
>> + *
>> + * Initialize work which must remain valid for the lifetime of the PF.
>> + */
>> +void i40e_ptp_init_work(struct i40e_pf *pf)
>> +{
>> +    INIT_WORK(&pf->ptp_extts0_work, i40e_ptp_extts0_work);
>> +}
>> +
>
> why do you need extra function for a single line of code? why cannot 
> you put it into i40e_ptp_init?
>
>
Thanks for pointing this out.

i40e_ptp_init() is also called from the reset/rebuild path:

   i40e_service_task()
     -> i40e_reset_subtask()
       -> i40e_reset_and_rebuild()
         -> i40e_rebuild()
           -> i40e_setup_pf_switch()
             -> i40e_ptp_init()

Putting INIT_WORK() there would reinitialize the work item during reset or
recovery. If the work is pending or running, this races with the workqueue,
resets its bookkeeping, and breaks the workqueue's non-reentrance
guarantee.

The work item is therefore initialized once per PF from i40e_sw_init().
The helper also keeps the work callback private to i40e_ptp.c.

