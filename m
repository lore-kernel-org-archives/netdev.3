Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353923394D
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252648; cv=none; b=IzbAnBbrNGPSRtLdFugVr/zRVSZR3Prw/cm/e8s8Wl0Qxyij/sXy2VVcgCOk1zNYm/fRXcg1DTRiY4ggP8P03zkBRvdfbdHA0cjWDFHROfiiGIqPWVgQsLOtp+Qcd29/UYoRYOWKfiWp4HaV19WQajOQek5FhoUevRgl+sqI6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252648; c=relaxed/simple;
	bh=buDbH2F3njrRXDQ6sKsXG1aceZOpDv/n8vQhTMP7H5I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ESIHimfKpvyaabiGAoR8jAke9BWr4wuLVs7Evb/TjOV/0ZpIPoK2qnNNd5NsUff1vcPv3PMD/iZNbCkN8KlxJaW2Cz9f52n7VA5z7eFLwa0Vq7xkpzCJoz+S2cAUxWMnzcw4K9N1SaRW9HoWMDf1twUSkHNny/wO0cPB473vrGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr3Zdkoy; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr3Zdkoy"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc0892f92cso236051137.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792252646; x=1792857446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZlkplhADRs5o0g+DjBrPDoiSvTdMdtK+ibJQdYkg8KY=;
        b=Zr3ZdkoyHecZwh9gUpewrKThHwH8ysmKyeqyvgOSByIDDBN6JXS490PYarmrSFxQO4
         RRq9l/RBMCOsbvgI1F/V3xkP0HOyfn4LFY8lfsi6onaZySWQnQGY038y6yCdvz6+PrgX
         migzCdGZYo25ItVsJk2ukvDMgEc/tqeb2OLsIl0FNdfsMzYK8r+spG0XM07Ow08H/8K6
         KnSX+uOcI3WFhBOBZ2ddxjqwjHmiWmSAQFKhosrGdH5kK9ljinRypvNq1JDRJgTr65Q7
         9lcFlvv/Bpy/jW8JeuKg6c1PGFo1XPcnUt9qmW/Qbitg29xmeRdSCPfUzs7QpZhS8hxj
         byKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252646; x=1792857446;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZlkplhADRs5o0g+DjBrPDoiSvTdMdtK+ibJQdYkg8KY=;
        b=Hr4Jh11x7ChsUqYa4z8AAT2zEfao2yGIHv4SahB06tCVDcZzQlvzH1m2EPSfqALmEe
         us0q/kPisZhk9MZs0uFJmtQTl42MA8wWntoFYNnuwkf5FIAIegi52w08uWJOixWL9CIT
         irLf9OkWFWrIGipB8khj9vsBzvQZONT1u8oRxMn4JvaNbz3CFl/mTewTjB9jw1lH2qou
         hisN/bxkDy+kksf0EPMRDecewsM4ImWlSlJD8A2x5JI2QMmbXImk4NDuMV031Ptxgryw
         FgjX4/DNNvyDPqgOKewB/T1tkeMMQiD4vFfLkWQeJ1PBwesWyMNoB4SXm83ApYzR2KRF
         i2VA==
X-Gm-Message-State: AFq9FYJqUfBg8TWiB7CUhNWaavJ30jYuozJYTz9HGdW5O9uosas4wx7W
	q+koCsi6DjxOlMgcA0POMt2G3P7bg5AgyjepE4ICZnq9FtH6Cj9+mDCw
X-Gm-Gg: AYBFou2fFSEPFfgZymTkO6jhOCHzxPfuB8w3FknhuztmEkQ9Z0LaVdrocqNtM8iM805
	kPYbo/P84KGtFvcE75Ow+VZcj2SNdwRxSxCx2ckE3VtTwUMRJjCzVOsCzC2q9k6Z3cvHMVG4cIE
	XaDb5daRBGXq+229ndYVHWZItUJgZrirMnBWwFFwWDEOoDtRKBHkkDdlQgSOvKJMEATsaw+hLfk
	vePh+oGbXH6ZNvUamO+CbaXgAvU8oCHSMdpX7p7w5Fib9N8RosnOLmIqMsCvzYJmEIXi5RJJqve
	SBl5MrR8WmK/p7MXS6SxIvRB3DznIXwvklPrfb1OlwT6xv3jVDYSNun5WLYOGAEvqkIz+T1VrGj
	omxg/gO6xdfhoylsRzs3I2zt/ZqCfqw6qnPbYOnJutLH+AWUoFLSjs+Rl7FLsFXSBUgEvKWc8c0
	96FEXO+rAGwauYAWSXLF78V6yrQk0dcQ9urnMj8KCMxqxhzjEbbK2z4HnHepJ8eNfsQTyc4rOIU
	NGgaVFvoC8jbf6Es09evjwd5uE2//ZIOIvnA39Wf/zUl+zGl3ZP5RNowv9EKnPULz9PIdq5eP9p
	rWsj0Tmf6wswf6dYchFo7V0s5TPF74QJLWPHrg==
