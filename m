Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA3BFE24
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781344814; cv=none; b=iPPcStc0MPOWjbDU/faSSiGikiqHzDeQkdacUtVzOlc6dxS3V0oa6UlzN5jQEIW+/rEtDwEGGaePro/ax0yqpcqidGjMKviIIhHObzNVYVZTdeuFALYGzA+L9H9OSY2/n36XTauSc6mR/TpMn/PDF3FnO25N+ZQ51Jk+gRgA9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781344814; c=relaxed/simple;
	bh=zE/aq7QcykEMgoRCjAtuYUTXkPyMiTJYt2hC+zx7ZRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IjX9FTrhwqTHLW0gv00K0e7oktnXYEbIvaMD2iEZbPvXSYlZXZ7q6RE++X8Y245NjjDMRnqKQlfH3qpuA68qIEldOxFY1FC7Ixi+tPhEPlj61D/3dIQU3VsTNtLDimpRS5moSxkiz7YvTYANWQsEjPFL1uk98p8zFqHqsOf8T4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMiOXSmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMiOXSmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1011F000E9;
	Sat, 13 Jun 2026 10:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781344812;
	bh=SI5mubNkp/ybE6yGHi0ZhrS7nRigP1sL2S4f5rK4jrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SMiOXSmNHPOWH5xTGZg24u70lcgm2jsLW4NnMmTZDz+8CgfogI1NE6BTpCK8Yef4G
	 txOX5X2kKSqmuFsyhqeKT5VyvsPfBrEj1QV69ihtsGhochdlrUgAXZfQZpjooyznC1
	 5X0FOs/2CIt+u5ZVqJN8tTbPkF/ImbEZ4LIaJYxW3H5MQuJ3vFq2bY9wLXSz3sPsOR
	 GX4h+EKy+dxNJ69LWRwE0UgxDugIPMldjnLZKUYQSI/vFVkh3rhNe/OPlgYXzJE5u7
	 DM7mCc6fI3XgNWaOerWVYeZ2z2N9EmoorH6+62hbPC9eggNqQPkA3EaeY+9Gg/JRum
	 x6bJc7babJtrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5E39EFA6D;
	Sat, 13 Jun 2026 10:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2026-06-09 (idpf, ixgbe, igc)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178134480863.1443328.11582222064261049456.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 10:00:08 +0000
References: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260609172458.4046222-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  9 Jun 2026 10:24:53 -0700 you wrote:
> Przemyslaw adds needed padding to idpf PTP structures to match firmware
> expectations.
> 
> Larysa bypasses XPS configuration on XDP queues for ixgbe.
> 
> Khai Wen corrects offset into packet buffer when handling for frame
> preemption on igc.
> 
> [...]

Here is the summary with links:
  - [net,1/3] idpf: add padding to PTP virtchnl structures
    https://git.kernel.org/netdev/net/c/d1e8f9fd6b98
  - [net,2/3] ixgbe: do not configure xps for XDP queues
    https://git.kernel.org/netdev/net/c/7bd4355272de
  - [net,3/3] igc: skip RX timestamp header for frame preemption verification
    https://git.kernel.org/netdev/net/c/38b7a274cf84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


