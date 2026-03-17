Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3B3E1205
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757212; cv=none; b=f5ZXh/GRenwNNt/q0TiXm88MViYjwLi0meIQI4xxoo3NkgXSfU5ipT+np1DUXCqfyTcpx5HMA6O/qBdjiQRmrokHDiVc3HhyGEYaCZ6knqVf7gA6kcvUoMWvq/rBO66qyoBTq5mtKVOOFOIkyjO/uOwGCQBrLfPYyhRbtK3R7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757212; c=relaxed/simple;
	bh=D2Aan5I7KojlHJH7qZQt//XX4gVyE0icMzOg2NEGLaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pEYvDYpXk69VKmjAQXif3qn++Maa6BAX7bTzbf4hyBjuSgn4yCgZSwlYhO/lXf1llsFHdePhV8jhyCMzMlPkHteV/1JLuOyphDlW2ubdBfOuKiPbMcleRojyy89m/zEo9uoY5t5okpgVml1vEuCrf3otNL0LO5fl2zSNf8OrGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWL+w+xJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWL+w+xJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDE7C4CEF7;
	Tue, 17 Mar 2026 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773757212;
	bh=D2Aan5I7KojlHJH7qZQt//XX4gVyE0icMzOg2NEGLaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gWL+w+xJlXiWCmAVanWn/LV8gq2BaExdXjjrGDliYxfj7NmvIr7uxUC0P9Y/1nXnV
	 /+TDR7m/onBPIaQt+hmUUw8XogTkiCbq5kzSCiLK/HWHOS1FJbtvGwn5sAD/OkfDXH
	 qfQt+EC1ydBEG0I+qvscm/khmZzg46jmmcl95XgULH7ATypgh9Ak+Wa5bF8b23Ti8T
	 mOxxzDkIZoO+r2nOtfef3yPvsofVvDDolYXuCkbgEU8bz0EAHyhLWViuriYYD+Kxux
	 FVDDcUjUwaVs2TF9Y/4lcAQha9nDOvg6WF6cutFQezqI17FFMy6XR6bybSC0FX9JEs
	 dahZz2PWC2TRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0483808200;
	Tue, 17 Mar 2026 14:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: select QDMA block according
 LAN/WAN configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177375720454.3643902.13747371433230269339.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 14:20:04 +0000
References: <20260313-airoha-qdma-lan-wan-mode-v2-1-7d577db6e40c@kernel.org>
In-Reply-To: <20260313-airoha-qdma-lan-wan-mode-v2-1-7d577db6e40c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Mar 2026 17:28:36 +0100 you wrote:
> Before this patch even GDM ports were assigned to QDMA0 while odd GDM
> ports were using QDMA1, so, based on the DTS configuration, both QDMA0
> and QDMA1 can theoretically receive traffic destinated to the host cpu
> from LAN or WAN GDM ports.
> Airoha folks reported the hw design assumes the LAN traffic destinated
> to the host cpu is be forwarded to QDMA0 while traffic received on WAN
> GDM port is managed by QDMA1. For this reason, select QDMA block according
> to the GDM port LAN or WAN configuration:
> - QDMA0 is used for GDM LAN devices
> - QDMA1 is used for GDM WAN device
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: select QDMA block according LAN/WAN configuration
    https://git.kernel.org/netdev/net-next/c/8737d7194d6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


