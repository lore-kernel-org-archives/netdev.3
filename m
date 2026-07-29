Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61141A792
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318397; cv=none; b=AKnVQSuOS9/25MFvY9/fLXP3D7s39vD4xgLXfThaK0QPWw/H8zyZSIpXl6wN39QZc1trwD+T8c1V+8s2RlkfiMTJrNzZ6WzWyhNeMehDQReyHXLrhlJEEr4D97SXshfabGRp6DvMx/EJ86xpxwd12YLkU5Fi4AB+89oUpu+nyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318397; c=relaxed/simple;
	bh=7qQPhbO7x8cevphBaoSYKA87SBMgQmKWwDQX5TBBZrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hcv5GUmMEBJ73Qckun6BveZqPSkLtnnNC2TOOY+2+vkGt6+XxnztrhME4U0BrfxTbfVQapHvipb4sZxyM98ub9uArSapACv3NxIZIlnY472f9NraG3FdRu+9fXpnhmQA62nKAnr8hA/V9K7MA49g3saR+EAnKEzDMmzZdXIa8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEwXHF56; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEwXHF56"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso8491395ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785318395; x=1785923195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZX80IHAYk8WquP9pNurg4cyEfZNZ2WQi/VneUnNeO8=;
        b=AEwXHF56upoFyYJPJlkOYhSqy+Xj2cXcltS03zQcOU7Owtj1BIMNM09D5gv5vYMSep
         FkS4e8IHUhotU8a0zX0oryvsnFWSjoOZlzXgr7LpDl2brKe20OZxoiPyN/QLw+81m05u
         lexyq7BdqJUmaOFDKx4GsLkEW0gLLFggfb88x/6QKN/CEN2sh7Oi9vic7fSRtoIwN5d8
         A+z71jg9rGdQ7w8H7NcnLwFRA3W/Otaa7m19oM0azefAYJ5ZQFJaR6fNsoGzaTSjqdmP
         JAGWLx+xgo1UTB95sKh7F6h/APYY36pJreJlya5n6Yei6XW9m+BFqTFRLHdNo5JCPUWW
         RmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318395; x=1785923195;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZX80IHAYk8WquP9pNurg4cyEfZNZ2WQi/VneUnNeO8=;
        b=i1Ib4X5fe70ecTgenRLRGgFdGvdaXfHd26oWCn27jUxDyKp4CzkfbNsEw3vclcgJGK
         mXbbKVbqVrpV7X3aiJKbRoEqizUo8btbG3FJlgtHI9dHI1Aqj6aHh5mnjg8UpYb1RJjO
         Xc414pJzxSYkZX5b09T2HKp27DtdXuPf626DwArjqpayIJyqWYmW1TwmeXOPQDlYtmA6
         PgCnjfWoNfFHUblsncC9VVUJdFr9Jf8DGnnNUSCipp42je+u6tY/6EWLVoVXKCgfF7jp
         vj6Q7zxguJ3DrMIYXVi+zV/6WE1vI9q7U+QSUbupeXh5qvpq5/gEFnw0naZXDXO99AUo
         C50Q==
X-Forwarded-Encrypted: i=1; AHgh+RpDuaJoomWIA2UiZgrMpMoWQ8hF5oLs9R4e2pZFEXxoYD/LctM4uRl2OYsqhQM1Wbv1Z4CZji8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYpLcdZ2GJg5Y+xZ5WMW6S/A6XVq1nLdS5g4XXJ0q6zdSTCw6
	crOMcaD+2cuYhhW936QIQtOK8Mb0GbEReVqr8BprYV1xtadl1tlZv+Nm
