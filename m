Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9305E280035
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581060; cv=none; b=sVKgDSN36MX/RP3p67aWhbw188EhSodvr+X9IZBLr/tGDm63GAnlEy36lSvnBg60ipmlLbtPjNqe0+iManxPvmP9mbZNUCKFUyOrU6cjm8h8fLRplAUEYaLzoM4ftWKzVPUgcEZdqg9sGdi2a1/BmE6uFfutgx6y7vpcDMbmhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581060; c=relaxed/simple;
	bh=qaRtLLrFLCjt5+OXI3mko5nqIROyrbE9v6RMnKJcXPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UBLxIrTOAkzlIp1oBm5YogBP0kRnUOL/PTEQMJCj4znkMB0okmQduVFayO7sce+H8AEHp6Ve9QGN8EuLDzW4Zccz9Qo5d53EStcfNcKXHalzHVsf+K830GQsP6+hHvFQpK8fC/6MdjbfjQ5AaJ5qQGibYKVghtpNoQGE9uc6e5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZURnlh4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZURnlh4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4521F000E9;
	Thu, 13 Aug 2026 00:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581059;
	bh=3pE8nDOnEiZUEF+NQGFN7kBFfwvi0hUY+Xy5EVVMNOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZURnlh4WxKadBWblWvmFQDapgW9a0npXaJpl/Jswjc11LmR1AzUFJXwOCmiSnIgoZ
	 uHx81mD1HAXeiFICEQ/sK4USVtY80LvRZiCHxpjkNucu+H/5oaHMRs5HuHe56c6CU9
	 VmPpLk3ycfmvAEqop1VCN2dBPf9RcYGCyFVvzG6BfWgq6aCTEG0NmIo2KyKnRJCHcQ
	 sRgltDidS5VU9oLr+dAraFnlnVaTHmFJXBDCmW881TaYHIrNR+DjfcgPb4GK26OoWF
	 iLga/j7fkwKJkW1+Uti9ip3ZX86kzSGtpmb1ad8HIoZA+M41JuILgg5MEBje5xd8xq
	 XWGP8zX4tpm3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5A380CED0;
	Thu, 13 Aug 2026 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: so_txtime: fix qdisc replace
 with handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658101438.2163205.4686358073688229214.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 00:30:14 +0000
References: <20260811182856.2702163-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260811182856.2702163-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 14:26:50 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The blamed commit updated a tc replace command by adding a handle.
> 
>   -    tc(f"qdisc replace dev {ifname} root {qdisc} {optargs}")
>   +    tc(f"qdisc replace dev {ifname} root handle 1: {qdisc} {optargs}")
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: so_txtime: fix qdisc replace with handle
    https://git.kernel.org/netdev/net-next/c/dbf34acdfb29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


