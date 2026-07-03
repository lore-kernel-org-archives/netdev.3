Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30677274B5F;
	Fri,  3 Jul 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061426; cv=none; b=StgnZ5+1K+gl+nJKpB4T/Bfz/3HiXt3/8qoNpzdXsLTKILlaF3TJ+EmmbA2DGYIQeXJahaqHq6ykTBi6g3nFXX/CR4a2Zjo/8EOFd4OZJOcfyAgm2IoTIfpLmvhPISFxYrbjxijDTJmefCBH9jRdm36dHtkDZA7BJEbrbxAUHBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061426; c=relaxed/simple;
	bh=C7i0nqVD3+2ZxbHx6AKgZaEYV7NM/roVnjEg8hW0Kb0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qXXASn9ms7njFuPw3RzCM20diIjcGmTwxsvmbeq+kgN68AgSEZEM7BVGcXVmehUkjtX1kIkqWKwUo4Gop9orwlZS2TZIBHAd26X8MJBUnApsWc0ys6Oclqn+Nf5oKl+4hS8U2U2nR6wjA5cAPgGSOuKhFEgNQ7LtuvUYCS2fUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXatBaVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXatBaVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A19F1F000E9;
	Fri,  3 Jul 2026 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783061423;
	bh=DMMD/8KrYT0Rq5j+M48CEUQVGFsTMHzW9NuAxLWmtsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VXatBaVOy+EUGTQNdi4f0UHLZYL1oM+Le4mLGcAfNUsM+JlJ8c3aH3Fg1B/kMGzrk
	 5bKYWlGEhgiDA+sDfoMIEzhVfZ734nowevMSFcHPJI10o9UsGAF3BDCwjqq0I7E6aV
	 tSqq5J0pxmxv6tIC59Wtty7/ESVqkzNrhxmxydhagYidVudSuB0svepcB1I60Bncu9
	 xi4SmRu0rC+Er4py5kG5b04lLAXLdXGAJBz1F9h5i/F/dSQl20+yyN3x5AjHlrJ2/a
	 SJYo8GGB5yq+kfF6QkIzOT7FNxDLR1JOjeSw7zhnHNhyahCvbl64snW15U2Om5GT0V
	 6W6CF8ebaPgrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5689A3938791;
	Fri,  3 Jul 2026 06:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv4: fib: fix route re-dump in
 inet_dump_fib()
 on multi-batch dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306140589.2489617.2726115462010182751.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 06:50:05 +0000
References: <20260630084220.2711025-1-zhangfeionline@gmail.com>
In-Reply-To: <20260630084220.2711025-1-zhangfeionline@gmail.com>
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, chenzhangqi@xiaomi.com,
 baohua@kernel.org, zhangpengfei16@xiaomi.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 16:42:20 +0800 you wrote:
> inet_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches, a concurrent
> fib_new_table() can insert a new table at the chain head, shifting
> all existing entries.  On resume the saved index lands on a different
> table, causing already-dumped tables to be re-dumped and the
> originally suspended table to restart from the beginning.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv4: fib: fix route re-dump in inet_dump_fib() on multi-batch dump
    https://git.kernel.org/netdev/net-next/c/2ed8d5c72488

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


