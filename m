Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884B332EC1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741418; cv=none; b=PjKTFnaJ0Bo5nfxDhZU2clpAMq0M1Q2+WnWbEuD88PhzJG3pnmcvyZ/woKkyXHO00f2xmKGW5+sRZOkLMXqixqXevv8/aqdghQyxjTYZFTE8ODxQHNeI57xDhy9P99ZNmsqCDsZYtH3FFVcT9GaXhRpmDArwUTWRQ+LtLjZkd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741418; c=relaxed/simple;
	bh=yUqlSmNESA9Ay45gsaugssFFEUHO6tjSddLgRx9CGZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kTHevmdH9Kucu081LW3dbW1/3qc87VeP2BIrlUP1CKM/XsAeLxBtbaKJY7eqOCGhbtp6jjnkt4xpWsqu/sEiKqPb4ZLV0LwvqfGbSutKXpDSUy3+wFn/Mj5EFUmk275ikLU4x2amZLAolT5hQxQzCTYXGZSq16zUnecGSrnTdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKyTj6OU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKyTj6OU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68206C19422;
	Fri, 30 Jan 2026 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741418;
	bh=yUqlSmNESA9Ay45gsaugssFFEUHO6tjSddLgRx9CGZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKyTj6OURO5O+0MLCYhYqcyTsGmWp/9cjpCruhwLSReco7pzE7lgcQY4fCZdgdlEB
	 4RK+uYwHP+CQ2H6SlSseckXAlSPaQ71pmrGNk2/ogI7E1uZszzuFllpOJELuc7uG//
	 SuctNS58ZX8UlGD3cRXYflMxi9J2GRLsOVT+g8wsCmTe/PPq8L/CztXUj41AV5uMe/
	 EZf4hznEye6DMBQQj53H96AXdOfgFLzp8zgV76nPOSVoCgkAKFo904Q9Rq1w7A1jwc
	 st1nXSd1/6UUJ5kPw20DJnPN6IWNN+7D0a/oZD5EQLuysMEFebNwW2387dcl0p5DWV
	 JVKrjK4E3DXcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA47380CEE0;
	Fri, 30 Jan 2026 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: fix potential crash in
 net/sched/cls_u32.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974141110.3149010.14820684978131291126.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:11 +0000
References: <20260128141539.3404400-1-edumazet@google.com>
In-Reply-To: <20260128141539.3404400-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 km.kim1503@gmail.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 14:15:37 +0000 you wrote:
> GangMin Kim provided a report and a repro fooling u32_classify().
> 
> Add skb_header_pointer_careful() variant of skb_header_pointer()
> and use it in net/sched/cls_u32.c.
> 
> Later we can also use it in net/sched/act_pedit.c
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: add skb_header_pointer_careful() helper
    https://git.kernel.org/netdev/net/c/13e00fdc9236
  - [v2,net,2/2] net/sched: cls_u32: use skb_header_pointer_careful()
    https://git.kernel.org/netdev/net/c/cabd1a976375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


