Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1C3F5BFC
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844043; cv=none; b=o0GYI2soeBvit1hhjJ6bx/SUvxIqHVwe/RKLml4mcQXzG7gxo2+ljuVw1OnQt6un0vVG+b718XPcYEiOfIUGWxnfW/RM+PN+PSNhiejtamEa2GiXU3gcgxGqJdauTNevxk+VDafdhbrYAAivWK+qyqTYES6WY2UV6Ml+EgDcaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844043; c=relaxed/simple;
	bh=JXO/glbfJfGZGtSvJc4vd3lfkR3dadkjue8XStgKAgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGKSM2dNY6FJZtnXWApNLQjHKW03IdZrBR7jrzJ81CWnAWYBx2yFbYJ8uvtYpt3ygSeakah8GDM7CK1bIHeYGDwKqCblB/eUtdeSnJBCmHyuc/jLRNA6pXM/cPU2NVono+H72WJXPbt7xRkrki80pXn7rJivOfsU70bG4MxrySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnSeoVTJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfIb2mLK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnSeoVTJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfIb2mLK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790844040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DL85yCfgbq7S5St/q3o/ZoxYnp+7M2TW1mb3xvZ37Gg=;
	b=TnSeoVTJqwerZzZ7gCt9G/q1f3yCNJ8ge9p32pc1SaYPMHSd3OckAU0kPOc61kXO6uOHFO
	diG1L9axYqJdzsTjEa+LOPk59RVCbX0B9/4qGYdwaLMzFzdrruifNUy9wvNWudLb2Qzz/M
	s+Gu2Iq9j+N/lXA4JES6X3QnpALDTJ4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-WYvWiB6JNZC_BHuuA8z1EA-1; Thu, 01 Oct 2026 04:40:38 -0400
X-MC-Unique: WYvWiB6JNZC_BHuuA8z1EA-1
X-Mimecast-MFC-AGG-ID: WYvWiB6JNZC_BHuuA8z1EA_1790844037
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2dd399f761so408251066b.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 01:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790844037; x=1791448837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DL85yCfgbq7S5St/q3o/ZoxYnp+7M2TW1mb3xvZ37Gg=;
        b=KfIb2mLKoyiUt8zXY9ehzTjJ8Vr+6xUsvQJP3cXlBv3s8ovGB/tl8vFlLlUmmguvIN
         gBnm9zIQ4nbgISa3R3PcsMQopm4Bndxa0RJvvmTrNG77bI1QV+nkwRj+aEub2ax8IWp6
         +yp+wSq/tAYqgmBj7mSCGrfxPZCAdtB7atDKZdOygN7dkO9S/3mnV+r2AeYsWGLGwFiG
         mvs6B1/QXqBv3oXMO/hjnr4J5lyKDBlcjrMcG6Bp31281yR5JXrcTnYi4OzHz0fs3nsu
         h1ySZkxBvGRqf0FzKvUn2BSynkOUBqm15ork9DA7dI41wkBZ3+CQmF9qBKdmgRBMIZTR
         1Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790844037; x=1791448837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DL85yCfgbq7S5St/q3o/ZoxYnp+7M2TW1mb3xvZ37Gg=;
        b=YH/0ZGnzdl4T9jNyR9tjQZeFXv79QrFVDcV47Ouwsh99XcM9A5hYO27Ydh/iztryxz
         bx+T4Ov5yDzshGVqkxOYJlD8pBMdJBfCjMHaJ34QWFcvGKGAAlU2qvXDzj/W2OpIPjBn
         wAQQEfz8FNaMuDWTi4atWhi/BT5V8pXBALFvOwigmT6yxb/tWrFigTXl5YfktcbD5OX0
         jQ6cB3/9keQzjjBa4MtYsAdtLYeW+shLxAErWRs7czMM/QLgH2GqQBTgyqqgYCfc1VQr
         vW55dTXlEHQJMcbnf3MB+sgdHdl+IsI3xTzTHh6Vh8saxpqRv3TDtEIolIWJljau7oQv
         NmrA==