X-Received: by 2002:a05:6102:5488:b0:7cc:2086:34cc with SMTP id ada2fe7eead31-7cc369c0cd8mr778804137.16.1792252645798;
        Sat, 17 Oct 2026 08:57:25 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835f05c7sm4323730241.6.2026.10.17.08.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:57:25 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:57:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Boyan Liu <yymhvert@gmail.com>, 
 Andrea Mayer <andrea.mayer@uniroma2.it>, 
 David Ahern <dsahern@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 co+98d7de09cd94fec5@bugs.sh
Message-ID: <willemdebruijn.kernel.3068e5bf74671@gmail.com>
In-Reply-To: <20261017120144.3059-1-yymhvert@gmail.com>
References: <20261017120144.3059-1-yymhvert@gmail.com>
Subject: Re: [PATCH net v2] seg6: Fix unset mac header in SRv6 End.DT VRF
 decapsulation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Boyan Liu wrote:
> SRv6 End.DT4/End.DT6 VRF decapsulation unsets the mac header in
> end_dt_vrf_rcv() so that the VRF device can rebuild it for packet
> sniffers. The VRF rx handler only performs the rebuild when a
> sniffer is actually attached to the VRF device (ptype_all
> non-empty); otherwise the packet continues up the stack with
> mac_header == 0xffff.
> 
> Every other receive path delivers packets with a valid mac header:
> NIC drivers set it in eth_type_trans(), and tunnels without an L2
> header (ipip, sit, gre, tun) reset it to the network header after
> decapsulation. skb_mac_header() even warns on the unset state with
> DEBUG_NET_WARN_ON_ONCE().
> 
> If the decapsulated packet is an unexpected UDP GSO packet,
> udp_queue_rcv_skb() re-segments it after restoring skb->data to the
> mac header with __skb_push(skb, -skb_mac_offset(skb)). With the mac
> header unset, skb_mac_offset() returns a large positive value,
> which the unsigned __skb_push() argument turns into a huge length:
> skb->data moves far outside the buffer and skb->len is corrupted,
> so segmentation reads out of bounds:
> 
>     BUG: KASAN: slab-out-of-bounds in inet_gso_segment (net/ipv4/af_inet.c:1383)
>     Read of size 1 at addr ffff88800da7ffff by task exploit/149
>     Call Trace:
>      inet_gso_segment (net/ipv4/af_inet.c:1383)
>      skb_mac_gso_segment (net/core/gso.c:53)
>      __skb_gso_segment (net/core/gso.c:124)
>      udp_queue_rcv_skb (net/ipv4/udp.c:2476 net/ipv4/udp.c:2466)
>      udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
>      ip_local_deliver (net/ipv4/ip_input.c:262)
>      seg6_local_input_core (net/ipv6/seg6_local.c:1640)
>      lwtunnel_input (net/core/lwtunnel.c:465)
>      ipv6_rcv (net/ipv6/ip6_input.c:351)
> 
> Restore a valid mac header, pointing at the network header, once
> the VRF rx handler returns. The sniffer rebuild happens inside the
> handler while the header is still unset, so tap behavior is
> unchanged; when no rebuild happened, the packet now carries the
> same mac header state as any packet received on an L3 device.
> 
> Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
> Cc: stable@vger.kernel.org
> Reported-by: co+98d7de09cd94fec5@bugs.sh
> Signed-off-by: Boyan Liu <yymhvert@gmail.com>
> ---
> v2:
> - Move the fix from the UDP GSO path to seg6local.
> - Restore the mac header after the VRF rx handler returns, preserving
>   the VRF sniffer behavior.
> - Verify the original reproducer, datagram delivery, and VRF sniffer
>   output under QEMU.
> v1: https://lore.kernel.org/netdev/20261010073015.7665-1-yymhvert@gmail.com/

Thanks. As discussed in v1, this sounds the better approach to me too.
But it would be better to get the opinion of experts on VRF and SRv6.
