Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B33F4843
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547423; cv=none; b=WsaX+rH3kUGEOarWEnAYMZQ0JnHPAgGfQfJxsdO1E2R9BxVDAdt35z+WqDOCWJ1NXsY42suovIAB0yJ6V7ADkBljxw4OLGtE93ybLo/QJ+HPT4NQxSPeu0Pbd5DC69cnu5n77cMRa4XG6/ch0IXtroV8s0162isCpgXPUdHREPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547423; c=relaxed/simple;
	bh=lfy9A+R4OT/C1WlI8cVp4JF5H+Np5KibUMak61dpVTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI42P2/B3Xi+H6JWrqmUJa2pSwFHg74eZOFDhr4BPGPyQNxzYpzO9wZ1yBeMinyGSSkP0biFABEbKtq9bMRSyFfKhCSkfMYBLZwylqsr6fZF6IEf4uJIvY9mspYS/xXzH2yhIqb8ia1wwz0upYcFFFF/j3FetS8JKt0o+zXX3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMgx/RDf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggfiMnYw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMgx/RDf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggfiMnYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784547421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUFpV4FJ38LScM2pwHRa69/ZPwFLGHi3MGED0c5Hvbo=;
	b=dMgx/RDf6W/GB5Vx43DNpF+mXTxzN0QNdOGbfI5nPezpu1iWzS20gholV6eKayw423BYUy
	EjSIA6GFfzHud2nvOHodj92K7OmEmIzsHA59zdA1R3RBqdMQ+15/4o9+MtXHyqIaNVRbC0
	020L/OUwc86+kfQYipawAX0J26poiJ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Nnrm0XrUOjOR6wCYYTCaxw-1; Mon, 20 Jul 2026 07:36:59 -0400
X-MC-Unique: Nnrm0XrUOjOR6wCYYTCaxw-1
X-Mimecast-MFC-AGG-ID: Nnrm0XrUOjOR6wCYYTCaxw_1784547419
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so10588795e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784547418; x=1785152218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUFpV4FJ38LScM2pwHRa69/ZPwFLGHi3MGED0c5Hvbo=;
        b=ggfiMnYwPIKbbNdU+hvwVavcBga8o520ODCyPsJT+7FgKVqFQySq8NDhU7gLbU5HdA
         IMb+kjeV1OIHjL1WOWwCruXtv6sPVR3XsQjn/WQO1HRKGxOkf+m15GKdcMnhnK4vc+0v
         h3b78MDqo8hUxA5zax8UVZ+JW+V8cdqSiZey15V8erYDIjfTGNQnxhlEN1HGFuBDjpgN
         h0EgiTFOjwfg8+wsTj3ixhuceW2D1JPykH0TXdpj6+4IQUzZjAfF0WymdkfIol8oEvjG
         B16m65xhD5+nJUKzdzQs+tPvF0wuwA/FgQmeJz8Y4w6W15+Oz4Y4IJhoRab8kSDzhY6B
         BNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547418; x=1785152218;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUFpV4FJ38LScM2pwHRa69/ZPwFLGHi3MGED0c5Hvbo=;
        b=WIxXj2jP5PsMI4j5ovGvnxPFlrKtc9uEANh/8ayF45HNnpKshfxR384xT6r4jmoQqI
         jnDW1EaF3uoYdlfBNel7R0JaV3jO6VQrsDtKF96/FlrvJEYsqzxdt6JprTcOtfwq42ek
         avoYH21qJslM6eXI6FaMnqUbuF6sijmeQKtwCEcBU7KyrStE4pPOqIBWbxYINzPdWrXW
         VwsaTeS+77rgLYtgfxa8yUWDgv8KAQDXwldw+/xjJ8zvC4Dv3Lg+ZH0riUjkR6b66OOW
         rkrCx21+4o+kf1MXfDX1imxOkDvL7q2EjujD7+hLZ0sG0ZA60FUT7QWkejJDF9AVPCcv
         m2DA==
X-Forwarded-Encrypted: i=1; AHgh+Rpzle37Yvif/JT6Sfv1UyTOBMc0NrqSjm9UbPQPxwRPtVw039RQQ7BGxq1il3fELkHok1BubQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFd1l8PYxZMY1TkIekJoa5sI1Zm2rNdKpsUz/5HypnMYhp70mg
	qiSIeBXEPI8vuQHEafjfS08ivx7H2B4bnkTKjR5eBEgILq1yWxkmXgVK+th+QqQioqjtNu+8juG
	Q3YKXH0UONB6RRTwVZVJeya24oYxKqSdagale3qApotlfhnbFNiU2K+TRmw==
X-Gm-Gg: AfdE7clauvxhovsihb0/pCqO7ReRcVC0CCoFd7UQBvFhsIi96Y2PF3C5K70jQHyixad
	qurusuuVhEIVVds3hkQfZbuYvbBTfVspTCZ/OxaMfaowpEN2RkuscutT/42UQZyCxqTcNrM0DHj
	6922cxxWGV4tOCqbP8V4mBZPFHtULthYggcfgKh/TfZx5830l1nVYh6H2gR9vo93dqovVoGJcRV
	NxLsqzADBRCygKBI4SxqPtXttX1wXEyin1ML1dg7908gN8vNN9hKcnUlp3MXTfFiEu6pWlAV57u
	4ljh6U0mlFIzqLFHposHMes/MrKKsxn7A2G2yjg0aaSq0vbhqO8Golb2FqoEYBaLQI9I815rjNx
	6kFj5cwHEiBXQ
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4954a3e6e29mr160745835e9.5.1784547418455;
        Mon, 20 Jul 2026 04:36:58 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-4954a3e6e29mr160745305e9.5.1784547418036;
        Mon, 20 Jul 2026 04:36:58 -0700 (PDT)
