Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E283D5C0B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192053; cv=none; b=g9XbuxBb8LxSL0vFr+GS8XaPOXlrZTm43Wtpju5kjIcyNk00aiU6iY10aa0kYvZEuYwSS8TtwG8fHFfVZEsptvfoXiLmTlO0UB49cGvcpsNqoFZx2IlFMb0bhzLbAgrba7bGU4vGH3t9nHPnH+ufPBw7kB5zXHgye352/W9x++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192053; c=relaxed/simple;
	bh=O/uqWVNjYMDpVycWX+NIU7f4/AuNgFqmgT9CheMY6jc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7dPVl+0IfDQ7XcLZzT4T9LbR/pb8GFsml8Pxg4zVFE9j3J2SpeRADrERTdBxW+SsC9+2RZO+d/bc5htiGaTuEfLLDfSw/b7B5TGkwvmMKDTblenyhEqBUBmOFRO9EWXRlqrhcsH9GKszCB91Iv5UGPbePu/GlDUr2p7wEbOqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POcqbK8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POcqbK8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1241F000E9;
	Mon, 27 Jul 2026 22:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192052;
	bh=xlQxt+OoT9YoxCHAvGuAJGjC/gKqb/PPj3bKyGF4TlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=POcqbK8sYiHT81wvyGUtGoupP37CI1e5vrEIyThYp6WrkLkaMsRhncQqHo1mHlj4D
	 JigQOuSJMwqe2C14NczZgefpFmg6FrpVdrZndw5A8kMjZWzBr36OyJXWELermlyvNX
	 4AXOv+67Ixl0NpxQsMhYu3CF8LRT+uxYl2+tsvTgRZMS6V7LM2fO++7oUsYPPLdkGJ
	 c4GtD9sN/4lV5bzVU/cFLFat7T7Rh+V9SxvLOlQWJn/4uAuATj+v0QYyEW5F630qFM
	 VtG4a/1YdQdQ0NCUDvC147RwswV0OhlQ2IDFDOShjjKN8/hHeP9mn10ISaSn2XrQRj
	 fwjWl0WeUyUwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93905380CECF;
	Mon, 27 Jul 2026 22:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] net: ipv6: clear suppressed fib6 rule result
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519201713.1443317.6562373845919608591.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:40:17 +0000
References: <cover.1784710966.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1784710966.git.zhilinz@nebusec.ai>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, Jason@zx2c4.com, vega@nebusec.ai, zhilinz@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 00:48:51 +0800 you wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/ipv6/fib6_rules.c. The bug is
> reachable by a non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: ipv6: clear suppressed fib6 rule result
    https://git.kernel.org/netdev/net/c/6aea62e433fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


