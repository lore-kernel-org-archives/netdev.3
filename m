Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A363B14C2
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792033014; cv=none; b=dJcMPIc6eEGOtDvX7k2U92Jber77RnWOSt23t6kSTrOSDloLDrVGADGpEMkw8s9/78ScIvfNJHxMeXqe/ShSeY1wUx0pcNvka837kmGZVixcwvldORA0U+Tf9ipuJDZUtAZwZdSAiowX7U5U6eOLpEACQoe8uOqZ7Sk9OhP2OOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792033014; c=relaxed/simple;
	bh=Ik3XO3cvIHw8bldp6m6yNBXukW/O+5KtzSL7EbNcoyY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NNFuudHyQq5i9MN8EUPWu9jx25ogfUmz9FK+D0+B0MN4uPIlaojciBZeEd9TK0z8vwsnxVvItnIowBM7nHzqe/wgwiwnDzgTfnRyULNjFHAktLYWTtfImBDerZAawP4QaW9fePfHrZaWQT9hjwkyatFscExxqA9W7UFhT55RKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8KLspHI; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8KLspHI"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5e948e56b8eso912711e0c.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792033012; x=1792637812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TNTxQfUgCJOsnMTQyE07oReChsZlTt8qxDE8Jve+7bo=;
        b=h8KLspHItMLT1Ts0hdrDVycYy9gSI1JtuQyniz71hkHseexIH9uLoyvLEK+tJlPeSy
         jazmb2XFviCJCPme+In4kTDP5AJEtLxNU2PRwcAdXJOA7ofSUeX3+hF5R3N5gRU82+k4
         g1GVgi0HWsvOwHCYUkgOVrOn0SjKTCZaXmH3YRbaz1qkZTpMU1d3z4RsyUfYF4D8alTt
         fon97SYhVVkdw3GjgLxZPsTp2I8BtIxePE6BsQed76aXeZL7S14wWz2MrAmDceBQgPhS
         G1oneyMRPB0QDvzcufeCjnbLtqW8hKzjenp8uZ3BN779KN2QGWnZxcZLgZaxMt1VvciD
         428g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792033012; x=1792637812;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNTxQfUgCJOsnMTQyE07oReChsZlTt8qxDE8Jve+7bo=;
        b=oi2HT4I4ErVLPYZ3UveMoNy0ZGkXkCrZxO0A8UuZCjcuEzoqVvVZnuFFMb5d7Yxlsk
         ZJE6WiwmFvox0P6a1yqKq5cWCYOAJunM3eov9K8gi9aITTZQ3ge6Z1Md2KHcu2VCQmer
         kdwf3/xtRL5pnXb/Sx2i0/66kNYdFnpWKgd5rZILcmWU+DDc+S/lLrxWi1H+o6YjSugD
         q+xN62MpWPs7H6zqcMOUQO5umbCNOIVOd8I/hT3PxBR5liRbXfQHsJRo60Jv0fCcWOg4
         ZHFR3/ZHorGn+QyMJ8hYx/125aRRX4GDxQialas06Nj4OiBMiThjM7xN+XXSB5VEWlu1
         w09A==
X-Forwarded-Encrypted: i=1; AKwUvBwr9tdbZeWSah7SxoAweRPZqmuU1Mqnwv7b87thZXCGrQBVkYrYkeOm5pr6G5uER6uCBFrLSmg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcpx94SVhUVXi9X/miR/newExjs0b8KPNHByV5fOf4r5rQ+r+s
	cpuXYpWj2FvZnbxwPdkxOesGYXn8E23lA6NXV6RnAflPqqSc+J2MnPHh
