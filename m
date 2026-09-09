Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336551A73E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950089; cv=none; b=O0+/N0YMQT3hQqlxeJE38w+/HvcLYkOu7DOMeZpQdnnbGC7x2JcqMUbIRSWw2ioxwK2mDBDE0gtnlzPCVSNbhAQAWS9VZx5LipudrcyzdrslmMR2gN5IAYP/XCVJ3xoYN9jrX/ig/DNYy9E+4sNdruJ/ZJtAfGGNFK4bFXmNCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950089; c=relaxed/simple;
	bh=kP07mdtgW5wUAWqvzj4hhyZrQCuNZirmAqSdLZ7Z/vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxjGUCdKfLDXBlw70Akw6nMePqXDVbDhF/fRprRP/ecnSRVFMj7ZEuPRgVoFTnmjIhvNCd8mffLCnkZzHrgx5br0YF0YotfllWvaZr/rV/Tsz9KWy4HPXmACTzgWh0iVyeiGJ+Df0PjFa/Gg5NhdOus7USQw+lhXv/VfqFtOsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjnUxR9x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lKZ2PU44; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjnUxR9x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lKZ2PU44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788950086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSPPTMlXJz35Ph6hazBsFM8Ov1euw/1XS6Hpd4IEgmg=;
	b=AjnUxR9x5rbaRsGKfIdrORQhS/1X0sbSL6f1jaszbK/ISQDgGdOHgTsQBwPgUnVGYH9l4q
	zHnjnpiSRExTJ/pf0QeJep6oDev96Ypiw99oqZAs5Zj6s4VeEp6ltWTcJRAPWhDzI1BA3L
	2CPfzzI735JWW0D6gDGW0VuVHBil7ZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-LvxATUmnOqiYpRvsbq4odQ-1; Wed, 09 Sep 2026 06:34:45 -0400
X-MC-Unique: LvxATUmnOqiYpRvsbq4odQ-1
X-Mimecast-MFC-AGG-ID: LvxATUmnOqiYpRvsbq4odQ_1788950084
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd55ee2f7so48771555e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788950084; x=1789554884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSPPTMlXJz35Ph6hazBsFM8Ov1euw/1XS6Hpd4IEgmg=;
        b=lKZ2PU44RjYm8GeWhfeU0fAFYrzXJN1DqcelnIzm7trysIqu2HY5rYZxnikkl5lEsu
         mamV0zjEd+zjAZRuKpiiNhI3XUNegFH5rbNasA/4I33vBnuIthffJzxaOgbGnPAKrvWA
         1p1kIDEtQ5Yc/XE2d9bhEj6geD0Y1JGdSUvZ15QO2yh3/khRLEqgEDSAuYpNI3HIkdpw
         B8B+Yo6rm2/1mMt+pkLd7VQ0BXGHaEJ82/zuKB79HdOwi8/X6qYM2QcrshDzxuw1SZou
         wTLLYQsp/LjnaN1ADJ7QOsvU+6Hr7dwBHpV3ar1SN1hRgkvQIVWAbTX8f/+zg+vM8CAD
         fyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950084; x=1789554884;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSPPTMlXJz35Ph6hazBsFM8Ov1euw/1XS6Hpd4IEgmg=;
        b=dJJNUP0VAd4SaKmf6Udnbju0CMqw7DuNqUsqyCS+TXfJDFO8XbxSHSaxPtoSd2sHiS
         1Z+cBP4dIZOSw6hmpxK34bD0kzZ8XHBS6XfMBMHf6XSbexgcJ4dcvugQfrdpYHhInZhr
         SxIa/t7ZRK/LNxB7hXjHca2u3WGpzoo84gyRDRnPeuAi9/USkA2yZ2HV334JkHsp/4cl
         /7hlX6Zm2aV2mc42hTg+ezPfEg8aVEtQeKO2eh5p/DR+vkj3BexVtdPvwAhjdmGS+qCN
         ad13w4DoHrOYKZrIMIdhQsmYWlXHQGlnLTCbvcHz6HkUtmzdbnRF9hUKsiecp9nShJ62
         J2Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwD9oFfKw3LtMD7UXMukPb25tsspu0L7vdSeBh7+A4SsG458gLpa1NUVZkWxCLwlzxSPRZZqSk=@vger.kernel.org