X-Gm-Gg: AR+sD12/jP8kOALMgP38UQgdvAwXVGAytCvrz/mFcQLmvkdsg166iy0fwAbgMYb7FyC
	cbWvNRKY4xfjvPiTtIHlh/o701OYPBDtI8pafd/F7hF3azICkdzNyv6Nc2BsEE8sBuS+YsuItds
	GawfKpSRfdi34XJEewcC3lTBjby+BeMZ6oYHsCU4tNVSqBCQDlVFojG2HC8KURB5a52TeVCPe7V
	5IdR+fVaYhX7KQh0nCFZIv8GH5kDekDRyrSOyx4yIW8ZikzkuOv/R7fONad5IdJIX+FudLcyqjX
	ty0ECq9oSWKc2JYxm8lUDE/BZ+AdKx/9onSHAtzDK8K6z4aG9SmyFrBfkKendy3n8PauF9NVP/d
	o+1qx405vPwaNZiNId5/T/DnjFJOFixhsdAwS4J4HaQNoxWgXoGnj4vQCCPHfMJcXfc3v1cUkNk
	JvODwrO2HTQeo+QjbEm3UmpsYWvvT0+VhLxOjFO2Lt7iVqkOJZAMHFUxNTO5yQDrA/n8Zr15Upw
	xY=
X-Received: by 2002:a17:903:3d07:b0:2cc:ed57:c7c with SMTP id d9443c01a7336-2d015cbb228mr66348375ad.32.1785318395180;
        Wed, 29 Jul 2026 02:46:35 -0700 (PDT)
Received: from [10.22.76.22] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a4af04sm8816985ad.31.2026.07.29.02.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 02:46:34 -0700 (PDT)
Message-ID: <a4c89c00-ddbe-4278-b386-b83d2b859a70@gmail.com>
Date: Wed, 29 Jul 2026 17:46:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
 <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
 <amHN9mOGj7oMak4-@sgarzare-redhat>
 <27412e44-ab4b-4dd3-9685-481875683860@gmail.com>
 <a6cb1b8f-d8cf-412a-a204-3a26e4db0bd0@rbox.co>
 <6b684c2f-1f98-43ea-84c9-9b6f162d5e9f@gmail.com>
 <amhmjLa9DjNFKgmb@sgarzare-redhat>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <amhmjLa9DjNFKgmb@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/7/26 16:21, Stefano Garzarella wrote:
> On Fri, Jul 24, 2026 at 03:34:23PM +0800, Nguyen Dinh Phi [SG] wrote:
>> On 24/7/26 05:43, Michal Luczaj wrote:
>>> On 7/23/26 12:26, Nguyen Dinh Phi [SG] wrote:
>>>>>>>> ...
>>>>>>>> Yeah, we need to handle that part better, I think it's a 
>>>>>>>> leftover when
>>>>>>>> we generalized AF_VSOCK to support more transport than vmci.
>>>>>>
>>>>>> Speaking of leftovers, I have trouble understanding where does 
>>>>>> vsock set
>>>>>> sk_err on listener sockets anyway. If it doesn't, why vsock_accept()
>>>>>> checks for it?
>>>>>
>>>>> I can't also see where it can be set TBH. Should we remove it ?
>>>>
>>>> I couldn't find it for listener side too.
>>>
>>> Removing sk_err handling from vsock_accept() solves the problem, right?
>>>
>>> thanks,
>>> Michal
>>
>> Yes, confirmed, removing sk_err checks from vsock_accept() does solve 
>> the problem.
> 
> Okay, so maybe better on going on this direction. WDYT?
> 
> Stefano
> 

I'm still a bit concerned about how connect() and poll() interact here, 
even with the sk_err checks removed from vsock_accept().

For example:
vsock_accept() now lets us reuse a socket whose connect() failed (call 
it r0) as syzbot reproducer does. After listen(), r0 becomes a listener 
(sk_state == TCP_LISTEN) and works correctly -- it accepts connections.

But poll() on r0 still marks POLLERR, even though there is no error on 
that socket at that point.

As I understand it, sk_err holds an error that has not yet been reported 
to userspace. In the blocking vsock_connect() case we have already read 
that error and returned it to the caller, so it is no longer pending
Shouldn't sk_err be consumed/cleared when vsock_connect() returns it to 
userspace?

If you think the POLLERR above is acceptable, I'm fine going with just 
the vsock_accept() change.

Thanks,
Phi.
