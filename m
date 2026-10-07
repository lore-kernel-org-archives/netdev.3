Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4649C4DE
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399099; cv=none; b=Fzb9lAiOKrl/lqKIwF4eNTJVE7vGUDCBroo9Uemwl+NMQiqTM0zYMpbzdhqmJ2+aVBfV4FWJUx1Chw7EFmuGGQkre+o45leUFXHHmj+XbwYQf+h745U/7tRIrh2HDqROigxe0ZT6FDAlOYwxVhi6kHHoWcI6j1dyvQplnfuLtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399099; c=relaxed/simple;
	bh=Rd7qMrZIL9VNqVwVYSWHvzG4ceRUBMjVn1LbhvOWWHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ+lv+w0FDMF1vxGeHV7AUa1LpOqdkPJ2m5FAEN1+qAoGN6fE8xoMKbozeDtCa0lkJ0mW4pcTqC7S6BAuV3ogBKQgGuHKYn9M1rstEzJ4tT0eMPPy5xbPepCa3lDnGB40tV/aLe+FgjfUL+/3e+xYrXNZLyiKHFNh5W44PUEYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XA9AOoJD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+PfVIzo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XA9AOoJD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+PfVIzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791399097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXsJrdMn+N59pnyS3VP8BExu6tp+oaLWpwNwDbsGihY=;
	b=XA9AOoJDa7sXmgJ1rBJI1edLTqYgVHKVvkHfDBDJyjSVbkjNUI+d0a22sYdxF0kvcD7pBr
	N74HAlYlQlWQXCZW0cA8WqEb91VlrLBNA+k55kI46esQlo/s6j73egusFvFLykY/2/FA6v
	H37Qz7LUnKcK82gR+yAmdTjVVevb2OY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-YtUM0OeMPEKfTLquMUm2gw-1; Wed, 07 Oct 2026 14:51:33 -0400
X-MC-Unique: YtUM0OeMPEKfTLquMUm2gw-1
X-Mimecast-MFC-AGG-ID: YtUM0OeMPEKfTLquMUm2gw_1791399092
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so66721825e9.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791399092; x=1792003892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXsJrdMn+N59pnyS3VP8BExu6tp+oaLWpwNwDbsGihY=;
        b=N+PfVIzoQTCw//hxs84wOFbnqyOiuHq/hl7D1dPJXAYb1ur/RtLcQ6YblDKpDd3np6
         dgSxrf+CoFkxoD+1H8q7DyEPVfsBbF5cjr2XU8RJ0htie0X1YC13wGpdG+L/Y1nwabaf
         MvNuwTTsUohC6Gl9fxk1Ht9f+can/97ynhHpqLG5yqYgacLSH3WmHgLyms7W2r+4/8ge
         Rv8vL+lky1PmReD4A64pmbQ0PrGSYpkEG5XH3JXO2oboJjAVr7ur1CJhuZrZQASZm286
         OiUghaaLtf3Iz9xrR4mjFTwDMWXIXO/H/8j7IpJFMvcccQLr1ZrL76CU4/1JxVGqQK0d
         PjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791399092; x=1792003892;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXsJrdMn+N59pnyS3VP8BExu6tp+oaLWpwNwDbsGihY=;
        b=y2/pFUkR6De/kcEyEmEA3zunCTzXhaK/pmKepnl0Bar5aoGoz6RU5HjLcXczPUDyVq
         5LFEDXTHdpH1utwRXMzPaAVt+a/8337l4XujH/YrW3gqVB/jTtSaov/h5/lQWcU3OgFG
         O1WFV+RW38gOuYMeAKEtp65qGb3f0Qvn9oeQJmgdxMl8YJKcZdRM5JvQHDslY9+XJdSm
         nZ7kLjT++WdJrl7FMnvacMYPP128sZJ+E62agT/4ku8wrhi9C/uqXMGX7CBCP6E3+oxT
         NUlovNCCz+QsvwhVxS/hjRABAn8hsMcxiXUYCNKOfpeA5bHhUua+CqpHY4YbSpg6+mNX
         eLCg==
X-Forwarded-Encrypted: i=1; AKwUvBxzz4cwqbEhecXvAoEdL4ytZecXefCSkF9iqBWvWQ9ENCu+BRSxw0EkUGamMYBMK47jiqGOUcA=@vger.kernel.org
X-Gm-Message-State: AFuF++mToNqSGNUGDa59Mufjh8SVa1iMD6jaD7EGIcmcCMBW2hWTHRkL
	JyBAlIn6Qk77kbzMTdzNNrnT3nbmU5zPilZyVgh6+nB4lxvdSOrPte0ZRzL/zaTBh6fGNfx8Da9
	Np+ABwvjhUTlBIzBZweqer4V+2SZg0ArfHF5MqWlAToTZeZ+KCKNXMyB87g==
