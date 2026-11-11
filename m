Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405711;
	b=v8obBMQqTsh2F/68L7QmEPRwziAHsdBKd6OYcpozu64kAf8vtWNVsdqQCVM78TNpzJV+
	 Hgp0GKIbVhLbBNSjZ7ukXekHUC+OWcGyZEsEuA/HKFcYxUxMT5/nAychOhl5r11jSXziV
	 RvQV0mlUM2ACb66z2oNSVH+gmhszCQ9kbw1emnh/cyFscrLIQp4XkyOh0cMldtU4ZU1rk
	 WXY6RxBrswCAIgQ/xyTdxec0XtmS3c7kMmKlHKAzBerchREZjuVAWPdRsgRMe5EhKL/Bs
	 U854shyXcHCpgOzAsg5CvPoQBEJ3DBmJNPkiYS11iRqwoTAQo0/SpW93aDHlAvrJM4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O8NgyjtDYz4pyha39rltZunf2bBWHEXRkohajtNJskA=;
	b=YXomNpDuDOoTJCFZY9UhCLauAVeKIcJeeX6lSS8CalN77CEF+uXs4H2rvGWBg+4d5oIM
	 yty6B4Za5RLxzGjZ2GILniJVGXKmyLv86Xh/eCteqeFiNPZFuT1YsramkgNTbkHSMWBBi
	 zVzeRt72QQCBd+iBdviSYhJpQMol/ADX4+e5UGh48LM8h9vBFYRxYdtbmUXlYgSqa977/
	 L2zOnnvaWrV9T06W4I20W/OSJbHvDRjNsjHhqxPG7P0QgDO9yzxgpwp5klFBAd2UhfChT
	 yaJBI1M+8OIczZGNAa1aeZm++DyEZpNZlspglQEqNVwFeojLBFgBnQIxrGdKWgB8mXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Wl5idHGG;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35875606A32A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35875606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Wl5idHGG
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3acec6677so4906535c88.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794405710; x=1795010510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8NgyjtDYz4pyha39rltZunf2bBWHEXRkohajtNJskA=;
        b=Wl5idHGG8+6GNQnjX94s0EZTSeshK00S72EEWd+SxHRyCQwBWnP8p+VmT0VkT1q31x
         Tdo1IFOqKdaT3o9I+rw5p40TBXTbPCOMWdKAlgJBNKNy6R6EFWfN7Ra9O//tp7AOpuwK
         7IGP9NhjK7O4hh4C5alKlt7KTJArDAT9AveXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794405710; x=1795010510;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8NgyjtDYz4pyha39rltZunf2bBWHEXRkohajtNJskA=;
        b=GgmVWC4SxuXCe1PYTCUDsM7kvvVmB2bIVgTofjYkGA5u9HXXfZbl5SJmmTzcPBQE3v
         4OTpdweeMQsE82j9y21N0JTmalalP9uwGQRMgBL02em6YZxUG4aPVAIe9zWMo9u9SSjq
         CP8YFQLrmG90tTIjRsA+cqBihTbdNsX+SjWEx0z39o6eCAJpn50gOPDyYWVetgPJNdWu
         iN3N3oiuR1AT5NBv3tLK4WUlRjuvisxCT1Hqt3pjiaElouixolneLQVEmAzQUYV0ml5e
         ahmZFzaI8jVSAZXkCn6i3mRlj1nvf236c7InAjnU6II1+P1+dOGDKl7JUgZ45jW5Bzhy
         n3EQ==
X-Forwarded-Encrypted: i=1; AL+hErHEHlHILRC8yM8BCVcRMB5/JsZCixoQAyDj5mTTy8f2qczqnIW4fw0LYI/F4MejoIZDGrr0Hlw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nRFZsQnhlGlhPshchoIc9+TB3HNhj6OwcXW8VOhy90BxbCSn1
	48ZB+pimraufVU+TbxARSoRcM52/QH4WqTHtRaDqbVpAr4RLn4+CdL5U3hJ7EQr55g==
X-Gm-Gg: AYBFou0JfEAElXE7Yp7dIbnb8dDnLKJzx2xrm0z3KkDsEo8T/AiaFVbRMNO8rrQ++3j
	vFO/aItLUvAxwbzgLhI8BURlu/1V6OrOAiAu0EWuRmiMuevECmEXM0HAj2KLIt9KTrk+scIpLaB
	1+ps9wPUraSyXSlOUQrGC3yD+y1RIaJxV+G8014OdNZ0/hYyIGxA2bExDos4KbVbhceDZxuCpmk
	ppuhKHFADoI8tw3sXaYzJtBnAfXoHwr2xLCvh0ldojCII2VDf0rFK58J4u/tKBniqVLAwVBWh7W
	NeVfI3gMOOyG+FUJyI7OEn/iKgnvVOM67Zh44MhXj3X60pKsqDC5uzI2wDI+goFFCI1K8QO7iZ6
	KIMelnJebMH/4m1XMq0wYDE8wdsYeqMxxEr1rm2/8tDJFjqF6Hcgd89CTOrYyOubwoOBignBtMG
	4NlREqaqauHh/NOFCkg7NhH48sxHaES/S/eHT3xuhnAR99Nxwy2wyDJTDNUZOoikfVQqzOIxhVS
	amT3crKCSzcj9G0eC1qOc2lm8k0RQmYLWH+YRUGdMizwQbKvWio9G+vC7pGSohKnCcGH9nllRQo
	eR5KpXTKSQv2hj5f+hU3Km4dDV+lPlB3WFDrL+0=
