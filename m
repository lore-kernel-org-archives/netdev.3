Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D2336888;
	Tue, 21 Jul 2026 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660493; cv=none; b=Vs+xvP1za8qL9bFR701Ec5G1pgmclEMt7yzIU66WONSN96DbZuRoxUHmc0oOXuPBI1ihOjTIyxnttl3gmaoZQ64uuHwM7Z04YILmLMNMoKwwL5jWgEZmd9uzixSjCTarUWAed5RnDhOF0/M1HZS/XiI5eY+KacOA8Rj9dcAgUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660493; c=relaxed/simple;
	bh=FcwGwUO5rLAzfAb7+Q02Uk8X5Dz3SR1YtANw+41qUkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gqk4wd6zXK6Lt1Y58CX6+M3T83g2I9G6Yy4vadCuQzi/uPRwOznkXwVkfxThL6U8fNxwEIielWUIOoLRgUFcJtcT2zsvIqLIN5QrVJu8d2RBvNo88XTKRWcub007eGVFGywuc6mq/zQxRlt6y3KgxfpTEr2bGWJOmJhbgfwuvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nrx9S78X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nrx9S78X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D5B1F0155B;
	Tue, 21 Jul 2026 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660452;
	bh=ZG8xDpnsHhfZGPWEaA4RsUcchwltDIlw0KlQGWpgUoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nrx9S78XUIHgBbLZlsEQA9AgO/teYRz6RfBAK8uCLSmLrZF14rsFY59fGS+un5d2z
	 Gdp2obdI287sVqii1y04jziyZZi9zE+BkgwiE96aM1JaB+TP+Mt2ULdXA3sVPcB/b9
	 uG0QF6KN1s/ROLtUAcrYWlowm073R2hVZpayHJ5tgM55CsOLgqsVha2/4FUowdYEaA
	 Xt7STUzGkHJWpRclaD8POiUCTtEpHJouX28lPVYJwHSuc0zaQ62y3ztNkikMeFECJj
	 sKE4tmb47wYYLB58WCPVAVK0tUrzpuZv4sKDBQFfc/eGyM9CkGYRVdUV/XQ/GiBhjU
	 7rxl/eFHcBZXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392F39253F6;
	Tue, 21 Jul 2026 19:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: dsa: yt921x: Fix external port detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466042214.954483.3802547284881614132.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:00:22 +0000
References: <20260710100000.3018614-1-amadeus@jmu.edu.cn>
In-Reply-To: <20260710100000.3018614-1-amadeus@jmu.edu.cn>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: mmyangfl@gmail.com, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, olteanv@gmail.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jul 2026 18:00:00 +0800 you wrote:
> The YT921x switch has two MAC ports: 8 and 9. Currently, the driver
> only allows port 8 as an external port, while port 9 is not working:
> 
> yt921x mdio-bus:1d: Wrong mode 23 on port 9
> yt921x mdio-bus:1d: Failed to config port 9: -22
> 
> Update the external port detection logic to enable the external PHY
> connected to port 9.
> 
> [...]

Here is the summary with links:
  - [1/1] net: dsa: yt921x: Fix external port detection
    https://git.kernel.org/netdev/net-next/c/f2596ce59b15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


