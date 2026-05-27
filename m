Received: from mta.al2klimov.de (mta.al2klimov.de [162.55.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043343E4B4;
	Wed, 27 May 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.223.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902552; cv=none; b=Lr7G9RqmTr+2sbBPxFW+bIZh+dx3ek3XsrJ6qpFNLhbc0T8GsJtbZk8bcf68aUeuLqhTlhfbvlg+10cH0dvQOSqgD3DWnSreaF7fRWQg7wDeKtsIsk1ej+Q1ZOPqo3SBIOvDCFztuRA+6+HWthrzXNzwiXI2iQ56T3u3haB6ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902552; c=relaxed/simple;
	bh=Pbcm9SAmqJM0tqLZipmWlKtIorq5H22yQEpLMbmTlxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHshvfn8f3Yc3S3SjSJdMR4iESk5W1X5lEGSGvcMYVdB6IqATYAaO07QHYFmyRdFZFqxPRwA0LDdr4h2xnEbDduBIM6UmBvdcarRhmxxKUfNygyAkj2MB4l+naGjAlWHVFQis2almLGXICftYiVdpXtX155xnq2Q4osluMtmluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; spf=pass smtp.mailfrom=al2klimov.de; dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b=rLHEumCE; arc=none smtp.client-ip=162.55.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=al2klimov.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=al2klimov.de header.i=@al2klimov.de header.b="rLHEumCE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=Pbcm9SAmqJM0
	tqLZipmWlKtIorq5H22yQEpLMbmTlxU=; h=in-reply-to:from:references:cc:to:
	subject:date; d=al2klimov.de; b=rLHEumCEPr3F2j3tc+5XR8S8Nxiyp3hmZ8TNha
	RyJ+xeiNDMzOqZWSa5Hku6DsJov+TYrdh5PtiR2cgCgPVgHgI/HKdcjCzt335GGBeUx6E5
	FNw+42EfTzR/G8HBUtfBIMa530tf+L4Z6lk4oHpBeWQL/T/oCxIl+Fvjkv2enXKB9xWP1Z
	b91Wy9GT+u1xgl3LbbeTMn03iZfBPgmqtMKstXay0h9gMOP/Q0BQZHfme70RpNTwR1L0+K
	2uL5q3geNYbsTGp5DcNT5lFh8uIQNW6BdZ7bE3iIIGzDceaJ8XvWQYsbll41cv6wS2ZW+Z
	GJgy8G0tQk6QpQJ3adim2q+w==
Received: from [192.168.0.101] (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id 371e7f99 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 27 May 2026 17:22:27 +0000 (UTC)
Message-ID: <1f859595-eb97-4668-966a-416db417fcbd@al2klimov.de>
Date: Wed, 27 May 2026 19:22:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ibmvnic: fix krealloc() memory leak
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Haren Myneni <haren@linux.ibm.com>, Rick Lindsley
 <ricklind@linux.ibm.com>, Nick Child <nnac123@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
 <20260526184105.18962-6-grandmaster@al2klimov.de>
 <fc74cefb2e0167514f1c3c0c3d6133ec@tipi-net.de>
Content-Language: en-US
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
In-Reply-To: <fc74cefb2e0167514f1c3c0c3d6133ec@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/26/26 22:50, Nicolai Buchwitz wrote:
> Hi Alex
> 
> You patch is missing the prefix with the target tree. Please have
> a look at [1] for more details on the workflow.

Damn. :-)

So far I've always got away with whatever I copied from the majority of
git log --oneline --follow FILE

> 
> On 26.5.2026 20:41, Alexander A. Klimov wrote:
>> Don't just overwrite the original pointer passed to krealloc()
>> with its return value without checking latter:
>>
>>     MEM = krealloc(MEM, SZ, GFP);
>>
>> If krealloc() returns NULL, that erases the pointer
>> to the still allocated memory, hence leaks this memory.
>> Instead, use a temporary variable, check it's not NULL
>> and only then assign it to the original pointer:
>>
>>     TMP = krealloc(MEM, SZ, GFP);
>>     if (!TMP) return;
>>     MEM = TMP;
>>
>> Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of Vital Product Data (VPD) for the ibmvnic driver")
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>  drivers/net/ethernet/ibm/ibmvnic.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
>> index 5a510eed335e..25d1d844ad19 100644
>> --- a/drivers/net/ethernet/ibm/ibmvnic.c
>> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
>> @@ -1761,8 +1761,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
>>      union ibmvnic_crq crq;
>>      int len = 0;
>>      int rc;
>> +    unsigned char *buff = adapter->vpd->buff;
> 
> Should be reverse x-mas tree (longest to shortest).
> 
>>
>> -    if (adapter->vpd->buff)
>> +    if (buff)
>>          len = adapter->vpd->len;
>>
>>      mutex_lock(&adapter->fw_lock);
>> @@ -1788,17 +1789,17 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
>>      if (!adapter->vpd->len)
>>          return -ENODATA;
>>
>> -    if (!adapter->vpd->buff)
>> -        adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
>> +    if (!buff)
>> +        buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
>>      else if (adapter->vpd->len != len)
>> -        adapter->vpd->buff =
>> -            krealloc(adapter->vpd->buff,
>> -                 adapter->vpd->len, GFP_KERNEL);
>> +        buff = krealloc(buff,
>> +                adapter->vpd->len, GFP_KERNEL);
> 
> Dead branch? The only caller, init_resources(), kzalloc()s a fresh vpd
> right before, and resets run release_vpd_data() first, so vpd->buff is
> always NULL here and kzalloc() above always wins. The leak can't trigger,

Cool! No leak = no problem = nothing to do here
