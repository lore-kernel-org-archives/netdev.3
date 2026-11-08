Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153767;
	b=OlZ/W0c57DBGY/2hhdlT03gE9pBXvRWzMmuQ8Gcei+2OiQAI4/G83jyOBOB2ughStVcs
	 63Hu2zRG1tFzewGacMyj/8fNXm6QrHC5GnRwTXGXNl2o1/dUVrxFoEL6Vhgn6IsNgEoPP
	 0Q41woKPUW90xj3j1jeaFW5XULn6YjK5+bFfZ+/oMjH4gvDVSs9n9awAmaMbFGU3RooF2
	 yKd1OKvJHulUGHq59wYu+iZRSWGcg+4r1iJt8JxhYFQruNJPxsvAkK3Gg5tYmALtOWw5g
	 IzIsLun/3JRGJSqsmd8VfS366qyM/i0h3gKtb0C7QAxa0pQMvwa6qjFEC8OFNlNbpTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=J4NyFDuTUY3lwLAeO38/EuphRDS2yiibt54EKH6XAwg=;
	b=nbF+V2pPhdGopRH6ZAoOTHk14owawo+IVrSRwsnmron/ppbOwLaGEGCPT8gGPQz+kWHG
	 EooVFJRPxUZyeFWLmJh1WbhgLrKQ+OL+jtTedJbM9kM6nXdHGoLatFP+HioaYlATEAeJn
	 6VAnv6eXk87xX7qLTnDSOjhWxZz0o9vN62i+/2tR0Gh4nAZA2VjrGq9ApIaHHlgfd8lTi
	 hBmvo1UIRH9cNZNVHI2mcbS2a4umFaEEETXhLiXITN2Lrz5t7KxHDsNYTlNxi5rzRxwTe
	 BZILicJyqTuHqwOlCw6VhuKvVDWegW7Sm2gDlTYsRRTqEknehrBA8NTvxoXbkKlpPUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXrVrinl;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498C606A320
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 16:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C498C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXrVrinl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e4831c028so170054f8f.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794153765; x=1794758565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4NyFDuTUY3lwLAeO38/EuphRDS2yiibt54EKH6XAwg=;
        b=qXrVrinlnoFYJR0zwhqsYePzZPuH2zknXhHrNS6QnT2kPYj96nbj7rjAHL1HDd6dGM
         8t7eqj/zr0EkTZlB03P+un6k4zDtCRe7UZ5ho1yh+7K+1E7BgWtdZpjdd0cn5tg8pbi+
         NKqRk8Thqmhus2d98SUE8+pTfyI7LJt10Rt9bjMeWCqsVfp/DmOjdZX5mC/sLr5z5LPl
         fmEpe4I7pONmjE4D8CJUVmXV7R/ROr3kmoi5cCuWQBZ3mzBd3kMuX5CjWDikPzgA+nGq
         vOZTKs9OnotDm7w5ghWF0VHcm64ka/dIPRTy3HlH7WMggsh/0ELtHKdPyYYWH4d5Zb7D
         IPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153765; x=1794758565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4NyFDuTUY3lwLAeO38/EuphRDS2yiibt54EKH6XAwg=;
        b=ieIVn+budN9K7NURGPCIzb+/ZJmfGDTUzj25LMnS/5NYtvPS++GH+6QYx1DwAI+QZb
         l258IBn2Z39ypxmti0BziSF+e/SbsmbUOPaYXzugd8AqIr0krIZIKINwWHsp6KRXUJZY
         QcZ1KNx0ZN4FhG+2EU74639DLoRdnSEaYvQ7NZpDIVCTm+WWbYoGxUmgjOtd/erIsXij
         v8MbZifgORa7PCcsLtJKisPIZXDf5ynssl1ldO32W1vAqLC+j+gxPz8q5ONwHxsENcUU
         ly2GQXU8/f/cYn3sQcNKRlIkZebP+A7LY29BI4tHifcfUDURHzyKjFS01kbfJf7x3/Ec
         gB+Q==
X-Forwarded-Encrypted: i=1; AL+hErGVTqnxEPhxlFWwSJIk63KYvj5ohm6kC72cd/3AIXeSqUqogK5gpxqsRba0e00M75kbWJnl61M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vswVR/Cy/2vikU0lDqr16pW3NF2jaRmDAsIGtgNCMmKFRUf5l
	rIyNXq1HmFuznuqZpv8axOFE4//n+9QSC1+qvrOV2I/htiUhVDezklNT
