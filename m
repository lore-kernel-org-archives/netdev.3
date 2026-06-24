Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7B12F360A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267665; cv=none; b=cQY9WV/BKR4gKt2PcJLIDE4+OJOxqEG+RKKwtXL6FSnbFswuRkltAZST/D7jNflvHw7rCQtqhVuRc3EFqgtJQPRfGTeI+xu6Bes11jFDBT2osjBLrlwQ4+egAFcRV3RGcRAOMyR7fGGFyHX65m9jYahpbtOYL7eMyaSeiKFbiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267665; c=relaxed/simple;
	bh=9vK3ARYUswW0jK1n5qSYHa//Zy1lqRO6FU1yh3x2qhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NuyPJQ7oeG9UTlUnLgaVqrxda6FIuFmg+Hkyi+I2iz5Dsyv+yqC/Rzm/2F6Va+yLFIYeWNoi6NJrBy0RravS5rDr2SJaqy45pNTrlGY0ZJnROVXoYhtvzXkty5F3OY/xcOR8ToC/njVOCoIfFHT3RTNsngONZPwqeicmdM84ZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn8Bdgww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn8Bdgww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69BE1F00A3A;
	Wed, 24 Jun 2026 02:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267662;
	bh=fk07/PL9n/7QLQndLdfQLuuvY5eviPEFkpY8fpfoE34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mn8BdgwwwRtogNF3BqyGxc42fEBpEN8M894TI09D21Hor0WeYWfHjfgbzds4h2vKm
	 zuUqD1Yu17ENaaW2dO4Giq9FOUb5IefAYBZUtJuVwtO3WDJnq5qb8ZUCuukvcQikxv
	 IZBBeCVeZbavCMygwDh8yZyXl0AEveE+R695sXDZvwSpDDfGheDozg7Sw/MSELTu29
	 1/Bdca7aCAVHiFbUQCk3KELXfk49ZKM+tvROC6dM2SIuG/mJ+H+3YPFRC2bk0mok1m
	 ijwb4dZcpvgS2wtOWkfLP0FefSbZS32I06zcVdavqtrPlNkvNOwzjipYsBSOC1+Mys
	 GS6BYYr/goUgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19778393102A;
	Wed, 24 Jun 2026 02:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: cls_api: Handle TC_ACT_CONSUMED in
 tcf_qevent_handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226765162.2513445.45924592615506529.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:51 +0000
References: <20260620130749.226642-1-jhs@mojatatu.com>
In-Reply-To: <20260620130749.226642-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, zdi-disclosures@trendmicro.c, security@kernel.org,
 zdi-disclosures@trendmicro.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 09:07:49 -0400 you wrote:
> tcf_classify() can return TC_ACT_CONSUMED while the skb is held by the
> defragmentation engine (e.g. act_ct on out-of-order fragments). When
> that happens the skb is no longer owned by the caller and must not be
> touched again.
> 
> tcf_qevent_handle() did not handle TC_ACT_CONSUMED: it fell through the
> switch and returned the skb to the caller as if classification had
> passed. The only qdisc that wires up qevents today is RED, via three call sites
> (qe_mark on RED_PROB_MARK/HARD_MARK, qe_early_drop on congestion_drop)
> red_enqueue() was continuing to operate on an skb it no longer owns  in this
> case -- enqueueing it, dropping it, or updating statistics. Resulting in a UAF.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle
    https://git.kernel.org/netdev/net/c/a8a02897f2b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


