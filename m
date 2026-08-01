Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED939D6CC;
	Sat,  1 Aug 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548463; cv=none; b=rj+6zAGrgPtNaH4KLAIJBiCz+SCKKP+/L2l/ti+YHzbPqit0HyG49SKd3KCTbqOuThYCxtilanAiGkwcOlON8PjrDKhO8eDF87ZtPWO3bEoh3ndjyTqEQ4lrYAZekyI+1BJ8MenvLfpU38C/4JsC8RHuZKJkhPrFRPyrH2cDNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548463; c=relaxed/simple;
	bh=Drzl6XK21MQpO/vD1IUDqtKdaSdqm2l6HKzZCXtI5jA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HCieJL+5GItmzJfYePYSMhaUB/FNcT7kHJ1l0uWiEH4HNVZlDdbOaFu5fZtSwhQCR3EWcNYnepIn5Et8XTnMBWod4IAOiMVjwQe8PIpax5+uwymPLCgFM7jyyrf3QF9HKL+5I+bKQi0qzUp/LI7HBQUQIhMJdQBwgYAYzRVu9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieqOFW3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieqOFW3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D00F1F00AC4;
	Sat,  1 Aug 2026 01:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548462;
	bh=ePEsaoq7ElQ/PNFz+V9hgdJDa7BwPssvUnUPRYPISbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ieqOFW3e8kPPgAPMIp3ai824lhzLmEn1jtVDpEu2oSPaR6kjs20j/JAnqL/DrN8L1
	 imzzCrOsmTh3ZRdbmxkgES/Teh0l2XS82Mo87XTeedx8h40+2VtrJ4ssh0oJM69HEv
	 SFsTbQH6sxbJ2q+G0lbHZ7CiGect/RrjXBnPInhMqfgpJr9Ml8oa/gWQxKzyRP/fkD
	 4Ijpk+chxRWnLDnBKvo/hkbeG3ZcX5RY3VWXHSWVpGwhrEJfEDWyow6ykqj7AHEFhR
	 Cxt/pPptYQzTK2+OyADA5wsEL9qnSIwm5hHkdtA6iipbsD4L+U97HECMtGFhnSEJqM
	 BZUQ1lEgwe3TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19875392665F;
	Sat,  1 Aug 2026 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/5] Add support for RTL8261C/D
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178554842463.979996.14715044544047954238.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 01:40:24 +0000
References: <20260728073106.1515-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260728073106.1515-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 freddy_gu@realsil.com.cn, nb@tipi-net.de, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 vladimir.oltean@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 15:31:01 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add support for RTL8261C/D and add support for loading firmware.
> 
> Javen Xu (5):
>   net: phy: c45: add genphy_c45_pma_soft_reset()
>   net: phy: c45: add setup and read master/slave helpers
>   net: phy: realtek: add support for RTL8261C_CG
>   net: phy: realtek: load firmware for RTL8261C_CG
>   net: phy: realtek: add support for RTL8261D
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/5] net: phy: c45: add genphy_c45_pma_soft_reset()
    https://git.kernel.org/netdev/net-next/c/3b63c19e64f8
  - [net-next,v11,2/5] net: phy: c45: add setup and read master/slave helpers
    https://git.kernel.org/netdev/net-next/c/d7722c03089e
  - [net-next,v11,3/5] net: phy: realtek: add support for RTL8261C_CG
    https://git.kernel.org/netdev/net-next/c/b772b5ae4537
  - [net-next,v11,4/5] net: phy: realtek: load firmware for RTL8261C_CG
    https://git.kernel.org/netdev/net-next/c/a04171a1cf32
  - [net-next,v11,5/5] net: phy: realtek: add support for RTL8261D
    https://git.kernel.org/netdev/net-next/c/f0667918d5fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


