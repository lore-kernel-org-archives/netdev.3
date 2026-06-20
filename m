Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE73438B3
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948603; cv=pass; b=hPjK/nJgZ6sUPZRVcCOYCErqw8JERCCu5TP3UcX3N0BlZzEu4QwNZVHk8DUfeHq3DEsvr/3S5LBY91x3lIZrxLE+lB4j6J5Eg97jtm4fpWgE2abvEYXARFCFmiYCWf9xd2A5woyqmzA9FETTnXpCjjFVNxtonSW8ns/8LOnvz4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948603; c=relaxed/simple;
	bh=7rdueKN8ENX9sEUivck4EgtWXQBZ9u1EruECLPrTt1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1sualhUvIv+uIK0nWa94r54psy5/ICvY0XGPW/qEEi8oGHbv6XP1rrf0ZDOFBbYN4JuOtg9rLo/0UlOX6BXKEuv7GcB4LuBqDOeO+2sSnvHQfVhW+ebL+fz2RFyqNl8K4Q/R9h/NP7yf9BwDC0B1IOnaGikNTTBckb04vP60/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=excefrgb; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="excefrgb"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6ca94e539f9so1669761137.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781948601; cv=none;
        d=google.com; s=arc-20240605;
        b=fAnj/2hxzCcgz5OJDRh33bgBVxoo8UEwwcBPn6Li7jX+ft50LUKUzZ9Z61fT6a6E+A
         hVTUfEM3MhWBLc+Fp77Lrz+ab2Qp6aK5z9sCXW/WkatTpLedh3jJBBeeXf1CeVvXMCmb
         m5o1BTXScErzjvaYFFjrGkuwSeegaCfmgWkLxoK/KJvAlhmNqxGBMFVGVGkI0MCSjpQu
         ZZxOApjP9ZeOcEOtjCMb6Gmz3DCrPPXStvXy+MLQCnvhWgUFpuqezl+bee8WUEoFwgCy
         S9KEQzzKJ7O9YPBm4Hms/7XoHcRQhvUZWzbMahOHUNbtSMxzaHQFZ8dvtPb6989zZly7
         cPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7rdueKN8ENX9sEUivck4EgtWXQBZ9u1EruECLPrTt1A=;
        fh=/XMD1Hg5fg+cHovr6sP0BARg/LWilulwJx4Zuxe6YPc=;
        b=ZjrAWZ19bHyxGFeMrEosNX8P4hE9Kih2DW3UvChlfuShixoSxkgOpcIEBXTMWkgIFk
         +fdDJhkCQiZUn4TmAlLGlpPq3OQRkTrlmAQHV8jTM0lZJTKv6XvJGI0HNWTFBb6ZfOZE
         UjsTgjwAQ5Cy2AIrIys3bUm8fAHQX21rMjhyMYpAyecbqeyWnjBJNP9oFm0JH3CkACUm
         9KKsIGkPby7v/z3unRiecUiQ+FWFXbjohuexrEMYmUdMnUWrnNaeRyBWMl7QKXaPMcSa
         9IfWyzrqtSG8UDA5jj6oCSJ7FpgCPXLOuH0S3sBmUNqkQ8WXyEln2VdwkzL4I4InX/Yw
         KhFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948601; x=1782553401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7rdueKN8ENX9sEUivck4EgtWXQBZ9u1EruECLPrTt1A=;
        b=excefrgbbhUbJUzshQBq2xMFhkHjX3FmOFfzEe8MJZKldx0/taCZz1ZxsOdtA4M5Vt
         LCTSoeeYnE6xdVCOmOIB/Uzv5SSPqP1yiTX6bO+4rdsviEm585hjdOBHVcv5GVGD9b1J
         9RwCZwv1ezwrkJhXFwecVjsLuTSL2cRklDNIJInyEB+bzdU+E8QKCDDPysxR+RZpgqHz
         p/kPE3fK8ZhDnF+F17vOtlYYVAXiUOmdi58q9bzQJuAyfvcqkT0eJ3Gt5Wfrxkm5YkjH
         cD1s+Zf670ss3Y50cJPFjJ+ePTwOjIUB7SHExA7xSBsALdIGhv04wiK02+Cc948duOOf
         uTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948601; x=1782553401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rdueKN8ENX9sEUivck4EgtWXQBZ9u1EruECLPrTt1A=;
        b=RXeGKaPjsRUTz8k67nMGyRY+WsH+35YEWuUZNCbt3ufuZgTjlnNIeuX5HpYbr8xLoN
         MYtiElq+LNAYSQ32UwYiNFknnxbS1L+L7h8OLPDt1GgnyyycD8ijcDdvgfXKM5/44AWk
         JtYIsKZxr9Rd1L4I1gC5U+Ifnnc3TmUtXfbeEKW84ZIZ+vQxePcQtbp0YjdnX4EVJ65u
         W/sJkeL+pp1d6SotLZWn512GN/rszrQOcnUS6bCsaLdPtIg47Vctjwt8Q/YLxLPOIBW1
         9giNuCnrHZwdmSuWTLL5hagQRCCNmrFTiYU0CGpZqFmrE4wC/Bxq9QLQCx7O7bJpS8hB
         0f5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9aobqaMBmfmay6LcpjD/mtadDkgw7Qa3DY23rgfs0BomSA0wymBKYo0bTpbUK3YG87yrn53KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd87FMYc4I6eLcscQ0fEoCEKdICzGWPIOSR4sYcFPSIO2GvWwX
	Xk9mcRESKUr+9rnTX7TV6PETKl3e02Je/rnJMcKKbiJP2iqDFq15C1QizyXz7CRhdxYXdML1cIa
	EEPglRRFxPTNXGYPhI4BZ6+Ps5uK3KMc=
