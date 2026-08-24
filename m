Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19529363C55
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570456; cv=pass; b=IG8luYfYeG//CC+s+JSD/VjYB8J2EXPO3LbbF+XpLk6yc3bsb0lVxjY2WTlcb4V3chMDo33EJYqz7jAnXDPpwqGJPZjbIxfPr6XkR1kQIrGWOklr+uuWT3gXYaUK3fnTta531fAAjYuBkp70SOxsoTx9ovuMKrVwoHykweoroc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570456; c=relaxed/simple;
	bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FibE/uY9FWpeE+2a0PrTkXa+Lzdy8jzO4tHdTqdmOECBETJcF3d18WvF7unEkJ6OMecPCeUrrZh6CtjPpWZVZaEESIeqTy72wTx8zvv6iac3QOzevRO6hlWjNFC7dTL+Gw8UDJn95fe/9CTeK0BZeZL5jvogpHwfddXCRPTS4yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOU7Nbhp; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOU7Nbhp"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so609122a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 04:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787570453; cv=none;
        d=google.com; s=arc-20260327;
        b=mhYbEPR/4RkBEsq/GaTiL6gvQxatKu6VS1Yfn0o5RO2p5C9L6mT0xspQCTMu9oongv
         xGTvwI0dDYOhJL79EsShFgUdPTfR7/PgAU76sWn0xtOpNznnZuCe/N8f7tUoByHWiRip
         Gx6AO47tdVaQ+k8fuycwikicxVTTBplFuro2T/bWaSNpcTJJ/7jEJLLc4bzQomjoe6Qt
         8Fdgps+YKhvkemL96eeUUlDxweNf+1zcDGEIN/Ml6/U0V4JU7oFy3GIWJqYXzmsgRIoU
         yXxez11+0gPG//k5ESRUiqkD0wEHIz66dML8+Y0USeiBP+q3UMx8E43DCU8A60YeS6tF
         8e4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
        fh=A5V6wQFyci2SkCcv1r0qjrGPAiBluqpFf6NdGFUzM24=;
        b=UsLP5B9ftXiXPkaki29Y8EtCQh0anCQym7RQ8Z8Ou7NxuVVSnjBjoE4EvC1e1+ZA9I
         LmYy7cHVCyBjV3QlMHnTw/xnRCAcSerNiP7PRx/V4osnKFpF0NK5VpxzVUFRlX5pm7wj
         5UFsIIQiDjFYGzWMgyH8jCQnr9uYst3HkJnodpUx69vom09rfL6Nq7Hnw1JUDnIKVlQw
         COZtfSP7K2tWr3aqP6L5miLdLGmMiyD7jD52CjNCWj1yQSYIHKvXa/gojFDrP+Yb02r9
         sIu1IfY88+n81oYLr3dkLfK2Modcpqzw/j7GWhOH2sifvio8AI5SycyecKChTjPkAvmo
         ObDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570453; x=1788175253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
        b=iOU7Nbhprl+ErIRVM0SKVTgNZoV1iGrWBpRu1qvJ9ZBorYKeJeE3SyZSnF9D8reAPa
         LZaj6MK+vNE5VSHfWdDCvWXOu9PmNQ+IfohxpYI+0coxmrCaVReQEnwjwVF+PPAlDOtX
         Ljnxd2ZVuZCpq1sUQEZ81QtFQjmpoljlA9a//h/p6oJhQKPzcvPTrT8jXoEwuNQSqGFK
         j1xvgGO+vIkh3fvCI2GzX185PH49aPLaZyAyWR2y9zTiH2SDtUwGK5O7RtvGjLit+YqB
         J9uCX13rhl4+f6pvqzu8YLI72srqEiZuHG9wjhFVWVjf2Uw8xkd+Dgkswz36aSX594ns
         V/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570453; x=1788175253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzYFGMQGqT7y4Z3luy3N+VOzIHn8PE+ndRV1J1LK56I=;
        b=PCcxcxP9+XrXu9GHZLCltQedo3gngCR5Y0NVkf1Epo6DWvNn46lhqKKGTU7y36Hlrd
         HGUVpd/MOYFVqc7Zv0uCKwA3aKhPg2ONcRTT96lsfopu8LAn0iONNNKX+iwHCBpbo0SZ
         JI+Lpd39prJHbiobnTv2Bngt7B5GENg/EKuDG3yLNHMLT6gL/aV8DH4Vi30aw4fLFZyF
         yxByaUGWD0gESoH3uAF9Xk1QuSAoiuSUg6bLGYSI07VF0HLMTS/Ddc0jGXA89LaoemiS
         PqJ0ez8i0XmWy510UjqMEjyOwTVPComF5Zm+k+WwiRiEk0PVU8ZY3Is3HWludqATa/MO
         hwxg==
