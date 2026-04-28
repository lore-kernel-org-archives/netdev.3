Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850B43C067;
	Tue, 28 Apr 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384849; cv=none; b=Cq/7XJGth8k2MqqQCXqXjVl/w3huDV2BXOVs0ZohSKitp7onhtSWrsuZ9RicegLVkUH5E+vxLuk8KIFA2EzD7imgO4TeC++7VjEZ2arKCGEaJso7ENvrahArrX7T6/y+3XbRoq+qVZopI8Op8kU0jgNbYQ29cvIGixl5UwdGT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384849; c=relaxed/simple;
	bh=NBziSZYoFZ+EdSB2M6EHEcyY7Cw7KRxUzRuq0FbasjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jfcD5R1HLgbzLWj9ZNyv/tUZ9P7RpY+fkCxJ5bk2S8ZbbxGsNfJsq5QM7Ds8MSY9mP/TVeUR0RdoOaZZFbM2RUn4Gnjx73AA9T6z7wsrPHHAIFuUdxmCogpQfinr/qGVl9IOaUC7Oj+GP/MBMAdm/hD80u7TPTbBQc+AuFJV8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8szO9cS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8szO9cS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F46CC2BCAF;
	Tue, 28 Apr 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777384849;
	bh=NBziSZYoFZ+EdSB2M6EHEcyY7Cw7KRxUzRuq0FbasjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8szO9cSeuruYB/0fjOohiKHDIP9Ni+07Ym84Mp6q9Wl81jaAty7JR2o0m6OxXkXE
	 VCLcS6mNIuQnOEeOOLW7GJjv9LMfeO9s97Qib4ms3gG6FLoA5IthErWHLzdOQxl7Jw
	 yH2iIp17kvcXVL1VxBK+COvQlFmlnUIGwQfhvrteHnLRH/tRBq9OO1OBrZa5ZvBkyX
	 ZTq9cvTmjtPZHHErFfqgseSjiD4vGVg74adAilrXMPgXtwrDR3Zk4+aIxt2qXbbuAq
	 MGA/OkeHaC9T4Q3d6hrHPgiAYYzweJubPOwCFc0WBb1YRTDJr4Do9rEYL5dJFTsFaI
	 ilyimWOcAELfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6CA1D393020A;
	Tue, 28 Apr 2026 14:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: phy: dp83869: fix setting CLK_O_SEL field.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177738480633.924994.11428544442154534477.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 14:00:06 +0000
References: <20260425031339.3318-1-hs@nabladev.com>
In-Reply-To: <20260425031339.3318-1-hs@nabladev.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Apr 2026 05:13:39 +0200 you wrote:
> Table 7-121 in datasheet says we have to set register 0xc6
> to value 0x10 before CLK_O_SEL can be modified. No more infos
> about this field found in datasheet. With this fix, setting
> of CLK_O_SEL field in IO_MUX_CFG register worked through dts
> property "ti,clk-output-sel" on a DP83869HMRGZR.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> 
> [...]

Here is the summary with links:
  - [v1] net: phy: dp83869: fix setting CLK_O_SEL field.
    https://git.kernel.org/netdev/net/c/46f74a3f7d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


