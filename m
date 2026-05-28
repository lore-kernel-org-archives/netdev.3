Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46951175A62
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930019; cv=none; b=duSDITbAgEk+bpNh5dWypjyExih2pUzlK7m5SML8rhB6VsPMjdzWJNov3vbqYwFwJyfD0KqvXaryeP96ytSOrzWyjcTIp1N2KHUItuCsUsGpHDQJNybXOQIXuqVrPdyPTD/iX1mv0H1PrVDeqWcWWsgY7pmbnR38n/4OiEpNJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930019; c=relaxed/simple;
	bh=rhc1elmn84eJ1gvqzfr2gA1fZG9dKEYug2jBcP2Wb1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AKuELgWuUOyN32zhhMYGg4L6Eo6XrBFU1DDnFrN+AZxu8ySqbdv9Vo3r1djc5W0gGCX5bA/9umlhFFyIB5WjUerlJnu09PKPyOPstDSpkVe5OihQSICXp2uBMi7otZHrQJjuWzDn8QQyIrzsdmrD94MZkCDX2dPh7YK6YsyJd9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOUkAoWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOUkAoWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB091F000E9;
	Thu, 28 May 2026 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930018;
	bh=eFpohcfrOYCk/5PIsAU2d4cKfC+GNpc3K+bPkHReIjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NOUkAoWhmIXQytFywYG14W70uVdI/iVI4xkHwEliqCmq3+iar36Fg4O8Ri4+0QPBx
	 pD6HSR2QHe7e0SNRu0LsXonvFGc3aYDG5Wc8LOGu7QXrlDYsgIst+nzKkJkkZZuvlq
	 sWdkkMEFSddg0T229XUae1FtJkCI6Oz4C4tyyVtQ/CVxZNqdIX2FAPmwee+q9HaiAq
	 Khf4CBJav0Nzi2kRiVmxyxqQuWnG8N3oMScvNgtHa+dNPMHOMcFnf3+U9HWJwZIp8M
	 K+DvknrgpjcZCvXXNb43qCgTfuYWs9IcbIGlnNv/hXBk8JV6d0IHGwKnIm3Fsd2GLF
	 NWacdx3BDLXFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B2C380CFDE;
	Thu, 28 May 2026 01:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/sched: cls_bpf: prevent unbounded
 recursion
 in offload rollback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177993002288.702981.1831083274612144658.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 01:00:22 +0000
References: <20260526025529.24382-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260526025529.24382-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, kuba@kernel.org,
 ast@kernel.org, martin.lau@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 10:55:29 +0800 you wrote:
> Quan Sun reported [1] a stack overflow in cls_bpf_offload_cmd().
> 
> Reproducer on netdevsim: add a skip_sw cls_bpf filter, set the
> bpf_tc_accept debugfs knob to 0, then `tc filter replace`. The replace
> calls tc_setup_cb_replace() which fails. cls_bpf_offload_cmd() then
> swaps prog/oldprog and recursively calls itself to roll back. But
> bpf_tc_accept=0 makes the rollback fail too, which triggers yet another
> rollback frame with the same arguments, and so on until the stack is
> exhausted.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: cls_bpf: prevent unbounded recursion in offload rollback
    https://git.kernel.org/netdev/net-next/c/27db54b90bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


