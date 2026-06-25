Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FA382388;
	Thu, 25 Jun 2026 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352222; cv=none; b=R4CgopMGC8Lo3xt50RTQqOF1VjMNkL/oH8/4xEK0ErenmQUC8klPT/BDY7CpgrGkkGtDYTp2JLhtgOP4bo9CJgg6wj/NYYt7PIROG3Mo3TAWZ7YwwilThC0IvzbSk/LQw6psvqHX7VEqzg6wr+5G/wUdT71faPbzAhQgfKk3Yk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352222; c=relaxed/simple;
	bh=YHGfqbhRyyDfktnsQ5Uq+RyCg8gszg1PLUxyWW7yum4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vkol/E9r5Pv/zU0eFZO9sY2SgJuGctowhjoGibJu+utncQ6d/1RhRcMy+1R9BLG4yR/c0TRurp/JDyl2f4zpf3VRHbmyH1T3x3055HnZIstfPLMcDOaZk2JYq3fHazap9lRCzauglJy7GtQZHNdyIke6RXL6Ec04luEm38S7G0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwPxS/NY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwPxS/NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50921F000E9;
	Thu, 25 Jun 2026 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352220;
	bh=Tb3rbYR4nybRquIn6oIG8yWcyiJzK0ODeI8w7S3Wx5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BwPxS/NYBPiD2m9FDKehNxKScGpAgzsm89XRyyK5phrhWpNQbwBHEVJJB6TPlM9P/
	 tmraZGQoZhtJpsjrMhkRasz4bRmy+n7Bl8MRqNGVAchjIoZpadvJpAgzIxirY4CR3H
	 vgLqp8U/5LnLXNGePJK1oGcRmzohkp84vBte+iFgTClFU+Odz9SyoDp57XzYk1COZd
	 PG/ZqRBzHFQjeCq9x+/yFdbmmx30ZZ9SJBP/lMaXZAGdq64wmxpIabwuDTYrpCz+EQ
	 yUpDfoJyupprEOjVaTuNAocHcBOHcvBA8AbUZ+beW5RCRTPyaJH1iMqyFjjBm2ghdm
	 v/EPh8LmW7xNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569D03AAA6D1;
	Thu, 25 Jun 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G
 bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235220885.3075556.12697769735215481789.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:50:08 +0000
References: <20260620011956.37181-1-honza.klos@gmail.com>
In-Reply-To: <20260620011956.37181-1-honza.klos@gmail.com>
To: Jan Klos <honza.klos@gmail.com>
Cc: hkallweit1@gmail.com, andrew@lunn.ch, linux@armlinux.org.uk,
 netdev@vger.kernel.org, maxime.chevallier@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, olek2@wp.pl,
 markus.stockhausen@gmx.de, jan@3e8.eu, ih@simonwunderlich.de,
 amadeus@jmu.edu.cn, rmk+kernel@armlinux.org.uk, hau@realtek.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 03:19:53 +0200 you wrote:
> On RTL8127A connected to a link partner that advertises 10000baseT
> speed cannot be changed to anything other than 10000baseT as 10GbE
> is always advertised regardless of any setting. Fix this by
> clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> call to phy_modify_mmd_changed().
> 
> Fixes: 83d962316128 ("net: phy: realtek: add RTL8127-internal PHY")
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Jan Klos <honza.klos@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
    https://git.kernel.org/netdev/net/c/510a283f4d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


