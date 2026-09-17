Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C84E2F3A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647488; cv=none; b=L9DxIrf0JF7EGo3X8QmjuunSLuuz+M1j6Ygz7MiQDpLIYTiyxvsuMvFY1X0je/QeGyinD6Jbu4RrBIL2qYZl/za6qRYNoR/AvCX8/jQkGdzrQST2nCG7tVneWbrdAy0Q/91kSyZVRTH7i4NxGqRrJTUzA3Xypj1+BpZptvkZIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647488; c=relaxed/simple;
	bh=jxxrLK1RVTIembjFJi4fT/dtsvhHsrbPFHD5t5ovx+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kae7mh7226RYEG+27YkdMGmFyuQbVAdRWFcN30hsUm05flSRB4ZCSjrGjf7Zld7eXqLMW+g33p0FfcxDukMLYIOwG2Hee8NQqtGKcTt1HWiPEILz6zkfCmrwvGLpEo4D9cgbgiVeXaLYrE45xZVNU2CrbIvZvGcYmYMfr9Jbg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=brwS8Gzi; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="brwS8Gzi"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7fcb425fb68so451302a34.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1789647461; x=1790252261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/CnLftEvKl62DKetab2YvCs3DqAzBULF24/3TZ0i+E=;
        b=brwS8GziG2zICsy+/ioB/6JStxIhgk1QG8R9AIZ4BT6wcDuuef725e5/d0dRyWzPyr
         4hFoyHKX6D7QwoIL0ItSrgbWcOElOZDFKteQP9tHT69O/KceU2klTdpttHHvmCm9z2qV
         4tCUo9oTUyOTvmwNtsCVuMwdDpzGrWosoOZUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647461; x=1790252261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/CnLftEvKl62DKetab2YvCs3DqAzBULF24/3TZ0i+E=;
        b=rNgOCeCsaWCpmWx2CC40erjPImNMGQbxdr6GuzN7FYoShEmGp13EvFfGGq5dcpReZd
         OJS+wCRnwFVQskrgKzza5QysNNUUtMO8vQ4TtSA8h0ygdhukzQ5iKN24BzHI2IfdVhZB
         WvPV4ixr5D+yirBra4M3ABBEfrUNTbxuVTROoqsTYl2Dg6Kqb5YgopcmDfn1sTzFy0C6
         6IevmMWLMXmxZ7QOyuRy2MqZaOMRfFee3gBfa9+nlcU3eg8GzeIg2EEYTO0THHY2tLVx
         WPNw8Phs+kpGxrBnRKco1u75XkcUZn5MwP+USYqlYVOvV5WGKHj5J6AsMmN5bZNaG6PZ
         zfPw==
X-Forwarded-Encrypted: i=1; AKwUvBwzE7307YAVungIJfRff99OTogo8Q16Ejtzfk6CHzn1TGy3jc8Ps7bGGAfQzpKE41gF0FZisCc=@vger.kernel.org
X-Gm-Message-State: AFuF++mnaXFL74y/WUQI0OoyroC9uSswsEBuMoakHzyzMBKjfqNBMoXO
	B+C8VM7qitT1+40O+HQQiyazBbWu3B6KmpqN5cu0RimDHyFv9xdLOy/Up/0a6HvPRA==
X-Gm-Gg: AYBFou3i2TIAg+DIEQFO6JOkSgI+b1NII9N+h3GwZnvGKKv7krifwpDT4bYi1PVufXT
	ZkDheWg02Pqj/P0ue1i3LLSU3vByfPNf8nMTDBPWXoJQx+4kKoHI7+EGSEu+qGjJo5lTi6jrLdr
	ns97rJMYrrieEpLZ1E4Zt/9+VbsziMWrc4OEiCK/KLy7DmL4IRZrDvHGJZf/eARcH8GJtgqJyAQ
	t+JnhMeFlgUT3PN1OSVfo5RN+l/hC5YprPS3rdT7gSF6xS3KvyfpXzW+uoZSvCHsBlW5BavAXSV
	UPuDNDJYwNegah9MddOX8kJlmL3fodV/Y4DnbLWBy89cqZXAVwsGsBaYoPLwGHmathx469UlkhC
	DQA0M8nNmhTDGekZnJypXIDjLSgHUai4DgBGK79BkKPEDBaq1sUHfwh2BmdkL0vqTb/14/FrCz2
	rI/+QXz/bt5RjNUTDhISzqfCA5+EXSFT4scEpIroWcBFy9BK6bEqW1DRwdQoPN8z+UsgO4Cx5Ez
	RxX
X-Received: by 2002:a05:6830:83b2:b0:7fa:ac4f:785 with SMTP id 46e09a7af769-80b2dc1d7d8mr6835533a34.17.1789647461009;
        Thu, 17 Sep 2026 05:17:41 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm2805680a34.16.2026.09.17.05.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:17:40 -0700 (PDT)
Message-ID: <692ed9ca-fac1-42cd-a514-517f6903f8d8@ieee.org>
Date: Thu, 17 Sep 2026 07:17:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Fix enabled_state leak in ipa_smp2p_init()
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, elder@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stable@vger.kernel.org
References: <20260917115216.2149867-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260917115216.2149867-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 6:52 AM, Wentao Liang wrote:
> qcom_smem_state_get() takes a reference on the state, but
> ipa_smp2p_init() returns without releasing the "ipa-clock-enabled" state
> when the bit number is out of range, when the smp2p structure cannot be
> allocated, and on the error paths that free the structure. Release the
> reference on all of these paths.

Where did you get the code used in this patch?  It doesn't
match what is currently present in Linux v7.2.

This issue was reported and already fixed:
   96ca1e658ae45 net: ipa: fix SMEM state handle leaks in SMP2P init

					-Alex

> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ipa/ipa_smp2p.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..78f6df2cad76 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -239,12 +239,16 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   					    &enabled_bit);
>   	if (IS_ERR(enabled_state))
>   		return PTR_ERR(enabled_state);
> -	if (enabled_bit >= 32)		/* BITS_PER_U32 */
> +	if (enabled_bit >= 32) {	/* BITS_PER_U32 */
> +		qcom_smem_state_put(enabled_state);
>   		return -EINVAL;
> +	}
>   
>   	smp2p = kzalloc_obj(*smp2p);
> -	if (!smp2p)
> +	if (!smp2p) {
> +		qcom_smem_state_put(enabled_state);
>   		return -ENOMEM;
> +	}
>   
>   	smp2p->ipa = ipa;
>   
> @@ -288,6 +292,7 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   err_null_smp2p:
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
> +	qcom_smem_state_put(enabled_state);
>   	kfree(smp2p);
>   
>   	return ret;