X-Gm-Message-State: AFuF++mGxO1H+kZ5mrjnY5wYPyC8/uvRpgV6zW+vFUpglWdYrnBdgU/n
	ncoPLxhTkX7VPbM0Yvq+w5aa54NuBv8sAsQBFsDJG+4ssY78/UZycUuIWv5Oa6+DvTjbPiHhm+b
	FpcEeGSthBIkeGlYdGr89UTRvNn7cDTKRTDqmG3SwUhTgfe6cYgm9U/e3Kg==
X-Gm-Gg: AYBFou1J3mYa+9rVa1vpxjw+mODUoIk5f1L9rSp4WZlBnI90h8Zt2emxNZCnxUQ+c7Y
	EGjG9sp96FF8+YES1hZhJ0OOH5clz2wJlEWd2G3HrmlYPr88KZ42q4YgIEedqPHhS3Z+BZZyIES
	VRYx67Msd5MwAMHhAroxlGNVvqHk8QYkjwotZQgk4dHK7FhVItrBYHwvYL8zq4uWIKhK+vQtqS+
	hm6qoY59anZiyEuhwENMpnYLWBpgmLypbIXemvi7Vnl4nFHAN7TETuGrarDT+0Tz84fIcWHSPHA
	Lf6q5hI7JksnD5Ncer8SuqcgHDR1WjwdzF3Nm3rBd4YnCJSeU1f2H2q8gK2OBbLYJlJzzWQ8R15
	ND6MYfbcDj8zHIFORME4KtMtwMbHD7b+8RGvCfW8vjdWDOcRTRC0nPhZIWReyQ2SmF04MIxSuew
	==
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49cf826c5f5mr330223305e9.13.1788950084009;
        Wed, 09 Sep 2026 03:34:44 -0700 (PDT)
X-Received: by 2002:a05:600c:c168:b0:49c:edfa:15a with SMTP id 5b1f17b1804b1-49cf826c5f5mr330222895e9.13.1788950083593;
        Wed, 09 Sep 2026 03:34:43 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0656e7bbsm357727445e9.10.2026.09.09.03.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:34:43 -0700 (PDT)
Message-ID: <83dd4915-e7a3-4c7e-91dd-adbea16450b3@redhat.com>
Date: Wed, 9 Sep 2026 12:34:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some clarifications on the upstreaming process
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
 <aqD-_cBnIOMEpxVh@secunet.com>
 <70d0048d-694b-4348-a6a5-de87a767b8fd@redhat.com>
 <aqEzoAcZ0uP0Kz6k@secunet.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aqEzoAcZ0uP0Kz6k@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 12:23 PM, Steffen Klassert wrote:
> On Wed, Sep 09, 2026 at 11:23:56AM +0200, Paolo Abeni wrote:
>> On 9/9/26 8:38 AM, Steffen Klassert wrote:
>>> I need some clarifications on how to handle future ipsec patches.
>>> Since we have the AI-generated patches and patch reviews things
>>> changed quite a bit and I have problems to upstream ipsec fixes.
>>>
>>> I have the following problematic situations:
>>>
>>> 1) Sashiko found nothing in the original patch submisstion,
>>> but found an issue when I resent the patch with the pull
>>> request. I think this can be solved by asking the author
>>> to send an incremental fix on top of the ipsec tree if
>>> it does not happen too often.
>>
>> This is usually the correct approach, with some exceptions i.e. the
>> newly found issue is impactful (the new code is exploitable).
> 
> Are you willing to pull this as is, or should I resend the pull
> request with the incremental fix? The latter leads to problem
> 4.1 (patch does not apply to net).
Due to time schedule I can't look into the series detail before tomorrow
my time. Since Jakub forwarded the AI report and left the series in PW I
assume he is looking for your replies to the AI comments - which is
pretty much would I'll do.

/P

