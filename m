Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C237FF4B
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976854; cv=none; b=Z8MjmrIrJ+TXPM8qtmo5FKsl9mtjuGyh7F6QQgMlsrGm2BaGS/04MR5Txwvfzk0DD6E4GDqpA9/orcD5uTsZRy3LNS0GVOOvwU24kf1czoAl8nhlRoI7ayV7vgmb+rtrbR5MqAvZKHvNy78jLlqVNWe3Ly7FnVFED/KPDRwAp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976854; c=relaxed/simple;
	bh=oYWT7685t7Q2dbQkCoI6nOi/VxaKLeS+8fT4Zk5HKGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K7defvH40zaVfhx+rXzyvo3zOreS7z7y+bhsxvBJMpV0fAI7xnTk7nNVqFtus28H+NpOmcHAxtHUx55Qpt9xny3eOOqS+7h2S0RTWqNPW/anDnD+ns22K1foU7687jMB7VqiHn1mNfJxqSVcK6/Jmy1rtzG0vDZqtwdLKjzFupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHtWGU8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHtWGU8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA791F000E9;
	Thu,  6 Aug 2026 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976852;
	bh=tLhrZSYfZFUBVwV88CRsSepdadJ1aWBuXtgGfMB31Qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UHtWGU8yeoaZEOPyQK14eBYg5KBymZIX3xraMc/fcfqOK++JnyTLOBeYKk3rsYHhG
	 6E/mHBxiobXX8TMoUIaScJxPSfy3vSPye0ZLBNGZKnR6Kl6nVeqaox/bNx3g2dG+cf
	 fqMOlqW6aAp6PJoyp/bdp52f8j4eyq1oEiybHCU+CuQRf/67ZMLASleu42yWYAza1m
	 rdKiRFdu8KNttWAnfvYVcP3Jvtxc2kaYWd0dZ3BY6qFmO6h7IfVX403etquFW82vUO
	 QL90XpekjwQHffxq1dJ5U6LX5dvkxSNgLdQOlj1gQREkffgQj7pe0cyw3XebquwYnA
	 Patqw+5eRoiGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A58392FFD8;
	Thu,  6 Aug 2026 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597681188.580024.6589230766951383118.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:40:11 +0000
References: <cover.1785736562.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1785736562.git.zhilinz@nebusec.ai>
To: zhilin zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, yoshfuji@linux-ipv6.org, yasuyuki.kozakai@toshiba.co.jp,
 vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 14:12:32 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/ipv6/ip6_tunnel.c. The bug is
> reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,1/1] ip6_tunnel: clear skb2->cb[] in ip6ip6_err()
    https://git.kernel.org/netdev/net/c/f803c086399d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


