Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D719E839
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515650; cv=none; b=fFfKnCxgDxyf39smDGGYwWffDdtLTrlojSMNKBBflulx67qO1o4bUskCtINA/GdkLOOU59tiTOI43fxHn5VBsmhGW0zmxzfq3K/Y41N8mjJJmYsENoKRE0osIB2xHPFGvO5g5yqmr0I5D5xmPHogMlPQXtEVRSYBMau1xrmKDQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515650; c=relaxed/simple;
	bh=fG4XzM+0j98ZmVdL/YHx441Q1L3c+7EFVTxjeKP48CY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p1F9CdfEXQ8uaXMffYsruBVKjR1+GUtqFQdPl22xDFubwhlN1VwHBrgJ8eqHxqX9YDPlY3AHMTq9YXnx1iU9uo5bW8IK54uSCV9ufqDG7kBXDzudCFpnQwpGcsFyAc91h6GgxFv/6lnAG/xcIPpKTjB1/frBuaVxKIcAUuv4PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB0NPV1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB0NPV1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B94C19425;
	Thu, 30 Apr 2026 02:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777515650;
	bh=fG4XzM+0j98ZmVdL/YHx441Q1L3c+7EFVTxjeKP48CY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kB0NPV1i4qWKwBur+nruR/1r+N+TmLOO6E469g7sVGC199cqD94XwcRxWuOvxvRZD
	 zTa3pOSrGCjk9mEg0syLpkNGAlbe7BWjnvdU3fmWdHMHemLPgQvWSP1iXYLEhh2OOx
	 xtLT1s/6+JjqRxVlagLyjtvMb9TsXpZXoezOk+bO9zLhLBK4y8352j5+vkJFP97z5Z
	 rC09WqF/QalYz5HzamWYjP1NfmlLS7WdX4lqMcXPvOgXV8IL0PzhpHJYXjFU2nFAxA
	 TKKP7XoxUrfahsLfTDZaV7UmbI6tvq3yvzwY1S3upcckVUDT1q/lGuWwKOWkfuhp6I
	 HO5C7bJ2BAtIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0783809A33;
	Thu, 30 Apr 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: add tcp_mstamp_refresh_inline()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177751560530.2266943.4878155187628228607.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 02:20:05 +0000
References: <20260429010809.784315-1-edumazet@google.com>
In-Reply-To: <20260429010809.784315-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 01:08:09 +0000 you wrote:
> We want to inline tcp_mstamp_refresh() in fast path only:
> 
> - tcp_rcv_established()
> - tcp_write_xmit()
> 
> Add tcp_mstamp_refresh_inline() for this purpose.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: add tcp_mstamp_refresh_inline()
    https://git.kernel.org/netdev/net-next/c/28df22acc275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


