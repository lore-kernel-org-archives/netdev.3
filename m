Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13972E22B5
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791334211; cv=none; b=EcjgET1Glb1KLd9lUjdTc80TeEZkE90+DhOIZg/A16PS2s+vBsxIKhkiXXCn46/+SSxXpIOzWaBlgYQBYgwmVtHGZu/bvoVwSYHeq0JN/94v0oFXfxivI0iqjZL04AeTK/YMKUuKyrN0gFQIPY/1k8tY2yP6rEUbi+XY6Y79toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791334211; c=relaxed/simple;
	bh=0WLR18cnaqFwwu3dVKdknTT+kPk3SNf490tylvumF1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KbXkg0Rd8AQaXWYkJF5F+y0n4FaW9VO5pz8PFIKB9qWejpA8DifI5GPa0TWo9lwPTgcOA7QBp0/4bbP1fRKm1dKq4PQMbDrYbHt5l+ZdocE1xNRxEywsT0pxeVoFOLegSHyFUS66vZLYKlsmZwmmHhnueOR8QJQKsnuLLzl70ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiNKS84K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiNKS84K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB681F0089B;
	Wed,  7 Oct 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791334210;
	bh=+ITRkP/s7pRRpt1skOJd6CHadfcD62eHH0nLp9wvWlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KiNKS84Ko4khJE4APZELtxC9ScYo0Kk5f0Dw2tVfMuPSNkvxrdAEv0Oq7JKMeWQzN
	 ZMhu5ulDWP7RU26A8/thG3b5I5sQPE+N7jwZ2ty3FPYL3ivrFBq0di00w3LwQKoUM2
	 RcWsDCmjskpN5LULIsBLaSvAKMNY21SRGrOd4tRpjn7o2kKzOot4w7J+/8VddvrJ8U
	 xEhRCAHr375UF72PqWSvbQiOhkhW1/uLsCygH00qsKEcjSg584mVtGgiD3G3BoJXDz
	 XGuWpv8ndVchQcakZWtMPGJbbrWtK1GPmOOZG9DtiUcWLtA2boDQNT44KaU+4B5HpK
	 xWQWvQ0VZf+VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B445F3806541;
	Wed,  7 Oct 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: ignore timestamp bits when testing tx
 frame
 status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133420927.2847663.11266607663263644162.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:50:09 +0000
References: <20261004171847.186954-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20261004171847.186954-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, daniel@iogearbox.net, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Oct 2026 13:10:53 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Since the commit in Fixes, the tx completion handler writes the frame
> status as TP_STATUS_AVAILABLE | ts, where ts can be
> TP_STATUS_TS_SOFTWARE or TP_STATUS_TS_RAW_HARDWARE.
> 
> Two places compare a tx frame status to TP_STATUS_AVAILABLE for
> equality, and so fail to detect such a released frame:
> 
> [...]

Here is the summary with links:
  - [net] net/packet: ignore timestamp bits when testing tx frame status
    https://git.kernel.org/netdev/net-next/c/88fb9fad5cbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


