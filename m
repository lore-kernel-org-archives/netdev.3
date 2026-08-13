Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF332366DA5
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620902; cv=pass; b=bEGmrQhqs4Sx6ui27FfwXcZ9ZQ3+mxNCUW6BrOo1k+sRfobOH5CO92Rlfg3wJe8pGQPiFeJSbLf5OkZHByol2SbJfjewDWEHq0UliHj74reBuzLcd4Y9GEtCGHYS/LeHAAZwxgnZHDyJ/eB7AiUX0A2+Sgg5HTWTIj3LsiramYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620902; c=relaxed/simple;
	bh=0dgpR5vjaXOxEpQo+Fn+JS7GUwziksGWhH1pTzHsS5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9XIfoHOBkAUnBEdU369zE6Q1n/4a2zHRDyd88YF/o0TAhQp+/D4dqjFm/0TZpOu9pWVZ8MPFH7yNGOGQp8JErtYqBbBDXOp0tTXZXLGIreh8i+nHOUb6yRFFYYHtLc5nang2Fjm6OZT46xTuisWK79VPwSwDHq3BGet7xoQuM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaIRuhnX; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaIRuhnX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacf197759so36541585ad.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786620900; cv=none;
        d=google.com; s=arc-20260327;
        b=aVWIkxUZs/DrvuisfJWkFSiatfNmWF/EQrpjLc9EHDeAw1PSEWXa0RRqhJF157hdAD
         G4eLWxLkvnvdXGSkr0Nid/yeotq9LKMy2j4wjyhrKTiMzVAwK19RMAxpYvs//v5gPONv
         zckAaUzpuPmZI3BHIw/EzQQwjJlb/pd7oK4pHHe3Bl2njDJR24gVE5uu//povLneJ4nR
         VW74y8AOFGSNn1fsIL2RhEZbV591XwTy6++0CVzICffyisvidqzK0eeywdy5QJ7pfSZ4
         z6rveaTMKCBTuQ5x7nBGZJG7neBWnWhi7hy2J8V/vQ2f9k5J41jKvAJL2+BVtwvKmps9
         mrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Oq+U9LuakWCGNWv2uf9pOHjLrsNGk0YSFSuRL9miXUU=;
        fh=R4b2Pb5GTIQfoFRUNd2g1yy6NbpWT79dkuNpUJm89aE=;
        b=EhyuXHmuAvd4MEFIVdBE3W8Xxcl7PbH9m2Rpc09dU22LCU6ebeTTgNIs+vMjOSZ66I
         3ujf0BURbViZe+uh5khmuXbgDWUiUjmFpChzFYay/gtPdo1YTPsFDZN4a6vA8jVsuxQB
         MTLe+js5JTWzDcu/Y6oFLsvfpZt8ALxud7OZpbvRdVZCJQfMBAEQ5DjrXn1PlzlFmX2n
         Yfeiepa2FhaVHTnkTpgDkE7zAroX0eFwWwRgPuDuLJjk8JTnHk9xE8NcuzgdColkMEOX
         82ycsk8OWMYdmVjoivafyebI5qCNMWBZ3nYFG4Mz2KkuKeEwl4qGyCS6IhnWL8gtUfA+
         CYbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786620900; x=1787225700; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oq+U9LuakWCGNWv2uf9pOHjLrsNGk0YSFSuRL9miXUU=;
        b=IaIRuhnXxzVG1aSJhGe37SLuJAEuujaABv6TB/xExT6zIvfKN2y+N8hz7XsBKZ+57k
         tHRnwzAa2BSZEGoucynWENbeeTWVacY87xjp/CAyAWF5wPezN+ALXLvqqZtYmdWFZELF
         90mUPv6J2zHPuCuEkVjfJJ42SELmJ8xINMDX0Ry35m+fb9kx11tvAoTvucB00icTFeIb
         CoPLugzJZh94lV8oIuVaILy/Dq8J5DgEKrk7qM3yhiJ55Zs5KmsFTZnPofbBDIlDOYEH
         S9+WmuDjh52oI2NyRqCDhBLAZEduIZ0MUATZg7gdPiNnIKvgUEpgAaEon+byIaCdl0Qj
         5daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620900; x=1787225700;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Oq+U9LuakWCGNWv2uf9pOHjLrsNGk0YSFSuRL9miXUU=;
        b=EnS+/Ry5vDKC8fPVbGVH8+X+43Fq7KzYLrs6k58qGnJfRVRcXZv4T6FcbOzlHo3VlZ
         1UezJqnBBlKawhusV2e6Ir/j6eJXFluGyqxY6lWl1tiwnHbZEM95g6go2SJNqhprmuCJ
         +GjhB0pWRsubuhFLNJgB++UHtIXM2PQfLjsBjwUcuwg9rzfxvXOhsUb2D7gmEwVWUZYs
         QSb52YdZOW4yP3v7GRrJ8e7TCIUDYjCbI2cQ+24VdtADx5v2KeLet4xnFaBOr6cIvrlu
         2tpnzcnMFsmh9oWLf6P4oOSj3NILg8FXuKeosyW1b1u6wiX1FmO9FthHDcHbGdxo6Kq5
         EtHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8GeVq6W/Vj2jD32IqSS6YUCSzAI9I8zpxMcKgYkm5zrnGla76HNyx9yZaJorfVwhpb9eOLH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQUAeDTHFt3yFMyBJKRSDUkeCNAGysw5tGl+gkKh9kTXWnDmf
	KwiQHAbYkAj1Ifqqw2wFGl0YjU1il5sFxQas6nc1YQ4paFgs0qxiRV61Vs1DffpcCXBxjHyyygL
	gLf/w7o8PPKz9JUY8FInplM9vQr2elIw=
