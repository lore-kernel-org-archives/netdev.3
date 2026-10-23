Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789808;
	b=fAOpenLyuGqaXAI3ifFvirgBG/w7z36ZO4o0uZd+BxPypMTRhFgZEtH4EXP0SWsskSyt
	 gaDtZ68lDUP1br4dU0MB0KZmaVnurUK9+Z7MTxPhf8phFRW6GR86xw1QtjHLeIor6FQNa
	 Lanx73Ifd9qYyHZliUHE7vEhMI/Ng/JXUrUHFZizwrQk4peG3RwZuRM3M1DeSeOLFnWVZ
	 gPO96yLPwX+Iq4I4gJjFBdxkIjPzpm9OY4zQWJqieahCBciq9EWia3tWPL2Avaf5v+FMU
	 y+RXZ3skLRRxjNn+WRjVhjk5oszBfRAG6dnGwXRylNuMzQBknksGu7H3zQkWRFST/QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aNINpD0OqmqNIeIsXPCMxFESLxmzCmTKDHZXUaQzoLQ=;
	b=TJuJ7W6TvkBrRmWBeR7Cce5j540d3x8/l4zLP+wSziu8nmRFOkeSkuPCppzCcXx25ZJL
	 ra2Ewhngy9F22uIe1FM0GAAFx2kiII9kkXJgNQJ527uzfINxoD/VMH9BR6N3rKoU9RbbT
	 TuN8tuFweja6dwjOwnaXkLEIOK1bnZxufu8z5vCTjEzQTQV7EXJocMqiqdsj2AKnlCDXM
	 tFr9p8HNK0lJQONvzi6ma1Ha6vIH6Kofo/tTyNV8mQpOaRwpJAncFEPWZNyQFH8I1cGOn
	 vgBJB8yJLfi87MwkR+k0Ng/DnyM3/PTzbuZp6AGFtO95JonnOFx2vP0KdK+ERXmtY4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXhLbcs+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F316606A328;
	Fri, 23 Oct 2026 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXhLbcs+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80101F01825;
	Fri, 23 Oct 2026 21:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789807;
	bh=aNINpD0OqmqNIeIsXPCMxFESLxmzCmTKDHZXUaQzoLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gXhLbcs+2GvBbodeWXnIW1pHMKWi4m5LdZZuN/0istfhdEOzdKs8rWUr2AvJOsLJj
	 98m6a3Bw/omDsOuC//vDA4p2sO6Oa8Vphj72M5z3cty0DxMpXXNoSFQMb/V6if6B0O
	 c1GPh+UjvulHJmeOsKJUBpcGFAzfenKjvjvrXzy+AYtTV70FzAR9OTJn1xypnjusii
	 mKwVE+yuP157bK9MEf6YINU9FQxnpeQdi8mp5wFtNbjIIgIzH5BMl7kmBT8GJnayHr
	 tVAwsbtIpE9N4DKfKkb6TEBY8HtNobRxp1CzVPUvYcVnvVpMaVp+xqbFuA2NVGzQH8
	 B2qP5LKQ97r+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE56F391B157;
	Fri, 23 Oct 2026 21:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: sparx5: fix tx DCB index drift in fdma xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278980631.1272863.10742886644709270848.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:10:06 +0000
References: <20261021-sparx5-fdma-last-dcb-v2-1-7b8fabdb9239@microchip.com>
In-Reply-To: <20261021-sparx5-fdma-last-dcb-v2-1-7b8fabdb9239@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, jensemil.schulzostergaard@microchip.com,
 horatiu.vultur@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 16:04:59 +0200 you wrote:
> sparx5_fdma_xmit() advances dcb_index before checking that the FDMA is
> done with the DCB, and does not undo the advance when the check fails.
> Before commit f4aa7e361ae2 ("net: sparx5: use FDMA library for adding
> DCB's in the tx path") the next DCB was always the one after last_dcb.
> Since then dcb_index drifts one DCB further away from last_dcb on every
> failed transmit.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sparx5: fix tx DCB index drift in fdma xmit
    https://git.kernel.org/netdev/net/c/1df26063ab9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


