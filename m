Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1833CCFC3
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108491; cv=none; b=iyRsDIuk5b//JVz+AG/PltFqRsH9t8cFFsYE8mDSwW318SS7MKxBpgQ+JtVK9T/o9acmY1Wvro+Yy24oUPooFHVJf7Z4GpUzs8Up47fwT030ko5wDZBi8eGJHVnQdya0JnEzggApyaOvRuMYmVHTRhiJ8q2kUSQzy1M2uNWJdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108491; c=relaxed/simple;
	bh=YGHRu+F97cWhGi6/KVH2KxwUVUoIhplxmVJj/OEzjb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiu5u7j8Z5RpzfwWsG00ZuECX0KV9yGaT64G0iKGEyMXmmv92lXrxgaccjwlIZ1mQSakaHSjtRg321AG0wKJv3ARaV/98MPvf7qUqkw6YNcp+7P2nHRyYfBizxkz//gYCFb2K94l6P6teZ13uYS10ix6BHAGwJsGpeQRUf3jkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pishA9GC; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pishA9GC"
Message-ID: <b2b2a0df-2164-44a5-a7a1-e7cecf1f7b86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784108461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pLf70bhIsBjYYAuXnkUf9IaSpfzFW1UY6uqtiFu0Cc=;
	b=pishA9GCA8WBAZW7KVKBT0Ofny9G+wF+WswAd6T6SRV3HSSZjsheVlF3H3Te2smds2jHX7
	d/3Irf3H7Z+CbcsQkijkkvpR7n9cEU4Yig7ZGAITVMkmWtTTqnY6hmhogBKQQB+hmZqOLT
	wZr6Gu+f84lxn/AB67o0IehsNJdxmPI=
Date: Wed, 15 Jul 2026 17:40:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-net v2 1/2] iavf: fix ASQ command buffer leak on init
 failure
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
 <20260715082548.56687-2-xuanqiang.luo@linux.dev>
 <MW4PR11MB5890DCEED74E887ACBC9161AF0F82@MW4PR11MB5890.namprd11.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <MW4PR11MB5890DCEED74E887ACBC9161AF0F82@MW4PR11MB5890.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/7/15 17:28, Jagielski, Jedrzej 写道:
> From: xuanqiang.luo@linux.dev <xuanqiang.luo@linux.dev>
> Sent: Wednesday, July 15, 2026 10:26 AM
>
>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>
>> iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
>> resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
>> unwind path elides cmd_buf while freeing the other allocations.
>>
>> The ASQ count is not set until initialization succeeds, so the shutdown
>> path cannot reclaim the buffer. Free cmd_buf in the common unwind path.
>>
>> Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>> ---
>> drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> index 6937b7dd44cbb..40f76f9507f4b 100644
>> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
>> @@ -60,6 +60,7 @@ static enum iavf_status iavf_alloc_adminq_arq_ring(struct iavf_hw *hw)
>>   **/
>> static void iavf_free_adminq_asq(struct iavf_hw *hw)
>> {
>> +	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
>> 	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);
>> }
>>
>> -- 
>> 2.43.0
> Looks fine, thanks!
>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>
> One note for the future - please be aware that there is minimal time period to be
> waited before resubmitting new patch revision, which is at least 24h for netdev/IWL
> mailing lists

Thanks for the reminder!

I also received a notification from netdev-bot, and I'll keep this in
mind for future revisions.

