Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792719642;
	b=rcwKJuDXEnk3EjMo31RK5M72y9omWg5dTfYW/FIm6bqArahL7pMX0amvhGSgg49vctpR
	 NZaUc08S+G0AU6lXyRAeB1fzIWVmRpuFZKhw6/3kRVNMkCSvukUD6Q1T9e5T/5eRiUdOD
	 tCwCQqmccKuk9xaX+xPx3EOCKlmBTgNpvAavisUJQK+Zm+3JdJeOzWfBwnbijneYf0kog
	 RlLQcjgyUclvXsjByFbcRT1095zhJ4Mlvix/wazRpRScjWUVh6Ux7faPPhN2jyzJ9kvbB
	 RpdDbWKbG6+94mtJ/1niFdlG0Z8BUOJOjBV+4bd7Odj+PJ1a4sA8zaGaLNWz2BmYz1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792719642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o9HAgtxaNemPxZckyLHTmWLvComr9TU6eoU06fiYdlY=;
	b=ToCVPLed4nKYJwGdg6RWNSgRCDrk0DqjVhEDP1l5JZe6e76RcnjxwvsU5swur6YCctwl
	 znxo56vx/ucXixqcPAAQ0wlKDtmzP7dz5aKQSD6AKtTyjuECrCYvOU6GHuINlVp2PLziY
	 6Ua9l0TScS98HhTbGKi7duPU64d5MrSITjVPuYv6046i4LfRDYMdwOB1n50c7xLmiJmLO
	 LG7fNsGTjgMfNGWFM2/wNd5CahZdOC+RXSYLt5jpcC9doy5TJy/nnhAapYU9ZEwhslJW5
	 MIsYuDua9IYKGUxtLHnnLfPWCAoEA/+WpQ5x6cJJDgA39HEXU90AkSdhF0d0i5WGsyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s1SsSein;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7D606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2D7D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s1SsSein
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cccb2c96d0so1608137.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792719641; x=1793324441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o9HAgtxaNemPxZckyLHTmWLvComr9TU6eoU06fiYdlY=;
        b=s1SsSeini4HLlNWI2u/4CcTuFPnLRQPe1ni/5caqVQWmRcnRQCpgIPhjnFkYU+CzQu
         ofwAsKvpr5nj5jXBnaDsEbCidMQtLqw0/DS1HN3lC87YcARIbeCGj+kV+gkXCKyftZiS
         orES2IV0PfRKyjqNBXLvbjs5KWXMyPmdmCpIIJsxNNUJdVBBwu/guaxmqapF5472FuZP
         0tuqiPmP4Qae34lXs1rrDRXl2Rh0zZbe46kJwHmXClaW6i/vlq8YTuXG4e4ADHazIWxZ
         GX7zv93mHoWv6UX2Atpx48/Ui5QES38fa/5iWxJg+mZavh+g9BeOS84PU4Ium+sOYOAM
         RKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792719641; x=1793324441;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9HAgtxaNemPxZckyLHTmWLvComr9TU6eoU06fiYdlY=;
        b=hPKp9UCoAjB/E9n424t5Q9oM5FCB8I1fGauGZfmGUF6I0AhT4uqbyc9V2qvQ0BCtI8
         GRyNydCzMyLyHIuv99Zuvx3DKBfJUFoLEX5BMmx29qrzYr0y1zvQgIzj3vOAtr3c69fU
         t32TX32jXj0zElIbr885lhqtahNDeMvCyBnselMI291QKw8K+F2y8tdu8rONvScqhSyj
         97ukQ9DyxN/CBp6YusCmhrTJIoDbx66zQ3roVYgPS8wfVJ6ImHPikye1nJVA5OCxI9rS
         VvjByyhdjETJ8F7e60+yBN1ziJQberGa9pLLmgc9iwK5iag7l9lxulS3EiUHP4ksaVDe
         pHRA==
X-Forwarded-Encrypted: i=1; AKwUvBwNxdCJrX4UBZOLei5F6zXcg+3JLV2f372xGz18v4M+vtqQ+kVq+C3qPxe+kRMTRUJuWggC8pg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGwr2eoI1TLZm4F6thyQT4pe75Q70Q2UOhpr2E/eSSaT3Bci6R
	lvV3eGjn2rsMgBw3dasZFnf4gDTz+rG9Zel+4Q+Av/RWsXfRKcHpujrwkgvtXg==
