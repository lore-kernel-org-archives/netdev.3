Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573704192FC
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768231; cv=none; b=Zrb6pQjsZpDNS04frUjETqaiRG+AMAT08fxxBfHTX5QfBAI5UdWpIs4ywjFDABsR751rbUDGNpJ6LuL8gRLJf5KTRn3vXQi88jmCSArsYxnY2ACQfdtflZcvp0KLiWaTHAanMn1+nOTY4EnKbmTCfENP1mRj9yfL6Tks4QxfsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768231; c=relaxed/simple;
	bh=wmhdTlozBmFoYEFKSTbuXzEqCAXVERRyi58TT6Rb4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDXKZlaAlXDtpybRaLmM+dS6SPXBK6BeSH6RuMGsrRg1eDYyEci4YHadptpvvEiY/EcgJnUK/CFuDv472oC50TxfdxvSn6EgYs3nZiPR8FySPEO6SsLClDuetp3N+Ryc4NQuTLqGYJlzb+z7/1kG+pDCCxoQ8+a0RJJsF12pg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R61G/nRG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+YsSxVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R61G/nRG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+YsSxVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788768228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S01/akrLSba7r0QPArIs2eHPrcFzuABNmLC8uce5/dQ=;
	b=R61G/nRG9T0LnRtmbKc+rB3wPWABlksh/ukKiOZxlQUjW5iAyerFtotYL389I5UP8PYxD4
	h0CKmkt1IY1EhXWzYbPohVvN7o98YSlrHWEF9OUw55MzzVoMKeS+BLv8GeFBRimbje1miZ
	zCTDJpAnhKC/ylXXL2NhWq9WObdoMF0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-itBuJ2KnN2SmPK5Ay1UXAQ-1; Mon, 07 Sep 2026 04:03:46 -0400
X-MC-Unique: itBuJ2KnN2SmPK5Ay1UXAQ-1
X-Mimecast-MFC-AGG-ID: itBuJ2KnN2SmPK5Ay1UXAQ_1788768226
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so36795695e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788768226; x=1789373026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S01/akrLSba7r0QPArIs2eHPrcFzuABNmLC8uce5/dQ=;
        b=V+YsSxVAbMLu4Smi/3oqSDFlD5iRUhC7R0Uq7E1xi/fe980pwxBvlPe3nwoISjUmU/
         Uzmtjntu3OflbAlidgfbgdbBfrPB22WbJL9kI4hudBAEm5prPasSHJy4yVTJzIXotuHV
         F9xe7OG89oAgugxKN1m1jDAt8CDxlDAZSoeKcKDvSQqyFHtyW+pIOZNcgsX10+GIdYvL
         zfUGmoI15EmBtHeqyHkyCaTiLA5GwhP3Th9ZbjtyFOC1x2cZlHhz8M+hNJItQPQYNwgZ
         1oRUof7alKgj10gnPwY0cEBhoVp11ZUyNsBP6r/EsAnsMWLMigOb7xmzLQ2EnYeDrlx/
         9CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788768226; x=1789373026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S01/akrLSba7r0QPArIs2eHPrcFzuABNmLC8uce5/dQ=;
        b=KkMlDS6IiXseYKAFxpapvejQMu/1DQq1X3GTgE+goegk7V/AV42l+RfTqZNtlvNJLg
         UuxztA1yBz0IOGU0EM64A79xeYAjzwAvCqbABH/ULKnbnmNIc5YB+aeIfHMZ37SdNrnx
         wOHCMmiVQWLVDRZvtJX8iMdsRXUSapU0xKXQD6A4bA+HIHHpcpbbEcbgEylGqb1+UmRV
         MYiwu/YclgSZE3oH/sNPX9f+i1B6UrehoOvWbmbDja0ms6f9eEPKgxmuWL7+Vgg86FZb
         PqvRJN26a/s4FztWmYY9gKVmIcPpiMuMmgtDDWUIUcLoXgRak3uzxDckqF9Q657OIrkR
         3tLA==
X-Forwarded-Encrypted: i=1; AKwUvBx72yuitIHm533M9EgWRu8njstVswLSUSrkbV/P8sBir0All+NVUB+s1LS0xvOaWIXhsNY/Ibk=@vger.kernel.org
X-Gm-Message-State: AFuF++nlJhkcnWaxewS4+taJuMgu1eELFfP8VG8B91Ne6Akb4mgPClzY
	Mf7pPPgC9w2YqCcUOyqaooshW1mPEsAFsh6wSvJ3FZpDg8Wyx+i4vJF8mWbyicsTW8+RyeL6e2T
	9+XstlCdFKhm5gETh2z6lMZJ9reAfeA7y/2cioLm0jIkP+DNwBWUqsWfVxQ==
