Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD71285050;
	Sun, 12 Apr 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010849; cv=none; b=WtNooH6i/EH2hYV68n8ml1Wp1qp8xREe1m07zcNdFkVKi5mjYinn/QhpcOtebIN1hDDHacZcQe/vpsrSQN1EdBEEZ48f3Gci2DpluvIUc/ieo1R9mb4NIWzzdCwCZPfBfCNmeeXX5AacJdcjoQgr5f3bl+GJvx49wOHR2QJ+2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010849; c=relaxed/simple;
	bh=o3yX3doUbqTr19OP49qK7kPb2+WHlGSahr3HV0Cp24k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pxppyrWvTVGWD8694/V5o0ukYslBbfUrE+zZmYLNgg4JXGGgQisJ4aeYHqd+c9T1mvEsJInIbATuMnO9FsZ71DrUR2gL98bofjGurwpeDEdQUVtRo0+rlyBPekWuLahjUowHMuU5u8P6SQ0s4HMPqqJmcSMiBl88mJkh9MwxPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d28+mx/i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d28+mx/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BFFC19425;
	Sun, 12 Apr 2026 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010849;
	bh=o3yX3doUbqTr19OP49qK7kPb2+WHlGSahr3HV0Cp24k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d28+mx/is3jy5NgGbNG4VRxDlX5iXgnwTjg/ObjhlRUi0KAWxusu+F3ZI5wgJgMYq
	 cZ3BYLsZX/kB3mP9hpUGZxSCYvAQXwmCpgAcl62bX0En/Pu5wEQbgm5VhSqJdapv/P
	 dfgVYF59Qp8cNvLh+Dth346UcUCUwmFdQg55JdLY6E5tew/5eataM1EJBYRQn3DSIc
	 RX4lbPYUh+p/I1nlqffqbqzhjcfu9mmS8rNiFKuxlcGagtHRbO3X5pL280uTLopzAK
	 L57tazxz6HmUXl7ywcD2njL20ktl76FMydRqMohvsWw+qD0KFR3ovL5wzpXBLTkGxT
	 bOBTjhNEgcscg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDE3809A8B;
	Sun, 12 Apr 2026 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: Add net_cookie to Dead loop messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601082154.3330556.7800864161685115961.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:21 +0000
References: <20260408191056.1036330-1-carges@cloudflare.com>
In-Reply-To: <20260408191056.1036330-1-carges@cloudflare.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 14:10:47 -0500 you wrote:
> Network devices can have the same name within different network namespaces.
> To help distinguish these devices, add the net_cookie value which can be
> used to identify the netns.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
> v2: rebased on net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: Add net_cookie to Dead loop messages
    https://git.kernel.org/netdev/net-next/c/b258cba1e05d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


