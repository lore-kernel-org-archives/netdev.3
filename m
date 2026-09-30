Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101951EE04;
	Wed, 30 Sep 2026 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803086; cv=none; b=XJU+HXXpn3Smlj8uAD6Et3DRTn4QDe4EmZfnBPt2LYUKwQsZEE5tTIacv8mceCHQCHf4SUA047iUITRULeZIxEnoYyYLni4bTk4QHNu9XCCh9SwcrUG/yBWzlK1+lIUSKg8gnjAehJZvSoshhe5ji3GxE2ECHZUAe5WevnJnVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803086; c=relaxed/simple;
	bh=PocxCH7n8eT26BhpwpWeCdgHkdK9HXheW7mnulJ9Cms=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkb5Yr18Zh0WLPDmFmMPkXbDdmEtlDuch28uC+B8z0WxjdQx+EvhCnRs4MdVXcj042D48vGPQnPz7m2hcBFRPqwVQbIn753ShqhI66RCDSpi+SrbpeMr+GkI7Lr8Nw3Y/26Oze7NYRRlptdy2lYjP1b864SLWyqbtlkhYXDd+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1/dk5t7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1/dk5t7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598621F000FF;
	Wed, 30 Sep 2026 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803085;
	bh=dKcJ/uGZDLC47eCjq9sqq21cqXPs4Vk25TGw1UWT/xI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o1/dk5t7RHSLvB8zCkcWipv35aTaUk3JQhApHI0J02aje7bTgQYj7kP+CTEGF8Bf2
	 CTrcVxNhrGacUPReFdfCDWshdSYEIYpNuaU3n5d5r02ff4y2Z5r2AicHl2qOOU4ZYv
	 wGLjP1T/1lPw43UEPrACVj8uQ8/1YQ6/wYm0XCPZ7Ff4sdCqldxgF6G8H4va9NbVLJ
	 cubYbBlfvYc/A3yJyxhDnB+PL38CLvbms8eiRNHSt3wKmDVG6VAYJXRnDd6LOM67hl
	 MkDCW4AWZmMgMOaSeKed7ON2AEhaxReYAkAAv6kOCjKOVyqyAxRYqH1DvWDpxI4kE5
	 q9ENe9IfeJkqA==
Subject: Re: [PATCH 5/5] net: ftgmac100: Allow building on ARM64
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ratbert@faraday-tech.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 21:18:03 +0000
Message-ID: <179080308391.434549.8867972525180892643@kernel.org>
In-Reply-To: <20260927-support_ast2700-v1-5-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-5-9f03f29d2c82@aspeedtech.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the FTGMAC100 Kconfig entry
  (drivers/net/ethernet/faraday/Kconfig, line 34), the new condition…

--

net: ftgmac100: Allow building on ARM64

This commit lets the Faraday vendor menu and the FTGMAC100 driver be
selected on ARM64 so AST2700 platforms can use the MAC. It also removes
the !64BIT || BROKEN dependency. The select of MDIO_ASPEED is widened
from MACH_ASPEED_G6 to MACH_ASPEED_G6 || ARCH_ASPEED.

> diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
> index 474073c7f94d7..dea6dcfc9ab57 100644
> --- a/drivers/net/ethernet/faraday/Kconfig
> +++ b/drivers/net/ethernet/faraday/Kconfig

[ ... ]

> @@ -28,11 +28,10 @@ config FTMAC100
>  
>  config FTGMAC100
>  	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
> -	depends on ARM || COMPILE_TEST
> -	depends on !64BIT || BROKEN
> +	depends on ARM || ARM64 || COMPILE_TEST
>  	select PHYLIB
>  	select FIXED_PHY
> -	select MDIO_ASPEED if MACH_ASPEED_G6
> +	select MDIO_ASPEED if MACH_ASPEED_G6 || ARCH_ASPEED

[Severity: Medium]

Does this select now cover every 32-bit Aspeed generation, not only the
newer SoCs?

On ARM32, arch/arm/mach-aspeed/Kconfig puts all generations under
ARCH_ASPEED:

menuconfig ARCH_ASPEED
	bool "Aspeed BMC architectures"
	...
if ARCH_ASPEED

config MACH_ASPEED_G4
...
config MACH_ASPEED_G5
...
config MACH_ASPEED_G6
...
endif

So MACH_ASPEED_G6 already implies ARCH_ASPEED, and the condition becomes
"if ARCH_ASPEED". The MACH_ASPEED_G6 term has no effect, and MDIO_ASPEED
is now forced on in AST2400/AST2500-only kernels.

Two in-tree configs change this way. aspeed_g4_defconfig has
CONFIG_MACH_ASPEED_G4=y and CONFIG_FTGMAC100=y with no G6, so it now gets
MDIO_ASPEED=y. multi_v5_defconfig (MACH_ASPEED_G4=y, FTGMAC100=m) now
gets MDIO_ASPEED=m. Neither had MDIO_ASPEED before. Also,
mdio-aspeed.c only matches "aspeed,ast2600-mdio", so those kernels build
a driver that never binds.

The MDIO_ASPEED help text in drivers/net/mdio/Kconfig says:

	  AST2500, embedded in the MAC. For legacy reasons, FTGMAC100 driver
	  continues to drive the embedded MDIO controller for the AST2400 and
	  AST2500 SoCs, so say N if AST2600 support is not required.

With this select, users can no longer choose N on those platforms. The
help text also still does not mention AST2700.

The commit message says:

    Keep selecting the Aspeed MDIO controller for MACH_ASPEED_G6 and also
    select it for ARCH_ASPEED. This preserves the existing AST2600
    dependency while covering newer Aspeed SoCs that use the common ARCH
    symbol.

It does not say that older 32-bit AST2400/AST2500 configs are affected
too.

Would a narrower condition keep the old ARM32 behaviour? For example:

	select MDIO_ASPEED if MACH_ASPEED_G6 || (ARM64 && ARCH_ASPEED)

If the wider scope is intended, could the redundant MACH_ASPEED_G6 term
be dropped, and the commit message and MDIO_ASPEED help text updated to
match?

>  	select CRC32
>  	help
>  	  This driver supports the FTGMAC100 Gigabit Ethernet controller

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927-support_ast2700-v1-0-9f03f29d2c82%40aspeedtech.com
