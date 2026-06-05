Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959C3D5C1B;
	Fri,  5 Jun 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623628; cv=none; b=aOFOQ12GKXJDOmPR5NhREYS0bFI9meWDQ6vrINknfhjnzIxPz0ym6o8dVVjsBVfBEfKHGPpTZd4+GwyOGP+YZOaDAzF+kHFned8N4l4SZlNx5HNsiyb9nGjEoJqwuC1jNCjptCVkXqcfo3toJ3qIrxwJ47lhXdE4DN0id+lJRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623628; c=relaxed/simple;
	bh=+zinyzrA8XoP3Nsg3fIbFLi/iU9M8rxdk3fHo/0+mGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AZryWyDi/NEwFNaWSRdSGDIL6WEO8l7ErzA6VyZYSbA3J2cGt0ORhkL/RGMT+HG2+cWS0Yq+h/6OaSEEuYmYzsWHXtuOlQCp54MMxbRklDML5X0wI/a9E029QrYoFV6mQz1szZLQ5oeY2lHGNJL0cFMCQydZNJgw//z6IbtW1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpSFTi+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpSFTi+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E141F0089A;
	Fri,  5 Jun 2026 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623620;
	bh=4pfn9JYoJyI0kDiXq8yrzgV1kwHYVOZnecHsEPykLUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GpSFTi+ATuOAikeh3fq9kx+astKK90T+CC15OkwxK09znoQsLp28ZOh4GnEPN05KE
	 ZlLw89odIepgutO0iJoLqqIQr8AmcN/6xJSsWVZDus39PJvgCTsqcTAMRI4XVgLkAw
	 LiKmgw5fSNPVDBcuuWJn7Zac/EQR+Rw/G1Zf6R7g2gK8S6VgxACQBquRwW6T2nl2dt
	 BbeBmwUlzvvrQgfZdhWYr8lnvVebeYQC0kfjbkuhr6frnEWN7a0cQ/L57dw2EgM64v
	 jkoOtb1K1nAUD0jO+0vhAzR8nUqqnKqFGFj5Hyf1JQUOxwnA2YT01Tih5sB2KaDXjd
	 sifSobfeCVWvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B4A3930A8B;
	Fri,  5 Jun 2026 01:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062362089.3097022.14883090293149597815.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:40:20 +0000
References: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260602002506.1519901-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, edumazet@google.com, horms@kernel.org,
 david.laight.linux@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 08:25:06 +0800 you wrote:
> ipv6_flowlabel_get() reads flowlabel_consistency and
> flowlabel_state_ranges locklessly.
> 
> Use READ_ONCE() for these sysctl accesses.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
    https://git.kernel.org/netdev/net-next/c/f425c55cb60e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


