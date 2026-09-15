Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924B4CDA34;
	Tue, 15 Sep 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515412; cv=none; b=lFqMA2e/6++dgk3qNiB5DEjnadEPVgX5fFovbspfkdNCjkCtAX0fvIXlZvSAcH8CUrfdGYaB0k2oMnI7aKf3MHK2P9C2Nrvf3NEYoNkgQnHtRWyLrHDKVOtPOnYglQ5lOPgHdZVSUCc1St9+gGnHTE/CdvAFRIWUUzcEyzmkNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515412; c=relaxed/simple;
	bh=OQrf53KQpUhTMb4CkVOjUhnXsV6OmtEr7b24QH352YQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OW6+jofTwBPd2KIJGOaEMUFx8var6B0634Qs8evRK7Bc+wZgMWJjlJDJUbBlv0IXTNIAvebT9o5Z5OHhno+bkBUa4ECIk6jOvSywhL4gz81Bq3uku62PwmauKejbzmboR9kFuyA6eRaqqvJphg7ZOACPQkm0CLRcxD4UwdAF7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9HPKdH5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9HPKdH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C281F00899;
	Tue, 15 Sep 2026 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515411;
	bh=07tPgzkP6B9ABg+BjPCoDbknGwY1QFJVN0ON8t73FQU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W9HPKdH5Uc5chdpaTacotnE+EqPVte4N9wvNCRNqB540WlY1KcUAGK1VmuxlkNwnt
	 A2fIKfERgLbBwv900zoioxM/LxdFynDTTorZ675HfV5Cucg7flqRTGq35otSRWGoIt
	 8K7/rv/LjsmyXMuLazT87wvtx9q1fR1DSpzthXhAhW1CFUmNLEd9t2pMyX96tk4U5Q
	 oBqrbju/DXz5oitjhGk2sQaxLZzaJfazRlUHOKxOfmVTRYFCYb53hCHpfbp/ZM5i5i
	 X5/WdOZS+NjB8sLLPrgLiL+fQv04Dl7vbqTGnd3hDYIu5ggwfL/CGlz8dCQqn4JweN
	 e3e0EGgjleESQ==
Subject: Re: [PATCH net-next v14 4/4] net: dsa: ks8995: Delete surplus driver
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 15 Sep 2026 23:36:50 +0000
Message-ID: <178951541000.22033.15668216277840535626@kernel.org>
In-Reply-To: <20260914-ks8995-to-ksz8-v14-4-3d72692b3c97@kernel.org>
References: <20260914-ks8995-to-ksz8-v14-4-3d72692b3c97@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml
  survives the deletion of drivers/net/dsa/ks8995.c and remains the ONLY…

--

net: dsa: ks8995: Delete surplus driver

This removes drivers/net/dsa/ks8995.c, drops the Makefile entry, and turns
NET_DSA_KS8995 into a transitional Kconfig stub that selects the Microchip
KSZ SPI driver instead.

> diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
> index df849cd0e640e..7e637d56b35c8 100644
> --- a/drivers/net/dsa/Makefile
> +++ b/drivers/net/dsa/Makefile
> @@ -2,7 +2,6 @@
>  obj-$(CONFIG_NET_DSA_BCM_SF2)	+= bcm-sf2.o
>  bcm-sf2-objs			:= bcm_sf2.o bcm_sf2_cfp.o
>  obj-$(CONFIG_NET_DSA_LOOP)	+= dsa_loop.o
> -obj-$(CONFIG_NET_DSA_KS8995) 	+= ks8995.o
>  obj-$(CONFIG_NET_DSA_MT7530)	+= mt7530.o
>  obj-$(CONFIG_NET_DSA_MT7530_MDIO) += mt7530-mdio.o
>  obj-$(CONFIG_NET_DSA_MT7530_MMIO) += mt7530-mmio.o

> diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
> deleted file mode 100644
> index 77d8b842693c1..0000000000000
> --- a/drivers/net/dsa/ks8995.c
> +++ /dev/null
> @@ -1,857 +0,0 @@

[Severity: Low]
Should Documentation/devicetree/bindings/net/dsa/micrel,ks8995.yaml go away
with the driver, or be folded into microchip,ksz.yaml?

After this patch that schema is the only binding documenting
"micrel,ks8995", "micrel,ksz8795" and "micrel,ksz8864", while the only
remaining implementation of those strings is ksz_dt_ids[] in
drivers/net/dsa/microchip/ksz_spi.c:

	{ .compatible = "micrel,ksz8864", .data = &ksz_switch_chips[KSZ8864] },
	{ .compatible = "micrel,ksz8795", .data = &ksz_switch_chips[KSZ8795] },
	{ .compatible = "micrel,ks8995",  .data = &ksz_switch_chips[KSZ8995XA] },

The two schemas then disagree on the legal property set for the same
silicon and the same driver. micrel,ks8995.yaml allows only compatible,
reg and reset-gpios, plus dsa.yaml#/$defs/ethernet-ports and
spi-peripheral-props, and ends with:

	unevaluatedProperties: false

while microchip,ksz.yaml additionally documents pinctrl-names (including
the "reset" strap state), wakeup-source, interrupts, the microchip,*
properties and an mdio child node.

Does this mean a device tree that uses a micrel,* compatible together with,
say, interrupts or microchip,synclko-125 will probe and work through
ksz_spi.c but fail make dt_binding_check?

The description in micrel,ks8995.yaml also still describes the deleted
driver's model:

	The chip itself is managed over SPI, but all the PHYs need to be
	accessed from an external MDIO channel.

which does not match the KSZ driver's handling of these ports as internal
PHYs. The two in-tree nodes named in the commit message,
arch/arm/boot/dts/intel/ixp/intel-ixp42x-linksys-wrv54g.dts and
intel-ixp42x-actiontec-mi424wr.dtsi, are therefore validated against a
schema written for a driver that no longer exists.

Would it be cleaner to add the three legacy micrel compatibles to
microchip,ksz.yaml as deprecated aliases and delete micrel,ks8995.yaml in
this patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ks8995-to-ksz8-v14-0-3d72692b3c97%40kernel.org
