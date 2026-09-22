Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184DB33BBAF;
	Tue, 22 Sep 2026 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037681; cv=none; b=RGlwu/+0rLjFHchndxNNyzdEVG8XM39RJs2VSTeewuztY1AVT9vbcHP37alCurVjS5I/1Sl/Wlp/DlHzaanX6sq5ahz7rhlXRsCE9fSkTQx9Wc5yFBXapkIEhkSuMNAH7cstuy3hT8HOAvtDtcogThHjmjlml5dhLS8MuHIPi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037681; c=relaxed/simple;
	bh=NQsejQ8O0RnDymlWFnKEl1e9UoxQNo6t3uhnlwF7RAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ODJL8+4RZprFoISsBiBprW1wnGPoZLUo0AyI5KjXYh9rK+38pOCmMWSovMzy+yvOpuP9ULNdsEdyKTy22LXpWsyisDKoSay5CBrYgTZVjLJjVdlPVC3e2HZXCsksiE7ACw6rf1WWT12Tv7SexvvsziFHkWoiuKxrKQPr3E8TPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y82rL1Gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y82rL1Gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B593B1F000FF;
	Tue, 22 Sep 2026 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037679;
	bh=ZaEzFNKUN2vriZI7vq6El2hlzqpMVkokm7Ic7RWgyPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y82rL1Giq773svJ+uA8s6O41IiWCQd0nebVtuECAi7QiPDI0B4vsCnbQc26d/AD1W
	 OlYnTt3AwnkOznRMORz5KN9FKjv0bZNjAAWgLN0o4oDxXtzcSRokQTZ7fZcHzqj+Qu
	 56EUcJVIPsb05cSSGgYb7rd9oEfiKD8QH4zE9NVJKfngBA7qWrHoPUIosKtkT8gQ3a
	 Ew6NKeiDPQ/eWzW4bMM7ru7jvoo4mkFsq4HPlhxPnzOJ0fStDBeMTEDok1ITjny3Nf
	 57PspPx2VPNOc6J9Qi913DF5kJlvNXDEFYP1DkVbRgTH7L6XOXtTBrYz6SyHhzpo7j
	 M7/GK8uKHjU+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568283930203;
	Tue, 22 Sep 2026 00:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: hip04: use 16-bit byte order for HI13X1 TX
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003761088.3308999.15696540056719264003.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:40:10 +0000
References: <20260920033641.13590-1-hppiscas@163.com>
In-Reply-To: <20260920033641.13590-1-hppiscas@163.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaojiangfeng@huawei.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 11:36:41 +0800 you wrote:
> The HI13X1 TX descriptor stores send_size and data_offset in 16-bit
> fields, unlike the 32-bit send_size field in the other descriptor
> layout. The transmit path nevertheless converts both HI13X1 fields with
> cpu_to_be32() before assigning them to u16 members.
> 
> On a little-endian CPU, the conversion moves these small values into the
> upper half of the 32-bit result and the assignment discards that half.
> The descriptor consequently loses the packet size and cache-line offset.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: hip04: use 16-bit byte order for HI13X1 TX fields
    https://git.kernel.org/netdev/net-next/c/114bd09838ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


