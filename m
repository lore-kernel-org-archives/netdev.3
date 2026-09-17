Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFA4D7950
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647549; cv=none; b=V/4LjMe7czk3h4pM1AkhB0645F96Ky2uovQ6zZDK+fyMm9lxDdrLFEYZ9KtLkEPtT1w2eUS2Uy1tDyc8uXIZrLpXGR5M66D7F+YEslkXw6UQOH1N7h7omtgJRP9dYONBZFgQRVmba3T2UxPPqlIJDT2uQ65v9GwEdbyPwETmXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647549; c=relaxed/simple;
	bh=Fd+Le0jp+oglmv5qPwpHrV4qPNDHaQBuUZ5IkKjAVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D3Uyj9j/qyPlFxoxdyJHoG0P2V03j11fpPLCKmmSjEx+ogYoHpO+Sq72iPoQIPr71LtbhOGVYw6eDegCxAdE5qt5Rv/cSyiENfjgOa58vhLffSLfBjliDjfd8wyzfILtw7IV5v5ST4wLLuXtJEB5mqqeTuoUYRk0BnCryFAYVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=DbJ/+8Kw; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DbJ/+8Kw"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3c0d7aso38271b6e.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1789647535; x=1790252335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86Xj64dQYiJYYfLFgchfsxWmATQAkJCeNs/wUb7INOE=;
        b=DbJ/+8KwpbAkXLCcgggEQGtDd0t0zTDjBphVqAGAQusQPPbafoqMeHwFjMkE/x5oqQ
         vZ6iOp+PbTCBnOHz51lDyd4binNRlRSP+/ljz2zEWoo0SpwIjTPOMFmf3ImWZ0+2m1wr
         Xz0pLYjOxloNk/kUi85vkKDdfPgOL2/ZFMano=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647535; x=1790252335;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86Xj64dQYiJYYfLFgchfsxWmATQAkJCeNs/wUb7INOE=;
        b=Xr1dQHYJNLk0Uz8lMsrK5ZDemwfGxXdy4BMq4zJdoY0OzyyinlQI9z/vwdOnYrVrCr
         KRi0L38iM2E+B6V3vOW8eHSdCv5zOZ7IBZObDWJhC/7EYpMt/2uJ2eQSs2PGLqyiPlPu
         GRVCsoeQe6xLECmarQD4x6GTdd7qhz6j+VxKSRCiQANuLNy7E1huR7GeteqjAGxkeN7v
         wd4LehbwHniUDaylg6ZmbLZoLW8HdLzeQsHId5PmSo+sGXzRQM0P8O7xGG8pYTUMzzhP
         sYpHBy4NUXK95wZzZh/sOKrbsxlgaRPSDShxhglNSrbXezPXkaMjrN1nNB8nVZ7YSHWx
         7Vuw==
X-Forwarded-Encrypted: i=1; AKwUvBzmEMjU7grHrqvd/e/PzSA44dJi7jmokJPK1eztB/yI0VNZMxCLoOElkywYx6jglCx2Qd9X6Ws=@vger.kernel.org
X-Gm-Message-State: AFuF++nLXlOuWbXB12CFEuH5/PkJuAtxR/aPbG9iljGbegk4VO4evrkp
	Eox5QOfSiKrMo0afawRi5qO0z172sOn9azK2/89ykWaTHafrBhnpTe9s0qigJaepPQ==
X-Gm-Gg: AYBFou1NZBNF8NadKGZWWvu4TgNqHmGGy7zQP8XekJb9DHe2ESDoZkrnkgfVXgBpoJy
	BwFSefoHuZo/ovoWrZbYrcizMSByu4ATCLNQNEXXLP4BeYNlLlNs+uhYGG9Lkfsd52+CbQ4D75g
	SpGg7pei9b7LSy70F3HGW7ggR6gYcbPmN94ERVC3d2eCx7sen5SWAYscaTaRPQl2CHEQx3h5sGp
	7gxwcAFeLU6yuclvYMuCCeErdZZ5u5zyjIp6hmqmnHFPx8xmyGEuEdJ8/2QnYU+CeuLxDaRyJuf
	JJVWeY0kp1z+RvvGw4je0XKI0sW2uNh1FrvSB6Ay+4QLK6i5TXbxbL2S/yKvzKyG2A23bdg7I0x
	P4s13suOkMAeTvxNffDTIxqhrVsHafT7A2e/RBl4RexulKUg+1ihWuBwoKvnKn/fDmdrno6BL5w
	vWdi9jEhnsOmT1qVv2bome0EWbH2w+Qd8mgy/AaYDjvJHHOED9JfITLF+kDMAtHt1pcg==
X-Received: by 2002:a05:6808:1494:b0:4bb:efe7:51ee with SMTP id 5614622812f47-4cb6b34e870mr2521276b6e.19.1789647535251;
        Thu, 17 Sep 2026 05:18:55 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4cb6d267495sm2361769b6e.12.2026.09.17.05.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:18:52 -0700 (PDT)
Message-ID: <ced2ea64-6415-425b-aa8f-68df68253bc2@ieee.org>
Date: Thu, 17 Sep 2026 07:18:50 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Fix valid_state leak in ipa_smp2p_init()
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, elder@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stable@vger.kernel.org
References: <20260917115424.2149947-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260917115424.2149947-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 6:54 AM, Wentao Liang wrote:
> qcom_smem_state_get() takes a reference on the state, but
> ipa_smp2p_init() returns without releasing the "ipa-clock-enabled-valid"
> state when the bit number is out of range, when the "ipa-clock-enabled"
> state cannot be acquired or its bit number is out of range, when the
> smp2p structure cannot be allocated, and on the error paths that free
> the structure. Release the reference on all of these paths.

I haven't looked very closely at this one but it also seems
to have been fixed already.

   96ca1e658ae45 net: ipa: fix SMEM state handle leaks in SMP2P init

					-Alex

> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ipa/ipa_smp2p.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 78f6df2cad76..f45225b16722 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -232,21 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   					  &valid_bit);
>   	if (IS_ERR(valid_state))
>   		return PTR_ERR(valid_state);
> -	if (valid_bit >= 32)		/* BITS_PER_U32 */
> +	if (valid_bit >= 32) {		/* BITS_PER_U32 */
> +		qcom_smem_state_put(valid_state);
>   		return -EINVAL;
> +	}
>   
>   	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
>   					    &enabled_bit);
> -	if (IS_ERR(enabled_state))
> +	if (IS_ERR(enabled_state)) {
> +		qcom_smem_state_put(valid_state);
>   		return PTR_ERR(enabled_state);
> +	}
>   	if (enabled_bit >= 32) {	/* BITS_PER_U32 */
>   		qcom_smem_state_put(enabled_state);
> +		qcom_smem_state_put(valid_state);
>   		return -EINVAL;
>   	}
>   
>   	smp2p = kzalloc_obj(*smp2p);
>   	if (!smp2p) {
>   		qcom_smem_state_put(enabled_state);
> +		qcom_smem_state_put(valid_state);
>   		return -ENOMEM;
>   	}
>   
> @@ -293,6 +299,7 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
>   	qcom_smem_state_put(enabled_state);
> +	qcom_smem_state_put(valid_state);
>   	kfree(smp2p);
>   
>   	return ret;