Received: from [192.168.68.125] ([216.128.14.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955fee64dasm57750365e9.10.2026.07.20.04.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 04:36:57 -0700 (PDT)
Message-ID: <acb60edf-0be5-4719-8f13-00cdbd1bb491@redhat.com>
Date: Mon, 20 Jul 2026 14:36:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/2] i40e: move ATR sample rate from ring to
 PF level
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch
References: <20260701093830.948756-1-mheib@redhat.com>
 <20260708143601.1491656-1-horms@kernel.org>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <20260708143601.1491656-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simon
Thank you for the review.

On 7/8/26 5:36 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> i40e: move ATR sample rate from ring to PF level
> 
> This commit moves the ATR sample rate configuration from the per-ring level
> to the PF level. It initializes the sample rate globally during software init
> and updates the fast path to reference the PF structure.
> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index a04683004a567..4d4d4b07a0f3a 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> [ ... ]
>> @@ -3454,12 +3454,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
>>   		ring->xsk_pool = i40e_xsk_pool(ring);
>>   
>>   	/* some ATR related tx ring init */
>> -	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
>> -		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
>> -		ring->atr_count = 0;
>> -	} else {
>> -		ring->atr_sample_rate = 0;
>> -	}
>> +	ring->atr_count = 0;
> 
> [Severity: High]
> Does removing this per-ring initialization remove the protection against
> dynamic ethtool flag toggles?
> 
> Previously, if the ring was configured while Flow Director ATR was disabled,
> the ring's sample rate was cached to 0 in i40e_configure_tx_ring(). This
> prevented descriptor injection even if the PF flag was later toggled on
> without a ring reset.
> 

The per-ring zeroing of atr_sample_rate was redundant. i40e_atr() 
already checks I40E_FLAG_FD_ATR_ENA before it ever looks at atr_sample_rate:

  /* make sure ATR is enabled */
   if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
       return;

   if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
       return;

   /* if sampling is disabled do nothing */
   if (!pf->atr_sample_rate)
       return;


When ATR is disabled via ethtool private flags, the function bails out 
at the I40E_FLAG_FD_ATR_ENA check regardless of what atr_sample_rate is 
set to. The flag check is the real protection the per-ring sample rate 
cache was never the thing providing protection against dynamic toggling.


> [ ... ]
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> index 894f2d06d39d0..b36e0fc9b31d2 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> [ ... ]
>> @@ -2879,7 +2879,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>>   		return;
>>   
>>   	/* if sampling is disabled do nothing */
>> -	if (!tx_ring->atr_sample_rate)
>> +	if (!pf->atr_sample_rate)
>>   		return;
> 
> [Severity: High]
> Can this global check lead to a hardware Malicious Driver Detection (MDD)
> event if ethtool flags are modified dynamically?
> 
> If an administrator performs the following sequence:
> 
> 1. Disables flow-director-atr via ethtool.
> 2. Disables ntuple (which resets the ring and sets tx_ctx.fd_ena = 0).
> 3. Re-enables flow-director-atr.
> 
> The final step does not trigger a ring reset, so fd_ena remains 0 in the
> hardware queue context.
> 
> However, I40E_FLAG_FD_ATR_ENA is now true, and pf->atr_sample_rate is
> globally set to a non-zero value.
> 
> Will i40e_atr() now proceed and inject FDIR descriptors into a TX queue
> that is not configured for FDIR?
> 
> If so, does this cause the hardware to trigger an MDD event and hang the
> TX queue?
> 
The scenario you described was already broken before this patch, walking 
through the old code with the same sequence:

   1. Disable ATR — flag cleared, __I40E_FD_ATR_AUTO_DISABLED set
   2. Disable ntuple — ring reset happens, i40e_configure_tx_ring() runs 
with ATR off, so ring->atr_sample_rate = 0 and fd_ena = 0
   3. Re-enable ATR — flag set, no ring reset

In the old code, ring->atr_sample_rate is stuck at 0 from step 2, so 
i40e_atr() bails out at the sample rate check. That avoids the fd_ena 
problem, but ATR is also silently non-functional
   — the user re-enabled it but it doesn't actually work until something 
triggers a ring reset.

This patch changes how that failure looks, instead of silently doing 
nothing, pf->atr_sample_rate is non-zero so i40e_atr() would proceed 
but the root cause is the same:
toggling ATR via ethtool private flags doesn't trigger a ring reset, so 
fd_ena can be stale.

Properly fixing this would mean triggering a reset when ATR is 
re-enabled. The reset calls i40e_configure_tx_ring(), which re-evaluates 
fd_ena based on the current flag state so fd_ena would be set to 1 since 
I40E_FLAG_FD_ATR_ENA is now on.

What do you think about addressing this as a follow-up patch on top of 
this series? Since it's a pre-existing issue, it feels like it belongs 
as a separate fix rather than being mixed into this refactor.


