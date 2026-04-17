Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834041C8603;
	Fri, 17 Apr 2026 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776391840; cv=none; b=LnkmE0dxjodaJPQwReFi6fz6+jQ0G/2vxq8kh8BVSGjf9ewzh5pOxc2TOFyorEzbBQBFgAdo4pDvmXF9Hn4gkitPB/UFeMPDC7bsy/xqV4Tf2pjbgOQz91sxtszbjUaAT8EC0m7H4G5C90IQfZL2ICO5tSJzEOl0pk6I/viS/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776391840; c=relaxed/simple;
	bh=zAyrQn8mwD9Mf/hBd4n7vn/v7wFuvBe5KGXb43sBMvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPnsiIyfckY7RiUWaiZpxyYwB1FftdhJYSrELhnBBFF66SYBK+t7E6IYTPY9GGuP4olIwqZh/4ZVKtkNwKgW49Juglfp/O9683f0fy0ZjT/2IpFIHNDZEdxDtKFtFp+oXbiGkkib0Nu5SkPoLlPWGI0o0NoA043gdBA/tIL+Onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKaCxXkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKaCxXkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C111C2BCB3;
	Fri, 17 Apr 2026 02:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776391840;
	bh=zAyrQn8mwD9Mf/hBd4n7vn/v7wFuvBe5KGXb43sBMvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YKaCxXkv4umzmcXI2PXAsI7Q9of8Y7ZYtbZ5RXxEjXaxe5aEQ6Qrb49/DEN1AS6yO
	 WuJWlr/4NZ4kR2VCaFCUBk3BPwKXZqB0kB3+PS07/QRUpfgmOrXV3bPZQKZm4L+onf
	 gB7EPHyJHj8PFm1zEBviI0YYUJ+ugGXef7rnuGO5pd2jytYC5RQshw+WFh1M6dFlaO
	 nHCJH8djrEw9sDywkg6KH2vtfHE2hxzkcKARTbJ+r6iLg0eVK7IQYOpsOOEQcLNSDf
	 B/bnusA6RCMfJMfZLZTNsz9ojXxfeDr2TfXMccFqEskujyNlzqaWEV4Z2C31Md9EAL
	 ZIFroOPcdlfDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEE3380AA76;
	Fri, 17 Apr 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639180830.3482475.10935777859672810901.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:10:08 +0000
References: 
 <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
In-Reply-To: 
 <980c57efa5843733ef95459c3283aebade56f142.1776162544.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: charles.perry@microchip.com, conor@kernel.org, kuba@kernel.org,
 maxime.chevallier@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 12:30:47 +0200 you wrote:
> The PIC64-HPSC/HX MDIO interface is only present on Microchip
> PIC64-HPSC/HX SoCs.  Hence add a dependency on ARCH_MICROCHIP, to
> prevent asking the user about this driver when configuring a kernel
> without Microchip SoC support.
> 
> Fixes: f76aef980206e7c6 ("net: mdio: add a driver for PIC64-HPSC/HX MDIO controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - net: mdio: MDIO_PIC64HPSC should depend on ARCH_MICROCHIP
    https://git.kernel.org/netdev/net/c/1e9e7fd839b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


