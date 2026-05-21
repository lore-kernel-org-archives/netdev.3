Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F61A6838;
	Thu, 21 May 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321616; cv=none; b=evZzsIhDA/gVevyx1TSBquXhebGT8eaJhZixlZL4scWTEHuVIfCl0d23E14AaoSPGLZXElo44bW0FfCi8Zxrf7COB9Dd+QDke08ma2ofaV71+S7lwNfFtRdHXFEwnFSl6tdeMLHhQ0jIj2Cmv7MZkJgmKlM8E/o5EjZTUerFmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321616; c=relaxed/simple;
	bh=JLAI1uRWMkpuZB+Em5Kq79cn5TizB/UaipVZKu47EVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SshbjO8wLALJ1pOoX+DOQrv2MvS48pQq/Yjgxfnyp+DHDvLI4USbhXYsfkYxPp1VC+CGY5tRrtXomhL5qTXNIMABZ7AQbODemi65Eu1Sjhhwwkip/7Le67IU1BjC5G+Dcf7lbDzJOfKteF8XOCo7ATiLurrVHgJqu4jQ005Kk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF6NWsME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF6NWsME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996631F000E9;
	Thu, 21 May 2026 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321615;
	bh=HVm8tc0PebIx1kMEfESFSYNBtkiOfB9asJ+ZOPtlzWc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BF6NWsMEb0xoctnJX1F0zQ5lbd5QUFj9Sm0DaFNP+iGov1ivDf0M6CSCgL0Xlqfxy
	 RZ+OkiPiDvK+CCgySuRM4D2nBfs1eEcBsmn0CFV3fSLmWP3paFw54vWackGIRAOiYN
	 muPfC4IQgokXsM6ughVSN/RlTb9dOvBSD8uYu25CmY23vJs23vFL8f7DCeY80Pb6/d
	 el3an51ra9fVyHN4X820rB0n50paSkjP1bWp5oQsr+tuo/ij+fuCr9kDYnMXd+MyuI
	 TxXkleGAxNDy1l0tqvydgam0ipDdP12EeChWe3CEM4M4iFrjTwbK82rxm9+ryxYnHm
	 lHOw8v2Gcycdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C173930C25;
	Thu, 21 May 2026 00:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: realtek: support MDI swapping for
 RTL8226-CG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932162564.3801238.2549776951847746974.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:00:25 +0000
References: <20260516190456.387768-1-jan@3e8.eu>
In-Reply-To: <20260516190456.387768-1-jan@3e8.eu>
To: Jan Hoffmann <jan@3e8.eu>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, markus.stockhausen@gmx.de, dam.dejean@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 May 2026 21:03:45 +0200 you wrote:
> Add support for configuring swapping of MDI pairs (ABCD->DCBA) when the
> property "enet-phy-pair-order" is specified.
> 
> Unfortunately, no documentation about this feature is available, but
> this implementation still tries to avoid magic numbers and raw register
> numbers where it seems clear what is going on.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: realtek: support MDI swapping for RTL8226-CG
    https://git.kernel.org/netdev/net-next/c/0765570f330f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


