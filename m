Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE741441E
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232661; cv=none; b=WyZOUNYVsj1BfKj4mEin2wSm1hwYukTmYsjBy0853XF8y4C/px5G/gZUV0gZfsMwqNmkITaSsdgSvjOKyQk9txhzEikB37Om/aEJzg4AuaMVf2NpkDto47cb4KYSEH92ODmSRN/95xoP8LmlDJ56d4kLLLofUMMlawFLZnnyN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232661; c=relaxed/simple;
	bh=FdfaAL0trSoU1tq71ePewjKCGhNumJNlW4lMnJDUJrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/S5ZpKfbk9ONDEzltih7FD1y0CphZqZmoNqOKACkIIec6KRbC45xXGEWg7zv5xQIendD5/5sEpEBkqFp0WBPP71oW5E/ZsFYwt3T81MF8g6K9xbhB7Al90OP3KbpHf/bs3lthXq99vjj1FPzdIm4tM+aaBDLQ0bEiK2oEipRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb7so163524685a.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232657; x=1790837457;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYSLaHavJ4PglZOT+cFIpQNUnogOMDphRk0Ds36kk5w=;
        b=KmdtlnUM2fvQZlJiFVMkIRT6zkSDQX6TvbWBgnDHqKBiaOIIFLqou0YGQHS3tRlOrc
         S0+YNzEugmRYNjV6NfJZTE6J5oYw+N3F/GjiC5hR8ieQeDBEKzyl3BqBqmIvOKIOGFJN
         iIcNOvPMuluX0RY+/NuAmnoWPkPJj0CGQD0joQtt+Y0DKD6SVHPCRXneJq4eL6zwtY4C
         7+p8IPs8zrOAlpi8VT7dhiFxatHsnfqxpKLQcThZCxv5jZVi93Tdz1a2nsozjcQv9svR
         xqKJa0BR6E3y4wH4OFb5JYrcBmY7i0Np+DmpN7Li6bAENQoOGuBpEfDsVCfbxFUu7PBr
         5y7A==
X-Forwarded-Encrypted: i=1; AKwUvBz6Jb0yooo/E0yeVViPLahrRJpkcIhIEVvD0hjcpjyNBc9M2p1+twboh+ONW9Z1i0x1PX3AtYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mbW5wOnOgfkybzdIgFUa9oZuiLtpGWQnz4ncbZNmm3Iw7rMIMm
	qSNgt6xtx/ZjGGdyHF3iHf2zaB4ucmmKkPKB3VxsfC9ObWLdgaYjxdGkvRQCxSTa+ZI=
X-Gm-Gg: AYBFou3EiVb6NtaE6aeWzOUBV5Y4M4tB8cJMkMxoRzCE/jC1aF/Yl1fSUx3/PBNMQgd
	kzlVLMdJgo95akmO9lkTTLWD8OEkYxcD7WvK8AwebI476dLv+b4AINo7jLtUQWWinkau9bImrad
	32ZHgN/y2AFP8PB6/UlOQY0Sp6t6uxg9ZTkboYnIUV81C1hvzonfGJv9UgAB4PyVJS1PiQVTWqz
	+fwD/XlnzcbROgRNDqVKZ/nf4IeuqXaIGAyIm1b3rmL4NLVsK91jQQ5hrTF++IQhOcJSUfewRfn
	B7Eq3zOnKJpv+BuRxnce0yLhOoNzc/RS+hunVf5g/imR9ut0zsgxpqtaE1R5/0yQd/W1+vJNCpU
	os6nr926wMGShU7D25JLtWNATzTiLqb/DEYpDsqYasMauqrUK455wCPKAZJunWmCcHlzP1Mqt+V
	HKhCAiOF5P2nb9zUQ0YrgCtlyrJmKuLexUq2BCokqsCGpqAqMgSitNR1cB+76L/nppoSOo/vZ1k
	Iknnzj0/VfgRuwAkW2+xTdRRvzGIr59itccWzzeXrl7oQ6Q
X-Received: by 2002:a05:620a:25c7:b0:939:3a51:2490 with SMTP id af79cd13be357-93c362f28b9mr147810285a.15.1790232657160;
        Wed, 23 Sep 2026 23:50:57 -0700 (PDT)
