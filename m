Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01892DE709
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084782; cv=none; b=BA2quB7v6boUZU/vs1eqbDvX+71sgahNQbpCy5QbrdW+HN3U4o9TEIt6MmlqoWv9kSJo5EV33y64EbmwrdxJFtS1MoJfl+YQ8rZWR5+HUYRwsXVUen1DCv3M2V3DhxBenx0Jg0NLc3d+jSy/3HH5UQtCJJcIraDRpnDWXYcJwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084782; c=relaxed/simple;
	bh=tJoootuQrX0nPjs2wYqXe3DCOdBgRRUX2l69DqK3Z7A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=p4cscWIgjlpp5lJMh0VK49EIWsuReNIL9ETUZSFkszR9yCG/7uF97FrONf+nGYrsfnDiDhJIf8mGQZX4yE/7UptGmE1qA4LZCYpILFOyxVUIh22ybFGlhMSSXRld3Y8ezwqFOWyewvt97/pYb1xivZn3ppgpyVJtsfP+/rQkIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfCOHw54; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfCOHw54"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso417335241.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084764; x=1792689564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=;
        b=lfCOHw54JGGK4Mr46veh8M9LLjnRjZ2B/jdcW/TPrTPsHFYR1VsnRt8yAC2OQx8QoC
         wtpOKThGCAihlllyErS8Vu+AE8pDdEszZ19g2yOq7ARDJY70hgQUpb/hR57QQiKtgETV
         RyrsStBdAQ031IdK+rnn+U/GKejV0vwVz+wjPEf1GQX+tS3b4SgpGoQgPNN84L76E+6p
         Vk3MqcnScsnqEMJoEQo4Z4H0iQ/rmdDNOn0HeT8Y+hWtuACs4yakhAQc8LRb++ykmABd
         sWgxj/7Gi3dN4O2eIkq254ao/41ZirZafQrlplWKxDnON6BmZsFg862AIqzLZ4AZaxnt
         NYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084764; x=1792689564;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZvyPedXovvZDXPLa62gGgR2ST9LAGqR+oO13yEpFUg=;
        b=tOkiY8ZObm/bC2KqMyxCrQSdducYAPXjL9FIfyUl63ybfeXAyPGjXIUlRtUynTsC5T
         typBd+wn+0VERB5hxw+mpePezDgm/t4PzvhKr0pDJUnNKDFESF+KQlsLSMW/9e/+mOQA
         AP04VFr+QMfocZ50d3qMaykJot9Xdw3qeJtz4o8t0Giut9iu2YxsNmh0bHrB+8mF7yD2
         HbaUosWPYDHs45/WvNbN/qsftN1MbFDHQgxqbOiVfRliz0oE5Kn6w1gDYU1W0UZwyqA6
         sZPP6FH292UJlU9DjFh/WaABGRSawunO/8Bfl3feERiBUqD9reGjTfnLsl/ikbi0Htpy
         /Neg==
X-Forwarded-Encrypted: i=1; AKwUvByUKLptiEIfEqepBY9BbcGCU8ncUT986AmTeL8kgWNqLGQHflkmQje6/7kG7rSNQvB/2ZLaSUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVtTVkmSsX1xX5i+rFGw+oLvPaBAek3WsgLR/pfSmdH1iVLghe
	QIgrnPV2ZTcqQDyzmYrC8gKoF0V2huYZXTSMhhbHGTpMOt9hvWsP+d76
X-Gm-Gg: AYBFou2UeB1IFMuF+a6VZ9IBu8KWWWQUCh0kyVwOd/5NIMArqnSHiJJS4i1lLowOY+8
	8IT/KmIwxvMHJAM/onow3+B63LrTsKJvhs7cr0qLsEr4tLq92aM+1vb5Anv4fxuXm/F0a5yNclf
	Q7LqIyjbSW8tHRh5OjFZ2vZ7pUbAQElxOApt6t7sxRLs+nILglw+GK4QcCSBDGI7EHfwKVUA3Lh
	UByuXr3jCo8UDpt1efajLlsjjEkJ2j/KcY8AwnG5XBT1HvfNMHnFhQaPEoXB5xhnEpGADP1rTwc
	iqK5LVTsGrtttKGgK06PGXWbNALQmAHtCY8VSmmQKDhF4aS/Fh+YXUhGZ6Ono2td8lLn4Yqcs2i
	iPXziKLs0AkDDRpvsAYcBnhW5gd249WUIrIw6hqJLNTSRz84HdO0n5Guiz+EOpHSxMka82P0knK
	OM2eFyYQIiEGd1ft3IT4AEfarwRbRITNcYi830LKQlVMhdCj5I1in8uI91WGGkDMlNcn9Dy7qOL
	VYhQ3xPL15kUVIOreDjPWJooyjpWCiFDVAJQEj5WswRNEB24Q5JcpK/J4mN1AQZU9GEVXeY/q/l
	30iypVOsTfqkZGE+S+IRVI49NqZO4T5eHLW079M9e94g9NdX
X-Received: by 2002:a05:6102:370c:b0:7c3:2b19:6266 with SMTP id ada2fe7eead31-7cb3739fd7amr4589811137.22.1792084763651;
        Thu, 15 Oct 2026 10:19:23 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9900490dd07sm12972678241.3.2026.10.15.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:19:23 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:19:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 linux-um@lists.infradead.org
Message-ID: <willemdebruijn.kernel.10294d16149b7@gmail.com>
In-Reply-To: <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> it cannot make sense of, but the vector raw transport ignored
> its return value: rejected packets went on into the stack with
> their metadata unvalidated.
> 
> Propagate the failure.
> 
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/um/drivers/vector_transports.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index e1fb2a76fdff..8b7548458663 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
>  
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;

Should this return 1, like the above?

Not sure whether the verify_header return value is well defined beyond
just boolean.
