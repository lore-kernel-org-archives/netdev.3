Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3CB35C19A;
	Fri, 23 Jan 2026 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136024; cv=none; b=HDCNNEGQdCV8B/fAkqDRCI/Xd32Knbmf9bO2cVtqT4ydT9KXZ6FSXsUV0nRk2QV/Melpvw37YesrdLvXmkjoAwcOyW4AUvXgSR5yjA7UvdCsF+88DRG8ba2ZMmOQWuDCA9vDCwSl4NWpaBqXo1KoR+daHedu5eqNjCHuC5Miasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136024; c=relaxed/simple;
	bh=rYnv4zqtY0mBEcBw1/7t7CTHC/pA41/mg6zxkbHmxPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J3lkM87QCArQpSJVr/Da6eEN1SU8FfnUjnNmtFE7xH1omo1uCYpFnNhJsTtDvu4LCLHDGjCPeagbCjGc7fX5iNr3Vpt9XsFZ3zhOrMrpDAaYQLUtGq8dYtsGFO4xwtPrQke22op5rgLSLEeBdpEGqKWXLmLDwLmA8tM/e1qNY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+jWSwZ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+jWSwZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE9CC116C6;
	Fri, 23 Jan 2026 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769136020;
	bh=rYnv4zqtY0mBEcBw1/7t7CTHC/pA41/mg6zxkbHmxPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k+jWSwZ1eP5mqHx46Ett5/lsqxNiOQvUKebp39gWeNwTDWF+FbtqphuXqQfAhOznQ
	 y+d6HtrISdQBTWgG2viM4t07WWlSQjd1264x2g5I/Ykz7nDh/HW7H4tPjhEGdcnjxm
	 U3Lf8AFX9CRS1hUzcS/5SEf8ASUlTnzuFZZNcDsOTPH5Di026hPLQ9RFqsGtz4RdMy
	 chb6Z1E65xYv/WT4Z8I0S2S4MPWpXiKmFfGopDZPRHO4LugRq7H4KQVoNr/DIAopaL
	 nPWJcQlYgW9J4pHG0JKXGdiBbof6EK1MJ4VDLc1XKJlpmTViHxqYoEvaxuUDn9dayu
	 7xahaO4HWKUBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4ED5F3808200;
	Fri, 23 Jan 2026 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: dwmac: enforce preamble
 before
 SFD for i.MX8MP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176913601709.2368645.17411798603536969153.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 02:40:17 +0000
References: <20260120203905.23805-1-eichest@gmail.com>
In-Reply-To: <20260120203905.23805-1-eichest@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
 maxime.chevallier@bootlin.com, francesco.dolcini@toradex.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 21:30:01 +0100 you wrote:
> This series adds a new phy_device flag PHY_F_KEEP_PREAMBLE_BEFORE_SFD
> that allows a MAC driver to request to keep the preamble bytes before
> the start frame delimiter (SFD) when receiving frames from the PHY.
> 
> This flag is set in the stmmac driver for the i.MX8MP SoC due to errata
> (ERR050694), which causes it to drop frames without a preamble.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: phy: add a new phy_device flag to keep preamble before sfd
    https://git.kernel.org/netdev/net-next/c/2153e151c27c
  - [net-next,v3,2/3] net: phy: micrel: add option to keep the preamble before sfd for KSZ9131
    https://git.kernel.org/netdev/net-next/c/fa1197a09496
  - [net-next,v3,3/3] net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP
    https://git.kernel.org/netdev/net-next/c/dc6597fab3e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


