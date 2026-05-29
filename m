Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF63B27D4
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086022; cv=none; b=dF1UhCJRc7vsrF4OfuDr2znNGK+BE09GVCplZ3y1LElQsxWorPr24BGrQMAZWrzJ5zqnU3IjHiUHMoZR2P8hPhzmUSAATGbd1odwpm9Bnga5B4FO9ajrZrHZk6AflovJeRKmrr/IwUAQ+KX0uL72g81sNSnI5UsiDgebdt1IogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086022; c=relaxed/simple;
	bh=oUcRPi4LS8VLjXwL2svgLs3IfJFtlsQS2KuvXGEiaEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bGaLJtoaLsVYf5Jgn59motis02JqFCdvJY9cSsx/PTzdK2DZ/3BtSO7i/CSuBB35xeSUW5yRRyHexik4XxQiuP6QV/6DvxEm4GmR+1uDM+t+AhsIqsHUtMY1P65nEOaRFFuUzbCA0Cis+0uN3wskt5SB8hrCKrPln+7tdNPnUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd6K3dit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd6K3dit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AE41F00893;
	Fri, 29 May 2026 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780086020;
	bh=tVFWNZfQAOHUYYHe6+cBAhqMlu2eJADcyQKPGm3Ebh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zd6K3ditG627DMvBpaEFo5mMuPr32GBUmKif7P215OVa3WSnCSSV10zM9NWLWDTAy
	 y2Fb1fxe5YInUWahpOZFbPRuBowInekNr30g6GISu3fu9O+ecMnchlS7tTwIQxCzM+
	 f3DfN1y9t/ItalyARa4tERWHf5d+xkFTntCTGaZXxMmV8uIfmHPloZRx8SwwPA5R8Z
	 jlkLnzL/jhAYoHGsM41LU7EaOWAIzzcqiNHrDqXQP9QzYoYUO0vSO4QPq/6fXIcfRH
	 Uah2uallj1ez9twRQRxobR2ylU4gbKCEeav+REwSJmtz6dNeRaFgZqU8S+yZChTs+e
	 S6GLObVozt0NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BEE39301A0;
	Fri, 29 May 2026 20:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: skbuff: fix pskb_carve leaking zcopy pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008602442.1951456.17330916463502610532.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 20:20:24 +0000
References: 
 <1e2086aa69217d7f9c8da3d38f5be7160f1b4cd1.1779993185.git.asml.silence@gmail.com>
In-Reply-To: 
 <1e2086aa69217d7f9c8da3d38f5be7160f1b4cd1.1779993185.git.asml.silence@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, minhnguyen.080505@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 19:43:53 +0100 you wrote:
> When SKBFL_MANAGED_FRAG_REFS is set, frag pages are not refcounted but
> their lifetime is controlled by the attached ubuf_info. To make a copy
> of the skb_shared_info, we either should clear the flag and reference
> the frags, or keep the flag and have frags unreferenced.
> 
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() don't
> follow the rule and thus can leak page references. Let's clear
> SKBFL_MANAGED_FRAG_REFS from the original skb to fix it. It's the
> simplest way to address it, but there are more performant ways to do
> that if it ever becomes a problem.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: skbuff: fix pskb_carve leaking zcopy pages
    https://git.kernel.org/netdev/net/c/ff6e798c2eac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


