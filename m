Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629606;
	b=Yq9caqOwyg9gasqQSgqZfqcsrBJCgw+ClW0S04vRvNkX7kG6AsHcJtFMNYVL8gk2laxt
	 FCYSCsOU9e27Hive/L8IdVXYMKC8XYNYpeZPzWxdX9OA2p9b4tYK63jEaD+zFiwzf7Mqe
	 s0sdz1W5/oWPuO+K4ZyqMZQSJSG+MRZYMAVXfuTkPq3UB6Aat0HVe+udEXngZMqH9TlKG
	 v0ciSv3sh8ZLoIZJUZUVU05ELuXK9rQER/DtLZ11p/ey+uxIrXJyqv2yYsaOGRk/kG+me
	 +Da1eIbqZ976SNn7sbBItQqB00B4YeuX1hc7JFJKgbGpadWSM5YE9PbNCD2Up16R92Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OTrjutFZCDQ0l7WrJm8zKTeNmXt5KhwGLpP4D9UA16Q=;
	b=Bt/lhZr6mvRr9ft+boe2U9P+Ao1qWOrnPWx8zA0Zv+36lcmJ2g/VtmV/+ofwOmo9Pq8c
	 FPJV6S7WdcLVhnvbjqXDvzKrV0uHXNbsUX7R4leBd54Mkq/H7YRNQoQArBUzSCG2EME5V
	 ziSFOLaCGb8KbjIQ7Ogpx0Es84OXFY1c1QNe6pQ8yiW5InzuDZaUPgoEMi1C+XgXwZpz0
	 oxOvc2dbD8lpwapEdMDxRj227+sR5A6bFY3oOUdSqC73xDaq5uGuEmg4b+EGax889R7Wg
	 DsRXjMC9IAStgUPouqYpAr0i47UrRvvZdw/qtjH9FDgr4Jn5Ok6P/Njquwkhkt7yrNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASDnPjLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB4606A319;
	Thu, 22 Oct 2026 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASDnPjLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE0D1F000C1;
	Thu, 22 Oct 2026 00:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629605;
	bh=OTrjutFZCDQ0l7WrJm8zKTeNmXt5KhwGLpP4D9UA16Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ASDnPjLswjTiE5WUv6kmaahpQ2Eq+7dwR1RF+dFcnKIHjbg9qJYNKvXqzFqg4KT2m
	 TdFDo2xaqUF4Iy4hBAuhrObOsbuKEjkuLJsAIEmRgl4O3MLeDcOURorp/FuwKvttS8
	 ujBITBsW6e7a6CPtXsev/M0eO2iaZX2SiASkzvyNTeICoLl6y/CskgKwv4WX1hnfz9
	 P8CyEVtRErtLuDoMDAm9FFjE5J6cbbXNs/6tfklDnD/V9d0oOjwXJc1ItQkOlX1auG
	 bfZ0xyIgrQgYe5re9ZFNSAPg0WtoR6qI4Cu3UYx/aU9bBxE0Gq/+kFr9RJp5bvuoLO
	 tfEDmmDPQU2jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4660380A963;
	Thu, 22 Oct 2026 00:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: bgmac: rate limit RX error messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262960453.1381785.4962376114187945647.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:40:04 +0000
References: <20261018231629.39734-1-rosenp@gmail.com>
In-Reply-To: <20261018231629.39734-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 nbd@openwrt.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Oct 2026 16:16:29 -0700 you wrote:
> When the RX ring is full the RX FIFO overflows. With RX overflow
> continue enabled, the DMA engine then writes one frame with a bogus
> length (always 0x45c2 on a BCM4716), which the driver drops with
> "Found oversized packet at slot %d, DMA issue!".
> 
> Under sustained overload this happens on every NAPI poll. On an Asus
> RT-N16 a 950 Mbit/s UDP stream to the router printed about 1450 such
> lines in 20 seconds. The messages are printed from NAPI context, so
> with a serial console the router spends most of its time printing.
> 
> [...]

Here is the summary with links:
  - [net] net: bgmac: rate limit RX error messages
    https://git.kernel.org/netdev/net-next/c/77dac783f113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


