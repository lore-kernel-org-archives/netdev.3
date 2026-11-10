Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279288;
	b=h6XD5jth2R2STagdU+D6p0QUkDsFLMaTrcI7fbaXJ1k3H6f0/GZxKCWqgY7ln4+ypj/R
	 CvdZDvuDJebWf6qVFTFRMJ8mtftr3bbk4R9jPCH7/MV1ABiRGBW2BbqkhOvtUk+BTnwCh
	 3viZfj4SBIG8kpOdJJnFj/c+wz6bowFaUypR65TVm2t4USUk+ugGD8Cp6/WOy9KHPCgv2
	 OTa7BHG7Jeb6O6lZKLewLpb6toijbiudvFzqcNDT6ClFCBgfSqW3HJsF40sWDhCVx0VIH
	 EUytLi80WfVrjDF9YUek1oz8ix9XIffh//kiLP4tLNjuzLP7oURvAk3SMWA4dNMINMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279288;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8yxDfyv18qDvNg1W6pwArXTK5hmwdgTQr84WXyNyi6o=;
	b=Jfp6ew4ycPTGSL3mYfVTw0vLxA1zzdNtuCtRrcjJpu21iISFRdfI9lMbt7IU+yMnm1AX
	 T8DLNG6Pn7HVoa6JEHCO49NyP+Yy3NtePZB1hmYZlaj8rHj7dLYDHP4JAB4qq6S+unGwO
	 rNiu4DToakr2PlQ9gxrPJldM/1mI6VP85o6g/CxZ2z6MaBGFBSChVPcGJofQwW9xChhFF
	 r5NrmifrOXlrtXjKdvTjyygf1FOuqq/j5Wpvz8N3XCiLmrpiwODkX+8FByqKtGTDHf7jN
	 u3p4ZmeigBLjk1jFyDZy/XP6ZMiMQE9SEIrVTgZjMoLGvzN9BnY8DjNDRyNAhRlJlBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2DOo5hY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2F60A3801;
	Tue, 10 Nov 2026 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2DOo5hY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBD51F008AB;
	Tue, 10 Nov 2026 02:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279288;
	bh=8yxDfyv18qDvNg1W6pwArXTK5hmwdgTQr84WXyNyi6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K2DOo5hY+O1lPtmaIIvnHCO3v5Evbxi1n+jX2+8XWLuJ2rLaoYsqSzSxndyBYxZdF
	 jY62uoymR6hL4Iw6BZdrNqbK85TBQIg/KOYztQUjSsTatZTS3ZjpSdG8d/3LbsgARU
	 7Y0PGas8JFvSbbcMzLoS8Gt62DVkYcPKFOYxRA8Un9q8vAUlhAXHtpOCinqF4mXLW1
	 o3buZGhRmEdtgGiH+oWCw/hfkdGaq2W2dDJbiXksfm1ncbrMfldksWEhJmmZni3l8S
	 xuJc2sJE6Pf3xIyitSUCS7NoMcaf5n68QznmAU3V91enfx45/lNeuc7dPc6a0mNpmA
	 CFMUwSbbd78AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 21110391AFCB;
	Tue, 10 Nov 2026 02:54:48 +0000 (UTC)
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
Subject: Re: [PATCH] [v2] net: octeontx2: fix building without DEBUGFS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928667.3612825.16491551761620638970.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:46 +0000
References: <20261105161945.1658464-1-arnd@kernel.org>
In-Reply-To: <20261105161945.1658464-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de,
 sumang@marvell.com, hkelam@marvell.com, nshettyj@marvell.com,
 kirankumark@marvell.com, michael.bommarito@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 17:19:13 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This error came up on my randconfig tests this week:
> 
> drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c: In function 'npc_cn20k_debugfs_init':
> drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:392:55: error: 'struct rvu' has no member named 'rvu_dbg'; did you mean 'rvu_dl'?
>   392 |         debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,
> 
> [...]

Here is the summary with links:
  - [v2] net: octeontx2: fix building without DEBUGFS
    https://git.kernel.org/netdev/net/c/2007f7e37142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


