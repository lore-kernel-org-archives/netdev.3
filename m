Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A68264A97;
	Tue,  9 Jun 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971608; cv=none; b=r38XAMBtmVkBAaABKEYPY13yswp+uNDCPNgKg0yzCZ6AcVtPAfGSON33SLsqOz/ttXnK2zt74jrmM51PwB5IaGC8dUklDd3/Ys8MQdi6JA5VVOS0uWbgv3peJk8MCViZ5JClvLI2JXgecoe+Wn4hK2MzIq1wkYINTfDlwJ4R8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971608; c=relaxed/simple;
	bh=jqvRudi4RLNY5qbeW9/jRuDC4CtIydMsORGJnAxYdQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1rk2ZK72y6b4yPYXo+Mr2yoBGWs2+8P6kYBb2644XYdTC+3H1/1T8y7TeRc/3pacmlAVqcy8IIPqsYpor95Qz/cqAcFdi1N+5630AtY9xQWO5NP7m636mOJ07mIG0Zdnl7KxwL35GdzCIyLC7zXwmlZLMXSxjyjw+bxSEXx8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRJeQupd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRJeQupd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBFD1F00898;
	Tue,  9 Jun 2026 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971607;
	bh=+hquM/O+ouF28xu+c1My6bqiYrCd2e1RnMMOHXkbssQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XRJeQupdyr+K4UhTt0XWaS5hD9tM4BNDA3q21qcoWQPHWlCW6UJgTyc/V0MrT0AKz
	 9q1KxhvGvupyfDtUhhgumBP8Rl02R2SjcjRIOedMy+HCdIkmolNGho49EuIL/AYU38
	 53CnAJlcgAgYiCHshAU1GPxXRJfn685u/wcCTrdJfdcVWXmgxykm3XV8HAMyKqcNQC
	 1peqJoV8IU/Dlkz8ss5UfNajXCnPU7T68tCwaNoBi/nBXfjiA7aDC9Q1tlSq9MLVx7
	 A6wWyfcXAWNU2IFlUtDipwrfpRD4rWBajRo+OjAcFxzcLx02ug6NvoMSCOHH6YlJYV
	 NctdMDmzuonjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B023822D43;
	Tue,  9 Jun 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: garp: reload skb header pointers after
 pskb_may_pull()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097160539.1758231.18195055123313838139.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:20:05 +0000
References: <20260604141925.237746-1-devnexen@gmail.com>
In-Reply-To: <20260604141925.237746-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, noreply@anthropic.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, tglx@kernel.org, zhaoyz24@mails.tsinghua.edu.cn,
 mingo@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 15:19:22 +0100 you wrote:
> garp_pdu_parse_attr() keeps a pointer into the skb linear area across
> pskb_may_pull(skb, ga->len), and garp_pdu_parse_msg() dereferences gm
> on every loop iteration even though the nested parse may pull again.
> pskb_may_pull() can reallocate the skb head, which would leave those
> pointers stale.
> 
> This is not reachable today: GARP PDUs arrive via the 802.2 LLC SAP
> path, where llc_fixup_skb() already pulls and trims the whole payload
> into the linear area, so the inner pulls never reallocate. Reload ga
> after the pull and snapshot gm->attrtype into a local anyway, to harden
> the parser and match the skb_header_pointer() discipline used by mrp.c.
> 
> [...]

Here is the summary with links:
  - net: garp: reload skb header pointers after pskb_may_pull()
    https://git.kernel.org/netdev/net-next/c/ab71cf79e2f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


