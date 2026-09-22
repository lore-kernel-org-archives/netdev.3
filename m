Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501C456DE2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068664; cv=none; b=NgsAp2CufZwTAZ5dt2yUHciHdZILVkTIVIuy2LwnGrWrar0QT6e28bybZ4JWwftD4dB4j0Y88KuSZ6K8CkiDlPJpfnR7eMI9aqJqrFzSRJLsY5XfJPSl7p8HpTY3p3h8eLIHbpfvGsnRSHUp+RJVsz8pldm4qBbx2t2PCTBJUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068664; c=relaxed/simple;
	bh=CZ3oPkSBqFVLdsQgqxzEWOijGFMKadDxp1f+3SNDcts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMW7IqJLZc2ltM7wVa/LczgI3ZcZ9702JQG9Y95oG+9vjJ3OoQuhnJ3HPiBtm/uehqkqweh+uCjNwY8hrzxpFBWhJmhc5DZH3a7Nu0sKPal+doNkpCzyZ7rPGn3BXlm6RE1WWl1DoiYo31F4tY9mfTqB0AHx5tiJsC9taB5VZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982dd15d169so2215870241.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068661; x=1790673461;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oT5SmnnEiCJkeSE3HgFIBSVwvA/3E4ZeuxsouiwktnY=;
        b=FFpcIFCvPIkvQjg8Cs3QmGkwdme3CPoGCMZgSnGfOnDTrcAkxPWHqe6KQ48JLN0iDk
         wfVnUf0eT3kwf4QMtfw7pvllIfltVYlNFSDi12KT0UPDsp7cC0qp+xbm4sLrYZqLMawz
         3AMAJCjfTXsD4g6fm0tIV1V1Et9Z/1yKT/VR0zd0YTZEAnIbW1GIv7jzyd3F8HFKqosW
         M6vWhO1dXeGCY55k8nV7/GncpqsUy/u/xwed6icY9i7xEGotkYZPj+AdogiF1HY1WOmW
         /xOV1+FDIkY5mhSOqBthwePjjFlQb3Rsirt8/lZbJjJYwWeAi+3I4y/KREQfwM65WDQa
         jwhw==
X-Forwarded-Encrypted: i=1; AKwUvBzVkxB56rMFsOiNEA+lu2ZHKVoeoFEzuGSFHhqSOyJSQ38M1uzQgC0i/22y9dkWCfQGDHbd9vs=@vger.kernel.org
X-Gm-Message-State: AFuF++mmK/KgklldvlIZWyCF9jgVCCkWNWWsq+Ip+E7LSBL6Njd7X9kl
	v4q+5s2HytHCBYCkWqsc+AzGp0J1Cf64M9XamOS0m0uUHNiFrDGMzOlJcTv48ndUBa4=
X-Gm-Gg: AYBFou16XgUgAFhp75lRjDPCmdbm8gHBiJTprQmLGsdpnSv6dZb/oOHOl4BXWgacoFW
	cJcXyQGfF9i7d/apnwvkIGXIW+J+0c66TINXDMttm12KYE5fWUSfjrf+dyDhUlzNoTFz0Y4jfAy
	CWprVK4ujKoNmiVlode5ONXwdTYiMMPb4WmtZLL+aXEd2qkDaMJMA2fTVnnG1c7dbm9UmVP0Xb1
	aVfcxrCd4d6/iIMOwjF3ymRgdNVWgioNQHX4+3oRvgwHrj1Zlbl6Qa4O5v0Bp7h+nZGQJyG2sg3
	maf7vGParmEvufN8U+C2xG0s4lGlP7aAybIX+YwOVYflBofjpl7IprxNX4VineKq0I/6NZg+beX
	LlOkwtdsPdYrHZt0gwQhF/AKRNWywfh+ftXDuDXMgq4YN95+azXG/bF3iSB0IA/dp772EgSS6wH
	C9unU8KvfMRnNTbdMEZpsrDIM7TF+Vxvv0a5OE/WUNfOoK+93eB5I2ynMYSSWreRaGaCTYmm24/
	q0m8jouKHKsKGRR+IAuKCcHVCHMcKJvGUA5avwee7q8Ss8=
X-Received: by 2002:a05:6102:148c:b0:7a7:198a:c2b5 with SMTP id ada2fe7eead31-7a7198ad369mr5340575137.29.1790068661135;
        Tue, 22 Sep 2026 02:17:41 -0700 (PDT)
Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com. [74.125.227.40])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ab17f3be4asm1076835137.8.2026.09.22.02.17.39
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:17:39 -0700 (PDT)
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a805351f5eso1225959137.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 02:17:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx9YmBGfyzWM2guw/fUqAHWWiF9mv5NIpc53yVIp++oQLZy7JQLscPuQqg5ngfH7hWINrzzel4=@vger.kernel.org
X-Received: by 2002:a05:6102:1492:b0:7a7:198a:c2b6 with SMTP id
 ada2fe7eead31-7a7198ad381mr4988859137.30.1790068658957; Tue, 22 Sep 2026
 02:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
In-Reply-To: <20260910-rk3588-dts-rtl-eth-describe-dt-alias-v5-0-c1b9e5f10cd6@pardini.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 11:17:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMjxgj+pT5A=jd_A5BVQctHXJqeiU4EhPA_ZSANZAAmQ@mail.gmail.com>
X-Gm-Features: AclHuK9pjyjJZh6DYzu8j0CaKCcKmJ8CfBcbQ8aIBw9Bf-OTlVvyy4dIW39Xywc
Message-ID: <CAMuHMdXMjxgj+pT5A=jd_A5BVQctHXJqeiU4EhPA_ZSANZAAmQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] describe RTL8125 PCIe NICs on Rockchip boards (and
 add DT binding)
To: ricardo@pardini.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Ricardo,

On Thu, 10 Sept 2026 at 22:08, Ricardo Pardini via B4 Relay
<devnull+ricardo.pardini.net@kernel.org> wrote:
> Several Rockchip rk35xx boards carry on-board Realtek RTL8125 2.5GbE
> NICs whose PCI function nodes are not described in the DT. Describing
> them allows for stable ethernetN aliases (matching the GMAC alias
> convention on these boards) and lets U-Boot's fdt_fixup_ethernet()
> inject mac-address properties from its ethaddr/ethNaddr env, so MACs
> stay stable across boots and U-Boot and kernel MAC match.
>
> Tested on a NanoPC-T6: /sys/bus/pci/devices/0004:41:00.0/of_node ->
> /sys/firmware/devicetree/base/pcie@fe190000/pcie@0,0/ethernet@0,0 and
> u-boot correctly adds local-mac-address property there which is
> correctly picked up kernel-side:

Have you tested this at 2.5Gbps? With which firmware?
I am asking because I have problems at 2.5Gbps using the firmware from
linux-firmware (on a different platform, though)
https://lore.kernel.org/CAMuHMdXPAeHoeaQbM9rXbXukoMbFV+0k28n6sRMw8XF8720WUA@mail.gmail.com

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
