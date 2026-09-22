Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8343E1D05
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084819; cv=none; b=bBQvKH0eTzqghWBNvvZezWJibuaMZAbLeSVxUyMZuONOIm+a+oUppGnM6lIcJHg2s67wEakVOvaqhdYzVlHMrUwvTOwZOse66smOhkoVAGWLkc4r6xIGMkVzA8OI0PHs0PKm1GgbAq/wK9X1LrhECu8iltGHJrZ+Z2mJcVLk07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084819; c=relaxed/simple;
	bh=A6mptCTqc8JYmR78HHITrrmFcDLHarfAJCWSHu//3Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhthgnbBFVT/3BJ+1LY8QVXHxv9r3OFkjeXW3BFGupeBYdM1WEl+R2juDeEpEZ1mbbklrU7DWGS1E2lmPuTda/UP+W4uyc/tQW0U16Rldm5FPTaBotQODwZJZCasPdKuTD+LSqdOcx/77BE3hg7ldgkqWTAc2xZ7WhfitW58HAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETN1UzYD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxP84dWm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETN1UzYD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxP84dWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790084816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRpz33ELk1+JRMOqNwfvb0Y3S56rs1Q7qrR4OEuociQ=;
	b=ETN1UzYDakwM6l7eWIafqVIEHy0Zn90Rk9MEUyUpDYu0uWaBbsTQxhnk2irBgrEV8xj2fL
	2lP4uVE9CzDynPCTGFp368402QAUVrBsok8vw7/1HZsKQpcEdgu2uAxlrCEs68ZeiRXsbT
	uKdl8WPmTrjqLTZ97dh4dvO6rQmeO30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-8LX7hwd0PZOljw-rB01OLg-1; Tue, 22 Sep 2026 09:46:54 -0400
X-MC-Unique: 8LX7hwd0PZOljw-rB01OLg-1
X-Mimecast-MFC-AGG-ID: 8LX7hwd0PZOljw-rB01OLg_1790084813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so30912355e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790084813; x=1790689613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRpz33ELk1+JRMOqNwfvb0Y3S56rs1Q7qrR4OEuociQ=;
        b=fxP84dWmDETI1q9zz5InT22xV4otHrrILkUz6OCI8GLWA7K0y/0Jd9mLl/DiyuM1R1
         T0Cqzm1wugmmGPAs07QtcUS/Nkq8Lx8uy9rPwMdXUtaLuF4WaanjBMz+cCMOsm4I00Az
         zZhmMcNtIf++Mdyl1op7djHRgo+jVvGAIrKj7t9oDLx7lPgr/786ZKfd2VTqeCJxPUnx
         ipTIWgu0WL+22egXVtF1krSSvQ1OiKhfUbRXz/bK+N+nu/bOhapmy9Agp0S8RGP4jIig
         /y+CDWyZ8+URb/AMd5BdJBZ7AFnt2YwJxeVzifJM3TkVQKACI9uj0rX0UoNGlpwjZTzf
         xfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084813; x=1790689613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRpz33ELk1+JRMOqNwfvb0Y3S56rs1Q7qrR4OEuociQ=;
        b=UO0VjD4M4oaw/VkS2+W+l1gJaah+qRF3ZurVNM1wIxsiJHSs2Ge0/HDkYRAikV7iO7
         R5wasCO74ZkkNcrG2XNrLR7gWV5kvU5cr7G/LSFeMQJqwaWQBWeuN26Gf+EIlfzX7f6h
         /72q0wx/6Xcpz4PLpOkgJH+5S3qwGU0agAhR+V+p5BwpuEO/2Ld00jVyqNhUxQ25fvkH
         bzcpwz6XFLlBOt/RRszY+rl7HpFHz/4g4f0hk1jpxXEYinzg0/jFy7VE/cU0KH0OZozk
         d2VtkTuWOXHeWp8wY/WCriKhHpRuoYBvXzwoo9M7otAdqyfVtohiWXbPzcnlSRodtwuP
         LQVA==
X-Gm-Message-State: AFuF++kwUrAsCo+S1n1nXi2bsW47gSipXaJRNwmq13qBXHKW8AQ2h31Z
	0svB35Jd69/Boy8qCAn+GPZITSFDxO4LgK0ttebxaXdwLoqlOAx4h8R+lN6tJQSzX3w1M3gfxLW
	sWB03Cx9axOKFPMNi9NbEvUMNmprGVR3GG6bDNNCZ1BbIzs7JWqHYc1/UYg==
