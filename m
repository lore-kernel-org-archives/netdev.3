Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D947D461
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826678; cv=none; b=gOXT4UFgiUQn7ykuWLOH+wUl0iVPn7TB9qNedrvO/l3x6D7F0W1xO2tlxuKDC+MWjEh2+Dni5Fsc2qTArbS6oyxiYsnooErfnf1ZXfBI/7say2CC20xpUm2wmZUBulX2+VP4MUibs5v5Qkso3o6TLk3gn+BiFdIVbQUIH7Hj1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826678; c=relaxed/simple;
	bh=edTXrTWOBdLdt7nJsTPWE7e2OiTb/6dlr86qzjDgoF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=csBjVMbzMIi4Wlze5tkCLKzVcoGzKCaMhGZEQxM1piAg3S1Am3BszKH7qwtN4PtubqtBbOJK6KhD2zD110p8GWGM79nfdXsFNhxmhnbv39eKrJqNDr48u9Ke4y0rywlNzEshi89Qc+D8twLj8qc67ErDK4NjWLdmMf5X0UpHYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DFB1F00A3A;
	Thu, 23 Jul 2026 17:11:07 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BEA39244CA;
	Thu, 23 Jul 2026 17:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: fix ETS channel derivation in
 airoha_tc_setup_qdisc_ets()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482661833.2789426.13319789723330809436.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:10:18 +0000
References: <20260720-airoha-ets-handle-fix-v2-1-6f7129ddc06f@kernel.org>
In-Reply-To: <20260720-airoha-ets-handle-fix-v2-1-6f7129ddc06f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 13:22:28 +0200 you wrote:
> Derive the hardware QoS channel from opt->parent instead of opt->handle
> in airoha_tc_setup_qdisc_ets(). The ETS qdisc handle is either
> user-specified or auto-allocated by qdisc_alloc_handle() and bears no
> relation to the HTB leaf classid that identifies the hardware channel.
> HTB derives the channel from TC_H_MIN(opt->classid), and ETS is always
> attached as a child of an HTB leaf, so its opt->parent matches that
> classid. Using opt->handle instead can cause two ETS qdiscs on different
> HTB leaves to collide on the same hardware channel, corrupting scheduler
> configuration and stats.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: fix ETS channel derivation in airoha_tc_setup_qdisc_ets()
    https://git.kernel.org/netdev/net/c/649ea07fc25a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


