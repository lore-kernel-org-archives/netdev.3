Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141C348445
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963221; cv=none; b=lD9k/EzSi8K8e8lrtrrZIWMm3Y4qkmS6pQ0WQzXVVeiUMdXUPg28vmGB3wrIFj1uZ7se8UI2CY+NPG6/FffIdhEifHtVeaupjo/BKeItCLotSjr3uecjAI6SelhIILKZdmftbxpFAJ0XwXHcbhJ5WNRNHAlEppqfbfGvh36DSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963221; c=relaxed/simple;
	bh=s/nOpcZ2dfdGq9bwCoY+9+xn0XWm9mgVfH0e3fAKI6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E99iIonHPFFOh3v4hqh4+E3S/1xYuxRDoledW+92mA/JfNQNLHLgoh3kI2HR+u43gnsJWnkL4EzRd80jTj5X2YDg3P4RADn3SlIVeQfJ0QkPpaCRESf6UGkZhXLrxyeEGErIzvJLuXONZP8AtyhwkBynuTjXWFadYuek4ZP92jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjpyyPwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjpyyPwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B76C16AAE;
	Wed, 21 Jan 2026 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963221;
	bh=s/nOpcZ2dfdGq9bwCoY+9+xn0XWm9mgVfH0e3fAKI6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sjpyyPwXJ5C3OsB0Q+IQ5lrCfiDjLn6zML6BGD044LzqEo8yT1IhN9j19ndpRQpua
	 TPO3Ve5jlRquHDjKBTAY/5JbxxJyLTNDXMZnaXlyFtavAm3/5wzRVZeFknC8+ZYKX4
	 KztnTE68KDs2PNqfHTtxkeMrs+uLU2NKCYTvovWu8txCcInNl5DTdfYbUovhCA/Hpo
	 o0OLRDLap6Sc/8kpxRIrhVjgcsPclDDA7wcjm943TEVRPZdDxQ9WTW/5zB/HRHSnRV
	 MwThDU/bt6afJcBF3s6CiEop/LtMKQMJTPq5jxvAKZrWAt5bOAS5mK0DoP50gytCDL
	 5E1TfjavyulFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EECA380820D;
	Wed, 21 Jan 2026 02:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix resume: calculate tso last_segment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896321885.699622.7276835234573904684.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:18 +0000
References: <E1vhq8O-00000005N5s-0Ke5@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vhq8O-00000005N5s-0Ke5@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, tao03.wang@horizon.auto,
 alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Jose.Abreu@synopsys.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 14:21:36 +0000 you wrote:
> Tao Wang reports that sometimes, after resume, stmmac can watchdog:
> NETDEV WATCHDOG: CPU: x: transmit queue x timed out xx ms
> 
> When this occurs, the DMA transmit descriptors contain:
> eth0: 221 [0x0000000876d10dd0]: 0x73660cbe 0x8 0x42 0xb04416a0
> eth0: 222 [0x0000000876d10de0]: 0x77731d40 0x8 0x16a0 0x90000000
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix resume: calculate tso last_segment
    https://git.kernel.org/netdev/net/c/5228e9faaed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


