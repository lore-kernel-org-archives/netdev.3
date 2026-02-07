Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEE82FB99A
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 04:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438032; cv=none; b=Wny9e2hgoNOy8upudiNJ+9xsymp7rD3WrJ5s7l0/qxL9JQ9ixrm0DWRTmYZSp8KcHKnLQrXIy4u4EdU3RAZrrO/+Sz4z5oejugEQkg0omkd1ippb78vV1ei0+MHictrsw24c1I7VIsHNjwjB2O0ubAyTL3zD9Tg3p4QzLNLq0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438032; c=relaxed/simple;
	bh=au1jMF5vADOUe2Q4k9JPHeUUmpf43aaA454kDCS82GA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fpoj3I/AlnSMVi3LSo2HAwsxoA09TPsityXvWft7fKCRGpPzMan1yqqgdm6nIj0716mRp2PbBWQPOQkCpKkSn5bxb2OXJqJ+gu8DTcqGgvkSWG1LBgAljTvaWYovZry6bWPCxphEmNbjyPQP0r7jUlDU2ei74Tu4Q+ERTJ+ygUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC6HLivx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC6HLivx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DD5C116D0;
	Sat,  7 Feb 2026 04:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438031;
	bh=au1jMF5vADOUe2Q4k9JPHeUUmpf43aaA454kDCS82GA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eC6HLivxn6NZP9PjzMv80S4ADhcKJy4juGaBo4WU0pLgbZmmzYVV7Xc36/I3FvGkf
	 Y4CpLzIVKyDARig+u/wse9lWGY+a/DDeb4V8/8h2Cg/4SyPJics8PPfYU30fGjmsmV
	 f5nGakyjxFgth7TeA4f/um9rnAs9g1ymXYBbAdvtOt7bpbd7TkJBAICYgAJRVXde+i
	 ID3MPE1hUzKVV4LAwgLC1Yzffc7/frVMSNQa8bJ1ZgmMpsK3Quz4nh9hUvhHtkPIX9
	 V7aAPTxtrIOJ9PtNPIE7V6u2GhDsvVFBRilZsTUXBSw27d3J8yX7uYPG59eK6SbfdQ
	 CDyzvq44Madjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0583809A1A;
	Sat,  7 Feb 2026 04:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: sch_fq: rework fq_gc() to avoid stack
 canary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043802857.1183264.6214114625911512967.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:20:28 +0000
References: <20260204190034.76277-1-edumazet@google.com>
In-Reply-To: <20260204190034.76277-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 19:00:34 +0000 you wrote:
> Using kmem_cache_free_bulk() in fq_gc() was not optimal.
> 
> 1) It needs an array.
> 2) It is only saving cpu cycles for large batches.
> 
> The automatic array forces a stack canary, which is expensive.
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: sch_fq: rework fq_gc() to avoid stack canary
    https://git.kernel.org/netdev/net-next/c/2214aab26811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


