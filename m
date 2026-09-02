Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C102415B6B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341058; cv=none; b=tsELnwyAS92AI9nuyzLwZekByj/2/S6WW7cAYAHuuDJ5awwRLI1uAVMjd7UqqpCyEnJzCpOgI3LaKM5j6hy8Tn2227enzD2Q/6cu92q4qG4PtovvjbWvRqyJE7uGukHm+2JxgKK4+GGqvkFF9WIMSmgpjQSLUe8wYIXoyvpf14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341058; c=relaxed/simple;
	bh=wi3qO921M+VWsBBas/ZiJoc39eV+5WMK/Bj0xc7Pj9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isrCiZRi0Qon6DWzguMmKaTKVR8ZmgNXe+lrfp4yazVn/bBEvVjDRkstbhTqwHq9EOAneSzwwPLDCItEhGn+bMFDzmcwa14E3NBdpPIXTbgpyvPnEuOKs9ZAknzLnrV2VQ067O5Cgaa0pI4VVKBS/edmoee1u3btUZNlMjpuKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfWjZ6CJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfCtEel6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfWjZ6CJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfCtEel6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788341055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cnDR0n4+GLAv92tnJZywkhWC5Cq0oacjpAbp860Ber0=;
	b=bfWjZ6CJsv0lpfk7rCZ1NKRt61ispc4ygDWC9bBHWgWYNKMcMRp+4SGnDxDWS19ZyBpOc+
	8yRu80XueFWk00c5V/H+g3pPcIinDD5kvA1H6mGFe2Mjqhu7O+8cQz+Xy3FJByRd5kapmk
	paRPbiGLYJHfAhoZWXumDwwLPqxkiEg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-jDZWxrBIMSWq64opL_dG8A-1; Wed, 02 Sept 2026 05:24:14 -0400
X-MC-Unique: jDZWxrBIMSWq64opL_dG8A-1
X-Mimecast-MFC-AGG-ID: jDZWxrBIMSWq64opL_dG8A_1788341051
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2538c1c649so94570766b.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 02:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788341051; x=1788945851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cnDR0n4+GLAv92tnJZywkhWC5Cq0oacjpAbp860Ber0=;
        b=OfCtEel68mAVaTm/5c5tvmHHX+jqWXCkMKB4kWh2ZBAVvmTSu/PqBFHTJEBj+MfZxR
         iKUwCn2T6EhFxJAHG4uK0GIRj2SgUVYir9eCXJa3pkxWOd0NeLkqJ8BDvIT/l13uPn8c
         K+hEbEFBUaT6wIbCP+U2r8js9RkQJKhFFV7Op923XV6Z+Qy2vzW1HQKv+ZwcmkvfiOE/
         gfbY3vsS8LqzagJLUVnwxZ+NoKAzVZbl5vXehr2ifqqeOzcrJ8Z0VQcXgcsgezxyAcVp
         ddtSBkPa6ssKDM3QyAZVjM2H7ZbfQcWE1BQIwPBp+ZSpU4iSywHbARqQvuTajmOReObf
         5MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341051; x=1788945851;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnDR0n4+GLAv92tnJZywkhWC5Cq0oacjpAbp860Ber0=;
        b=AXQPGXRJhkxiRSUv3Ofdd6mg//PwCdPtKiJx+aBq1CQaHCJ2WDAqYL85wCu7FU7nWT
         LLDgLC17dJmyNmZ4mwQj1tePFssk0+rhcyB5x03wzkqdk1MLbs6ZldOUrdGHy3yeJs96
         mtJ7633MD/P34vgE+TVIiBAsrpR2wiq/FfORXVQgD4WRZ44AJkD79uL61dQhR9RjyTry
         /fqqV4XP6tGSYzVYwo5+9m1G002FoklgfZDgEsAQfBYBxxjq1xA5z4BpgecblpS37xNa
         WAbb+ZHFN791qcVvzu9mCGt6AzNbNRXPtN5cCCWbmwoHXCinBZsiLXwAutiERVWoc8o4
         C4gg==
X-Gm-Message-State: AFuF++l+kNGEm2gTGKYQbdRE4hH/98a7X4435cnEGS8P2cachYDJRdxU
	QAiXCZTkON1wrthdNxmswtnXlHoUt/ygD8iJvGL7p8BDod8tGzcDKktsco4YBO92YMhma0VZRp9
	HWN7t6mKdGEsLNqLW9JaU8g0rs3S6o0JX77sb9+smL2XwT0DLRt7JHih2Dn5zE67wUg==
X-Gm-Gg: AYBFou1wD4Wajo+huejhGUVK2ydvParuEj0MWxlWsEpvQh8hyMWq96ww89StJMtaO0A
	6jbGhJODfBG6fDx17cY81ks3q3OLsutrqXBSnDf/ZiQpnusRW4aQIVHlrH24Xf5ZcaMxEHdP7x1
	FNj9+bVcM2wal+EqPO7YoiQgt3H0uKiuOFBVfGdImzM5iobx74AqhO7wHaXbJBnAe9l7zixW9lI
	Qtq/0qvnR0gTFLeLY/8t0dNBAMqONY8jXpDyiMXxBT2VFhbLcT3PZ6cvCcvyu3crjXdQUJ0b5/0
	sB/dWFocJlWkftYoRYkq4AnBoOajSCvKBWbeC1ZOquN6UDH/9QqrXgSoJEUUkDngHS0kz8Mu0qf
	55dJYiOif8wG/M/gJLFpdVlEmBc/VOIGpKwDOISIjdW9QgyQzbTFWKVPIgMjYW4a5vcED1XTy3g
	==
X-Received: by 2002:a17:906:99d4:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c25d52b4f8cmr209871566b.10.1788341051261;
        Wed, 02 Sep 2026 02:24:11 -0700 (PDT)
X-Received: by 2002:a17:906:99d4:b0:c25:58e:83ff with SMTP id a640c23a62f3a-c25d52b4f8cmr209867366b.10.1788341050845;
        Wed, 02 Sep 2026 02:24:10 -0700 (PDT)
Received: from [192.168.188.103] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d044d776sm96589266b.62.2026.09.02.02.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:24:10 -0700 (PDT)
Message-ID: <0d3f33cf-d1db-451b-a4a6-25b22fd9bb5b@redhat.com>
Date: Wed, 2 Sep 2026 11:24:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: Make skb_ext_put_sp() idempotent
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, kernel-team@cloudflare.com,
 Jakub Kicinski <kuba@kernel.org>
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
 <20260831-skb-ext-prep-work-v1-1-ecc2a8542fd9@cloudflare.com>
 <20260901171520.072acdd2@kernel.org> <87ld9k2oaq.fsf@cloudflare.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <87ld9k2oaq.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 7:51 AM, Jakub Sitnicki wrote:
> On Tue, Sep 01, 2026 at 05:15 PM -07, Jakub Kicinski wrote:
>> On Mon, 31 Aug 2026 08:27:38 +0200 Jakub Sitnicki wrote:
>>> +	if (!sp->len)
>>> +		return;
>>
>> Somewhat mixed feelings about explicitly checking what is the loop
>> bound, anyway. But I guess you can argue we shouldn't write len?
>> Probably not worth a respin either way
> 
> You read my mind. Then I thought maybe I'm trying to be smarter than the
> compiler? But it seems that neither clang nor gcc eliminate the write:
> 
> https://godbolt.org/z/EcWTdEYqh
I'm a little late here, but it looks like sashiko cataloged as 
pre-existing a couple of issues that on top of this series can new 
lead to memory corruption:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9%40cloudflare.com

Could you please have a look?

/P

