Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799602253EB
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538846; cv=none; b=BkoRYM9zXEoomSYQMHUAJWcr3CaCF5/5pGPnhoDYE4iQyJI7BkVlx26H+R5ojqAd5ektWEk5ZAvdiHl6bcFUpUVW63ZWn6RcVelIJ2zW2IvK2/VhN9IADvPMZOvi0U5VstuWOAKdrzmn4cqFwq7cC6SKXl5VznZyVJPHahwrF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538846; c=relaxed/simple;
	bh=EuMXbL0YTUemFqUTkCiUX3iqBxHSNeRVt7VfFdEjQ7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fY89FLpe2ZhR0i2xqmEzX9Spad9UPLilutFxwXGO98mn2FodaatnYQABUdDIOA6RPhl3TEvTkUsWo7B/izRlLe6+oHLerF0lvYQUatyxYqDxqZZpMAWEmMZIPW1Rim1+szu58sJs3MPwE9TkigMSdT4h2SGclkKOCWMJkO/oY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/W/iqw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/W/iqw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16667C2BCB3;
	Sat, 18 Apr 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776538846;
	bh=EuMXbL0YTUemFqUTkCiUX3iqBxHSNeRVt7VfFdEjQ7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k/W/iqw9TnS7iOFVa+MqhpCVKLFi7Fm2PEGH/AtlTK0A1mLRXPDBTqEJjO/tKQ+XH
	 8KdwpYnMT9ZXypOVLItMfrCgCA+4sp3xmLdsCs9AuXpZxKjdWa2PDKE+Be3aYGDlHy
	 S3roHtQoEJN7Ndz1QT6CuwUJcE7NaX3JVaXM4olonqYa0gTnPln/0B0OJYLgFI4NaF
	 4iCz5q2PulgACbqkXca5H3GStKq3MlnJf2nPPf2rt6kJLWTlfPx+KGW4RpDKd/JZEX
	 EpW5KAU3CJEM9ENvrCxZXEmnszb1cA1BimmEzFUnK2b2BJ0pjgtlDpDqQvg3Rz+vgQ
	 Xlpq2Rqa0MVgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0A1380CEDD;
	Sat, 18 Apr 2026 19:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] selftests: ovpn: add nftables config dependencies
 for
 test-mark
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177653881230.504139.15068087519650158923.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:00:12 +0000
References: <20260417090305.2775723-2-antonio@openvpn.net>
In-Reply-To: <20260417090305.2775723-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, shuah@kernel.org,
 horms@kernel.org, sd@queasysnail.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Fri, 17 Apr 2026 11:03:00 +0200 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> test-mark.sh installs nftables rules in an inet/filter output chain and
> verifies packet drops via nft counters. In vmksft this can fail when the
> nftables core is not enabled by the ovpn selftest config.
> 
> Add the missing kernel options required by this test:
> - CONFIG_NETFILTER
> - CONFIG_NF_TABLES
> - CONFIG_NF_TABLES_INET
> 
> [...]

Here is the summary with links:
  - [net,1/6] selftests: ovpn: add nftables config dependencies for test-mark
    https://git.kernel.org/netdev/net/c/e5fd34ab8dff
  - [net,2/6] selftests: ovpn: fail notification check on mismatch
    https://git.kernel.org/netdev/net/c/c409da0fe15e
  - [net,3/6] selftests: ovpn: flatten slurped notification JSON before filtering
    https://git.kernel.org/netdev/net/c/222e7f8d1ca3
  - [net,4/6] selftests: ovpn: add prefix to helpers and shared variables
    https://git.kernel.org/netdev/net/c/7c29665a3a3c
  - [net,5/6] selftests: ovpn: align command flow with TAP
    https://git.kernel.org/netdev/net/c/1be93bb979ab
  - [net,6/6] selftests: ovpn: serialize YNL listener startup
    https://git.kernel.org/netdev/net/c/6c9b1dc218fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


