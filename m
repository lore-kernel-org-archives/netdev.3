Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508208;
	b=crAkxAmIlkhlHHNI6q0HbUevsjXqpBxJ1B4BNy2XAkJ2PndqzqUuEKoglIJJD9Ritu40
	 /LE7IZQnoEbQg8ssSkndsO9jmYv4c/tX8SQ4PagOWSASjvDzj0vjGnVcyH3M+nGepWtSX
	 jswhrnG1K5ftiQOVXDf7h7+UoHgBOrhdWkn/G55JHngnpxZpV547GSeVDfjM5BKwNiBSY
	 SdP4xRICxKSZPq9TWM+F83u2SEIluZTMEbkrQnnsG5swQN1kFAP5HNcAWZTAgLNRljxLL
	 ODJpiwgWueG9JCzriSk1p6xCiD8G9hSGCh7w6F9o2QJW5v+e/faA81nKhQ67rhZYF4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+52UGbBilkl4hGyrUrFA0fSvaAA64MpqwEqJs05gnNA=;
	b=B2eOX7WQVCtefY/2h2CvQR9cH7z5aKfrF5xYvqPmeuU8ATgOMlea9Lfv5eTn49lpvMjl
	 nVJBsTxGTM0aRVf20jzw49LTBTsK/Iq6q2bI9XWRctJOikBD1QYdwCZGUZP+Zu5/4PNCz
	 dhTyvdRFXDpvfoxKjWE8i1H9pyh/Qm2swNSwzr0uL+xrXDUGxLuF86ty99oQMiy3hbkZq
	 XlgTbl+VMjDApXk116ypIdqxgotSziZRtmDi/Qijn7LCN/sxCozS23UjcMR30yBAVS8sK
	 i5o8F00GrdI/MM95UOUANCrwPbJydOCSDOIT9y/FYxb09mzf1DpSvg2Qofdc70m1XKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz0heuvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1A606A885;
	Thu, 12 Nov 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz0heuvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03711F000CA;
	Thu, 12 Nov 2026 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508207;
	bh=+52UGbBilkl4hGyrUrFA0fSvaAA64MpqwEqJs05gnNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nz0heuvctAyaSfiiJvoHqgZqQ8vTXglysA79k+he2ohOLzsolSr6kchIiCHDRLHrb
	 TyrXK+GrFfqw0mpDhQ9vsIa+I2pExs4/nIhKCJGb9s65r36BX5AhYuwusuqUCmotlI
	 /TYBAdrslIIuoRacE1M8iSBZV+O/F9XHM4cX42YrVJD4SDQxY9Atg0H8/wEk5HUApi
	 F8t+ggY04wLx++OEzE2TTeBfmViMTob26jEF/O5LtcYiH/pxvq3RoyNCbwmxPDsDnn
	 6bYLw2YtWs88/LX+qTLEKclwWpD1D/beoJ0YZ7IYhnmoqAYAKKN8jm6nLy9TjFF8rr
	 R8TAM9/F3JTZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4454380AAFF;
	Thu, 12 Nov 2026 18:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net] udp_tunnel: don't treat IPv4 sockets bound to an
 address
 as wildcard
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450820653.579048.1771964318277156966.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:30:06 +0000
References: <20261110113306.3698438-1-antonio@mandelbit.com>
In-Reply-To: <20261110113306.3698438-1-antonio@mandelbit.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kuniyu@google.com, razor@blackwall.org, alice.kernel@fastmail.im,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 12:33:06 +0100 you wrote:
> With IPv6 enabled, sk_saddr_any() checks sk_v6_rcv_saddr also for
> AF_INET sockets, where it is always zero. An IPv4 tunnel socket bound to
> a specific address (e.g. fou or geneve with "local") ends up in the GRO
> lookup fast path, although another socket may bind the same port on a
> different address: GRO then hands that socket's packets to the tunnel's
> gro_receive.
> 
> [...]

Here is the summary with links:
  - [net] udp_tunnel: don't treat IPv4 sockets bound to an address as wildcard
    https://git.kernel.org/netdev/net/c/612b8376e811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


