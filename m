Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDE22DFA4;
	Tue,  7 Apr 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526647; cv=none; b=qiAHYEXiOwLeojbMi8vJxZVbLtZQd6HFtxFiyQaxV2DHCR6y2ceZ2Eu6pw6BAPofjVvoXTD7h1/mpHCveogRP8bg5vlMOwLZWFwmqm0/DlAL7IYYW6qN2/bz6k0vQrOcRuQTcswez+s/kK5g1E9Jv1O/Sp6DvASiPcEeC8IjJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526647; c=relaxed/simple;
	bh=I1894Tqr1GIikOXl1eglFgSX/8ktbiaMFBzaS7PcAIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HGUB2PBG5n3jD+zK/H7VKi8vY4hh0Vz0lmWTAVY8WRJ0ulQqxqRBnTPEgsg9yXxwvxshbZLA6QvACR/XxKT8d8AcUi2SI3m0g6vczNFBsEUo+MbbHS0jJbwE3n5HwkghPg5cxjfe8KjE816e7t8o74soWt3nXRFPx3neTBpVPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1QAfGHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1QAfGHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2930FC4CEF7;
	Tue,  7 Apr 2026 01:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526647;
	bh=I1894Tqr1GIikOXl1eglFgSX/8ktbiaMFBzaS7PcAIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1QAfGHg9snnQFWry63xRpdpsiikxA1ldAWgipReUXxizZT1qarfKyYRyabvgRlHm
	 qbJyngtDi8LuYp0EoyyWHglvZR8SJ31H/n5E68oaqwmhFw0wtxNckvo1ACi64rlV+g
	 vE0xfWNFMOkfyhOsKqHnyW7NjlmUe6Y6OSA6vi/iB/VUlQXWMoqYWDk2I0IfvWkKva
	 ngP++fMXTxH5Vqrwf0Md4xf37cop+M6+0FSOoE2hfyzNEXrzVLaXiQ1jz8cfltP4Mx
	 /ex54vM2qUee0XrqEw/x8seKRdbiKaXyV/rJMSzokj7/LTWvmlMBzJoQW43GvIKG3y
	 nHdN/uj5GTogw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D433809A28;
	Tue,  7 Apr 2026 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip6_tunnel: use generic for_each_ip_tunnel_rcu
 macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552662529.3337768.15440650984728375871.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:25 +0000
References: <20260403084619.4107978-1-yuehaibing@huawei.com>
In-Reply-To: <20260403084619.4107978-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 3 Apr 2026 16:46:19 +0800 you wrote:
> Remove the locally defined for_each_ip6_tunnel_rcu macro and use
> the generic for_each_ip_tunnel_rcu from linux/if_tunnel.h instead.
> 
> This eliminates code duplication and ensures consistency across
> the kernel tunnel implementations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ip6_tunnel: use generic for_each_ip_tunnel_rcu macro
    https://git.kernel.org/netdev/net-next/c/2f60df9e61aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


