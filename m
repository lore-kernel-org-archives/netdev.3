Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938911;
	b=fwDpPNYsyh5g+yZhfZaFcZH0Xz544eSS8aottUpKZp9rfR48kyY3D/uMBADGom4ikScg
	 0i6SXhiwtxIbrziAOclqoqRTBXwxbE0jiCY+Wn82ttkECXfyHmhIMR37QHe83rDB2UI5a
	 a9GpQ1TPnbg/2bn1K3hqUos5q0O2e26XSNWXNBJyNCBDR2ELwARxFmbTbK+7hgUzMn2pe
	 2xyFJvU/jrL5d4/tU4Q5Ej6iYZCeHww9qIj7Bx98fsW0J12q+cCuwHZD3rIYmk3qY2tLU
	 /R21tFckXS7PbBGRHD7oLWjPUOGaquQ3rvc+eaGbZwYEhymBGKrTx2heBtIrqWflSKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3iWGu++LVn2H+H7qSXINsSF2Yix8YUXmGD2jfuzlbW4=;
	b=zp15chui6nP20B6rWGj9VH46F1++STafx5z/kvY5rrB+clCo6NO0rnFem0Roma0pR4+7
	 AGIZALbwjX5w4YutcN+98rrt/uVg/pQA+25dcUCHbSPxfPYrl2E3Z7eA47y0eEIbvKyIK
	 mgkoiOzxOgIIEmtX1RzynfjIepo0Qu/cvmc5HqSJH7HblD8J/Tu3kX4HwHPflX+xpWcAX
	 ei3zymCgETgRqdhHKXEReGKcIeTIgSznuDAKUbaCBlPWbHVrHMVnFCCH05SN6iWcqgWUg
	 eNNhHELvcNyNm5fd4cUeOhyfEWYlEVIclp/Ioygdvbd5feu3enb8HqY65beZzn3tRnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPLBi5Zo;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530E606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 04:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8530E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPLBi5Zo
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so44930241.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 20:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938910; x=1794543710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3iWGu++LVn2H+H7qSXINsSF2Yix8YUXmGD2jfuzlbW4=;
        b=HPLBi5ZoJ2FEx9YB1JPFyR+U0TF1QS0yQl70jq8YtcZV7js8q8IX+l5BqY1UE9m3FA
         hYtG09mknOxPocanxUtwFlk9zzf535Ha0GgsO8CekAYUoGedtTxymN66jxQlTFlNoUbY
         2nHGPYFtZaLCOCp+KYphEw0rooKmxEDtAol6Pc3Laxfknoeq7u1hXFxdWymJM0LXzK+x
         rr8Lt2huFTLYZvm3IWxvJTSZusc7qt1VxzqzSvFC7tgWpXLxB+zJA9wbwjrjJOvDQVLI
         vTWXiOCj+AxVSmr2NSqB6nX15dfzesN9HRWv08FkchI0EAu3E3Pds8jfPAYOzcdB2+19
         3/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938910; x=1794543710;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3iWGu++LVn2H+H7qSXINsSF2Yix8YUXmGD2jfuzlbW4=;
        b=HSpeg5ApFdJwf4SAhTGgaHl6JHSruRNenSOsUDRVQaFYGzp/PJ7MiM0ijykHeQEeqx
         ynyHx1olHrdJOljmz/a0LyPrV65R3djepMRdif9MojMJ//NxfDTwaXDA/AB8oAIJiLN6
         NWQwSl03i6aROJ/uiSKtQEf5lcD6oM+ksEYFamkQWAnwPS4uJH3WDuMsPwM9he6IeHBx
         5Gy64n6eDtVdgpsSD4b2jSA8SsHjTLJDftuBH70dzZ8bS8QlcJ+KGvhxIO2c78qSYcf+
         17S+0d7iUWNpUT/OmoQKnMt35qFCJUGg2ukV297wUBIjkuib+XLfrw78aW4ysMSWOIL7
         um4g==
X-Forwarded-Encrypted: i=1; AKwUvByqjX2M7kQvNvodd+QV3IIrKFKeq5dbYm7pHPIEHLORwANaYPZma+5nj7kabgmXMxdQemDhQSk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7l21v6BsZktYJXAUhu1dl81WSSg1y0s+iE64XAAalqVNJaBEA
	2bzFrtan8Y9r4kfQCPS2Uu6jES2hDETOUQsUkw8hFyJHnBBxfCJ6B27v
