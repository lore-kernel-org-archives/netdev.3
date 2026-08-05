Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879622E414
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898854; cv=none; b=HCP/IvUt0ZbDVbN8udTyBhZY1n2xD46TeQds/rJnsutjeDpE+UWFjXozN1odqspefYAdFtnPXf1iVeyxchS9tqX1gqt3cQGUeyUO5yzek0Zi9lDSOFIHA1PWZvz6N3zLdyB9MxGepkq4wpDV+XK3JqILLOT/u3+SndKsdpTSE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898854; c=relaxed/simple;
	bh=mwhrfDEmPx0YXIa+S3iZ5LfSrwdqZ2P5rpKTtC+PD+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u4GiyZ7QCkgPomXUBQM7GQlUjHzzVsh63+0JbVJG/a9HZPyZ6Y3yHRCr9Fi8XAlAP8evTtPzfGUaSbE1jctS6r6nTyG4mllEh/b44ky47ILsmGwbQFtsDoSoOP7MJJkA5kAWCPrMVvcaMweZUa+nOtq1iTugii6OpAC9+WqiS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKduwOuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKduwOuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2286F1F000E9;
	Wed,  5 Aug 2026 03:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785898853;
	bh=xZA1Qm1XqmDPFUocu4qo43kQrZYqDT11WESW8GHw0HY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gKduwOuuCmXIQO7t71Z00nfLIVh06Adeeu4BCVJYeiFsjajb8GOPQhphmucVD1TZ3
	 mRl6TjBB9HcuDB6n1Y6JYa9w2fEOuX905C36aRJCq8EnLe50mTwCVZ0QU/NyQInqcq
	 PsDEIVYMboe3ThGbdW2vBXqRkJHPkYSZDlVI6LlLdd259zlj0H5O1kY7lPPADAFrVR
	 /7nvwrGBZ3ygyq+LDUe/iQulrzG9Ono6Lli3AspdbqYREdZ1ElYNoB6lTQP3oqvxoH
	 ererY52ZEfgzG1hqlJpUmOrObseGzxIqWZmO8wyyYRAJQAydBp2GqIhI6po01nerVn
	 SKZeRTWkOeNTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A44392666B;
	Wed,  5 Aug 2026 03:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589881313.3892316.12105671103564143961.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 03:00:13 +0000
References: <20260731190937.807270-1-michael.chan@broadcom.com>
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Jul 2026 12:09:32 -0700 you wrote:
> This series include 3 bug fixes:
> 
> 1. queue start bug fix on the VNIC's default ring.  2 refactoring
> patches preceed the actual bug fix.
> 2. Bug fix for TPA data corruption seen on some ARM systems.
> 3. PTP PPS setting bug fix.
> 
> [...]

Here is the summary with links:
  - [net,1/5] bnxt_en: Move RSS table fill outside __bnxt_hwrm_vnic_set_rss()
    https://git.kernel.org/netdev/net/c/1d0fc6c7ea49
  - [net,2/5] bnxt_en: Determine and store default RX ring in vnic structure
    https://git.kernel.org/netdev/net/c/53f01cd594e2
  - [net,3/5] bnxt_en: Refresh VNIC default ring on queue restart if needed
    https://git.kernel.org/netdev/net/c/0b137529a899
  - [net,4/5] bnxt_en: Disable EOP for TPA on all chips to prevent data corruption
    https://git.kernel.org/netdev/net/c/c3faf548a00f
  - [net,5/5] bnxt_en: Fix PTP PPS setting bug
    https://git.kernel.org/netdev/net/c/80eaf88efec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


