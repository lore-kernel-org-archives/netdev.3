Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF43B1EEF
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026738; cv=none; b=hQWQv+pOm5M/K+NiZanv5RBRevIzbuOmCIOJ7jrljNqVP8N9N28pLUNg7pN5RsnctJBu12aoBNrYpIrjH6rsk2H8DbcaDyApiK+Q0cODIEwzzaY19voYZGvUlFEHhxcKJw91hBZn6DDCWkLMqdxMQOFQhRE6QPeO+0aPb+OCWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026738; c=relaxed/simple;
	bh=DoTLDoZAc8+Q60nsS97XWzusuz0k89fPZ3SCF59brQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSqF0P2teWAY8CVQOM7cEZmotu9rLiXJq1jYIo4KfAFsdu8r/d/fFMBOQmq6DE6kliqRR4iX1yZdX7u2+U6ud9/wVAml3hXjp/PywhuJvIRoYBt9bXgZUuq8HYBKU0E4/eMfRF2U/xw/ttqO9v53+g2Bq/aPB6mmHmMPfl9ODqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGCzIRmk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGCzIRmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026738; x=1817562738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DoTLDoZAc8+Q60nsS97XWzusuz0k89fPZ3SCF59brQA=;
  b=VGCzIRmkZ90wZIz454tKEC4lMwaO/uBzZ8symImkuDPNAPkFkt3ZNq8i
   4yF16SjQkD8Lpr6Qpwzmq8OzJl4bf3HxuXeDW/W1rk2WY+Jscc72xqGG/
   WM48nOKdqFoFkh3gEszRQUAT8lBhjZA5py5CX5T8ziiXEhqBv979nu8p5
   MIi5cNR1XZZMk0VbbOBv+rQfecO9t3FEPhdeKDh/paGVopIH8ZPW9GcOu
   6kN0FNH+yxyUPf2M9+k2YfdXeOpqTAN/Busf5tYsbysLBb6G9bdaR29s2
   UTiSTLvWQYuwRQgN8IozwpPSUiPOoipSN0RaXQjUMVKzoOzWUGqg8hmKZ
   A==;
X-CSE-ConnectionGUID: /lrDI6Q4TRW95ht6La4gJw==
X-CSE-MsgGUID: BohJBGljTpSOEx078z+EmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86829752"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86829752"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:32:17 -0700
X-CSE-ConnectionGUID: 1SYzp0QjSgW5PNsBN6EULA==
X-CSE-MsgGUID: WkTgm0QXRCeN7uRihIiPvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="286792944"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239]) ([10.217.160.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:32:15 -0700
Message-ID: <2c551a5e-22f3-42c7-a6ef-daf246e57cc5@linux.intel.com>
Date: Thu, 6 Aug 2026 16:32:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
 <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
 <willemdebruijn.kernel.35c676937c974@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <willemdebruijn.kernel.35c676937c974@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/08/2026 16:19, Willem de Bruijn wrote:
> Marcin Szycik wrote:
>>
>>
>> On 03/08/2026 23:06, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
>>> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
>>> field in a single operation.
>>>
>>> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
>>> __le32 to ensure the fields are written correctly also on big endian
>>> platforms.
>>>
>>> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
>>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>>> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>
>>> ---
>>>
>>> Changes
>>>   v1 -> v2
>>>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
>>>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
>>> ---
>>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> index c724d429a7aa..91ca75e45463 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
>>>  				    struct idpf_tx_splitq_params *params,
>>>  				    u16 td_cmd, u16 size)
>>>  {
>>> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
>>> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
>>
>> While it technically works, I find it unreadable. Looking at this line
>> without reading commit msg, it looks like a bug where a 4-byte value is
>> written to u8 field. The intent to zero an adjacent, unrelated field is
>> not clear. Consider assigning these 4 fields manually, or adding a
>> comment/function doc.
> 
> This is a bug fix, which generally should be the smallest surgical
> change only.

Agreed.
> That said, I do agree on the style, and a follow-up for net-next will
> clean that up too:
> 
> 	@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> 					    struct idpf_tx_splitq_params *params,
> 					    u16 td_cmd, u16 size)
> 	 {
> 	-       *(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> 	+       desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> 	+
> 	+       desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
> 	+       desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
> 	+       desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
> 
> The fix is queued. If there is consensus, I can respin. But given that
> we will clean this up in net-next properly, my preference is to keep
> the minimal fix as is.

I'm fine with this. Was the cleanup patch already posted to next?

Thanks,
Marcin
