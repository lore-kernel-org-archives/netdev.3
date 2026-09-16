Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD65221C0;
	Wed, 16 Sep 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575682; cv=none; b=kM3KPndkYg/aLn4dx6zQY/F32IzKA5TNqZWU1D1OFG56fl388SgGrhqUkYN8JGH31ZbVqUSqX1Ujxt1eXAaPWWtNGj4LHjjPHC4pKnMHSzSLZ+EasXSnslXcQQB/lkko8NFS4zyMDeUMUn1C33YWO8Ad3+izxsI2SFFZfpa+ED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575682; c=relaxed/simple;
	bh=0lMncFdJAIyse8zps8m6szqNvRqud/6DYdLeuviKeP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PayKnBgjkQ/5q41rdRRXAGbKEgxGQcyG+1GfPwdo2mXLvhUPQLHDpGYV34yfCfXaMSYsa93cPw/uLYQAQJSZXThe//eNGM2dhdhCSU+7EsMy3W+cuBOThZSEXXp5BF3WvgE1l6kIhHdjsYh5xZ52pXzX7CLao6l/K2y7r292iNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.42.68) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 16 Sep
 2026 19:21:05 +0300
Message-ID: <b43350d5-09d7-4fc4-9791-16bb4322d794@auroraos.dev>
Date: Wed, 16 Sep 2026 19:21:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ch9200: do return USB errors from
 control_write()
To: <netdev-bot+sashiko@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-usb@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260915185805.38712-1-s.shtylyov@auroraos.dev>
 <178954341078.22033.8722936070498955076@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <178954341078.22033.8722936070498955076@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 9/16/26 10:23 AM, netdev-bot+sashiko@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> - [High] Incomplete fix: after removing `return 0;` from control_write()
>   (drivers/net/usb/ch9200.c:137-171), the helper now returns the…
> 
> --
> 
> ch9200: do return USB errors from control_write()
> 
> This removes the unconditional "return 0;" at the end of control_write()
> in drivers/net/usb/ch9200.c so that the function falls through to
> "return err;" instead. The stated intent is to propagate usb_control_msg()
> errors to the callers.
> 
>> diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
>> index a206ffa76f1b9..3a81e9e96fd33 100644
>> --- a/drivers/net/usb/ch9200.c
>> +++ b/drivers/net/usb/ch9200.c
>> @@ -168,8 +168,6 @@ static int control_write(struct usbnet *dev, unsigned char request,
>>               err = -EINVAL;
>>       kfree(buf);
>>
>> -     return 0;
>> -
>>  err_out:
>>       return err;
>>  }
> 
> [Severity: High]

   But why? 8-)

> The commit message says this will "propagate USB errors to the callers",
> but do any of the callers actually consume the value?

   Most will -- after another patch:

https://lore.kernel.org/all/20260914202503.52920-1-s.shtylyov@auroraos.dev/

[...]

> There is a second point about the resulting contract.  On success
> usb_control_msg() returns the transferred length, so control_write() now
> returns a positive value (2 for these register writes) rather than 0:
> 
>         err = usb_control_msg(dev->udev, ...);
>         if (err >= 0 && err < size)
>                 err = -EINVAL;
> 
> Would the obvious caller-side follow-up "if (retval) return retval;" then
> treat every successful 2-byte register write as a failure?  Would it be
> better to normalize success to 0 in control_write(), or to check
> "retval < 0" in each caller and update the callers in the same patch so
> the errors being returned are actually acted upon?
   That's what the patch I linked to does...

[...]

MBR, Sergey

