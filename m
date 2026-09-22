Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270C539776
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074879; cv=none; b=ZhvJCrH+uYeRzHDzC4UTLGnb1BzkQs+rX86DarjUP++KBRCbwko5TjewxzN5T+hB4ZhCgFWzekT6Vw6hmxQriPqhmkiMKqFo7ETMSeYO3hDtOaRoXHPX3gcc1FWR/Ro4w0jGrxB6zqO4ETTJ8+3o4h9Xi40qA2fICd8H3IovXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074879; c=relaxed/simple;
	bh=4pn9HlPENIoGcC7WNaPTUBaKaF1U80OrkUu0oHtCI8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kOJt+vaGPPsxv7bx4G9W/gvEDnkvl6u4Gnsf2DReZs757jHolFoLq2ukQ63pQuouXMV2V8T87iYHtzkicT7jwmorekp8PsZ+rQ0zJxKfxw/yESfnjV/oie93i0vCcs5wv1xaihD4rVURMSFv3shySecPc0ys4xyEM3lhsbo55K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhPxlmRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhPxlmRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22401F000FF;
	Tue, 22 Sep 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074878;
	bh=obDuh5oJcfhIsVVQxXNsacYpXyC3eY1Y9ZBXVsdueGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UhPxlmRE9ufNHoKf0qfVV85ki8bx2UHxDo7UQYrC4t7iG76hTm0RV3pLOd+5PL5td
	 oYSu6RfFRnTProqvNrrt5LeWg3piLlnbRJko62FApfjgjLYiZgnvqSpqIvMFrBRSFE
	 jV0JqVm9prDmasNcCA42GLEtuBRPqI+zPSshytrlaF1KemITloe1EpCWZZGyx4rVbs
	 9uUT9PNYBQ3BLzSVbuVKApHMbxFjKlXnFPyZRWgKPesDYN7auAzxnMScQWwyjwpdWR
	 jWbCf/QzeE5N3YiOYLEwL47xWhmn3KzCWRmWFuUxrD/Ubko0h59ZhWQoWQmtMGqkUa
	 5OKKk7DtcB1Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567E838119DF;
	Tue, 22 Sep 2026 11:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/sched: complete action notification
 accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007480897.3557644.13819699362575738986.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:00:08 +0000
References: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
In-Reply-To: <QDISC-RYTB.v1.20260918093205@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, horms@kernel.org, hybris@mojatatu.ai,
 sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 19 Sep 2026 20:04:26 -0300 you wrote:
> The action notification paths size their skb from each action's
> get_fill_size() callback, but three gaps remain: one callback undercounts
> (TCA_MIRRED_BLOCKID), five actions have no callback at all, and the
> TCA_ROOT_EXT_WARN_MSG attribute is unbudgeted.
> 
> Patch 1 fixes the mirred callback for TCA_MIRRED_BLOCKID.
> Patch 2 adds get_fill_size() to act_simple, act_mpls, act_nat, act_skbmod
> and act_connmark, the five actions that still lack one.
> Patch 3 budgets TCA_ROOT_EXT_WARN_MSG.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
    https://git.kernel.org/netdev/net-next/c/f09db8b83e83
  - [net-next,2/3] net/sched: add get_fill_size() to the five actions that lack one
    https://git.kernel.org/netdev/net-next/c/4ba61bfd4998
  - [net-next,3/3] net/sched: act_api: budget TCA_ROOT_EXT_WARN_MSG in notify skbs
    https://git.kernel.org/netdev/net-next/c/54f5a4edf609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


