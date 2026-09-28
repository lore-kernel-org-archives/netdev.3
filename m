Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158E1397
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790556890; cv=none; b=YCnRuBR/P4hvXXXcqkWQPusXAX02v+0GAEvG6LItUEjUU8NJjgJNTZ1CihdpE5DaTM1Qrq5DijxPFlQDVoyWAT/r/mE1QyLLmeX0RckEyhPRmbtleUh3xICvsY2Lp3tZcAbLUs3YRdJG638r1tBRrwtGOWGU189wSZ2cygHa1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790556890; c=relaxed/simple;
	bh=v+7EAOat2bUhmXZxCVn/VDDKLd8H6fA4w1b07cXkcvM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XJ5EGp9PUpEEbwfkqPNCCBJ6eiLoGLO4g2t5kuhwoWL4LOeIuuJnXwf2j917tqm5akDaK9D0n4ypa7HojJtcvO5Ww7d3d4ANGNamG+77eemfEyTeKhiGjzStTpdAyE+NJ6TXZ2DFvKWJnfgwcG/KsoIIYM3ybOCdUzlEZs5S0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebbWhg1E; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebbWhg1E"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so17677697b3.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 17:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790556887; x=1791161687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/XZW0RmfCHiZbi2JmDAjRdogx5VNu3G15/mPaOcUQ8A=;
        b=ebbWhg1EY0bbEcHCEGIZ8nvsI6BEC6cq0GajAhkShVlT/5JWR1S3sCuAL4Liuj5q8S
         w1V5SLHouKOTkBdnNgpdfh2mHBYQ0zHF8r9DVpf+JcJK1V9xpivy/+yVKDt8EQO2nG6S
         ihuAuR/viQtSIJLIKhYdnlFLef9GOFc/HIKKOfE0niz/usvaU1BmnGG5pL6FON1B9aRj
         eRuDdeoA2HsMV3bVewGxz6dDbh/lRNVQp6IKGe8sxU8nJuNK7zarluTfVCBKxUboFo6x
         6O1zSu72zRU2lFKom/12KmLcUN2OT0DRgFkXD1UzyidDIQ8HsUEu1eehmQ9L8SrWjPmU
         YmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790556887; x=1791161687;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XZW0RmfCHiZbi2JmDAjRdogx5VNu3G15/mPaOcUQ8A=;
        b=VQfA6xiz2ntQKKXna2dWeDpZKp2IpI3rS5ci5hs6WZfuwejzc6jqWH/ybz8tbb7lPE
         hmCaYkGG3lBX1xW+RhESoNikm729L989aP/TfKoX7gf4VjaUbMcQVnR5ELV8UP6rgWH3
         c1ujpelkEtcpGaZCknX4Q72OgMvJkuqk5xZvtP/sPRTSo6Mzdb94jb3/E998PM4bRHYP
         YNvyNAd9P3Ws9NPG8EDioUEj3ENXj48QzhkTnRLbjINFLTr4+V1pXFtVs8VHDwQQXCA9
         Ph5RtomR1nBLCvrTCnLgcUg3pZUyCrb7g2m1khy6Qb5kizrMexO8Sir07HqC1XUSRdM9
         5DhQ==
X-Forwarded-Encrypted: i=1; AKwUvByt51qw+c3LKHNz0i1/Lp0zLigzGYbMRUQidFdn35+LHxFJs2c18yvDrqAa30II2+tKaZEEwAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrAKgLM2R5m8jpJdq9z/QwEOIH6BhpIZVYEH622ftOVNS1rNXg
	ahppcj5yKJw2sSFJCCUMU6gmg46X4r2J65ogtFydKq3jyM2ecYxaxtvw