X-Gm-Gg: AYBFou3ALq2D/5gYfoGaAhjojJoDudvmjd9Q1mTdRKaZqX8OW/I7BUjnUO6aMpQkAMY
	cWWhkKutaypAQ3FSbsnDis9uXtq0t33UEdv7xSpnjSry3LXjwc94m8++XV3t6ll6cWZQqAJUVSQ
	2WN5zcv2iRb0EkhDVU1qCvO2b1Ec0yEKSlQnPEJcoT5K1RShtUdjE/rNBC4vxuApLfVPUc3rYcW
	sI2pkSIA2GB8UvEeb1+LTImCoFAKk/5EQ5cbbAhvZ5cGLmrYSREGNmuZZbqUIM4/KG0/d/Yk6YR
	Emj+07Uw3LpBeBr2GM3/FFMBaPN21T0/lvBi1kmExr+eKVZGwQ2OsBswOc3duWBwI/k20SRNJra
	6n9kBsCEbP5tCwxOT8YJTO2NfE+phjM9nz6KcjfO2f0xpktGgYB+pFLJC4RscvWr/9Ymu2PoO6U
	SFFkzDS73Oq23xWUGaEcmwvx0HfUJ7e/GFlyFSYwxrY+A8DwpGGKDB0QmPT7gXlEdLbx572bAIX
	rJOuKgLMPjOHktrsuOQSYTwAwa3YNGzM0Y/r3lTDQz+ULZ1r0bXz9UnWffEI/I/WPFNvUC9Y3fA
	lTqaInNa1fPpSEfpj+CPyH0rUG2ts02CF4y27g7BZDmbnHymgeTczyz55zNxj6wszSVrujOlD6G
	+JXFz3MX1sLah7kEmPHT0PaZlLnTiyVvZJ7XpCve3BnLm8msUCMa+cGiXGLcETER1BLBCR2c=
X-Received: by 2002:a05:6102:a18f:10b0:7ce:6474:7216 with SMTP id ada2fe7eead31-7d2a2f0ac8cmr439924137.36.1793938910317;
        Thu, 05 Nov 2026 20:21:50 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2a85beb50sm492944137.1.2026.11.05.20.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:21:49 -0800 (PST)
Date: Thu, 05 Nov 2026 23:21:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Hassan Sultan <hassansultan@google.com>, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.1afc96da83d57@gmail.com>
In-Reply-To: <20261105115715.1466924-4-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-4-edumazet@kernel.org>
Subject: Re: [PATCH net v3 3/8] tun: clear stale skb->protocol of NAPI frags
 skbs
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> With IFF_NAPI_FRAGS, tun_napi_alloc_frags() gets its skb from
> napi_get_frags(). If GRO merged the previous frame with
> GRO_MERGED_FREE, that skb was recycled by napi_reuse_skb(), which does
> not reset skb->protocol set by napi_frags_skb() for the previous frame.
> 
> On the IFF_TAP path, tun_get_user() calls tun_vnet_hdr_tnl_to_skb()
> before eth_type_trans(), so the virtio header checks see the protocol
> of the previous frame: the outer protocol check of UDP tunnel GSO
> packets rejects a valid frame when the two ethertypes differ, and
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with
> the wrong protocol.
> 
> This needs GRO to hold packets across writes, for example with
> napi_defer_hard_irqs and gro_flush_timeout set on the device.
> 
> Clear skb->protocol for IFF_TAP frames, as for skbs allocated by
> tun_alloc_skb(). eth_type_trans() sets it right after.
> 
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/179386753589.488856.11455181721004759454@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  drivers/net/tun.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 3920b3dff1e8..6b648f21018c 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1941,6 +1941,11 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			goto drop;
>  		}
>  		skb_set_network_header(skb, ETH_HLEN);
> +		/* A NAPI frags skb recycled by napi_reuse_skb() keeps the
> +		 * protocol of a previous frame. eth_type_trans() sets it
> +		 * below, the virtio header checks must not see a stale one.
> +		 */
> +		skb->protocol = 0;

This resets it for all IFF_TAP.

Would it make sense to do this in tun_napi_alloc_frags if it is only
needed for IFF_NAPI_FRAGS?

>  		break;
>  	}
>  
> -- 
> 2.53.0
> 


