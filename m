Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AB3D967F;
	Thu, 24 Sep 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272881; cv=none; b=LYC0PFGe6QMAN+brMK7v/kK+lTKLCn1sJdssu0d6/JP2dAZHI9laM1HwlDqPrFT1FmcAuGAh17qLCWEQblGyKe1eHGXxPOOK7pmQaNKd9qmzW7Cty11fXkOF82CNdYp9+mo+F0FqhkkfdhbjGNkPSOA3oUpgMOJVTiFbSbK4HOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272881; c=relaxed/simple;
	bh=lCW/CUfnoAFpPK4UKkZ3XhUHYchYHM3g9z5O6oeUFAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pRYq8JHGiulwxR97aWVqeyVIoTMHIip/TcrH1vyAW/8z/F2g99TTRJjPVte4LOYCR0Jdu0rXQEUusyKz6eyCyxPskxyHbzfF1gHAOhGaoakJOY1gQCwsgmhHPTUZajrunzFtCHBOtERNKmCJ9PiBlwBC4hfJVQncOKuQQRLmZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJsasJCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJsasJCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329B61F00893;
	Thu, 24 Sep 2026 18:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272880;
	bh=3b7s0TZCouRV+fANKyon2fgb5XJsJs6Z3Co+PZgaJH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iJsasJCeYcma1r+urKfOz0k8MclnTql/D1yVdZRNt6KeUQFwBy4IYdzChbWGVpUgC
	 +m1YjISlr9tTMgCG899hV+yLjNlALOFMET9kxqPlyp8wXKbEboH0D0hLqJGnosXYbD
	 n+jvB7849l/+p3ecltU8JlbFJrJAvCEsTznzdkIrYkVmFSFW3+zX8X6NjvWAdiGHQw
	 lwwaapzE1FapwSoJ2H2a9rQqqetku6tCKb7DziCdCP5/0fgoIePhdZOZyuQ67IggFt
	 Ed0+3r13bhWufGoDv2dm9/Hcj8vh2KnFyrzesy4OL3D1dQNX7tEOCMK2qZXdhzhrL/
	 6bxE/sx8eTlKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C43A566DD;
	Thu, 24 Sep 2026 18:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: stmmac: dwmac-rk: fix bulk clock
 leak
 when the PHY clock fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027280889.1685480.8117520252597627875.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 18:00:08 +0000
References: <20260923123713.3137146-1-coiaprant@gmail.com>
In-Reply-To: <20260923123713.3137146-1-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: heiko@sntech.de, maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 sebastian.reichel@collabora.com, netdev@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, lorenzo.bianconi@oss.qualcomm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 20:37:13 +0800 you wrote:
> gmac_clk_enable() enables the bulk clocks first and then the optional
> PHY clock. If clk_prepare_enable() on the PHY clock fails, the function
> returns without rolling back the bulk clocks, and bsp_priv->clk_enabled
> stays false, so the later gmac_clk_enable(bsp_priv, false) becomes a
> no-op and the bulk clock references are leaked.
> 
> Add the missing clk_bulk_disable_unprepare() on that failure path.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: stmmac: dwmac-rk: fix bulk clock leak when the PHY clock fails
    https://git.kernel.org/netdev/net/c/8db67bb6a1ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