X-Gm-Gg: AYBFou0HDllNXhCMLsFq5FDwM4s3gWU1LcTMULni7+7lQJlIEKvBAKU5wZdznHGAVtC
	PRSDcCA4fqRBgAPI6F8N2nkkg4ark8NwBgeO07TwKnQvZCtIxLll1IE+670zsvhxI4IuMLBACof
	RXwy1P+LvrRYj1G2BhWf3qSTNrB6QSCIYLwNRTHfFXmWvs1aFckvrl6uFrTs2NxgLcmoEAcZud0
	TTM4gjUhT6+9mOIuN0UFootj44qhBnVLw27/601zNfaP2fuIG5QoYQ8cxR6Aq9ZarHUPFsFqWAB
	YimmWwI3MUIt2+ehxmhNreBD6xTtquLMe6Oixaex+hRz/J/noHJRSOl1kjCQGyCNx2XjaOqbdw=
	=
X-Received: by 2002:a05:600c:821a:b0:4a0:1e68:d28d with SMTP id 5b1f17b1804b1-4a180303f9cmr53468885e9.6.1791399092531;
        Wed, 07 Oct 2026 11:51:32 -0700 (PDT)
X-Received: by 2002:a05:600c:821a:b0:4a0:1e68:d28d with SMTP id 5b1f17b1804b1-4a180303f9cmr53468495e9.6.1791399092075;
        Wed, 07 Oct 2026 11:51:32 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843dfb3bsm11458295e9.13.2026.10.07.11.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 11:51:31 -0700 (PDT)
Message-ID: <d4ece13f-6f4b-4eda-8175-b857fe48a5f2@redhat.com>
Date: Wed, 7 Oct 2026 20:51:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] dpll: zl3073x: reject output frequencies with
 too small divisor
Content-Language: en-US
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20261006153116.347497-1-ivecera@redhat.com>
 <20261006153116.347497-2-ivecera@redhat.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261006153116.347497-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/26 5:31 PM, Ivan Vecera wrote:
> The output divider has to be at least 2. In N-pin divide mode the
> per-output divider must be 2 or more and the N-pin is divided once more
> (also by 2 or more), so the N-pin needs an effective divisor of at least
> 4.
> 
> zl3073x_pin_check_freq() only checked that an output frequency divides the
> synth frequency, so it accepted frequencies that would require a smaller
> divisor. Reject them: require a divisor of at least 2 for normal outputs
> and the P-pin of N-divided outputs, and 4 for the N-pin. Also reject a
> zero frequency, which would otherwise divide by zero.
> 
> Fixes: a99a9f0ebdaa ("dpll: zl3073x: Read DPLL types and pin properties from system firmware")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/prop.c | 29 ++++++++++++++++++++++-------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
> index ac9d41d0f978..a4bdc3878590 100644
> --- a/drivers/dpll/zl3073x/prop.c
> +++ b/drivers/dpll/zl3073x/prop.c
> @@ -22,7 +22,8 @@
>    * The function checks the given frequency is valid for the device. For input
>    * pins it checks that the frequency can be factorized using supported base
>    * frequencies. For output pins it checks that the frequency divides connected
> - * synth frequency without remainder.
> + * synth frequency without remainder and that the resulting divisor is within
> + * the range supported by the hardware.
>    *
>    * Return: true if the frequency is valid, false if not.
>    */
> @@ -30,7 +31,7 @@ static bool
>   zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>   		       u8 id, u64 freq)
>   {
> -	if (freq > U32_MAX)
> +	if (!freq || freq > U32_MAX)
>   		goto err_inv_freq;
>   
>   	if (dir == DPLL_PIN_DIRECTION_INPUT) {
> @@ -41,18 +42,32 @@ zl3073x_pin_check_freq(struct zl3073x_dev *zldev, enum dpll_pin_direction dir,
>   		if (rc)
>   			goto err_inv_freq;
>   	} else {
> -		u32 synth_freq;
> -		u8 out, synth;
> +		const struct zl3073x_out *out;
> +		u32 synth_freq, div, min_div, rem;
> +		u8 out_id, synth;
>   
>   		/* Get output pin synthesizer */
> -		out = zl3073x_output_pin_out_get(id);
> -		synth = zl3073x_dev_out_synth_get(zldev, out);
> +		out_id = zl3073x_output_pin_out_get(id);
> +		synth = zl3073x_dev_out_synth_get(zldev, out_id);
>   
>   		/* Get synth frequency */
>   		synth_freq = zl3073x_dev_synth_freq_get(zldev, synth);
>   
>   		/* Check the frequency divides synth frequency */
> -		if (synth_freq % (u32)freq)
> +		div = div_u64_rem(synth_freq, freq, &rem);
> +		if (rem)
> +			goto err_inv_freq;
> +
> +		/* The output divisor has to be at least 2. For the N-pin of an
> +		 * N-divided output the effective divisor also includes the N
> +		 * divider (>= 2), so the minimum is 4.
> +		 */
> +		out = zl3073x_out_state_get(zldev, out_id);
> +		if (zl3073x_out_is_ndiv(out) && zl3073x_is_n_pin(id))
> +			min_div = 4;
> +		else
> +			min_div = 2;
> +		if (div < min_div)
>   			goto err_inv_freq;
>   	}
>   

Reviewed-by: Petr Oros <poros@redhat.com>

