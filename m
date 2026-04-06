Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9A347FEC;
	Mon,  6 Apr 2026 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479390; cv=pass; b=q7kHyimPGiZG8PWhu1h3XsjXV5df03NIFKV9+36MToXXEGxLViGzf4WRbbiAh29VnzNL2XUrfy6JkyJluV9+RSARcEGcks7KbPMYBvroJagsLgdCXPedNQk4GA5EVR2nTSvBfXdTeTnX/PW1MMSYToLKHZmDEJB1OFrAhgBLD6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479390; c=relaxed/simple;
	bh=o71LCjpQ+FkwymRkz7CSKQkm0BjuwkBoc4linYLJZio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjUNipBAJ3O6kaxR0eTfpbeO4KoKDMS6tRxGQIvac9ACa14gNlcs8zTiGer4s63WoBvls/cZpKaSRoU6VXYVU8oKeHp/8SOO4qwZTK9aiuiEeR7zbm7DchKimMEoR9FXSQK19777zeNt8iC2kLjE/AGVjYefWoUhNt8oUVZIHbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=RstiPvQQ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="RstiPvQQ"
ARC-Seal: i=1; a=rsa-sha256; t=1775479368; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BScQ+Ks9FQvuKooZfppwojKnp/hyE2TBl1ntNnw1428WJJSWV5fzBDQdnLL6101SgI0U/4fJ5/3JJQkyzU+CtGKZGhdalnwoNVy3cbeV1Tr+iAJE5yDKZqum4a3acaGhX7Kd70wpIl2NDK31nC28J3HlOQPpBnzaXhfPgbjxiYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775479368; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CmSnrLq2CguI8aCWb+g+eytRw4ve96+ufTl27dYwvqU=; 
	b=UQl6L4flIbPNcj8SCyW0eJmATunbGQ0hr48WI6Jyo5BlzALbK4D6rHG3Q4AT24aB+OHCF2CvqHUfmgBnboiOet3P4ZJEqPfjhxPBLsEt10k6fgchxHhXe/Fd5yxAiBppc65Fmb19f71yXU9tkhfnxnE7RqnhWPFO3/Hvng32q8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775479368;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=CmSnrLq2CguI8aCWb+g+eytRw4ve96+ufTl27dYwvqU=;
	b=RstiPvQQjdgRVoqWQwubs3esp7nlL3RLDifdLBW9TT0x+49ZHGIiX9rBGWA3T+JV
	oR04Na8NFTthCeSjOE0ZYkh6NtIE681B1yQGfmN5cDYvkfJEgDQRMb0iMRCRgGHXnyv
	ibnrzOJV3mkTgcXJ2q5o5Zoi0WEoVTxDJb9JjHs4=
Received: by mx.zohomail.com with SMTPS id 1775479365106594.5157446270235;
	Mon, 6 Apr 2026 05:42:45 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:42:29 +0000
From: Yao Zi <me@ziyao.cc>
To: "Johan Alvarado" <contact@c127.dev>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Cc: <ggo@tuxedocomputers.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: fix eFUSE MAC address
 read failure
Message-ID: <adOqNTRBOF2BQi_r@pie>
References: <24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com>
 <4aaa214c-4286-4c24-ab5c-b17a3a1a8f1e@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aaa214c-4286-4c24-ab5c-b17a3a1a8f1e@smtp-relay.sendinblue.com>
X-ZohoMailClient: External

On Mon, Apr 06, 2026 at 07:44:25AM +0000, Johan Alvarado wrote:
> 
> This patch fixes an issue where reading the MAC address from the eFUSE
> fails due to a race condition.
> 
> The root cause was identified by comparing the driver's behavior with a
> custom U-Boot port. In U-Boot, the MAC address was read successfully
> every time because the driver was loaded later in the boot process, giving
> the hardware ample time to initialize. In Linux, reading the eFUSE
> immediately returns all zeros, resulting in a fallback to a random MAC address.
> 
> Hardware cold-boot testing revealed that the eFUSE controller requires a
> short settling time to load its internal data. Adding a 2000-5000us
> delay after the reset ensures the hardware is fully ready, allowing the
> native MAC address to be read consistently.

Sounds like a reasonable explanation. The vendor driver reads MAC
address from eFuse before issuing a system reset, which explains why
this doesn't reproduce on it. However, I'd prefer your approach which
ensures a clean hardware state before any operations are performed.

I'm currently on travel thus couldn't verify it against real hardware,
but here's mine tag,

Reviewed-by: Yao Zi <me@ziyao.cc>

Much thanks for investigating into it.

Best regards,
Yao Zi

> Fixes: 02ff155ea281 ("net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller")
> Reported-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Closes: https://lore.kernel.org/all/24cfefff-1233-4745-8c47-812b502d5d19@tuxedocomputers.com/
> Signed-off-by: Johan Alvarado <contact@c127.dev>
