Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED23BB9FD;
	Thu, 20 Aug 2026 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254290; cv=none; b=Y9U0bFRi7AhyWgLdr8E3t2Su6xXHjWGSoDLlgAajH8+BD0xu9dWxOH7J5lbyVPcG5iesKO59/ooPDALP0ehSBDwHUYrpV68GFqhXVi2Ac3lHDnoyBZDkTqdHKULR18GdK6v6JuVxIu/zfFHlsKX4jSI6gPzpdGIDCeWdJtTUHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254290; c=relaxed/simple;
	bh=maz2zRskyqzDCXuLvPo1sYBPnIfN4LDYuI4ZmcMTYmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L9/I1X6meLnRci/bb0pMg3psWO2vGmLrPzG3uNJJJueJfeJEhhe+B2weXAFiPslj2O6uciCYqQVDssLP5d6nl8Xz4Uy8FhHjrl2uostdWuqVjDH9xTQFCtt9862FFKj1nO7qEvxVSv/oekBEfnLHPgxMDx67asYzoxAb5IigaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO4SZxoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO4SZxoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3E91F00A3D;
	Thu, 20 Aug 2026 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254286;
	bh=2VTYN3MgxEq+G5/2VOWw15orGhBdyNhe8pssUuvz/ZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MO4SZxoNudDT9Ry7if9WLygukSRfAGNNrNAehUiY9zPA4C1v6M2TxamlcbImjBB8x
	 WGgzBnq7JTma6wOb/6qTkuhOX+jzy52tMugdtc7Pr49AfKSPghoGS2a1T4atD9npKV
	 lwNjcb+fu5tOc4XT6mEsY2FMK0GGqqzYDNjnF69FwoxcL3CmnBHlPlD/AHgjaOhoYL
	 wtCxU8OEJ69Z1ona6ncw7DiwB+TZy79r5lYITfCeUyh8ZLJVveubgnH2fH7WmIYc6l
	 bIATlNF6nORzKv/NMQ4o8DtoYcpKQBiQmBFa/TC9NxzqGs7+7kAw49eD0Glxjt3l3m
	 GUsuy+0Yo1M0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A63924459;
	Thu, 20 Aug 2026 19:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] forcedeth: two register-window bounds fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725423663.446762.8387913060215636639.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:36 +0000
References: <178682367884.3748309.5288746298966501007@gmail.com>
In-Reply-To: <178682367884.3748309.5288746298966501007@gmail.com>
To: Marek Czernohous <mczernohous@gmail.com>
Cc: netdev@vger.kernel.org, rain.1986.08.12@gmail.com, zyjzyj2000@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tobiasdiedrich@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 21:54:38 +0200 you wrote:
> From: Marek Czernohous <marek@czernohous.de>
> 
> Two bounds fixes in forcedeth, both in the same shape: a loop that walks
> the register window one step too far. They are independent of each other
> and touch different functions.
> 
> 1/2 nv_suspend() and nv_resume() save and restore the non-PCI config
>     space with i <= register_size/sizeof(u32). On a VER3 device that is
>     exactly the length of saved_config_space[], so the last iteration
>     reads and writes one element past the array, and on resume it
>     writel()s that element one dword past the length the driver mapped.
>     UBSAN catches it.
> 
> [...]

Here is the summary with links:
  - [net,1/2] forcedeth: fix off-by-one when saving/restoring non-PCI config space
    https://git.kernel.org/netdev/net/c/9393f1d656a7
  - [net,2/2] forcedeth: stop the tx_timeout register dump past the requested window
    https://git.kernel.org/netdev/net/c/cfa9178ce2e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


