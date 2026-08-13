Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E9378D70
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615252; cv=none; b=Aq3aRGe+t0DmhHCoMS7ZBXxEZ7KtO5N5L9KbNaUBygTQNA+HeYyNlmtfpSIHPJeM24hH7r7tg9GtqHDJZAfYQVEnKN9CnsmoDuc/EOGcEsnKPxRHNSU18kExJRLNLrR+4fQtXw8wJb4Qc4771c3hqR2hDKF72fkOXtDf8zKy7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615252; c=relaxed/simple;
	bh=h5vmb/lO65/vKmQkq+KbSwDyu1f9TEipgh7kD5r7KbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cWuuOAhzXJlHZfuTxVn6tFkZ278oJjz7lXZHGgLluqq3yrSP0IDTcnsqbfuUk1ts7Ay00rp7+6rnRwm9ax+Qfwbhq9DBZDw+XCDj6sWBR1Hpk/+lvIcEgOcwUHvhTTVq4Y8+BEbgHqyZwf88w3EhmiOXGhIRPCZpE1kcu2jyWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E89GgsIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E89GgsIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CD21F00A3A;
	Thu, 13 Aug 2026 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615251;
	bh=cp81QyDKGz0yT8MrYSFg1LWGqT9V6AwaReTfVwVZ3uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E89GgsIYG+Bzd0wM/c+FWYPaLAVgFdwheeGaOa0azNBUlAbu3LHhEA3ayZ/hSLVV+
	 VqlfC0Q1MZ22vGGvee7vULkrZDucR3QiGLrYP8nGl+qa5huZg/AJet3Uxy2SCusAVs
	 tjB0RVcPjanCGBszE34YTByzebxzjWdgWMM6X4tncK3+uP1fYoDGqdUk8lJi8wqJLu
	 axXunEsb76X6JXGMW1g6GKLLmaDRPCG+xd+X+mXKMNXcQKuN52c7zAti2E+AYCBl2W
	 yOHAONEUf4m8uYr2jlysfSzDQY7TjeudjVu+fS/BSiiS8dGyt6iK564ybQoV0Kt4h2
	 W+VPz1tZtK0Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD8380CEFB;
	Thu, 13 Aug 2026 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] l2tp: fix tunnel and session refcount leak on
 seq_file
 release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178661520639.2350073.15095295535866945481.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 10:00:06 +0000
References: <20260811144651.2733424-1-edumazet@google.com>
In-Reply-To: <20260811144651.2733424-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 idosch@nvidia.com, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com, jchapman@katalix.com,
 gnault@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Aug 2026 14:46:51 +0000 you wrote:
> In pppol2tp_proc_open() and l2tp_dfs_seq_open(), iteration state
> (pd->tunnel and pd->session) is kept in seq_file private data to allow
> iteration across multiple read() system calls.
> 
> However, if userspace closes /proc/net/pppol2tp or /sys/kernel/debug/l2tp/tunnels
> before reading to end-of-file (EOF), any tunnel or session reference stored in
> pd->tunnel / pd->session is left un-dropped when seq_file private data is freed.
> 
> [...]

Here is the summary with links:
  - [v3,net] l2tp: fix tunnel and session refcount leak on seq_file release
    https://git.kernel.org/netdev/net/c/9006c116dd11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


