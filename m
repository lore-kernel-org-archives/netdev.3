Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518654;
	b=eKJOsw6AVDy0aTYVn+uwUGlM9s7dZm+6ImgulbRhETU7+4YLKLrGp9hFVKd2FtLDZ7M+
	 gWORiS1zG9HwFF5jaZf6ji0J8YxAEqbYb4iZYB/ErKxGclJ4FytQ2T1rxXaLK+RmUXlyD
	 crbKA1WHnXU7n33pnRNZUQkstKl3Qkd1xrjjlJr7k3sxqgD/7/1kON3pqnKDcNTaWEeXE
	 f5skcDJUwJ0RM1WqL9abLzBem25hTgCX3Cj/r4n5zs9TpNWTUWpbnEWbWoLhQmVzicpSZ
	 PwG2chgpWDRcYEDTyzjnnFLeI1LKCDWyGIJ9hSMUgEFW0A5RvOxxpK4pySIcWVppSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518654;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=SwiyLr/OYnqBboNqHgT0M5zvPLcGsgM/V44oH2pABuE=;
	b=p97y8AnzM1Su0nxdNQfx0qXN/Rws8IFOTT+7iLQfhWa10lWCuQ7KBFz3ewqykpyyn1yE
	 lCyxOxO4JyWi5M2OU4OCoFvRg6Hrjc4vJCevIRA6aOQy85FJz56ZJpgpIDe0m7TSf1F1s
	 /5RhDPROodSoDzohWO/Fj0RR9ML2StTZ3oHGLrmLFr4Yhq+YzV8p+7YU1/uqXeDaRc17+
	 VowBBv2hrO7r03E7gs51ksJP9rQ5Gfei3SVqxlLbQRuoEEJzMbylkjGg6FCJ6A/SpzLMS
	 lIkOYUnGfD02Suc+gU4fFiSvfOfM78VvAI01r/+4Szakge6c9RpT9xl1jzlACVB9OxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aD6FvV0S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFA606A88A;
	Thu, 12 Nov 2026 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aD6FvV0S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC13D1F000C9;
	Thu, 12 Nov 2026 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518653;
	bh=SwiyLr/OYnqBboNqHgT0M5zvPLcGsgM/V44oH2pABuE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aD6FvV0SU6orZUiYFY+a+S4oTkyzSyBAM4eX1lg3LvebQ00MgPTccPr/e9jWbTxSu
	 SIDlHCEzd1qLQUvGgPnGl6PXZYEf+yIvU7vbq7GQYquigrzMvgCpTZ0mh5xKuyBjXT
	 giCzt/LnL0bIYlv90blqosfxJSiNI742tzkfTiC+3LaoG+IkviUA6AL5ExYiIBvsAv
	 9LzNQXNnPzDnWgaui8b74S3Q/Xg3ih/nVC+FFJum/6izXp9zlbFFBjQVw/3vKecH4n
	 j7C0t0h9wp6JwemkgLOxIyPcsOnNI5ZRbAQmYGmPu8BX9imWPcMumNDXPlX5KzKBXS
	 0M2/J+TH0r9jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44B9392626A;
	Thu, 12 Nov 2026 21:24:13 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261112200100.519879-1-kuba@kernel.org>
References: <20261112200100.519879-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261112200100.519879-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.4-rc3
X-PR-Tracked-Commit-Id: dee3429e94d8089713645706df678ec54a049e13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e1392a42ea288d70a266f6553fe06f57f8647ea
Message-Id: <179451865236.654083.2910315134434826799.pr-tracker-bot@kernel.org>
Date: Thu, 12 Nov 2026 21:24:12 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 12 Nov 2026 12:01:00 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e1392a42ea288d70a266f6553fe06f57f8647ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
