Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F633FE10
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540046; cv=none; b=pxe9n6E42npvrVfu0HCZlDZ+AaMc2v7J59en/4UUGLfq+A6Fo4tjduBiBjrixR0Vfh8kuqlwwNQm7RWBMzLRoZHeOZ7XAYtbzO1Y5tTVoB+jdz7s9rHq8Sk2XvawmPAP4KnbHwg3cntnU89kchjUyb3/fbEepdDWfvtHySTZwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540046; c=relaxed/simple;
	bh=+mzUMcLNf3pr2nPtyWyWaWUJX7n7Fsj4YzjT+x5HTcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRz+SbQaj3hZhWsZTqdqTA7il7whI1itmeXYGR/4+Q9fjiIfHkIq6iN99K3Xqwykqay8RnO1PVcHIpZsyhGPVrE1uskEbWX3kteyA9MbwE7hRkDfIJCQScFbgOTH0GCA2AJsUW66ryAjAzAT8M2DlHF/s9cuUq2rlfPnrRwNQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSigi1lh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSigi1lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2B0C2BCB5;
	Sat, 18 Apr 2026 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540046;
	bh=+mzUMcLNf3pr2nPtyWyWaWUJX7n7Fsj4YzjT+x5HTcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JSigi1lhyduw1Bg4I2E6zd86tw6OxKsuqEjkMss82nWyIup7xXwGwx1cL9DbBYvu5
	 YOVg/wYX/aI0eh1OUGCIlx9s309pU4x4mzdBoqXc6G0ZuJVF3eJm4dVRRsfJnqE7MM
	 ea2uSMiIDZbATiGL7wrqWucmP/Nz6e4mr2KI7k5zAQ7ebIriX/FeLVeUEVUsk05CdW
	 JRP3zCGg9ht07r9UGTcxieBkV5GQ/czEdHYuSAy/dT30n8ThvVvs0W6xIPfsrTijs9
	 8nb8SE1r6mMMoFIu7x3zurSyA8TTwda93DcybpIQkrtowW7dvP9dErHhLCZH8LzorS
	 ZK260zLdv8ECA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF9380CEDD;
	Sat, 18 Apr 2026 19:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix possible UAF in icmpv6_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177654001279.508728.6020617181881359392.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:20:12 +0000
References: <20260416103505.2380753-1-edumazet@google.com>
In-Reply-To: <20260416103505.2380753-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 10:35:05 +0000 you wrote:
> Caching saddr and daddr before pskb_pull() is problematic
> since skb->head can change.
> 
> Remove these temporary variables:
> 
> - We only access &ipv6_hdr(skb)->saddr and &ipv6_hdr(skb)->daddr
>   when net_dbg_ratelimited() is called in the slow path.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix possible UAF in icmpv6_rcv()
    https://git.kernel.org/netdev/net/c/f996edd7615e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


