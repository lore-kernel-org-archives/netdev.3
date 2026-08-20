Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31A4229B0
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224783; cv=none; b=BSPMePo02IrCxeCLHHwSQUF9gFagXMRbhS7qw2bhy6BT42AWUHjBTNqJ17/R64pQDFTxHA1gMQQbWpzOE/dCzeJK/O8vqgi1VeK3q/8Z3E0ezOWB1lprzMazEwtn0FDwbSnrdFt/+0JUIam/ltYNlIFmzDearIx8fd7FhLUaC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224783; c=relaxed/simple;
	bh=jcvUQicqdqzUgKeSjbTl0UKM8JYz8pmqQYKIy7zgv4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooA8PmyLBgVMOePjoFP06+ryO8S9vpdFBk1oz4/zZGy8/9mjGgtmjcC5ZUNkBRWH7UG/joD1M7NwjvvnfiZ7BrG7BO22m9KP1y6hXuxIaErYvNhKTyjW1SZrXuYzHxzLCBcOrMexCzqLAZgNkWaH4ih7GSWpav0XV/NIzI3GpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLVR3Vrm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=emenpTkl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLVR3Vrm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="emenpTkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787224776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o8NFi3s7zb6B3mmWlGxRD/OiqVaDC6PWfUryprr8lE=;
	b=LLVR3VrmcT3LgkCbB4VbZnoZtnFn1kE96HDaFqeT7Bttr7esKz0x0hPVidqUWNQoqpAdqK
	DA3D23hHY8987JqZYuN3+3aisX7e7pYbBa/CWbz7N5ClkFweqHO9tjlNunc3lh/CGzp3FP
	azMT8yrAUMx3jgE6OOV6EA7mMmPw8yM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-0pteSn4_P4-BkK5E2F_Knw-1; Thu, 20 Aug 2026 07:19:23 -0400
X-MC-Unique: 0pteSn4_P4-BkK5E2F_Knw-1
X-Mimecast-MFC-AGG-ID: 0pteSn4_P4-BkK5E2F_Knw_1787224762
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so19844025e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787224762; x=1787829562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8o8NFi3s7zb6B3mmWlGxRD/OiqVaDC6PWfUryprr8lE=;
        b=emenpTkl7yYMOn1ebUMg9Y3eyLkCMFAfzI7PtBjjskIY0qrKycV0CmPdUORM6nt/A5
         QssnETeQ4mTLMs+svsUjgMO46wc3+t+u7fmbgOFAQCyf5/xcOu41wcmAdtozV3XzfHBB
         /Sb8Aw8qyvaFd0vjVka/Sep/SlHwU87a2xlIg6PClFeG0ryoUlCz3deSrc8JqWFbFAYn
         3+KbHr2IaI2y5VHF7hIeoHmVpKGiSNMbV+o2Rs7At43le8Iw0wPLKmZUwRK2/de09pTD
         ocv8q7Svw6POjLMZ1VsBqDRmfzQLnfouYIVF0YP9uQ61GVKOh1hlgjjSwtoytxyXFGqC
         s+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224762; x=1787829562;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8o8NFi3s7zb6B3mmWlGxRD/OiqVaDC6PWfUryprr8lE=;
        b=kfAnBVmiICO6PveVOZEbjCOKOpi2Qgf4w1rgcC/w79dWeSGEPEYaLp9oNxVFcEQ8Je
         watgrgXm26u+2EbHbPgGMgXFBIPUOC3rn0xertImxpkMUom9uDsIuTNhsjGQ3VAdGOAT
         e7J+A4twZhff+BrndmgZpTtUnLVQZnhk5JRH3r4xYxY1C8n/ks9y1HkjyzBM+BPTp/DH
         WULXoqqXjNFHos9Ag/ZR+fn00oHg0DRUtUccbTP8KDYUxgiKa4HsLXPKoekfym7bJOFR
         J6tCRsWRbsi6PlmAVgxkUHIw3/eu+kcYblvT9Gk+7+fNKtmsWPaVWB6O/u7Kg4n9RM8z
         QJIw==
X-Forwarded-Encrypted: i=1; AHgh+Rrm8iDJJyKuUDVh+XtjdOG5bUbpSxrGLZBbgv4OpXyMZC1HbDA0s9Ly738JbWdosG8rGC5pQNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsps2T3M5tfNgkOLBuDFkpOu45lMZ8JiiyanW4v9BkbE+m9+Xd
	b83PlSGB/j0If623CaTN4qMZp6wxhTVdxQs0cQvOPB4LZ2BVzsKc/+u3Cogpgwucu+d993m/RUw
	sAvcSf0OanOdnyO06PAjnU2jtmwjVuHAmh5laV3hrutxGG+OOtAtTxk4KsQ==
