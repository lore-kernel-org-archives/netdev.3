Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6C45C70E;
	Mon, 24 Aug 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587225; cv=none; b=qEEE87i6KLSBh8cIvccFUBRn/oPKDK1X7ROx+Yi30h/IzivKRCmF2MfHQ+OF67tJywaKMjQjgn3SkoPiQu+Bhz3WTejb+na29REBZ5J07fE7niTKOIFvtqAJ5YgVDWVxM+AUcm67ggYE3bMfL8ywCh6DGJKvy0YmQwDnz36PUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587225; c=relaxed/simple;
	bh=iKmxx7O9Rt8AB+jQPOKu/wJ4vzGU8H4Qko8Ft9yudMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tzQ4VbXwU2/clkkBdEvrrbQYUuHvLKjdoLCsnngnLCSc/CZS/zpnMazfXLcSgxCzdGIwHTUi+RvcN4TZngcJvlFljVjDl4uu1fTFAwpnc+fR+BY3D08dA16EGKEl9EsHpw3iaVb4nlc2EO5Ye+GGU559t2cXVtaKqUVQlplcKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.79.18.3) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 24 Aug
 2026 19:00:09 +0300
Message-ID: <eff53efb-9838-418b-ac9d-f592a15ea76a@auroraos.dev>
Date: Mon, 24 Aug 2026 19:00:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8152: simplify loops in generic_ocp_{read,write}()
To: Michal Pecio <michal.pecio@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20260822202155.18632-1-s.shtylyov@auroraos.dev>
 <20260822230326.5d642593.michal.pecio@gmail.com>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260822230326.5d642593.michal.pecio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 8/23/26 12:03 AM, Michal Pecio wrote:

[...]

>> In generic_ocp_{read,write}(), the *while* loops look very strange:
>> the last iteration is executed differently to the prior ones, doing
>> some useless assignments before *break*. Move the code for the last
>> iteration out of the loop bodies, dropping the pointless statements
>> as well...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace
>> static analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
>>
>> ---
>>  drivers/net/usb/r8152.c | 67 ++++++++++++++++-------------------------
>>  1 file changed, 26 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index f61686433031..de9738bdce85 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -1431,27 +1431,19 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
>>       if ((u32)index + (u32)size > 0xffff)
>>               return -EPERM;
>>
>> -     while (size) {
>> -             if (size > limit) {
>> -                     ret = get_registers(tp, index, type, limit, data);
>> -                     if (ret < 0)
>> -                             break;
>> -
>> -                     index += limit;
>> -                     data += limit;
>> -                     size -= limit;
>> -             } else {
>> -                     ret = get_registers(tp, index, type, size, data);
>> -                     if (ret < 0)
>> -                             break;
>> +     while (size > limit) {
>> +             ret = get_registers(tp, index, type, limit, data);
>> +             if (ret < 0)
>> +                     goto error1;
>>
>> -                     index += size;
>> -                     data += size;
>> -                     size = 0;
>> -                     break;
>> -             }
>> +             index += limit;
>> +             data += limit;
>> +             size -= limit;
>>       }
>>
>> +     ret = get_registers(tp, index, type, size, data);
>> +
>> +error1:
>>       if (ret == -ENODEV)
>>               rtl_set_unplug(tp);
> 
> Looks like it could be shorter still.
> 
> s/limit/chunk/
> 
> while (size) {
>         if (size < chunk)
>                 chunk = size;
>         ret = get_registers(tp, index, type, chunk, data);
>         if (ret < 0)
>                 break;
>         index += chunk;
>         data += chunk;
>         size -= chunk;
> }

   That's definitely better, thank you! :-)
   I'll rewrite the patch along these lines, mentioning you in the
Suggested-by tag...

> Then it could be do-while, because we know size > 0, though
> I suppose compilers may figure it out themselves anyway.

   I'd prefer to leave handling of !size as it is now, so I'll
keep using the *while* loop...

> Regards,
> Michal

MBR, Sergey

