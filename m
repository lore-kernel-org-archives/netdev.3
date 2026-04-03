Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FB2673B0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253638; cv=none; b=aqisjwREG5AmmORzEPbOIBl/LHP/15VkMj7/iUg3h2t3KcWzDtP7ZKCDim/FsnvhWT1cmW4dE/V1lcauxgs6SEx6fEaCjhmsKy2IbamjNEfGg/POqx6K5y+/4rMjoBoN0O2X6jaKQI46YQErA12QzaVYgi53JnRliHKkevP3/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253638; c=relaxed/simple;
	bh=XQhuRFS5BhcmVEdMuLawsRfUu2jHBVhVjnMXYwC/UYE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t4hWb0n8zxTOFPmWk+52+TXHjFibuSnXAevy95yHI8UOpE4IiKtZ7l/jesa95IeCBEKjLvYlTKJDhWDLkhF0rbcgoBwwWDkKRd/UehGPEo75Wuq/plKbpzUzG3LTs9c/JGV+plDiIjv8awZ4CAZdRSYOwkT+s8PRyys4ZeXfP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWulMMjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWulMMjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7A4C4CEF7;
	Fri,  3 Apr 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253637;
	bh=XQhuRFS5BhcmVEdMuLawsRfUu2jHBVhVjnMXYwC/UYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWulMMjS+GA+sce/alHYMe7S7502pEHOwPO1e/XgbBPylsuwU8FChqi9PUMkVsHRG
	 1t39RpQV8EObJa9vFGWjc2iuJfAitb9hGEGomEZQL2NaRc8WrqNubIuaEbeVeuV/2H
	 MIglKDpeW7SrwzMbeTJalPgTHzExCK5WkQOQvMr90Q4qkMHJ6MHFQ0PYkuJ/eXU0qD
	 RZpsxw3MP5jDdl9kkb08OZKfYebprt/FG9JMnz4oyZqqT7+oNfDcxVEDsr1/MeOBkk
	 mOLc1Od6wjUdQuC/vd5VWi3F3ZcBwm9dVcIIbc9NOQTk8HWKmKKUfJsYCENYWzAoTP
	 jEtS2nofA9Y+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD813809A14;
	Fri,  3 Apr 2026 22:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix memory leak in
 airoha_qdma_rx_process()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361903.1466030.1505141844783892898.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:19 +0000
References: 
 <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
In-Reply-To: 
 <20260402-airoha_qdma_rx_process-mem-leak-fix-v1-1-b5706f402d3c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 02 Apr 2026 14:57:10 +0200 you wrote:
> If an error occurs on the subsequents buffers belonging to the
> non-linear part of the skb (e.g. due to an error in the payload length
> reported by the NIC or if we consumed all the available fragments for
> the skb), the page_pool fragment will not be linked to the skb so it will
> not return to the pool in the airoha_qdma_rx_process() error path. Fix the
> memory leak partially reverting commit 'd6d2b0e1538d ("net: airoha: Fix
> page recycling in airoha_qdma_rx_process()")' and always running
> page_pool_put_full_page routine in the airoha_qdma_rx_process() error
> path.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix memory leak in airoha_qdma_rx_process()
    https://git.kernel.org/netdev/net/c/285fa6b1e03c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