X-Forwarded-Encrypted: i=1; AKwUvBybf4+6n0VDG9nFTx+2i0QKPjKxsgEmE2Y+eYUrCyYRaL69Pa20x9O8UHIRmXeY4zjoRxH4R3s=@vger.kernel.org
X-Gm-Message-State: AFuF++mYZIdXDNOrBkXN6GkdoJaLRrd6tgu+KZFr9qu8hgADxSbyRgj5
	bv4xSYNEQmS73Vnn3rVEFXDBLkoEIoREBpRckuzJ/ZwCO5/ZWDDa6GW6QQ8uNrnMJIO4z32sCp+
	kSMHZp7IYK9FEwahomrDj6jCSXKjLhFM7mmm6P/9rqdmVKpm6tH9hYQ/CXA==
X-Gm-Gg: AYBFou1gf5ThktBtOJrA3Wi/R6WbvAPjFlfQmvSkEsHsZagFgb/ZaM8B6wa4roR2Xc7
	ypwMP/Wf/ZazXbZUSyDX0PgKdGnE4OPUkBtLCmA2JUq2yomZVO+M6/gR5s6anVPS15zVidMqNOr
	pYViWhbeTUcr23CPmDNrm1s4mII6mQRboDn94Y0VkL80EF/qhSKw5r6HaPgY5lN7PkcRgCKTHP0
	KQiZ4GNAYSwcY/l6ZjOqCBXTGcPDHJHNTjn2rhKy8m/x1jBydh3XKtRojPzVbqnnlOeFbY4g6Fi
	RqR55UlY9nq7glogeviRzLZBTGC/27i1cUSoEG7mitif1uoA9SFTgz0RgAS+Hpe1FeqPmQEDCrf
	9MTHYiIbVxZ/fSq3OqvZoIo/8K8W2amt3BMnmdAfZ8dRxWztl6VlYce1p3Y41TEx7fjbWYAIbKA
	==
X-Received: by 2002:a17:907:97ce:b0:c2a:fbe1:7340 with SMTP id a640c23a62f3a-c2e23e0d58cmr318837866b.41.1790844037506;
        Thu, 01 Oct 2026 01:40:37 -0700 (PDT)
X-Received: by 2002:a17:907:97ce:b0:c2a:fbe1:7340 with SMTP id a640c23a62f3a-c2e23e0d58cmr318835166b.41.1790844037027;
        Thu, 01 Oct 2026 01:40:37 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e3185cf7asm119481866b.0.2026.10.01.01.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 01:40:36 -0700 (PDT)
Message-ID: <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
Date: Thu, 1 Oct 2026 10:40:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/29/26 22:43, Marc Kleine-Budde wrote:
> this is a pull request of 16 patches for net/main.
> 
> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
> CAN-XL devices.
> 
> A patch by zjamg restores the skb header initialization lost during
> the v7.0 release cycle.
> 
> Oliver Hartkopp contributes 3 patches for the CAN net layer, the first
> one fixes the net namespace integration for BCM, ISOTP and the CAN RAW
> protocols. The second one converts the unreliable ARPHRD_CAN type
> check to the robust can_get_ml_priv(). The third one fixes the unique
> skb identifier regression under RPS, introduced in the v7.0 release
> cycle, which causes lost packets.
> 
> A patch by Joshua Crofts adds a missing
> pm_runtime_dont_use_autosuspend() to the m_can_pci driver.
> 
> Maximilian Zimmermann's patch for the xilinx CAN driver adds the
> setting the ESI and BSR flags in the receive path if they are active.
> 
> Jiale Yao's patch for the mcp251xfd driver rejects devices without
> match data.
> 
> Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.
> 
> The next patch is by me, targets the gs_usb driver and adds
> workarounds for the HScanT USB to CAN adapter.
> 
> Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
> driver.
> 
> A patch by Stefan Günther targets the peak_usb driver and fixes the
> CAN-ID when reporting CAN errors.
> 
> Chris Strong contributes 2 patches, to fix an out of memory and packet
> loss problem in the mcp251xfd CAN driver under sustained receive
> traffic.
Linus has started pushing back on the ever-increasing net RC PRs:

https://lore.kernel.org/netdev/CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/

We are trying to defer things to 'next', especially this late
in the cycle.

I think there are a few patches here eligible for that. i.e.

can: gs_usb: add workarounds for HScanT USB to CAN adapter
can: remove CAN filters independent from namespace
can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

WDYT? How much a pain would be shrinking this PR?

Thanks,

Paolo

