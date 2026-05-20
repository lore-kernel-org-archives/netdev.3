Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CB299937;
	Wed, 20 May 2026 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241196; cv=none; b=WHG5IQnd7CfwyCW98wGptgwHUUnKX2cyADowd8rU+tpRWGv5xqM8PX6gi8hYBA8ZQkPqykCNuD/eUO3xuG7/R0dZBZaeF/fcfr3NtGqbUmpaYshyJY6o/zXH5bP0Rg5OAWP+vMN1LS+TlMmV9lwBVRYSWGX6EV7X5pspZe0pFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241196; c=relaxed/simple;
	bh=jaERvfP9vlS9HhCuR6b0QO4ihikNt88x6o4aaucV4TM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YkaSQ73gz76gXwa9h5xDV65sOxm9ZdqXqlj13uK/33MdmNaOFHLvW+cQIHMq9L0hxDjuEOqy4EPI2VE7zmG/qgXcyPY229aHgAfqgeem9mJ/mJ1WYsz66CW+w8g4Rc3YUUVHPXGHIoxY9yevYRIUjnu2zzvST8eLjaDSJEf1Vjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Ypcgbo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Ypcgbo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7D31F000E9;
	Wed, 20 May 2026 01:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779241195;
	bh=Sz4goEQEmPOxpmdjzuLQpA4CBuy9m4YUtFBD8eEbjTQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O8Ypcgbo5d14UqP82dk1m2uy+BVfAp7s+GKqaWM7w9SEbD+74EJ8FLHfUOaPRq8lP
	 64sMhJf48MK/sqqlGNMQMipTXLNealo2MTAD14F0oo5yon0zqTMPIq/SnjOv7BaNkY
	 9Pl0vKmxujofIQG3EusGHP0IR1PQocyavw9VwEji0QjqHtXcF94sO7/lNt5ypPBsHW
	 KFIOVgnOK/QCksyb6womhv+33Qpq9qCPdD/YZAA/8LGFKyOCP/edSsBCoXowELxkfC
	 ZL/Q7UUaq15OSUPjRVynz1RIqipWyXpjvJa0PXXv8XgcNTHHNcfVWi0ph5vlOOB7D2
	 7zgYJRqo/nBHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5683E383BF53;
	Wed, 20 May 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] net: Replace system_unbound_wq with
 system_dfl_wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924120589.2945535.5054552078846441379.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:40:05 +0000
References: <20260515135143.259669-1-marco.crivellari@suse.com>
In-Reply-To: <20260515135143.259669-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, horms@verge.net.au, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 fw@strlen.de, idosch@nvidia.com, ja@ssi.bg, pablo@netfilter.org, phil@nwl.cc,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 15:51:35 +0200 you wrote:
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
> 
> This leads to different scenarios if a work item is scheduled on an
> isolated CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] ipmr: Replace use of system_unbound_wq with system_dfl_wq
    https://git.kernel.org/netdev/net-next/c/2c57948924af
  - [v2,net-next,2/2] ipvs: Replace use of system_unbound_wq with system_dfl_long_wq
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