X-Gm-Gg: AfdE7clKP7KTSa/pz68Cfx2RbXevoPCm+PDWs62vBCTETKlMgHBLKcxnhtqbunkwu9S
	muN/92Ct9bBlKs99dfmKSKhwpPkCLosZB2cdygzrhrPgGm28S6UnjaT8n0B0ELTB+4vdMJZtpwg
	4padtNpTgvI5mCEarkP8FAtZ3szEOmWwJCW3IAFXYaM49KD7/cOhqZ0vxmwOV5gVsGZTFVih+iJ
	W21llfo3GYy3b+R2gCZBnU+3yENXBnk/pUO/Iz9dNAJDuDre5b5JRyLtMwhkV3gbUhw5qk=
X-Received: by 2002:a05:6102:f9c:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-72a03d9e389mr4462130137.20.1781948601248; Sat, 20 Jun 2026
 02:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620011956.37181-1-honza.klos@gmail.com> <008101dd0080$5feb6860$1fc23920$@gmx.de>
In-Reply-To: <008101dd0080$5feb6860$1fc23920$@gmx.de>
From: Jan Klos <honza.klos@gmail.com>
Date: Sat, 20 Jun 2026 11:43:09 +0200
X-Gm-Features: AVVi8CeMPoNY_qlQIvzeWJTayQdmhrKG1PbtCp0HoQl5cbN7DVAYFqHO9F8FoIU
Message-ID: <CAMm4rXKbCcPhsiL0FMQJ=SfdfA-7vu27D6cavjSngbgnY_hEdg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Golle <daniel@makrotopia.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Aleksander Jan Bajkowski <olek2@wp.pl>, Jan Hoffmann <jan@3e8.eu>, Issam Hamdi <ih@simonwunderlich.de>, 
	Chukun Pan <amadeus@jmu.edu.cn>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	ChunHao Lin <hau@realtek.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jun 2026 at 08:45, Markus Stockhausen
<markus.stockhausen@gmx.de> wrote:
>
> > Von: Jan Klos <honza.klos@gmail.com>
> > Gesendet: Samstag, 20. Juni 2026 03:20
> > Betreff: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G
> bit
> >
> > On RTL8127A connected to a link partner that advertises 10000baseT
> > speed cannot be changed to anything other than 10000baseT as 10GbE
> > is always advertised regardless of any setting. Fix this by
> > clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> > call to phy_modify_mmd_changed().
>
> As you are enhancing the mask, shouldn't this be "... by respecting ..."?
>
> Markus
>

I don't think so, in (__)phy_modify_mmd_changed() the mask is really used to
clear MMD register bits from old register value before setting new bits in set:
* @mask: bit mask of bits to clear
* @set: new value of bits set in mask to write to @regnum
*
* Unlocked helper function which allows a MMD register to be modified as
* new register value = (old register value & ~mask) | set
