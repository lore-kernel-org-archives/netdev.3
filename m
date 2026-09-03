Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6593815E1
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425259; cv=pass; b=oKtfRCJQ74Aypjx32fBeVfbVR752T8dg+Fk/gH0EOxNQ5xNiD17Z5XvL/OFa0YJEms1dGpZ+AFVG3vTbIxUHwpmDsmfcnYPlOjWZRQkNiC/S9T3USd0QqRfTDdmMcktyboaWKhNa1joDyChjLiqZPCoG1a4Ar1gSY+yKL8G2bks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425259; c=relaxed/simple;
	bh=05J8FDGfobF9lm48BNn5ph4iz34rcbzc9v4CylZoeOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co9AC1GxdjfpaBj9W624R+TcFdYFmHVEGosk84nb1MjKjyYOqYSjQFd5ajtjVu2g8NJqDrAsb4ZnXt7G9tnZ6Wa4pRGVYqksj1c8JM5r0hYx1BU3CSKJmWkaRZlpfJ2FAZJaFqjDURuMib+zpLI5RZ4Ft1vyoqoWUUQitOa18aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+tF0twS; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+tF0twS"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-529a1ee0e62so23865001cf.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788425256; cv=none;
        d=google.com; s=arc-20260327;
        b=XgyqiyjjY8WEmYk+tRzvDpGVFxjJsFhVrdhDOdpgGkcPWLPP+CRSqcYIXTimSuRZQc
         VcJFeX3diM2GrRwjx7/3aLMCmtYP8XwBDlGZ1wk+rBukcXuLxeNFqsONwGF5MoLzrWmu
         1b9/4hBG2g0zol9fgJTck6Lwj47a7zzyRsMbghAUgDmHGdZ0DIpYU8QG4q+juROgLnn8
         2Z/tuBEV86JOKECr3ko0OBADa7VSkdbyWGMzlkqko68KWFnZgWqIhbDjVJ2tiiMd+KGD
         IhGyqIdTaHvR1uxq+yPPZA9ZB5axUkSDajeObt0iyudWl1wzZpqBxBMyMfgDHYHcXytQ
         Xinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlvqRataTugdfjdd+6DiNrkrIH6F8Qpk4TF7K6+Vpt0=;
        fh=i8Qwsyao44VVtOY8hfTL5sBfJYA19UHuytlpXjIayWA=;
        b=MpHl92oX92SGRoj1fQuYbuLHvNZr7BWHazBTuSRfiR7Pu1kn+957UvuVtl5XFPSLTx
         wwYW7gyaEdTzH7guDUNBfgB/I3EMs5Z1nKGHySBxH24MdiVzc7w5K7dbO3851rGVcHDC
         KQS7af5YNaNNeWnMlQrNZhH+CwTUQhIupMQ/yGx8kEs0Ner3cAG9mjq0U7/vmdmty+EI
         nPIVJWlBY+B7A9JlbyeUDA469nosNMan1YkHdpGvgb1OVP5d6sh0x0V2wrPPU7TvuO3u
         iTp4kUylns0MnkqKNv1ONYSgir+HHQffjCwxEIc0Gk4Icjj7V9G19wu1c0o6zo9XMVFc
         i7ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788425256; x=1789030056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dlvqRataTugdfjdd+6DiNrkrIH6F8Qpk4TF7K6+Vpt0=;
        b=g+tF0twSgUEAxJF0BJuirdtu3AzUTNJKteFVswI6HGVdiDlBPnA3TCXxmwWjMXV7uA
         rkoAXFRs5Xtbot4LmqoRk6ag1G4+v0Y5QGscNvagixNl71uZY6Aa35Pe2/ZFfKRiBkpC
         11046PP9nSej0c38wfNTekbdStVrSBd2KV+EpgT+mWolpg5VJcQWl359FNstJtwSyrc1
         QeOc0TbiJlNnhYsLldvK8o4mWSe70cvvOnUiP5bsmS+JzsBaenM0QjyGO0KFKBiOJC8K
         ktM4s9yfih4ERtUe7MG5n71/SGy8FAgVK+XwTVG0c/z1uVrFELvSTxlGpyWkb8o+Q5rJ
         +vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425256; x=1789030056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dlvqRataTugdfjdd+6DiNrkrIH6F8Qpk4TF7K6+Vpt0=;
        b=RvKNK4mkqnWk9GjV1vN+3p4/hv3/LLlAzFZvvu4YwMTiu51sNf0Og2aXKpFQwqrVYx
         qhI1/tOeOINAxerAfXyoaRwiysznnIegZRV/QO67E/9Esb4OZ8FFhwVM2UidN+sQKeyn
         Y8enAncPOZwhcC9dltU4dBpQlS6/9MYzk11hwrgFHszAA3c31EQNU32ns9hjrPzYRK3e
         K4Biabg0kpasd77CWGK0YmZznGTFlwbfGvUq7TndCfwp5HwakNUqeCd5C+JNCZPDRo5B
         uXq0ye5cl+7q3svPixQiD9LKr0pFIqrvGRU9xRC09RWejcs/QYz1oNxslfo9UERF4+FP
         YZlA==
