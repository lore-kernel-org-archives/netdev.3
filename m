Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B20448B96
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817664; cv=none; b=TO8UlKZcEPCfzwS5CxvqLxsskUHK5+7Jh6l7FnIOZDKx9ivgrczhbQgR8/0MxTN/Z1rTNlJUS1yOCYAztwRirvVZYupnjV6eKX1pD4olgH0Ph/LQ1mQF/wwerTmYe6z2dqSx4c99/0IbYK8oY2LacSjovyp3aYRVMMjB2JtU1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817664; c=relaxed/simple;
	bh=ZAG9hcuTvOzu6pEVhaGzNunN8/1+A/e2YlzGhpHzdo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lv2st8fnEGJZdmSXhkKaNzL6XudFgnjsEiQ+zra2l0ZDxf9EdLHNyLQAHg1BB9tYwpxD1HhbajL94w7lH6C70qohZPuwM9yYaiYfB0u/9k7kHv90DCY/4sjdrG8jk68MSqTuR+wDGz52V+iiFDRMkSd8v5ne3FFUETiaQ0SW70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvqvfRiZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvqvfRiZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a2fdbb7be0so315407b6e.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784817648; x=1785422448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFFIDea2xmVSpdWE/MYrb1K4WJLcvIaxafqCWyU/OtQ=;
        b=jvqvfRiZecEIVmnik/2kWYnhs+i7tjPqTIBNUj6k3rTUwIAF9A1xehYzWSqTzhmeeM
         OQS7gOIPNRC2Op+MQloIGgGKVzUZoupce2bRtCi7+DIZIBqz1p+pcGZ677ez8UrhMwAd
         8dINTiiY8z1cdcK0AYmxoiTtSrCXxi4G4t8PO29Wo4n7HmKGDo2OB8JPgldYeNN052ME
         y2Xl4ib3vrjmm1BnyWB17NJHZNgcFk2NhQfxtArfuQ3OiqNayQa8su+Ynw1TMSF0Kfjl
         D9oYt+E38g4jO/I9cRdk4SDnY3FgRZ7HDKyDYUmps5tEYcBQsuQ7Lka9yZ+9cmKGduKG
         bP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817648; x=1785422448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFFIDea2xmVSpdWE/MYrb1K4WJLcvIaxafqCWyU/OtQ=;
        b=b4Yl+EPQ2OhrliLeNR1T3sxXE5wq9LPd+Fq77FPEeGtth0qRrKJRDETC6mHLpAo/D6
         stWIdR6praqRmP1DZjBQ1oMbFHsDlWl3lRux6URTDGnWWA9U8OqPIzwLdqFzAfLIc9NE
         QpzJOxn8ZwTL1Cq0gv1Z821qcLyUktfGNW/fuCfAN0X9yrD8GLoXxECp6bTnjtFJNmrH
         eJ3gddYuv5AUo+9hGLKBwUl75J+E5Eqv+jaEEXagqz4VXadxIFkOh2bsVJ6unPpEEhtw
         +YyTKOAYegABh4OYWX3m8SY99ZFjqo1AHDvtGNaI8JsVIGx/Y1Q/GDeeOwVXLd8hvy87
         Avtg==
X-Forwarded-Encrypted: i=1; AHgh+RpNN+tVWPi9FMbmmJ2h9IRJwGwya/ApZWBrV3N0nITCzgkN4OX6ZZagvHqR2Z6niG5dZSW1R+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53SgqKoX6ch8iG3Oh72FRsAJU6p5ypLLu8zJ5tS2Xp1FZHDGA
	mYOGEyhrJj9oaBCZ2mz3gXDm3/V9cMG7jqSW+dCBl2OAJsxZ/wVSytmc
X-Gm-Gg: AR+sD10YPL0kippL4u+nUfgYGMpfQtg0KQoh57YTPMdvaxbNqxr9Cp7ixRddWuAH7Rw
	Va3gsohGQu/jVQ7e6FgmXWnxFvmb1SG2xJnAaM5Pkl8QfXx5xI1MdH9N/5iJthMmKcEVWecU3rg
	opcqS4DKyMT5J2tR9jTXTqQAZNVt8kZQEIdKEDL4J87IvsBPmY3u7QPpCrJtScC2gGiY2023Af1
	gzsXlEuoGgdAe9aJg01/Dhmv9Dtf0oVbUcylOnAotuAv4EQ+HthJOfH6fiIeFcnHo9rTxwwLtVp
	fwsDNVRXHWEzjwB3t/lAG3meUoXm60clKtbGM9O0yDzeyx0651dQM2rbbNSx70bYxIwqRBAYrc3
	/ztyzYHt3L0W/alg8dR1/cYp8TleR5taML77iNxNnip3hOwJ/gV8wAae67r7tvsbLs8Zarw10GX
	to7t50jJAQom1ckZvq3B1Uk8O9s1l6Twaa1QqePMo=