X-Gm-Gg: AR+sD12oKsxM1b+GeblIgaslJOnm5Q33ji9OT121/KZaWMYAekeHFMtjjv+iqbM3L2B
	H+JTJy4u/bVElCq0PPUXqaPjDvEiNTR+m+S8t6pXkgU+vH4GVqkhjp79sQYxA3HpBRE4vR8C09/
	YrXDtlyysBI2kxcIddRsfKEC9FDOgRxGvIjAiwwbVs31ks/PZ5nGj9jw0SQoXQpRgPXTyHxgZMz
	kUnDWqakoDjPZmtpPuIV35EhssKvvj50wWYDY7+cfif+Slijgqn3m79X5EukeoJgkwm/DrYZwpG
	ZGEIhuqqIiSHxtOgH/dVujodX3xmwmNZR6s5L7kbRIdGJneHCDz7iUMGuodLnB4FxWnf0Uu9D9P
	0VqhsSr3o7GS/VI0lE5a+lxwlZRW1BQfX797Tta+BdzsVha9qd1P9YacEq2t4m4WiWlwwUKEwRy
	E=
X-Received: by 2002:a05:600c:a012:b0:499:52dd:c1f0 with SMTP id 5b1f17b1804b1-499aa180132mr233779875e9.1.1787224761780;
        Thu, 20 Aug 2026 04:19:21 -0700 (PDT)
X-Received: by 2002:a05:600c:a012:b0:499:52dd:c1f0 with SMTP id 5b1f17b1804b1-499aa180132mr233778895e9.1.1787224761352;
        Thu, 20 Aug 2026 04:19:21 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa11f832sm132733055e9.7.2026.08.20.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 04:19:20 -0700 (PDT)
Message-ID: <7c5a9d55-a15b-4235-a308-cc6f65ce2de9@redhat.com>
Date: Thu, 20 Aug 2026 13:19:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/10] pull request (net): ipsec 2026-08-18
To: Steffen Klassert <steffen.klassert@secunet.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
References: <20260818092920.653034-1-steffen.klassert@secunet.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260818092920.653034-1-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steffen!

On 8/18/26 11:28 AM, Steffen Klassert wrote:
> 1) xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
>    Tighten the secpath-depth check so a full chain can't write
>    past xvec[].
> 
> 2) Add and revert "esp: do not unref managed frag pages in esp_ssg_unref()"
>    The patch does not fully fully resolve the issue, a corrected version
>    will follow.
> 
> 3) xfrm: espintcp: fix UAF during close
>    Synchronize espintcp close with the xfrm_trans_reinject work
>    queue so the freed socket message isn't dereferenced again.
> 
> 4) xfrm: drop ESP-in-TCP packets with no ingress device
>    Drop queued ESP-in-TCP records whose saved ingress device has
>    gone away, avoiding a NULL device deref in the XFRM input path.
> 
> 5) xfrm: avoid lock inversion in nat keepalive work
>    Split the NAT keepalive walk into a reference-collection phase
>    and a per-state lock phase to break the AB-BA with state removal.
>    This patch has some issues that are fixed with a followup patch.
> 
> 6) xfrm: Fix skb double-free in xfrm_dev_direct_output()
>    Stop freeing the skb unconditionally in xfrm_dev_direct_output(),
>    letting local_out()'s result indicate when ownership has moved on.
> 
> 7) xfrm: ah6: validate routing header segments_left
>    Validate the segments_left/hdrlen invariant before rearranging
>    the routing-header addresses, avoiding an OOB memmove on
>    malformed HDRINCL packets.
> 
> 8) xfrm: fix xfrm_state_construct() auth-trunc leak
>    Detect an already-attached auth-trunc allocation by the pointer
>    rather than inferring it from the algorithm id, so a prior
>    attach isn't overwritten and lost.
> 
> 9) xfrm: bound nat keepalive state collection
>    Replace the per-state allocation in the NAT keepalive walk
>    with a fixed-size batch that drains under BH-disabled locking
>    and resumes from the cursor, bounding the worker's memory.
> 
> Please pull or let me know if there are problems.
Sashiko has a few comments:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818092920.653034-1-steffen.klassert%40secunet.com

do you think they deserve a v2 or could be handled as follow-ups?

Also the fixes tag in patch 10/10 looks invalid. Possibly a rebase
would be needed?

Thanks,

Paolo

