Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740210;
	b=gTaCgNnf8LP39AAPypjrmvcK2rvkQg6ggSpmwhFJNDPHTYbRYBLKdtMxfPOHah6T2r8g
	 QOCoHlbfMeKnvEoMJ/LaqAYihhtb1S/MXlzMgFF9atpEw/0MuOzX4tOMaCTHrHEdz2zjX
	 2IXXV3XKROeKvMx/bNdbmc36l7uREsDG3kQ8yA9Py07P5RqxfmcTTJvIGypv9jMzyaCVB
	 qCrLQOcIxc8561W/IHZXxAb0+1os7Tiw1wB4uWsyPzCGOOO9RQm5GyME8jwOGKGLnhiq2
	 q14m1nZKS2NbcB+Q5qrWE7AXzGoVhmFOA21aqD9CQZCfa5nz+RMJwv23MtiCD6NDKEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zV7Lgp51qEqo2WDFdMLU1p7YBKIQkpPhWHSCGlkZW/M=;
	b=3XJtHAAz6yW8Ydzp3I6MyQioiKqGLr+psVLUt+zaiN1tGODJ4WC8yquIAh00gQfWWKJK
	 nSjCtyX8jLxSne25Fr5ufMZqHuDNfDxx1Q4Znqa+px81WhEpE2pGdwAwMKSUb9xKWqTc8
	 Pkx9DSV3HHuUqIvclRFUxLhwVRCVEik7on1nY/2K145b1gLjuY4SpNAymLMgBdH9fEWat
	 gBRf346P1xuj/NaWOSWDqsgf8YfoZHhoMzrKI7BKAWH4oHtH+Ny1ei5ZSvjcUU4X7v8Qd
	 5nZAV+qCAEULVB3IQxzh9bDq4OTRwVpftofuq+tgXO0ULAdVXvcDRdMwaA21L1J3lWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itI0bKYE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED9606A31B;
	Tue,  3 Nov 2026 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=itI0bKYE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5931F000C1;
	Tue,  3 Nov 2026 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740210;
	bh=zV7Lgp51qEqo2WDFdMLU1p7YBKIQkpPhWHSCGlkZW/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=itI0bKYE8HR4qZE209NCueObkiWZE/j4J+y6T0pvNyc73uwodbpww6WiVfbAUk7GF
	 HflHM4dhjSu3SM/bL1rPPjw29d4RYXvD17IbVh39sNBL3eijtjAEwR5erZGfCZFcCE
	 WQAjQTaEFJUmvuMsP9pzgxSdm3tdz0gj3fRRm/NeNv8tuBzZfwXWdz7lfbeBwHrlaR
	 C87SOPjCx4sCuAJ1zzgLp//rdurQnAhSzvRnOH0yhBk6Rd3ZI1bSiwMs/eNRIMz8JC
	 52McuFyLET7Q5QgR6zq6scw5bg1JnTMi8k/nrmVqrx8qyXlEIR3f7B+EhT5ZhL+vy9
	 MB2BikdEIwSQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03132391B0A1;
	Tue,  3 Nov 2026 21:10:10 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: ethernet: mediatek: preserve sibling PPE
 bindings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179374020858.1880228.9743953514014477016.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:10:08 +0000
References: <20261030010517.45639-1-alex@goodkind.io>
In-Reply-To: <20261030010517.45639-1-alex@goodkind.io>
To: Alexander Goodkind <alex@goodkind.io>
Cc: nbd@nbd.name, lorenzo@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 tarick@bedeir.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 18:05:17 -0700 you wrote:
> __mtk_ppe_check_skb() clears entry->hash for flows bound to other
> hardware slots in the same software hash bucket. mtk_flow_offload_stats()
> then skips their hardware counter updates. L2 cleanup also frees sibling
> subflows without invalidating their hardware rules.
> 
> Restrict both cleanup paths to entries assigned to the inspected slot.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mediatek: preserve sibling PPE bindings
    https://git.kernel.org/netdev/net/c/34cc22a9ce6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


