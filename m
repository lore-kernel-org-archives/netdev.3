Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE0286425;
	Wed,  5 Aug 2026 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894647; cv=none; b=LswiF/Ojr2kN9xd/aowIi1TSvI0E/N9+Oj0TXaQ5eNFrZVyUJkl2zRb5nfsXEO+uo76JAaYG1X41xm0eg71WicczfXWLl5Gg3qU66LgcfWBX8AqdmH1CS9hE6EM3dguykOGhYBFf1kM0u+lJxLoduLhpaIZnkqdqaZAZ+vIduVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894647; c=relaxed/simple;
	bh=ErluoVwqzoafeTgsCxjkBDZO0bL9xN1QZ01zxZdkWl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y5WCueMbkmdBVqvuUK64PNjnZ7AMxCs7DmG8E5z1249EZBp6EofjBqgiNX7m+2PZpexXsXkAgmlxZuTe4CRyUONfJznzeaSI5EEcPLs48NCO59d+2QdHfVYACwodJxJ6SaTg8LJYZsUpZtvhA7e+ZwuXTeuhE4r4o1fRaT63S/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5buW8GT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5buW8GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BA71F000E9;
	Wed,  5 Aug 2026 01:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785894645;
	bh=6dBBdt8/+6GDoxZMWl+juzNM+hGF1wXGPtksPjYUM10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E5buW8GTWa701CIYzFkMHef1385SKQtQIUlu1Usrf84wGMmRW7l8JJhbTzmoN6x7U
	 tjUW1Y1JmVe3tb4n6XYrSpt96tc6nRoiry6Csu5Sr+IKDhfigRDbNIEx6VzXhT6Anq
	 u+DyOpTipD0wpGuaQZIseQED8skrJz9lRa0+D3Vdqj+yXejE11+s487QZ2XRphCdqG
	 FhTZjV1SArWrZ8+ttX+nhnlBzsWJZjTQH0fUkP1DA0bkk/iReDX8G+pxzcVr9FJocE
	 Vw6wOKsnbpjpMQ18agm3LpXjPNiqLLhYlFLp9nYzs8XZfi2XZZrXH6uBetdrmEkqEq
	 CAYLp7lNKqW0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568733926667;
	Wed,  5 Aug 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ipv4: nexthop: handle errors in
 nexthop_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589460589.3871126.9086068460518250575.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:50:05 +0000
References: <20260731025249.80026-1-heminhong@kylinos.cn>
In-Reply-To: <20260731025249.80026-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 10:52:49 +0800 you wrote:
> nexthop_init() ignores errors from register_pernet_subsys() and
> register_netdevice_notifier(), so a partial initialization can appear
> successful.
> 
> Check those steps and unwind prior registrations on failure.
> 
> Do not check rtnl_register_many(): for built-in code it panics on
> failure, so the call cannot return an error to nexthop_init().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ipv4: nexthop: handle errors in nexthop_init()
    https://git.kernel.org/netdev/net-next/c/c0fd47726c94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


