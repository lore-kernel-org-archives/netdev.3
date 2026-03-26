Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67E3FAE16
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534824; cv=none; b=bu+wksOC+WdhgGcnoyuqSwWVjKz5m7bHUA8TivadzqycpkOUqe/B1yeWKivKJGI/3skXjkdjZ2bUqheeMiDrDppE6/rn3YE8OLNCyyzmpC5aoIJvBPX+yIOr2AdsBco79NKsD01/U56/NZ/sK+0wL/94xu8PvlYt29BtApSBEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534824; c=relaxed/simple;
	bh=GN3q2jDb3yXGGB4AvYK4N+PEzgJ1AQEQxcCUBMHg29w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=etYXDdSH+lfIf/sdzW87ScPlh674lw9ejtpHckzehj1ZPFXbEd+UGC1zsRjJsJfoscfbYVtfNJjFd49NFocN6GBTv9IO9jKS27q7LXAmC7G/Vjo1v+NRecRLAf7XGp70utDyN4HjgOdgstgCSb6PgJIqGLeCz5/zm6EFAr5CMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joGMUyRh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joGMUyRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6520CC116C6;
	Thu, 26 Mar 2026 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534824;
	bh=GN3q2jDb3yXGGB4AvYK4N+PEzgJ1AQEQxcCUBMHg29w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=joGMUyRhNpT/9iWHpMFFN6HTfjikPye9/nCnjluP2nq2ERbOgd+pc710euwUvr8DB
	 vkymuTNb3CmQUO6JNUcPkRSB7RPrjjwsAajvkywzndGToXtq9Zyi8WrEtXFpcfe73A
	 GxbPF+gzWa7GDXVms5VXoirPKmqT4+ynshVUV2KHjdQywKBo91Q82fA9WyWGAxN9f1
	 BpTi1v2jQDT5175SuBPSQMnxuz+UpvVrfKS7k035DWHruf6CWPMFlJQijBhtSqzXDO
	 TBT47cgt2aU6JZoG3sfyKYjqxvLpPDkW7YuifVMKjTc/oajBkZwo2gu95EexT26qXF
	 kwGSNfMlkWm3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF7839EFA69;
	Thu, 26 Mar 2026 14:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-03-23 (ice, iavf, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177453481117.2576185.2499695518599161703.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 14:20:11 +0000
References: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 23 Mar 2026 13:58:35 -0700 you wrote:
> For ice:
> Michal corrects call to alloc_etherdev_mqs() to provide maximum number
> of queues supported rather than currently allocated number of queues.
> 
> Petr Oros fixes issues related to some ethtool operations in switchdev
> mode.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ice: set max queues in alloc_etherdev_mqs()
    https://git.kernel.org/netdev/net/c/c7fcd269e1e0
  - [net,2/6] ice: fix inverted ready check for VF representors
    https://git.kernel.org/netdev/net/c/ad85de0fc09e
  - [net,3/6] ice: use ice_update_eth_stats() for representor stats
    https://git.kernel.org/netdev/net/c/2526e440df27
  - [net,4/6] iavf: fix out-of-bounds writes in iavf_get_ethtool_stats()
    https://git.kernel.org/netdev/net/c/fecacfc95f19
  - [net,5/6] idpf: clear stale cdev_info ptr
    https://git.kernel.org/netdev/net/c/1eb0db7e39da
  - [net,6/6] idpf: only assign num refillqs if allocation was successful
    https://git.kernel.org/netdev/net/c/b5e5797e3cd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


