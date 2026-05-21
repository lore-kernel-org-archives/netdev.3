Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFC314A83
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329400; cv=none; b=vFDCTE3Y4qwndziS95Wj1eK0znaNCs6lIW320/tZ+X+Ckg1+l9MPXp7abY8Rxo5PqLZHl6FqqUBV7FzDAU9KjuwnNxTg/tjrZyFoqkyOgi5LihsWVfEZeFyzxz+r0kzGz3rj9Az5wWvyZ2rsOZUcg8WcwQsgiU4tvRwGQqk21cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329400; c=relaxed/simple;
	bh=cSXmWAwb7K+4tv+yeQXUgELNXtJpf3l+4uXBowYiFbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nJ+G1GTF/ntQB7gaeGbryBehy1qGwjdQE/u/sTX+SlGYnmW0rPujuDYaXRK9gNNAofP6nqEbGh2R1ItvM+sviaV4zM+ml3D5Efyjk3arRaknxpM5UvRk+xg7IkHaBi4wYb5fwTINcimw1xrxgl1NdVM+c+g2vrLCrgN/URqaOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYqd6c19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYqd6c19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0C31F000E9;
	Thu, 21 May 2026 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329399;
	bh=2WOIcDZjypz5NHhFyAiLElITC52UGHzvFk4lkFHvEcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TYqd6c19rI8BSMRazNGp8DMlKRcL2G/GQE1iFO+7MJ7TUWzZ0oXewZXLd/bRw/h86
	 E4Dr1z4NlwHV8+GK4ohp1btKLjp6NwZ/OH6S1uEJN3U4jPe+rySYgfkT6q8sROLOou
	 +B6fQ6o5eW1T63qtrcRQTHjrra60t6alsrX77Hycxzm9Xc5dw/UZLn26tk/DJR8CU4
	 01zjMw39XSwodWqwGaHes1djSejdWeBDFQbfFTHen1ZRU1khH3JSW+eT15I7B30Y9Q
	 nma2ARwMUmCJFqOVVtRO7VbyNVYK5M8kETw3Iww9DaSOKMigQeEslzGiAagDOFyefd
	 UIsR+rlyEk2mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0C3930C38;
	Thu, 21 May 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: use WARN_ON_ONCE() in ip_rt_bug()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932940964.3832404.4819745016411427645.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:09 +0000
References: <20260519193248.4018872-1-edumazet@google.com>
In-Reply-To: <20260519193248.4018872-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 19:32:48 +0000 you wrote:
> It turns out ip_rt_bug() can be called more than expected.
> 
> syzbot will still panic (because of panic_on_warn=1), but non debug
> kernels will no longer die while repeating stack traces on the console.
> 
> Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv4: use WARN_ON_ONCE() in ip_rt_bug()
    https://git.kernel.org/netdev/net/c/e4bdef4d320b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


