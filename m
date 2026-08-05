Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308D3BCD10;
	Wed,  5 Aug 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895257; cv=none; b=uUfvxopii2AiXg/zUc/8RsfNQEiG7F+EA7rjQxaCxzww1xULHkN2RXqtHtp7hG38ZPGWm8tsQcV6d8X9/Smt/dKhqmzxNpLsDWcyyuFrkl+X8mXTT77O5tk4AUvvk/rU7tyyrtK/2SiIXO6Bxo7pI7kEfyOJVA3eielGR5FRssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895257; c=relaxed/simple;
	bh=WcVj6Ck+fIE8ThUcPCQmtYgcg6nmUdQbHeixeOOqq0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DQDXivtYLdyjb+Cz0vRwd075O4hXbz9ze4i+nKtimBhZNhTEKqjee0o+ZrB778j3QeKX6b0kPNdq7lZlgTo8fteOiqMHLb0c2WrhTuDcypjvR7dZFgBMtwcBOCWSp66lF5/L4TLCCYE0+7o9kA/PCnMeLd5Fgq8K6iUd052EmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHX2XXxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHX2XXxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAF11F000E9;
	Wed,  5 Aug 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895256;
	bh=LhMWJ1kB3ibHOGuLYenRfGe4eG2MPIp+UGFtfOSP0a8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hHX2XXxErDDSji8J3IPih1ZV2tDGvs/ZMVg2LTUWRt6vZfifrZByqfBuvoHMtUBXO
	 vYtmgk5gIAJpw4qdkGfUQWDlun0tUU38fYkEgYjCn2bk9qFg3+8U5UOH53BoA0NF3i
	 7arUs2W+UglVgX1BArqVtOK6KZcdtnOIzc4WVkfbWIzWuNYpB1i76VI0TQLgqX5jZ2
	 SBadBTqC3yyeyR2ySnmifZbbtFSJXR32h/m9dciz6e9YoFHiZisanE50ZGa/zsHmrO
	 BHx83/A8L8oNzvBFNy1vTqueRxY0KOxbCiK/ni54jnTrJmmDxPj1wzboXvNsj7+xX1
	 vFpJLmJYKDD/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A83926667;
	Wed,  5 Aug 2026 02:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: vrf: check register_netdevice_notifier() error
 in
 vrf_init_module()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589521613.3873994.3433141909093769199.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 02:00:16 +0000
References: <20260803090002.142453-1-heminhong@kylinos.cn>
In-Reply-To: <20260803090002.142453-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: dsahern@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 17:00:02 +0800 you wrote:
> vrf_init_module() ignores register_netdevice_notifier() errors and
> continues module initialization, which can leave VRF loaded without its
> netdev notifier registered.
> 
> Check the error and fail module initialization early.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] net: vrf: check register_netdevice_notifier() error in vrf_init_module()
    https://git.kernel.org/netdev/net-next/c/ac072a89cba2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


