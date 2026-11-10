Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354012;
	b=fsP3qDHWD2obvNR5VKxY8O/gOoRBCOiEuh9B2QHfXzNDS0+3YjcfqxYHU/jUSExpznSJ
	 umQ6+vVEuLZOq35q1K3FLafxg4ioX7E+KEgBTr7IoLlS4i6wThJIdiitJZimPVU9a1rpI
	 OKVOSf596HiLoJay0NseSHxIuHzju0VSVSQwONTItiogLqsYUZOK7g7O9j/5peUqlClz4
	 fckyepl8dXAc5ZV8FWLfIS6cqNfyN0Tei1hPzfQVULQOUSxKDGA/MLyMMWmcUwmaFHTln
	 tUGqAnlXel6iDjjNQvnX/cpsnLUk+FNYGJn9zFHD86qBfT/tKAnSzYxqsseBiE5FNFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354012;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ASeU1P5UZIXh0NhLOvAQsAciKUFenpAunhPSUfy5KoM=;
	b=gYfQ+3gNte085rPcEvVvK8CbFMpRdoFk2jJL8m1QJreB2EUuIMaVBjSRGVwPBWcUzRCs
	 RCdsqClgdZvKmr/m8kqIF6ymibPzHATa9Lf5LGYUkoLlghQmJ4M5kZ2FIEdEOmawXvDxy
	 0q99wDN+oer3ThunOzDSxI/WsgKJneBBnXsoG4VbbMNa35eDZ+MTJj2vp/l516+JHQR4x
	 HhwVyigX+DlilYQSdAjl2kC0G7Sig3HGivn/ZmTuTZSgmtOhheub9KtW8x/iybW0vDFzG
	 6QwhYcjDLVbwjhC0/cEP8x7fhTSNXeTWtI7sNdL9G7hadKxgf9Qogc3Zn4ektynPZXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1TePK1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B0606A326;
	Tue, 10 Nov 2026 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1TePK1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB021F0093E;
	Tue, 10 Nov 2026 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354012;
	bh=ASeU1P5UZIXh0NhLOvAQsAciKUFenpAunhPSUfy5KoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j1TePK1cs4ciKMDSiPa22k2JvKQIz3WnEbQD6GwtjrcRfHR8ZecmB255rKjuuarM7
	 Rg9Rr6XWvzEl0h8z7g94yaBkvsjCQ1OSCoHGHrUmOfVtYabX0Avu+UYJhQhCfK3HX4
	 vVOtJ9rJtBhkfw40fRa7j8lvz/AZhzDXgcMZUoMXMKk7yqn44porBXp2bOz/giinEl
	 qddxWw6C+t+mMcc1W9xyI9te0hA+c9gtCrwAHV3Mq7NrjS2W7qr681pQCag3tV4A5c
	 6oS/0bMiZ5b09NGNEDtz5OIscecU7Mh3qXtsEWzNhlma7/t8ONBynXujr7cnLlQzNJ
	 yezOxQe8chEOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D817739E8A41;
	Tue, 10 Nov 2026 23:40:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next] MAINTAINERS: Add myself as maintainer of the
 lan966x driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435401042.117523.18097212172531978662.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:40:10 +0000
References: <20261106-lan966x-maintainers-v1-1-476bfb921aca@microchip.com>
In-Reply-To: <20261106-lan966x-maintainers-v1-1-476bfb921aca@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Nov 2026 13:21:22 +0100 you wrote:
> Horatiu is busy with PHY work and will not maintain the lan966x
> driver for a while. Until then I will look after it, so add
> myself as a maintainer to have lan966x patches routed to me as well.
> 
> Acked-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add myself as maintainer of the lan966x driver
    https://git.kernel.org/netdev/net/c/8692b91711eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


