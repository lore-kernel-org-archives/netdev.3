Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2DE2931F2
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728368; cv=none; b=Wle857B+TLHD7B/IxnBgvj5DPvT6CbW/+h1RJVz0qu2Nnu4qBNBXMNw/h5w6h5D3b7z0H6D05wPQkkad6Zpfe85F+9GmRbsa24hsraZcuvJOTYZ3ju2L42CmFE/fsMH4x4fx5S7uzp0UT2QXWJRgOFxZl+VPT1WhC8EDqQ4ZLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728368; c=relaxed/simple;
	bh=CHjKwfI1uTmV9nwmnXXgp5ahn1sTjNe6sjOhKGJye0s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jh+35GmuyPZLu52JgBp6ErpcprD8jn+/1tXl75ktG5Gx16FoNNbYMWobookKK4GKvsQsvDh/L0eYPXSagegFfuCpRaeceOOq333oGD8KHjsA5HQ7TxdDmIyic740eOz/8KYC5WH7EJ0VMtGYEzzPwvqi7K3qjJMUW1iGF+9NIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJbEtXoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJbEtXoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9338E1F0089B;
	Sun, 11 Oct 2026 14:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791728366;
	bh=6zqkZk+g5q4RbRRFuZ9M+HpR7P/0gOIBZ03DWDS5h64=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GJbEtXoclnVcRX4FST1ELi1YYFZkbBZbu5sHqGsqzHab1ahQ34/mMDzvv2ywm0Ywc
	 o5H/Lz1/2j5V7ZCS3yeADWQRjwxlT+Htx5f1StPv4CKjcfMmeA4y7KLOyOKTh+DkmR
	 AVzpbpvGSe5XtZ5LWnkVOPtXJEred24n55pnKskrbgs/cyV3l7cUxYv+vRL82jbqKX
	 MCA/dVnshHWtnIIFa9wbcPZiVSmrETMDoGIhGo87H/XMg6u0HhC0uZzR9RyG5qA7XR
	 9r7WnG5aJ5R9HQztmrrwnOGmBKOWD9X8UuwBEiHpYv3TexESTWfsuoCRHRDVfx6Yib
	 V/Lb+YxzYOmqQ==
Subject: Re: [PATCH net v2] net: dsa: microchip: fix KSZ8765 fiber detection
From: netdev-bot+sashiko@kernel.org
To: sebastien.royen@armadeus.com
Cc: woojung.huh@microchip.com, netdev@vger.kernel.org, nb@tipi-net.de,
 kuba@kernel.org
Date: Sun, 11 Oct 2026 14:19:26 +0000
Message-ID: <179172836607.434549.17102201654397350166@kernel.org>
In-Reply-To: <20261007080557.15719-1-sebastien.royen@armadeus.com>
References: <20261007080557.15719-1-sebastien.royen@armadeus.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message does not say what users actually see, and
  its Fixes: tag points at the wrong commit.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  ksz_switch_detect() (drivers/net/dsa/microchip/ksz_common.c:2931)…

--

net: dsa: microchip: fix KSZ8765 fiber detection

This commit changes KSZ8_PORT_STATUS_0 from 0x08 to 0x18. With that,
ksz_switch_detect() reads the Port 1 Status 0 register to check the Fiber
Mode bit that tells a KSZ8765 apart from a KSZ8795, instead of reading the
Global Control 6 MIB Control register.

> Fixes: 91a98917a883 ("net: dsa: microchip: move switch chip_id detection to ksz_common")

[Severity: Medium]

Is this the right commit for the Fixes: tag? 91a98917a883 seems to only
move the detection code into ksz_common. Before that commit,
ksz8_switch_detect() already did a global read of the same 0x08 offset:

drivers/net/dsa/microchip/ksz8795.c:ksz8_switch_detect() {
    ...
			id2 = 0x95;
			ksz_read8(dev, REG_PORT_STATUS_0, &val);
			if (val & PORT_FIBER_MODE)
				id2 = 0x65;
    ...
}

The wrong offset appears to come from 4b20a07e103f ("net: dsa: microchip:
ksz8795: add support for ksz88xx chips"). That commit replaced the
REG_PORT_1_STATUS_0 (0x18) read with REG_PORT_STATUS_0 (0x08), which is a
per-port offset.

Stable trees that have 4b20a07e103f but not 91a98917a883 (5.15.y, for
example) also have this bug. Tooling that follows the current tag would
skip them. Should the tag be this instead?

Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")

Could the commit message also describe what users see? With the old value,
bit 7 of REG_SW_CTRL_6 (SW_MIB_COUNTER_FLUSH) reads 0 after power-on. A
KSZ8765 is then detected as KSZ8795, and on a board using the
"microchip,ksz8765" compatible, ksz_check_device_id() fails the probe with
-ENODEV:

    Device tree specifies chip KSZ8765 but found KSZ8795, please fix it!

There is also a change in the other direction. Today, a KSZ8765 board
described as "microchip,ksz8795" probes. After this patch it would be
detected as KSZ8765 and fail with -ENODEV. No in-tree DTS uses either
compatible, but would it be worth mentioning this for backporters?

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index cbe98494578c3..f6104f714a8d1 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -853,7 +853,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
>  #define KSZ88_FAMILY_ID			0x88
>  #define KSZ8895_FAMILY_ID		0x95
>  
> -#define KSZ8_PORT_STATUS_0		0x08
> +#define KSZ8_PORT_STATUS_0		0x18

[Severity: Low]

This isn't a bug introduced by this patch, but the read in
ksz_switch_detect() that uses this register does not check its return
value:

drivers/net/dsa/microchip/ksz_common.c:ksz_switch_detect() {
    ...
			dev->chip_id = KSZ8795_CHIP_ID;

			ksz_read8(dev, KSZ8_PORT_STATUS_0, &val);
			if (val & KSZ8_PORT_FIBER_MODE)
				dev->chip_id = KSZ8765_CHIP_ID;
    ...
}

If regmap_read() fails, ksz_read8() logs an error but still copies its
uninitialized local into *val:

drivers/net/dsa/microchip/ksz_common.h:ksz_read8() {
	unsigned int value;
	int ret = regmap_read(ksz_regmap_8(dev), reg, &value);
    ...
	*val = value;
	return ret;
}

Could the fiber mode test then use uninitialized stack data to set
dev->chip_id? ksz_check_device_id() would catch any resulting mismatch.
However, the probe would then fail with -ENODEV and the misleading "please
fix it" message instead of returning the real I/O error.

The other register reads in ksz_switch_detect() check for errors. Now that
this read is meaningful, would it make sense to do the same here?

	ret = ksz_read8(dev, KSZ8_PORT_STATUS_0, &val);
	if (ret)
		return ret;

>  #define KSZ8_PORT_FIBER_MODE		BIT(7)
>  
>  #define SW_CHIP_ID_M			GENMASK(7, 4)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007080557.15719-1-sebastien.royen%40armadeus.com
