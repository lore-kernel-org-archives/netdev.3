Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267022;
	b=e5CBkLhcpRs+t9boWK3ZstlsCSt/tfXki9wZBcnHGMNohaLdyzvrsSJdSbt5oF8oJUjM
	 /FR9Kw+FdJD4RA0qpwns6qZ3TxNyZGu6tFEO++nJiy5m2jaBeQOCBYl9b4LdNwoNMe63R
	 S/IzUxyZmx5eYv2p9a+OvRUYNgOBr0yVnRpG/7RIrgqr+g+w4c9l9FvoVzGECnGpMNg0L
	 NnYGWmGSaGnxZUA3q30iK+VraryZVZlivCICIkQw8F+5jr/gqAliaPtJGHDNyNtYS4qlf
	 mBxuPuNEFyA+Dk/YQtuDwjMXROfIE65jlaMg3DsWSBV2GEbeMbXtfmGwlPR5pGok85Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267022;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d7flpOWW+EdDVpjqNDQCEwbgE1WjvjabhxU7S+bNa1k=;
	b=Wt1U+1dWSBgKCciUbLsjD3/pyJ+ZX8xi/XnP6JSrSSIg5JVyW9NNBKDySBDMlAfjj4d3
	 ifmFzOxeCHNfnfi6NxLdE2gfOteedVI/SPe5q1RMO30u2c4epLvUYbbXNBysr9sO9bUDS
	 DOwQ1gjcmiLqaa5eIPZ3E2nYj144Roj/fg9UelMQyu1X2rXxd/IeJCvaVnI0yXRlcUS+o
	 wHo+zluQfyDcCP159o3WfQQFajp63YZMWTMAZqHYYQl2bxzwXj564ET1QOS+1ExWkKNmI
	 IJvP4/lQNCPXn3tCQGHOejU5ydvRR6SMKcja4dglX2xrCBmK2Glsx0hSax5yvVSUfoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nH0eA1sB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA7606A321;
	Mon,  9 Nov 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nH0eA1sB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F5E1F0089F;
	Mon,  9 Nov 2026 23:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267021;
	bh=d7flpOWW+EdDVpjqNDQCEwbgE1WjvjabhxU7S+bNa1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nH0eA1sBP1mmuUL/NiZB2U6tR8AqFqC1VUc4yEC0XgDbq+/OlqmO83hY2wwD4f0kE
	 SRVvBzFKjCpFaRrfAMyDAl1qwqChLR6ZfKotz77LNMbr8RgltPhUbok1hkuA6KVthr
	 Fdw9U27S3VN6VUSZ8RfvNcj1iAkaqXGyQLb1v2WRAWxTGI2WIrQb3u/FxU2wNO16D5
	 AlnyIipXX4i41jFRVFN0IgAXPp/GpfXuY0MifwXnneutL/ZqOQ42sRNocaZKjpzIdy
	 bQebz+JbMBAQDNF1/ydGDVCK68K7p9nj4S0hlIkRbMd5t7QlBfhcUvdT60BIM4Oe4s
	 N+ZL2Do0Qnvfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8354391AFA5;
	Mon,  9 Nov 2026 23:30:21 +0000 (UTC)
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
Subject: Re: [PATCH] net: skbuff: preserve fclone lifetime when freeing stolen
 heads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426702076.3543549.4583782076046363502.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:30:20 +0000
References: <20261030042329.74461-1-kylebot@openai.com>
In-Reply-To: <20261030042329.74461-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Oct 2026 21:23:29 -0700 you wrote:
> skb_morph() can give an skb from skbuff_fclone_cache a page-fragment
> head without changing its fclone tag. IPv4 reassembly can produce such
> an skb, which can subsequently reach the GRO stolen-head path.
> 
> napi_skb_free_stolen_head() puts the shell into the ordinary NAPI skb
> cache without dropping its fclone_ref. If the embedded companion is
> still live, KASAN poisons it along with the original, and later cache
> reuse or eviction can overwrite or free the allocation underneath it.
> A mirrored batman-adv DAT packet retained in a plug qdisc reproduces a
> KASAN use-after-free in plug_dequeue().
> 
> [...]

Here is the summary with links:
  - net: skbuff: preserve fclone lifetime when freeing stolen heads
    https://git.kernel.org/netdev/net/c/86706ffa990e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


