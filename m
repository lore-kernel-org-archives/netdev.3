Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663693612ED;
	Wed, 30 Sep 2026 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734211; cv=none; b=rbZmS14TckvWOmd9mhFCjFegyU/I5vfQ2h+boI/9tZF6SvKSJoMFllKGa3PK7kcHExGFTDlOFAkfhDMY2xPxCIM/GsVIaVTO2yJq09g/IvkC8PTHb+gi2WqgUL7gdykltKUDmZGrHBaae0bWzBYh6efP4QtLX1Y30qyz7aqwpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734211; c=relaxed/simple;
	bh=OudPYF567QuqlLLnL/0kRpGRdZbYIr3iuxsNHfD2UJA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hgDQQcuy8Cq5v5T5S3WjlCXKp19sfDOas2M6+WQGku2RgIYF/u/jm45ObsGA+kVjYiXjoi2gpUugY9dNLXqOedcOQg2HCTseRYLB684iB+m5LyWybgmMFWHtJomH6x1DwLsrd/hkq1bzKzxKqRX2p6S9J9tQd1FYpgLkwoVzGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyZD2SVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyZD2SVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E9A1F00899;
	Wed, 30 Sep 2026 02:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790734210;
	bh=rjM+1w0TrvdqguewNyTYKTaQBWb7xYk28dKvIBdPPGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OyZD2SVk/JRWXVL6hFK9dLQbvDLu1HYiZeqjoI7KYtvQXsSVSMk4pb8wp/Il57nA/
	 R7fUPFlQztqIiyCMr9znuIQBBw6MEcwnCceCGHZAtTdWppahVQn1W/9kayg0wYhkqW
	 TAn6puWEbbgu8XvPZxXPH4yFvcwkAGtrTQT8Wm3bNS5bGBg1p6M8P++54OsCKx/GhP
	 n7Jyc7YeEt4YJfDTHbWUd0pVWEUue5+WjWuPoSZjmDbwbqKO2I+pdN+cDCmi49KD72
	 CNIKoQaY030+iF7DHVerjt+pH7TgGHJTb37qIL5Vlykxfj9kwZbx0BLvyJAC1IDNd2
	 Jb/4d57QiOOAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F152D3924FEA;
	Wed, 30 Sep 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073420852.1211220.2021094445984738152.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 02:10:08 +0000
References: <20260924180607.60932-1-marex@nabladev.com>
In-Reply-To: <20260924180607.60932-1-marex@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 xiaoning.wang@nxp.com, claudiu.manoil@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, imx@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 20:05:19 +0200 you wrote:
> The current eMDIO MDC rate is 558 kHz on i.MX95 B0. This is very low,
> but also very compatible. However, for example NXP TJA1120 PHY needs
> at minimum 1 MHz MDC clock and 558 kHz does not work with that PHY.
> 
> As a minimum change, increase the MDC clock to 2.5 MHz which matches
> the 802.3 specification. Also, even old PHYs like LAN8210Ai, KSZ8794,
> DP83822 support up to 2.5 MHz MDC clock frequency, and it covers the
> NXP TJA1120 as well. There is no known rationale for why the 558 kHz
> was picked when the eMDIO driver was added.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
    https://git.kernel.org/netdev/net-next/c/587acb86d646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


