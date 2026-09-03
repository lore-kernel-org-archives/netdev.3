Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB038D3F0
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429067; cv=none; b=TbZGK8ojKXpl1eEayfb1OMt3xMwmy44XLh8bf5lDquWm+FNy2jTpD2zT2EJixSWR2V8ch7tau/W/xjjil7/7lGUkZ5N+nvWbL0J4oJo3JFGFUdVT+hNikAjyJJbmnkyHn1e9DxIKV589xW95+KLLSqda/821i4U3WzhGFqBPms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429067; c=relaxed/simple;
	bh=Z+/r4nNsxkQ9J8iset8uFJzDKDX6tY4e39oiqVbQaAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IamoW+OA9SLzZJSBG1/RH3cxP/0LKJ5ptbXxvx1Go6Iu8wj+mYBIi/JPRLtGjMeOJcBm70w0RzhKqQ6xod/n2EnsMzfT5DUJ6KMUIS7q06fl6pWOBeLBaD4oW3euMy9g8DCdPYHxtq/+5a5t74upE70CJxZF++cQS9MjlYxhBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCiYQ0kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCiYQ0kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653581F000E9;
	Thu,  3 Sep 2026 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788429066;
	bh=bkxJ54lLa7UyJpsWCW4xrgS9S6PmuGVbCHPuaNKsEG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cCiYQ0kdK+jvzDycJdh7ASVvlsp5IFdadQUlLhoPglE8C4BdzWlC+W6dyDClnDT8b
	 gO5f8tgNgMSsUqVoEI0TQyGzQ+I1kiV97pLqVtln5YH0s860hf5jVdG8uiAPOQUCyq
	 Q/ib87eKIcqzgKp+lj9npoqG5Cr27EdPZ8hQ51p+5k7ndaOXrv6VJT2XwLchwxbD9W
	 NmuSbWoQxO+RZjldfjetbcVrhDGuHAV5eGdxbt/AVHNKGVH7rYlIyNn5fwkaTo718G
	 YaDkTVgViRzxRthTA0NrKOwdvKGXYg8X5v+D8XFJNFfspbainCxc+Vpf8HKQBeUu10
	 KfwojBIUgv36A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198433811965;
	Thu,  3 Sep 2026 09:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: enable RX_DONE interrupt for RX queue 31
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178842900765.3234406.8351313053019359790.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 09:50:07 +0000
References: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
In-Reply-To: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 30 Aug 2026 14:28:27 +0200 you wrote:
> RX queue 31 has always been allocated and filled by airoha_qdma_init_rx()
> since RX_DONE_INT_MASK spans queues 0-31, but none of the RX_IRQ*
> _BANK_PIN_MASK values covered BIT(31). As a consequence the RX_DONE
> interrupt for queue 31 was never enabled, airoha_qdma_rx_process() never
> ran on that queue and its buffers were never reaped.
> 
> Route RX queue 31's RX_DONE interrupt to IRQ bank 1 so that the queue
> is drained and its buffers returned to the page pool.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: enable RX_DONE interrupt for RX queue 31
    https://git.kernel.org/netdev/net/c/7db28abbea0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


