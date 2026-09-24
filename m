Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246223B8405;
	Thu, 24 Sep 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216481; cv=none; b=fuVRIXmggpr63kIWnzcnoNFkYbrYYxPWqbd0ZwG1sJtbALbHS8Yg8VRIJ4YBMaNV8C2kc7bPrAV3i10khC2QOsAYEyi6FNfkUi4/HQGSMuw8s1hOZ/I/3tlahEYU4I0uPbwKtFf/T+WQWkV4ZVRH6crEYrA5qonczFk5EmFjEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216481; c=relaxed/simple;
	bh=KHanjhW+yLs1gIshRNkH6F4bBiVQPE4bQCt/yltyLGA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XC+VQuQU12h6Vv5O/zSvHhrvX0VE65YyjoRaUUAa018Uye755jQbUxJtSi6IuoYi56OpPRZvqo6rBXtsgwNsMT4k9NEA5NeJTzMywARRT6jvn3yX2o41TbQ9KML5mVGTMcoFtMWOks5evv0f4U6WBdUYE65kWIxKnCs8XvdD0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bud8KgJZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bud8KgJZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4DF1F008A2;
	Thu, 24 Sep 2026 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216479;
	bh=xDPF9xxLiDd6DBLCCQPN6x1Yxk0dUmWroBWKzSp5P2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bud8KgJZS/avcjXDgdxTOjSMR1LtAa344ZTZZPseUcw7sVVkdreuiY+t1fpTC1dJN
	 +yQy5kpi+BMn7DQl0+iblqN/aapSHsoZ+ulDT8QNM54uJPNW867TwN9DgB/CiHpyus
	 SDI9UEMFtJThKtu6YECTesdgaVN0xJrGYX33PflvSP36FnFw5KcwyyPiOgm00E9sul
	 wxeZTir2zyKUqghaklP7kn2QGlVkZ2VmdURZB+UaBXtKVOxfkCqE38LNPjIdQthD9d
	 3ibdifZX++mBFtpZMXGZs3DHudjLJUK98V+Nnc81xXeuwMHJF2aLl0qUJoYomA9VEH
	 1r6DLt9z5hXWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D5E39E9611;
	Thu, 24 Sep 2026 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] net: bcmgenet: Collection of bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021640940.1281065.14257321695952299439.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:20:09 +0000
References: <20260921220021.281418-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260921220021.281418-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 15:00:16 -0700 you wrote:
> This patch series contains a collection of bug fixes found during a
> LLM-assisted coding session.
> 
> Changes in v2:
> 
> - corrected Fixes commit for "net: bcmgenet: do not skip WoL power up on
>   GENET V1"
> - dropped unnecessary patches
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit systems
    https://git.kernel.org/netdev/net/c/0e2bec77ea62
  - [net,v2,2/5] net: bcmgenet: initialize u64 stats seq counter for all queues
    https://git.kernel.org/netdev/net/c/3aeaa609fda1
  - [net,v2,3/5] net: bcmgenet: do not skip WoL power up on GENET V1
    https://git.kernel.org/netdev/net/c/cbbc1aee7776
  - [net,v2,4/5] net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
    https://git.kernel.org/netdev/net/c/273941c85fc2
  - [net,v2,5/5] net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT
    https://git.kernel.org/netdev/net/c/d64e277b955b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


