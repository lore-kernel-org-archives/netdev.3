Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140207;
	b=29VkV8Hu5wRnk+Vf3J3Y4j9laNZV8jqGNQ7WJvoVq51NUJuF3qHFHOmwq0NIpESAqvo0
	 s1xOK0jdXvgp65turkV4vLtfKU+2RvG4VBdb4P+/DsdzFCeDdWBKNJhkazpYyLai7h6z9
	 JRZcgvdbEW/nIS7FjculQ+dwbtxZhLLthxlbQ7jE0jVAIMPeBES3lylsT28GMIug0uAh0
	 sRxRZxh5Uqc5FDjjElZqQmgxhbtre2u1yPwSJzBemKgIRe55NeWTBZ5dJ6kYilVPlG13P
	 t+6h7f3OAGig8/sc4ryi2Fp4HQOqYQavPbVolhWidxxgyZYzhzpMUNZyn52HMcF861Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xuq66sDnBhsAplEkzYm7QcixWPor8L5zRdirUDF98Vs=;
	b=OBe8pbelmCuzZG8PSYQ7+yfR5iqYDOvZVLGkr3W6Qnn8xhi7tTuqg5I2B3h9Ytg/CED6
	 zQELUwq6pI0NOW/RkTBfNu+YozKzunNL8RghwScJ3NrpmQKRJFBFl1ELfd3zszSgCwcl9
	 0HAojI0xdpNJiB7IE01D1qfsGTm4xYJqkmFPMVGcN6QxvHvIhz+/WSZe8AQGNv3SJqmhM
	 SZyC3cnmdesINxnH2aNWkQOkRrvvoYDLsg+yrTWY9M9oD4BX5iwFym3QeYzakf88Px7iC
	 lsAM/J06wxEbtXwJOMrcJH4nuDfvcSy4o3ru2k/dvn3o9TFfB6r10ixjZ6NmAXz5Ssg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2xcgAJs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A095606A31E;
	Tue, 27 Oct 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2xcgAJs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F321F01829;
	Tue, 27 Oct 2026 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140207;
	bh=xuq66sDnBhsAplEkzYm7QcixWPor8L5zRdirUDF98Vs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N2xcgAJsVvjA2GHoiyQcvdzZae2VtjCmB4UvxqHSPhnRgRBOwbvmrlS8vSBjyimZN
	 K7ObJX/nInju5WgC+Ku08Ga/uyeu5S4ODHA5/PWHUrfU/tb5TECyrzIC6GTPiv2Nx0
	 0tnRq4OXP0DP2V2ULVsqAinECK5qDmannYVKExh8nFCI9OsvKOS260KSt4pUIAZvMH
	 kP0dsojOAXad0PIdPBtwa6oif4UdvTnq52MtwFxvxmnslByR4qEFo/s1w2K4BcFffk
	 Q/+cziWsGEY9LAPRYrpgD+meGk5FbFF6QabkkTsc5VajyhrUkOsxHBGpQeN/zCfX7A
	 uqC7yFlb7UVGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DC5943AA940C;
	Tue, 27 Oct 2026 22:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: microchip: fdma: fix DCB corruption under
 sustained load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314020569.360855.3209955034452568131.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 22:30:05 +0000
References: 
 <20261026-microchip-fdma-dcb-corruption-v1-1-36dab6caca07@microchip.com>
In-Reply-To: 
 <20261026-microchip-fdma-dcb-corruption-v1-1-36dab6caca07@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 jensemil.schulzostergaard@microchip.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 14:47:05 +0100 you wrote:
> __fdma_dcb_add() prepares a DCB and links it into a channel's chain by
> writing its address to the NEXT_PTR of the current last DCB. The FDMA
> may be processing the chain while this happens.
> 
> Before this patch, the link is written before the new DCB's own nextptr
> and info fields, so the FDMA can follow it to a DCB that hasn't been fully
> prepared yet. Under sustained load this stalls the FDMA.
> 
> [...]

Here is the summary with links:
  - [net] net: microchip: fdma: fix DCB corruption under sustained load
    https://git.kernel.org/netdev/net/c/573a6d4c7a21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


