Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792611263;
	b=gK5vgBvTOCR1EpjODZ2heV6SX5HIZNA6Nh9j4pjDMvb93yGx8vjgrqBoVt2ZVzw8jIKp
	 vQvGv8wZjZq+NEsLars7myKBJrpXZEj2zS+dtFahp1wNeRCB8xwOZCyrmNNMXpbhQ5mhr
	 RFCdGw2LEPUPlO1HmQrzEf8Q7Mvp5VsUyZJSIS2rK9HOvdW43iv0whr2KCzmQHr/66reF
	 tFgDIA5mFmO2XRO0SGqk7UofLUk64u8pt8YTn/BtGfGnX5YhIZRSCrwOjaqdIhjyr+MpS
	 xdtnOwAmOMYKb84qWlbTG1DNxSzO1Vbt5Dda1ZzXFbMJ2ObKdaElvHtdmGT3Zvoy3ag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mAjxMb2peU68rNTsun/fi4TV17KNA0jxH7E2LUDJGrM=;
	b=TSRBFTFy2aSrdbkVxMhUWuuFszyVVQ5QyYmBTIWEa51VEv/ppBiY3cWziaLe9q0QnpVl
	 bWg4zL9PYlgcp5QxHpg3zvgeSPMLFVoaiHZie4rSc1ryrIyzdXq1QBimtylwQFV8gAa1X
	 1Rt0waRaNBLGQGtQaVZxbwDajnHJtKEuIAFCXfFCZ3t8hSvwqtT0WyeHGt/zsP/Zy+P3J
	 M2R8GeCsDJefmgMELhxd8poAE25zGM35ubb6nL3PRQc5xvOoL/x8LXWiBZRyviMv27pOl
	 KfrpzacwbXr6tw32quQwWrDgW1P2dSBm5vix3T1dvCOpf8DAdwyUk2cX8Sx+EdYjqSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=swuO3xS+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC764606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC764606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=swuO3xS+
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1d2ec9aadso545e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 12:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792611261; cv=none;
        d=google.com; s=arc-20260327;
        b=L55PookgqHFXM4PebNhni12fOwLbNXghSkw/WzwyQwie6kYAUizjLCWzLqKP6pzQUD
         jwZ/gpNiy4ntEEg5o6IslgRTimqDCyD9efbd96zahQ616+X6jQYycedLYwUOIgQB0Dmz
         7NF9EtYpjOJWzXTXbjmbQuXEYuQgoHEDyaCTEKwMxY62b6KX/KwfgBvtuT8AmG47rkW+
         7LLKPJEsMlYqDAWxJdhiKiwkF6+vxGySXwwXe/miIFIBs0V+Ql8d/hR5U63tUYXbIUtt
         yeGUHgGJIJC1TeZzsjoS2ssrPgL3UnrMbQDvsGM3ur3DE6deZnlbep8Mdsga5WDkp6MK
         fNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mAjxMb2peU68rNTsun/fi4TV17KNA0jxH7E2LUDJGrM=;
        fh=3ufI/V+/jRGnnw0gbi14HJND2sWOgiifRhYC1wBERO4=;
        b=oSOl6tD3ll4E9JMtlirZegEDh3M5L+UNUg1cERnuFUWO0JfyQsslOfAKAHggFfLVFO
         oYyBoIMqQFecLFIlMZwhG+fy0cpaeOQ/Y97SQGATyXAnZOHFXHSqOoYq1GIVxZC8OMKp
         xPXpRtNXMkJUiJ0w2gv9+EgJGSN5rJuLY0sqwuZzIbOyczfOtMKIZxrpYtWGFRWK4hER
         dLMXDQOvmPGBQT9uTLc//GkI96y6k+psnQxVwS7HLqhUJz2g2I7ov7WEBtFvNBhUJkVd
         4/iem6S0rV0fZEnLtFd/msCm2+9WqT4YHJzzd2WgS3DvXZjGnhsuScnju7kWk4mG+K11
         9nag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792611261; x=1793216061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mAjxMb2peU68rNTsun/fi4TV17KNA0jxH7E2LUDJGrM=;
        b=swuO3xS+Rtqk/Z4Nj3qkbG2O0ZZLDQF8iMbuh4DvAp4GdNO5ZIkR3kXnxQQvNhK29b
         KdstpTQ0hhkkPcBEmQr26iaaG7qkruHFoqmC8m+n9MLGFmLMs5xRzWT+Swz7SfLg5dAj
         4pMGWiju+12Q3Txh2UWkJl4GDhH6BqV3D+7+Bw7wbedrXS/DRCmNc2C8ma6y1/lYVpYj
         dPzYBkt3htE0B7AjbsOCV4XvEzUjj1a6hHojBBPIrMxIq/dT7FpzN/EGR4OC7n56cjrU
         6LF6m4plSOOAmnO9HTSoUnFqVz2Ru4l7gXNW7IJoxpAuzA4A9QklpsTvmgBYkkM4vetN
         bwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792611261; x=1793216061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mAjxMb2peU68rNTsun/fi4TV17KNA0jxH7E2LUDJGrM=;
        b=eBF4ftdXBhoofTTl1MAPhIbEE+aUUUCxj/1v3iFNwrADnosKJiVBvP/XkmvY2RK0WI
         CktGmuiBjDvuwbjlg4AjJSjQDd6u7LrxSBPtzR4Z6H6YOLlLBqrmLlosm4L3qG8hSh8j
         IrPgHG1MbKB4qwaXHeNwKOadBFkVVsYcUGiRY9cQM6aEdtqcT90rHJgpsPg7plKdY2M7
         LFmaf9X5E0Cny7FMVVt1CN6bNUAvv18giKvNQY+rLkByHDBDaqrDlmLYWvHlpCtQDM9r
         gucJUW8RYdpHWHA4bN/sa3G90W/dnboyuDKoqYTrbiYphdu5uEaJe12Yi0bhcPUC9wN9
         UrfA==
