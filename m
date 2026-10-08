Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC544E06E3
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474129; cv=none; b=gpSUy2ZHi1GDrYNkWRZ3TBnNRqlXvxPByE6kjj95zp7FABZS/3BLSDUPMi9V1GQN/auxwoLvgbdtpYL3u99Vh5uG06Wm6MbUFp/8W/Cf5gXJJXLDajJeby6lozkIZ33G5Yi/XV/MrGvEcaK2hzXayYRXiPn2y3oEOy3QKmnjvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474129; c=relaxed/simple;
	bh=p45yao1RQtKXl68qwuddwSHT2qqwACdieU8/+vJP4+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7aZN6hybovyykBeJzEb3VRUf8i4ELx2v3xRttwQiy7uV6fkZhA2O539D3fBc8FOt551h5ij+5rcoW/32Fr3usJREXemTNvgaBzjVubeDRYQ0jVwZT7q68GMP2M690jkDHeMvYsmyz9lUmrru72G/7RWuZVGBwI6Njyh2fOdCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSeVAN98; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSeVAN98"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so62414335e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791474126; x=1792078926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhN0Im/ZOMl3TVldoeLhsQ7Yvsx3fhHCKqS8ZGHq8nc=;
        b=sSeVAN98q4k5cXt1DQUOgpImiWFGoLYTtac1but9LP+mF8+fdJ+1w9I2VgNu+PR/5r
         cjc5F/bq/meaFRpyuB0VQxiAYRIMVOyxkGZSvMFdeh6dWg4XHCLeoJ7S/a7Q1zptTE4O
         vwE5jc1qz6ZcEucGhmUnVQ3H9UnIemKtQGXuCFkXsGhuoTtjqMsTyAfqYtuVyTJj8z3O
         QZ+4ppyzJMKaYHncrES/IWND4b9QZJs6XmIGjI4grziLPhHmNq+A9GosuJYA5EQ9TQiY
         2enxHHnnmS6FV+EzY36o5rvmD7CRwMLnkrKslRuNfOs1dx079y3GX3S4MiYN6d5knBa4
         33bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474126; x=1792078926;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhN0Im/ZOMl3TVldoeLhsQ7Yvsx3fhHCKqS8ZGHq8nc=;
        b=NLYI1PqtlVfMZ5qxvgA7w4rSYbOUcPX2qBvjG1wAhLSsBhYwqd2QVCnL2EsTeR1ZeW
         Dd637uz6JRdb3I8/molwjM25TIJZJiC4dZ9cPd0jVuyhxjjKeaPPiQ1R/lxaT4iRfSg+
         KvZZRax2rIPaFuEK+4Ub64F0NMHts7qsZYYtksDAdVFMxGIolWBMiQvz6j/ICvp6lXIA
         MemMeh7AVSGHDYC2r6Tj8va78dJ536VdboiLjUzs+DSGlTwzn6/wuSGkeQhEFhfpjlMT
         UDcswWkTH/Z5mZWkldOiLlJth2Uon+vFfJoU7+z9jt0vLw3430PyU8z5CdIKm4PhZI2i
         pRkQ==
X-Gm-Message-State: AFuF++kEyleIH3xoT8qjFPI1AX6omtqNiFFxe7aa2IPf6zUnALekNm/t
	ntdBD5bDZpRJBy3BYDJ8876TmxKNHkIfjMVETgmbLACCX0RHP7Urpvtv
X-Gm-Gg: AYBFou10iVlGN6pQKmTpMfVDq8fWEtmXDrXjTm0xQ6b9Oy2DPoZJcRNaWE0/s+VYMRs
	PuzWn59VU5mfvls/0kPjXrFhruNT0+yLl3pYsTIs/mYx5X4tOk2ER2PeIYLihzxoMaC8jcpUCsR
	i5j9itkNPaLhYa9/09olkqzTIqRB1dLiOEYJ+3D1AOv1a04wTi7Hz5KkMRHJOk/1j+mslf2XhmV
	Le0TNAZ/gGlK9JKi/41TyQGtcIAYbqbJIXmaI/0i130Kk2MkjVmgpnYcya8HFx20ETUniAmkuYl
	7IWDl3FrgsLhHWWGa+2NT8f2BshnSQbZfr7RK/SciGh9CO7t9c9Vu1/q4afRZcQpSKjRuz02AGW
	mKKvQmphFjHv73DqJ5KWfrz5rummhbGbM3/jo0U1gy4cdjicFYkUYNLRQ6z9IZynndmQwpvoL4v
	/hhE1esfLyySmV0z5AhOXoSa9r2SAqonoZE+vInRszAwwLpzXKojzwcoBMn5Cp4tVvMqM5o0sgB
	tB+nLoJ
X-Received: by 2002:a05:600c:3e0b:b0:4a0:c02:938c with SMTP id 5b1f17b1804b1-4a1804459e5mr112838975e9.25.1791474125821;
        Thu, 08 Oct 2026 08:42:05 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db6521a1bsm184697f8f.23.2026.10.08.08.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:42:05 -0700 (PDT)
Message-ID: <79a32d7f-ded3-4ef6-be78-3424ac1d5542@gmail.com>
Date: Thu, 8 Oct 2026 18:42:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
 <179141094859.2527009.4935200551311639225@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <179141094859.2527009.4935200551311639225@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/8/26 01:09, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Sashiko AI suggestion.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

Theoretical.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

