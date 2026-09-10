Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081F4A0EF6;
	Thu, 10 Sep 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052677; cv=none; b=KtywNWcfFldL1w4HaRZTgTPXUiaFLrSpxTLzglkG7PIyd0uJ4+yYotYu4zrt5tJx0Ievy87Bl3BDh0kV/nK92ACmXcLVdS6zODhwisbxIGEyranLUw5syk/ULp5txcSrUtyx2v0zcojfkMqdoyq7ECwm7a0cXdm9eCdM3YqubHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052677; c=relaxed/simple;
	bh=SuaHZu5oYnEzXSShHPgamJEbGE90hohaMeHH68Zwlu0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/jR3xgnFI75gPkAzBM6m9wk54pb2LST9dnbPFIyIfF8d1WZ7CBID7b58JgHBY8UhOQHXk0EvA3/gk2Zrzxck7ZaX7J12wAiR4sxJcnWf44E+VEM6+eNFimgpF4h49ZZOinYZ0vk2kZ58BJQQmHoypDcRO2oUId9m1FRZXbidw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3udn2M4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3udn2M4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51F1F00893;
	Thu, 10 Sep 2026 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052671;
	bh=UuAE4sonWCNSgtWto/7TkRlL4/OL3xIbl+l96H5bnZw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q3udn2M4NDorY/w3MNLfXG82aiKyTke+cpjgss/nVGFpug9htNrpkcNvMiY/n3T+K
	 pZBhYyvrpfuemDX0FTESo9a+lfzfRiTFAd9d/hWKMcNur6V2pTec+rQA6GvmO/zPfX
	 qxTCLfqwfvWdjmco2BCy5p3FwySeeJM6KPkgAF21epW/9BKmbT4+WxuutvqljkLukz
	 +8pQwwULnZUjDeItVBWTy5E60H9uV3yfGRjyL4hW8W7LtkooeLGfbpcRL7tnvjxfsZ
	 cNqrHrgHY8s74R8i/g/fWPmp5Xpva1OUSbgGWNu8lOOwhq8jiFsUxIOlcAmIiEVtgJ
	 gCCmRVqIXFKiw==
Subject: Re: [PATCH net-next v3 2/4] net: mdio: realtek-rtl9300: Convert
 "fwnode" left-overs to "of"
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 15:04:30 +0000
Message-ID: <178905267047.219967.17076903048414131472@kernel.org>
In-Reply-To: <20260909150107.3602067-3-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-3-markus.stockhausen@gmx.de>
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

- [Low] Incomplete conversion vs. commit-message claim: the commit states
  it converts "the remaining 'fwnode' left-overs" of…

--

net: mdio: realtek-rtl9300: Convert "fwnode" left-overs to "of"

This converts otto_emdio_probe_one() to take a struct device_node instead
of a struct fwnode_handle, replaces fwnode_property_read_u32() with
of_property_read_u32(), drops the to_of_node() conversion for
devm_of_mdiobus_register(), and switches the child loop in
otto_emdio_probe() to for_each_available_child_of_node_scoped().

> The latest developments of the MDIO driver consistently used the
> "of" API. Convert the remaining "fwnode" left-overs too.

[Severity: Low]
Is the conversion of "the remaining fwnode left-overs" complete after this
patch?  otto_emdio_map_ports() still prints the parent node through the
fwnode API:

drivers/net/mdio/mdio-realtek-rtl9300.c:otto_emdio_map_ports() {
	ports_dn = of_get_child_by_name(parent->of_node, "ethernet-ports");
	if (!ports_dn)
		return dev_err_probe(dev, -EINVAL, "%pfwP missing ethernet-ports\n",
				     dev_fwnode(parent));
	...
}

The statement just above already uses parent->of_node, so would "%pOF" with
parent->of_node be the matching "of" form here?

A grep for fwnode in the file at this commit shows this dev_err_probe() call
as the only remaining user, and it is still unchanged at the end of the
series (5624848bce74bb4ff1882ee7fa047bde6f4e04aa), so should the commit
message be softened, or the print converted as well?

The message text itself is correct either way, and %pfwP on an OF-backed
fwnode still prints the node path, so this is only about the completeness
claim.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909150107.3602067-1-markus.stockhausen%40gmx.de
