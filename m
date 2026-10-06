Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC41443C11
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244815; cv=none; b=Tcs+rWv1OFJyMCDJ7gLC9A3HNbkfStIBtdb5EQ77SwlmTzFHfgK1KUqYw8/Vz+LvoBg4naI2yX78gvjkbTdEThBjI0oKk8RKAWaUhuALPN/x4ymp3qr4V5ZLHoqW3LIvst9q4STo0WVVUM468ji4wfH3XCIg/niVDLhX/sjKB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244815; c=relaxed/simple;
	bh=K2g7NW5Ha/9swSIrUqqn5D50S0NuAjsZkcyKZgfZah4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZBRCHM4AIyek7cIiDZXEaanLZ3BseOsg2WhWmk4fQ863H288i0iG+0W+CrwkppA2DiE70p5qPgIhWhIVw5BFsB2H3Xg+NM/p9s6cRcM474W091daHXIGStXcu8z1C60sYLXDG7OUBmA7kFrPUvMTMaJcQy/Ury+SzTU7O5/Y1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEvbgReN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEvbgReN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436F61F00893;
	Tue,  6 Oct 2026 00:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244814;
	bh=dquMfx3KkpejF42u0QazTIb+7JYwllot23pAFeXYGcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mEvbgReNcvxHbqbScWB8BaT2nB1O8qnUp2Iu9nyQk/woaPvnuzB4J6T1hlzGm7L0b
	 UUr1Osyap+NjfRd6ud1tKGDKB6UvAapP9KINhcaloJQbow4sDYaAw49gTQRrvDYaAe
	 DJqbaa98nLIZZBnKliu/hjRBbewFH6/jkgH6/0OT+m784zMn6xPy9Ugtcv1I3Xrnrz
	 KVT7PPhtBeUpEY7zoj14Lii9VyFRo5rETckS7xRAxNSED7wCRehNsqMQuetTxVLHvS
	 4BBGDY9tn5wtOpV30FDtoFGwWV5TJD1NO/A84E1bV+gvxEu0oX5aiOHCkTkHdtx/Y0
	 n51IBbomVFZHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A20E392667F;
	Tue,  6 Oct 2026 00:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] selftests/net: add SO_RESERVE_MEM test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124481277.1944959.10542295544983932360.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:00:12 +0000
References: <20261001192137.309983-1-edumazet@kernel.org>
In-Reply-To: <20261001192137.309983-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 weiwan@google.com, horms@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 21:21:37 +0200 you wrote:
> Add a kselftest suite covering SO_RESERVE_MEM behavior:
> - Reject unsupported socket types (UDP/SOCK_DGRAM, UNIX/SOCK_STREAM,
>   SOCK_RAW, MPTCP) with EOPNOTSUPP, for both zero and non-zero values.
> - Validate bounds (negative values and values > SZ_1G return EINVAL).
> - Verify reserve adjustments (increase, decrease, page rounding, and
>   reset to 0) and corresponding sk_meminfo[SK_MEMINFO_FWD_ALLOC] changes
>   via getsockopt(SO_MEMINFO).
> - Exercise cgroup v2 memory.max enforcement returning ENOMEM when the
>   requested reservation exceeds the cgroup limit.
> - Verify that a child socket returned by accept() starts with a 0
>   reserve even when its parent listener configured a non-zero
>   SO_RESERVE_MEM.
> - Verify reserve retention across TCP send/receive/ACK cycles.
> 
> [...]

Here is the summary with links:
  - [v3,net-next] selftests/net: add SO_RESERVE_MEM test
    https://git.kernel.org/netdev/net-next/c/095dc989f002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