X-Received: by 2002:a05:6808:179c:b0:497:d371:21c8 with SMTP id 5614622812f47-4ab353844d4mr1717912b6e.19.1784817648450;
        Thu, 23 Jul 2026 07:40:48 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::10db? ([2620:10d:c090:400::5:1ca2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0eeb073dsm3149343b6e.16.2026.07.23.07.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 07:40:47 -0700 (PDT)
Message-ID: <06dbed72-1f5c-4c91-bab2-4acf6e562713@gmail.com>
Date: Thu, 23 Jul 2026 07:40:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/7] selftests: drv-net: refactor so_txtime
 errqueue handling
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 Willem de Bruijn <willemb@google.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
 <20260722204454.3234605-5-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260722204454.3234605-5-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/26 1:43 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Prepare error queue handling for upcoming SO_EE_ORIGIN_TIMESTAMPING
> messages in the next patch in this series.
> 
> Convert do_recv_errqueue_timeout into dispatcher do_recv_errqueue
> and move SO_EE_ORIGIN_TXTIME specific code into a separate helper.
> 
> This will make the next patch a lot more readable.
> 
> No functional changes.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>   .../testing/selftests/drivers/net/so_txtime.c | 66 ++++++++++---------
>   1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
> index 55a386f3d1b9..7364ce2bec0b 100644
> --- a/tools/testing/selftests/drivers/net/so_txtime.c
> +++ b/tools/testing/selftests/drivers/net/so_txtime.c
> @@ -158,7 +158,40 @@ static void do_recv_verify_empty(int fdr)
>   		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
>   }
>   
> -static int do_recv_errqueue_timeout(int fdt)
> +static int do_recv_errqueue_timeout(struct sock_extended_err *err,
> +				    const char payload_char)
> +{
> +	const char *reason = NULL;
> +	int64_t tstamp = 0;
> +
> +	switch (err->ee_errno) {
> +	case ECANCELED:
> +		if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
> +			error(1, 0, "errqueue: unknown ECANCELED %u\n",
> +			      err->ee_code);
> +		reason = "missed txtime";
> +	break;
> +	case EINVAL:
> +		if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
> +			error(1, 0, "errqueue: unknown EINVAL %u\n",
> +			      err->ee_code);
> +		reason = "invalid txtime";
> +	break;
> +	default:
> +		error(1, 0, "errqueue: errno %u code %u\n",
> +		      err->ee_errno, err->ee_code);
> +	}
> +
> +	tstamp = ((int64_t)err->ee_data) << 32 | err->ee_info;
> +	tstamp -= (int64_t)glob_tstart;
> +	tstamp /= 1000 * 1000;
> +	fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
> +		payload_char, tstamp, reason);
> +
> +	return 1;
> +}
> +
> +static int do_recv_errqueue(int fdt)
>   {
>   	char control[CMSG_SPACE(sizeof(struct sock_extended_err)) +
>   		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
> @@ -169,7 +202,6 @@ static int do_recv_errqueue_timeout(int fdt)
>   	struct msghdr msg = {0};
>   	struct iovec iov = {0};
>   	struct cmsghdr *cm;
> -	int64_t tstamp = 0;
>   
>   	iov.iov_base = data;
>   	iov.iov_len = sizeof(data);
> @@ -181,8 +213,6 @@ static int do_recv_errqueue_timeout(int fdt)
>   	msg.msg_controllen = sizeof(control);
>   
>   	while (1) {
> -		const char *reason = NULL;
> -
>   		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
>   		if (ret == -1 && errno == EAGAIN)
>   			break;
> @@ -201,33 +231,9 @@ static int do_recv_errqueue_timeout(int fdt)
>   		if (err->ee_origin != SO_EE_ORIGIN_TXTIME)
>   			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
>   
> -		switch (err->ee_errno) {
> -		case ECANCELED:
> -			if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
> -				error(1, 0, "errqueue: unknown ECANCELED %u\n",
> -				      err->ee_code);
> -			reason = "missed txtime";
> -		break;
> -		case EINVAL:
> -			if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
> -				error(1, 0, "errqueue: unknown EINVAL %u\n",
> -				      err->ee_code);
> -			reason = "invalid txtime";
> -		break;
> -		default:
> -			error(1, 0, "errqueue: errno %u code %u\n",
> -			      err->ee_errno, err->ee_code);
> -		}
> -
> -		tstamp = ((int64_t) err->ee_data) << 32 | err->ee_info;
> -		tstamp -= (int64_t) glob_tstart;
> -		tstamp /= 1000 * 1000;
> -		fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
> -			data[ret - 1], tstamp, reason);
> -
> +		num_tstamp += do_recv_errqueue_timeout(err, data[ret - 1]);
>   		msg.msg_flags = 0;
>   		msg.msg_controllen = sizeof(control);
> -		num_tstamp++;
>   	}
>   
>   	return num_tstamp;
> @@ -245,7 +251,7 @@ static void recv_errqueue_msgs(int fdt)
>   			error(1, errno, "poll");
>   
>   		if (ret && (pfd.revents & POLLERR))
> -			num_tstamp += do_recv_errqueue_timeout(fdt);
> +			num_tstamp += do_recv_errqueue(fdt);
>   
>   		if (num_tstamp == cfg_num_pkt)
>   			break;

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
