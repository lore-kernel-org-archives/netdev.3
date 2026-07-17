Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22C3EBF16
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287243; cv=none; b=EI2ZQZfgWAjFm8iEDh6XSQeRHdNC/kvnkRXvkyagZuM8bj4pDnWiY7nAYDrJvSKSTgu47baRnzPf6+BkxI87lMiKcJzK94/UiU4psimU06mAUsLtPO/F95L0w56fV+9C0dKfKZXOn/h8FMb8Dbd5iUimsf+VLq+ouhO3RMnRcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287243; c=relaxed/simple;
	bh=sCLG1kgtQPoWuqB40x47nezQG9a9tA2RzJzZH3YAow4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hnrqLl51JHFszquREU3YOaOo11oMvZeJYokgI8+rH0qAfG6kJLsHhLK9t8pB8m+0RjG5Obl30AghJJ1TmeLq6r6wMLmuwCbd0kCVeKk+EaHktoyq6ax21LyVwChwI/evIZD5rrX6KCW7DlyHWJ1ZuYqVooZ29aBVnJZAhuUfikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMDIUGES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMDIUGES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968991F000E9;
	Fri, 17 Jul 2026 11:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287241;
	bh=U58275oukP1SolzSMput4gUq2ByL4S8Tv7evc9xcQOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aMDIUGESsXHOGXMaJev4GSLHQsQ668yYYW5b2Xuf5s8cXkJQmB55qLHU0LLYg/IKv
	 fXp11aI2KBPNZXlYd38bhvg2X8wg3F4VwrzEbwZkizaaOUvBQoYpQu63sgP1C97QbS
	 cjPOsd3F0X77GOeLP4DRPT6hPTdqIUTVo2e3TUX6eWvuk/YM7JMQfS/T7zgcrs7hgS
	 ajka9CMPpOzWt4g0zfnCB39OzGG1Pr/DuKEvVenPPTlBOrGFnI++0h8HKSYt0oT2Is
	 e1vL7B38tdND700lZh4SMScR685anb6AC4BPQC80jPS8aOkqyrPzHeVsDEicMXSwMH
	 /Tf6JjaBhSrsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BF380CED4;
	Fri, 17 Jul 2026 11:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: add preliminary support to
 configure
 tx hw QoS queue during flowtable offloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428721388.1673922.11887998955572978468.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 11:20:13 +0000
References: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>
In-Reply-To: <20260703-airoha-hw-qos-queue-stub-v1-1-ef253ffdd093@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 03 Jul 2026 13:02:17 +0200 you wrote:
> Add the plumbing to program the AIROHA_FOE_QID field in the PPE FOE
> entry with a per-flow priority value during flowtable offload. This
> allows the hardware to steer offloaded flows to a specific QoS queue
> on the egress QDMA block for traffic forwarded between two interfaces
> via hardware acceleration, bypassing the kernel forwarding path.
> The priority parameter is currently always zero because netfilter does
> not yet provide a mechanism to pass the skb priority field to the
> flowtable offload driver. Once that support is added in the netfilter
> subsystem, the driver will be able to extract the priority from the
> flow rule and map it to the appropriate hardware queue.
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: add preliminary support to configure tx hw QoS queue during flowtable offloading
    https://git.kernel.org/netdev/net-next/c/9df92875d6d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


