Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529409;
	b=vDUol0bXVA7FRKu+Fq7QOIa4rrtBC+tcjFmUKAxMYX5FTwDTmF2iYmddPknTVKrauZwn
	 SmAyRA0r13A1O+tctFLRzZ6SbSuh+8uvV/fEZWI0hmyLhAdbepmw+Mc01H03LMdASxcZe
	 HQ/w18ItZw7xZMpzcVsf9BxY5Is3tVc71vGNwnm0n+0wDhLIBYzr6Xa66dV/f7Q2V/rXg
	 4EZfCV3XYCCrKBepfJyeHX9UX6+0WCbjpFGvjqe3rxR05IJsF4a/GT77qh0yLGU+PJ9YW
	 QxFLr+0BcrAca0d7/P74d/6f3VwJ+781UsUkg18105/im7dtuLYNg0Qs14YZ5Gc59qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529409;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UQAaHgmlQKDGLtXEfAY2vP+sucWYdmNtFS1d5EJPeGc=;
	b=q2ZMsTN9r/PlyfYc3iHcNfu8UGGUnHuhGT1pNH8SQjGHAYrvqhnN2cV5hAt6ubgELc8H
	 ToAwWimcnNHaHCJrD7ZlzkxvcZfGaC3B9JEBzuUKE7VAK8XR+W7byd80szamqyUpRJc2L
	 KN549CYwemwodYII65v2gz6Auc4qXgRJd6oN/Q9mPmdwYwoxM/vS4//qG58ceh+HJIO2s
	 eiQwnXr+3a78yGjpiRCwFdvGkolwP3SIAEGnM90dnwtGIHHd13k862nTAIz6c6/MmvqY3
	 7mtd5hngjKZ/Cq2tWZF2DlH7nMVF2o+NQ1TOLgzqedPvU6L6EZkf+dteLMedblZnjkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMHv9988;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E0606A326;
	Tue, 20 Oct 2026 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lMHv9988
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D121F000C9;
	Tue, 20 Oct 2026 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529408;
	bh=UQAaHgmlQKDGLtXEfAY2vP+sucWYdmNtFS1d5EJPeGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lMHv9988OSw2Qf+jK72hfM+vT4RWfedhlGVr3DF3Qf+AgaVYB8GqYUmk2VmWZSGAt
	 fVLMIxSADHPxcIxNqHJCYDs6mG9jfnMOsCPQQfAqVbHCGkX5i8lPFh5h8naCuHh+Cb
	 mO1FC6lE2R0nlZzI5YWZ2+HCqxdUiKWTl5APQiJTZuoFsYqdmqAiAQ7/cgnYnzBAOL
	 mO8clKUA62qvqMATwLOjyFeezb4Qf0Ahf9vNnh7EcxMUZKutXlgVj6VPod3lotxsCT
	 Ohcbn63c8567IwCpq6rIvpbujWvIyASF6PXBgMemmmNKRtVdPJcAEbJt1FHeQQ6052
	 K262PCg9WIR3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774423809A09;
	Tue, 20 Oct 2026 20:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net v5] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252940703.202014.9168036604597546075.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:50:07 +0000
References: <20261014194818.11640-2-rosenp@gmail.com>
In-Reply-To: <20261014194818.11640-2-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, michael@stapelberg.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 12:48:18 -0700 you wrote:
> marvell_config_intr() rewrites the whole interrupt enable register, so
> the config_intr call from phy_init_hw() on resume silently cleared
> WOL_EIE on the 88E1318S and 88E1510: m88e1318_get_wol() still reported
> WAKE_MAGIC, but a matched magic packet was no longer routed to INTn and
> the board did not wake.
> 
> Bit 7 of that register is WOL_EIE only on these two PHYs; on others,
> such as the 88E1111, it enables a FIFO error interrupt. So give the
> 88E1318S and 88E1510 their own config_intr and handle_interrupt, and
> leave the shared callbacks unchanged.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
    https://git.kernel.org/netdev/net/c/f434191f9388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