X-Forwarded-Encrypted: i=1; AKwUvBzhhBZKc2M871kvbKtc5hCGi72HV+R3nnZnA+xowXKyuw7OXr1JtrYFKeQ69W24NROLm5a6xqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOls4BijKISekJ2rzuoyLb/mPYS+9RyFby8Rdcm5fO5HIQEVR/
	FUUYzWg6Ef47yZvgArAR314lPpoE5gyZz9NuHwWCabiiB8NhbRUuLdDUzDsf0z8OePF+TWeavxn
	qDnKK3uJzRgv7HD4vRBk5d+qZtO7XHWGBsaYB27jk
X-Gm-Gg: AYBFou1jjRMY8eNfn3jFiR/lt6pEMsAK+PB5idDRndV99eEvI2Z57irR3s2kjOy8lyr
	JQtCKuFNdWKU74VyIQ9HuwnYdJDJcIjsBuGRxKLoHr1cFp0Sone0RRq+DffE2LCLL6f8IBvYUZw
	LqNA05SZ6iHIeT1xxgAP1LV1t7Q3W2OL5je+d4i6oiEzOg0cI129BLdRjhMlrFGofaiWu0f+EAQ
	6LV77r/L88OpgdS1sbeJsta2qNebfPDjqLgAp4A9F0LF38CN5PKT7oCjafKPMzgZfqYk2KF66hb
	kt6n54+iEWzgICJ8BtBP2cHwHWAuxMzlXTudRjgH0YcInI3lbML15rHm+qIRXYz3bpFkV7jLujO
	tmG308owmdLTdudD0D9aw+gIIT9nGkLXxai0N7DmRKnQToRXS01xwEPVkP5VOMZ+ACQ==
