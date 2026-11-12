Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505209;
	b=u+h5K5S8iZE8sqigFr5r9x5UWIRLWr/zW33Sw9jGkGYV9fXHuzU88iPZ7PVqWEVfRMHg
	 qXPTesl6PuBNeZ+i18V88ueLbesWMJ49/5LdIHUncFxBDLZqEluONtbz8yrJjxNYRO2pT
	 padyqMqvaP8wK4YbGqEq8sG+ETbfjTh8wugeLIcs9VvUQV77Tt8sHkdU3IhwK20rM0C5J
	 lFFjWYihN0uephg6O6dcgMLxxhE6TiyYqBcY4CFFn2sCR83l/JudPCk00ek081p7qlplK
	 VEWg8Izrjg+CZKnsFIDzFsDb0T9jIJrBKS8pBQuoFnCchN6CP3jxcZhj2D43k7iktAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=P5iVSfC4PebKGq7ThZH76L5c18owWugS+eX0tVrTM4M=;
	b=l1zPV0T0KXQPbj70U3iBvuc6vFKGdz0ATLM2884rW/UAsgQUNDEhQsfDeOwbqa0MAULc
	 xtCwy2PBTWRld9KND1Yph0jTdhNkFQ+G2kC1LZJ+I7ymnsVfC2DbRcKm+1idBUo0F9XWs
	 g2EAxMQ72naA1FZynTLVV5jRvo19+vl1KPpfRJBAYbSAQVEqu00QTCf+11zSbBzrkjn+y
	 fVHiarjzDZxnByIiTcq5D2BpT1wWinxuSCHt7FnJfu+UV3UbxV7JIaQrTSQevrORbgGlE
	 IyfP29Eb+CbLtAf3S8VAtBPgdnj8ODZd6lZ3it4EWp7w0bhDne5Vf6faIjII5E8c6OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVb1ofME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3528606A8B2
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVb1ofME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837981F000C4;
	Thu, 12 Nov 2026 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505209;
	bh=P5iVSfC4PebKGq7ThZH76L5c18owWugS+eX0tVrTM4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RVb1ofMEpb49KY5k3LAPGURGviC1jeHN7lTGe7CJI72SYt2bHwr379B+HnzcfCQyw
	 BewipxKFLO+JNMsaAd6ocGv7sniJI8pD5T2f0ys5ftSnKyfbAszY76Zs4Pgxcyzfwp
	 quLE18m6DttlllAc1PYMfk8KyB/EdfvmsnYlD5tNR2K0blRB9aLfZGEuUVUthL5R0C
	 db42/XS8NTZDICwaz0gJKN2bo7wsJ+UgrSKOHXajv59G758SMufmaejIXaPwn3YoOn
	 5NAO5NK22jBuZNL6aMp+yewn313w2qkmw0Ipyx6Zl0Dv47t8PdTcZ0Thcpj+lJktI3
	 VrPghiycMPoQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773D1380AA78;
	Thu, 12 Nov 2026 17:40:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/2] net: ixp4xx: fix OF node leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450520802.558080.7315802190681537713.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:40:08 +0000
References: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
In-Reply-To: <20261110070803.1099-1-zhaofeng2@cmss.chinamobile.com>
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linusw@kernel.org, kaloz@kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 15:08:00 +0800 you wrote:
> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
> 
> ixp4xx_eth and ixp4xx_hss resolve their NPE and queue phandles with
> of_parse_phandle_with_fixed_args(), which takes a reference on the
> resolved device node.  Neither driver ever drops that reference, so
> the NPE and queue manager device nodes are leaked on every probe
> (and on every -EPROBE_DEFER retry in the ixp4xx_eth case, as the MDIO
> check happens after the DT parsing).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: ethernet: ixp4xx: fix OF node leaks in ixp4xx_of_get_platdata()
    https://git.kernel.org/netdev/net-next/c/81d20448c14f
  - [net-next,2/2] net: ixp4xx_hss: fix OF node leaks in ixp4xx_hss_probe()
    https://git.kernel.org/netdev/net-next/c/37f53abe8ee6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


