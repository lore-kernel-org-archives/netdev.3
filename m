Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287C3C5536
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792181176; cv=none; b=WAKSk7AI837KDomVdd9bVKTczdchtDb1+xhtfcmWAl3jpxXvTheyILvGWnGZsmicU5Wat7XdJygGQi7Na9xbUI4XL38WTsY1u7Bepczv+kE+SSBgv2h6oz1/ECV3KN9xYHw/fUQmYQWGsWTOPquLGqFbAWOJbVSG5VeOfLpXEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792181176; c=relaxed/simple;
	bh=YYHrX336edggS0vBKeW4ydGVgXC7tUaMGTtk3gho1Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JieCB9V9oX0mtd8DaYCtgeVZUrvqkm01YLpakqcCoSbgmi7uJZ/FV75T1l1vW107PsnPOwnkfIea0xhsa2CPKa7zioXWpb3V4qAj+pD56xMpqU5j/A8TNmgAtf84oATa+syzt7uLhWHPrFgkLtY2m7xfw7iz91X/xvdYXtxhPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRrWcEDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRrWcEDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96361F000C8
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 20:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792181174;
	bh=YYHrX336edggS0vBKeW4ydGVgXC7tUaMGTtk3gho1Ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QRrWcEDfOUfQzMN4NxOFrZXSMMwjSY+PxlLh0u7sZqWe3C7OI5iMHbdvGKnvh8xZC
	 XLCGVtIEjzrno7TwJeCdCtlUBeHJVAESAqzt/CW1RupnYbLXVwstV4TP99tizX8cWi
	 sbFALm3Tsb/orPlbms+EpvEVtK8AJZawYCdFjXKdzKPpPx83Jd853+GymNL5YWfUAn
	 Dbn51Z/7mgRZ4lwS5K20w2ZJOTFI66TmIj7jA0sAf5fxUoNKCrizHVz2QrCmHfgFMX
	 rcGHJbuxyW6Dhw/C38B8YgQ1zGksK4WDf7SZHp9/+/xajDIpe6eWuI4d2QEL9dZ4dc
	 PqZQw4mUgnfGQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a60cb94b80so2825821fa.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:06:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByMG9j5F59v/+wkXiD7pHeTKty9PQBBm/tQp+Q4oTd7cknQTxVY496txyP1gfbG8MdZ9q0QoQY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfj+WZiCGNzAuuAoqglBcw8n2Oavf3afepb074oFb+NoxmQt/j
	bJlDXFIpyZK6lVXH0zFpzD/qfxn4nnng5Z67GOmGJwcXaZp7RhsimqQsj1f/dDdR5uh58U2Juft
	F094HRIInI1ovL+8D8nQ+TebBExe5gIw=
X-Received: by 2002:a05:651c:1547:b0:3ab:1639:9a49 with SMTP id
 38308e7fff4ca-3ab292bfe7emr1867771fa.18.1792181173665; Fri, 16 Oct 2026
 13:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <aca905a9-9cc2-456d-ba5f-2d9425f1b5c1@yahoo.com>
In-Reply-To: <aca905a9-9cc2-456d-ba5f-2d9425f1b5c1@yahoo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 22:06:01 +0200
X-Gmail-Original-Message-ID: <CAD++jLmUiEAdjOCXorRXixy-SLeNsKp6VX-UrpyjCnetRSnguQ@mail.gmail.com>
X-Gm-Features: AclHuK-CqTZPESfqKRBtl5jaHOX8BMcagpCxd_3c_I_PDsKkIA52kO0gIM51yCE
Message-ID: <CAD++jLmUiEAdjOCXorRXixy-SLeNsKp6VX-UrpyjCnetRSnguQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/9] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk, 
	luizluca@gmail.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:04=E2=80=AFAM Mieczyslaw Nalewaj <namiltd@yahoo.c=
om> wrote:

> On family D, RGMII on extension interface 1 needs two things that the
> other families do not: the EXT1 RGMII TX clock delay field in
> EXT_TXC_DLY (0x13f9, bits [5:3]) must be cleared, and the pin mux in
> the top-level configuration register must be set up.
>
> The vendor RGMII setup for EXT1 clears the RGMII field of EXT_TXC_DLY
> (0x13f9, bits [5:3]) in addition to programming TXDELAY in RGMXF.
> Do the same. The init jam table writes 0x0090 to this register, which
> leaves the field at 2, so without the clear an extra TX delay would be
> applied on top of tx-internal-delay-ps. Clearing it makes
> tx-internal-delay-ps the only source of TX delay.
>
> If the internal MAC4 block occupies extension 1, do not advertise RGMII
> for port 7 in phylink_get_caps(), so the configuration is refused before
> any EXT1 register is touched. This mirrors the vendor RTL8367D API, which
> returns an error for RGMII on port 7 when UTP port 4 uses the RGMII
> interface. Otherwise bind the RGMII/MII pins to MAC7. SerDes 1, which
> shares the pins, is always disabled.
>
> The family D branch is not reachable until the chip table entry is
> added in the last patch.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Looks good to me.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
