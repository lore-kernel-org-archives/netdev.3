Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C53FD96E;
	Tue,  9 Jun 2026 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004611; cv=none; b=U46KLDTRpF6qXz0ugCACvRVf1jSmD27WHKEu15Mje2cLAcwSxbHVDsj4/mSCs2Q7OF39jOQQbq7Wv4vWFaI1yyJSbD9OpM7Icz8DszICjnc8JifLgmE2/pBH2g55qM75aA3JqfXdzkO4bFTRtI6yIbJ+R7UFrAyYVcVzuVbPbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004611; c=relaxed/simple;
	bh=VSN30PGqN+I1aRALg0H1yUKnuCx9UaoU9ovFZyI2brM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dB0eJ94zTJ/a9gsp1Sye88lbGWtbF+HwylUEukN+7ibS3ERuOgeS4xfK1AL33Dg3k/OO/8j4YnKPwsxorxzbGTysRaR4xcQv6vCYO4sBrATawc2bHjYw74sO3lNyNzUwMkMRzmutFrkG4Nfi3ZYKmP92elLEisuXF5rUXBss/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG+zO3Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG+zO3Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37A21F00893;
	Tue,  9 Jun 2026 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781004610;
	bh=YqRrLqaWRa9PDZ8B2BfGwvMD9VdifRaF2iQ2kVsbhhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CG+zO3FixG2N62lkll/fDxTMyc9q0ZMa4piXq/8Ws3SSY/5U3fB4ql/DGxwrJDBt9
	 z+5Dpvsa01QxE5KpfIZyAMOwUCEDajeu4Qq6YKTuARPMecIi3S1V32ibjDqLpdMVOs
	 N/7p6VJGLvi6jVwXy+J9FiDldL4GLHhE6q94RZkONTJ4+S7DUU4z1XY4gDERp7dS97
	 myV7dAZZDQX+3wUO4Oy92kNlhUnlpFtrxrp4V/W4yFqVdJtCXNdnldOiH5G8+1pESY
	 PciLHM4qC5oACvj+saq3NUV8wIn0Dw2E5Eb6xUd2TV+/aaiKo+2EZcEWpdlzbqykgC
	 yTPCQezX1AZcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D839308A1;
	Tue,  9 Jun 2026 11:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] ipv4: igmp: annotate diagnostic procfs
 data
 races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100460914.1971667.2337389980081963342.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 11:30:09 +0000
References: <20260605014318.3890804-1-yuyanghuang@google.com>
In-Reply-To: <20260605014318.3890804-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  5 Jun 2026 10:43:16 +0900 you wrote:
> This patch series addresses several unannotated data races between lockless
> RCU-protected diagnostic reads in /proc/net/igmp (igmp_mc_seq_show())
> and concurrent writes in serialized paths (RTNL and group spinlocks).
> 
> Following the precedent in commit 061c0aa740d5 ("ipv4: igmp: annotate
> data-races around im->users"), we annotate these intentional data races
> using READ_ONCE() and WRITE_ONCE() macros.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] ipv4: igmp: annotate data-races around in_dev->mc_count
    https://git.kernel.org/netdev/net-next/c/1719841cab55
  - [net-next,v2,2/2] ipv4: igmp: annotate data-races around timer-related fields
    https://git.kernel.org/netdev/net-next/c/3289d17b7a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


