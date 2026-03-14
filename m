Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7622772D
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510614; cv=none; b=soR5a/pMeBQ0h3qonAHTCh6iTNd4Sz7PaHvIu4EHrXeXmhZtlhZs8EPerFlVqoZ9DqTaU2X61sxOuTpEej5FJ6vExmCluXUovSGs0ttrEJSnecamYdN6UvWtOaGYAgEUmwVy76cG26CjaRHuNpDj+GviyXPU/esYr48EpOqSonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510614; c=relaxed/simple;
	bh=VvM1N7p/gg/k3rQT81Lj15EUTG2c3hW9E9sZmPrhX+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WnSlVdpJcpszvaoWr33ULDoFBF+htPdLjJHG0GFz8n7RuqnuzICJpKWrLRug4sDmb85+jvWkntr/4mFHD4s7dS/PdxRpSbbUhqCtNpSYdAOZw+URGIacI9hWoF6zwdfy2HHq909WA3ikureztR5Q47F0tN3muSGIw+IeJP+/5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CX66UVYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CX66UVYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8417C116C6;
	Sat, 14 Mar 2026 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510614;
	bh=VvM1N7p/gg/k3rQT81Lj15EUTG2c3hW9E9sZmPrhX+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CX66UVYmVPbMnZCN5aP2pUIWo4FzZFBoRiFGQEnEa0W2AOAHmwdYhZz4Gw7eukyDr
	 u4b5gRuPK1R+RyTrLlhCtrM83pcOkiy7AS5yfRUIDOwRbL/h/lZnrKAQNARRrTCEJT
	 bq13svKqXTK4ixnwgcZhhjuLJPD58pqOv6OGz3AoxAWZ9+czbbiZz5ZlYnbX47fyRT
	 MtnjtIDtUV7KwR/C7JmpqA0FJujh55ZgdHThqzDVqXEqAZLza62NDH1mB0ptowGvdD
	 YjJXfGU+GrrSaXSCVS/j6rkm8NHnYlIgStXZbaF8YmSNonZw4FEJAtX1X8q/fQ5p48
	 mSxZVdzZrkjrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0305B3808200;
	Sat, 14 Mar 2026 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: remove selecting FIXED_PHY for
 FWNODE_MDIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351060853.1744213.6491766287326837790.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 17:50:08 +0000
References: <880ca62b-a5d3-4865-bbce-2d2210928239@gmail.com>
In-Reply-To: <880ca62b-a5d3-4865-bbce-2d2210928239@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 21:54:46 +0100 you wrote:
> Fwnode MDIO has never used the fixed PHY code, therefore don't select
> symbol FIXED_PHY.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/mdio/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: mdio: remove selecting FIXED_PHY for FWNODE_MDIO
    https://git.kernel.org/netdev/net-next/c/b87249aab4c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


