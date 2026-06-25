Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53E3A2E28
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352834; cv=none; b=DXV6VIqhpYfdGRTATX3a+KdCQ4KjW5NClilZxPfpejsFWghQ156qKm14LLAnV62lcbKYItrQGMpVSqoSLEEvafM52wQgb+X77J0X1PFXJjmQZkG2TO1D5tbLE837fbFhfbLeO1N49nISZ8odlGXdiq/X40qPJlv7PZdcmgGfeOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352834; c=relaxed/simple;
	bh=LfsfaccsY1IdBKJhQFBHt+8RW4wuDxF3NIp7aisJ51A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U0KrMsKZh6QFr4CLqyU+F91KCRZDP2YUSDEAmCO5fjKoDCx/06B0r+nq3cB/0itQ0zAIZZjOFrol9jovx/pEI2eTvt16GwoWAi2LthMmJtfsKURR000HLukU290J/vejpuFdbgmd4Fd2yazo+ygXiQUFuDSNy8p5RafOUcEU20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/wJ/J7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/wJ/J7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F0F1F00A3A;
	Thu, 25 Jun 2026 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352831;
	bh=AFRvaNN957BKinEjtYyb+MFHmqdiS2LpJw69b6EOj+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q/wJ/J7+zgvVnhDluJT0DRc+fakfEO32e9R/YJkUAQPTTzlNdLD6TVdtjNODjldUh
	 IqPtZYyiUKCa8woU4VcURtexFIHW3b60HhPWg87ivNzcZvD00gEYut8XpnGnK6/BYL
	 A0DmHwY9WQEbhsS0StEBlTWrZLFRy1HNlwc8VmexilUpjkMdlICATD7TO8+vi186ZM
	 +vfE/207Cz3m9NxcAcjechrmrcGo/sM1kBH8JgRpBCYKogW/+t7hZY2KaFtCH17Z3+
	 LF55wQ8tis90/2qKxCCkpvgdKNzK4O9ANSpFpdGXMJAfBLDBeTTt7GdA0LYiPJ3L70
	 wXyclq4cJrjWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B523AAA6D4;
	Thu, 25 Jun 2026 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: airoha: fix BQL underflow in shared QDMA TX
 ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235281922.3078979.12001514996584548357.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:00:19 +0000
References: <20260620-airoha-bql-fixes-v3-1-76b95374e63e@kernel.org>
In-Reply-To: <20260620-airoha-bql-fixes-v3-1-76b95374e63e@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 17:04:51 +0200 you wrote:
> When multiple netdevs share a QDMA TX ring and one device is stopped,
> netdev_tx_reset_subqueue() zeroes that device's BQL counters while its
> pending skbs remain in the shared HW TX ring. When NAPI later completes
> those skbs via netdev_tx_completed_queue(), the already-zeroed
> dql->num_queued counter underflows.
> 
> Fix the issue:
> - Remove netdev_tx_reset_subqueue() from airoha_dev_stop() so pending
>   skbs are completed naturally by NAPI with proper BQL accounting.
> - Rework airoha_qdma_tx_cleanup() to disable TX DMA, flush BQL
>   counters, DMA-unmap and free all pending skbs while skb->dev
>   references are still valid. Use a per-queue flushing flag checked
>   under q->lock in airoha_dev_xmit() to prevent races between teardown
>   and transmit. Call airoha_qdma_stop_napi() before
>   airoha_qdma_tx_cleanup() at the call sites.
> - Move DMA engine start into probe. Split DMA teardown so TX DMA is
>   disabled in airoha_qdma_tx_cleanup() and RX DMA in
>   airoha_qdma_cleanup().
> - Remove qdma->users counter since DMA lifetime is now tied to
>   probe/cleanup rather than per-netdev open/stop.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: airoha: fix BQL underflow in shared QDMA TX ring
    https://git.kernel.org/netdev/net/c/611709830945

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


