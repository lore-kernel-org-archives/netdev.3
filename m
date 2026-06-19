Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82603438BB
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875424; cv=none; b=u/wzkuzrwfiQcjU0ks8HfRmlEG6iYYlBTAFN99UjzoOSZ2gK4zqPE1aQ5BHn7efAg4FvUjWuC5UOQM4EMc13geXjUEzlGzuM3pYJrgKjjcsF/bg/3kRw/kvMJC7R47AdOQud2voJRMT1vVOVCBTJt56gk3CyoHj2KwSlarCR1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875424; c=relaxed/simple;
	bh=K3jeaS/iIPypjh/26v18Z066QlX+Adyq4Qa4KlmM+Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gctNQCvgj8W1/837Lid+NGMdwWf01ym+2UKs5wYOuqBXBCrt79EKx0P8wn8hI9oCjg9T/PLP42KLU7Lp5HLYUwAaGGq+e6hpjVWyWZAA1RoLBxdkWj/6KKFVgNSENed6iDZfob4jes3bET6duxmgfX7Ojyv6kNtHTKizJ0GIkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpfGFZhn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpfGFZhn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso16022745e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781875421; x=1782480221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAWPzn34y8CYq6O+CxhrxaMNgqNT+C5Jv3hz1Na7La8=;
        b=OpfGFZhnCenTmcW5nkGIGj4IH7Qv0LpViSP4rTY+JJMHp1rRZ3m6nTD8s5LtVC0ajS
         NQ6CJU0zLP0pvVVk2yEqc7CQTWTTc5jYxj7skLPxfdC47xstOhWCj2RxivGr8BvjvC27
         kle05FPgr5+xz3BbdUqt+MqaQwe4VD/nStk2lXEkRrQuxbd4d8UH+3Y+WJ3s5xy0oEP0
         fyPHrhK7MMUc5K/GE4SdQcnh/8MWRf+2UmPm1OnE4D6wOSDEyrzW/pi7F/LrACoJgR4S
         W54EVinL8H2kXR4YMiZnagE69fASr0CcTNTDnQ/nSecRWP/BTL8nCq618HEl0MtP78my
         CuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875421; x=1782480221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAWPzn34y8CYq6O+CxhrxaMNgqNT+C5Jv3hz1Na7La8=;
        b=dNvhWDOcULIgfOSAI2e5FBRa1Ur9YQlw3Cjea7fIYdNzQ52coVMvaaJ08dqOtdpOu8
         o8blJ24WqT1WuqvLYMBVo5sXMREA/CEBfHcYzNSEmPE3bBnLMYJ5JH0BSh51mhwdTZ41
         UuMgGYbQxYyzFHkzG/cfJ4L06wwVkjCcLyg9WditaRkdbWqWwgMZejXEQ43nx4kCTudm
         QNebDjSyf6WIFBvc7cqGjaskcRxHfPniMxiKHs4+ku1HCha172j9bC6F7p76gT4goEmw
         WVbU4B1PNQ2lw9RXkH/PD2oU8cl0mBEi4aG5xsW2//CGuksjw6FUnLy58zm1jedIlmaN
         pPJg==
X-Forwarded-Encrypted: i=1; AFNElJ96d0r9rAEMQDm3BYqoXSJlzeI742LP1a3ByNCiO45biP4x7kBDdqJ9WaROJMnG4dILGCddO6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyof5HarI/ruQZ85uwaPgs8Cj/lSmeHYnzwUJEQ8KMZ2wMZqOB4
	aD89EP+I7FIDmws8sGOFoFxX+TSDb1dU4rQKddi5PRVYLHLw9vYlSpbS
X-Gm-Gg: AfdE7ckSvm5E814XVOc2mfsiUzQEke5XRc9BoPjLxBUn0tf6t7OxyTqA9OY1HjJrrxT
	011InuZTieQ5EIdMShGHf+HjJYz+upPg1Zx24wZPeuIJTpGprIH5VOX0Srsh/0EY266/iSYK8PU
	VmeMtJn4Ci0g6O7xYuxqrpMyTBNuy7vAmufTW7z6CMqXcMvXRdwggobNea/EEvwHxsbADmCvobO
	T5bQqXTxUGWQcbD1olGM+nFutS3t+xi9LpaYlgDoIrcEWVvUxyk4rHxBam6Wbop4kchs2/HmcYV
	eUmhCZiLH2FXwx1Jpps+2d3v03pnfQ6+iWUTK4O2VoActuCPdQkqCxEatNZcPtu/hkFtu4EVorb
	ZSjfMyPs6keJv9H8aU2O6S/MScxanQ0hgOs6dFSIWIfBzeXCYeHva1rf+FI7joMsZCciduHA4gf
	fgqJjpjJMB6HTK1IMGrymJArnjeke+4bECiQdhOYPYi3ri4j3HBsQCH4D36fvguNqARuO8o4Xaz
	dk=
X-Received: by 2002:a05:600c:8218:b0:492:1e36:9a90 with SMTP id 5b1f17b1804b1-49240a598e5mr40232245e9.18.1781875421282;
        Fri, 19 Jun 2026 06:23:41 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm76157815e9.5.2026.06.19.06.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 06:23:40 -0700 (PDT)
Message-ID: <5d131a91-f80d-419e-9b62-64ea0a1133c3@gmail.com>
Date: Fri, 19 Jun 2026 14:23:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 5/5] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-6-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260618181806.118745-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 19:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

One nit:

> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
> index 45e191686625..057d30090894 100644
> --- a/drivers/net/ethernet/sfc/efx.h
> +++ b/drivers/net/ethernet/sfc/efx.h
> @@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
>  
>  int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>  		       bool flush);
> -
>  #endif /* EFX_EFX_H */

This looks like a stray changebar, clean it up if respinning.

-ed
