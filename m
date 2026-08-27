Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D835C6A1
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845262; cv=none; b=sU08kBREgQZyjwA/PZLLba61i5ZvUNHyIqhyxfA2ez9vSHJwahMmCim5ZtqiVmytx1EDfZtZcZAGEqCFOFqYtC1eFtE57TgAqvdJV6CsQ4JuBGlnsBoQDBKCs3zi6+ijPyxOZEqbvDAiuXyuU8h7FFqu6N8cWWkaj5crQScQm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845262; c=relaxed/simple;
	bh=wtjUcYL5LSp0M/mkJSKRYajSVqnlGhn1z6L1yHi50Ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eUDR3ObG4rZh1Y5J72AHDmEH4EAV3FvU1YHyvtjSVmd+yOY7aNLnHxw1bvjcRBX2Lpq4bvVdtwJY+xUOi+5MNG26sf1lCDaaIuAjSTSWjreIWi/g26pM2+jh+z6RUlQ/uP7EownLu1G83e7L8zr2GLOPYXj/MyHA4ryfO4mRk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKfB4+Jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKfB4+Jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E21F000E9;
	Thu, 27 Aug 2026 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787845260;
	bh=p4wXp4SMnAsjShMyy1yXo/6OnVjOFCZNRDYWqRA8YH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iKfB4+Jku2apizg0iJQ7k8xS39erHnid2NYigmfO/q+T/BUXaZ7F+SpTxnHERxzWC
	 zLyGc4wm+QCk0g0tcBKwwrTDlMY8KSn3Mr6sfkJPm32TOJ2gUANHo4UkqP1K2GyDfB
	 RDE+jczfHHiVjfW4MctxUSO+Dlt+CIlUVE//vgXRJ+9+KDmG/77+hMuhyFKQMHch2Q
	 exsS8MQApbYwz9rpiFo3rT78/AOBFirKWJsbuwS2UCHHIaKlEMIqIuYfwbNmxkJlti
	 GIeP+p4+IgBbSqcEeP5e5DfI5NUx9VhQmpE4nsNfHGnA5w2Q2tJSnv2k6U1M1f4kTf
	 mEq+ucR0RkJnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938E83809A3B;
	Thu, 27 Aug 2026 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 1/2] net: airoha: npu: fix missing streaming DMA mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178784520615.1711054.16936700320913913242.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 15:40:06 +0000
References: <20260820085941.380401-1-pawlik.dan@gmail.com>
In-Reply-To: <20260820085941.380401-1-pawlik.dan@gmail.com>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kuba@kernel.org, lorenzo@kernel.org,
 nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, yangshiji66@outlook.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 10:59:40 +0200 you wrote:
> The driver calls dma_set_coherent_mask() but never dma_set_mask(),
> leaving the streaming DMA mask at the bus default. On the non-coherent
> EN7581 platform (Cortex-A53), this causes the NPU mailbox to hang
> after approximately 41 calls when using streaming DMA mappings.
> 
> Replace dma_set_coherent_mask() with dma_set_mask_and_coherent() to
> set both the streaming and coherent DMA masks, matching standard
> driver practice.
> 
> [...]

Here is the summary with links:
  - [v10,1/2] net: airoha: npu: fix missing streaming DMA mask
    https://git.kernel.org/netdev/net/c/6fe7e31a45e3
  - [v10,2/2] net: airoha: npu: use cacheline-sized buffers for mailbox DMA
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


