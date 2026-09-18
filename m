Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81F29D29F
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695674; cv=none; b=W0MHh4sHKINuVmE+MVPFhq2xYC/SAzZpdOB13nr/f6Ir+KlSZDhX5Mhkothc11cYzsGz3qX125SOcNilkBwx5Py963Jsm8eugdQLkNISAHzqDuXpjcNe/mfnFxvz9mWOS7ZpMCbEoQlQW4Ybz0NEfhdwQlkmxZywver511U4frc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695674; c=relaxed/simple;
	bh=xYngXBFGQjoFIYFwboXw97KuSJ7IcRKy8RF2jMkNHeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cy1FelKz3FmPbS4B7z3vAw39J4aZ+eAHBvzcYkAXAQvfx0AcwMS3NFrCxuO3fBpT0oKQaiY4reGdZMps6dER8TqKB3rDslE47iA8XMwsmicgxIf948v1AH4iWJH6mhrBqO7iks2x6Gz7elXWh7Ww+4R7X87IfoVovKaPCCgQuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzuqJBvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzuqJBvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D31F000FF;
	Fri, 18 Sep 2026 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695673;
	bh=wI9m0lJ7b3nxh9ep/+hPfkqPltxqQ6ChOsFkebGaryE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jzuqJBvDSouBqFMH3Xo45cxg92IdT7Fdn1+x2ZO0436Py519Qbpey4/u8ObSK/Leo
	 SCVKoarXvLl87j5eOAFNGpYkDHd++jsp+55BnLhhHCQ8LfgLGfAeXcDqkbqHt1VMn4
	 ln7KtMEL+x0VNEC0LJ0X11eUrW0+tmGgzMFblR8nrBYr+Qwz+CCKSJIO8CBj0jQ/vh
	 S8eWNf61RQFNAy+MVBEtxQbvQpOUFpCjXDqvTv+9n2eq9eemhCZ2z/qG1hEcwNwsYp
	 xLaw6hfXcwWdOrEKsA6yHweX9rTMImnLXyePIJyj0jzoUhJquFSzP9Xr1FRKJYYh1l
	 YATV3ucha1Vmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93879380820D;
	Fri, 18 Sep 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/9] devlink: netlink spec fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969560638.219487.12884398442343203707.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 01:40:06 +0000
References: <20260915161341.1053476-1-kuba@kernel.org>
In-Reply-To: <20260915161341.1053476-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 tariqt@nvidia.com, moshe@nvidia.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 09:13:32 -0700 you wrote:
> Number of spec fixes for the devlink family.
> 
> v2:
>  - [patch 1] reword commit msg
>  - [patch 6] also update the attr list in the spec for region get
>  - [patch 7] include port-index in the subset attr list
>  - [patch 9] new patch
> v1: https://lore.kernel.org/20260910200312.2665792-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/9] devlink: fix the enum behind DEVLINK_ATTR_RELOAD_LIMITS
    https://git.kernel.org/netdev/net-next/c/6c53effab88d
  - [net-next,v2,2/9] netlink: specs: devlink: drop the stale port dump reply value
    https://git.kernel.org/netdev/net-next/c/b8ffb7e5b9a1
  - [net-next,v2,3/9] netlink: specs: devlink: describe DEVLINK_ATTR_NESTED_DEVLINK
    https://git.kernel.org/netdev/net-next/c/6338e31e6855
  - [net-next,v2,4/9] netlink: specs: devlink: complete the port function nest
    https://git.kernel.org/netdev/net-next/c/4ced66fc97bf
  - [net-next,v2,5/9] devlink: generate the port function policy from the spec
    https://git.kernel.org/netdev/net-next/c/3ec610a6bb12
  - [net-next,v2,6/9] netlink: specs: devlink: populate multi-attr attrs for region read and line card
    https://git.kernel.org/netdev/net-next/c/b1380f907cb0
  - [net-next,v2,7/9] netlink: specs: devlink: describe the netns id in the parent-dev nest
    https://git.kernel.org/netdev/net-next/c/150079380e4b
  - [net-next,v2,8/9] netlink: specs: devlink: add pad to the subsets carrying padded u64s
    https://git.kernel.org/netdev/net-next/c/826e2a736e33
  - [net-next,v2,9/9] devlink: validate the port index in the rate set request
    https://git.kernel.org/netdev/net-next/c/2a22788ba265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


