Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAD3A4F59;
	Tue, 13 Oct 2026 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853712; cv=none; b=PPYV1/1dgfa7R7ybPPBwZMo35ZFUERUrKPESI+btgr/mkbuoGLrW3ZGEM+pqe7P1om2Vsml4o2RnAmAZZmCrncGduGApWQGqDKf9/DxKtFxj2X4aBuqP+ITiKdV1HXBmmWDRDiUWuBzZiUOkQNSuhXkdXYBcK+o3zNvJ3PXhDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853712; c=relaxed/simple;
	bh=gxjU/RnF0q3ICy1bTrxkSG4Q5ildQjm/HjTjw8/QTdI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M26a0+JAb8Ft0OpMAod8pN4xMoT58Yvs7nWCM1xxu2cglTqyfmN8pom4V3aJfQAWGCAC3haA3w7KEi2PYguZAtCwtzOXXz1XrNmbfZ+weBOn8tt6H91jKnVL9l5r3JKLduX+WtC2dCeLlLDy5Ylwqsm3hMEcfW2ZIna1FcBkbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOz0RqKX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOz0RqKX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17F51F0089B;
	Tue, 13 Oct 2026 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791853711;
	bh=bHuMvOZYevM2t7cStzoFw2qPkoYHwdIC/BbBUiGqwag=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nOz0RqKXrqpFklEXlDWHwYtKYlJc4D5RyJc/39zeMZzkzMvbR9UoKp5X2GUBolzIk
	 5GGTythflUcazjVsXsEJY2Pi7urUPHHwxLOlk7tfljYuk/zBKGj4XviEmcIZqyY/kL
	 kBTPHcKr7AznoDNv2OPI3bdOSIl8TEdJI11k2vRjKFILvfEmQl0y+RQyP6T4SLDc9j
	 AlGbqTTzh6n4rJ+r3K/47vc/1sqo56ykqgmkhjcKe3Y9fAtQLYoDVC54w8pHq48NG6
	 5HxbKCx0sfmpz5QpORCHd7Kuk91pQwfxeM3Eqpjdw6O4AuXTYCk3znYR4fB7UfBkES
	 +ijRCcMnZVSKg==
Subject: Re: [PATCH net-next v4 5/9] net: dsa: realtek: rtl8365mb: set and get
 vlan 4k for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 01:08:30 +0000
Message-ID: <179185371034.434549.16480732640712379008@kernel.org>
In-Reply-To: <41c9a735-0688-4932-b0b2-5c41ecbc6699@yahoo.com>
References: <41c9a735-0688-4932-b0b2-5c41ecbc6699@yahoo.com>
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

- [Low] Commit message wording (rejected by baseline, kept only because
  requires_validation=true).

--

net: dsa: realtek: rtl8365mb: set and get vlan 4k for family D

The commit gives family D its own two-word CVLAN (VLAN4k) table layout
in rtl8365mb_vlan_4k_read() and rtl8365mb_vlan_4k_write(). It narrows
FID to 2 bits and drops the priority/meter fields. It also forces both
the IVL_EN and SVLAN_CHK_IVL_SVL bits to 1 on write.

> Reusing the three-word family C layout unconditionally means the third
> word is read from and written back to the register that holds it on
> family C, but does not exist as a distinct table word on family D's
> die; whatever data happens to be there gets folded into member/untag
> bits [10:8] on read, and re-written on every read-modify-write cycle
> in rtl8365mb_vlan_4k_port_set(). Give family D its own two-word
> pack/unpack instead.

[Severity: Low]
This isn't a bug, but could this paragraph say that the new path can't
run yet at this commit?

Every entry in rtl8365mb_chip_infos is still tagged RTL8365MB_FAMILY_C,
and rtl8365mb_detect() only matches entries in that table. So
rtl8365mb_get_family() never returns RTL8365MB_FAMILY_D here, and this
check is always false:

    bool is_d = rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D;

The first FAMILY_D chip entry appears later, in "add support for
RTL8367S-VB". Until then, the is_d branches in rtl8365mb_vlan_4k_read()
and rtl8365mb_vlan_4k_write() are unreachable.

Would a short note on this help readers who see the paragraph above and
take it as a description of current runtime behavior?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/38872e6f-1264-4a93-9f81-8212173e909d%40yahoo.com
