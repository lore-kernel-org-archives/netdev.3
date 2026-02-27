Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8A329361;
	Fri, 27 Feb 2026 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163001; cv=none; b=h7pZOf41hJgEpnHRLQ45fpj/yJr+ZfJ8L5RO3VFNhFb6W23kkMufBHljGp+KHIr224cTf56JdkTA3JtWcQitDn6R74UNLEPXA/6ao9fdYSc4Vdh3nif/wYEa+Y4hUoN7ciUh4zixj9Ks6KNfYDHdpGaJay2lh9CT0uB/AC4MAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163001; c=relaxed/simple;
	bh=iiOwXb8uVifSZ7PySOcOmZe1Jp2tN1bt6v5sZO3UzmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MADAPQSWEH6VLNH2m65njiSFmWSHkuHsTaxtpXofMMfkinBu++2gM1rD9Bagk2dFOzaOlDtGXUd+ebOFtTahW2K9DIk5qHStjOC3AULOMMgNe7cUAZ+dkz6nnqwAzYnfsUwudyBAmzPkretzdJokiTdzi2QOYwsRQNhQSGtoyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNft+ry0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNft+ry0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F109EC19423;
	Fri, 27 Feb 2026 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163001;
	bh=iiOwXb8uVifSZ7PySOcOmZe1Jp2tN1bt6v5sZO3UzmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNft+ry00BO5EctoGu/4PmXQQ86TgRcDmWzuolyeWHWAhmBMewxuGH3u7cbn7Iy2j
	 LHrz9OM8PqFS2eZMNfVhLYkDTaVwatUHrYSuoU/z+xNNK36iTGavzwvQI+sUb0Jh9A
	 77JHtLwLPJO488k/5YUsBq4eMtDS0f+DS2tjBaJjMDMkT4dRpb+b35rqD0H2K5QLxc
	 Uv2jyAsB2vKScYj1VszyfeOvQJFAjmhMTLPdbT2D+ZX6S8xo9hyR1nYMX4sfu+zKvC
	 BGxsH6VzL3qa9ERcV7G6Fc4BcFVPBrKkGRuKPIIMrkCQOTBs4YyQSb6PuT1JKYwWil
	 njZyfXKeLxDsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE81393109B;
	Fri, 27 Feb 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: Avoid double-rtnl_lock ELP metric
 worker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216300504.1958105.15758262442071363378.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:30:05 +0000
References: <20260225084614.229077-2-sw@simonwunderlich.de>
In-Reply-To: <20260225084614.229077-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 github@grische.xyz, freifunk_nordm4nn@gmx.de

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed, 25 Feb 2026 09:46:14 +0100 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> batadv_v_elp_get_throughput() might be called when the RTNL lock is already
> held. This could be problematic when the work queue item is cancelled via
> cancel_delayed_work_sync() in batadv_v_elp_iface_disable(). In this case,
> an rtnl_lock() would cause a deadlock.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: Avoid double-rtnl_lock ELP metric worker
    https://git.kernel.org/netdev/net/c/cfc83a3c7151

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


