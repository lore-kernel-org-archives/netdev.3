Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342606;
	b=aAxMcUVQsbqyCj0FFBWymzf76H3j+Z6WS6qzcLMgXL99xob1zUkLRoxFvE/VTwmRVCLO
	 PhS81Yv+3F4xPk+Q03KxA3hPGQ7DXgBTKZ/qNdNAHpQYZik8itdcKWsvXkktjfBLwQ/c0
	 ME5b0Fe7VXnYEMnBae26DlXjMo05755q9i5w3s7pq1ouMYWvlPYJApf4x2dM5wk85fCKH
	 NgLzpis6CKYLBtb6aVpBkEPBjhCxHEbRkfQmQUeXjFbFIoeIK+iyXEFIHZ5Hb5yjkgd5F
	 6zTgbx2cvQ1I/JUBhl/Xni+nfHHveG/+/V2JoQwCU6bQhlPlvGGzU8+q82n7xV6kFZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=DM5l0Pfmg26v1twgLSCXrEPpD+W/7qp0faXl0JQa9FI=;
	b=3vVBySeEJUlBh2UAgFJNHW4A9ffWwGUHy3vIELyoydGQ1UZnHDEouHqpflViUWc+7sop
	 ACfKQpaBqshnIlkU0ye/vYa9SpXQn3L+steu81St50sDci3KGZoR8TKuJtiyym4/CqjYB
	 q4CZq9DP3nVY1uii0iDneRTb0CgHvHtZa9UuGpAspGThb/QKjZsrdg5F+RTSjQfu5p2rF
	 F2lLuj/DyqbL9Ew9eOJU+VMOh3UI1+H1yLs2yLkkD8Nv7LTZaQVa1bk9OffsDLl1icbPp
	 fd0BcbQvJwueeRNSZO34Z/aJvxmKpj7n8hQvX9HttV6/2kyWLQ1CNavKOdT4roo/IIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D934ShSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFC606A898;
	Tue, 10 Nov 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D934ShSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D811F0089F;
	Tue, 10 Nov 2026 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342606;
	bh=DM5l0Pfmg26v1twgLSCXrEPpD+W/7qp0faXl0JQa9FI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D934ShSO+lyR7iZIfUw0lnk/ThUaqyU5sRBmb2Z4WuYW3F4KXdAS7Y0PZttHz1po7
	 6D2OlNlfJsTGU+8FbaDRwLDfwMJaHnMvcFDpLxPraOGEWd20BWRYtu33BOFj4YOziI
	 6oCrRyTGe0FR8HLIbBQ7v220CDHpvAZWS8LFsdOGiQg5oufi96S8xNiU+YkmC0WXKN
	 PnFl9/vUvesBVFdGeywTSrhqfUXhr8hGt/NM1+KvU+J+DM4IgYR7KrNhmMIc9hRdK1
	 YaPMduE+Zl1lMtJBxmqLU3Y4uUrBaCkRRZtIFcO+7QwiNDcRcg+7vp4EwM6grKjntQ
	 bT8sREwJawVdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D828C39D6573;
	Tue, 10 Nov 2026 20:30:05 +0000 (UTC)
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
Subject: Re: [PATCH v2] net: stmmac: release MDIO node if bus data allocation
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434260468.42011.3541882891013618336.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 20:30:04 +0000
References: <20261108110231.315004-1-vulab@iscas.ac.cn>
In-Reply-To: <20261108110231.315004-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: maxime.chevallier@bootlin.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, horms@kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 08 Nov 2026 11:02:31 +0000 you wrote:
> stmmac_mdio_setup() takes a reference on the MDIO device tree node and
> stores it in plat->mdio_node before allocating plat->mdio_bus_data. If
> that allocation fails, the function returns -ENOMEM and the caller
> jumps to error_put_phy, which only drops plat->phy_node, so the
> reference on the MDIO node is leaked.
> 
> Release the reference before returning, using an error label so that
> the cleanup stays in one place.
> 
> [...]

Here is the summary with links:
  - [v2] net: stmmac: release MDIO node if bus data allocation fails
    https://git.kernel.org/netdev/net-next/c/8959c2030f5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


