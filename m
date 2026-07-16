Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE1375F9C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221504; cv=pass; b=uN4yPbChNUtfNs1dX56PzHjsrODUaTFEUq8DJ9xlMfTTkyCZLiGTNF7ckl6hUTjrbHxu19vOZfMHAxkryv/NEv60N7Q57zjyFVRCX26NyMCgjn3tlOU+kK6u38c/qj2ML92dZ82y6kxrBRF+oE7pD3xliydoMRqig6dIV9tP1bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221504; c=relaxed/simple;
	bh=/NRbTPr2ARCHaeB7JpM9UxUa94xtC25Ck/TTv2Pv0rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bq95+YXYzX1n9BTPbf7oFtkgmMiLO2T5NyjjavmKhp5nUKF8ut1ZQ8s/AnhhHIhOz7EhQt0lglbWOKjvW0RVjP4Q8ySYr25hcuH7Ow82IsJoeRcqefki2syu9t2fVB326kts5liV5X3uLSLrwGHDlXkdQQM2CXFOWcMk8dIxyiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=AOp+g+iS; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="AOp+g+iS"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6611669cd16so3691680d50.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784221500; cv=none;
        d=google.com; s=arc-20260327;
        b=qcbE/s6npatpcUE4on7n/pJrMQ2lXcEzAUqWn6vxAIbavom914b7wbSO8sauVFQEcX
         xCaBGPlGoZMcooR3su05RsaGmHUQm9XLvCb1RXWV2DjYl4YqiXF/o8myy3RyYNns7VCq
         P5wepYQ+mYseKxJ884kJf8r/E1nUKqDdDO4LAtEuxEXP1h2lhq7fr81zbLQvaW86VYMH
         Wk8i/UjCug/SEvb/IHPRaFRMT+Ph8Gp6gzltmAyQZy6sFk9Ws+GgHN8rCkmd2djab7ay
         MQhDYCnZk9zS/qegteLbkRwQrNA2gT8tBH2E24sN8D5h/v+y014xhltKw42Vs0Tep25z
         UC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+JZw5Hz4janJjEuqA16a7six9g0o8x0/OwI091S30mQ=;
        fh=AM/IK/Gj8Vx/AUqqMG/mbVVrmqiqVbaQLlwEhbLly78=;
        b=ST9FuVblWTlBGYActIzdRfErC7LRYA8OvvYcJL3mDwBa59oTvXQexT9AmgTy/yKwia
         uomMMz9vE9yFlXP+ysIzkIVPj3VndXrF/wIRNYyJi5fQu9KTfWdZFE1r9chnjMB3bkd3
         UwjHInIEVt6t/2kGCCqJFP7wYql6oFKo35tcpGClvFcj9hoPJYUlmyYbyuY2GX9HKKeE
         cTzqo0OPPJPFL+ceIFBY5vnWg77w7tSiVYA7WXgI9ixwlQkKAihUHCYu+lLKhVvCHUU5
         YrlNwZgasnl/eIcCSemCxxTYt0yao/RGxC3Tnm5vX+KG1tsGs6MVaNXetjATvh1eBpG2
         AImw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784221500; x=1784826300; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JZw5Hz4janJjEuqA16a7six9g0o8x0/OwI091S30mQ=;
        b=AOp+g+iSBlxvaH2/1hal7wyl2F5ZsCek5HuHleeiQOwma2xb2jGmygOy+pqXJx2gS2
         fBv5MQvJ4QiBdJ+N49VwZcDW6N0+X3M9+ZtoSDBeS+3puuxGoj1iNH8c4FhA2fHjcajm
         9imoiv83+NEEy6ssVM3KurWTBZEKps07nadHaSgJilYFRrcg6Zy6hTDXtqEVe5Av11Gp
         rJYfjmDQ8j1FKdqHiUgHmd8eyG2e80SQkLYVLv581sVnUqAhzXKqWCblLs94wfFqRBkw
         X9gA4AU/3Dhd4pyd67O1oTqR7xW0RimkV/Jomu0LZlvnPrEHqXhXcFSLJxIdKXS4wiWc
         LtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784221500; x=1784826300;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+JZw5Hz4janJjEuqA16a7six9g0o8x0/OwI091S30mQ=;
        b=qMw7QQ1YceMNgvrfecCo+rYUmnfvpRCwK6oTRVhMdySflpbxobOPSWdMKMgHWPnfYH
         rzIZ+J8djm7DjGl7XPnm7mId41Hdwr9N3Ws7YU9eDuJ9lcESLsx0PMTaRhWF+7ZvFqyB
         wEsNyBVqSPGro5YMS67PcY64Qv7BS8/qS09h4S03knfwUMJplRbaIE/up9RdxHU8Snl5
         /uRMZoPKi1fT97FNIkt8abo2RZ3xwsDmHiu4P8bi4VSLlT7vwYvTcs2GU13h9G2cWomZ
         /GNcmsZc5WGBznWoeuLlg+VFEPneACdiGf8dyMs6NK8GZ7F8EC1ABV9zfLK3jCEdBgI1
         EnSA==
