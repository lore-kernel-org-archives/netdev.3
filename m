Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CA2FD7C3;
	Sun, 23 Aug 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508016; cv=none; b=n3ukWF25P1mDb3TBBv7A/zAOPTiGHXi8ABIRboUxGIU7swapg6pvT0ykR4sX4xuMJc4gTWUeNqnTBFPwYBzDb3SkfZ/+EHJg0Vq2jxL/xyyAp0CNhMl8kP71er5AVppI/I6DYjoNoYwZmLRHk6ebBKrO4g83rS2xu8/1LsQPgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508016; c=relaxed/simple;
	bh=97QDPfohEIIivZd/werejf8J7hDmTG5Q1TT2BdkFizc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fmKq/y8ernJsHEB96e9f7yBMvW7KCHziNo03dijWrgdRHjR2cZKW2bYkms87OMgLjU2pINcyBOSvNYF+9ASLkSGX1FcNAo9GfDtNLdtDSRiiabA0SlkLwuwUUQMqAOH1LW0Uuf0wZQraggscvy+EcO/NuDoKBBhD1KIcbnv0yHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.10.7) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 23 Aug
 2026 21:00:06 +0300
Message-ID: <8d9b19aa-c44a-47d0-aef9-9cf5e639f1e7@auroraos.dev>
Date: Sun, 23 Aug 2026 21:00:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
To: David Laight <david.laight.linux@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
 <bf541361-3d57-4e53-8c67-78b474b420a2@auroraos.dev>
 <20260823091131.0254d6ab@pumpkin>
 <4a7604ab-c6ef-4552-b63b-3e7146ff42d0@auroraos.dev>
 <20260823105110.231a88bc@pumpkin>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260823105110.231a88bc@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 8/23/26 12:51 PM, David Laight wrote:
[...]

>> On 8/23/26 11:11 AM, David Laight wrote:
>> [...]
>>
>>>>> In generic_ocp_{read,write}(), the *while* loops look very strange:
>>>>> the last iteration is executed differently to the prior ones, doing
>>>>> some useless assignments before *break*. Move the code for the last
>>>>> iteration out of the loop bodies, dropping the pointless statements
>>>>> as well...
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>>>>> static analysis tool.
>>>>>
>>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
>>>>
>>>>    Actually, scratch this patch -- it's not entirely correct... :-/
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c>>> index f61686433031..de9738bdce85 100644
>>>>> --- a/drivers/net/usb/r8152.c
>>>>> +++ b/drivers/net/usb/r8152.c
>>>>> @@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
>>>>>     if ((u32)index + (u32)size > 0xffff)
>>>>>             return -EPERM;
>>>>>
>>>>> -   while (size) {
>>>>> -           if (size > limit) {
>>>>> -                   ret = get_registers(tp, index, type, limit, data);
>>>>> -                   if (ret < 0)
>>>>> -                           break;
>>>>> -
>>>>> -                   index += limit;
>>>>> -                   data += limit;
>>>>> -                   size -= limit;
>>>>> -           } else {
>>>>> -                   ret = get_registers(tp, index, type, size, data);
>>>>> -                   if (ret < 0)
>>>>> -                           break;
>>>>> +   while (size > limit) {
>>>>> +           ret = get_registers(tp, index, type, limit, data);
>>>>> +           if (ret < 0)
>>>>> +                   goto error1;
>>>>>
>>>>> -                   index += size;
>>>>> -                   data += size;
>>>>> -                   size = 0;
>>>>> -                   break;
>>>>> -           }
>>>>> +           index += limit;
>>>>> +           data += limit;
>>>>> +           size -= limit;
>>>>>     }
>>>>>
>>>>
>>>>    I forgot to check size for 0 here...
>>>
>>> I don't think it can be zero - assuming it isn't zero on entry.
>>
>>    Even if so, anyways it can -- if size % limit == 0 on entry...
> 
> Not with the 'size > limit' check at the top of the loop.

   Ah, indeed, I didn't realize this check is also "strange": the
code of the last iteration gets always executed, even if !(size %
limit)... Anyway, the current code is safe against !size on entry
and mine is not. I think I should play safe and keep that behavior...

[...]

MBR, Sergey
