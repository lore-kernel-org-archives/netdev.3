Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56542D2495
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114809; cv=none; b=aI4hglwUR8FrtvntTqL0tyxxHHZH2/MhRzxQW4hQB9cGb4ntcjS16xvETZxokkNn/ObzCZjWh29etlsg7AZrHeWHQsnCc1uz8FgOVPRbvmy6NZAbp/ahW2aHJnLb2CbkgsK7cHeqOaRhpDceocgvJA45CCTyM2lUTJM+Au9SAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114809; c=relaxed/simple;
	bh=MCVoXZlM7XNgHdnCT60M4vmAoGtNxl9lNJC5HnmUGzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GuGc3r9ho3SiNm4oKQ8SlKo3bdjKuDjuMr6wGubst/6Dc0Fm6fHtjVGXM8xny0lbqJUNoi0vICUJBojtIxg/Z32o6NsZkpAquC1q2z7aF2J3wRBfvCqDHzTMbAHGdJuh4VXZqCVStlkC+TKK6DqTLWJWVmfn4OQrWJW0JnmCzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/D3P85p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/D3P85p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B1C1F000C4;
	Fri, 16 Oct 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114808;
	bh=NNLmcT+pccgyVN6WcWXx43hRcAVr6TkEbkHvXvdOrxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N/D3P85pkru8Ytq1NlzNRTJ+2QCar0S0Z16hnI+/ZGkkdyPSvQxr4ntQES7bCmkNP
	 bQjywGhyMCG9oCCoVUhL6yLq6SD5dnGmUnVfRkT+JjHHnlb483yu68DG7v01lAr3vO
	 bY/7hm0dRfn4pphqgVnWMZUxEESL9YWdZJeUqcG2De2okdUu9lIgQEEhrtV9vsF5K3
	 ozqg2h2vMPybukv/+UyQDEJS03IwIe/+c2Yv5R0MFU3+yIPFFa/eU281zvLRMAimmg
	 IalRv6VN6lxZ0w7oL6VLjTG8Pt5iSbZW+9cg10WAvZXITBdeu78d1/CvATfbNpMu2J
	 hrDKITHe+QEgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A51F3808209;
	Fri, 16 Oct 2026 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] ipv6: defrag: orphan skb before queuing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211480676.6630.7305268106492377922.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:40:06 +0000
References: <cover.1791008591.git.petalzu987@gmail.com>
In-Reply-To: <cover.1791008591.git.petalzu987@gmail.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, joe@wand.net.nz, ast@kernel.org, kafai@fb.com,
 vega@nebusec.ai, fmancera@suse.de, petalzu987@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Oct 2026 00:52:30 +0800 you wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv6/reassembly.c. The reproducer
> requires root in the initial namespace to configure TC ingress BPF socket
> assignment; fragmented IPv6 traffic received through that configuration
> triggers the crash.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] ipv6: defrag: orphan skb before queuing
    https://git.kernel.org/netdev/net/c/5dfa91a5ec53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


