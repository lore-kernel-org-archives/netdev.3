Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C9153A89B
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986874; cv=pass; b=YG8s0iDxPgt/WO1akerp4PebsqXvNbVEiEor/Km2zj8vEO2J2/LSJ9sGKOtOlhqBD3xE1srQYOQTJob3GvKpJ3nG6FduZLEmE30mtK/QK8jMPwoXragM0gcdQkd9ZIR0wLJgYwOSbsFeuNTC3HuBhTw6A+Hh3Lk4cYp2BcOsTaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986874; c=relaxed/simple;
	bh=Ju4TCHvUQjzrivVHreXOsbIFDljzoatZ5Da/lDsSQWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBQyhhAjmJqegjX/OjIE8kz346QgBVeD4ThRHJMtuxbtZDdCS0h1F9a07AJFdv1CIB26vxlYT3HEPu2jQ5JkxV8cmsbLd35NncnZCFGyt3biSlLg86VkPCwXReM9WTviUVLQodL9spomizbz613Jpi1YfiqWewpXlFMmDZZLhQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUkN7mB8; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUkN7mB8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so728703a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791986871; cv=none;
        d=google.com; s=arc-20260327;
        b=JSYnIismIRRdNuAH10dTRV3IZR2qA0bP6gZUCVg6LEc8y0lJ+Xo2uMqbzfkaNIFeXt
         hGNHNyqxAAY7Bik1FLSd0Kv3KF3ERrE0AKobts0GXxT4GtV4WATuGwV7Nf3tALG+MmU8
         XGSGx51E1dKtXTp7HdWdD2BVFDi2mmnhTBefceHJ7WZAlMPa5L3jwN+xmTSw4kwUnP7s
         KVeLOLvnoDBSSAOMg9SV+ZZgMXK4dXt8DR+1jyVhnAOwfEtHXyzHwLp7JsxHnUQ/AqA4
         vmFbkdUq0rBY5USyLF2xHUMBuir7dh354H5W8XuyvAUUraOczVFMiM6EagROgXD+EGxJ
         0O4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UhgBX9GqYPCtzCE/DAmHkc/tMFE83OUWkvy12Au6Y9I=;
        fh=GJH5CXQViTVcN71n4scmc5MGty6i5dDcvk3WLFgaPIM=;
        b=Jr4zygfu8DWMOlo79ChW7m0D7yCukaMwalS2cRv9WwEOwZXqiGdKG4dUKVGVLhsCF0
         BUmAK+Y3vDWPFz+zgH9HI1caxpLsZD8N1nBa3zaBsB/ucLSdMtDpLkz0UR10LRGNOI8S
         r+aoMxmTjW+mfSfqvNvXhrDoCzYzIcw2TJV+mi5Pmc+bTDFPgdVlKOsA4IM0Qr/fLfeO
         jZjq+IJMglkBVz9nJrj5dTgyMb1+zNNDudR9PDeD0sPMpo0zCFqr2qGmp4qHBH/CbgC+
         6ZKkYeJ6UhRGof8GrPKg4QQECERRtP7jgDlcH8DGhQmcfRkGdwrluAvKvw4HShkrlzgO
         OmRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791986870; x=1792591670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UhgBX9GqYPCtzCE/DAmHkc/tMFE83OUWkvy12Au6Y9I=;
        b=dUkN7mB856aMWYzk2mAv2Y2m4zG1a4xeSRddZTuYhgZKusDDQonY235dIoG5o8JKJl
         QKfySKcXwVicI9gch5/dxIFvAJojQzL6662wKcXuu4woKgZMLRJ/qad1Qy12hIJJJF92
         ap0aW58U+bM5nXGVO7L3/S2o3U/Kyi3cgwfBeiJYRSMjA7/GK7XHQF2hovcQ9r30LjhF
         MtBjPUVNrnPtQXrBrGRKYpEqg9QVg5bej6nn+jqbr00k7bX60FRo/nenuMwc00AjgrKz
         Y5DeP6fJxqbzggFanRCjH84Dbmygd562npSp9dszqhZnUGifPCTVTeXchMJlw+YQwKXj
         AlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986870; x=1792591670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UhgBX9GqYPCtzCE/DAmHkc/tMFE83OUWkvy12Au6Y9I=;
        b=pparqYhBg8M2BPIY78r8EDII4UL8+428JYBsLZpemsav+OxDgSMG2VEkLU0VPT/K9N
         /AuIBwARGbPTKaxS+3OqqwoQGN+mGznMs/0egyrEX6a+gr7bgrPeYCrSvxs5OyDtKi1X
         ygpNrzu/frvKcalPkDnjV5iXqKKzP5NSOVKfnJzqkkA2nLIWOot0LfQ2VVwHmpgN5aDr
         D9sF719NmMLA/Re/gQDl6xTL7XWZsPT79/bYW2VJthVwYNfi/1fINhxV4CkTRQNRZ1rx
         Rk2zn/zPVqDftfk63n89JAm4UxndPCLI1fypP93d9fwn5BkgWLltYcNbtk9VBbhSX8wc
         OhoA==
X-Gm-Message-State: AFq9FYKNGFZP+TVwqxOUE6U92+dHZGhUvNZNsQoWk5iyHAzLYOzFhbVG
	OVQtT8vXPZ4HRHXV38eBXfQOOB1g7JNiDXYJl4D2pD9ITdR+YxQn1XR2vXfZeTpKtiHmh5vlsPP
	HSASMcqaPfe9Ty5t5iSAPkywFY3kEF5uWocT0E/UY
