Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E0303C97;
	Sat, 14 Mar 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516614; cv=none; b=owlruiUoWaRvfowRWCxxvApgN0UJG3LJw5hus7kONil2OhtnFuJlSvDiMV7NbalIM8MZUdin73yWLHmPlOYYDk+elBCgwqxg+TteIPjXN/dJE4bh3v3+mzR3QgG5/ASl/aW6nedvkv1SxzpdPOR3XnXfJstCxEFJ8/4+m3v/v90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516614; c=relaxed/simple;
	bh=zmDFLImBATrlY5PX+2lUXOVkdP0lQVU0kz9DlM4p4Qk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VM92lByFQn40IHg43mX8GDQe6LEpRFBo9qdK3DuWI2sSaEln1GRd3GwTeZlebCVIORQohylJ4GqBnDeLuMI80R0fYGiEkbIsy43FZD+IuObrTjYU7cIhhQiBtXQaBjvwNW1yxlh+YAUq5pLAOPAm/aC1vMtSYrwJfVNz01ZKjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHh/Kztx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHh/Kztx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFECC116C6;
	Sat, 14 Mar 2026 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773516613;
	bh=zmDFLImBATrlY5PX+2lUXOVkdP0lQVU0kz9DlM4p4Qk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aHh/KztxU7iwBEtOksUZoBj0wDg9oZiP6+sw12vXDujKYB3B548tTMxG5E+SqcPlw
	 mvKHgiqB2XnsfeL68MgLlkXiQCfmGJo2NZaQ2q3V+UkeZkzRsXK3ZjA0KL/li0OW6B
	 3IRiS1RuB/IsD6iqgJF5emWUNTqANUlk2KClybyQ0CrCuq3dTf9Ak6LR5025jlP/FZ
	 dXyt+gXy5pRTdzGFMjm9fjFJDBHxgW5K0ckiXl848VuMSetE70trjldecGP0NQth5r
	 RJbM8VTKF3OWS81HWQHoD+1rktC+UU8cgm+N4kzgpncIGdbIVzOLY1czU6og4BWK1H
	 NnlSqUUUI96GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DC33808200;
	Sat, 14 Mar 2026 19:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: macb: Fix Ethernet malfunction on AMD Versal
 board after suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351660779.1763199.11769087375422491221.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 19:30:07 +0000
References: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
In-Reply-To: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 quanyang.wang@windriver.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 16:13:57 +0800 you wrote:
> Hi,
> 
> On Versal boards, the tx/rx queue pointer registers are cleared after suspend,
> which causes Ethernet malfunction. This patch series addresses this issue by
> reinitializing the tx/rx queue pointer registers and the rx ring.
> 
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: Introduce gem_init_rx_ring()
    https://git.kernel.org/netdev/net/c/1a7124ecd655
  - [net,2/2] net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume
    https://git.kernel.org/netdev/net/c/718d0766ce4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


