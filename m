Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490369;
	b=sdBvJDcAQCzyG7HcDoRbjAMbaCmoqDNmoXQgiifmNeKqLDyZlkkVlcExAfscp8qkggW+
	 GGAQ0zRGB5H8pz/xLhCJ8yZCXjFntF3uADHnM08y8Q1+0e1v8lzUQGAs+nzK8QZX7LOPt
	 8x/gaoEvZan7upILOWW1EJ54zFLV04BzlxXA1McSvdxllNJcoQahUmMBUtTVMKCfJ28iP
	 fsGyplU5WU+Zhn8mm3GxbNOp4G5RMKnSfpywbOeOBaEpJ8xFQYjObg9MGInkuQuH7Ua6A
	 5VEUQgwTuk6uQ9/HR4ovD7/WFOeuwwagvyTINAC7WCLXl4eMK1+dsp2NYRMfJmFdfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490369;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iEo2xki5lr0Ld9JYPAmWGvg1Pdjk4kdBgUxL5c/PWWA=;
	b=11p5BzBerNzmzRNgDv1H9oEBGvkeuEWSq/jZPVuaG9LvzuzAtVbcaBIxr0CIt1Xp0+wA
	 Sev3Ks4R3lYjqUOWSYb/RtyVLGBfBxHznczWLsTOm6KBKhTJadrItbhsxRAH3m2ZXI+Tf
	 TXGRKroxgdd+E8YrDFsnoTU8UK+p2GpOHr0g8UV0Jehk5XRnyUtpk9GQxG9L21jGp4wSA
	 jXcDRg9Tf4HFoYqF9EXHPLMB8WHzw/iDGMVwwdKrA1+I+TthENbRI3UYashs67XFSJehB
	 OZB46Z4Vx08kGB132LOIkHB0NUIJVPd91ksMzqUxxH4fctQ3PtUQ4OS/8Xsh4C1fm0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9lBr7SG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AE606A32D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9lBr7SG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CD21F00A12
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490369;
	bh=iEo2xki5lr0Ld9JYPAmWGvg1Pdjk4kdBgUxL5c/PWWA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=i9lBr7SG/fDtD9bdmi6KD+XPnkRUcprImJzMti7MgTMiG3fCabTEmScJmy6bmre+s
	 TWwEf8neAUTGDJtN0k8m6X59GkHTQJf4TEQLiHRgueZjgJYfb0LcnmyWTfwb87aVJV
	 YUkRzi42wR3lsTyEYM8X+37yqRRgTaZ+quFhMrcyETttLQzAdbUnBhYvoKGAzz4unW
	 zDAjfUJWjFg0Y6n00Fd1f6iL9ntHsHW3NUgccfxUi4z+32EpyxJ03WL0IH5G/kZ8YE
	 e92roH1ccmLjKYcLOfy0zuUspWwBlHAOZVv3bhsRr/11qxAsBYyQVrdsBiPjDdnIWg
	 0z+nhdXPa72zQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3adfcafaabbso38596071fa.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 05:32:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHLYOciJLadKRFiCSTzhPWm0QVlv6s+SfuEgMyntS8aSpmeaDgts9yQq5pwlUOZvRlAwJlYf44=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SCwHlFYj4wEscAQhExTHJ/0vbHDyJNG/pp/7DvXn89YaPggM3
	s8Q+e3Z1Xqdy/n9/lGP/VOs7p0FyebRuYBHZOK0ld/6jo7uLgFc0dXA/JW3kXM0FHS/cjV/8mSv
	jQqhWmqkCIvDM87T44JBnVs/i3XCJlTI=
X-Received: by 2002:a05:651c:1445:b0:3ac:429f:6da8 with SMTP id
 38308e7fff4ca-3ae12679b99mr12954551fa.10.1794490367466; Thu, 12 Nov 2026
 05:32:47 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com> <20261112-sun8i-emac-jumbo-v2-1-aca0cf23cf17@gmail.com>
In-Reply-To: <20261112-sun8i-emac-jumbo-v2-1-aca0cf23cf17@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 12 Nov 2026 22:32:34 +0900
X-Gmail-Original-Message-ID: <CAGb2v67P+9zBpmst9qLBJ+PpPG4ghtiC0UiyTz1PK-wRm2jqVg@mail.gmail.com>
X-Gm-Features: AclHuK_HGkL2v-mrL96AWKEOzFXYn0NCtooN1Z9_WCMxITXSHxeYkq61j0wWgcE
Message-ID: <CAGb2v67P+9zBpmst9qLBJ+PpPG4ghtiC0UiyTz1PK-wRm2jqVg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: stmmac: dwmac-sun8i: Fix the RX_TH
 threshold encoding
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:41=E2=80=AFPM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> The EMAC RX_CTL1 RX_TH field (bits 5:4) encodes 00 =3D 64 bytes and
> 01 =3D 32 bytes (H616 user manual v1.0, 6.5.10; 10 =3D 96 and 11 =3D 128 =
bytes
> as in the driver). The driver has the first two swapped.
>
> The values are only used in RX threshold mode, which stmmac selects only
> when the snps,force_thresh_dma_mode property is set. No Allwinner device
> tree sets it, so no in-tree board is affected.
>
> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

Checked A64, H3, H6 user manuals as well.

The original chip this came in, the A83T, the manual for it doesn't have
the bits for this register.
