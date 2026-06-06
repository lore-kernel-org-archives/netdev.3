Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020EC1A704B
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707626; cv=none; b=nbs6dUUipfCoz4cGAojBOu5Gdd7B4AISEUqlmVR0ZDXSBy6UO0JbtegMZ2gTzoujzXcWo1A9d84TcJjCRrX5MkloZOwXViZ3m7AMmY7fTrmQbB/oDMr9FfId7KKMN+3gTENR586niTuLpU1FXZ2Jd+iRQDpVzEIDgME6nHrW1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707626; c=relaxed/simple;
	bh=2dt3j7xK0yTYyQmx1h8DuZ6BVD4GTFhqplrD6TvgORg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JydF5qqkRSjOhbQ5kqoRVIn7daevKZSBlf37hePew/9VxdVo0xFD6XR9PbYshbnr9XRhApgPiJFhKIfwiGukAOIZe+5JgurT+Mvj9BnIapxjZms7GiCt8+x2xJ9l89/Iv2Vmway+v6LfkRcsd+pIMOGXSjw/5Cq4qZYPQ1LO3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QACf3VfO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QACf3VfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5E31F00893;
	Sat,  6 Jun 2026 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707625;
	bh=a4LMEFoS+tUuds4DJWXU9nFxPwxAUDbm1tSBiNrNZeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QACf3VfO78+LprqJVfNYWCH1KS3GdaOMRoaXTdqUeEUynjrSRcWvmYZ8ygLiAwfJS
	 QcX+E/FRAf5+Vv3J4aUC+VviC2lLMbAPdtJ6zW75AK1PSmDabvZD9AdqXanq9FPW08
	 uijS9IBXL3vPoI6NKOshgTRP1ypjpYpbjETYHJublYxLTOd+FuXqMY7hiVMmKpm5ZD
	 RrkOsvxARf9Kqh44j2mjvaw9IQeo0vPrOSmPZLgL6rwvoT/P/iZCxiemanfRfD5tUe
	 6n2LzH6UWMD2nZqrXAcNR+wCE7vPFp8FPvxeyBkbbC+Bcwa/l3hD0jL1+StKPjTcEJ
	 YJdPTSsZFKQGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F03930C06;
	Sat,  6 Jun 2026 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: remove obsolete EXPORT_SYMBOL() and
 EXPORT_SYMBOL_GPL()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070762564.3975748.11843425072454917140.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:00:25 +0000
References: <20260604174555.2801532-1-edumazet@google.com>
In-Reply-To: <20260604174555.2801532-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 17:45:55 +0000 you wrote:
> These symbols don't need to be exported, they are only used from vmlinux:
> 
> - inet6addr_notifier_call_chain
> - inet6addr_validator_notifier_call_chain
> - in6addr_linklocal_allnodes
> - in6addr_linklocal_allrouters
> - in6addr_interfacelocal_allnodes
> - in6addr_interfacelocal_allrouters
> - in6addr_sitelocal_allrouters
> - inet6_cleanup_sock
> - ip6_sk_dst_lookup_flow
> - ipv6_proxy_select_ident
> - ip6_sk_update_pmtu
> - ip6_sk_redirect
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: remove obsolete EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL()
    https://git.kernel.org/netdev/net-next/c/9410fb4da2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


