Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3172627;
	Fri,  6 Mar 2026 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841018; cv=none; b=LvK6vot5a2aiRORwId9QwFAS/tX8k1WxlEB7TAnVDfG95eM/E7ige7FbWx2xVmx7Jy2B156KbTgVbmVJlbsESWiLhYDdg8BsPRJv6r5u/g3BfHR4L4182gqYKaDRauj4RCJ6ZuaB5d3b0HSjHax0A1y66WlDxRS6xRSclrUI4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841018; c=relaxed/simple;
	bh=BQW73dxoFvf8W9lwbY5JOxppl2jq+PcUgOfCJhuasFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uul7qr5xbsFhPruKUO/ZgHFn6tj623NVMW8aPcP9qWykXxuP5fk+XG7JLrbZYCDU82hZxuj8Dj7TN1kcg3rX+YKUXWjA3tb0IGBomt62fwLZSRB9iCuNflCV4KT10FUVSJCi1n92bnh9OHIZmdlWPtEldzPtiL/4MK7P0WbSYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZeceoFW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZeceoFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2844AC4CEF7;
	Fri,  6 Mar 2026 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772841018;
	bh=BQW73dxoFvf8W9lwbY5JOxppl2jq+PcUgOfCJhuasFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AZeceoFWUBzHrcZ1cwO/gNZKKGnTGYzoaTq4ZcmJ3PkLhzEbo1YHEm2P3D5sQjNah
	 JjVGGBxD6egmPXbetoSy8xZDIcG7gkwDbLTv3d/Vdx9zRojsBKqtn/KbKJrrR9mW+6
	 MIV9N1wlDdcbQPQuhvlxyWU+0t50ePLZCkAUFTaj2K0//qhaOvAvcWsz8Jcc54ruep
	 jmY9pkf1Wox7Jr4uIiIbFPmyYyKeHR3AMV/JyMKulw/n+PpejERXJxN5BzHzb1rq2e
	 3xAf9jv6V2j0O2tQhW0Zek11e/SysJwH3PkaOZ1yaV1orDHOOdjKJP/RgKNtSEUT2f
	 9p25rXvQLGR7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF413808200;
	Fri,  6 Mar 2026 23:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: stmmac: mdio related cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284101730.95361.6178473364485118037.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 23:50:17 +0000
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
In-Reply-To: <aald--qJquWGIvmO@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 wens@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com, samuel@sholland.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Mar 2026 10:42:03 +0000 you wrote:
> Hi,
> 
> The first four patches clean up the MDC clock divisor selection code,
> turning the three different ways we choose a divisor into tabular form,
> rather than doing the selection purely in code.
> 
> Convert MDIO to use field_prep() which allows a non-constant mask to be
> used when preparing fields.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: stmmac: mdio: convert MDC clock divisor selection to tables
    https://git.kernel.org/netdev/net-next/c/4c7e0e081889
  - [net-next,v2,2/8] net: stmmac: mdio: use same test for MDC clock divisor lookups
    https://git.kernel.org/netdev/net-next/c/b6687ef97603
  - [net-next,v2,3/8] net: stmmac: mdio: simplify MDC clock divisor lookup
    https://git.kernel.org/netdev/net-next/c/506f78f43c58
  - [net-next,v2,4/8] net: stmmac: mdio: convert field prep to use field_prep()
    https://git.kernel.org/netdev/net-next/c/58bd0039002b
  - [net-next,v2,5/8] net: stmmac: use u32 for MDIO register field masks
    https://git.kernel.org/netdev/net-next/c/df388b4d3913
  - [net-next,v2,6/8] net: stmmac: use GENMASK_U32() for mdio bitfields
    https://git.kernel.org/netdev/net-next/c/a64d927aecf1
  - [net-next,v2,7/8] net: stmmac: mdio_bus_data->default_an_inband is boolean
    https://git.kernel.org/netdev/net-next/c/3cd963fa915c
  - [net-next,v2,8/8] net: stmmac: make pcs_mask and phy_mask u32
    https://git.kernel.org/netdev/net-next/c/e4fd855c52ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


