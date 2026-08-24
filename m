Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A73839B9;
	Mon, 24 Aug 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595666; cv=none; b=GHIoL+REIaQspNyktrJl1LLfC/ctD3EPaH+gZpGDzGHXwyVgVND1SS/IaOt6l+qcEEgLefRWr+rDsXT1oUM99M1UKpkZoS+31Aiaj5tjcaQ+2G0q7LjoFAiTOAMi9zj1eMYMqk+nB11cdZpyg1EVWqbkqS6hNYYl7YHz54JEBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595666; c=relaxed/simple;
	bh=WA+DMs6W+l9PG5WMFeSHJGhcnhvFqznANMyCq/1qbCw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HhoIZcgG6OxC8rwbi6RKw66kwSkIBTgsGZE0jXwxtZyqsHBBEDQQ+7hEfUVPCT/qMluwuDkMMtQ2YDi9IfjAPXhE1la0FjUY0dWiz2zHlYXIwKGyn9kLWSyE7zVFKzzir0vGBxAFh2LHkbXl+KVaU6CT4khQQz8Ec1JL2bqe4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asWIVPnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asWIVPnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6FA1F000E9;
	Mon, 24 Aug 2026 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787595664;
	bh=VC4G+XqTAfrFRT64hospUFqXl0HFoiSRWtgAhJL/a7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=asWIVPnDJTek2DU4bX3bTdXnsGHKhQxERRvr5tTvYCyhEWPtoUjvefBo1gyS1UW0c
	 qme9iVwF6OuNAv4rALq0+Yfbe8SiiVdJ8RTdEsOiFgTFIKUPGg9DcUoFYrSVzvtMkv
	 AccRbe9dGSIBTIwycaqHVW21yHOuY5/ZutfX58TL0zVHMMJydHLoIdRSSjHQCT++HR
	 AOP1axogqC8H9N5vYkOAO+mryC5l1cVUCqP7Q8RRf720hk4w1MO6WT0fqsNtPta5fZ
	 lyIuDqzXTu8HFeEeJvbuF1JW2MIREZJaMdP5TI7wCJeO3fzNmW2bXdMyxMF9IhV2su
	 R5dLvVnF8MjAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 727BB3924A4C;
	Mon, 24 Aug 2026 18:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF to
 0x80
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759561210.3051903.7350962309805353332.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:20:12 +0000
References: 
 <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: netdev@vger.kernel.org, rex.lu@mediatek.com, nbd@nbd.name,
 lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 21:07:07 +0800 you wrote:
> Change WDMA RESV_BUFF from 0x40 to 0x80 to avoid CDM TX FIFO overflow.
> Without this patch mt7986 and mt7981 may have WDMA TX hang issue. This
> patch was pulled from mtk-openwrt-feeds GPL open source project.
> 
> Link: https://github.com/mediatek/mtk-openwrt-feeds/commit/07c87502e854b68b48544d101b6fe17ec059b97b
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> 
> [...]

Here is the summary with links:
  - net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF to 0x80
    https://git.kernel.org/netdev/net/c/c0ef04232f9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


