Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6572D6E44;
	Mon, 31 Aug 2026 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136274; cv=none; b=UsfMEalgLgycrDA+nZWtJwSw2YWcfRB2W0rx7kLX75GBASs4gFuqSX/rqMMDVFb+cd+bKzh/rpCwyw8XNZc2y1d0i6fALym7w798IdKbj8DOU1akiWgzc7icxANsEnkPiGRWQ34kXuBuHu/ijE7FSkDdWypze1QeQJ7afsvn0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136274; c=relaxed/simple;
	bh=96aJ3VCBX7KD0qRumoP2E1GikYgtU7bWw2M3hkV6lLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jE9LsYM/rUf9yzeIa0VbP5z5sNM6+f2N5HJeRXTuDM6um9ArFnBJL2lYpXTR5r3FgN/uNQNngqxCY9cY/4M8rPxxQe+u6eAv7VU8n/SG40T+izoeh6n7xTt/QfgRjY2sOR/RyU9HfUWbIgUrtFHiUSyl9JEv66K6VrU5jCQGQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsGyt4ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsGyt4ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B951F000E9;
	Mon, 31 Aug 2026 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136272;
	bh=YGt+e6fGrUSj1AFyydsWDKZOb+S30Q0PQ9RjCFLvlR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XsGyt4kub0KT17u9dHM2tEniBsrU0Og7JCio8KJclJogT7HDssCJcBun+FeNmH6XM
	 jB/zCJA5vcIs37k/Rq01LV5T3Wid2ktDIk941+VkFXBUsNqrJ9x5hx9vpGp/mkFlhP
	 aCn6Tcw4OjDMw95agnyyeuv+3zRs5r9CYhpgtRwtV/e5KE4oK4B7z6JmBMwtKc99eR
	 wsaLs5wGUtaGjxl96pv5a4Yj17j09Qc5MbtdAQMsbpifCrb7CHZ5ghvRo/11zqm2Jb
	 eV9QjrhGK83ZQm4bUlzJUH30OgLEtO0Xtoo799yv+u74V4XUd/pxKAD3WfkBsgJehc
	 t/E0fSgTuzsXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C5B380CFD7;
	Mon, 31 Aug 2026 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/6] net: phy: fix cleanup after probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178813621634.3966634.2247622864690119590.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 00:30:16 +0000
References: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260823035600.188864-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 kuba@kernel.org, hkallweit1@gmail.com, chleroy@kernel.org,
 qingfang.deng@siflower.com.cn, hao.guan@siflower.com.cn,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, luoxuanqiang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 23 Aug 2026 11:55:54 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> phy_probe() initializes the PHY driver, ports, SFP upstream, and LEDs in
> stages. Its error paths do not always release only the resources acquired
> at each stage. It can also mark the PHY ready before all setup succeeds.
> 
> Port setup also leaves SFP cleanup split between phy_sfp_probe(),
> phy_setup_ports(), and phy_probe(), and default port setup ignores errors
> from attaching the port to the PHY driver.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/6] net: phy: split phy_probe() error paths
    https://git.kernel.org/netdev/net-next/c/b6d201d97145
  - [net,v5,2/6] net: phy: unregister SFP upstream before port cleanup
    https://git.kernel.org/netdev/net-next/c/f558204abcb9
  - [net,v5,3/6] net: phy: set PHY_READY after LED setup
    https://git.kernel.org/netdev/net-next/c/52dd7eb1a33e
  - [net,v5,4/6] net: phy: call driver remove when core initialization fails
    https://git.kernel.org/netdev/net-next/c/afd5aecd3c07
  - [net,v5,5/6] net: phy: propagate errors from default port setup
    https://git.kernel.org/netdev/net-next/c/48378efebbe7
  - [net,v5,6/6] net: phy: avoid double-free after LED trigger registration failure
    https://git.kernel.org/netdev/net-next/c/f7f619ecda57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


