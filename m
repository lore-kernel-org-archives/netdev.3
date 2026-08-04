Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A395D3F1676
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813090; cv=none; b=Nx6XjC4lJj0lPEnik5C0d6U3bRT7q4C8cJgYuRDWWhlZ5BpPc07Q6XsQSLPK0QhlDQwZrK3kSUDZWYrI/EfOSOJz7UKXL3ZoJtnJLztQ0d29CPe3R6TQpKSBXqIvs2gfsVF+RtFaXApCNeRy+3YdhJ4A5MYlf8yMqgkFl0B5Oao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813090; c=relaxed/simple;
	bh=j0mufMSuKnhX2/ovchw6+aaDzAm1BL+aWMDZ0rsyfoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpHKaT/oSjFJ28it//U4YuWHXxJKvOOR4YnMSmPV3kx4al2Y41p+Lmr9sXVEw8zjNV+da3jjxmq56gah6Mg7gxEW1+hDtzQtX/OEgicjgtw0I59UKR1jkntTU4bm5VwM3PnBhbI4ge7VJkgXmx6ZGEhbCcEoOSRb5aDz+yLfk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S22WY6nt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S22WY6nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE131F000E9
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785813077;
	bh=3kgaZqDQUIAJeM0ISENNIK8m7boslYUgftvdD1PiZw0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=S22WY6ntoQfkDL8DZvdChixVpgJU7Q4dD8F06+1bG8Co2P6nvIFYg+DxCTjD1cRll
	 onZNWNruCOYw4RZq7mn9zhsscrdMd9NyTI/sytz4zvrfP3A9mWfuzmTnXGsPVbJ/8K
	 aJKeRRR55yqubNjXs4InIYUE1AXcAL066FnQFEfF9oluIX20HCg10BTnGhj36Yyb3L
	 oHYhm+BWBkWtNo9EFdlKzG9dY9vjNz9ka/b+E1mEm80xezmbnPHzgTwf09Tdjj0knN
	 wNspKFuczGA4PqtM3CINb1aegZECoHRXPfXt7axUn81mA/J0XIf8h8cHavagb1VbNx
	 NGLNz/NDq0pIQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39db07589caso37433851fa.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 20:11:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqpqTraSm0i19eFlKvrSlWZWg03iILdoHn5qcYuS8Uio8zdrNfRYLCVzsl4FGA7nH78tfqH10w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAkvWmFW6dnclZdtIQuy47U4Xx8120xKqrfMzBizuQQX+9fb89
	u8hYVJa7lzECclS/mEueCgLW0BJ8Tu04AhNhDdX7T8vtHf9/9XPAgYbVaK9awy1ztt3yAwERNY0
	RxQ8JZa0TvQ8apYxTSGP6DljTUqqFAK4=
X-Received: by 2002:a05:651c:43c7:20b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-39f8610a7bcmr16699651fa.6.1785813075746; Mon, 03 Aug 2026
 20:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-7-andre.przywara@arm.com> <ad2e46d5-53db-49b2-a128-7c54883e18eb@lunn.ch>
In-Reply-To: <ad2e46d5-53db-49b2-a128-7c54883e18eb@lunn.ch>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 11:11:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v64yH+grXMbxg1te6XHt1PxhUc4Jzch_OdUW50tq2Eg1cw@mail.gmail.com>
X-Gm-Features: AUfX_mzJ30C6xeyppFwdQIE9h-X2BZ86M3EAAzUkPSMo3bVFKVcmKT8a2L5ByFI
Message-ID: <CAGb2v64yH+grXMbxg1te6XHt1PxhUc4Jzch_OdUW50tq2Eg1cw@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable
 Ethernet support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andre Przywara <andre.przywara@arm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Liu Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 10:53=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +&gmac1 {
> > +     clocks =3D <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&rgmii1_pins>;
> > +     phy-mode =3D "rgmii-id";
> > +     phy-handle =3D <&ext_rgmii_phy>;
> > +     phy-supply =3D <&reg_cldo3>;
> > +
> > +     tx-internal-delay-ps =3D <200>;
> > +     rx-internal-delay-ps =3D <500>;
>
> 500ns is quite big. How did you come to this value? Do you have the
> schematic & gerber files? Does the lines look unbalanced?

Unit is ps, not ns.


ChenYu
