Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625C1A9F9F
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816821; cv=none; b=P3aG64D9dFKKFYBdNAm7GO+LQiJow9mPxANhy2jp543BtobaAssJnzdjxlU1e7XFly4bOIY2KGOqih1pLmmrIXFNdw4mqLSgOAqYgRnZ6XiQETHoobPAOqnN4gLogmnkVyt3bC2DMTCXxw/psCpNO5Ow701nJ6cY/gaNMD/H3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816821; c=relaxed/simple;
	bh=GBVNDpvpTMYRwuBR5jHuCGd39lgzUCI90GiEX4xBk+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMYNr9wc5xJvq8njBTriKOzqQUenIpomEy7ZtFNikdlekHJtq9LelXUFBFY16UIzk6kF9eevisoaQUUWvH4S01a1W7yAHMO2oIcHVonXn8/dtQ/p/E9OCXpPqgMv2xGf4OIWcLXpG3U9XuSerLAj0Ybfb0RgtJ7SROcZLgXBHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp8JmTXf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp8JmTXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AA5C116C6;
	Sun, 29 Mar 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816821;
	bh=GBVNDpvpTMYRwuBR5jHuCGd39lgzUCI90GiEX4xBk+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rp8JmTXfm+dxNCpQ+M7WhZdunpj53g5HPxuXTl/ELmKUSzPuEkv2YYZBLsR7vTi1h
	 9lmfMAeYWUTny5YVKCOCYUkw3oBwJRuOSjuVib5LXwN8ILkefVy8E3+NMnNHsAQnNz
	 NkDO8q+UD11tFeqBgdS/fN1CC6SXnCdCBW2keCpIsi2w6CIL2p/VS08liSyN9Vj16l
	 x34hNmbhfGAuyhV2ntSpQDfE9Vgyh4RUDhJbdCgXgk2zg4D83QNgIdb+V1KdnL+pJH
	 Oabxk/VCvHbhBi6lg0E/A9OAdq3Tli8INTNf1cf06TD88QK1gQ1VO8cIqMPKN8rW5x
	 1tNM8D3Elxu/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D373930012;
	Sun, 29 Mar 2026 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: qca8k: Use the right GPIO header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177481680579.460129.6710614801382324337.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 20:40:05 +0000
References: <20260327-net-dsa-qca8k-v1-1-94e613a5c369@kernel.org>
In-Reply-To: <20260327-net-dsa-qca8k-v1-1-94e613a5c369@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 13:23:45 +0100 you wrote:
> The driver header for qca8k includes the legacy GPIO header
> <linux/gpio.h> but does not use any symbols from it and actually
> wants <linux/gpio/consumer.h> so fix this up.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  drivers/net/dsa/qca/qca8k.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: qca8k: Use the right GPIO header
    https://git.kernel.org/netdev/net-next/c/d4383c7c7863

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