X-Forwarded-Encrypted: i=1; AHgh+Ror4QMdDd1lV0nBnfQKwSdGuqpb6xw99+OgGp5aYnB9M01gdFkyFXDRS+egVsry7CQDiRz9Ae0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ahNwdbkoDLAdaWV6wNv1F9I2GxQEd5kXRzN8S7wd1No+uzXJ
	OsQJMptzw7kChErLGpU7FFveRQXFLj6cwi/jiQh500f6pC9kKjNBE0LI7NWA03g10dGvWJi+ap5
	ilsgGcJQbnkxIQI9cAhhKVTA0JA4LsNngbmxTaCZ7lQ==
X-Gm-Gg: AfdE7clsGrzpKgeSzUJbE2nVz/LOY9GAvNsRvsGlLeHmC+9fs7fKTsUSuYUrKewXVtE
	RkLEkfanVT23fcmpAXDt6qV2H9xSVQTOqlWxLBJCPL/Qe4R40bujvH7l1J6EyeeloU58lXngOB6
	nFpgNP0+6N349kSusIJJyIsuoMH7QJppCoqshCUkWcvaGZGEkh8c283or7rpYzP9rYDhVNY3ZEJ
	+mn6AF8OF+cP00WD8UwLDKUnMm3azX/IKAQC5ZN+1GYsrGtIIgX8JVQ9Qf3PvO3fmwwT4LUjrqQ
	q8zqfD1w+81BdQgb4PxJhH75iDx1r2F50vRsvdP8x1crGj/J
X-Received: by 2002:a05:690e:408d:b0:667:db44:649d with SMTP id
 956f58d0204a3-66836ef0257mr48143d50.64.1784221500119; Thu, 16 Jul 2026
 10:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-5-alice.kernel@fastmail.im> <20260716144742.334586-2-horms@kernel.org>
In-Reply-To: <20260716144742.334586-2-horms@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 16 Jul 2026 20:04:41 +0300
X-Gm-Features: AUfX_mxUPX6hqqz3LgVXnxcjlSy_yXRipVG5gtUjcnx8M6AMwAR-DpnSyB1aNsY
Message-ID: <CAD0BsJV6SU_UxygMt8ruLVtgsrC91ZKNUyJdh691xphKmqqwDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/9] udp: Support gro_ipv4_max_size > 65536
To: Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org, 
	razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com, 
	andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 17:48, Simon Horman <horms@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [4]: [PATCH net-next v9 4/9] udp: Support gro_ipv4_max_size > 65536 ---
> commit 6dfda0f76318408b2e2b33603d561940b926529c
> Author: Alice Mikityanska <alice@isovalent.com>
> Subject: udp: Support gro_ipv4_max_size > 65536
>
> This commit fixes UDP GRO aggregation for packets larger than 65536 bytes
> by setting the UDP length field to 0 during GRO and restoring the true length
> from skb->len in udp_rcv().
>
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 493e2b9e16fbc..4f9a3922937cc 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -919,7 +919,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
> >       struct sock *sk;
> >       int err;
> >
> > -     udp_set_len_short(uh, newlen);
> > +     udp_set_len(uh, newlen);
>
> [Severity: High]
> Does setting the UDP length to 0 here (for packets > 65535 bytes) break
> software segmentation?
>
> In net/ipv4/udp_offload.c:__udp_gso_segment(), the code adjusts the
> pseudo-header checksum by subtracting uh->len:
>
>     check = csum16_add(csum16_sub(uh->check, uh->len), htons(newlen));
>
> If uh->len is 0 for BIG TCP packets, this subtraction will fail to remove
> the true 32-bit original length from the checksum.

I've already replied to this AI review comment before, and it's
mentioned in the cover letter. I don't get why Sashiko keeps reporting
it.

For BIG TCP inside a UDP tunnel, the SKB doesn't go to
__udp_gso_segment, but rather to __skb_udp_tunnel_segment.

> Similarly, in net/ipv4/udp_offload.c:__skb_udp_tunnel_segment(), partial
> GSO relies on uh->len to negate the old length:
>
>     if (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL)
>         partial = (__force __wsum)uh->len;
>     else
>         partial = (__force __wsum)htonl(skb->len);
>     partial = csum_sub(csum_unfold(uh->check), partial);
>
> Will forwarding BIG TCP over UDP packets that fall back to software
> segmentation result in corrupted checksums for all generated segments?

No, and it's verified by the selftest that also covers csum offload off now.

Normally, gso_type for tunneled BIG TCP packets won't have
SKB_GSO_PARTIAL set, because udp_gro_complete replaces gso_type with
either SKB_GSO_UDP_TUNNEL_CSUM or SKB_GSO_UDP_TUNNEL. This way, we'll
get to the correct branch and subtract skb->len. SKB_GSO_PARTIAL is
only set by skb_segment, which is called after this check. In some
very convoluted hypothetical scenario, if we have to reenter
__skb_udp_tunnel_segment for the second time, this time with
SKB_GSO_PARTIAL, it will still be correct to take uh->len this time,
because partial GSO packets have a UDP length set to wire MSS.
