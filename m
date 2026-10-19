Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452009;
	b=w++tmlAXtd76gZAobQBcYYVfHiBkpfOZdTSks8PVgfabBjp+gjYjUXmXF4Yt85YvY0Yw
	 PmSjtMkXZOwIKHELOlmaPAG1YU5ZVMkKsB2N4ACJCZEsjgmQ3Ltv3XEykfeIEcGZLmTol
	 aku4tC3aWYrpgLFgymfTRU1lTO0TKUofUWDg0fjs9yMB2Hb5NBQMzcXiwW5roRyYDZB3H
	 lOgbnGp+MdMvF3pzT8Jg7Vt/foy3ZDP/2i531Uf+GIxzkxYyXc1eEOOZjqAapb2wv7cRg
	 SGrSC7OD4g4JPa0I7IvjmxtCgNT8mPzBkXEZjs8pFKX24wfXdnTkYy9ueLZt9o6qlEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UIFGHKXHOA/8BifJkz3D7Mz2RiXvRYHx03CDI/1Bz+s=;
	b=nhhi43Im+lM2+3sqlZAeNmcer+im+QX9OuLtS9qziqInSNFdEoBzzTiEDqr3dxFKXJkI
	 b23228QgS8jRhGLF+3MMfqd7YGA6U7qv1uiK1Zz8bhFJqoUzEeqCc/xKWxQiuSs9LTQSt
	 agDNUWZvXQ+PGu9nIlsAvKNRJS9Qbc2qyLo22DJOc1S0fKpuzIhwezU98AvhUvA1PxOpR
	 07DuwmpMUEwP//VnZ8CzhX109SKj8mPs9KB0MDSOrdaMq1/hEcJF3rzW+XujwdFqYK6yG
	 We8B1z8mwOy+FtXVewKkDiSPvHlIOs0Skz+0/hlYzfqFMCsfdOJAnacazSVWqWKOZ3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrrPwx9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8188606A319;
	Mon, 19 Oct 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrrPwx9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F90F1F000C4;
	Mon, 19 Oct 2026 23:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452008;
	bh=UIFGHKXHOA/8BifJkz3D7Mz2RiXvRYHx03CDI/1Bz+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FrrPwx9ZBnlNQ63R/+vg3oitryhq52mzGM7P2TfAOBETGQaeCKG7XEWsidZCiHMsv
	 OSmIw/Mzx0+IU3a+qwoVKIkLtLMGN8AG+eeThX/CmceAGPXKz4kcl8LtoPoaEy9pz4
	 tMZW8ve5QzRwMMblcYWl6IQwjEmCzhAQuVK+CAkrT7/DfhFcQ59UuZFn8cjj9sLvb7
	 PffznVmcUr4vNPVCBo6iZVgcdG3Sb+NuFQvhJoPEUJGU54rj473ro2h9psii0jKARm
	 w8/zjqR90PiCLwRhV7+YoF564zLctF1QhBFcZXwfXJWhhbzzbZqS/LsM5BPfi+3rmh
	 vTu0+0RjkyKUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773CF3924A66;
	Mon, 19 Oct 2026 23:20:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v16 0/7] r8169: add RSS support for RTL8127
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245200728.3379641.6632488338806435429.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 23:20:07 +0000
References: <20261008065722.1026-1-javen_xu@realsil.com.cn>
In-Reply-To: <20261008065722.1026-1-javen_xu@realsil.com.cn>
To: Javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Oct 2026 14:57:15 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch series adds RSS (Receive Side Scaling) support for the r8169
> ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
> 
> RSS enables packet distribution across multiple receive queues, which can
> significantly improve network throughput on multi-core systems by allowing
> parallel processing of incoming packets.
> 
> [...]

Here is the summary with links:
  - [net-next,v16,1/7] r8169: prepare for multi irqs and napi
    https://git.kernel.org/netdev/net-next/c/36af5aac9545
  - [net-next,v16,2/7] r8169: refactor RX path to prepare for multi-queue
    https://git.kernel.org/netdev/net-next/c/5df447aee076
  - [net-next,v16,3/7] r8169: add support for new interrupt mapping
    https://git.kernel.org/netdev/net-next/c/677f8f8c4c5f
  - [net-next,v16,4/7] r8169: prepare for new interrupt mapping
    https://git.kernel.org/netdev/net-next/c/7c543c5d12b2
  - [net-next,v16,5/7] r8169: add support and enable rss
    https://git.kernel.org/netdev/net-next/c/90d0cfb577db
  - [net-next,v16,6/7] r8169: move struct ethtool_ops
    https://git.kernel.org/netdev/net-next/c/dcad1105f164
  - [net-next,v16,7/7] r8169: add get_channel support for ethtool
    https://git.kernel.org/netdev/net-next/c/aaf99d89a72a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


