Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06D4E1C7F
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399339; cv=none; b=K7fq7vD/4L1rnt7pnacxrmke/7TUGXa8jvwKBzIp0VJz8ZXcU//Ksc2KKFwfuR32Yomp4FMuzmU0Ac0OrP8D/fBDPByPV9JHrsv3mKlK/IVt4FP4egvTR2B8+R6dTOVrTcB4N0jhA0w6aXM5klnfgudS0ob9vd4BILHwbQNCffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399339; c=relaxed/simple;
	bh=uu3JqeXMG5UefUJQhmZbsoi7zLbrkvzE3trJopZIyAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoGzXCzElOnCg6k6Kzj/M2v34QZHvLACsx7GV9OZHL3wp0Rv991TSFtdDzqvG5TDZwG0UkAzAUPD+p4EWytLvgfZgwB4mCHeYBPY8D5GCuGgOXsTpnF02yAf7fXUraVaGb8IA3vvbU5X1NWp3PWsEAeVtsXrcZ9+x5dMsWA5S7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELfD4F8x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sILQRoFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELfD4F8x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sILQRoFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791399332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8Xbta3BKJJZV2ZdH9m9Ms9T8qVfphnBRdOND2h8Bsc=;
	b=ELfD4F8x2MujP0yuB9rQp1Ilch8Zp935YLimOFPwd3IjDuKRiHkk5i+Z8X8a9juicycVPg
	z9+5b16LBUVkf/rY4nheYi41glKdiCsrJ+6Bvyoj9Hk4QWRda5jQ+VZFpAe47nr1ciKGx0
	NNGELVg2c6Ef4clWoo7PrJrWhBWrulA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-96tNIw0HNi-obj0qXelMpA-1; Wed, 07 Oct 2026 14:55:31 -0400
X-MC-Unique: 96tNIw0HNi-obj0qXelMpA-1
X-Mimecast-MFC-AGG-ID: 96tNIw0HNi-obj0qXelMpA_1791399330
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c415561aaso2831935f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791399330; x=1792004130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g8Xbta3BKJJZV2ZdH9m9Ms9T8qVfphnBRdOND2h8Bsc=;
        b=sILQRoFd+YQBu7Ng35xxNTiy5dWcUIChZ6ByQwB8vrJ3DPH6iVjI8NcTKnu2vJw+eJ
         y9UbOHB2VySOAKFDGCqM+yUdjfzAKJYSdtRaPruF1rlTM64m1AqQEssg4eyP7qaqltHs
         hgmvzoQuyCri17CBk920cXRxU/JXPVkYr153GO+3x/vve0zsCuuNzoAyL4VOHC7xClNN
         iVgW5eUq1rhCi9od+h+YmaDdifeKEROcNHHwlZGP/RBg9OwdLJOmQKQaZlk53T41ogvj
         HEeXp4o5CmncQmHKOdgcSJ8uU3VagukJBfgKLn2psoh8uNkgKbKsU2ryhhGuM2NmNKC4
         Tcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791399330; x=1792004130;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g8Xbta3BKJJZV2ZdH9m9Ms9T8qVfphnBRdOND2h8Bsc=;
        b=MJK04PqRXhwuWsOubhKW13VIRFZf2ErmVVUZ67czgdt2P4hucD9g1j69p/RHNjJ7yB
         2PKwGkTOOanmQrw5U0mHSQhG7xH/mZso1zF1ovtYagfUXb24TsqaiLAdoiVIXvVOCjr1
         5lJpRPxqmy8d45dnnS/IHzRvSO8XEulaIUssAQOgBNH52wMecbNvBADwe/J1spso4C7H
         nXfyOMOYtCaiBwj+fmsi02DeVhoAgijt8dDThLXNTQxhxjEweuTn7LZ7p8cIHziFrI5n
         9Hrv0RUjeG6ldOYxcjVTmhd9Nv8kE+0d34gylG8DtPwT9vDhuhH924sPWCAaf07Zi7BT
         YIjA==
X-Forwarded-Encrypted: i=1; AKwUvBzIxMlHMuD5Q4S1FcSzdCY6XQ/ErDp9mL8A3C6LEFGIs4VEwWERT+v2X4ISbZuKFrzGwURjR5g=@vger.kernel.org
X-Gm-Message-State: AFuF++kq0TAEnpiV585pn/neyuuIh2xig3KY+9k8pH+OCBfptdTuWn2O
	5IpyltfFGfExTzGXvCX1QHMivHr5IWSNZvoFpjRAq9TxuMPKYXPIFBMUXFgJKctWkEQglYmTvuR
	xCgPpP1FAwasPK8H4ZrI1V9GqOZDYtVVdjmQ4fbD92jhQEvTtHW3UEgDV0Q==
