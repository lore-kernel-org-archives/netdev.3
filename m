Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438009;
	b=K+zunBXZ7MzCXKUMUAn7rmOSd9ttIrkEWUMT2r3pWYQ6NDvcaV8tjY917lu4ofWFyIG3
	 zMstKwcPt25dfeLIs4j46gaT7nZRFRqzCa1kbQRyejouUliKF3oZEBsVgVjveC/Ma/jGc
	 OiZq/1SJSpl13aBrR0KJ/rSwe1K1fCSGhXw96hMq0Un1HyXHSMB7oDJq74Be3QeFsIMBi
	 0EJunnnsLhEmDkMBWhNQREZJ0Iui/cAMbKWdhczRlz6S3LiKuAxrG41HhMIOgtMWweCf7
	 hDRfOgNRWh+nfHm4oF6SHqW10PsLdVKvptrEbT8McXjAQcODql2f27elYRLovpMGhlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=u/lyJaSf0jh00R25h2n09r2vJy/Cqs58RLY5lnto2rE=;
	b=FmvC6UJMpfYCjhLcpEp+k3eG+hFX8R7QFM2TeMBetUNbogD9oWLG1jtLoeg1ZE2f57nE
	 XF/gPfdCFK3yVrRvf9n7ZZ3WO5t5dyiaSKR1aksfofC2tIbxWU+vxADMLt6F52dYBPkCl
	 YxfyUQ2I64ZkjKjA08sY1eAIwjFIf9iL6ZzBNtEWSaPKC7Dois17Zt04tr22NaMcxvOj3
	 C77jB8AXRoOVkL4HWoaDD6I5A5HFcNciD4mb1rEIsF2/KBWUJFqpH+e8qAQKRg/CRZ3sW
	 yOUlKtaVlmnAaRl/LlQlwq0mZWNYTPTjCxs2qCV4+SCEqqj1JU7QPoPeuebZdpVKvFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDkY0QQ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17891606A327;
	Wed, 11 Nov 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDkY0QQ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F171F00A05;
	Wed, 11 Nov 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438008;
	bh=u/lyJaSf0jh00R25h2n09r2vJy/Cqs58RLY5lnto2rE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DDkY0QQ2gyiQj9ji51vw1ZNaVYF3+upGlifhK6ePRIcggKHK1w8XPNJhXs28g7RKE
	 gT4Ohpc5ZbBeT8JBO9VkDCdCH2FnMiGcZ4Z38Y9Wlm4vzbDWDjTr716DCupP25yLFZ
	 ch1k50MThxiu0F3UeqJLxGwgjW3W6N/1YyPqyrvnMsUUlgIORCVswwj3xMusonEZKw
	 Xg//C/lQE1nNZMw9sFcVhwBynT8seZoE7iVa+eBIlNKOwRNb9cHW6qERGjDKi7DBJG
	 UQkh9KGI2I7xj5ctiE6r7cD5jSn8d10U2IU70f6lMQfWNtt2z2i4bbzLOXVJr3IalU
	 jT7sOspQokNJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B266391AFC6;
	Wed, 11 Nov 2026 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: Keep the RX buffer mapped if skb allocation
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443800718.1692642.15271790587054510634.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 23:00:07 +0000
References: <20261109-ena-rx-skb-alloc-fail-v1-1-aee2927cb51f@debian.org>
In-Reply-To: <20261109-ena-rx-skb-alloc-fail-v1-1-aee2927cb51f@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: akiyano@amazon.com, darinzon@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 shayagr@amazon.com, harry@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 09:14:29 -0800 you wrote:
> We are seeing the following issue in production on arm64 EC2 hosts
> (m8g.metal-24xl, 64K pages, SMMUv3 in strict mode, 6.18 based kernel).
> Right after a global OOM, the SMMU reports F_TRANSLATION write faults
> from the ENA device, followed by a burst of:
> 
>   WARNING: CPU: 48 PID: 1656834 at drivers/iommu/dma-iommu.c:1242 iommu_dma_unmap_phys+0xf4/0x108
>   Call trace:
>    iommu_dma_unmap_phys+0xf4/0x108 (P)
>    dma_unmap_phys+0x194/0x2a8
>    dma_unmap_page_attrs+0x1c/0x38
>    ena_io_poll+0x7bc/0x1790 [ena]
>    __napi_poll+0x54/0x220
>    net_rx_action+0x250/0x520
> 
> [...]

Here is the summary with links:
  - [net] net: ena: Keep the RX buffer mapped if skb allocation fails
    https://git.kernel.org/netdev/net/c/3e8e22a1007a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