X-Gm-Message-State: AFuF++kQ1i3gXWIL3soecJvHTZfcI0AlbjQ8qSabJ/gVWeI+eLkAN2yy
	VsuLaE9zcFr1ovqKMwcD4ktCt+TXUUe+dfibdSlvUkoHwaPq3dPkv6Vd/7KXWBR1C9YKkvUmIDx
	RsfkbIQru/ZlUbsZGlG8wmHVaFd+KEKo=
X-Gm-Gg: AR+sD12ZoS4kZe9DOZjwwToOQAFwLV5x+Lep35uLnMWg9I2jR/AOtpcvqZoBM/eR42N
	in+rF11Kf/YeyFp/MpyzkjrRz8OMHBmnu9CgrQy17Zo66MVMQwm/XxyKkjKp1w8/Rq0lZA+5Usy
	h7WOomVKU0pag5QAvvFnTahET/HLCyx6wc80hrK2gMaJL4A3XXLKHH3nHWW6VYA3GNq4PZQfVss
	byYUsrTeKFqPAyGDf0MGa2bFlbsYas+BAaXaQprEVQQEl1SG1emNLSY3z2rF0A0FffqqLivSL3t
	hXkCzSlQkgBIPb1BVchH3543eH8yJRwbQTd7O9J62G+zA87b/EAfmGBtrwuaIyKEPf4JFgoDMg=
	=
X-Received: by 2002:a05:6402:249c:b0:6a2:9c3:6926 with SMTP id
 4fb4d7f45d1cf-6a42f1bcc81mr14169194a12.1.1787570453192; Mon, 24 Aug 2026
 04:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801060115.3538849-1-nicoyip.dev@gmail.com>
 <20260821145908.2829132-1-nicoyip.dev@gmail.com> <20260824075011.GA858321@shredder>
In-Reply-To: <20260824075011.GA858321@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 19:20:42 +0800
X-Gm-Features: AcwNN1UcFXyuU7hL-3GWhAB4rcYKRD0bjXeZfTZl0ULtNilBR6X5re8wwsqhuVM
Message-ID: <CAAo+4rVEbS4qq9_3OxMLMisD80CsZNjwN1ZD-obGQ2rxSy_30w@mail.gmail.com>
Subject: Re: [PATCH net v2] fou: ensure GUE headers have enough headroom
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Antoine Tenart <atenart@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 3:50=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> It is up to the caller of ip_tunnel_encap() to make sure that there is
> enough headroom in the packet. Otherwise, what is the point of the
> encap_hlen() callback? Also, adding skb_cow_head() in the build_header()
> callback forces every caller to refresh pointers to skb->head.
>
> There's a WIP patch to fix the same problem in IPv6 [1]. I suggest doing
> something similar in ip_tunnel_xmit() and ip_md_tunnel_xmit(). Note that
> IPv6 reserves the headroom before the encap push, so the snapshot is
> enough there. IPv4 reserves it after, so we also need an skb_cow_head()
> before ip_tunnel_encap().
>
> [1] https://lore.kernel.org/netdev/cover.1786088695.git.petalzu987@gmail.=
com/

Thanks for the guide, I just created a v3 to fix the problem using the
similar way as that ipv6 patch by adjusting the callsite.

Best regards,
Chengfeng
