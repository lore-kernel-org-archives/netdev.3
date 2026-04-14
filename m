Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493023DD52B
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166835; cv=none; b=SdnF4yDmDMB0kqAZGAKI1nGCJe4azB44soYaoVMdR423IC14bqsgaolZfb8zgCZEtuB7YACCdhXMKT4VNkj5Yqu5rXftHABnRjDII2csR0Dhp2tukgtu9ytg5B+fCHOpNg5eQPavLnAHIl9XGe832+XmRvrWaJVGdeSHg9sCNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166835; c=relaxed/simple;
	bh=B3BglmvRt8X/jgxHSb6URI9mj88QwlUxQhBzS+va8rU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIrz3fDSloaAceFdaL04jcH4TMLK5FL5Lv4Z+YrZXE9I42RkSRzLzSAtYV3qbjLiz+fWnxJPijp6O4gQ/lz9ipGku4qiwP17/Bkrbr127DI8ocG3nlSpmEaMMdvI+45ozS/MZ4fGYMxD8F3g5Hg0e1ZUbKQy36OOtcZaJVWQG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU4pYPFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU4pYPFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D60C19425;
	Tue, 14 Apr 2026 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776166834;
	bh=B3BglmvRt8X/jgxHSb6URI9mj88QwlUxQhBzS+va8rU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FU4pYPFnthk4cT9SVYY2n9sh7zY/ThkDQBv3UpAF6uqFug2Ee7N/IIjrZ8Qfwv3Y3
	 /ilxmuXrxUKx0wjEJHr3HmcSL/t5D9eQYoCT12SQ/KN17yAtGcI1eo+XApI/lm3Nh+
	 n8bPmr1aH2+nZuXkw2cATloIvz0latJjTIvq/8sebOvYL43I7HNVygxeieekFSsJET
	 WbwO6KMGTzZKbZZmZvP0BiUeJnhEPwFjVpX5dG1gnjedOV3DIIh4OtB5JqnGs77vzn
	 eph+32ZqnfYAd8QE0Re6J/QELvmHBIKG9RQqCNb7huKhfxb/3R0T5+AH0eXAevtd+E
	 rCjOfHbD7Prwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F153808205;
	Tue, 14 Apr 2026 11:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix VIP configuration for AN7583 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177616680555.841978.4384575148487022724.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 11:40:05 +0000
References: <20260412-airoha-7583-vip-fix-v1-1-c35e02b054bb@kernel.org>
In-Reply-To: <20260412-airoha-7583-vip-fix-v1-1-c35e02b054bb@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 12 Apr 2026 09:57:29 +0200 you wrote:
> EN7581 and AN7583 SoCs have different VIP definitions. Introduce
> get_vip_port callback in airoha_eth_soc_data struct in order to take
> into account EN7581 and AN7583 VIP register layout and definition
> differences.
> Introduce nbq parameter in airoha_gdm_port struct. At the moment nbq
> is set statically to value previously used in airhoha_set_gdm2_loopback
> routine and it will be read from device tree in subsequent patches.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix VIP configuration for AN7583 SoC
    https://git.kernel.org/netdev/net/c/1acdfbdb516b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


