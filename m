Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD219C566
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312617; cv=none; b=meEeXVllaf8vEZAjSx269UHHHACyPxVobllKE+6+spV0EQqS8HWBQbKfRb+Rm5llUlYwmbEifnBxrZi2tfMODyvx1/+I8mM3DAC11n9u7CJv4U7M9HEXcm4D/1NYWB7yqrMi4AHZeMgL82lhrLkyDwOhOO8+M4xjL48cGLTExUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312617; c=relaxed/simple;
	bh=nmhl7oJPwOQKGhvS5Y0LaKirKo62bY/yf4EL+9kA0OA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=miKdDtjC5BJ4lbiBC+NlUYtCe+uLCo8DufevcsYM9U/hZJxCMAXd65OYRoee12KEadOCzS7pEiXKw2edrRfzuKVJCwIPf6Fzj2Giwd2Fj7vRjVSJmSD08c1VPLytrjR6WzuqIcVo73+pgJgSsgyNdXGEvC8OBc9pQqTMl8DOVEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/Stjmdv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/Stjmdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946A2C2BC87;
	Thu,  5 Feb 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770312616;
	bh=nmhl7oJPwOQKGhvS5Y0LaKirKo62bY/yf4EL+9kA0OA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F/StjmdvehKAzGGyVRuefB9Wz8w4AvzGJhIV2ZSFJQgxLah7OT3B2RVmRNjpfXNEM
	 91aaioJzFFMtuYgrQP+Yiy428mYEoz0jqtTmtpXWSrP6FtS0EDDKKWo0O6OPR+agZF
	 PQsGxIlsMk0K4omsx2ch1cJEiOBc0TsAiBNFutCVn4AxMXvKD9Jf3PYItHezUrH4Dk
	 VOSiYNAdBTmNzJjHcQ2kznnntFWjwpg3qbU9b/a//4GekZak5knSCATNl3m6VQzTn+
	 KpymdsP2FvnP2lnGrZeDISkhfhjxLkraW6ZPMq1e+GtO1sE10Pa8l+qiKxczb2LUs8
	 upXQlFpC7haaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8534B3808200;
	Thu,  5 Feb 2026 17:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: stmmac: rk: final cleanups part
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031261432.500992.15994609944563824228.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:30:14 +0000
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
In-Reply-To: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, heiko@sntech.de, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Feb 2026 09:14:02 +0000 you wrote:
> Hi,
> 
> This is the last part of my current dwmac-rk cleanups.
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 361 ++++++++++---------------
>  1 file changed, 150 insertions(+), 211 deletions(-)

Here is the summary with links:
  - [net-next,1/6] net: stmmac: rk: introduce flags indicating support for RGMII/RMII
    https://git.kernel.org/netdev/net-next/c/d323769d64f2
  - [net-next,2/6] net: stmmac: rk: replace empty set_to_rmii() with supports_rmii
    https://git.kernel.org/netdev/net-next/c/a9d4aff670ed
  - [net-next,3/6] net: stmmac: rk: rk3328: gmac2phy only supports RMII
    https://git.kernel.org/netdev/net-next/c/f365541bf7b6
  - [net-next,4/6] net: stmmac: rk: rk3528: gmac0 only supports RMII
    https://git.kernel.org/netdev/net-next/c/d7d92037cbd8
  - [net-next,5/6] net: stmmac: rk: use rk_encode_wm16() for clock selection
    https://git.kernel.org/netdev/net-next/c/5c1fc7cb81df
  - [net-next,6/6] net: stmmac: rk: rk3506, rk3528 and rk3588 have rmii_mode in clock register
    https://git.kernel.org/netdev/net-next/c/b10d56b0db3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