X-Gm-Gg: AR+sD121YH4P4IbKaxluKnVdd09C+hlwjF0C1fyKMnAXZleNgqzzs4x3EOT6cHPzHQm
	CYmNx85HBhfbs6vn7AOp69KacHHo36CoyGminG+vlRjeva7f6yxZV8URGlVVIQx1jYrvqlg9JJn
	5Wf24OuF3FIIi3hmnv82WTPv+bvRafYWZ38uWttyxDrzXOB7aocExe0HTf93yZwHwIYEK/a7VSo
	9HopbfZE1lW/iHLVxL/v5Yg14rm7YXKD4+FucSI3CkcUnMYB4dU6fkvKiex8pa6LFQiAUB4srfY
	QKVpN5TWzIB9oDTtiWOhV59zDblQvexVg5di+rsOPY7tny2EKpn/kdBK
X-Received: by 2002:a17:902:e80f:b0:2c9:ceb9:865b with SMTP id
 d9443c01a7336-2d37ebccf8amr51028315ad.21.1786620900073; Thu, 13 Aug 2026
 04:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805072641.402-1-strst.gs@gmail.com> <CAOiHx==-d_nzO+TQO+4UD4GfoLSOBUyfLuO+hfj8rQ1if4sZ4A@mail.gmail.com>
 <20260812205047.ojq2yyjtmoe5gjot@skbuf> <CAOiHx=kKoZrZp3=o1kpH5ueSvfc+QLSu0GF-noCa7LPQnSQbbQ@mail.gmail.com>
In-Reply-To: <CAOiHx=kKoZrZp3=o1kpH5ueSvfc+QLSu0GF-noCa7LPQnSQbbQ@mail.gmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Thu, 13 Aug 2026 14:34:48 +0300
X-Gm-Features: AUfX_mwRCzdZCEO4bZnEfhWmPktifeidXgeaT9O-Nbx0mhLx-3Jwdkeb-xoBbQw
Message-ID: <CAAsRjRkDoUw+QYNr+Wb7B0hrMCtr3SFVxM5FVqcrgj_X1uceyQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: be VLAN unaware when not filtering
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, florian.fainelli@broadcom.com, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Thu, Aug 13, 2026 at 10:08 AM Jonas Gorski <jonas.gorski@gmail.com> wrote:
> There is also a (global) bit in VLAN_CTRL5 to configure something
> similar to MV88E6XXX_G1_VTU_DATA_MEMBER_TAG_UNMODIFIED:
>
>  *     PRESV_NON1Q      - en_preserv_non_1q_frame: (default 0)

Measured on the BCM53011: the bit preserves both frame types.
Setup: vlan_filtering=1, VID 1 with the egress port dropped from
the untag map, external endpoints on two front ports.

- Bit clear (the running default): an untagged frame egresses tagged
  VID 1, 12 of 12, and a priority tagged frame egresses tagged VID 1,
  10 of 10.
- Bit set: the same untagged frames egress untagged, 10 of 10, and
  the same priority tagged frames egress with VID 0 preserved, 10 of
  10.

The description's untag-map=1 case for priority tagged frames
measures differently: they also egress with VID 0 kept, 10 of 10,
where the text says they would be untagged. So with the bit set the
preservation of non 1Q frames is unconditional.

Best regards,
Semih
