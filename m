Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295B380FDE;
	Thu, 27 Aug 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818265; cv=none; b=g1QcAgMUel5eEwMklYa0dQ7Y+nxbNzceUrz0TR/4BVtxuNYWT3mN0SDRIuXbyL0/zjWvdom3WINnRJDzfMow7H2FiSMjqK11YvFq4FdVUK6Fjh+th7Wkm5UIWZkMhwr7GgCh2P2IaaXVEwkMCdukYyTXyyh6GLWIPH1SG3muyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818265; c=relaxed/simple;
	bh=bxhnAPZCY5DW4eFRZDPe7yLHv6R0ofl8xh/MPWZq9PE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fTZFk9gfZ66tn/rTCCEX7fXZ9c9Xgc7ZAsNJDKiMHaw05AX9FtyQ2t0+U7t04bOy+4F0ZcXbjtCuc07pKDGEvDMAr3d2a199L6c2+Pq1hbZBcKZtpQqTvM5UqX96LYJ0xYjsNPPNiPD53lFIJFd5W+ZgK8XGUc05az8Kkp12sRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8rppW3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8rppW3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E971F000E9;
	Thu, 27 Aug 2026 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787818260;
	bh=+MwTcniFgsQyj/mh+HBBLh8w4RBABQD8nqYNKGZKxGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K8rppW3ABdUDNXrK6Q7jT8E+OfMviBE+EPcrDRVdF8nvH61z4tOpwpzhH1mIZqVEW
	 0YlYdIVc7HXFKeek3Cu77gsBKHUnyQzO0+18UhO5l8yyGg0L996u0CHk+T1BoE+8VP
	 Ue93xqJYJVxpfX4YnKFPkzGdDTOSuZBxt78p7Xf/2ZRsCf8kWDPBtJkxH8Bm3GxR9R
	 sO0dv6iFxWB0hf0lBZy1slylRLtWW9wHSRb49d+kNmkPVIFw9/h8bzUDJpatg87GX8
	 1qtMk8zA+BPZQTxm1lp/YVVzTAB+ak4lOilFKxyUGX8xYIY0WDmzLXZKwaON5RotdZ
	 RWq09+78fpGAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939493809A12;
	Thu, 27 Aug 2026 08:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: sun4i-emac: Fix IRQ error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178781820640.1094636.14217098118734046137.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 08:10:06 +0000
References: <20260824100901.31675-1-phucduc.bui@gmail.com>
In-Reply-To: <20260824100901.31675-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, linusw@kernel.org,
 kees@kernel.org, bartosz.golaszewski@oss.qualcomm.com, arnd@arndb.de,
 sr@denx.de, mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 24 Aug 2026 17:09:01 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails.
> The current code checks for -ENXIO and therefore does not detect the
> failure.
> 
> Check for a zero return value and convert it to -ENXIO.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: sun4i-emac: Fix IRQ error handling
    https://git.kernel.org/netdev/net/c/991c2be78257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


