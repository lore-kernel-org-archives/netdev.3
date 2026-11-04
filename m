Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827817;
	b=lVotiXSMeSbhCLH5I/MHWpt2MedlJuoLOErTujv+aWND4CR+x4XfazK7HQ5wpFKgZ1Uv
	 XvYxRmMIzkz8il81w6hbN/v/5zLvTmscePyLZKtZPVSVOnqQxW/LOjHLEnmBv4gvX8E51
	 pCVTiWwEd1eeAdNwJs8DrblGuloicZGbyCgSiXISG5Og7W5FW+CUM0t9yxXB6hmhbEM/l
	 BuDTD+5IzmbVJ/l/360vCiS0w9drR0xptNipdk5NjxnP3dl1OeYIfmVoo1wZM0o6MS2tt
	 iZBiBz7pKAvGZ09v58vgqr/KrUV2asdfI/q/JdM9emytmoalJrog1Q/SkiTnMWBhN/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827817;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xS8E5Xjbml3R5zZBxPCvPqXCNF7w1EP6L2oody/G3yg=;
	b=apiM7YNsnvsVx5uD1SxCk3tt12f+aXp0XX5Hdz8nP8WN87KMSghYN71uDEi68hDzs1SW
	 qrgP/RiAS1bpOuDp4i9CEzz3hlTqBqoXcpeLABwU0mm320KYJ/BU7u5JM7fbxQgGkM8yj
	 Pthi+V2FYebkgIDaxYaVtMVUMBjRxEWeXJuHCQydvV7dZKjGjmW8Wf14RU9CJTU3jKrqR
	 JFUk6W97phgxnPI9q5TJGBdSr7ODdey+lZCWZrcuBu2FYaBGXVW/gdvlgbDTL+qK8IKg6
	 2j8m4XTr7D2tixx+p3RKCuDmZju4Fbb8uio4BHLpCkcyOlylmnN6hPHZoa89aWn+0GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezSKGxoX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF736606C92C;
	Wed,  4 Nov 2026 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezSKGxoX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4962C1F000C1;
	Wed,  4 Nov 2026 21:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827816;
	bh=xS8E5Xjbml3R5zZBxPCvPqXCNF7w1EP6L2oody/G3yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ezSKGxoX8mJh1PQJY1WVorcLp/yVHuGqHB2b2Fe4rTtXzNrqhcv2BJT3BxWN5Tjml
	 KA22jmRBKJN9Sp0UqxS8RHOw1OruzjEDtWDZ6PqkwQBp0MyiGeJldqS9ANypwIFuTf
	 uKxFpyy8/FcGPa4z5Fjg2ng/+ub0FlDMZh2pM6i4IzTimdPoyAj6FMTuR4rbbzt3kz
	 5eNZKdXwXJ/j6HXThSO6ZZWXQeL1zGDE/0pdgppae8VxJyvPnfKHtwOekHfeDiYF3j
	 G5taiErNUZAZDVKH9VOAuUZ/yGe+S6+PmbxAIQsblNv4btrgNDOPCL3diXspBkvrJE
	 dOo7EOgTqTH4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4017438003C5;
	Wed,  4 Nov 2026 21:30:16 +0000 (UTC)
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
Subject: Re: [PATCH net v4 0/2] Fix TCP retransmissions on NS/NSP SoCs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179382781479.3232389.1538844230446462425.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 21:30:14 +0000
References: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
In-Reply-To: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 jon.mason@broadcom.com, arnd@arndb.de, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 14:15:38 -0700 you wrote:
> On Northstar and Northstar Plus SoCs we would see about 1000 TCP
> retransmissions per second due to a rate mismatch between bgmac and b53,
> make sure that we run at the same speed on both side to avoid dropping
> packets on the floor.
> 
> This issue was found during testing on a Northstar Plus reference board
> (BCM958625HR) while running iperf3 to a test machine and noticing
> retranmsisions:
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
    https://git.kernel.org/netdev/net/c/d4f3d2c04624
  - [net,v4,2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps mode
    https://git.kernel.org/netdev/net/c/41af38324341

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


