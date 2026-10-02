Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5A62809;
	Fri,  2 Oct 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902207; cv=none; b=h3Dr9IdsmgvFogM3b803+tzJJQYEjZCzImtrJTwawHZlXRr+qU+hNVNp+g5AM2uSUvzL4O4qCAbfKec+aWaAaHJPA0C9hy+WRxgSv8Ndxu8ENhlX5R3Z8tj4Kcs6Xx5Oy2E0atRL886x3RzE8p0Pv3NSfJr3LFV0aWRRdvtJgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902207; c=relaxed/simple;
	bh=0el18PbQy0dWcfUZZZWoiwo0LtFtA8CD26TEIKwFuMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T2eqi8NzIiwwICJZpkZ4QZ6TjC+wouGA883wR+IvH9wc63pqPoBS5WNLzqIyZ1vhmPPY2+l44T9W73/SM46CjPR4ZAfDCkjy4clKzZ7cZsJPHEWC6hLT5HUfylLINtsa7I1HkiscCMNJ/8NN24wAVmXMNQ/JlHPCKx+aoO12FUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvzxnuKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvzxnuKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295241F000FF;
	Fri,  2 Oct 2026 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790902206;
	bh=vhBEnvQsyfC0h+1h1yPjT+rFPAZoF7o3I3ZKMbE2YS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jvzxnuKykuPPj6wM+3ifU28bUu0urm3B38iPsHz8QXXxIVteElcCS+v0h93CfTbVp
	 qKE9PyiHMpXHIusTDAUsx6At1J7R480m+Os9q+aK+MH/FieSGnLorlZ5SSy4vYVCyv
	 Hs9tC2vY6vh8D+X88kt1S1mJyy0XSAqcroiPD5uxpFVP6bHKajRp2UQkkbrcmWHQ49
	 KdBxIQGAtLMOY2IFSnqRwW5S47jrKQ/7RnN5/PF2Slg24L6dL7BcgGxT8Q7him2xu0
	 NagSzxSpwAUcX0PeyqGPK6myTOuAPBcLY3yTAK1lxocPJk9W0zap2mx6+5oDAAINnA
	 bQ1yOHbTCIv6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20E06381197C;
	Fri,  2 Oct 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: octeon_mgmt: kill TX tasklet before freeing
 rings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090220503.3161824.2688708785190122158.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:50:05 +0000
References: <20260928134125.2003-1-getshell@seu.edu.cn>
In-Reply-To: <20260928134125.2003-1-getshell@seu.edu.cn>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 21:41:25 +0800 you wrote:
> The interrupt handler schedules tx_clean_tasklet, which dereferences the
> private state and TX ring. free_irq() prevents new scheduling but does
> not wait for a tasklet that was already queued.
> 
> Kill the tasklet after freeing the interrupt and before purging and
> freeing the DMA rings.
> 
> [...]

Here is the summary with links:
  - [net] net: octeon_mgmt: kill TX tasklet before freeing rings
    https://git.kernel.org/netdev/net-next/c/c47befeabc33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


