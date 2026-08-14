Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4103DBD76;
	Fri, 14 Aug 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677881; cv=none; b=M5iVpB4PBhkFKS9126R0j9CNp8EQb2eq6x5/waU3H5EOPjWgCVnx6rkvsuFEE2sbW/wjSAPzg5D5mMgorR24vqKw7KJbEUyNfamxMzC8nQR+ktMC+69ZfwAubqEabi3XQm2QmQt9wrx+G3cLivDxL/Fd9PbHqpd8gFx11VOiRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677881; c=relaxed/simple;
	bh=aoi6IyavqOU9QVEPrvI2km7eXyksyIhw5EMkwDhP07w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElWnk2IbYZI5+GK/UllisfGu2UKyaPDwuuHvA9RviXpAbUx5A3KewTf0aQpWzksgEud/t4JB/rBk8zsUukjkrTxOBjkP3WklZlN6owtmM3G9U1Z6/OqD/OYzkeY+GXRHkNKhLL04TjakWL1BAtVmgCm1xrk0beoKmcd87zFLpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1VZMZmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1VZMZmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF571F000E9;
	Fri, 14 Aug 2026 03:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677880;
	bh=9SjwtDkWoR/1fXOJ47WM13v12u5kRwXbTWuhTE5xEyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K1VZMZmFE1P2ar7GVsuIU7RIAtZhSg9rAVaUnfbHmF7iIVKKzhXd7mPffX42JCOpO
	 X38CX24TIEAAszuThnvgJW4RobW/+DLr9Tw9JnjsoaV//r4OR6oxBYTiwcV0ACjTVL
	 aHB0X8fJpi0fCxyqXFJxtkHjb24FUEyTsuurY+keBiEgf3K8SRwT8AD2+5b7cBQxWF
	 jTZJstfCaD0BBhdUTJoP3hnxgXYGFi1cyzPjksOji+EuVh+5iZAACVFjLBp92gRO8Q
	 mH51qXFxk1way3zrqV35VPoL0t4G5gtpS6hd0zga075FVZR5/KGbkbpiweE3wMPCLj
	 4iUFRRX33wPww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A9C3810900;
	Fri, 14 Aug 2026 03:23:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net] net: page_pool: fix UAF in
 __page_pool_release_netmem_dma on xa_cmpxchg race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667783439.3150297.17463702464769958998.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:23:54 +0000
References: <20260807114830.344336-1-shaojijie@huawei.com>
In-Reply-To: <20260807114830.344336-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, almasrymina@google.com, toke@redhat.com,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Aug 2026 19:48:30 +0800 you wrote:
> This bug was discovered while testing the hns3 driver under channel
> reconfiguration (`ethtool -L` / `ethtool -G`) with iperf3 traffic on
> arm64. The race is intermittently triggered when page_pool_destroy()
> runs page_pool_scrub() concurrently with page return via
> page_pool_put_netmem() on a different CPU. A WARN in
> page_pool_clear_pp_info() surfaced the dangling DMA index bits left
> by the cmpxchg loser, which led to the investigation.
> 
> [...]

Here is the summary with links:
  - [v5,net] net: page_pool: fix UAF in __page_pool_release_netmem_dma on xa_cmpxchg race
    https://git.kernel.org/netdev/net/c/24ef02f934ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