X-Gm-Gg: AYBFou2Qtr/74c5yxd3X/qs9j0vvnnr3cHw18tQKvIbBts1mUGGr7ALZuGgAjVbEtR1
	mdu06KsE5hKnH0gs7Li1kq+pnT7oWuZpdzzEavtcuusFe3VX0AT762LOQ1E8pHt52P3DRg41iqc
	a4nYHty/NwjJMSlnvc/0sVp5GkHWXFKf7httNR4/jELwkM0jnPpS0brjTJL0xCpj/myxjy/zzgW
	tarPkbAFan1RcY1upPLOJOO8btBdYG0PPLPDlBu/YOkax2rB0SK0C3trgvJQwUg5UKgPfEcjZut
	j0NZFWcs1TDkdWT+YvYfkYH7B+8O2ocKrl8vfVkJIv8G9HoxyPFZyXMfW8g2F3Rcmus20HYsMFc
	uN3ls6rytXGpOVZouycGRTg8/c0MIwAZMPIpmEAG6/SrBnK0wDriW44+J0wUV/Ja0DPO9hCXVnG
	uhl/H7Fewulx105wVAQwXHtOSuIjw9WaSDcABpS3NQmvPV6Kv2+BA3mHvHSkGsp1CcahJ3iUNU6
	Yy3Wjn1kzYAA3jBFYjML5lefMW0Fhaq2k0XEZltMKxYTJLf7SmCaZAYnA+ATj6rMjGtuzkSJO4a
	RbeeOV7GXzVJHnNpMDJ6OB8Aoq/Z2p2Lqrid3mT9ML96zPx+EuPGyH7r1wKFY7Q8jLzQHviDotv
	xPA3TgiuSC/ol7Ihqmrk=
X-Received: by 2002:a05:6102:548a:b0:7ba:d953:edd8 with SMTP id ada2fe7eead31-7ccc32dfa8fmr440445137.27.1792719640718;
        Thu, 22 Oct 2026 18:40:40 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13f674c5sm906104e0c.16.2026.10.22.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:40:40 -0700 (PDT)
Date: Thu, 22 Oct 2026 21:40:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kamil Sawicki <user148783812897@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.23b75f0b6c0cd@gmail.com>
In-Reply-To: <20261023003750.1133904-1-user148783812897@gmail.com>
References: <20261023003750.1133904-1-user148783812897@gmail.com>
Subject: Re: [PATCH net] net: limit priority VLAN untag depth
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

Kamil Sawicki wrote:
> The priority VLAN receive path can repeatedly remove VID 0 tags and retry
> packet processing. Unlike the read-only VLAN protocol parser, this path has
> no limit on the number of nested tags it consumes.
> 
> Each skb_vlan_untag() advances skb->data and resets header offsets. The
> offsets are stored in 16-bit fields. With enough nested tags, the network
> or transport offset can wrap. A later protocol handler can then derive a
> large pull length from the wrapped offsets and access memory outside the
> skb allocation.
> 
> Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
> Count the tag already stored in skb VLAN metadata as the first level, then
> stop before untagging a ninth level. Keep the accounting inside this
> uncommon branch so the regular VLAN receive path is unaffected.
> 
> Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")

Thanks for the patch. Agreed on the general approach.

One small suggestion for the drop_reason is worth a respin imho.
But aside from that

Reviewed-by: Willem de Bruijn <willemb@google.com>

Just curious: is more than one 802.1P vlan 0 packet preceding a real
vlan tag even something that would occur in practice?

> Cc: stable@vger.kernel.org
> Assisted-by: openai:gpt-5.6-sol
> Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
> ---
> Tested on net/main f4377bf85887 (7.3-rc7) with KASAN. The patched kernel
> blocked the nested vhost/TAP trigger after eight untag calls on five fresh
> boots, with no tcp_v4_rcv call. The eight/nine-tag boundary, nonlinear
> GSO, 32 MiB BIG TCP and fragmented-head tests passed.
> 
> An unpatched protocol-253 control executed 31 calls to
> skb_copy_and_csum_bits() with offset 65516 and length 548. A direct shadow
> probe recorded a 20-byte wrapped linear source outside the skb allocation;
> all four Generic-KASAN shadow bytes were zero. The patched control completed
> the same workload with zero matching sink calls and zero shadow-probe hits.
> 
> Allyesconfig and allmodconfig W=1 builds completed with CONFIG_WERROR=
> because unrelated existing warnings stopped the default full builds. Both
> produced vmlinux and bzImage, and net/core/dev.c emitted no warnings.
> 
>  net/core/dev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360ea..b40efea27dc292 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6198,6 +6198,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  	}
>  
>  	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
> +		unsigned int vlan_depth = 1;
> +

nit: since this does not count the actual vlan tags removed with jumps
to another_round, slightly confusing naming. Maybe 8021p_depth
or so.

>  check_vlan_id:
>  		if (skb_vlan_tag_get_id(skb)) {
>  			/* Vlan id is non 0 and vlan_do_receive() above couldn't
> @@ -6209,6 +6211,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>  			 * 802.1Q or 802.1AD and vlan_do_receive() above could
>  			 * not find vlan dev for vlan id 0.
>  			 */
> +			if (unlikely(vlan_depth >= VLAN_MAX_DEPTH))
> +				goto drop;

consider

        if (unlikely(vlan_depth >= VLAN_MAX_DEPTH)) {
            drop_reason = SKB_DROP_REASON_RECURSION_LIMIT;
            goto drop;
        }

> +
> +			vlan_depth++;
>  			__vlan_hwaccel_clear_tag(skb);
>  			skb = skb_vlan_untag(skb);
>  			if (unlikely(!skb))
> 
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
> -- 
> 2.53.0
> 


