Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69D2D0C92;
	Sat, 23 May 2026 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502211; cv=none; b=ZSH4XWOA0pe52IdpAwyWhgQH2LpL+eRv7kehL3fc7Ti2/M4JJYzhad9ww3T38PGJ9T+ECMictQE0itLCSC96/pjXNn++isVXqUhPNUMcKc5uy+tmRcZquH2wOVmwpGxt7dqSn7q0sN3eTyqSMEw0lvMReSu6r1tk0CIaaABMhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502211; c=relaxed/simple;
	bh=nnVA24FSv+gpIlRFxPmXV8ZoJRHwoLx3Y1IQWa/cCkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ln85NzO1Np8CAJqF2U7xR/zKzM+jie432kkQm9uFuNbmSdQeMzYaVxvQTwzBVfSV/VuGU1ltw4Znzp3uHMjSjlsStIpAEG0IGPt9EZBDuvKcSzSKF4SmN1yR6AKYKRLHIdf843MRgPFmuqNytjhH/A+HK3OyvqrkQ7Ril217sY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGbmrqvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGbmrqvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3771F000E9;
	Sat, 23 May 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502210;
	bh=cwexbUW3atHUuxBiUTlgNTLA4iU2dMsS2Z3tlktdEkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AGbmrqvZq0KQ3s2Ie4j2kB90prZL3N03hQSfe1OoTO22Mf7ZlSbgGv4h0X4vUdEbn
	 T0ec8aMAYvPgztM5AqSeANeEEc9zjeRvxuXbeoC8IlqBAfJyTqMaupzhruVcTUNFbE
	 T6ycbfwJEE6j2birU9uBpwHES89adh3U/9TWXMyuKtHNMF1vgh5Ky/V//w/xbEkq5L
	 LkSZ8uwdIK5xe9gvZ1uMqBkh0yZ5n7QFBKk4AH9kuBvExxxw3XR5AYFeHXMprLWcaG
	 1PZeFZ3vIfxbFuIh+4Xq8li1fa+2qNVluwtHss/ecDjeIeEvNyGeTiqtSzK/0b4O36
	 DomDH7DvOVI/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A123808205;
	Sat, 23 May 2026 02:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/8] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177950221889.1443443.5198644261821848371.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 02:10:18 +0000
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, tristram.ha@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 08:12:35 +0200 you wrote:
> Hi all,
> 
> This series continues the rework of the KSZ driver initiated by a previous
> series (see [1]), following the discussion we had here [2].
> 
> The KSZ driver got way too convoluted over time because it uses a common
> framework to handle more than 20 switches split in 5 families (see below
> table)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/8] net: dsa: microchip: don't reset on shutdown or driver removal
    https://git.kernel.org/netdev/net-next/c/5fe0b938bde7
  - [net-next,v3,2/8] net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
    https://git.kernel.org/netdev/net-next/c/dfc5c56829b9
  - [net-next,v3,3/8] net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
    https://git.kernel.org/netdev/net-next/c/7c494a10f937
  - [net-next,v3,4/8] net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
    https://git.kernel.org/netdev/net-next/c/4c54f910eefd
  - [net-next,v3,5/8] net: dsa: microchip: remove dev_ops->setup() and teardown()
    https://git.kernel.org/netdev/net-next/c/df478153cb2d
  - [net-next,v3,6/8] net: dsa: microchip: bypass dev_ops for port_setup()
    https://git.kernel.org/netdev/net-next/c/aa6902098914
  - [net-next,v3,7/8] net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
    https://git.kernel.org/netdev/net-next/c/932fc72b9849
  - [net-next,v3,8/8] net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()
    https://git.kernel.org/netdev/net-next/c/2b0c672543cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