X-Gm-Gg: AYBFou0859lH7QY+k+1kcE4qNKqrzG5GetO5/RRyRvuOtkWHfuYk9GSZARtvKROxJGq
	YFOzyDLAp+A/1sbdtkIX5vW/CjgC+gKctZrll0N3hDQR7RwZ0LX0lubwmjEn/HaZHvA+I1Uap7s
	BuyIn3Z1uqKGcYXNJblpzSPXZ3WDeUwvwpcFzKrM6rkxGrHNlNCeem6ATqRgy3cdUr2u0vQ0gGX
	ls8GNr32/J4nekHYU8NvmXnhLwOok3pV2fC6iXJkfmmge9JL7OW6k36NagJjg+fz881v8Oba5fb
	eADPhkJ65TEVwe4tX5bP2UyKcJGEF7NBIG1jLO76lTF1iys+6X3Wlw7ogGcFjioTiMRESWP7Ks+
	9FvxJZDNZqrFv8p5310FnPQMHJKPBg+Z3GNTqd8TH/7n5rD9mMGtOczdXm6bbD06VkKhW9Fsjig
	==
X-Received: by 2002:a05:600c:3f07:b0:49e:7caa:e7b2 with SMTP id 5b1f17b1804b1-49fc5756f60mr191055425e9.29.1790084812984;
        Tue, 22 Sep 2026 06:46:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3f07:b0:49e:7caa:e7b2 with SMTP id 5b1f17b1804b1-49fc5756f60mr191055105e9.29.1790084812619;
        Tue, 22 Sep 2026 06:46:52 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaafa9cfsm56898185e9.4.2026.09.22.06.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:46:52 -0700 (PDT)
Message-ID: <11c3ed15-9694-4b03-832f-6c49abd742d9@redhat.com>
Date: Tue, 22 Sep 2026 15:46:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ipv6: keep room for the mac header when
 growing the headroom
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918-seg6-maclen-headroom-v2-1-4d370af55b2e@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260918-seg6-maclen-headroom-v2-1-4d370af55b2e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 03:28, Yuya Kusakabe wrote:
> The seg6, ioam6 and rpl lwtunnels all grow the headroom with
> skb_cow_head(), push their new headers into it, and then rebuild the mac
> header below them with skb_mac_header_rebuild().  The headroom left
> after the push has to be at least skb->mac_len for that rebuild, but the
> requests ask for the pushed length plus dst_dev_overhead(), which leaves
> LL_RESERVED_SPACE() of the egress device, 16 bytes for plain Ethernet.
> 
> Where the mac header is longer than that, as it is on ingress through a
> VLAN device with reorder_hdr off, the rebuild runs out of room:
> skb_set_mac_header(skb, -skb->mac_len) computes a negative offset,
> stores it unchecked in the u16 skb->mac_header, and the memmove that
> follows writes skb->mac_len bytes about 64 KB past skb->head.
> Forwarding plain ping6 traffic through such a device reproduces it on
> all five seg6 encapsulation modes and on the rpl and ioam6 inline paths;
> skb->mac_header comes back as 65534 on a 704-byte head.
> 
> Ask for whichever of the two is larger.  These requests carried
> skb->mac_len until the egress overhead took its place rather than
> joining it.
> 
> Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
> Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
> Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
> Assisted-by: LLM
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
> Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
> ---
> Changes in v2:
> - Use max_t(unsigned int, ...) rather than max() [Justin]
> - Make the same change in ioam6_iptunnel and rpl_iptunnel [Justin]
> - Reproduce and verify the fix on those two as well: unpatched, rpl
>    underflows in 12 of 16 probed configurations and ioam6 in 3 of 13,
>    both reaching about 64 KB past a 320-byte head; patched, neither
>    underflows in 18
> - Rewrap the requests so they no longer exceed 80 columns
> - Retitle for net: ipv6, now that the change spans three files
> - Link to v1: https://lore.kernel.org/r/20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com
> ---
>   net/ipv6/ioam6_iptunnel.c |  8 ++++++--
>   net/ipv6/rpl_iptunnel.c   |  4 +++-
>   net/ipv6/seg6_iptunnel.c  | 12 +++++++++---
>   3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index cfb2c41634a0..4fc745f78eaf 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -262,7 +262,9 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
>   
>   	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
>   
> -	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
> +	err = skb_cow_head(skb, hdrlen +
> +			   max_t(unsigned int, skb->mac_len,
> +				 dst_dev_overhead(cache_dst, skb)));

The above snipped is repeated 6 times verbatim: it's calling loudly for
some deduplication.

Since all the existing dst_dev_overhead() users are touched here, I
suggest moving the max() computation inside dst_dev_overhead().

/P

