Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0154119E3
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410446; cv=none; b=QZuHzaKt3x/P8gDmqajnuWh9wHz4Vxn9zX/u5d27VpBK/XoTWo9jShnVv4UqwRwdtyc0VlvhN3532CBF4k6h6oM+EDW5PvyJZkly94c3/GSa3B1j+uRUxVQIF4hsIiUcX/EJHeU+n6lHSxhzJDqy4DZDg++nlwjIDgPfxtbaDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410446; c=relaxed/simple;
	bh=moUAKuo2wH6sRUk73Z11zFV9GguDD9iP26KAqNTXHCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JqEVLDJfEfUjJjouegFzm1dxCZB/iYOTbF7FzGfeq/ZSrO6freQR0+g2FLPq5nKq/lMTjjraDKgI1t3b7gzklq34uRKzBayYDCguDHGYALb+RjFX7pdLLIMzLL738yb4let9gEaMDdYNK/wvgfN2CheWrAtTUP4eTgGFgrVP8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F72gP6J6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F72gP6J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFE71F000E9;
	Thu, 30 Jul 2026 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785410444;
	bh=lPp3lY2pIQH2uSC7G7deXpYepE8KniShwxQhKC0vZyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F72gP6J6X03YPWYE0o97P3aQh1bruVK3GJkSoRuy2Li9bAFcWQUVIwOxBpYPtc86x
	 me2I604KHHJlPlWXwHn3HZWRFeFIYvNbhJejc7pa90wgTLHMik7SnjI8K6q5ihgrAZ
	 w0DrTKllyFb6dKfKKwvUZx7cycUTmRQbXbbx4+o8tPWyf2nIAxgFI8l0/sYG407rks
	 p0w2BWVl8vSSGq76lqGQ2MrXnm9bgzGd1J73o/a/pljSu4eAIIlA85ZEwsokO4Nah9
	 Wz2lXr0b7FKrd2Rxzxnu8hCZ7qmAZccUcI5qI+L+OHazvstjqFbzm337Lkm8/U7Bv3
	 agJr5h6Q8ingA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 44DFF38119C6;
	Thu, 30 Jul 2026 11:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipip: reject unsupported configurations in
 fill_forward_path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178541040806.3517205.6987640971492782243.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 11:20:08 +0000
References: <20260725-ipip-fill-forward-path-fix-v1-1-bc69fd3127d5@kernel.org>
In-Reply-To: 
 <20260725-ipip-fill-forward-path-fix-v1-1-bc69fd3127d5@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Jul 2026 11:33:45 +0200 you wrote:
> The ipip fill_forward_path callback currently does not check for
> configurations that cannot be offloaded to hardware:
> 
> - Collect metadata (flow-based) tunnels have no fixed destination
>   and rely on per-packet tunnel metadata, so the forward path
>   cannot be pre-computed.
> 
> [...]

Here is the summary with links:
  - [net-next] ipip: reject unsupported configurations in fill_forward_path
    https://git.kernel.org/netdev/net-next/c/d25c5beea9a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


