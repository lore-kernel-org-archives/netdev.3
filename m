Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445523BA22E
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487877; cv=none; b=aevBk9D85X4nM7RWZSneORU4VUz4Y2ZlN9hupUNZEEI/gPfIo/eZCehHYr7th3/Tay+l0PNWU1Yn9e+slClNrgLxpQgZjOpxvFHsYNzi6saf/CTDo8PjGQusCTsSPtZU4Y/ZWEozC9TLecOeMTs47rs41oGcAdD7SIM1FKOBaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487877; c=relaxed/simple;
	bh=tBmbcWBOxRB/KGcfDMzhMHFt0EK9TotdSB1CdL8k/vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2/CJt3TT55VAydRRFAj/3Eo7zL+sFGGA5AQXwHKnjU6d18gRS4TeQZgcJpAuZs3EHmBvjKrtCNRS8SrBrhe+8j7bEBj5UWs4xVtw26yXJDRyXPzGHNXbIkJIlF1Y/rUGqEppA+3iuq+wd5keIXzdtY0YNxJYxWksoEJ2t7RfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fUonJIRq; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fUonJIRq"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8dd20fa3c41so6311226d6.2
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1782487873; x=1783092673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Myp1/AJ7+f45jiO/7vpdpmC9cty6oWFhDB31tMdKwqI=;
        b=fUonJIRqCCj1KNtD2vbj9j32mKhBUCCve5SkhNzZ0+nUqE3YE7bwoyGCLrcHuZp8r8
         jcy4UtnLR0ybfpVVSMrqncv2DNspfWWsx/a3S0lqLMykoWh6B5tSQ+/m1pQ8/fXFmWvJ
         Jdiq41x+oSimz5b6ska3vnpn1bB6UlhXZPwXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487873; x=1783092673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Myp1/AJ7+f45jiO/7vpdpmC9cty6oWFhDB31tMdKwqI=;
        b=bAY8El6Wpp1XSstkH2xc1a5XMgLUZqk2e1GbrLVGf0BDm/x2af3oAvY+W64UE3VoHB
         o8/EHjnp27xxBf6JIKmKqB0VCcITio46ZFardXCmpsCpvKKcV4Bho/nIzbdjaGoI+8jv
         3qyVnnDAxAXmWuAlM/4ESJs2TK+WWiUKPMj49bo0UH0E0xULDgCB5CyNsBHzu/ifkqBN
         WyPv/5c6H8c4zMrzohecHRBuoXYHCU3nslWkhbThoTpyKqOPHfgLcJPreuyLYULyVgZe
         lq2f8DLeT4z1kcK5PAyezPmaPSgTD62gVsv55kM61YIgktOo9uNT3Qddx2BeYdq9W8W5
         o/4g==
X-Gm-Message-State: AOJu0YwChB7kS/tN/SvAlOyTyccsqthCwn19rUUgdusVX7P1JH43VTWu
	0jv/YCFSo5bxp6s/jm+FVDPegLr8Yshura4unw5RkYX7AfEpYTNc1Knsc4L7KKYbHg==
X-Gm-Gg: AfdE7cn7hYPxvFvGgX3CBgiJqTrbLe37ocX+6z036UegV4PdJeh+ErV4hBZLU5AujSd
	31EIB+8x78wrTILuWUbBmEYjuCzkugfCa2Z8nU8jD+LKfYloL7tnbB5sDokCYp/zJGB2rdaFmGj
	KIp1DPd8Z89hWkoUF3cVhAZYnA08Xn5uSGJDcGfOcMA0DkEtewyN4SiTXvkcoKCHMDQstCG62ur
	yd7B6RCh2QkNVIlBb7YlHqmN/DKFokE5cYxt6CFbXQYaNDu8SGWCtYA5errsVYT3kUiBkjSClfF
	vQwATei4dI18bzBnmeMFDJNqCVHSiRdQyCM3uCqll7+mClAQR/o/x+ZgUs0b+a3ACOfQUuRSpOS
	AARxMMVj8mECpUdNBm6GMJjy0XCkRfzfhcmPuZslI8Z63BD3hLpoSOd0yN+YgRWuRac8Bjm8iUS
	QUb8LShN8=
X-Received: by 2002:a0c:fde2:0:b0:8e9:f62b:8fa3 with SMTP id 6a1803df08f44-8e9f62b91ecmr6028596d6.56.1782487873049;
        Fri, 26 Jun 2026 08:31:13 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-8df7ef1fe40sm213750836d6.4.2026.06.26.08.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 08:31:11 -0700 (PDT)
Message-ID: <51d2934f-0144-4303-af34-c7257ea02f24@ieee.org>
Date: Fri, 26 Jun 2026 10:31:09 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ipa: fix SMEM state handle leaks in SMP2P
 init
To: Haoxiang Li <haoxiang_li2024@163.com>, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260624065955.2822765-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260624065955.2822765-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/26 1:59 AM, Haoxiang Li wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Release both handles with qcom_smem_state_put() in the init
> error paths and in ipa_smp2p_exit().
> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

This looks good.  Thank you for the fix.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
> Changes in v2:
>   - Use explicit qcom_smem_state_put() calls instead of devm helpers.
>     Thanks, Alex! Thanks, Jakub!
> ---
>   drivers/net/ipa/ipa_smp2p.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..331c00ad02c0 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -232,19 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   					  &valid_bit);
>   	if (IS_ERR(valid_state))
>   		return PTR_ERR(valid_state);
> -	if (valid_bit >= 32)		/* BITS_PER_U32 */
> -		return -EINVAL;
> +	if (valid_bit >= 32) {		/* BITS_PER_U32 */
> +		ret = -EINVAL;
> +		goto err_valid_state_put;
> +	}
>   
>   	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
>   					    &enabled_bit);
> -	if (IS_ERR(enabled_state))
> -		return PTR_ERR(enabled_state);
> -	if (enabled_bit >= 32)		/* BITS_PER_U32 */
> -		return -EINVAL;
> +	if (IS_ERR(enabled_state)) {
> +		ret = PTR_ERR(enabled_state);
> +		goto err_valid_state_put;
> +	}
> +	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
> +		ret = -EINVAL;
> +		goto err_enabled_state_put;
> +	}
>   
>   	smp2p = kzalloc_obj(*smp2p);
> -	if (!smp2p)
> -		return -ENOMEM;
> +	if (!smp2p) {
> +		ret = -ENOMEM;
> +		goto err_enabled_state_put;
> +	}
>   
>   	smp2p->ipa = ipa;
>   
> @@ -289,6 +297,10 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
>   	kfree(smp2p);
> +err_enabled_state_put:
> +	qcom_smem_state_put(enabled_state);
> +err_valid_state_put:
> +	qcom_smem_state_put(valid_state);
>   
>   	return ret;
>   }
> @@ -305,6 +317,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
>   	ipa_smp2p_power_release(ipa);
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
> +	qcom_smem_state_put(smp2p->enabled_state);
> +	qcom_smem_state_put(smp2p->valid_state);
>   	kfree(smp2p);
>   }
>   

