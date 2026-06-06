Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5218A6A8
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707625; cv=none; b=HH5gUsvfermlkElilzkcS0NN/tWxvFkBpgQnVMfbvjeaQ1F6BnCkF/MRAIH1tw2hRaR+GmFMOhSU6nXJxJA7EHvXkexd4NBwTfg0eVzYeOBcD2McbRuLsXW9kW0qNeck0OfwXPU4mLRi51yTCiooPVJNifZFlkMXqZ2vFretKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707625; c=relaxed/simple;
	bh=3rUDTInIHCzQKIoxLpidTK9C0xpIQbmvSUMArDu/ucE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e6eHA9TAOkQSMKYw6mXL3ZJu/dRO1sJIBGr8OzV7lMZGGm/pkLaqSo+KTV+rbXy/AM4ZY38p+/XiHFF9wtVKQFPeHt79SVFSFgUdWp6G+2UqHeCeOjAAntJ0zaz/OW8t2yRhIrLax6QM8XwXvisrOkcphjQwkC5xA03QT4QLvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9eV4jz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9eV4jz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330141F00893;
	Sat,  6 Jun 2026 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707624;
	bh=2vGrMrzx2c3QON9VNo1YF8JSUrNMvu395e5PHm2Q40s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m9eV4jz3ctvjzMMOb8cl9XYVhUKCDkrkZcGhpL/nPM8LhNQkHh6YhoLFuWR8aYfdP
	 WZd4xl2Aw1QIu4wOCzS7fdwUcsdYzcHmLfX2S1Skumvk1miPvwHDVdBtILZ/cnpfzK
	 WGeniJKQ1EyOiD0kETappULw/Ghb3Oioe2dMjVzZebUwWeI1WEGeyFjymfmH8h+Iav
	 39awUy4HlnbX7HjVP38w2T515bkT8j1ffxWiw7W7TWqqIoLBCap7U0/DAbIQFSkmoa
	 JPQKKvD3zXxG5gsl0nUalgZdHOcAUYJNMyxhAV0i7aA9aKjzvEfa3caUTYnwLLEH90
	 EQLt2v3y533WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B223930C06;
	Sat,  6 Jun 2026 01:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/11] bridge: prepare lockless
 br_port_fill_attrs() (I)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070762414.3975748.5475369779498083392.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:00:24 +0000
References: <20260604141343.2124500-1-edumazet@google.com>
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 14:13:32 +0000 you wrote:
> medium-term goal is to allow "ip link show" dump commands to run without RTNL.
> 
> This round of patches adds/fixes some lockess accesses in bridge.
> 
> This is not complete, more patches will come later.
> 
> Ultimately all changes to p->flags should use set_bit()/clear_bit().
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/11] bridge: add a READ_ONCE() in br_timer_value()
    https://git.kernel.org/netdev/net-next/c/032c8f6f21ee
  - [v3,net-next,02/11] bridge: add bridge_flags_bit enum
    https://git.kernel.org/netdev/net-next/c/87020def2529
  - [v3,net-next,03/11] bridge: use BR_PROMISC_BIT
    https://git.kernel.org/netdev/net-next/c/f8bcd3075725
  - [v3,net-next,04/11] bridge: use BR_ADMIN_COST_BIT
    https://git.kernel.org/netdev/net-next/c/2013ebb9b381
  - [v3,net-next,05/11] bridge: provide lockless access to p->path_cost
    https://git.kernel.org/netdev/net-next/c/f236240c9beb
  - [v3,net-next,06/11] bridge: provide lockless access to p->designated_cost
    https://git.kernel.org/netdev/net-next/c/5deaf0495158
  - [v3,net-next,07/11] bridge: provide lockless access to p->designated_port
    https://git.kernel.org/netdev/net-next/c/009b1dc8bf64
  - [v3,net-next,08/11] bridge: provide lockless access to p->priority
    https://git.kernel.org/netdev/net-next/c/abe46dbe52da
  - [v3,net-next,09/11] bridge: provide lockless access to p->port_id
    https://git.kernel.org/netdev/net-next/c/6d39b5d08009
  - [v3,net-next,10/11] bridge: provide lockless access to p->config_pending
    https://git.kernel.org/netdev/net-next/c/f51657cd7227
  - [v3,net-next,11/11] bridge: read p->flags once in br_port_fill_attrs()
    https://git.kernel.org/netdev/net-next/c/0733947606dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


