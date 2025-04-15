Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E129E07C;
	Tue, 15 Apr 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731610; cv=none; b=RcGoQIqrnWwSUek/diQOLGIoWll7+PsEobf4Pe+tFd+erQf85NXbtoPqVny3fDbBw4D+iO+o3Bt/hAMfjU3bZabsYqNxYrYVrbuoWIZ5Q2LltX5TgJu2zsOnXt7mb5jz34qSB8n2HDOAuxrU7PzKKxUqYglijU4hWbsFstkonzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731610; c=relaxed/simple;
	bh=dzwTkeVW3m8NZo5p+8+xPOs71OcTG5vKrAZ0wG5pETs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XgaTKQDmEZioQc7oTk4NBEZpCa3RNF4WANWC3C/vccwCoL5PFH2MsOylZpNsuEVVi1PZl2cWlA6cjPG3PYeaZgW0JlxM+HTsI3JYd6OlUlLL7fBYkfuXiJdVL5sB4TxiJCypD4ATVFSCj/8Bb1jPTC0USrmIY0WUAl49FfKRWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYO4VTGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYO4VTGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8538CC4CEED;
	Tue, 15 Apr 2025 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744731609;
	bh=dzwTkeVW3m8NZo5p+8+xPOs71OcTG5vKrAZ0wG5pETs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lYO4VTGqisxqq2ozajFWSqr3ercrEOC8Wwga3+2rt4jygg4ysPzvQWpVqrr/fv4GM
	 9eQxL9axGqSdqERr97ccZQcI3oB6Cnx0KayrR7JgtoETApG/n/6A1bNmRRDCUa2eWq
	 szOJu3GdtjV8QQ/oDnvO/hq776avp0CNhrwH09r+dGFlg16aYG7J3A083VGoT+eHz3
	 Kz2wDPARZYr8KzzgXBcR7sSw88GIB3oCW66knHOOpVJcdxKzxPpMDrNxzbZ8QOxsIi
	 6eKlUfNxxInkyPwpjzd6C10DbgRo02+FUOw5MhAgsnS21XzXLiOVmvOjBK+0dQHdzc
	 t+5hqqwodb1IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBDC3822D55;
	Tue, 15 Apr 2025 15:40:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: imx: use stmmac_pltfr_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473164749.2680773.17264687658771021637.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:40:47 +0000
References: <E1u4Flp-000XlM-Tb@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4Flp-000XlM-Tb@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 festevam@gmail.com, imx@lists.linux.dev, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, kernel@pengutronix.de,
 s.hauer@pengutronix.de, shawnguo@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 10:06:25 +0100 you wrote:
> Using stmmac_pltfr_probe() simplifies the probe function. This will not
> only call plat_dat->init (imx_dwmac_init), but also plat_dat->exit
> (imx_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
> results in an overall simplification of the glue driver.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: imx: use stmmac_pltfr_probe()
    https://git.kernel.org/netdev/net-next/c/b2ee4451c1d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


