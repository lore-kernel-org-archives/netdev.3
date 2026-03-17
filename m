Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A625A357;
	Tue, 17 Mar 2026 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717624; cv=none; b=VliA3cXT4XV9MPLT6nDZAlcqYtKQdmVUKqY20WqNa6RtveU02Sm6g5m4IAKmehkNR1L4oR6IiwghcDK0tMNdY8FUm8HX+QqhCBZGJ1SIkOK95g8yvNS516S3hEhraqEYLKJ3dJxEWZW4Tkk4i7Cdd3USp0qW5DT8XtXJTPFakto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717624; c=relaxed/simple;
	bh=v/7y334kmrpQVe8O+MZvlcwnp+EHDxJCOGIBAHun8wM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XiANvT2kQ9000YPRAFO6rb1VVDQ9dsMEebnpv4/i0OwC5mH5iOZp4pQ9ADx9S1R4lPdf9Fwb7Andey7M2XiELpFONDV4whqV2xoTR8e15l25vv/5C3PfZ+UD8YPeARIaoBpGF4Bi6HUVlmnUosYLrMC98JVrLMYBWQP3UWaE+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU842gHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU842gHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AF6C19421;
	Tue, 17 Mar 2026 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773717623;
	bh=v/7y334kmrpQVe8O+MZvlcwnp+EHDxJCOGIBAHun8wM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gU842gHh9ysARNVOeDDKttK9Jif2kSzliZHnnbb3LiHCfooVpTerQ0HYlj/YtsJF8
	 Ym4cTtqk5aF8JG/keBw4ll6dgK2EbJyr2na2wOpH4gfij4618LseODQ5DO2GH3KnWy
	 7UP4iZQgVu6bolPjYLdfNWejhluWtqTrwTvbRTJGJfrQFsd35I3WqAt4vtv9/lQ7Af
	 Rhnz9hPXC+uH9qd1/nHv+rhIcY+WVdSXZNSgSW1MXjuvigwnb9qObX62FTNzSQnd9R
	 GEwJs2txup9u3fBVvEB/FYHDSOvsR/KENPjhtlt6MMa4+33Tdu1PmxmygyTuM1wt91
	 UTF7MCCI67RCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4012C3808200;
	Tue, 17 Mar 2026 03:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/4] Support multi-channel IRQs in stmmac
 platform drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371761578.3410412.12736160514869511469.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 03:20:15 +0000
References: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
In-Reply-To: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
To: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 08:13:31 +0100 you wrote:
> The stmmac core supports two interrupt modes, controlled by the
> flag STMMAC_FLAG_MULTI_MSI_EN:
> 
> - When the flag is set, the driver uses multi-channel IRQ mode (Multi-IRQ).
> - Otherwise, a single IRQ line is requested (aka MAC-IRQ):
> 
> static int stmmac_request_irq(struct net_device *dev)
> {
>         /* Request the IRQ lines */
>         if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
>                 ret = stmmac_request_irq_multi_msi(dev);
>         else
>                 ret = stmmac_request_irq_single(dev);
> }
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/4] net: stmmac: platform: read channels irq
    https://git.kernel.org/netdev/net-next/c/a31bbe5ca2f8
  - [net-next,v12,2/4] arm64: dts: s32: set Ethernet channel irqs
    (no matching commit)
  - [net-next,v12,3/4] dt-bindings: net: nxp,s32-dwmac: Declare per-queue interrupts
    https://git.kernel.org/netdev/net-next/c/cc7a3435dfad
  - [net-next,v12,4/4] stmmac: s32: enable support for Multi-IRQ mode
    https://git.kernel.org/netdev/net-next/c/66ccb4f1d205

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


