Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631415;
	b=oJEuIVAF1NFLWvTtJBuENFBErfQOvNJ7kGelC+CqwbFAfsjJ0SgETVWPuKD7ZPBxykzh
	 Q2uoXeSaLzUa8J7raSdQ0pOftk6KozKrOLW090phqAHbzdmh2UrySvfSo2cxK4HVLyQEj
	 h9oaSZOIyBwDShHSZNiJaqL/Tljjz0RUWo8fpL6jior0Lsinv/zqcy/vyWGeyq4ZuAG+I
	 XgQKXpv80a2DN2A9/6RRtorjTVm792l8FyNU0J8BeP10tWKPVovpqmW3LaXgn/Fr7fXrn
	 A+16ipY01W0zSz1WDo+SsL0YmPHAwEGYUKadQBpB4zdEHA4F2Jy2WYVcKGO2hMRuy6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=cIdij3y1R9Spdujd2eleAyL/qs8R2kkZeGSPGMbVydI=;
	b=UUFow3iLU5Vu9qpbjqon1yhcISdIR9FEHOkJs5pHSvq1ZyWSjfo0VX0SVPXms7xzl6lg
	 3zND8/Ech513upVL11PMnq9Xls5JOtQBJSl7wfs6IKaQD4tx2qZZ1fMS+aCuzxeqEhJMx
	 ecY5hgbnEnY+7KfRU0l8dtuuJIOlpVfeCPFgcVfrxv+3w1jjmrpHYF2CcXt1IPC08r52H
	 O4w+wp5Foz3CYufFW47esCwEwRzfpTzg7N/Ok6wqVciFzd7Cfe30EjHsJ6sNc+Z7/9+ZC
	 cRhnYGAI3wLK4LhKSjt2Ghxh0GJagwTS5bWTFND5nAEt2gJQYMsCK6gvc7uJqs1P/+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZImSqKro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE5606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZImSqKro
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA021F000C2;
	Thu, 22 Oct 2026 01:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631414;
	bh=cIdij3y1R9Spdujd2eleAyL/qs8R2kkZeGSPGMbVydI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZImSqKroOXOQRBkTn+VPpF99/pOeSIEui38h+lITsH5D4mkacC8iceP5/7Sa56cyQ
	 LN1h4QqlJhibfk4dbg9hG88jvHve0ktw138Np40FRY4I0zhKTDRQuAA1lSJohFu9a/
	 aRtNgMNIg6DkuU/7d451llVxBGhQiKtdoAwv/OvehaGfkJDFc4rn5Aej5pqNFWtc9v
	 i15lUAM7bIoiun4CdB9CtLsQvQbOVJHecZJE9Wh5BH7M8eNNAn3HntAvF7sbEkf70E
	 2EYRztZ45C4CcVLNBxGcz66y8fpGCaHANY9AZn0lh6PazENurEfyii5hwMwLHB2K5J
	 tjVoXsFmRz7Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77265380A963;
	Thu, 22 Oct 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] net/sched: sch_cake: fixes for accounting
 and
 reconfiguration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179263141302.1392288.3198241467821485238.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 01:10:13 +0000
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, cake@lists.bufferbloat.net, victor@mojatatu.com,
 sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 07:00:04 -0400 you wrote:
> Four independent fixes in the CAKE qdisc.  Three are follow-ups to the
> autorate reconfiguration work around commit 7cbfb180945c ("net/sched:
> sch_cake: fix autorate reconfiguration throttling") and the 32-bit
> admission-counter wraps fixed in gred/bfifo/plug by commit 4c660ee8c809
> ("net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue");
> the fourth is a dead-code cleanup found while auditing the dump path.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] net/sched/sch_cake: serialize reconfiguration with the datapath
    https://git.kernel.org/netdev/net-next/c/d23a16d907dc
  - [net-next,v3,2/4] net/sched/sch_cake: reduce parent backlog when clearing a tin
    https://git.kernel.org/netdev/net-next/c/d7010be1ba23
  - [net-next,v3,3/4] net/sched/sch_cake: widen buffer_used to u64
    https://git.kernel.org/netdev/net-next/c/dc48c97e7c69
  - [net-next,v3,4/4] net/sched/sch_cake: drop dead nla_nest_end() error check
    https://git.kernel.org/netdev/net-next/c/700b4c6c70d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


