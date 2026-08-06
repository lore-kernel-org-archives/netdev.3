Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4A3A7189;
	Thu,  6 Aug 2026 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978057; cv=none; b=Km1EDdQVhjuZatj1+Sw/YDZ7k04b5P8Yvk5h4drBqDsKJ1E3lABQZ6uADshe9BPmnL2A9G/3wMtS47fo3CrYpd6TzxjB//SCmZDIOPL58OQgNS91waQC+oPWTK55DOzOU9ejVUrfnvZBnog9frSEnuFGESOaZVwlEONfnH36++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978057; c=relaxed/simple;
	bh=pwtk+ub9EiAczH9IMbvbyibdmAgCHuAAjVhrPM+tyow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMqFQ4ZfA57oRZR36c8Qg9TVeXK5XIVAbF+fDvWsVRbB3K9pLnyS/KuHUimRkWMG3oNRafESPZF7pGMIYYiD3Uhwxa392Yop/hlHTupaYqak2RTHlRVvVq9sjz3Ls4t6diXBW4UBuabov2ncYtQeQGyXPQi8Q1E1FkWZ9Z6FGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9xtGYk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9xtGYk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326AC1F000E9;
	Thu,  6 Aug 2026 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978052;
	bh=IIhmkrm+bivvoiY9RIC6qWlOZP2USxIOQwE0STV/n8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F9xtGYk0dCauUJReoxX2mp79TFWFJUZwoS31L2zbEgMGFKtFIv51aqqsFKP7ycT6t
	 2bNYFIOqhm9IkTcZ5/Bz8PPzLRqshVOJVh9eFnXWBKh1iO/1+ZfmEJSh+DL2rcljnH
	 PU5ZlOYEj6PXbYH7iVslxo67obDvsJKkubM7doa15slYBkXkjaMFyS48nOR2umvgvZ
	 f7sjUc6jRXnrOdU51riTVJnCSLoXQEomyeT6sNrqWhpfnizo4nP3fen/dTufHg15fw
	 ftDYY3XiWOAzy+jpY5UvKATx2PX0jF4DY/H6fSa76waRVjuO7uuBmqLA6IlMQ7Vt5w
	 a1AVzUyB8dMnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198CE392FFED;
	Thu,  6 Aug 2026 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: nxp-tja11xx: cancel registration
 work
 on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597801163.587098.12117115424912791664.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 01:00:11 +0000
References: <20260801140643.1871-1-getshell@seu.edu.cn>
In-Reply-To: <20260801140643.1871-1-getshell@seu.edu.cn>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Aug 2026 22:06:43 +0800 you wrote:
> tja1102_p0_probe() schedules work to register the second port. That work
> uses the Port 0 private data and phydev. The private data is
> devm-allocated, but the driver does not wait for the pending work on
> remove.
> 
> Store the Port 0 private data in phydev->priv and add a remove callback.
> The callback cancels the registration work before devres teardown frees
> the state.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: nxp-tja11xx: cancel registration work on remove
    https://git.kernel.org/netdev/net-next/c/1aae367b1646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


