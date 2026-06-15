Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6079CD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563812; cv=none; b=WbLqcPzRXRAUQQAMEjuxe/yVPYkuQSTxUeyaRYYr8Som14o7BPpK6az2w/LzgbGGwLNhe933+EXvY4q/0MvcWHp4DxY0aSj7x0/4ktRPFtP3SxnTbTtLdKDGMtrGTB2Uwq+i25+rTGlNZb9EvnbOvGK/299VLywGVCcGUa1BnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563812; c=relaxed/simple;
	bh=9IfPHaM2qg9a1ZJo/KxopywVgwethcP2rKtKLON0IhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zefb/1ISdct6GtmZdy8eLee6dGwbnUDeV1QDxOXnrw2luv/wF6k1nfNnHxiZcx+cGCzIK9JeYABFhmRiblxC09ctouHjUnuM3y3Qk4DVLiSkjAFEoPOginGEnzV218aktIjOj7I3VxS0t2LUzn8yv1LOcabGvr+5vI53I2Z7Q3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/eSgO6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/eSgO6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18121F000E9;
	Mon, 15 Jun 2026 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563810;
	bh=+UuQVCAyUvse1CZNlmPDFh59OEsUZB+xGlZxHGND+n8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G/eSgO6vZTW3YbchjfabTrxKMJadLhtgPRAsobGJN8TnxIW2rMClT9+2+M/Tkm4+X
	 RiIV6X3pqHoJoK5yotO8qkx7cnS9Ur23r8FraMx3w/mviMytAN/2uVBzdkVuPUxNkc
	 ePFQpu84tp8hATKLJdM6RTpAeGoCNLhV3fMUicW+DffIIAyOj119ouhie1h06wq0k2
	 ZVx2XbXoNl0JurGU2OfW9VG32vJLFiMbQrVHdUf5uLD0mciXNobQfnqRYcdQi2op1k
	 zMog6+d1Y8fNI1wYeH+sQiMAGuN5uZImpEsFlJKahJdiHIfASg5hhNIE4Kqj3SCIZa
	 K+1x7ZVauUC7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199623839A08;
	Mon, 15 Jun 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: Fix always-true condition in PPE1 queue
 reservation loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156380564.325968.12566495684945605433.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 22:50:05 +0000
References: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
In-Reply-To: <6a2ca3de.ad59c0a6.147df9.2ac1@mx.google.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Jun 2026 08:23:12 +0800 you wrote:
> In airoha_fe_pse_ports_init(), the inner condition for PPE1 queue
> reservation is identical to the for-loop bound, making it always true
> and the else branch dead code:
> 
>   for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_PPE1]; q++) {
>       if (q < pse_port_num_queues[FE_PSE_PORT_PPE1])  /* always true */
>           set RSV_PAGES;
>       else
>           set 0;  /* unreachable */
>   }
> 
> [...]

Here is the summary with links:
  - net: airoha: Fix always-true condition in PPE1 queue reservation loop
    https://git.kernel.org/netdev/net/c/c66f8511a810

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


