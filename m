Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B503EB81A
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404466; cv=none; b=hZV4Pf6MtZa/bBt0gHsHn+DOlLs4fO2v/lcyvLIFy+Su7vCnUx3DDVC3StLZF4Os2MY5OZLk170Vp/6BB2PHSGpTA3Qd95svpITtZVvWZAttL6xQjhbiDCzYBVKzoTHyCcvRY+gdQS0Jz+NzETqTLiGcdwMkH0c5rmm+xYQg4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404466; c=relaxed/simple;
	bh=KSbqgoHGNzYBrCqqe1NILAOfZlR0Bog8V5qxiem35mA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NcwdygfLgIRtxkoXZHzTCh+D0KkF/8W5ZbENg/5lghAbExK/m6Z4CCf3k1rEPN+NhXQf3VjAK7NxoOyzXzEW8dT/ysDv/VOz1xtfOFpa1QUukoq8TgMpJUn3mv+galp4lYz7FVte+ZmU09ijUM4wqjIDBjEGD1xrVkYY2lvLo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA7E3QkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA7E3QkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F8A1F000E9;
	Thu, 25 Jun 2026 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404464;
	bh=R9YbzsmjCZpBRNgWP4J4vs+VqRH+hvRpRw4HededISQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FA7E3QkVYXbqeDgnetlcYUDiB1QO1vkZXA1R2KCbiuJYxltqYwkZGOGmCnoD5HstU
	 TXnhn1b4Wb1hKBWMY3M6skuxeXOuyJk6ZtImFfZd3MhjYpAGupb7a6rAzdjd9AzYHp
	 58JUEZaTwEWmTh1co37VXfc1OmUzIOFh16iEKKQIzuPEgVexaRs4gZUoXnXSd4ymMW
	 ElS+zjQvSJ0U/B8RR3rRc4pPGyCOnFmwjux9ALceOGGEmA7f1vkCtdF2QGZBAcO0Ty
	 FsFU8LQwEtb8GIshnN81uZuuo6cfzP8kplwo8dB6LjWHSXd2EoS1GfHhs/4SotTGio
	 Ym/r6e9zoQ0JQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08A53AD449A;
	Thu, 25 Jun 2026 16:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] tipc: syzbot related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445253.3803792.1258406668336193421.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:52 +0000
References: <20260623173030.2925059-1-edumazet@google.com>
In-Reply-To: <20260623173030.2925059-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, lucien.xin@gmail.com, jmaloy@redhat.com,
 tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 17:30:28 +0000 you wrote:
> First patch fixes a recent syzbot report.
> 
> Second patch is inspired by numerous syzbot soft lockup
> reports with RTNL pressure.
> 
> Eric Dumazet (2):
>   tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
>   tipc: avoid busy looping in tipc_exit_net()
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
    https://git.kernel.org/netdev/net/c/7116764ca53f
  - [v2,net,2/2] tipc: avoid busy looping in tipc_exit_net()
    https://git.kernel.org/netdev/net/c/c1481c94e74c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


