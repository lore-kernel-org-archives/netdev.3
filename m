Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8D298CAB;
	Fri,  6 Feb 2026 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348008; cv=none; b=sngC7TCDzi77QD7KNREtS/J3zgjYg2e5jDlXrbgteVv/UT6j/ZIrJiHoReWFHfUCf8Fy6WDhGbcoQG6/e+Ahh/e1tsppsLD+pX3mLItZQjmuxqbORmhCLLtD69cGUA8Id42i8z8x5xFQPJsAadJxxYa8M5SHH/10Y5d+/fLFc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348008; c=relaxed/simple;
	bh=C//8Hi4AiqIGFvJuTuR7o9sA1msw8Ral0c/dbE8xS8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pzeCndSluz6e7bMRSAjkW1NoKSgnMPGKLCcRBohg3tEZIihvfBk4pcUQyeETAoVVwzJwju7VVd0xNqgwtJv3TizVxhPslNVoQ6Mybr7ewb66salIOpwwN221PUVdl8yBKcQRkPI4VlJoQuwVljs238hUfgEQndOqKwZFdXfWmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeHbR4q2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeHbR4q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8D1C4CEF7;
	Fri,  6 Feb 2026 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770348008;
	bh=C//8Hi4AiqIGFvJuTuR7o9sA1msw8Ral0c/dbE8xS8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aeHbR4q2VyBrVp3bWnW5+tealQgSUr16jZaEvbUnNIpw1FABLtt8tJj66isblw7zJ
	 rd2LYjwmZcyJdaemkfZtnZ5RQe2Ulg38TWzNpjsrPfR4ngNc2TR7UBHJdlZ6Iwvr0y
	 050xkfnxQf7Tfv6COJeL5/GILqq+uullGSV3vkADRKLP0lgcnMBii526MmwYt8hp77
	 NEjPFUqVnafFJHQq34qX7p0L+pFp1lP4ZCYnmSJlqaN2/HheTEr4It5I5A1P0+iQsS
	 M6UQtZlcOCVFSy/vCwzJbWCMNhXHa/fl/XXjvuL66y/ZmPJ62t+8Ukf1kg2/c5E19z
	 9iNndBXmI5Z3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23543808200;
	Fri,  6 Feb 2026 03:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] amd-xgbe: add ARP offload and RSS
 self-tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177034800558.667103.17338829057267608247.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 03:20:05 +0000
References: <20260204145829.801839-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260204145829.801839-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Feb 2026 20:28:29 +0530 you wrote:
> This series adds ARP offload support and ethtool self-tests for the
> AMD XGBE 10 Gigabit Ethernet driver.
> 
> Patch 1 is a build fix for randconfig coverage.
> 
> Patch 2 adds hardware ARP offload functionality that allows the MAC
> to automatically respond to ARP requests without CPU intervention,
> reducing system latency and power consumption during suspend/resume
> and normal operation.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] amd-xgbe: do not select NET_SELFTESTS when INET is disabled
    https://git.kernel.org/netdev/net/c/ee9241524b46
  - [net-next,v3,2/4] amd-xgbe: add hardware ARP offload support
    (no matching commit)
  - [net-next,v3,3/4] amd-xgbe: add ARP offload ethtool self-test
    (no matching commit)
  - [net-next,v3,4/4] amd-xgbe: add RSS ethtool self-test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