X-Gm-Gg: AYBFou2LC9OUBccilUyvGRx7Nthiv/hj5mr9p4dSa+YyysrNuiekbZMcmdsUrOQFocp
	CyuPOUzHqnEtYoE6gpUkGfW1qPpY/yS8SqOi3yUwTBKvkfasaBSPXMMGtV3pqrtKgZtXYY8w9Ok
	ZfsQhS8vpk6KnX1mG7ZPcz2tyeC2BDsGIpiaEXrrPpEGdNy3tkEwpod2AM6TM1V8QQfsokexNtq
	dMNgp3Xp4TvZGGri5So+CmwhFhnrIqI9zEimEjitRcsraegkt6RkjG+0m7GJpiFEAbaPhRYSSe4
	+YAy0dIRyRJz36i0TTb+dm5u8sX0zMV1CLWkOtzgcJiHO9Pjn8wtYE4tyTKDxZjEBTxnMgDmXOk
	a46hsLiE9UmR/kVlZGVYMqDbTd2Qt1Xo8XgCXYinr6AkLVKxAF5862p7ldi3QMiHGiNIhoST4jd
	NsmFXdvuiDZeUOp+8kyrmyuSR5T6YmNAcuPfk80GZJ+d5a9QtW0W8XWPIiPMGIqxlHF9UqQAcbk
	KCJ/c2l3rvVEktNPsQvZek0M1V9cnkuvulbnq2GXG5VetfB+QvLBjSJK2nhdBghcEoH5uT1LcVM
	33MHV+ybqKNRBhj2sp4Rw98+/3te3N0aIdb81XAZZBQaN9gVutZhID1XEslrkQxLU2tSPp9lDVW
	/o9MUCqg788I4iofq07HM121HM1TLcp1VO0wmC+S7hLVWmutFb5ROIOcEuc/++S+N2gI=
X-Received: by 2002:a5d:5f90:0:b0:48e:4a8a:e17f with SMTP id ffacd0b85a97d-4958083082amr3604985f8f.4.1794153764903;
        Sun, 08 Nov 2026 08:02:44 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:7100:cde5:5d75:8598:b64f? (p200300ea8f457100cde55d758598b64f.dip0.t-ipconnect.de. [2003:ea:8f45:7100:cde5:5d75:8598:b64f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597d0a775sm4952992f8f.55.2026.11.08.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 08:02:44 -0800 (PST)
Message-ID: <3e6370f9-0905-41ad-a87c-c51c0a41513c@gmail.com>
Date: Sun, 8 Nov 2026 17:02:43 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net sysfs: simplify creating empty wireless
 directory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <0a0a7987-abb2-49c8-bc16-3938233ae9c5@gmail.com>
 <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
 <2026110816-crate-tightly-8560@gregkh>
 <d85b02e5-d9ab-4535-ab82-9b8184fbd1a8@gmail.com>
 <2026110812-angles-guru-473b@gregkh>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <2026110812-angles-guru-473b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.11.2026 15:21, Greg Kroah-Hartman wrote:
> On Sun, Nov 08, 2026 at 03:12:04PM +0100, Heiner Kallweit wrote:
>> On 08.11.2026 15:06, Greg Kroah-Hartman wrote:
>>> On Sun, Nov 08, 2026 at 02:46:03PM +0100, Heiner Kallweit wrote:
>>>> Now that an empty directory can be created with attrs being NULL,
>>>> make use of this new functionality and remove the dummy attribute list.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  net/core/net-sysfs.c | 5 -----
>>>>  1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
>>>> index 5c0402389c6..f58b59e1126 100644
>>>> --- a/net/core/net-sysfs.c
>>>> +++ b/net/core/net-sysfs.c
>>>> @@ -910,13 +910,8 @@ static const struct attribute_group netstat_group = {
>>>>  	.attrs  = netstat_attrs,
>>>>  };
>>>>  
>>>> -static struct attribute *wireless_attrs[] = {
>>>> -	NULL
>>>> -};
>>>> -
>>>>  static const struct attribute_group wireless_group = {
>>>>  	.name = "wireless",
>>>> -	.attrs = wireless_attrs,
>>>
>>> Why does this want to create an empty directory?  Surely you aren't
>>> adding attributes later to it, right?  If so, that's not ok either...
>>>
>>
>> For compatibility reasons. See 38c1a01cf10c ("wireless: add back sysfs directory")
> 
> How long do we have to keep that?  That was a very long time ago, 2012,
> why not just remove it entirely now?  And if the sysfs core hasn't
> needed this since then, why give other people the opportunity to abuse
> it this way as well?  That doesn't feel like a good idea to me.
> 

Seems Fedora learnt at the same time (end of 2012) to live w/o the compat wireless directory.
https://github.com/fedora-sysv/initscripts/commit/4e96fcecee7ab70295a5f2c52748cd57cbab60bb
So it should be time now to remove it. I'll submit a patch for it.

> thanks,
> 
> greg k-h

