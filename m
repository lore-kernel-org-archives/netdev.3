Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515166;
	b=c1t4HEqdGU8Zgr0leReyPqmCG5SVNYwxV8UxNtA0VBplpzeeVGCfXCPLmXefK8WNNhix
	 PJOH+3FjOuBNBJUGPYb0QkX+z+eD5ZEybCAwYliwHKXvRN7+TQg3zctaahYZFCAB6yp0W
	 UkoeV2sQ+LtRKNeZurzRC89zNHxhwhfC866433JUUwbQ59Jei03vSVL0liezMqw9thXPH
	 bJVk5Yvz9O/dEtvmIpW1tgw+X9QqrPei8uTTezSVAoQOjifPAHhH61zVsQcIEWOjjmC5l
	 V19XEI91YYNOFk42JOgdncWv/m48c8lbRGHUtx3Gvkh4/ZG8SS6XNQoYdULW8H5y0yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515166;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JZns9HamMNcZdpHYP/qFBtvpz2do+0TqTxyWCFjtrBo=;
	b=Gtqi32UTs9w1dM1glSVTTzIgDiSz57kWuMtGoo39WskoayGdIq7FRT9V+asWme58iFtW
	 f+CjXsgQFDxjoN9W05mdOHIophRr6zcJxSvG8F78JW06WelgTqYgHMDWWt0C/LQrpyOid
	 TQYRADlzpMmoiJ4ZTPa5S+8tcjaXLb3iuEZZnQmOuHqWTn+P3MOBfUPjBPbKpqpZZoVfb
	 N1oYojd65aviIsojG4h9ndSewvKt7gGpFtFLZHt5FNqvISbzDqMPKU2+dyK77qaqS3sCk
	 VtT4HNaKBesMVizlLdhrGmRzabU2iEKHxPAAZ80Z4G/QVaxn0i+UmsV3QUbPBNnWArQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayvBxNnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA1606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayvBxNnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F6A1F000D3
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515165;
	bh=JZns9HamMNcZdpHYP/qFBtvpz2do+0TqTxyWCFjtrBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ayvBxNnYcfw7YYNC9qg6slBeEO0T1T3arnqugFZsmCBXvnvCOEmawy2hpAsEMrWRG
	 owH3E5b0hmwbDAXJdzYkwhfCQYjd7LK+5PWRYjCmAts/3Lt69HybUdOZL2c2jwVv+p
	 qjd0X1FF31/JIPM0tAp9R4iNaBxSwa3XL9abZXDm8MrLlzZjCfszczR8+wDz0J5kqo
	 oTS2AL1Tk9v0e+513akTwTQP4X98WkPT/ryTNkWwcDMV7EhuaTLWIEGA4WCDCn7QNx
	 3CUy1BmsNYe11TMo/KjoZCED4qMa9u5ShrMl16p03FTYWAz07ht2bHqSfneQRT6z4n
	 yBqgLbeuSQh3Q==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso252990e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:26:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGoa8KICD16afmt47jRN/OIRNTYrIn4Rg1qjlLSfCWu5ec5yILCSTdPiJFJG+mSfIdqiruN5NM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bwZ9Pj8CMPlLf/2WnBinLKR0CxQX4MTT5y41T62pdiIjjTlu4
	gP9vovE3hiGcRt06w8e/9VkOcplSxyPnIjjMjeiNsYu1DtUfF2CdZs3FPYZR8DE/q2hu0FD6haL
	BWsYCqgkO/8Ed5PikTvwvdbGf1RjCk+0=
X-Received: by 2002:a05:6512:1048:b0:5c1:5958:a7e4 with SMTP id
 2adb3069b0e04-5c17077eaaemr175815e87.15.1794515164600; Thu, 12 Nov 2026
 12:26:04 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d9da17af-f49e-4878-a8dd-59a8919e6930@yahoo.com> <915a9103-82e6-4504-8d6e-3d12c4e7af1a@yahoo.com>
In-Reply-To: <915a9103-82e6-4504-8d6e-3d12c4e7af1a@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 21:25:51 +0100
X-Gmail-Original-Message-ID: <CAD++jL=0AO5o_1vWb284Kw-NRvwzRXM1b38HLHbiBA+m39gS7A@mail.gmail.com>
X-Gm-Features: AclHuK_3uCaXSKEUAL81VQhKIbyG96aLPrYBXSXLkRKlO7m5dPPVTgpdDl6W-DY
Message-ID: <CAD++jL=0AO5o_1vWb284Kw-NRvwzRXM1b38HLHbiBA+m39gS7A@mail.gmail.com>
Subject: Re: [PATCH net-next v10 07/12] net: dsa: realtek: rtl8365mb: set and
 get vlan 4k for family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alvin.sipraga@analog.com, gusfmora@gmail.com, 
	kuncy7@gmail.com, fabianotassotti@gmail.com, gabonpivovich@gmail.com, 
	contact@c127.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:37=E2=80=AFPM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> The hardware structure of 4K VLAN table entries has changed between
> silicon families. Family D's CVLAN entry is two 16-bit words rather
> than three: there is no third word extending member/untag past bit 7,
> and no priority/meter fields at all. The FID field is restricted to a
> narrower 2-bit width. The chip itself supports both IVL and SVL.
>
> IVL_EN (bit 3, versus bit 14 on family C) follows vlan4k->ivl_en. On
> family D, rtl8365mb_vlan_4k_port_set() enables it while any user port
> has VLAN filtering enabled (dsa_port_is_vlan_filtering()), so that
> static and learned FDB/MDB entries use the same key. Family C keeps IVL
> always enabled, as before.
>
> The stored IVL_EN is refreshed on the next port_vlan_add/del for the
> VID, not on a vlan_filtering change.
>
> Reusing the three-word family C layout on family D would read a third
> word that does not exist as a distinct table word on family D's die.
> Whatever data happens to be in that register would be folded into
> member/untag bits [10:8] on read, and written back on every
> read-modify-write cycle in rtl8365mb_vlan_4k_port_set(). Give family D
> its own two-word pack/unpack instead: add rtl8365mb_d_vlan_4k_read() and
> rtl8365mb_d_vlan_4k_write(). The shared code reaches them through the
> vlan_4k_read and vlan_4k_write pointers in struct rtl8365mb_family_info,
> so the pack/unpack code needs no is_d() check.
>
> The two-word layout matches the vendor switch API for this chip
> family, which writes only 0x0510/0x0511 for a CVLAN entry.
>
> Nothing points to them until the family D info is added together with
> the chip table entry in the last patch. Until then they are not static
> and are declared in rtl8365mb_vlan.h, so that the build does not warn
> about unused functions.
>
> Tested-by: Gustavo Foletto Mora <gusfmora@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