X-Gm-Gg: AYBFou2dAqu2NMoIlNphXTOt1uv7Q2TjLyVhyL+GhKg8A3gZ3RVz1x1EUIyN3hgccnI
	uNhi9wEVk6hlszXV6GuebsaXPIEW14oSXl8W178axV5szQTwAQCg2kp6775B4Zyfmrq7alIwujO
	GIgovjj3frJ79kzdTDMwGFI5qlAVMHiIjig6RFzoUgh6cGzLyLR8r1v1Z7aiCM/FRslZ9g+FvZC
	d1HsvVD0Vh3UgbShH03VdtXdYVbWjBSPESD/F/e3Lci3fQ8RPcDm+8xKzrWHeCNdh/tEydBCoeZ
	NzN9LYiVITxAbNOLdsYLfrx9vCIlCsf3bAEtfDYXcSqRSB66fk08eEhZ31XHw75HwLdtPxT0vmb
	1eDnASAuu5NUU5W3cwp4DnyVYGq6Rbweq70ed1iIhhwMfvWEBszD5KcEJHivxsA+EYV3/QoWPfS
	Q4U3/mYr2lvHirOQmHExgteD65IbTk8oEF4/HU5WDIG5dpIKbEVLU/tcLikiSUHC1uwemtkrUG/
	/YsYGMQcuO6abU4pJCicOkLpytaPU48od1bILeQ7Kjl4pV+sntmDD76tJsyGsbg4DAD0a4eQdX2
	oHC110pB6noYukYZQHdDvAEC7QaRsauc0ArIFNa3WfNL0Uul
X-Received: by 2002:a05:6102:5487:b0:7a8:46fb:eb3e with SMTP id ada2fe7eead31-7cb373e517amr5965316137.36.1792033011887;
        Wed, 14 Oct 2026 19:56:51 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cab4a97sm12938054e0c.6.2026.10.14.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:56:51 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:56:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Alexander Lobakin <alobakin@pm.me>
Cc: linux-kernel@vger.kernel.org, 
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2f0d78527930f@gmail.com>
In-Reply-To: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
References: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
Subject: Re: [PATCH] udp: let rx-udp-gro-forwarding aggregate under
 encapsulation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eva Kurchatova wrote:
> The rx-udp-gro-forwarding checks of the veth kselftest fail with "got
> 10 packets, expected 1" on a host where something uses UDP
> encapsulation, a vxlan say, and pass on a host where nothing does.

Uses encapsulation in the same network namespace as where the test
runs? If different namespaces, the socket lookup should fail and
thus the behavior be the same as on a host without a tunnel.

In general, I think the fix here, if any, is to address the flakiness
of the test, not to change the lookup behavior, which is as is
intentionally.

> Since commit f2e9de210d50 ("udp: gro behind static key") the receiving
> socket is looked up only once a tunnel socket exists, and commit
> 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO
> packets") takes "no socket found" for "forwarded" and aggregates only
> then. So the device setting works on a host without a tunnel and stops
> working with one.

These heuristics were chosen for a reason:

to avoid expensive coalescing + resegmenting if packets are likely to
hit a normal (i.e., without UDP_GRO) local UDP socket.

> Aggregate whenever the device asks, socket found or not. That is what
> every host without a tunnel has done all along: a local socket without

without a tunnel, or with a tunnel?

> UDP_GRO gets the packets resegmented on delivery, and a tunnel socket
> keeps its own receive path.
> 
> Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
> ---
>  net/ipv4/udp_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index cf07c3c6611a..d4e0e6bb9959 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -804,7 +804,7 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  		if (skb->dev->features & NETIF_F_GRO_FRAGLIST)
>  			NAPI_GRO_CB(skb)->is_flist = sk ? !udp_test_bit(GRO_ENABLED, sk) : 1;
>  
> -		if ((!sk && (skb->dev->features & NETIF_F_GRO_UDP_FWD)) ||
> +		if ((skb->dev->features & NETIF_F_GRO_UDP_FWD) ||
>  		    (sk && udp_test_bit(GRO_ENABLED, sk)) || NAPI_GRO_CB(skb)->is_flist)
>  			return call_gro_receive(udp_gro_receive_segment, head, skb);
>  
> -- 
> 2.56.0
> 


