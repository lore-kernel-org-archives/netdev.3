Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0F3BE163
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181218; cv=none; b=Jbet5neCjLr/u5mKMPPiLI3IgflBXElpvgHKxEAXNxmS6SYFppO9FUjwmvdfgDK3huJ22Eb6CLc88bO3MUf4LHbkoaqezf5Z2lI+xloUumZnhGXsNDJJ9kjv7gbZsOc3DdNh/pi51EmeOq9EQUVkITzxyjSPQX1V8Rtcwr3Tb84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181218; c=relaxed/simple;
	bh=jKOtN+9q/uPl4veI8tMMpqUU6oLXYAfHYVc+qRScx40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0oe4Qu0eu078A0SJuFL26SmoVA9HC2hW7cxLGHMl+uI+shPHJu76pmOuRjLnNFfABRzxt8QLNg7kLi/Fi0bY8D2FP96XAD4sFBJch2aOBbiPz1pHwwFZVE63OWuKB0DF/x7sitKKtvFqGdBt5FGoGgYVSeYcHCjdrx0+N5xrqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3dXcnDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3dXcnDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D631F000CE
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181217;
	bh=jKOtN+9q/uPl4veI8tMMpqUU6oLXYAfHYVc+qRScx40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V3dXcnDY9qbtxe3on6/fybBWIiXnuGApplZNm4/kT4NyFLMTB8Vo98cvIU9dgnfg9
	 z+TCAUu8vv1vgpilrzTMANyCv94Upgd7hMG2Qjh2Pyh22hJnxkG1uEDW7ivElMRDGP
	 GNrUldI8b9CReoqLI92GITBoZmo+qwES5kIjrQgQGlfY0SwgriE0BPQzHVu7+H5HKm
	 FdL3lI1IEoY4kaLQAoi5gp+3RN2Hkz9B6oj8Rl9S80W9T76kjX/NOcVdMIDZ1mRcgK
	 RYkb3YJg+IFGJJyT9WADook8ODeaCytQiFEiL9TbGdTPGjfrc08btmm3UyV3fOGllo
	 1IIKc+Dibd2lg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3db57938so339723e87.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzEn/uZbXJPWwlKP+hsmf/guKiNsfYqVzudw45OtNW2l9/LlQL0wP+EJ8Eb2sIoJ9ebtWjvYVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZJbpdQ8V62w2E3sxlWoLiW1TRl0C/Cok4D90ilt4Z1xXS05kQ
	C9yOg3msCLuWmoXZP1hoP6MmjEx5YGVeC38FToBm0DWV3OEUaP8iQbU+OaRk4ScABp9taXlTfkg
	8bJJiI6OV35R7U3m/zmulufDhpCcGqXs=
X-Received: by 2002:a05:6512:3f0c:b0:5b8:f127:3477 with SMTP id
 2adb3069b0e04-5be50a6ba26mr177777e87.46.1792181216129; Fri, 16 Oct 2026
 13:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <6c9542eb-1411-4c1e-b678-f5ade2f5628d@yahoo.com>
In-Reply-To: <6c9542eb-1411-4c1e-b678-f5ade2f5628d@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:06:43 +0200
X-Gmail-Original-Message-ID: <CAD++jLmTeU7D2vvQ7dHA0+GHQQBWXyHb5=Bzq4P4Xpz5fSxPPg@mail.gmail.com>
X-Gm-Features: AclHuK8d-8yjgfn7JXzvfU5sIH_wfbDoWfPC6m0ST2i40gJg24x5OkWg7ufxPl8
Message-ID: <CAD++jLmTeU7D2vvQ7dHA0+GHQQBWXyHb5=Bzq4P4Xpz5fSxPPg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:05=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> The hardware structure of 4K VLAN table entries has changed between
> silicon families. Family D's CVLAN entry is two 16-bit words rather
> than three: there is no third word extending member/untag past bit 7,
> and no priority/meter fields at all. The FID field is restricted to a
> narrower 2-bit width. The chip itself supports both IVL and SVL.
> IVL_EN (bit 3) follows vlan4k->ivl_en, as on family C; the only caller,
> rtl8365mb_vlan_4k_port_set(), always requests IVL. SVLAN_CHK_IVL_SVL
> (bit 2) is left at 0, as in the vendor RTL8367D CVLAN API, which sets
> it only from the SVLAN member API; this driver has no SVLAN support.
> vlan4k->ivl_en is read back from IVL_EN.
>
> Reusing the three-word family C layout unconditionally means the third
> word is read from and written back to the register that holds it on
> family C, but does not exist as a distinct table word on family D's
> die; whatever data happens to be there gets folded into member/untag
> bits [10:8] on read, and re-written on every read-modify-write cycle
> in rtl8365mb_vlan_4k_port_set(). Give family D its own two-word
> pack/unpack instead.
>
> The two-word layout matches the vendor switch API for this chip
> family, which writes only 0x0510/0x0511 for a CVLAN entry.
>
> The family D paths are not reachable until the RTL8367S-VB chip table
> entry is added in the last patch of the series.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Looks pretty mechanical and straight-forward.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
