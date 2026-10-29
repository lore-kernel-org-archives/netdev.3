Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296978;
	b=EW5k1sblKz3LFDpl42dqt3Q3NfnoPx/2BV8uXJCgHBc9z7Pd7iY/QoyGSVoPTDFIY9GQ
	 cd8kdvLk5U5S31d5HWubbRK/JxPkqCC+AgjEvvGtcS/rGcW2XX7SwQDIpmdlromFVhhwp
	 YwC2sndJy6S6ckceuf17VYLwjjOVneUtrXAzPbVa/dxUymbtFdAvE6M03zNOTAfddSrAd
	 ISOSVm0VIscA5MLE/lb0tyRebKg6o5H0f28JIMfMFQKPB1ei6WaQrDD6qUz/vksaAThWU
	 n+epp7mi/EQfjZDs8ZMR03Dg2rKbYe0MyD+gOi8aNtzu3g1N6nXzb/BZhHOBOrfFBiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=p/lwM6aKVbeVX9E+nb8lJFGnESDw/RwCj1wwSe0sy0M=;
	b=TB4kILH2wOBxvYGnhVfdwlixw0FPwJxFku66Zx19re4W6OvD6PQ8tuNXkH9FYeAPvDSW
	 zx/L0+y5WSRZXVAoseLW1CnJ/0jDTq2nZejEcdmIoFisKio8GP0YR/V0nLl8tc/J6gUCF
	 Y4uVZ65lQO93p9btS0M/lKeIumdnghx52NLXpSzp2EkJzB401bUKQ0HOKOyP6+60vQulI
	 AWamKG4RY90ke9Fyxidg4OTAK570eFQO4NADPprZ8Nd1C2XrCNNAzkakDH8/FUELX6g6Q
	 AVtNgCWU8RTysII0iUSdB2PCyr+J4Hswz5/rtgADhPV/55nkDzFVreoNFLDkoFTKF2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=HwHeGpt6;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4E606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 18:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=HwHeGpt6
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-846566246e8so1054265a34.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793296975; x=1793901775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/lwM6aKVbeVX9E+nb8lJFGnESDw/RwCj1wwSe0sy0M=;
        b=HwHeGpt6EFOcB8ApjWct2c02zlx67RnQZXZUwBAbbeOfUH70tNE4CWqx4SM/5tAfFm
         EjsXVWM42yqmTUoibgcYUBlR0fnVv+LN+T4HNMqb8ufogOT0SWLU48i+V2FePct49nBG
         uYRv+k2/EeH/bHALaeNK7NisZZfFeQLRxQzwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296975; x=1793901775;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p/lwM6aKVbeVX9E+nb8lJFGnESDw/RwCj1wwSe0sy0M=;
        b=nBFKfsdsC9VM8/kzo1aZI9DKgdYnkWRE6EGMAuiVpIkf7Qwr5QfXUigWJHZaz8Bo3q
         fe0fFTuDBSJp6suFlu4PfMz37x6EE7nsu+fSso9EIoyyQcGnYy9cV6Cj4fcti3KNygju
         gtcq575DXSjPok2Rd1MbgIMGg+e8KaWqFbgTcJdfP8TF6idmIh6IvjYgm02B/cSrPuZf
         YixvkJtQWTHRQEZjL7KgKCDHDuiqT26yhXdbTo22n11+EgpSQV8Ynsh2ngzkFg9+S0Kl
         n9kXACxoSK7bLMt7Epiq4pQuDlvWfizhYRhl4yLOH1H/tnGI6WczNFpw5c0CQLWG/G+L
         ce8w==
X-Forwarded-Encrypted: i=1; AKwUvBwIXKMHz75R0XIk/AtkrUoi6OAu5omHrfszg/Yl4z6G0uLw4lGZYWdHU3j7YiwfD0XwFYU3cYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKl5o6dzKHg0BdIaBDmZ/UXGTZ8NvHGsF2DDOK401SEuozVyZKs
	T6VzkrmKA3A5zg7k17ylPm9lHk2snpcIhUDg3hznG+ZTrQReXb1h0memwjEjnyINqA==
X-Gm-Gg: AYBFou18N0SI4YmAPQ64aXg2nwswR+xQWoqh0cBAksucFxozH/gSJHnvFA6uCC+aUc4
	OVC/NZH6GMOgrYmJMC8x7vghBpMJIo24Ckf4CV5m3shj59Q6vtrFz/Xka38pzZvcCmDQpSKzPR8
	j7zYENKjD06f3avymVGNJHDIrFG7Wvc7qXG79K5IZd8qBz85eJZTD7SB/XwK7/Nhj5zPoccX7U2
	JxT4KlG8GsdHwRrCuAETcMH+SB9KVoQp6z1FGf1qQbeqSxflc7GniCrHwzTunaiTjbdwIxq34DH
	xiFNJcPF64gWh0j/ULg23iL8B2hEiywEA3heybBGPT03H5bAILrJVb8CFPnHcKHcDZDfkqkqfmx
	uUZsqnQ6C/vbMZKNZw62WztBN7DXppHj9+dtneIt6fGbu8Eyy7TV9xMJDx/LeSMOz0Glik1CCF4
	QrqZ/3zExmbr/xw8uumS0gXWn5UiLtoExXejCpzxLxdZ1PF6oGVpEn/LZERq+4oHv6Geqzi9BK5
	k9rBpOusBsla9TR5hONygaGRkrU7n8kJjV7jXnB/2gl9bo8mPaWTmqVF/sbuxVDWhw/HzxAEgcp
	0eaTi0HQoXMGvGAQ18aXF+4N