Received: from mail-qv2-f37.google.com (mail-qv2-f37.google.com. [74.125.230.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c33e6e728sm122634085a.36.2026.09.23.23.50.56
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 23:50:56 -0700 (PDT)
Received: by mail-qv2-f37.google.com with SMTP id 6a1803df08f44-91235f46716so13139086d6.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:50:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZOPTTwmdBS74rjPbNn/BHY5iaCrqKCkNQVkEPPvDasxHOZyRAihPvQOUW7ZNILbDmiviI04Y=@vger.kernel.org
X-Received: by 2002:a05:6102:e0c:b0:7a7:a382:6bd7 with SMTP id
 ada2fe7eead31-7af1dadc05bmr812949137.27.1790232328063; Wed, 23 Sep 2026
 23:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
 <CAMuHMdXMjxgj+pT5A=jd_A5BVQctHXJqeiU4EhPA_ZSANZAAmQ@mail.gmail.com> <e166f6e2-05b3-4f36-a1c3-b75861618c75@pardini.net>
In-Reply-To: <e166f6e2-05b3-4f36-a1c3-b75861618c75@pardini.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2026 08:45:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+Dum1VaMOQx9aS_hBn1Bmq_mZ1qaH-WegK7Q=pEdmTA@mail.gmail.com>
X-Gm-Features: AclHuK8sCbd_Nwk8hcPDRDy2MSUfMylLVdDaP4Bmdtue73-db_SXAulz9teSuSc
Message-ID: <CAMuHMdU+Dum1VaMOQx9aS_hBn1Bmq_mZ1qaH-WegK7Q=pEdmTA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] describe RTL8125 PCIe NICs on Rockchip boards (and
 add DT binding)
To: Ricardo Pardini <ricardo@pardini.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Wed, 23 Sept 2026 at 20:49, Ricardo Pardini <ricardo@pardini.net> wrote:
> On 22/09/2026 11:17, Geert Uytterhoeven wrote:
> > On Thu, 10 Sept 2026 at 22:08, Ricardo Pardini via B4 Relay
> > <devnull+ricardo.pardini.net@kernel.org> wrote:
> >> Several Rockchip rk35xx boards carry on-board Realtek RTL8125 2.5GbE
> >> NICs whose PCI function nodes are not described in the DT. Describing
> >> them allows for stable ethernetN aliases (matching the GMAC alias
> >> convention on these boards) and lets U-Boot's fdt_fixup_ethernet()
> >> inject mac-address properties from its ethaddr/ethNaddr env, so MACs
> >> stay stable across boots and U-Boot and kernel MAC match.
> >>
> >> Tested on a NanoPC-T6: /sys/bus/pci/devices/0004:41:00.0/of_node ->
> >> /sys/firmware/devicetree/base/pcie@fe190000/pcie@0,0/ethernet@0,0 and
> >> u-boot correctly adds local-mac-address property there which is
> >> correctly picked up kernel-side:
> >
> > Have you tested this at 2.5Gbps? With which firmware?
> > I am asking because I have problems at 2.5Gbps using the firmware from
> > linux-firmware (on a different platform, though)
> > https://lore.kernel.org/CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF872=
0WUA@mail.gmail.com
>
> Hi Geert, yes, the RTL8125's on those boards work at 2.5gbps just fine
> (both with and without the fixed-function nodes in this series). They do
> get quite warm at 2.5gbps. I'm using one of those el-cheapo 8-port
> 2.5gbps switches.
>
> Currently:
>
> [    3.254450] r8169 0002:21:00.0 eth0: RTL8125B, 8e:b4:90:97:32:30, XID
> 641, IRQ 124
> ...
> [   10.480872] r8169 0002:21:00.0 end0: Link is Up - 2.5Gbps/Full - flow
> control rx/tx
>
> # sensors r8169_2_2100:00-mdio-0
> r8169_2_2100:00-mdio-0
> Adapter: MDIO adapter
> temp1:        +52.0=C2=B0C  (high =3D +120.0=C2=B0C)
>
> I'm using whatever is in Armbian's armbian-firmware package:
>
> # ethtool -i end0 | grep -i firmware
> firmware-version: rtl8125b-2_0.0.2 07/13/20

Thanks for checking!

Mine is RTL8125D XID 688, i.e. a different variant.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
