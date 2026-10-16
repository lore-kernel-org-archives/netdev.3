Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BC1ABEDE;
	Fri, 16 Oct 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113010; cv=none; b=rMVbrjyXv4StqMHDYwaAvlmms8ZOeZ1K2YH5b1R5Qfirzuy6mwpO8HZINiqjhg0rkFUfY69l4okRZcL/Cug61JS1mdhghwyh5nUr1Slm15Ldy3YibQ47+4OGgjiPFWK2kd9kRou2HNjTz1CHC0S0RjibzZX/cA6HjVR0nu6iy8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113010; c=relaxed/simple;
	bh=R0w1STXSO7ZbsFI7l7JdkL9mw/WSsj/u6jUOvOzMipg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dY5zm5TweXSeibg8khCLrRUPyiYbJgzL4QUh+JilpOtXQgwtWdAI6/h+crgCoYwCuU0L6JCkethZO36FNw73o7Rj5N3XQW+jUs+tNZvaic70ZTJLKVBg2lL5OD4T/BeuaiMBkydFmMh3lOWCHuHHGTqPaJjQIHT9ripzsSXOG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7Y9XKOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7Y9XKOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA71F000C4;
	Fri, 16 Oct 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792113009;
	bh=nAXeX20TUuPCCVL6iWrrKcAYv23SAxZ1bAiWSQ5JksE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f7Y9XKOVaJ/wdZsaqYrgGSu0+j1V4fieBFlQfL/5JQZLhNX98uTClwChrCGKeYoIn
	 Q7h34/LThtw1z3eHwxS2Ou+eFWTYaXmmeq+AoNZ2NfnTN8SEZI7+CUZdFi3TumTANp
	 RbG0zeUOy/K0t40EcF0GToCFYYAHr8emIKUuEgQQvV7H+Z2gyRQ5T4kny2RuY6lJs5
	 aTbsl+a1JH8wVZvmaEo9/wmC5yktc4Nxa1WSLLl5n4d5hyopHmlhhOop12QSx/SwC3
	 L2tmqM/M2QlmvebudLZX1fszup7hWD5elugZa3ZUtvh4ZyonK+QiwF8m8o1MAyQIgu
	 rYDo4hkhfWuLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77A423808209;
	Fri, 16 Oct 2026 01:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: phy: motorcomm: Add cable test
 support
 for internal YT861x PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211300813.4187796.258497069495042661.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:10:08 +0000
References: <20261009175936.428256-1-mmyangfl@gmail.com>
In-Reply-To: <20261009175936.428256-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 01:59:29 +0800 you wrote:
> The YT921x switches integrate GbE PHYs of the YT861x family (PHY ID
> 0x01e04281) on the switch-internal MDIO bus exposed by the yt921x DSA
> driver. Add a driver entry and TDR cable test support.
> 
> v3:
>  - add dt-bindings
>  - add PHY_IS_INTERNAL
> v2: https://lore.kernel.org/r/20261006202352.1616626-1-mmyangfl@gmail.com
>  - split into a driver entry patch and a cable test patch
>  - update comments and kconfig
>  - add yt861x_config_init() and apply the auto sleep setting, restore auto
>    sleep when starting the TDR test fails
>  - use separate variables for the TDR status
> v1: https://lore.kernel.org/r/20261004184246.1260426-1-mmyangfl@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: motorcomm: Add YT861x PHY compatible
    https://git.kernel.org/netdev/net-next/c/1202140b297e
  - [net-next,v3,2/3] net: phy: motorcomm: Add driver entry for internal YT861x PHYs
    https://git.kernel.org/netdev/net-next/c/ae0c7e8d0bab
  - [net-next,v3,3/3] net: phy: motorcomm: Add cable test support for internal YT861x PHYs
    https://git.kernel.org/netdev/net-next/c/fc697291ad0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


