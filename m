Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265214;
	b=CL9cX8tv+Ww7BvbwU/GRs4bELnsfT+dqGkH+xnRKnLVESZlYTuC/h1kTYgLEUsGmYJJf
	 sYIw5gqhjbkCnYAkRJqEA2AzRCDdT2NFagpNyZmhGinQ5zVk4e6Mt0PoBm2oADsEDpPOB
	 yt6N0C98ylByODq1MKbPh+q+MJReallavnCLQ6X6QEpraZwIqRDiOEGQGnR1lELkyBAIL
	 xZKU/u0LzuDCAqhcC5tUZ7yxh1V+uWBpfzBhVrex2iNN3an/4XtjTttyKVt4f/T0RbRGS
	 tFkOKm6p8SPgHw+zJ1ngghcX4dLIgkCzB0bGGcIzGsDsDkgCX6G6ZA+J6fCm6kMbfwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265214;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=20ddS1lUPXY6gGPLXPBCRXNkLPEvJTmKmOT4cVSb0SQ=;
	b=LPlZIAa4TWUoykLRpOGzbpUzsqpA71C8hPQ0FoqR2C7gtS1f+QHm4IA3HeQh4NY5aKE7
	 gdsLdNeUxBftk11Pz/Xh9HXOnjvp1jUpXrutNRP1xIr1C5OO+1u+OOEzQsQanLXoo478C
	 WnLquHoHf15wEkKa90uOxfIBlcOL43yhdVFfRqBKHMGpZEgLeK3zkDNMzGa0U7cqbq3Kb
	 wWg0KnHOr+VwEJWekOa9yv/NeRyKTdx6tAXVkQHfTHzpnk/qHoyo121qPTbbS2OZya1v2
	 tOAPddRmiLo7UDIA9iP7eHIirwr1KlSfHcKwr9BcgdeuM+T86ilj9EtoJFkJ2DgAqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl8R5uEp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A562606A32A
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl8R5uEp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E333E1F008A1;
	Mon,  9 Nov 2026 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794265213;
	bh=20ddS1lUPXY6gGPLXPBCRXNkLPEvJTmKmOT4cVSb0SQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pl8R5uEpXMmuR+q2EUl3K+ZdpbaFnLGaD35DGzX7P3FXFwRCrLhTXLlJ7O/m864C4
	 UnwJQtXePDDnuWm6N64x1Iqw73Qe/Bv5QJla7sSygV5i/VC5xjHgJIlqIEDBQ4yI5M
	 5p8NVnAss4c1z2/o9W0p9iGmdcm642NmoBEgWDgR8mrGxkmyLSGgfCJxHixMGmMiGW
	 PKnX5NTGC5QHOdnJpztDDAzslVpOwIoMElleWHoy3heCGHZqXSdo+YZzUscFe5gMLo
	 2BRm1OAU6QPGPJdERG5PGqzMGYHUizeg0/NvQ1QPTMifZGepcR5qnZxth3SLhHhZvk
	 +G1ohHbV8ivgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82D3391AF99;
	Mon,  9 Nov 2026 23:00:13 +0000 (UTC)
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
Subject: Re: [PATCH net] tcp: rate limit receive queue collapsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426521242.3532311.12175474305421546096.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:00:12 +0000
References: <20261105124043.1543405-1-edumazet@kernel.org>
In-Reply-To: <20261105124043.1543405-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, horms@kernel.org, ncardwell@google.com,
 kuniyu@google.com, willemb@google.com, mason@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 13:40:43 +0100 you wrote:
> When a socket is over its receive buffer limit and its sk_rcvbuf can
> not grow, every incoming segment that needs memory goes through
> tcp_prune_queue(), which runs tcp_collapse_ofo_queue() and tcp_collapse()
> on the receive queue. Both walk their whole queue, even when there is
> nothing left to collapse.
> 
> A peer can trigger this walk per packet, without refilling memory:
> 
> [...]

Here is the summary with links:
  - [net] tcp: rate limit receive queue collapsing
    https://git.kernel.org/netdev/net/c/c2213d9b61c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


