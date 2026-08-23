Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0B364E9A;
	Sun, 23 Aug 2026 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787473242; cv=none; b=rXJ/VWLWNp3iNdPr2qw9NuFJFXIH8GSX/mKShp++iY4OfpJCl2avl7rjE71Phjj3e5NJWuOqqaW/CIcsUjqd5IH0XIpv2tdceUYzliZ1FGKlaJhwvmlQOB2RWIYFtRPNA7qjW4zbzJjphPliucPuk9QxDBbwnahQV/2UR8ZtOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787473242; c=relaxed/simple;
	bh=OpSFy2+G3fh9VOWGlb7OO1yv5570nXxWUBKIMfjV2eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dyghiRNcCl3nyfzcCXA0Cp6o7L3MiSMSkVG/9kdzW/OyvuiAo4VcEpUcqEGVePthCYrbM2oQYvHBV1bXu5uCshn4GPKXil0dgzBIFunurBih0LX3FsV55Ug8GIWr443WjIRKLstrU3ZwhCwY00K41sfz4s2dcYYPoSshm24WkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.20.171) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 23 Aug
 2026 11:20:31 +0300
Message-ID: <4a7604ab-c6ef-4552-b63b-3e7146ff42d0@auroraos.dev>
Date: Sun, 23 Aug 2026 11:20:30 +0300
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
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260823091131.0254d6ab@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 8/23/26 11:11 AM, David Laight wrote:
[...]

>>> In generic_ocp_{read,write}(), the *while* loops look very strange:
>>> the last iteration is executed differently to the prior ones, doing
>>> some useless assignments before *break*. Move the code for the last
>>> iteration out of the loop bodies, dropping the pointless statements
>>> as well...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>>> static analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
>>
>>    Actually, scratch this patch -- it's not entirely correct... :-/
>>
>> [...]
>>
>>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c>>> index f61686433031..de9738bdce85 100644
>>> --- a/drivers/net/usb/r8152.c
>>> +++ b/drivers/net/usb/r8152.c
>>> @@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
>>>     if ((u32)index + (u32)size > 0xffff)
>>>             return -EPERM;
>>>
>>> -   while (size) {
>>> -           if (size > limit) {
>>> -                   ret = get_registers(tp, index, type, limit, data);
>>> -                   if (ret < 0)
>>> -                           break;
>>> -
>>> -                   index += limit;
>>> -                   data += limit;
>>> -                   size -= limit;
>>> -           } else {
>>> -                   ret = get_registers(tp, index, type, size, data);
>>> -                   if (ret < 0)
>>> -                           break;
>>> +   while (size > limit) {
>>> +           ret = get_registers(tp, index, type, limit, data);
>>> +           if (ret < 0)
>>> +                   goto error1;
>>>
>>> -                   index += size;
>>> -                   data += size;
>>> -                   size = 0;
>>> -                   break;
>>> -           }
>>> +           index += limit;
>>> +           data += limit;
>>> +           size -= limit;
>>>     }
>>>
>>
>>    I forgot to check size for 0 here...
> 
> I don't think it can be zero - assuming it isn't zero on entry.

   Even if so, anyways it can -- if size % limit == 0 on entry...

> David
[...]

MBR, Sergey

