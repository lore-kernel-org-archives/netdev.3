Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284F496919;
	Thu,  2 Jul 2026 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998427; cv=none; b=CWb2chWXpBjo6tLIWeYlPmKqWxXQuslj83yzm0oDx/4y86p5BG4+V+jrChzx4OEhKLZIoNroBKw/JOSwc3HP41deJuodHZ49nzcAVGrLT5+0Nh8OIcuBSDQHFISWrch4wwqx/FXz4Z2iKPdJQRDbas5YtuUBxY3U7Khgp/bGefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998427; c=relaxed/simple;
	bh=jce5eIDqJ1qhSHWuJeHjmciXAzoES83BFZce5IudpbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRFAn9dfZ7wzkBS3ZkdkCNkMkZxKMTyslFzda8aZgoPWNksUW/XD+i2X9ysc+sMR/vKTpFZdFVuKbrYQjIx/epCfkOkYhsqNA/A2oKF/kAjtNe3xqtGprOk/HJGgosUCEX2Wv6BgsbN0cRU9IZ+uGvMmulYopqLRIfLjNggez0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDTBgyDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDTBgyDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8131F000E9;
	Thu,  2 Jul 2026 13:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782998426;
	bh=8vpQVVgpuy1jDG+NB+a3fUPOj4X2FL4FrbzEm7M1nkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aDTBgyDqpxVQoj7rFqa4rxYFZUGWUu/dSuYymhUVWWzZKujsTtEpcDHH1eQf7m00v
	 09nepxefNxYKjvHSxpEWDxIza0r7VKKBJXNxYQrsFtYBeKUKdTTGJ+2QcEPpf0AjEj
	 9uiLS2hKHUs7IUxZ0A1RwtQIOjm4zn6Inyf3WE100H5ByzljQLRUSJ7VqQm0WndpPJ
	 9XWfN3vhYVeVDfUjX8MQS2VVfcE/UkvLfBXK8CR3MlHCG5jamUMDxtG0ZNxxNy0wQa
	 ldvYQZl5fxQz+hcSWsdF8w3Jby/NtPJJ6fcCHqs5IkmMiGik+ild4d2YxZ+1Sx90fg
	 LVgHP0uiOTPOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BCD3927231;
	Thu,  2 Jul 2026 13:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] octeontx2-af: NPC parser and RSS
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178299840914.1667715.17957237174202579176.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 13:20:09 +0000
References: <20260630062145.2533816-1-nshettyj@marvell.com>
In-Reply-To: <20260630062145.2533816-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kirankumark@marvell.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 11:51:43 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> This series extends the Marvell OcteonTX2 admin-function driver with two
> improvements to the NPC (Network Parser CAM) block. The NPC parses packets
> received by or transmitted from the NIX, and its matching CAM (MCAM)
> selects which VFs, queues, or output ports handle each packet.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] octeontx2-af: reserve 4 PKINDs for skip-size custom use
    https://git.kernel.org/netdev/net-next/c/5ba5611ef946
  - [v2,2/2] octeontx2-af: Add RSS hashing support based on RoCEv2 header
    https://git.kernel.org/netdev/net-next/c/961db18e28d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


