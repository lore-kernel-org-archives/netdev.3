Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361A2D7817;
	Fri, 16 Oct 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164006; cv=none; b=La/vTuemsbz0rrur0szNqeTFR7RrAMO8PiJDrCkzMX1J23mPx7ij45bzDPe09Ziq7sIB+Tq6Jwn+pZroOzuMeUDbnKg9n2SND4CEiizmWHJ9hYEf50+2WtlJfqsezVrCmmIkS7I0xp1QnE9/TZkUEyw+oDK9nFZwyMfwt3AzuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164006; c=relaxed/simple;
	bh=QWyrNBfMkUlbdXJSdmg9tZmmFd3tYkyFPii0W9J5mNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZRun4ezRxHhbNYotZKYzqrDjrbeQEszpGijCjgK7fze2IQRiX2BTxDccVqTiz0wyJUqfwcyW2DYAmD4NEMUPCFq24qgkOMYeTpRcW3iYaiYTAr57QxUIc7aP9RTGKhBxnkl5kVeQM8qM9UEQRNi9Yye+FlCDhPITkL5zkwbQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5Rx1nK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5Rx1nK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828A71F000C4;
	Fri, 16 Oct 2026 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164005;
	bh=RgYq0+99nB4s7Z6YFAw3BNSSx8JH/I3EnogCY3sRCqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C5Rx1nK99yebsuZviYIbNkkqL5xUz/VT+WYiIjwO9ciAOvfQkERjY/ieeUALgTFqq
	 F4fouP776yj+IDI6lGah/R4RbLnQG3HrVbkMuOWAnTQd2lx6cMASzRRrqCCPe7v4xt
	 JvO3hmCEmKKfYgTSXZNmSZD4bR43hOyJnKWoUR77xjYQW2qv9twuqvFGcJXC/S4Sjt
	 ApfUxYAP2gvydGfALdo7lIPY5iOC/tpaOdd9j251/Tlub+TH/NCBCFqysZUWHmGyKv
	 caik2ULKfaFTBl1e8mJwg15Fo1er0nJL7mELgh8srM2ds3qC0gsNFoi40QBgRjRZ+b
	 KP6A0oFQ+/mtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774DE380A96A;
	Fri, 16 Oct 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: ethernet: micrel: ks8842: use dmaengine_submit()
 instead of ->tx_submit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179216400428.812602.6391711676783414058.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 15:20:04 +0000
References: <20261002193022.168248-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261002193022.168248-1-Frank.Li@oss.nxp.com>
To: Frank Li <Frank.Li@oss.nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com, yiconghui@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org,
 imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 15:30:19 -0400 you wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace direct dma_async_tx_descriptor->tx_submit() calls with the
> proper dmaengine_submit() API wrapper.
> 
> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> [...]

Here is the summary with links:
  - [1/1] net: ethernet: micrel: ks8842: use dmaengine_submit() instead of ->tx_submit()
    https://git.kernel.org/netdev/net-next/c/9b6fb15a5cc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