X-Gm-Gg: AYBFou1mxtfjDn0RDUl0zkwVlxwC1ZH0MrMeWlrW3OvsVmEVy5gXJ0W4SPFv7ziaPL8
	SShS0nmv/yxRDm/7wJCtyI4fJzBlsOKrgoVkEqOoEp+XsDiE6PHrfYtGZidiKdoPSQK608uSouw
	othng4e+o1BGYRUQJD/ObmdLKe6iTENBVLbMmc+80G4FCsedLiw5KshvYTN4EahRtsyuNypMJ07
	xtDU8/ZfNrNZRMavTzM7dmHeWH2LlPsRWgrV/dgpieP/zlRPqHiVFlToMbxfUtlgbSK0b1aGkaT
	oPG1h4BAZ3aCRRkotc37W/DHQRlak3PtgLjP7XYLrAqyRl0I+0L6bN9oNHYpLfOixvdnhp1tyxV
	OWQAzFQ6mWPPGvVmnKML/vZESG18voJ5WEgtZ7G5LFqfWsg==
X-Received: by 2002:a05:600c:5254:b0:49d:5ff:f404 with SMTP id 5b1f17b1804b1-49d05fff5abmr106384025e9.1.1788768225245;
        Mon, 07 Sep 2026 01:03:45 -0700 (PDT)
X-Received: by 2002:a05:600c:5254:b0:49d:5ff:f404 with SMTP id 5b1f17b1804b1-49d05fff5abmr106383095e9.1.1788768224533;
        Mon, 07 Sep 2026 01:03:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm200078385e9.13.2026.09.07.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:03:43 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:03:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: weirongguang <weirongguang@kylinos.cn>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Rongguang Wei <clementwei90@163.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v1] vsock: validate buffer min/max size in setsockopt
Message-ID: <ap5uSKRcfnjhXyC3@sgarzare-redhat>
References: <20260824091257.136269-1-clementwei90@163.com>
 <20260824131632.2d325c42@pumpkin>
 <e16178ad-85c6-42da-931f-f0b2f8240828@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e16178ad-85c6-42da-931f-f0b2f8240828@kylinos.cn>

On Mon, Sep 07, 2026 at 03:45:54PM +0800, weirongguang wrote:
>
>
>On 2026/8/24 20:16, David Laight wrote:
>> On Mon, 24 Aug 2026 17:12:57 +0800
>> Rongguang Wei <clementwei90@163.com> wrote:
>>
>>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>>
>>> SO_VM_SOCKETS_BUFFER_MIN_SIZE and SO_VM_SOCKETS_BUFFER_MAX_SIZE
>>> do not cross-validate against each other, allowing userspace to
>>> set buffer_min_size > buffer_max_size.
>>> When min > max, buffer_size is silently clamped to an incorrect
>>> value. For example, setting min=512KB then max=128 results in
>>> buffer_size=128 despite the user requesting much larger buffers
>>> via SO_VM_SOCKETS_BUFFER_SIZE.
>>>
>>> Reproduced with a test program:
>>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE,
>>> 	   512 * 1024, sizeof(int));
>>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>>> 	   128, sizeof(int));
>>> // User asked for 1MB but got 128 bytes silently
>>> setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>> 	   1024 * 1024, sizeof(int));

The user set MAX_SIZE to 128, from commit d114bfdc9b76 ("vsock: fix 
buffer size clamping order") this is the behavior we wanted, to ensure a 
rational limit on memory usage.

>>>
>>> After that use getsockopt to get the buffer_size = 128 and
>>> buffer_min_size = 524288, buffer_max_size = 128.
>>> The buffer_min_size > buffer_max_size and the kernel accepted
>>> contradictory values without error.
>>>
>>> Add value check to fix this issue. Return -EINVAL to userspace
>>> when setting MAX_SIZE to a value smaller than the current MIN_SIZE
>>> or setting MIN_SIZE to a value larger than the current MAX_SIZE.
>>
>> That is going to break userspace that sets the minimum before the maximum
>> when the new minimum is larger than the old maximum.
>>
>> David
>>
>Hi, David.
>Thanks for pointing out the issue.
>
>Here is an alternative approach:
>instead of returning -EINVAL, automatically adjust the other value to preserve buffer_min_size <= buffer_max_size.
>The trade-off is that setting one parameter may implicitly adjust the other, but this is preferable to breaking existing applications.
>Does this approach look reasonable?

With this fix, how would that change the results of the test program you 
included in the commit description?

Honestly, I don't understand what we're trying to fix.

Stefano

