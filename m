Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF12DC352;
	Wed, 18 Feb 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378216; cv=none; b=uwpwDSvG0qb6HzDsTmzAfpjJuCxnXW2QVAubLeETrkg2CWHaGUMZVO/xDjC0ZOpawV98x6ejvauRM+OBQU+aIlC6O4J5uA3SmBTSFOaabk/7jh94snjpbKFCi6OX2PE7rkL3yAabUxbZaxhQQHDV/u0pSM1V8mRHkCeATALlNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378216; c=relaxed/simple;
	bh=IrIT7XGf/L8NQo867kl4btMQvfxnNdGTOrt3hsd6FuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLMD5df5V48r/PUvICy6h7mzFmsrUKdl8TiQkVtcwdZMe93hST5mbtmzASKKXSiudLZWl+XLEViwKJUZEhp5WdPRbQgAprKVj9cGuqcW1ggPoIthut/OzYyBEXFVxTmWWjeSu4v4p0czyeP/UCuobYKv5a3lsGqHqwRPlX9xOEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzdfUK+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzdfUK+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F49C4CEF7;
	Wed, 18 Feb 2026 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378215;
	bh=IrIT7XGf/L8NQo867kl4btMQvfxnNdGTOrt3hsd6FuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QzdfUK+R0NkY3M5sktn+qmJJ0ZQjAs137g8T2332DCT9wnf/9KHZ87yYtxfkhLFht
	 usxXCi5It4vagFE6EUM1BSVYQ3c8bBDSsPkRR25aJRcNwHSHkdejVUUqzUUl2IY5Jc
	 tKMDPwE3R1zsnclJ/nEmjHMkEa3yZXvEU0c0YV0G6ycEk7gpFWkbyYAU6XUoQmm/ws
	 b8Sp28NnmuJYIdjFVoLl9XzhKtZo/NOkRGW/UBdkHVkSbhwKnaNu+dY2QJRFj9mVIu
	 Qec2143ZYw11bR2BF0lK/9cZCv3hO4tI6v2DhuqWIo4+mWOnzj7J1Vsqox3Hw3Qswy
	 NzaIRQby/1AZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C24183806667;
	Wed, 18 Feb 2026 01:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ec_bhf: Fix dma_free_coherent() dma
 handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137820757.768688.9508706442919619950.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:30:07 +0000
References: <20260213164340.77272-2-fourier.thomas@gmail.com>
In-Reply-To: <20260213164340.77272-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, reksio@newterm.pl, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Feb 2026 17:43:39 +0100 you wrote:
> dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
> the dma handle. This would lead to improper unmapping of the buffer.
> 
> Change the dma handle to priv->rx_buf.alloc_phys.
> 
> Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle
    https://git.kernel.org/netdev/net/c/ffe68c376699

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


