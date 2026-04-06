Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4C296BD2
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484758; cv=none; b=rsGzhCGUgRrpaUWuz5FP7M5jyP0RQXU12r9gbUfeJOVcRMIhxaKQdIW1rVuut3rjrva2hXVhrNno9bLlSjxp2Sezdmws9Vm1VFHgU7P9xmnyR0fb0kdG+HdJtv8az7bQ8/mBIy3pOQJpEO3eirR2GGgC+w1ovbm6AlQ+f9EBbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484758; c=relaxed/simple;
	bh=UK2SVH8TXBaIYXis85mAu9ZcKBy/IYwma3iGJlQ34PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faXo4EztWx64oW4KUEW7zvGy5zT1Evqzogl7W2acq3AyuYnVi8G43cZhPnmwAdteFLycDWO4LSM8HYsGVAjhDqJdTAD4+TAbglNWeC4r8eD3HlbF0vxybewsVIS022RLTyLN6wwgSzErgDlPh8+/s8sJIJgcafs7GmW/R/aTgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6c9cOgp; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6c9cOgp"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d00cf835b7so503861485a.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775484756; x=1776089556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMOsnvmEr0i8ZUnWpq78US8xsmNYVDcykG72w05H6j4=;
        b=T6c9cOgpbV2eN3u35Ux55zm3CqMlunNhL+u+SoqaXMzEEnCtGorLY8CGg2LoqoGy5y
         DuHEEMB4NX2Xk0VxJT6dIDPKobAHCkinqrP7A+PJ+L7FdTuAQr+stTvUPS2lyQVdYaQj
         c2SK4G9Tp4pylAfOv3UfLRwp8pfcJvCP2ytzKzd+JIkqfzGKzn1H6J/P56zdsoF0akEN
         qv6hEaAptLe99U+QemWj8ayphtfgfrwm8eB1vgGpqWlY2XnojDlCm/RnT3dLZl/TcE1n
         VAo75AQvPKNQ2vR6YY9J42m+5YiIYor/Dv2d4stmjKSernMjLsAjnoQgFqr3N35WV3/7
         KHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775484756; x=1776089556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMOsnvmEr0i8ZUnWpq78US8xsmNYVDcykG72w05H6j4=;
        b=eeR7PllIRIM8czGuOtA1gbsS8DFvqRjQLjDVQe/M5d4vZagLWkNfLFwNWhV67QJDmt
         JLxysAEAl2NNMYRtJHgx/3LZjxvgBOg9Vl0zINnFx2GD3z3S426rs4RY29FWNzcvu52Z
         Ld93iO6mulp+XXAEdhB2Gix4eN5My+woUo02BZERRg79aYJAodKrcsoYRSvqnpNCHreS
         yznagcSvJLFLROOcWWzz+08dlHHDZgGUzg8Tt6mWTGkD8VYrGzrKoT/wBlhdh0JA4cBs
         BSdO+BY0b0JVxsmS9JYRWYMVyh+Mwra3xFLLvgnaPnhQ1JNwGNcN+1/LDIEaP9NqR65o
         rmbw==
X-Forwarded-Encrypted: i=1; AJvYcCUs58NPkGk4IhivkpAEnKdl3xj/n8aJMBvC9544jhRyGglw//bRvLOC+sb3Mvcrvr8H1OOZBXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJYyfZbYA0YqBOdjfRtyz1Xwv5DptEQ6fEsHnPCDYcu2HBu/R
	ZhnjG7roUSkLo96EO092CubZ5QUQPPxzYAXLhyb4AsU3lGbrCVYtz1aH
X-Gm-Gg: AeBDiesMwajpTi3xKhRjSqfrEvN5RIaJbtpTmBs+Ob9W1M2xy7ZFMxW+YDpObSGCtyT
	IzWZTJgjXAnjrTteZgN7Kszh+H6QfQWe2eYckTINf1PoX28+tw8MlV2y3DH8CH4X0eRmQBUGBe0
	vHAWtYu5J3irEhaWT+Hppy5XnGnHPbspOoK2VWSwKCpAVkf2fNMypfLHeTrUImFQjKqg+fUxiOm
	U46G8KfZU1NvIju2IqgGBWMxRlUMNyhf3tkWBFSWZR3jd9M0rBv/NqQveRogijzCObYuBOYdB+F
	BAG25kmn4ACizHg7wOelj38HSnhb6s0ao4TPWRCpIg9NMSPpeWRAdcesdkJi3YApz2afGb+ic3N
	JprFavX/txCaNStxk+WFssnB9SG5kuW91SA3nqPHg+y/ASNrkcSInHQpEPLZ36LZlpmf61JqNnb
	gEGkszqG7lgV6k0hQaDjR6TQI/I96fH8m3tnuIgYV8U5FajNr8Vl6E6Ok7NDOC16ke2aB3YOX2/
	pSkXA+AMyT+fB+hYEjDUDnbHAzhb1J+Nwit+A==
X-Received: by 2002:a05:620a:28ce:b0:8c7:ad9:d0a2 with SMTP id af79cd13be357-8d41c3b5997mr1797056085a.22.1775484755986;
        Mon, 06 Apr 2026 07:12:35 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a1307586sm1059779585a.0.2026.04.06.07.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 07:12:34 -0700 (PDT)
Message-ID: <c502c837-6f01-4854-bd6b-e81aba940dc8@gmail.com>
Date: Mon, 6 Apr 2026 10:12:32 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 3/5] psp: add a new netdev event for dev
 unregister
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
 <20260405055853.3285534-4-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260405055853.3285534-4-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/5/26 1:58 AM, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
>
> Add a new netdev event for dev unregister and handle the removal of this
> dev from psp->assoc_dev_list, upon the first dev-assoc operation.
>
> Signed-off-by: Wei Wang <weibunny@fb.com>
> ---
...
> +static bool psp_notifier_registered;
> +
> +/**
> + * psp_attach_netdev_notifier() - register netdev notifier on first use
> + *
> + * Register the netdevice notifier when the first device association
> + * is created. In many installations no associations will be created and
> + * the notifier won't be needed.
> + *
> + * Must be called without psd->lock held, due to lock ordering:
> + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> + * and takes psd->lock).
> + */
> +int psp_attach_netdev_notifier(void)
> +{
> +	int err = 0;
> +
> +	if (READ_ONCE(psp_notifier_registered))
> +		return 0;
> +
> +	mutex_lock(&psp_devs_lock);
> +	if (!psp_notifier_registered) {
> +		err = register_netdevice_notifier(&psp_netdev_notifier);
> +		if (!err)
> +			WRITE_ONCE(psp_notifier_registered, true);
> +	}
> +	mutex_unlock(&psp_devs_lock);
> +
> +	return err;
> +}
> +


This looks like an abuse of the psp_devs_lock to provide mutual 
exclusion on psp_notifier_registered, which has the undesirable property 
of establishing a lock dependency from psp_devs_lock -> rtnl_lock. 
Perhaps a dedicated mutex would be cleaner.

>   
> +/**
> + * Non-admin version of psp_device_get_locked() + psp_attach_netdev_notifier()
> + * only used for dev-assoc.
> + */
> +int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
> +				    struct sk_buff *skb, struct genl_info *info)


kdoc open, but not a kdoc comment.

Minor comments, otherwise:

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>

