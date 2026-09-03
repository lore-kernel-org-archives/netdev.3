Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F612367280;
	Thu,  3 Sep 2026 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406275; cv=none; b=W29hFmwBy1m9DYRhz0En++21WTL2+FBmTwgLG1R3N/oyOXWEKy7+u7MuEeA22tlGq7FVtgcuAzFz6nJmfkXFIlv4/yEgnkSfXxgrBrxIb+c3W/LnTa+g6ol8U75YK22J9SGH/My+LQeoCA2gmO4MaAsSVKk3mqD5W5Uz9nBl0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406275; c=relaxed/simple;
	bh=Zeh7rn/x5nvnvU54QjjKRdGjjAWgfX+uS5GjFSA+QkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hhg/XGZSg7HfSdJOjGUmf0xd8IXuJGWyJLua/yyfijA95AlNSWYIbEPdQvRleWzeedFtRsrVdeXvXZK1UYycMRkJ5Zu+fKH8EABIoUBhG6XI1/8zDwdR2g5D07WffLsyfxwi0h/5eVL2BUDYtIMK2dWs60YPv7JJmVJ+MOxfDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+auT/re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+auT/re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4376C1F00A3A;
	Thu,  3 Sep 2026 03:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788406274;
	bh=KGFtclhnf2ezPaAOlcnrR8I+0hi3TVV0iugo6nKpjC0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+auT/re0CSm+7EN7E7KcLFBlVA39dq6VBWu93y/GKtoqzdKOsaV6NFvzJojvtric
	 yU/4r/O/uYDfaJfEa9zm9zyz9BP8uHETibM2Br9mBxT4gKuf7/eMy+xuzSY1qW9bna
	 ML8meEdM1Y0g5p3w62uPCc4a5FqpabTj9oCHB9bzhah2+wuQEJo8waomnueW9Qr5WK
	 wd5tLOcblkQp2KpmEQ49mndwjARCQFhsW7Xz35M+KeJhm67uM9yXotgLc4Ucls0XEU
	 /s0qmnF+61hW9PJAzZi4TXFThyxZJ6J8fGZEIGMn2hv0Iw58WUUy3BmVYhGJT9qAg5
	 E+V6MojcuH6BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BA8392705C;
	Thu,  3 Sep 2026 03:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/5] net: dsa: motorcomm: Add LED support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840621563.3072235.4183497708325455365.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 03:30:15 +0000
References: <20260903031630.356840-1-mmyangfl@gmail.com>
In-Reply-To: <20260903031630.356840-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 11:16:21 +0800 you wrote:
> LEDs can be described in the device tree using the standard LED node
> notation. Currently, only parallel mode and strict 1:1 mapping (i.e. the
> HW default) are supported.
> 
> v11: https://lore.kernel.org/r/20260831044818.4103477-1-mmyangfl@gmail.com
>   - handle one of *delay_on / *delay_off is zero
>   - fix error path for yt921x_led_setup()
> v10: https://lore.kernel.org/r/20260816193905.218112-1-mmyangfl@gmail.com
>   - new patch to fix lock status check
>   - LED control block redesigned
> v9: https://lore.kernel.org/r/20260726162731.1005803-1-mmyangfl@gmail.com
>   - LED initialization sequence adjusted
>   - add DT description
> v8: https://lore.kernel.org/r/20260725045008.858692-1-mmyangfl@gmail.com
>   - limit the led port number
> v7: https://lore.kernel.org/r/20260723195335.806002-1-mmyangfl@gmail.com
>   - rebase
> v6: https://lore.kernel.org/r/20260709014812.1158178-1-mmyangfl@gmail.com
>   - per-port initialization support
> v5: https://lore.kernel.org/r/20260707064752.1030345-1-mmyangfl@gmail.com
>   - improve trigger selection
> v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
>   - fix some reg op typos
> v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
>   - fix null pointer dereference
>   - support polarity auto-configuration
> v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
>   - allocate LED structures only
>   - eliminate double locking
> v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
>   - set up polarity correctly
>   - do not set up .brightness_get() to prevent dead lo
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/5] net: dsa: yt921x: Check lock status with lockdep_assert_held_once()
    https://git.kernel.org/netdev/net-next/c/b1950d0426aa
  - [net-next,v12,2/5] net: dsa: motorcomm: Move to subdirectory
    https://git.kernel.org/netdev/net-next/c/9c472a0d7c38
  - [net-next,v12,3/5] net: dsa: motorcomm: Split SMI module
    https://git.kernel.org/netdev/net-next/c/e9423a64d382
  - [net-next,v12,4/5] net: dsa: motorcomm: Add LED support
    (no matching commit)
  - [net-next,v12,5/5] dt-bindings: net: dsa: yt921x: Add LEDs definition example
    https://git.kernel.org/netdev/net-next/c/5f28f63c5d19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


