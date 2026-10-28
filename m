Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230807;
	b=fIXp+DGpOFoiVvvCQlaK2LZ2QzGBS3rP1iGCgsk5LedNs/xiRneVDm9N4A/cKCXM1fvw
	 7hi72t0b17oK24J+VMTFDdKePF0L9SskEha0iQHc3p30pwDPFQbZJvqua+QbB9uk6gZhw
	 xDCl9M9fclFi1c6/1L9lKPxEp7M5OkB0oT64zOQXM2g4o0VvH/u04C0ViHIpTrcvOV0fU
	 2SEfbd5R2agbmLoRicJ0FjAiZF4xwYz3v8H1ZGS0jdNE07H3UFKNInVmPBOAx5ZH4S7Y5
	 SenonLycGwRo6uyKTR5boFwA+iBD/HSvapQRWhoejpHiNYNqKqOH9mrnrseMt2r7iKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=uY2kI5z3bPHYkCHhQ2AdcAWS/ONiyP3o5qHkCj3UvpI=;
	b=GF0HuP6K+HAnm3AjCXgDoYSnVGyQi8Bl/ObCKtNNQYjFu6+GLtpLNFIyfHn6NrbC3qE8
	 +yiBNHo8Mc8dmE8fQwCXXNK3VQepNlbb/CAHJ8QiGaiNQN7PWo1KLYLgB0zKHn9OPGBMf
	 4Zrv03hSeU+gbCT1yUKwcyEzKppkVHG2LPdMLOjplrUmA2HEwbG/llKxRRSc2cwNm2k4p
	 c/gXTu1KkN9VilL8QYqdt2op/wE6J09tO0RdM1KYCTJVIGCiZXHY+ypI1x0hdPl/zyAqc
	 P/NfeFJqcdvgJQYwGrRSUBsFUSXYGOIVMEXrhTBa2DgpFv8A06i6INQ+MDijaIKzU9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7v49fpM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA60606A31A;
	Wed, 28 Oct 2026 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7v49fpM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E07C1F01825;
	Wed, 28 Oct 2026 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230806;
	bh=uY2kI5z3bPHYkCHhQ2AdcAWS/ONiyP3o5qHkCj3UvpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g7v49fpMS2sx+JeJFdKwaqHkrbC8e32qKKp7iZLRu6EsboT9X/yErghx1jEY8wlex
	 QBUUj5uJ2wlsDEEeG0RAPkO1XJM6Ky3QtEyFX+3ykiFgHd4CAw4mLWDgFBxXpA0YSj
	 BC8KtajXrJy/uVgyQ6BFs3GPD3u94FePuT8t3kBt4jd1SmTRaHQiqFGYmYnF5cu6/1
	 qShZUUO2B7cKV+c/c6ApcpciwdTX7OdTeBDfC3TTXY5+ibT+q2hOm/xL+lBVOLJ13E
	 tO8PTTL7JO+CMU3yBuqUvdIPDs+7ntJZdAsxpQMzfzIbg4mj4Tc+sDAk8IHsrYrBI2
	 sdLp3PQ6mY8Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444683AAFC4C;
	Wed, 28 Oct 2026 23:40:06 +0000 (UTC)
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
Subject: Re: [PATCH] net: i825xx: 82596: use MMIO accessors for the MVME16x
 PORT/CA registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323080507.1480461.14843841868832449618.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 23:40:05 +0000
References: <20261025024514.802862-1-daniel@0x0f.com>
In-Reply-To: <20261025024514.802862-1-daniel@0x0f.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, denis@h3q.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Oct 2026 11:45:14 +0900 you wrote:
> On the MVME16x the two port registers need to be written in order to latch
> the correct 32bit value.
> 
> The way the code is currently written means that modern GCC can decide to
> optimize the writes and break that latching.
> 
> Convert the MVME16x specific register accesses to use the proper io
> accessors to restore the latching and make the driver functional again.
> 
> [...]

Here is the summary with links:
  - net: i825xx: 82596: use MMIO accessors for the MVME16x PORT/CA registers
    https://git.kernel.org/netdev/net/c/7cceaba6ffbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


