Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7253D0923
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217021; cv=none; b=ktIyZsZIL9Oia8b0/ZMS+g7N5r+dh9I5f6RJ7+cDyIAMMGpthm7hQcDeDgXeNegRnmkOGPJjvJKD0yq1fcOgUmqaTZJk3dvlgeL3dLH6VULUDoonwbKVlWrkp42DhF2y8qWUy5C/iIczlqNhq6MGYfKNHsMbw0dgKl9xUdcMSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217021; c=relaxed/simple;
	bh=XMEg4+lZXxcFxnzojGgmBnM3VpNyILxZwzg5fj/joe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=niI/b8pGgfb4YZoS3+8wtzIRZn5mOhDWknk0ojncGBWios7NIfOOXKWY3VEnjllPufYSDmu/0lRLNXkwV9o47tjKEEmc5BIEZTd3QofMgr3dSs1Kf2nYBfGjNYw6iybvfXDqpgLUwerioHbaFNyVDHu/lJWVT3IsVkhuRi331YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqH0s6/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqH0s6/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA321F000E9;
	Thu, 11 Jun 2026 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217020;
	bh=pmqnXvm8j0YctDYPkvzzb82KQ0eCgHXq/TbwLAAVzKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aqH0s6/bcyXhvkeSgjgRhGqsmktA9L0W3HhcJtOYKpyypGlno6UoFikgoKe+D7TsL
	 srBHlzK88+mYymWy4/ICthL6k2irkGaumNHM9D8dB2IYpjo60kkPghZl+gq6Ep40hp
	 CirbYjkOCfuwxDPazVRGf9IP8mIVEg0FMHjnkb8GREA9nx7JCO0rjrboBhCvJmjKDY
	 IN55/yjVZTKhqu02T5i4GepGt6vIVJ+9ua/VxsXh1skovk1HdXxdtKxkMaub+yaEmF
	 pGXLPE45Iy0v0qJIalwsPo440JA2jjaswiW4+SzAPtIPGyTBC5PqcoaJtNrLW2U6Pe
	 SQ4exRQ6ILnVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939023930FAD;
	Thu, 11 Jun 2026 22:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] net: fib: Fix two use-after-free in drivers
 during
 RCU dump.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121701713.389578.16845185284597284885.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:17 +0000
References: <20260610061744.2030996-1-kuniyu@google.com>
In-Reply-To: <20260610061744.2030996-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 amcohen@nvidia.com, jiri@resnulli.us, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 06:17:17 +0000 you wrote:
> syzbot reported fib_info UAF in netdevsim, and the same bug
> exists in rocker and mlxsw.
> 
> Patch 1 fixes it, and Patch 2 fixes the same type of bug of
> fib_rule.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
    https://git.kernel.org/netdev/net/c/06b693d2eb66
  - [v1,net,2/2] net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().
    https://git.kernel.org/netdev/net/c/2821e85c058f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


