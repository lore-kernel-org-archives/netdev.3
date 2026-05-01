Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC271E492D
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598456; cv=none; b=gGAl6K7grF+1esvNG1OSrVkYsnfJk+QwADwEKvMzfNokkUOcqxKnRSFFIqIRlXIodKp3NQASNlxwqDOQZnuacs9VBd2nW1f/uWLxuz+Hc07W39tfBcFRILMoHJ8QMYo3f8t0cHk+hn/GKAZC0zVvbeBz+I15/raPDa7nEOQUWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598456; c=relaxed/simple;
	bh=7rKuBfm/sZqWZkIHfGrPtqBLbz7QhI+DrjxOxPQGULw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CUhu9NVYELJefGW9ueYnRCp8rdosSfTWV/scmRlnDGZhuTkpnkSKbwerSM4gF/TucYuOVYhY0nAHdunAEQjCJTkUxla4vNhNCiOIDfT/0/LSVO/CacOhOh4n0EU8PPnQ7uawJLwrRKupxkHOZ7nPd2UTv4t9jtWET1RmTsNKi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsBNqDWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsBNqDWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7BCC2BCB3;
	Fri,  1 May 2026 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598456;
	bh=7rKuBfm/sZqWZkIHfGrPtqBLbz7QhI+DrjxOxPQGULw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IsBNqDWiGsHNeM/iuiQqKxH4swR8cjkUwEK/tmacRzj+lrUdMaXDTaGVNofROB5sF
	 bBRODprviHwVF9VQuBIYcZfE5TFhZpUthESgCf5ZlmBwO2d9jAbWnyo60NtK+kvPiB
	 ukozERPSd6GQgUthnkjU2WUEQ7hoLZF1IL8iPi1XhU844bync1gOyFnYjr/xvF8fA4
	 6vOpDxwr6dkSi/MiGP2eb3tWmb+nCsu+Ts1i2ezYiJUJiYRS93IBhoXefPfCOJ6BEu
	 kzIY2gOsalMit/H10XPtTRPMiWg/LTiI6Qew0wLk4YKCDUwxJsX40ZDqYtv7UauFVY
	 oKxsyQDxwdAuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC46380A957;
	Fri,  1 May 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Move entries to queue head in case of
 DMA mapping failure in airoha_dev_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759841005.3278779.2333326558858237558.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 01:20:10 +0000
References: 
 <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
In-Reply-To: 
 <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 14:02:31 +0200 you wrote:
> In order to respect the original descriptor order and avoid any
> potential IOMMU fault or memory corruption, move pending queue entries
> to the head of hw queue tx_list if the DMA mapping of current inflight
> packet fails in airoha_dev_xmit routine.
> 
> Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Move entries to queue head in case of DMA mapping failure in airoha_dev_xmit()
    https://git.kernel.org/netdev/net/c/75df490c9e84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


