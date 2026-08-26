Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F05352014
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729676; cv=none; b=g2yXdmHeujxgdd6ejSByypOJrRp1YwalUgUTM+LcKlcDaMMiONxAkA4g37+nHRL6ASwTEQhe8ljd6hCi6SIupR66Sf86N2FVZjzTG4OniqagqNEqC7LY08kDDd5rvyk3JUfzzXeJZQGYv43AdVnFdJRul6qulLhW7RpqXE3l8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729676; c=relaxed/simple;
	bh=n2WVrnZjyqhw2pFyYx5KasETZzqRcXijdNs7VaQ+d5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tgztj4kA0sXZS749RGbNl8y2/eN0PX+0qMr+PJ05DF3F3NMHuJ/MTbAppT+qptWepBVyUAUGfapvR6pY8ob3UkLi7PX9pTn29WldGXC3zTa2FgHfIyOfYEjI8u5sWaUMh9EmpmOEC3NpXaenFx18ww1DZoeBmuPT5c6xOm04b2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JLatz1VE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JLatz1VE"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso71732566b.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787729674; x=1788334474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dg8QvMkmOhGx80YRqBGHJGdADY7W81iRGlIWI2IcRe8=;
        b=JLatz1VEy25bo2FOwwoChitgb9wcyLg32eNN2Q2FdnolHKX2LozXynvdAvXtPnDtgU
         GHCwAtDvwJNaS7n3MutWXfNGP8370uRbuHQ0BdUz2q5E0CWvjpRxwr74aA19ZBNswyU8
         G2mm6voXyNO+8BJ/mSqvRUpQR74LJOA3WhaKY+FmOZkaGxb3U94zGozBX0FWy8ws75Ok
         /CYCVZ3fUPfpug1rAEzv2J1ba3arItkzdTJQcHylYTZ/FZLMFCl5+2KmOC6A1K+JAh7m
         ihI4VMeFqvOiB9IbJrrjxr3ouvY39UncchVggMulDIBCxsUKQtBSLo0AD1VQvwFs5TtX
         KyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787729674; x=1788334474;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dg8QvMkmOhGx80YRqBGHJGdADY7W81iRGlIWI2IcRe8=;
        b=RUyYhJvNiLZSX2/Qe3LLm7VwS5VN0R1r6DLsEkGEyWhsxnRo5R2VMV5KZnR1yKXMjP
         P+fcZ9Qn2eMUUdBfzlSbTyuYYw+P365Vq5TSnORIa/VcUeLzNE+tx+LNpxNtHt3+rIVs
         0THBq6T2JBkj6h28s7UuWp2XeNhxD9kNuKmxsshwWNnbMdpRkh84WqMsHdb8WvuqXWIn
         FW9FvRH8MMKvf3xLi/I73sXpyTYibHb2WOCz1i6GgUf19SFwbg3eZbyON/8MQtiVVPnR
         Etu9lk5eiFIlmYAi3qDnfvSz5HwFBBPQn6xLvWftkM6dilM8gRTsPWTkjvpxFyyMUlba
         hXTw==
X-Gm-Message-State: AFuF++m1OEEHGcMxqjyf/T4piE6WDJM7w5Wdp/S0WtO0QmHeltuqT1NS
	iIfnvkhB1aidMSTFiWtYqyQXHTFE28JLp1SnhDs5BILdjRwXP9oVZWjyabnQuVCkxG0=
X-Gm-Gg: AR+sD134BGvFMhsSlvuPQ8A2cZt48GFfVOXnLXcGArnPqXNq8aL4bhSHX6SbHIuN2AZ
	xxc+5yd3/2lzDYliRy/wj10TGhYafOQ5SHTG3I+nwbOVwYaekzgRcJ3c7lYRBtSXASL1qCtDlCv
	I01rKKm/z3VHsmRS+dS3zZQ2KcU0CEZBGWATZddpmGfZ/+NCc9SHuu82Bf6+SLMEu6kRV8ABUJn
	dIMUjYJhIPijkrPYiTjfonrHKRaXyybcwyglUzqHvxO8X8VmE/sSQjTvOlj0XuUKUCX4bAE91AL
	qOJUxlWAFW8OV2LsAlf0b3iwI704w1K8JcdOCirM0vZk30HgkTb3TIBy29ji9iFr87voVVAQRjN
	SwpK9HFVhPIY2vc0F1+VIoqJH7n4UAkNYSro678AGWs9Z3ZFsy4WhQh++wOxk2y7zDqW58Fapq4
	tQNzrQstAynDROX+lRyCIBd7MzCFjqJkBlf6SvEltgGwaPnk8KKxL8Yqp+JO0EBHA6VqTE0LdU9
	6/T6w5u3vualc6uaME=
X-Received: by 2002:a17:907:608e:b0:c16:126b:98b4 with SMTP id a640c23a62f3a-c250bac809bmr533370766b.3.1787729673343;
        Wed, 26 Aug 2026 00:34:33 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d68desm512748966b.10.2026.08.26.00.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 00:34:32 -0700 (PDT)
Message-ID: <11e1c3b9-5aac-49a3-8232-f3bad8b281e2@blackwall.org>
Date: Wed, 26 Aug 2026 10:34:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2026 04:01, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The TLB load-tracking fields tx_bytes, load_history, load, and
> unbalanced_load are all u32. At sustained throughput above ~3.2 Gbit/s
> over the 10-second rebalance interval the byte counters wrap, causing
> compute_gap() to produce incorrect gap values and mis-select slaves.
> Such speeds are common on modern NICs under heavy traffic.
> 
> Widen these fields to u64. Use u64_stats_sync to protect the per-cpu
> unbalanced_load_stats against tearing on 32-bit architectures, and
> div_u64() for the 64-bit divisions. The tx_bytes and load_history
> are protected in spin_lock. Also protect the slave load writing in
> bond_alb_monitor() with spin_lock in case of tear on 32-bit.
> 
> Rework compute_gap() to use s64 arithmetic throughout. Return LLONG_MIN
> when the speed is unknown.
> 
> Detected by AI code review.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>   drivers/net/bonding/bond_alb.c | 52 ++++++++++++++++++++++++++++++------------
>   include/net/bond_alb.h         | 11 +++++----
>   2 files changed, 44 insertions(+), 19 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
