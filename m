Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73A17D6;
	Sat,  5 Sep 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637866; cv=none; b=JAAQdlYggvAszs2tTOUT68eadY1os1TyyIh3mfUKnJmcxySB32TUDE+WnxP7/EUkT2tjdy1AbQqhumENXe0bCiC7gcmlNX2hk79CqvKJdaoCFusKVgFok/KHt4wz2sVW6sCvJeU/iMlJgWm41puexOYJtR5pWcsE3gWcDULFKNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637866; c=relaxed/simple;
	bh=jqhSaI2cqKkziLLFSrSvU9GdnEejv/MdJuPpsTdcOUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pBr/o7OnPBYZs+/RCoM7adjN0vmmfuDY01B/G3FiZ0Cmb2d8gdv1xckokaDRJDjZZ7674wwg3Jcd2/Ua7h2KZMfzfyGzGxaODGnDr9f5dMJp0NpFR3/gcYxJACy2j+MoFrN36ns3o7V5Z4rFpvrDtKzH4zfm909PJ4sGvydrgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoTTTBKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoTTTBKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357DF1F00A3A;
	Sat,  5 Sep 2026 19:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637865;
	bh=yzm1hvxHBVn+B3AEQ0kR8LeF9ZDDoIaccH3h83YuSh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VoTTTBKFaXjfTlbtLpNmJRzpwp0sFna/+YUoKCNtfNEipXrDV7u0ze22UBfqkHOgV
	 DcHSrLE/Z7YzHbYbtUogQTzbfhtVSJ779MvPrKbkm0YwuOWH7H1w5R9/rX0k/C7LKC
	 kXDvz0zZrQ/9m7eQVKi9CGXXIBrR7IFbnDIREYq6G3itIJ+QoOmQdrrubFr+vXiWsH
	 QOm3iD971ecBjon8tEfwKJqyzoy54q1kSGTeVOSg075KhSVfAMeNYLPkx8jImk27lm
	 UhHLuAkE1Y6mZzcu+PF2ANIJygaS2W2KZLkZ2a5R6LNAUI0fpjFSIjo7tiTfqHzlXS
	 IthN+7aSDAH/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938693924FED;
	Sat,  5 Sep 2026 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] net/sched: defer qdisc freeing after failed
 creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178863780539.1335621.17808621390639346249.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 19:50:05 +0000
References: <20260902155231.2149915-1-bestswngs@gmail.com>
In-Reply-To: <20260902155231.2149915-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
 xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 23:52:30 +0800 you wrote:
> This is v2 of the qdisc failed-creation lifetime fix posted by Kyle Zeng
> and David Lee [1].  The public reproducer is available in a follow-up
> message [2].
> 
> When clsact binds a populated shared ingress block, ->init() can publish
> an embedded mini_Qdisc before qdisc_create() completes.  A later invalid
> TCA_RATE makes estimator setup fail.  The unwind removes the published
> pointer but frees the containing qdisc synchronously while tc_run() can
> still hold it.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net/sched: defer qdisc freeing after failed creation
    https://git.kernel.org/netdev/net/c/e6662f2100f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