X-Received: by 2002:a05:600c:4e41:b0:4a1:d75a:8b4 with SMTP id
 5b1f17b1804b1-4a205eae4f5mr51205e9.12.1792611260644; Wed, 21 Oct 2026
 12:34:20 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792608753.git.zhilinz@nebusec.ai> <5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai>
In-Reply-To: <5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai>
From: Naman Gulati <namangulati@google.com>
Date: Wed, 21 Oct 2026 12:34:07 -0700
X-Gm-Features: AclHuK80M6qCxyiiocerGC3vShN3I2vPmFhfJhEDtzvZhJ7x2jmIyABqng8l3Ig
Message-ID: <CAMP57yU3OXGEY5km+BTj00S_3qmQ9gyCgmYdsJ0A7=gCjh4g7w@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] ipmr: drop packets with unknown ingress VIF
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org, 
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 12:01=E2=80=AFPM Zhiling Zou <zhilinz@nebusec.ai> w=
rote:
>
> A packet can race with VIF publication and make ipmr_find_vif() return
> -1 even though the VIF device pointer is already visible. The parent VIF
> device check can then pass with an invalid ingress VIF. For (*,G)
> entries, this can also let the packet be forwarded back out its ingress
> VIF.
>
> Drop packets whose ingress VIF lookup fails in both IPv4 and IPv6
> forwarding, before checking the MFC parent device. This prevents
> forwarding with an unknown ingress VIF and avoids the (*,G) hairpin.
>
> Without the early check, the negative index can reach the IPv4 offload
> lookup only for an skb marked for L3 forwarding offload, currently done
> by mlxsw. The race is rare; the supplied PoC reports only the UBSAN
> negative-index diagnostic.
>
> Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_f=
orward()")
> Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr=
_forward()")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4=
c6df.1791899747.git.zhilinz@nebusec.ai/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Suggested-by: Naman Gulati <namangulati@google.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v3:
>   - Drop the ipmr_forward_offloaded() index check; the earlier ingress-VI=
F
>     check in ip_mr_forward() prevents the invalid index from reaching it.
>   - Rename the subject to describe dropping packets with an unknown ingre=
ss
>     VIF in IPv4 and IPv6 forwarding.
>   - v2 Link: https://lore.kernel.org/netdev/23ce70e99d6c710bdc4cf065d7035=
0b754ed8f66.1792476942.git.zhilinz@nebusec.ai/
>
> changes in v2:
>   - Add ingress-VIF checks in IPv4 and IPv6 forwarding.
>   - Add a negative in_vifi check to the offload helper; removed in v3 aft=
er
>     review because the earlier forwarding check handles this case.
>   - Clarify the mlxsw offload-mark condition and UBSAN-only PoC result.
>   - Add the IPv6 Fixes tag.
>   - v1 Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033=
a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
>
>  net/ipv4/ipmr.c  | 3 ++-
>  net/ipv6/ip6mr.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index b9c544d48c452..de869a6ac011f 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2064,7 +2064,8 @@ static void ip_mr_forward(struct net *net, struct m=
r_table *mrt,
>         }
>
>         /* Wrong interface: drop packet and (maybe) send PIM assert. */
> -       if (rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
> +       if (true_vifi < 0 ||
> +           rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
>                 if (rt_is_output_route(skb_rtable(skb))) {
>                         /* It is our own packet, looped back.
>                          * Very complicated situation...
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 9d8116b5edb17..faaf04f5c4f33 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -2218,7 +2218,8 @@ static void ip6_mr_forward(struct net *net, struct =
mr_table *mrt,
>         /*
>          * Wrong interface: drop packet and (maybe) send PIM assert.
>          */
> -       if (rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
> +       if (true_vifi < 0 ||
> +           rcu_access_pointer(mrt->vif_table[vif].dev) !=3D dev) {
>                 atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
>
>                 if (true_vifi >=3D 0 && READ_ONCE(mrt->mroute_do_assert) =
&&
> --
Thanks!

Reviewed-by: Naman Gulati <namangulati@google.com>
> 2.55.0