X-Forwarded-Encrypted: i=1; AKwUvBwP2DUTq5LlAlEoyGA/GRXX1riPHLYnjdYgg2OAMvqmqmx+XETFQXpxqVsMRq/YqaJrfSk2V/8=@vger.kernel.org
X-Gm-Message-State: AFuF++lNX4+W408ZrKpnLZZZP7gtxEwJRaZUf7zAdSDvGjkmr/Bc2C5A
	HwkBjqTQU/66x87FP8tHrzioxgDJVb2A1XUcDkkHUvaJv2pHDDOxwWEh5DLuD3k4dESQ8fgaSZ/
	Piic2uyJDiT9bbvUFdtKPGzuuARciATV3P67xyGIyN7ArY8dj3on3c+/+
X-Gm-Gg: AYBFou1wc1TAvOGztnSSon0gAZtTDA/UopAf26g/dOhSxjGO9D+898dVl/kwgue5LV5
	2bJPZ3u1y5Isqct22nKMuoU4Ewyy5xy4Hw535HdFPV2+QlOSrt3sB25BF+R5lp/fNegkMTD0dhZ
	3FCQ66QyQTvp4KSoRxRKjwi6FVN74Sq3BGQtz4XeJx2ZpcKqqQzdyq9if1qdG1IyQI9g4GMekl9
	wga63Odb1YELxL0rwPo0/Qf0uwP1VvgGd+7vqUWt9JrPX6pWmNAJm/LTEzsamt4jB6PBhkIuwBW
	yLeHcgIrpHQ8R9yOE8pLueF1b90MXuqBsp7cxfPZUwLEmEcKUaErCotrm2YP8BtYb5OfZkWOV37
	MAWm8Q3L3F4toIUugiu9OziNFz8m6Ej9TBjLfSKRE7MmvgdNNyFb+htxcxA==
X-Received: by 2002:ac8:5f96:0:b0:530:2b31:a294 with SMTP id
 d75a77b69052e-53036cef643mr123350521cf.26.1788425255796; Thu, 03 Sep 2026
 01:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com>
In-Reply-To: <20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Sep 2026 10:47:24 +0200
X-Gm-Features: AcwNN1UNEffLCiS4uuycKstKIm2Kxs7muBvBi_-Ls_uLI52ZvwsZQISghlLpd6U
Message-ID: <CANn89iJ=atViUvhNJejKTJ=u6EyQ+8Zs=dLLUudu=d7-zcFBWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] seg6: reallocate the skb head on L2
 encapsulation only when needed
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:23=E2=80=AFAM Yuya Kusakabe <yuya.kusakabe@gmail.=
com> wrote:
>
> The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
> on every packet, where the IPv6 encapsulation modes reallocate only when
> they have to.  Ask for the whole encapsulation up front instead, so that
> the reallocation happens at most once and only when the headroom really
> is too small:
>
>   skb->mac_len + sizeof(struct ipv6hdr) + ipv6_optlen(tinfo->srh)
>   + dst_dev_overhead(cache_dst, skb)
>
> __seg6_do_srh_encap() then finds the room it needs and its own
> skb_cow_head() becomes a no-op.
>
> Drivers reserve more than that on the forwarding path, so the
> reallocation usually disappears altogether.  A single-segment policy
> on ixgbe needs
>
>   14 (mac_len) + 40 (ipv6hdr) + 24 (SRH) + 16 (LL_RESERVED_SPACE) =3D 94
>
> against the 206 bytes the driver leaves.  Where the headroom is
> smaller, as on a veth pair, pskb_expand_head() is called once per
> forwarded packet instead of twice.  Asking only for skb->mac_len would
> still take two whenever the skb is header-cloned, because the cow that
> unclones it does not also make room for the outer header.
>
> The cost is amplified by CONFIG_INIT_ON_ALLOC_DEFAULT_ON, which many
> distributions enable: every new head is zeroed in full, and that memset
> alone accounts for 16% of the datapath profile.
>
> Throughput at 0.5% packet loss, 64-byte frames forwarded through one
> 2.30 GHz core (Xeon E5-2650 v3, ixgbe 82599ES), offered by TRex and
> binary-searched over 10 runs of 10 s:
>
>   Before: 654.6 kpps
>   After:  965.7 kpps
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
