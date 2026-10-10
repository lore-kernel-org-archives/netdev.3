Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35154BD363;
	Sat, 10 Oct 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661217; cv=none; b=FzLYPtA3NxBIp1uLiGxAMc6Neg43kVVt11PvvyCchrzAhzxZGjhP4c6kagacdGwc9ZjcFOQbZuZfnUwDGETzzv3e6rQa/mgjuN53k3u4GM2GcFdLxOaYXSuWk9pOBKFVQCbZJ4vr3hsM7MMBuKNmwmo+3L/VOBJ5a+Gl5iBWajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661217; c=relaxed/simple;
	bh=nv2tocSlpYGtnHFuL673b6JquwYesAJKQf4bvqmTL4w=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcH9an0EPG27SCnM6FWkbUcSfgQY824jGi6cuGT/iryyAa1BHIrHpx5AhxbRCGTnMYh4Q4u74CW5tZMl3PcojOU7DaAazWl6T1u/VJQAhbxEqPv2b8HNf0YbhRKYKluWzN0P+Fl1ArJuFahaRKXsMVCd1p6hhjJNJxctX9RH12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL5Hd9aF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL5Hd9aF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82F91F00893;
	Sat, 10 Oct 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661213;
	bh=8V4+4hZdwtqnR1ZUsdI2kqMyO5eC8bR6rdfVX9L2Ph0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QL5Hd9aFdrxwjkLCggoJcfP0Wpb9nnRn/qg3r8cM7ZWLb4mDrl8STHv8PhU0TzWVM
	 ddqJO5XJyqdPQJ5RH0CsSBhn1j2JwMnEkMojRQwqJWrd1UsxETTHvmFWvJKf6mM7y4
	 ivrhxqCWjYgYxrG0fcLlAkxZ5+AKHExxkOW8t7q/aL6jjFa9ew6s94iX447GyE8QGr
	 6zJ3pf8VENcMCHo/QgWe7DOblFkJJBZh8RgpoEcgHBt49vFtApnO3zG8C4e6RP7pUI
	 1sfXzc4hzGu5JLGk21D5KJnucD3zMqjzz+A5TirxvV1GTd3lBTiKSj90+Q8D1R7Pwl
	 ihr2rMeTYu8HA==
Subject: Re: [PATCH net-next v9 03/11] net: ethernet: oa_tc6: Move oa_tc6.c to
 its own directory
From: netdev-bot+sashiko@kernel.org
To: Selvamani.Rajagopal@onsemi.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 parthiban.veerasooran@microchip.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, richardcochran@gmail.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 edumazet@kernel.org, piergiorgio.beruto@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, jerry.ray@microchip.com, ciprian.regus@analog.com
Date: Sat, 10 Oct 2026 19:40:11 +0000
Message-ID: <179166121127.434549.2014178695820662916@kernel.org>
In-Reply-To: <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
References: <20261009-s2500-mac-phy-support-v9-3-dcefe1d0bf0d@onsemi.com>
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

- [Medium] The commit message presents this as a pure file move ("Move
  oa_tc6.c to its own directory", similarity index 100%), but the patch…

--

net: ethernet: oa_tc6: Move oa_tc6.c to its own directory

This patch moves drivers/net/ethernet/oa_tc6.c into a new
drivers/net/ethernet/oa_tc6/ directory, which gets its own Kconfig and
Makefile. It prepares for the hardware timestamping and PTP files that
come later in the series.

> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index a306dae23bcb8..e0e86c249e425 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile

[ ... ]

> @@ -105,5 +106,4 @@ obj-$(CONFIG_NET_VENDOR_XILINX) += xilinx/
>  obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
>  obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
>  obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
> -obj-$(CONFIG_OA_TC6) += oa_tc6.o
>  obj-$(CONFIG_NET_VENDOR_ZTE) += zte/

[ ... ]

> diff --git a/drivers/net/ethernet/oa_tc6/Makefile b/drivers/net/ethernet/oa_tc6/Makefile
> new file mode 100644
> index 0000000000000..f24aae852ef27
> --- /dev/null
> +++ b/drivers/net/ethernet/oa_tc6/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for OA TC6 10BASE-T1x MAC-PHY
> +#
> +
> +obj-$(CONFIG_OA_TC6) := oa_tc6_mod.o
> +oa_tc6_mod-objs := oa_tc6.o

[Severity: Medium]
Does this change the name of the module? Before this patch, the parent
Makefile had:

  obj-$(CONFIG_OA_TC6) += oa_tc6.o

That built oa_tc6.ko. With the composite target here, CONFIG_OA_TC6=m
builds oa_tc6_mod.ko instead, and KBUILD_MODNAME becomes "oa_tc6_mod".

The subject says "Move oa_tc6.c to its own directory", and the file
rename shows similarity index 100%. Neither the commit message nor the
changelog mentions the module rename, and nothing else in the tree uses
the new name.

Anything that refers to the module by name would stop matching. That
includes "modprobe oa_tc6" and "rmmod oa_tc6", modprobe.d blacklist or
options entries, /sys/module/oa_tc6, and module lists in initramfs or
packaging. Dependent drivers like lan865x still load it automatically,
because depmod resolves the dependency through exported symbols.

The new name also stays in place at the end of the series:

  oa_tc6_mod-objs := oa_tc6.o oa_tc6_ptp.o oa_tc6_tstamp.o

Is the rename needed? kbuild only rejects a composite module that has the
same name as one of its own objects.

At this commit there is only one object, so a plain
"obj-$(CONFIG_OA_TC6) += oa_tc6.o" in the subdirectory would keep
oa_tc6.ko.

After the other files are added, renaming the source file would also keep
the old module name. For example, oa_tc6.c could become oa_tc6_core.c,
with:

  oa_tc6-y := oa_tc6_core.o oa_tc6_ptp.o oa_tc6_tstamp.o

If the rename is intended, could the commit message say so?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d%40onsemi.com