X-Received: by 2002:a05:701a:ca05:b0:1a2:fa1d:1de5 with SMTP id a92af1059eb24-1b3c2154fc8mr1737384c88.20.1794405709684;
        Wed, 11 Nov 2026 06:01:49 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4d67::1c9d? ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm16836234c88.9.2026.11.11.06.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:01:48 -0800 (PST)
Message-ID: <0c970ddc-4cfc-4ee8-b0b9-6107a8804267@mojatatu.com>
Date: Wed, 11 Nov 2026 11:01:42 -0300
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
Subject: Re: [PATCH] xfrm: avoid stale tunnel pointers in deferred input
 callbacks
To: Jun Yao <yaojun8558363@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 dsahern@kernel.org, idosch@nvidia.com
References: <20261111094629.230568-1-yaojun8558363@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20261111094629.230568-1-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!

On 11/11/2026 06:46, Jun Yao wrote:
> IP-TFS input can be deferred while its reordering queue waits for a missing
> sequence number. The VTI receive callback stores a pointer to the tunnel in
> skb->cb, and the device can be removed and freed before the callback runs.
> 
> Keep only scalar tunnel metadata in an skb extension. The VTI callbacks
> look up the device by ifindex under RCU and check its link configuration
> before using its private data. If the VTI no longer exists, drop the
> deferred packet. Use the same metadata to preserve tunnel mark handling
> and IPv6 tunnel detection, and clear it when a new XFRM receive path starts
> and after the callback completes.
> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> 
> ---
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 6787fcf6a..f97412b95 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -5044,6 +5044,7 @@ enum skb_ext_id {
>   #endif
>   #ifdef CONFIG_XFRM
>   	SKB_EXT_SEC_PATH,
> +	SKB_EXT_XFRM_TUNNEL,
>   #endif
>   #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
>   	TC_SKB_EXT,
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 445223a8d..defdd4088 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> [...]
>   
> -#define XFRM_TUNNEL_SKB_CB(__skb) ((struct xfrm_tunnel_skb_cb *)&((__skb)->cb[0]))
> +static inline struct xfrm_tunnel_info *
> +xfrm_tunnel_info_add(struct sk_buff *skb)
> +{
> +	return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
> +}
> +
> +static inline const struct xfrm_tunnel_info *
> +xfrm_tunnel_info(const struct sk_buff *skb)
> +{
> +	return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
> +}
> +
> +static inline void xfrm_tunnel_info_clear(struct sk_buff *skb)
> +{
> +	skb_ext_del(skb, SKB_EXT_XFRM_TUNNEL);
> +}

The above lines are causing build failures when XFRM is not enabled:

In file included from net/core/sock.c:134:
./include/net/xfrm.h: In function ‘xfrm_tunnel_info_add’:
./include/net/xfrm.h:777:33: error: ‘SKB_EXT_XFRM_TUNNEL’ undeclared 
(first use in this function); did you mean ‘DST_XFRM_TUNNEL’?
   777 |         return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
       |                                 ^~~~~~~~~~~~~~~~~~~
       |                                 DST_XFRM_TUNNEL
./include/net/xfrm.h:777:33: note: each undeclared identifier is 
reported only once for each function it appears in
./include/net/xfrm.h: In function ‘xfrm_tunnel_info’:
./include/net/xfrm.h:783:34: error: ‘SKB_EXT_XFRM_TUNNEL’ undeclared 
(first use in this function); did you mean ‘DST_XFRM_TUNNEL’?
   783 |         return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
       |                                  ^~~~~~~~~~~~~~~~~~~
       |                                  DST_XFRM_TUNNEL
./include/net/xfrm.h: In function ‘xfrm_tunnel_info_clear’:
./include/net/xfrm.h:788:26: error: ‘SKB_EXT_XFRM_TUNNEL’ undeclared 
(first use in this function); did you mean ‘DST_XFRM_TUNNEL’?
   788 |         skb_ext_del(skb, SKB_EXT_XFRM_TUNNEL);
       |                          ^~~~~~~~~~~~~~~~~~~
       |                          DST_XFRM_TUNNEL

---
pw-bot: cr
