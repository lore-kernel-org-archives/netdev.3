Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18746215F42
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496822; cv=none; b=aMgRSljvWNFQsO0ixPRRu1a4hxlyqVfIk0gjpZ+/7AFWSXh1ZsGkXVHQO9QGFkyqMgigSKAdQ7X4hY85AjiBSJyKnxlGM+0eC4RjE1QgAx+nRaxHnuYhQcnud9r/tvlDMUNR3YucDs3///mLmBTzh6diHELG3jbhC4ShiBzdgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496822; c=relaxed/simple;
	bh=yanYS7C8kLtqVYKZMPt2gclRurlWIs8CX9WBJkj/JzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DgDEZwGiGqXdRS68vIahCIzQHLpkKV7uPq0k8arIhx64CG79d9XPMBjbM/DbO1/zR4oPX/2lUOYrP4A14too6eLkAXs17zNivsGgjgAASCxiW6K0o4VK71JJB/AR7E9cniUsNwk7eg56MHo6WwmE/Gs7k9TsH5wR3M9BkIv6I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzUY5v5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzUY5v5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028C11F000E9;
	Sat, 23 May 2026 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496820;
	bh=sw/CQQRDAny356XfXOpc/NaO4Nwr9ZGfWgzjdjiDNRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OzUY5v5W6xN5qS43QX5eEpld8gwq0+n2L2hVHqZoaR/PEZg4d716iQBDCMKcwF3gp
	 w7avetFaI0tV1RMB2qiJL3Elxp7nYNaUXFKDU8tiKabo8j71ydU0gPvEc0imRAvodI
	 VB/ikfzo73ndvzipy3Z0zTY1Ey87K8mNr8gUfPPNJBHPszoOXiqtsAvV3Nir6Rmlhy
	 DVguwBoJSD+K24VFqyGQbqvYpL9imaSaW34HftXYUJTdajnuI75BpkQPrpOsuu+4Cc
	 yaqHzbPrp/xSbRXjqAML2bG2eSsFLa5ABGCZ4Fg9xg2EWg7TnsPw1l2RP5TA3AwQSa
	 /+wlf/J357QEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19785393100F;
	Sat, 23 May 2026 00:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpll: change dpll_netdev_pin_handle_size() to
 assume
 DPLL_A_PIN_ID will be used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177949682863.1426243.2478472170496429722.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 00:40:28 +0000
References: <20260521171440.114956-1-edumazet@google.com>
In-Reply-To: <20260521171440.114956-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 17:14:39 +0000 you wrote:
> We plan to no longer hold RTNL in "ip link show", and use RCU instead.
> 
> Assume rtnl_fill_dpll_pin() will have to fill DPLL_A_PIN_ID.
> 
> It is fine to over-estimate skb size (by 8 bytes) in if_nlmsg_size().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: change dpll_netdev_pin_handle_size() to assume DPLL_A_PIN_ID will be used
    https://git.kernel.org/netdev/net-next/c/7409fad779e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