X-Gm-Gg: AYBFou2/cCgoF6MuioiwR135nYbjUnv86w66zNeDbIVTPsJf6+q4IT331SuZfX2i55n
	hYlwkdA2W951mCIDCDm1Upcuqu5CCH2qLddOqyn8xb2QR28psZ/fSHw8LhIzTCnE/+dez7/Tpf2
	9OccuavAA5Rzxc6EVvlzesYwDOtvj9hvEkOsICfhhKpHtpKlttkbP6u+T7zsOadbTlvVbffiLKj
	MCZ/wT7JwCKBlsUv+NEEOfwBek5oRjlSjMeG6tsOIZGuWwC4SIsxoJPmXXC7GRA6YEHX1HcbA3j
	eVpXpn5GeII7voOMbMPmRCamB3FHifdAhgpJg0Vi+1JCK6MNG1mAIi+5FRRNis/e0jOwefhFwA=
	=
X-Received: by 2002:a05:600c:64c9:b0:4a0:25d5:e853 with SMTP id 5b1f17b1804b1-4a180648c64mr52096575e9.35.1791399329776;
        Wed, 07 Oct 2026 11:55:29 -0700 (PDT)
X-Received: by 2002:a05:600c:64c9:b0:4a0:25d5:e853 with SMTP id 5b1f17b1804b1-4a180648c64mr52096235e9.35.1791399329359;
        Wed, 07 Oct 2026 11:55:29 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17fc664d5sm38007745e9.0.2026.10.07.11.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 11:55:26 -0700 (PDT)
Message-ID: <3a161f4f-2cd2-4f04-9b1e-4f94e5183786@redhat.com>
Date: Wed, 7 Oct 2026 20:55:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/4] dpll: zl3073x: reject inexact frequencies for
 N-divided outputs
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20261006153116.347497-1-ivecera@redhat.com>
 <20261006153116.347497-4-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261006153116.347497-4-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/26 5:31 PM, Ivan Vecera wrote:
> For N-divided outputs the P-pin and N-pin share the output divisor and
> the N-pin frequency is synth_freq / (div * esync_n_period). The frequency
> set helper computed esync_n_period with a truncating division and only
> rejected a zero result, so a frequency that does not divide evenly was
> silently rounded. Setting the P-pin could then shift the N-pin frequency
> too (e.g. 600 MHz synth, div=60, period=10 gives P=10 MHz, N=1 MHz;
> setting P to 2.5 MHz moves N to 1.25 MHz).
> 
> Check the division remainder and reject the request if it is not exact,
> and require esync_n_period >= 2 so the N-pin frequency stays below the
> P-pin one.
> 
> Fixes: ce26d7ca50a5 ("dpll: zl3073x: Add support to get/set frequency on pins")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/dpll.c | 37 +++++++++++++++++++++++++++++++------
>   1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
> index 7c997966c3c3..65107b4cc4f8 100644
> --- a/drivers/dpll/zl3073x/dpll.c
> +++ b/drivers/dpll/zl3073x/dpll.c
> @@ -1007,15 +1007,28 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   
>   	if (zl3073x_dpll_is_p_pin(pin)) {
>   		/* We are going to change output frequency for P-pin but
> -		 * if the requested frequency is less than current N-pin
> -		 * frequency then indicate a failure as we are not able
> +		 * if the requested frequency is less or equal than current
> +		 * N-pin frequency then indicate a failure as we are not able
>   		 * to compute N-pin divisor to keep its frequency unchanged.
>   		 *
>   		 * Update divisor for N-pin to keep N-pin frequency.
>   		 */
> -		out.esync_n_period = (out.esync_n_period * out.div) / new_div;
> -		if (!out.esync_n_period)
> +		u64 prod = mul_u32_u32(out.esync_n_period, out.div);
> +		u32 rem;
> +
> +		out.esync_n_period = div_u64_rem(prod, new_div, &rem);
> +		if (rem != 0) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "OUT%uN freq must divide OUT%uP freq",
> +					   out_id, out_id);
>   			return -EINVAL;
> +		}
> +		if (out.esync_n_period < 2) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "OUT%uN freq must be less than OUT%uP freq",
> +					   out_id, out_id);
> +			return -EINVAL;
> +		}
>   
>   		/* Update the output divisor */
>   		out.div = new_div;
> @@ -1030,9 +1043,21 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
>   		 *
>   		 * Update divisor for N-pin
>   		 */
> -		out.esync_n_period = div64_u64(synth_freq, frequency * out.div);
> -		if (!out.esync_n_period)
> +		u64 rem, prod = frequency * out.div;
> +
> +		out.esync_n_period = div64_u64_rem(synth_freq, prod, &rem);
> +		if (rem != 0) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "OUT%uN freq must divide OUT%uP freq",
> +					   out_id, out_id);
>   			return -EINVAL;
> +		}
> +		if (out.esync_n_period < 2) {
> +			NL_SET_ERR_MSG_FMT(extack,
> +					   "OUT%uN freq must be less than OUT%uP freq",
> +					   out_id, out_id);
> +			return -EINVAL;
> +		}
>   	}
>   
>   	/* For 50/50 duty cycle the divisor is equal to width */

Reviewed-by: Petr Oros <poros@redhat.com>