X-Gm-Gg: AYBFou3TesP1oCBmIaO1v7fCt1I1OyjKuXI03GNeHXQ3RQHXqy6etbTHvDMuCFI2sqg
	R1FC7aOqTggMpa8BBFgGFxlO8vay1GZkSjb0+P3Yug5HYQKuoS24lqOLcuJF2VPU5izjNVHQouA
	AQb9vLyTdvxaDWEf4XDZllv6Jt16Ctllxn+byxlzFNDx30j9kEVHdNpqGLjLFFKcj2EUw18uh8L
	m4Q1atOwRrVFkCF8rgWGcOB3jcASIXaKFbVMxwTvqk/A44ej6dRH5SC8Ui8LXtlwtIuO2+IfZ/E
	dofHoNSawiGdnDh6xCPddkKDjCYnVCUhzWxt+HDY0+F0SP+mQy3UyRZiZXdxYd7FfU9P2vMU9pF
	b+mSdkgwRNmXSE848uEhyR/yPbW1BDtb/Q6+yyr5+JIAHRG2OX/PX+SGCgKs2iFyTzd/JPQGRlQ
	5bb1Rct76CNNFVGVEZ1c2HRdmamyr9ssMMxIEhg7/hhQhwgt0Sj/n54xiFDyf/XO00zrEbtJwcd
	VZkZIP2PfwlFgzQCJ7ksxzr3+8fkHVivyUzSM0KtuVg0DPoBydb
X-Received: by 2002:a05:690c:6e81:b0:8a9:c0ba:3ecb with SMTP id 00721157ae682-8a9c0ba418cmr16301617b3.3.1790556887583;
        Sun, 27 Sep 2026 17:54:47 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860ff8099sm36669067b3.33.2026.09.27.17.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:54:47 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:54:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 edumazet@kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Weiming Shi <bestswngs@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <willemdebruijn.kernel.e1283f58a0ec@gmail.com>
In-Reply-To: <20260927195536.2489079-1-edumazet@google.com>
References: <20260927195536.2489079-1-edumazet@google.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in
 __virtio_net_hdr_to_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> validation") added a '&& skb->network_header' check before flow-dissecting
> GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> __virtio_net_hdr_to_skb(), because some callers (such as tun_get_user(),
> tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
> virtio_net_hdr_*_to_skb() before initializing skb->network_header and
> skb->dev.
> 
> However, skb->network_header is an offset from skb->head, not a boolean
> flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
> instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device where
> LL_RESERVED_SPACE_EX(dev, 0) == 0), skb_reset_network_header(skb)
> legitimately sets skb->network_header to 0.
> 
> Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
> the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 bytes
> for TCPv4) without dissecting the packet, without validating ip_proto or
> n_proto, and without setting skb->transport_header. If an IPv4 packet
> carries IP options (ihl > 5, up to 60 bytes) or an IPv6 packet carries
> extension headers, pulling only nh_min_len + thlen leaves the TCP header
> outside skb->head, causing tcp_hdrlen(skb) in skb_gso_transport_seglen()
> to read out-of-bounds:
> 
>   BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
>   Read of size 1 at addr ffff888103c7ec4d by task repro/5718
>   Call Trace:
>    <TASK>
>    skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
>    skb_gso_network_seglen include/linux/skbuff.h:4718 [inline]
>    skb_gso_validate_network_len+0x92/0x1a0 net/core/skbuff.c:5566
>    ip_finish_output_gso net/ipv4/ip_output.c:285 [inline]
>    __ip_finish_output+0x28b/0x4a0 net/ipv4/ip_output.c:316
> 
> In addition, when skb->protocol is pre-set by a caller before
> __virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
> virtio_net_hdr_match_proto() was not checked.
> 
> Fix this by:
> 1. Initializing skb->dev and skb->network_header (plus skb->protocol for
>    IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
>    tun_xdp_one(), virtnet_receive_done(), and raw_verify_header().
> 2. Removing '&& skb->network_header' and the unvalidated
>    'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GSO
>    packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
>    their transport header pulled into linear data, and have
>    skb->transport_header set.
> 3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type)
>    after skb_flow_dissect_flow_keys_basic().
> 
> Fixes: 9e8db5913264 ("net: avoid false positives in untrusted gso validation")
> Fixes: d5be7f632bad ("net: validate untrusted gso packets without csum offload")
> Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hdr_set_proto is correct")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswngs@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks Eric.
