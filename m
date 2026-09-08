Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C74B0483
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857573; cv=none; b=G9LRvqz0QyQWr73czX+jqaGgjP3O0tTTDPN6EEN7sTeWSB41NYojsdZZiKm+kQgx7hAPIECpS7F4CLD4HZNxDaXIbl2ZuaIg7Plg7ebL0KBtHA20jO8aAS3KgSsXM1F9G7Ztvjqs7QHxobIhXTrniPq2AnnmwsZ1MzKC8QCBMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857573; c=relaxed/simple;
	bh=je+F0OPWeTZLgdJRJufyWIP+kwQe++5kqut9YBkrXVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ot75UmdUjEk+DhKr76BqdIyA1RCADN1N4+9jzvgCcxWsq4wQrw1XyPx/t27vp0z98/k31TM5MI+/GkP5VDlVcyldI+HuyWknbE0dUHxw9PI7p96iVzNdMCGdXjKcUwd2FhJl3QDFtoPOplDRzdAnDN4qlBXtBa8chHgGz2BgeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5k5/0p2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5k5/0p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCD1F00A3A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857556;
	bh=3W4oOrZck+N1ptGY2moPSlp11dOJcmwzEUDKOztwOHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N5k5/0p2shm2MZCybuh/C0nfPum5JdsOxFVEwkZs4ux6K21wfSD6atSXWHng/4NuP
	 xa7CKijYwIQR94Qm49dEYJXbYnI5fGW0nXYGJSPh64YbPJr2YceW9lh2Ts/2cmpuw7
	 Xusl4WjXeDLcxe3hYriKRBkOErLozYwayWiDgfXCrubwF+pGa7+kSpIua5Z5qi7Ej4
	 Rx1GvH+N24WdW5Ri4UJa6c63Qvxn/b2KCCNgjZ2U6swJ4MaB6YEfSZOt9gUQElZ+8P
	 +wIUpunu57d0D27b8cFbtNd7r8Ve74ozGkCsVhY7lRTpiPg7Vn8dS+8p5FbI3jZAU3
	 kZj9aiG+hOgKw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b5e5ab03afso3580553e87.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 01:52:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzPc6ST8F0OOzmHHiwWncX/9R54IxWi9rv+HfgO1rz6MLq/LdftM32+q1zBR8dZRchYW+ZivE4=@vger.kernel.org
X-Gm-Message-State: AFuF++kq8xjmh7HnLvGsnOK7IXhl+8nJv4jrh75cTLxT4FJnWnI22BHo
	Lh7FW8Zw8BmzVacBImkLDhcQ39NUy+AP5NsqvSL9qlxSF1fguR/0kvBex1as+6k/MWEUtd/QRns
	ftWLjFMDPVoCeSlnfwwKV32wN8/m28jY=
X-Received: by 2002:a05:6512:108e:b0:5b5:e517:9cb9 with SMTP id
 2adb3069b0e04-5b616f15c32mr4513436e87.11.1788857552575; Tue, 08 Sep 2026
 01:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-ks8995-to-ksz8-v9-3-8d8815a91bd8@kernel.org> <178883938573.219967.4602720623318150522@kernel.org>
In-Reply-To: <178883938573.219967.4602720623318150522@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 8 Sep 2026 10:52:19 +0200
X-Gmail-Original-Message-ID: <CAD++jL=Dz1vtyH=0Zm6EE6zxj8TV1avNW9PSVE8voFmRhd=fMg@mail.gmail.com>
X-Gm-Features: AcwNN1XD2YrjahEhw2Vin4QwxDua85jBaifRMSNbHO2gd8mgyUN2y_LDN5Tr_Jk
Message-ID: <CAD++jL=Dz1vtyH=0Zm6EE6zxj8TV1avNW9PSVE8voFmRhd=fMg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi netdev-Sashiko,

new stuff every day! I like it :D

On Tue, Sep 8, 2026 at 5:49=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:

> [Severity: Low]
> This isn't a bug, but should this loop use dev->phy_port_cnt rather than
> dev->info->port_cnt?

Actually no. The boot loaders reset also the CPU port.

> [Severity: Medium]
> The commit message says:
>
>   "Notice: there are also KSZ8995E and KSZ8995MA. These are BOTH
>    different from the KSZ8995XA."
>
> Given that, is it safe for family 0x95 with chip ID nibble 0x0 to be
> mapped unconditionally to KSZ8995XA_CHIP_ID here?

Actually yes, all known users are the XA variant.

Whenever/if an MA user appear, we will deal with that then.
We have no hardware to test this as things are today.

> Two in-tree device trees use the generic string today,
> arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts and
> intel-ixp42x-actiontec-mi424wr.dtsi, so if MA behaves differently in
> special-tag mode those boards would lose CPU-port traffic.

Those in-tree users are the XA variant, so this is a non-issue.

> [Severity: Low]
> Should the three Micrel strings also be added to the compatible enum in
> Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml?

No. Device tree bindings are OS-neutral and do not change
because of Linux internal driver changes.

I will address the rest in v10.

Yours,
Linus Walleij
