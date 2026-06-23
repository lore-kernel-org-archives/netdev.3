Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E13A6F19
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247222; cv=none; b=Q5eqQQvU392RIXU7/bXaqj5xLPK/VkRWZT+aOUBNGDe3dNgg6MqtJeuyuHbNOkZAATRy3Dd+r53nA4wzltzleRZSyXxs+1v7ux1ywLPfPIKxEDaWvGmopqtcIAzFjd5ONvkx+aEifmsuibU6cnwO3ByNgjZrorrp0kx2pH+3MjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247222; c=relaxed/simple;
	bh=888KVhgHm4zZtlcn9H81Av45V+cO8vyTuxujhwS1Shg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZoMoF/4YyA+bCLXkFKTUzhqi5/222lGN4jjHjVouVKEWkeOoOAZ9J2uHs2HwFv0MJsRXtn1ck5zuprh7+TdnoejSC0NKBHqrrTwh86fIgT1w6qZuRzzGTJJ5YqXWTw3OAvP/OIu0Y4BwqCL13caWGNtSwZFL5ven4GEEU4vMtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkKCGoEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkKCGoEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E041F000E9;
	Tue, 23 Jun 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247221;
	bh=AMcpquJMVliWCyVZpJVdP+uhF1fM/B/VVl+0HBiNrFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BkKCGoEO1hf3YhviPT1C0bP64ZqgQsZrhgVcMF4kWb6E1AiTeKELbfYTqw60uH921
	 2tWluMaDcn8Af9ijoAvovMewR+9AM8EucJ71jDxPr35ogKyycGLxbxyjBpLXnJdqYZ
	 FOhXCamRTtkP4CvMp4E+nwN+iZe4x3c1D++WkCs8P1N/iPf0j67dYYNNzTWdvY1ZKR
	 E+nP+5HzW6Xu+5KCX4Nhj24RyLKYp4vtO+0M+UTXoe78kryuGbsK0LbEDubAVr+LUW
	 MO/dzhnjTL4rdGenFKQeT59s30Z/uK1Hae8uYi3KLvpTGK7zpP3y4/y8aaoXtFM/TU
	 pEL1k50X6lkWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D43931005;
	Tue, 23 Jun 2026 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: airoha: Fix TX scheduler queue mask loop
 upper
 bound
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178224721075.2409533.1841899511926101005.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 20:40:10 +0000
References: <178187479434.2400840.1312143943526335838@gmail.com>
In-Reply-To: <178187479434.2400840.1312143943526335838@gmail.com>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 21:12:06 +0800 you wrote:
> In airoha_qdma_set_chan_tx_sched(), the loop clearing queue mask was
> using AIROHA_NUM_TX_RING (32) instead of AIROHA_NUM_QOS_QUEUES (8).
> 
> Each channel has 8 queues, and TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i)
> computes BIT(i + (channel * 8)). With i ranging 0..31, this causes:
> - channel 0: clears bit 0..31 (all 4 channels) instead of 0..7
> - channel 1: clears bit 8..31 (channels 1-3) instead of 8..15
> - channel 2: clears bit 16..31 (channels 2-3) instead of 16..23
> - channel 3: clears bit 24..31 (channel 3 only) - correct by accident
> 
> [...]

Here is the summary with links:
  - [v3,net] net: airoha: Fix TX scheduler queue mask loop upper bound
    https://git.kernel.org/netdev/net/c/245043dfc210

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


