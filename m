Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5247A40D56F
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742061; cv=none; b=TNGrAKjMbVWFW89ze5ESFMSBUn5BY9uKl+EiGbrA2AdqjEFTKOK44w/8VdiXGX+B/fIf0R3uTDbvZvF9PctCHAQNzB5knxtwOLELZlvnLCTNgLXxZXHW4AAGRsNLclWUbcqVO1ywe554HftbRWkrSLcAfmPk0UPCfQSTeOkS0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742061; c=relaxed/simple;
	bh=8eWueccu3LOtZoris0rEasgWqyxVv8cPWbRFhVeU4rQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aVrjM4oZf9f3cSog2Sr9+XOxuAhi1e5HvFCUQd9r3EfDDk+8RStjOqOJYDvyHfPu0KVScs4GtX8rrIqrAmcKhI5K0zRm3+lZC6ySfaPmUySYzX3UtALHnO31T6WYl8c0bXW9tZWCOolEVQpO0OnsFH7M0E9hgEqPz0EqAisJ6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmLNKJkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmLNKJkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B2B1F00A3D;
	Thu, 18 Jun 2026 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742060;
	bh=Y36d3c9E+J3nQ2hIY9KPFdRkxun7FQwJj96D5/KofuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cmLNKJkAWEYPv96ZZeS67kU8bzAykkPraRXUF75VxaWxt3LRWDvB/PItFZhrPlXA/
	 mxvtwaSFKqwRVE2tBITV32GyjCjGF/BPwG6Afl41H4Sg2VWICxUGhI3t0JuASi6cq6
	 iS+8BV16YbvzuYIV79+6SJK/r6M/nIRHIX/q/MLUdmai9xaT6dPWrDZA47YrjsRoqa
	 EUJXiprKLkao6INhU/v+YhfhRghMnS3dTpNVjhadkd13RL5E4oQly8U7zXGzZHw48c
	 PLNmZMgGNd5XV5zUlhZtX6aRjBFmIlrcgPW4mCnfe4mSJ/DxQOcYbq+BAyJy416TTz
	 mkO24dQIPnejg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197EE393102B;
	Thu, 18 Jun 2026 00:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: psample: fix info leak in PSAMPLE_ATTR_DATA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205363.1875263.12586731210463427377.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:53 +0000
References: <20260616003046.1099490-1-kuba@kernel.org>
In-Reply-To: <20260616003046.1099490-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bestswngs@gmail.com, yotam.gi@gmail.com, jhs@mojatatu.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 17:30:46 -0700 you wrote:
> psample open codes nla_put() presumably to avoid wiping
> the data with 0s just to override it with packet data.
> This open coding is missing clearing the pad, however,
> each netlink attr is padded to 4B and data_len may
> not be divisible by 4B.
> 
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: psample: fix info leak in PSAMPLE_ATTR_DATA
    https://git.kernel.org/netdev/net/c/aedd02af1f8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


