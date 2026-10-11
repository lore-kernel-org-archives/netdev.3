Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190D459ACC;
	Sun, 11 Oct 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748285; cv=none; b=gW4Kc1MrobtdebrkVdwHzwA23l10UFSuffLV/Yf1Nw+bl3cx3cs9DrLlRa/GiqD//FqmBANFLtV/MTNCApn1jHBvSScx6HRn2tbvd6Aa08dMTMIdmroIs6Uxk6v4AvXs5Zav1GAZmOIJjgp8BS18Xjp/4cwvON78dp3Y1oK4VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748285; c=relaxed/simple;
	bh=BWutdyMamCdVwm9Qn+yPcllLirhxCgPb1JN/Csi6xKc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKTSw7EwDDhMCdkoum3MWq3u45c8o2SFLfsB87658mFC90QzenCGc3uJtTmdUL/C0/lCXdZAZW+YWW3C1TCTIrzBgMSdc46QHYgNaPxYplDiB7h5wx0+92MTRA/7I2neM90AGk7vU44DTI22thy5PUehOxfZO6DYTJPdwNvpvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJe5A3Mb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJe5A3Mb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16A51F0089B;
	Sun, 11 Oct 2026 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748282;
	bh=sB/L71YF/xgJPQ05BSjIj0+rUGLcR/3lUeJcWhL7P88=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EJe5A3Mb5qf6tZcdElRFAWdb5gkjJdOu6FB3L2k/hRv73EEbPgm4Esgprr4nRMTaV
	 YFdDFhE2kT8Xj0Zq4V+6oBO4so6lrRGTcLUOEFjvo4gyK8Ci9wJIa/ye3TAoS+fhlc
	 9KPJ2MQ0cgSnoRXcEJrYLYwP7vjF35qfQcJnXa5cdbaighdNRhXQV57W+obEy1FdIz
	 hkm/XTn4G4b0kaKBUFvFaaoyIVRaUh9LR+8reC+P4mxrhDOwmioUeaMscsPP2ERtdl
	 6pwC/PeXkqc4PT5RUvsYnz5CCkdZT+Q/FFfnIz8OyCXYPF2XOo3fHI9ES2PrcAa2qW
	 azKiKx0DW45hw==
Subject:
 Re: [PATCH net-next v3 1/9] dt-bindings: net: dsa: realtek: add RTL8367S-VB
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:21 +0000
Message-ID: <179174828124.434549.16134018214912356302@kernel.org>
In-Reply-To: <e3f96c51-f454-4544-881e-80a02f9ae9f8@yahoo.com>
References: <e3f96c51-f454-4544-881e-80a02f9ae9f8@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch adds RTL8367S-VB to the list of models under the
  realtek,rtl8365mb compatible in…

--

dt-bindings: net: dsa: realtek: add RTL8367S-VB

This patch adds RTL8367S-VB to the list of models in the description of
the realtek,rtl8365mb compatible in the realtek DSA binding. Only the
description text changes. The schema constraints stay the same.

> The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver.

[Severity: Low]
Is this statement accurate at this point in the series?

At this commit, every entry in rtl8365mb_chip_infos[] uses chip_id 0x6367.
rtl8365mb_detect() also needs an exact match:

drivers/net/dsa/realtek/rtl8365mb_main.c:rtl8365mb_detect() {
    ...
	if (ci->chip_id == chip_id && ci->chip_ver == chip_ver) {
    ...
	if (!mb->chip_info) {
		dev_err(priv->dev, "unrecognized switch (id=0x%04x, ver=0x%04x)", chip_id, chip_ver);
		return -ENODEV;
	}
    ...
}

So a switch with chip ID 0x6642 still fails to probe with -ENODEV until a
later patch in the series, "net: dsa: realtek: rtl8365mb: add support for
RTL8367S-VB", adds the table entry:

	.name = "RTL8367S-VB",
	.chip_id = 0x6642,
	.chip_ver = 0x0010,
	.family = RTL8365MB_FAMILY_D,

With the whole series applied, the binding text and the driver agree, and
nothing regresses at runtime. Could the commit message say that this series
adds the support, rather than describing it as already present?

> Like the other models in the family, it is identified by its chip ID
> register, so it does not need a compatible string of its own.

A small wording point too. Later in the series, rtl8365mb_main.c gets this
header comment:

 * The RTL8367S-VB (chip ID 0x6642) is not part of the family listed above. It
 * belongs to a newer generation, which this driver calls family D.

Should "the other models in the family" be reworded to match that comment?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com