X-Gm-Gg: AYBFou2rsfpZsGlRFSqaMKZP4+UZJulypgEKol7WbrwjxnTy0kLJ84gU8MMusMFuTcH
	PkpLJoGwmDCeXVMqy3tzMhz/rxQ0i9xl3pBMI6vN6R7HN3AueDJ9UIOXVrJIz/WxdtO/MtyQqwD
	lOUhMBS/FZ4me8uCg8DdxxRAG7xQuRgrRjBQwaX4vna9RkwAo8L0ERMpv2apNv0BT9rk3R8UG+N
	moCZo1TKgAx1B+hA9Ewov9xbjW7PUspPh/aaEDDI/alwqnc0uNvM09xIk4+hpyu7BpE6M7RBSqZ
	sGw6A2k1v+WeB/H/j29NTtp9JVhJF0JY7JNHY0HU/w3zxv5cyFjyGb4jczW91aPhW/zBaJ8B2lg
	dynZ97zg9xno=
X-Received: by 2002:a05:6a21:a0c:b0:3dd:a196:308f with SMTP id
 adf61e73a8af0-3e16beeee7cmr12019509637.63.1791986870601; Wed, 14 Oct 2026
 07:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179156155963.36253.400481753322266658@gmail.com> <20261010090534.317149-1-wang.zhan@smartx.com>
In-Reply-To: <20261010090534.317149-1-wang.zhan@smartx.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Oct 2026 10:07:39 -0400
X-Gm-Features: AclHuK-Uxd2Qc-uVsvOHuNpvBEQj9YyXbEeOa-oEAPBD6eBDFm2MCHFuD_v1aJU
Message-ID: <CAHC9VhTMjeruUxobNKyE=4qmtgcQfd66MdbQY+X346Vn4Yz5ew@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: keep BIG TCP payload_len in calipso_skbuff_setattr()
To: Wang Zhan <wang.zhan@smartx.com>
Cc: netdev@vger.kernel.org, Joas Antonio dos Santos <joasantonio108@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 5:06=E2=80=AFAM Wang Zhan <wang.zhan@smartx.com> wr=
ote:
> On Fri, 09 Oct 2026 12:59:19 -0300 Joas Antonio dos Santos wrote:
> > calipso_skbuff_setattr() adjusts payload_len by the length of the
> > option it inserts or resizes:
> >
> >       payload =3D ntohs(ip6_hdr->payload_len);
> >       ip6_hdr->payload_len =3D htons(payload + len_delta);
> >
> > GRO can build BIG TCP packets larger than IPV6_MAXPLEN, and stores
> > payload_len =3D=3D 0 for them; ipv6_payload_len() then falls back to
> > skb->len.  For such a packet forwarded to a destination mapped to
> > CALIPSO, the code above writes len_delta (or 65536 + len_delta when
> > shrinking) into payload_len, and ipv6_payload_len() no longer falls
> > back to skb->len.  nf_tables, conntrack and sch_cake rely on it.
> >
> > The same arithmetic also wraps when a packet grows past IPV6_MAXPLEN,
> > and a BIG TCP packet that shrinks below IPV6_MAXPLEN should get its
> > real length back.
> >
> > Set payload_len from the skb length with ipv6_set_payload_len(), which
> > stores 0 above IPV6_MAXPLEN and the real length otherwise, as
> > ipv6_gro_complete() does.  The network header was just reset to
> > skb->data, so skb->len - sizeof(*ip6_hdr) is the payload length.
> >
> > Tested on one kernel (arm64, QEMU) with SELinux permissive, a minimal
> > mdp-generated policy (network_peer_controls=3D1), "netlabelctl calipso
> > add pass doi:16" and a NetLabel mapping of fd00:2::/64 to CALIPSO
> > DOI 16.  calipso_skbuff_setattr() was called through
> > netlbl_skbuff_setattr() from a test-only debugfs hook (not part of
> > this patch) adding a level-only label; payload_len after the call:
> >
> >   case                         before fix   after fix   real length
> >   1000, unlabeled                    1016        1016          1016
> >   70000 GSO, payload_len 0             16           0         70016
> >   65530 GSO, grows past MAXPLEN        10           0         65546
> >   65540 GSO with a 24 byte hop
> >   header, shrinks below MAXPLEN     65528       65532         65532
> >   1000 with a 24 byte hop header      992         992           992
> >
> > (0 means ipv6_payload_len() returns the real length.)  On the forward
> > path, with a client injecting unlabeled UDP through a router to a
> > server, the router adds the CALIPSO option and the server delivers all
> > datagrams (Udp6InDatagrams 5, Ip6InTruncatedPkts 0) with this patch.
> >
> > Fixes: 81fbc812132c ("ipv6/gro: insert temporary HBH/jumbo header")
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Suggested-by: Wang Zhan <wang.zhan@smartx.com>
> > Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
> > Assisted-by: Claude:claude-opus-5-5
>
> Reviewed-by: Wang Zhan <wang.zhan@smartx.com>
>
> > @@ -1357,8 +1357,8 @@ static int calipso_skbuff_setattr(struct sk_buff =
*skb,
> >                       sizeof(*ip6_hdr) + start);
> >               skb_reset_network_header(skb);
> >               ip6_hdr =3D ipv6_hdr(skb);
> > -             payload =3D ntohs(ip6_hdr->payload_len);
> > -             ip6_hdr->payload_len =3D htons(payload + len_delta);
> > +             /* 0 above IPV6_MAXPLEN (BIG TCP), the real length otherw=
ise */
>
> nit: consider dropping the comment, it just repeats what
> ipv6_set_payload_len() does.

Agree with the nit, but otherwise this looks good to me.  Thanks to
Joas Antonio dos Santos for identifying the problem and working on the
fix as well as everyone else who took the time to review and comment;
the help is always appreciated!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
