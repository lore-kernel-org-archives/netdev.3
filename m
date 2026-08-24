Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7F3859E9;
	Mon, 24 Aug 2026 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596864; cv=none; b=AX4+hOqSxPuyfgDhJgflmoItb94oaS6BgR318VI9BnKEMKzS3tHRXH8jL0OPR0i6SwfqmfVfKOSTjyMCPMeCHeyjvjVdJXm8NfHJEZcYgFb8dETvBMpcNiVrUARl7UApTdCzZFKbjKRW+QVlTiI/lVkxYzmuOEqQ3U8KMndPEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596864; c=relaxed/simple;
	bh=zIf7jywNpBw+wmxs/DgRStXTICiB+A6pm59kESIzPYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1MAsJYUxW8/S4UlLUb9vDzeGqJYkYlDRPXPABltY7yQrohirl4IqEtEwhbAsWLUmbnP7Vtevedcnt8vCiabbehinsWiNHVGkyEb6rqm0JoTxlTDHA1N8RVN/eddR8VY20JYzZ8rstzrgCKhVACZquJJIQ3ALWKKSZMohp9BeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ7iwpdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ7iwpdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932FB1F000E9;
	Mon, 24 Aug 2026 18:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596863;
	bh=PQtNhnA6mtlqiUO9MPrCI6soKXJLBf+IR16LYmv9UDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kQ7iwpddUJrrg3NkfB1t6R0eofGj6zOWjIwxRjbHGhEU7Fg7e4A5kxvTPFzhpN+uE
	 osR4ahyxUWHAmODJ7WmNGZHPnU9mh/qxYZKt1qWI7boE6jS/Os7ZMAzL1wbNLRTuHq
	 uKPnk/9xbxDK1Rj3WcnxVybueCb10LSosHVuGkv2t+qjHPU4oyr09qic0B6BiLBTS4
	 nU+tgbP6QXX4/s2sQAj19522/aW9MCRR0nKBezsRvicLN/PJoNh/VT6Y35oSVA+Gqi
	 BdPiNXknQZ5ZLssG+T4njEeDX0TBX+fzIHyzbThJIuUjGgtIlbSX+2XG77jYORvsz+
	 u7YxpjZnbXVZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5681D3924A4C;
	Mon, 24 Aug 2026 18:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix out-of-bounds read setting MSI-X
 irq
 affinity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759681089.3058449.18175108445880184567.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:40:10 +0000
References: <20260820055451.2642358-1-rkannoth@marvell.com>
In-Reply-To: <20260820055451.2642358-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sumang@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, sgoutham@marvell.com,
 agaur@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 11:24:51 +0530 you wrote:
> From: Anshumali Gaur <agaur@marvell.com>
> 
> rvu_register_interrupts() walks every MSI-X vector and uses strstr()
> to match "Mbox" or "FLR" in irq_name before pinning those interrupts
> to CPU 0. irq_name is a per-vector NAME_SIZE buffer, but not every
> slot is populated before this loop runs. strstr() keeps scanning until
> it finds a NUL terminator, so an uninitialized slot can trigger a KASAN
> slab-out-of-bounds read at boot when debug options are enabled.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix out-of-bounds read setting MSI-X irq affinity
    https://git.kernel.org/netdev/net/c/4d5df98369c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


