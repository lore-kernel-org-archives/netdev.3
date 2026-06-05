Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA0364939;
	Fri,  5 Jun 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623629; cv=none; b=OZuxOQNs4H+Byg8kIJsWpQTGlLsns7MqFIIHSAK+DbP55vHlRWbjZYh7Zo1oiq0iXYD6Pz2rFBuD+SSsCnd+J91eVuIgIi35w9bfyZdgXegwEzD67y6d/IfioOIsuwzH8E2bWtCnVS0soKhSvAJ3TMG8/4JVcgV6G1zZNENT844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623629; c=relaxed/simple;
	bh=vRXAdQtaMB/n3LIqHdj8QcWdDFCWhTQBmDwBN/jt9rE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9iCmXhyWvg6lhpfG5Z/NNKLfO3UDQ4XgFR2IcrOaPg1dlnmT//YEpSdQ1LBHSxLZzeh2F5Ox0/aXVI3RB7iBrTD743PeEnS/FOH1c1gZ4tc05jrYqWQT8ohrP4FSgH/T1dDtNYmm2lUUIn46ZMOziFiEvcHgOCbpA9nUVQ3S8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6/l1+tK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6/l1+tK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E021F00898;
	Fri,  5 Jun 2026 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623617;
	bh=e1dGGFkL7mOP11H/4QSRAmNfsELjK81noFUNsbOWfS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D6/l1+tKegYdwgmTkTfH/p8zNg9Rfj/hINa3uVl5TscbpoVlJFuJERFuDM0iphxLz
	 UZ/dmKV1W16SiytwzfbllX361bYzPTxhMxiYEG4m9fa74MmIUI7lafNos4B32te6XH
	 2hH/taRnfuDiK1CNhhT9syTSQxsqdr5Tynay4sM43cJua50DBv8acpLqOsJZG1H1Vj
	 7BihyKrDYrOhtwIQOuOySYwdXkkOhOC3OrvMTMqHPdQWNAlNRYcmN9p2zZMcYE4y8+
	 28bmjnLfWRvsbiewu3/f4pO5/1uR5b3jvH00MgA15+1jPikghshbSa1Nuug5oVNkDY
	 K6rVmI2hyz1Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA13930A8B;
	Fri,  5 Jun 2026 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: use READ_ONCE() for bindv6only default in
 inet6_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062361789.3097022.10379548092017503549.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:40:17 +0000
References: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 08:24:14 +0800 you wrote:
> inet6_create() reads net->ipv6.sysctl.bindv6only locklessly.
> 
> Use READ_ONCE() for this sysctl access.
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> v2:
> - Shorten the commit message per review feedback
> - Drop the Fixes and stable CC trailers
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: use READ_ONCE() for bindv6only default in inet6_create()
    https://git.kernel.org/netdev/net-next/c/7a20eb54224a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


