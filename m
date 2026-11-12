Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481807;
	b=maYiRwsAf8o8y3DVU+ce2mRzR9/EkKYYI5HUWY8AzFCvx5PCWTQdlTMNVG69gKBXwSNC
	 E1bvYRa7Bm1jwXbI7/6Ww5Y79LOb5plTQ/nuLn0qiaXQv2jv8spQ/FiA+JKH9/s9NcasB
	 AWrcHbMZ83aOSV9m0cLT+naFiFuD91wPols28i/GC4H7RFO636VeiXxFjCe3UlLM1cjDk
	 wv2msaicB+HrypqI6ADVuX694cfiEHkzXi6FkslvvtBgSChPV5QZDLjJupMfdxRs336fC
	 A2u3CP/P6gG2+D7Gc+CxolaOUMd6z4r4L2H1s8G2KfqfO4B12H7OtLcBekleFsKJdnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3o+S+io1/3KXyuW9s9/1hpYnBD4T2kW7+RqGSG8XCbM=;
	b=2L+PvN3xnSZsy4C3d3fDuuchIzRopBaKsn5ia35XoN2OVswZNz65nNpJjVbbjyCnjnp1
	 fyMFakOgME1BT0UCBvedo19U/57/F36Rt47yjPo2KCk+Lj+/Cn+Pcva23nSc5M9kote0s
	 VZ5jZ8hF6JX/pnHLvyYy14yL7QgAw1DFG2kFHsS5zjPIcGAj7rK8Bc/yhTATJ/9VGmf6j
	 4gmndJtS5RA2WEhTmhjZWBvt3l+tWzaKLoxOm1m138QM5XTPmh+aL7/RFA2MDn6M3QAu3
	 pKqKJofWVw0SVF4iJzLXU2JAgMqCwi0qZcSni6GOsP08Uvtyk4UH6REUsDApD4LhEgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH8AacNf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D087606A335;
	Thu, 12 Nov 2026 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH8AacNf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CD91F00A08;
	Thu, 12 Nov 2026 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481807;
	bh=3o+S+io1/3KXyuW9s9/1hpYnBD4T2kW7+RqGSG8XCbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NH8AacNffgQHnCQHXthR/vBvCxJxEUtijQbHm9I9Q+udGpLl3UBR0vTwgGg+UfkWZ
	 6MZFGK1EIyIXrSu0/d7iJTZd3S2csUWaohlwV2tV+0MGkZc9RYhyDHp4MXcsaDHOr0
	 FvemAJnqE3uSKEtxxLYz0Dar5zAJR3BDC975r+Ip0pn11uaQYF/06Ool1juHXqIkNl
	 6GNQnzMaxkzIBS4RbxtfkcE7jSKOjeje9anMIADyj5cCLgTvYo8X34+fwfKF73G31V
	 18ByJ+VGBUTbM4oEbcbUTtcb0uPcpfOvdUw2dX2a766JW++/kTiZ050NwoSYi85Wue
	 QFHsCNHn2l6Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E29F3AA9F46;
	Thu, 12 Nov 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ag71xx: let both QCA9550 MACs use MII,
 RGMII and SGMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179448180592.2021886.2401928322346836474.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 11:10:05 +0000
References: <20261106221607.16215-1-rosenp@gmail.com>
In-Reply-To: <20261106221607.16215-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, o.rempel@pengutronix.de, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Nov 2026 14:16:07 -0800 you wrote:
> The GE0_SGMII bit of the QCA955x ETH_CFG register selects which GMAC
> gets the SerDes (QCA9558 datasheet, 10.8.1): when it is clear, GMAC0
> connects as RGMII/MII and GMAC1 as SGMII, and when it is set, the other
> way around. The driver only allows the second layout, with SGMII on
> GMAC0 and RGMII/MII on GMAC1, but boards like the TP-Link Archer C7
> use the first one, with GMAC0 on RGMII.
> 
> [...]

Here is the summary with links:
  - [net] net: ag71xx: let both QCA9550 MACs use MII, RGMII and SGMII
    https://git.kernel.org/netdev/net-next/c/7cb4cf087038

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


