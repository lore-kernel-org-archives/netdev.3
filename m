Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099125474F
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777608669; cv=none; b=Vqg7Z7MwVp/z02vT09SaA+BR58pMkovLrduIk+3kaOA2IGWbMa2k6+nxhWL88dmVo+Cf67Gu1L72wHc19PJVE06ssYpxTglKW5vmXN6CmKgCpEjYqi27rraOIUzj6DmtoVBpwRFOqkqSKw0qoPEC1eMWI2WUr/wmc2DtLvF8foM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777608669; c=relaxed/simple;
	bh=Hn7AS9nLoOeYobBv0Xz8AyLGxwHW7hPieYtvTIBOrAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qgzyvRuSAvOo37Wl3OH6FlAEuHVa4QQ15nf36uEHZIku9B8PduaNUoy2MYsHOZ5WSOsLE4Qx0D4sz4sPdOdbSOW0Etvs4N50fKE0ueY0LSi8MFvUJ+pW9Vr/Izlrn7a8L/q6ZenDXWBxv3lxRI7rza3dVG7daHWWyNw2jixsSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir74uxAp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir74uxAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF257C2BCB7;
	Fri,  1 May 2026 04:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777608668;
	bh=Hn7AS9nLoOeYobBv0Xz8AyLGxwHW7hPieYtvTIBOrAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ir74uxApL2PsEUWr9ApY6Oea+lZh6Sl/jqEO7te0grLXkCe7nVhH9BprdnbB60ZJP
	 GQelcwmHj/w1pfhk9m4VR1wvMlVQuyXUoK8QFsX68Tg1wSrn3iwlYkZpToKUXlBZ0M
	 av4zZMbmCnn8DPqlHpjakbTYhO2VDS7xFCfoXpLN9Kf2nNDm07iuLnKs+AueABX8hI
	 wtK8KoqJxxhWpAf1MJnGNu5M/xhBn44/P1WPDsg99ttp8hGJhi2OD6fVGdfl7d9+tf
	 OEcqlwL3UyuG1XUkao4/S1ogVZPM4pOZ7vqE7STURC3NQq1oNEspGyAz8of4trNZfT
	 ls+QupPygmAwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D77380AA66;
	Fri,  1 May 2026 04:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/4] net/sched: tc_dump_qdisc() optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177760862280.3319327.9882800505110092540.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 04:10:22 +0000
References: <20260430023628.3216283-1-edumazet@google.com>
In-Reply-To: <20260430023628.3216283-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 02:36:24 +0000 you wrote:
> Before converting tc_dump_qdisc() to RCU, we make the following changes:
> 
> - Use for_each_netdev_dump() instead of for_each_netdev()
> 
> - Only dump qdiscs of a single device at user space request.
> 
> v2 and v3: addressed Jakub feedback (thanks!)
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/4] net/sched: propagate tc_fill_tclass() error
    https://git.kernel.org/netdev/net-next/c/db6ac77b0433
  - [v3,net-next,2/4] net/sched: tc_dump_qdisc_root() refactor
    https://git.kernel.org/netdev/net-next/c/304427709ab8
  - [v3,net-next,3/4] net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
    https://git.kernel.org/netdev/net-next/c/748bbef5fc6a
  - [v3,net-next,4/4] net/sched: speedup tc_dump_qdisc() when tcm_ifindex is provided
    https://git.kernel.org/netdev/net-next/c/6f63b829632c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


