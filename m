Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF0233958
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456048; cv=none; b=DkHq1Uz28jFKxdIMa1Szzed2O+hEu6CEi+Zr2PzNA72jKdjShopTXWN4nHV2p6JMUAUrFtFzQFj9weZAXMX5vz2y9G/IImYBNJTszZcNU6UBI+c/klSDi/msHZxiqAeAikEgkGd9lZA+4ZyRpItPJyFuOHL0dbWYGZiNhu6c6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456048; c=relaxed/simple;
	bh=ZeLoqNoWPGuLIg3gW4tAg7XgCMkCijxw0gzMsMDf3iU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EkObHZeJvAsJd+27/eH6Y2E7QjbXjQu4MGdom6fVCUiG5fTmi5jHRqx5BM2S9F9JXAnuchjY7J4CcYjCnOFoPp4rk2nCRi70oYNqHJU4odFb3tjUL0tGhnrwDsi8gekyyl8uarBeA9um3RIVKgxcX2qsn3+aWb/zB88Nx62KMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7qcmmVh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7qcmmVh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3841F000E9;
	Fri, 31 Jul 2026 00:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785456047;
	bh=CJoGr6acbO3MhRjIORoDdkT7ZHUa65wLK0yIyo5Fxjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n7qcmmVhUFUS1PlfDsWEAj/2kTvhgPr4OfAl6tRBu0HfNuX9Zm/y61lmoDZYLIn/v
	 dIj+2I71ujWuWKoZWZ77exLX0eA6h7iquBK8p2tIrMDsy47SlSo9RmKXFEOxZLRMQ4
	 SPYX9QtiUubM7oJrIjZfuS6a5JDBmPyY8BB+x4Tnfa4J97SMV3FszMAONyVV20KF0r
	 1dnjNTNVYj4pVTrQdYxM8PMLZN1SNjg/zZiMGBtEbl0kllj2QZgfstpz3rCBtTrOWE
	 TQadCz5WPytno5ewnKopDjfljOHkPHrwZ4tUmxNd7il6JuLHm3pyOrZ2Go223TJY1B
	 NtIVsJzAd4N5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939073924472;
	Fri, 31 Jul 2026 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] pds_core: keep the health thread stopped during
 reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545601014.49120.8761022328957689132.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 00:00:10 +0000
References: <20260727164548.359562-1-nikhil.rao@amd.com>
In-Reply-To: <20260727164548.359562-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 16:45:48 +0000 you wrote:
> Commit d9407ff11809 ("pds_core: Prevent health thread from running
> during reset/remove") stops the health thread with cancel_work_sync()
> before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
> health_work, so pdsc_health_thread() runs again mid-reset and double
> allocates the core DMA queues via pdsc_fw_up().
> 
> Only the reset path is affected: on remove PDSC_S_STOPPING_DRIVER gates
> the health thread and the workqueue is destroyed.
> 
> [...]

Here is the summary with links:
  - [net,v3] pds_core: keep the health thread stopped during reset
    https://git.kernel.org/netdev/net/c/cd09971dcc1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