X-Received: by 2002:a05:6830:3495:b0:846:9414:ded with SMTP id 46e09a7af769-85c1e2b659fmr2055399a34.5.1793296975496;
        Thu, 29 Oct 2026 11:02:55 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-85d3549a2b4sm141226a34.13.2026.10.29.11.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 11:02:54 -0700 (PDT)
Message-ID: <97e9474a-f491-4447-b128-e4a5687056ab@ieee.org>
Date: Thu, 29 Oct 2026 13:02:53 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipa: Drop unused qmi_elem_info arrays
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 6:11 AM, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Did you send this before?  (Why the From:?)

> 'ipa_mem_array_ei' is not used anywhere, so can be dropped completely.
> 'ipa_mem_bounds_ei' and 'ipa_mem_range_ei' are not used outside of their
> units, so they can be narrowed to file-scope.

I wonder why ipa_mem_array_ei was still defined.  It must have
been used at some point...  Anyway, you're right, it's not
used, so good riddance.

Did you find these by inspection?

Reviewed-by: Alex Elder <elder@riscstar.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/net/ipa/ipa_qmi_msg.c | 25 ++-----------------------
>   drivers/net/ipa/ipa_qmi_msg.h |  3 ---
>   2 files changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_qmi_msg.c b/drivers/net/ipa/ipa_qmi_msg.c
> index 51dc13a577a5..e2401d8475b6 100644
> --- a/drivers/net/ipa/ipa_qmi_msg.c
> +++ b/drivers/net/ipa/ipa_qmi_msg.c
> @@ -188,7 +188,7 @@ const struct qmi_elem_info ipa_init_complete_ind_ei[] = {
>   };
>   
>   /* QMI message structure definition for struct ipa_mem_bounds */
> -const struct qmi_elem_info ipa_mem_bounds_ei[] = {
> +static const struct qmi_elem_info ipa_mem_bounds_ei[] = {
>   	{
>   		.data_type	= QMI_UNSIGNED_4_BYTE,
>   		.elem_len	= 1,
> @@ -208,29 +208,8 @@ const struct qmi_elem_info ipa_mem_bounds_ei[] = {
>   	},
>   };
>   
> -/* QMI message structure definition for struct ipa_mem_array */
> -const struct qmi_elem_info ipa_mem_array_ei[] = {
> -	{
> -		.data_type	= QMI_UNSIGNED_4_BYTE,
> -		.elem_len	= 1,
> -		.elem_size	=
> -			sizeof_field(struct ipa_mem_array, start),
> -		.offset		= offsetof(struct ipa_mem_array, start),
> -	},
> -	{
> -		.data_type	= QMI_UNSIGNED_4_BYTE,
> -		.elem_len	= 1,
> -		.elem_size	=
> -			sizeof_field(struct ipa_mem_array, count),
> -		.offset		= offsetof(struct ipa_mem_array, count),
> -	},
> -	{
> -		.data_type	= QMI_EOTI,
> -	},
> -};
> -
>   /* QMI message structure definition for struct ipa_mem_range */
> -const struct qmi_elem_info ipa_mem_range_ei[] = {
> +static const struct qmi_elem_info ipa_mem_range_ei[] = {
>   	{
>   		.data_type	= QMI_UNSIGNED_4_BYTE,
>   		.elem_len	= 1,
> diff --git a/drivers/net/ipa/ipa_qmi_msg.h b/drivers/net/ipa/ipa_qmi_msg.h
> index 644b8c27108b..1924ac2dfa90 100644
> --- a/drivers/net/ipa/ipa_qmi_msg.h
> +++ b/drivers/net/ipa/ipa_qmi_msg.h
> @@ -253,9 +253,6 @@ extern const struct qmi_elem_info ipa_indication_register_rsp_ei[];
>   extern const struct qmi_elem_info ipa_driver_init_complete_req_ei[];
>   extern const struct qmi_elem_info ipa_driver_init_complete_rsp_ei[];
>   extern const struct qmi_elem_info ipa_init_complete_ind_ei[];
> -extern const struct qmi_elem_info ipa_mem_bounds_ei[];
> -extern const struct qmi_elem_info ipa_mem_array_ei[];
> -extern const struct qmi_elem_info ipa_mem_range_ei[];
>   extern const struct qmi_elem_info ipa_init_modem_driver_req_ei[];
>   extern const struct qmi_elem_info ipa_init_modem_driver_rsp_ei[];
>   

