Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DF2DB7BB;
	Fri, 16 Oct 2026 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110623; cv=none; b=jLvKNDjep6IG7Y2f/GtThn5q73F6o0ERk52a1hrd6q3xV4PZnUZWEmzNXFa4h6hVdRF+gviU+ZFgXL59J5y64+3Jnj64PrhAbn+V+Y3i2HzuSzLGvRwN2krvwGyAfhfFSN+55th2kYAPKOlJ65dLewT32eZbhwDLvLlZZ6OoiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110623; c=relaxed/simple;
	bh=nawWwXpWb5VWEtEIV+wPBWpvT8L2alh4kcY+FPDyA1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nlCLSRQD2SHdyd8mbrPujwX+J22CZk4E/sj3/jDfNBR+EJVVfn5iatDnQARqk/n1yuGhtu1Ivt2msfCjqLlY1Mkc0+L0K2DO5wAZH/koH5Po2vEHBohzQXhsExrUNPnk1tqIXsYAHTvOG31zI6D7RD9KjkyHSNpIIOOv+9TkHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TInjAKLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TInjAKLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0692F1F000C4;
	Fri, 16 Oct 2026 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110622;
	bh=zylu+P6R/+lrjSvYrhrkUHfZUcsGG8BzH4MkYmh6WQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TInjAKLflLdtLsPaPrVzAQiTurjw/L8PsB3G841RY7Vc1Cy3PdyKtVLKSr723UMgj
	 Of2/K1F6iPmvR+Lj8t895Q13pT8vsp6w45ODysjbr5su3pNFsxPDkgJWjHPsrq6Nir
	 fOC7BPHAGkllc2PX3kAwJ5+3qBYJoVQdGfPDANQomgFZwgrP/gzYCdIc21C7UCHf29
	 vsqrxHkhlruMDjDTxiPhEG+MJDVLMPDsm1QifOwJDjYlpwd4sgitbwDprIgnkXiOit
	 +3eqgeVnu4zV07CR0RxcIlRVlBDLpM5HNgu0LrnIJ7MZipcKz3yzDn8IqdL/ZHv7+3
	 BdLigmqWxuaSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F143A3808209;
	Fri, 16 Oct 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: add quirk for TP-LINK SM410U
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211062048.4173731.12561937466055901420.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:30:20 +0000
References: 
 <172a4fed74d35b1be51f4e8aba2222aa33845b08.1791679663.git.daniel@makrotopia.org>
In-Reply-To: 
 <172a4fed74d35b1be51f4e8aba2222aa33845b08.1791679663.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 pepe.schlehofer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 01:51:14 +0100 you wrote:
> The TP-LINK SM410U is a 2.5G copper module which is based on RealTek
> RTL8221B, but doesn't seem to offer any way to access the PHY over I2C.
> Add a quirk to disable in-band which isn't supported by the PHY.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/phy/sfp.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: sfp: add quirk for TP-LINK SM410U
    https://git.kernel.org/netdev/net-next/c/01b99e9d0d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


