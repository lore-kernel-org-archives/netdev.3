Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613C27F4F5;
	Fri, 30 Jan 2026 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732937; cv=none; b=gh53eVtXdMr0M/XOtlj9fYPclkroZkzPC2AQzxsqy6yYI0kmHp6BgBqc0X7B13lorQA3U6v457wOlUG6xFF0Y0oTgV8d07wSwzc58awwE0JQSKNPgR5NQSx+hLNVXrBzVePn89XzYbnr/tHUJdweq3kcnYr5oF4XOGaeVfnQC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732937; c=relaxed/simple;
	bh=dNFsPqunxOZeg7MlDmttqkE6xQ/SD87GXDksdwlJNhc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rJ8TJHbZDfRufJ3rVl3NXMnFXUmNASTF5ouZTEikR0kTCaa3LWRHVdcxWHagsr9ruWfFn7PR9JAGLfG5voPrRjUmem1cJMOgbL+lhw1H87wDA8j0DCQWGpTqzbQ3Jr51T+iS6bEFpIb1pXb+Dkcb5eH9FUcFAhgscTGLNldpgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJFuRPgw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJFuRPgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057B7C16AAE;
	Fri, 30 Jan 2026 00:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769732937;
	bh=dNFsPqunxOZeg7MlDmttqkE6xQ/SD87GXDksdwlJNhc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kJFuRPgw1Y8YWTdyRiYyFuzxzgmnM8i1p6KGA9bxoCr1nsZN1RLmGSMUwu0hR9ezk
	 fNQt84FlPIRK52Gk8oj/w4e0moH21ufSKmumNbq5o5m+E89OecblhweRjxgQSoiiGn
	 ls7m0DTgq5UJ9h3lJpJI4czo/jS2Ci5Q4hoWczVDDGYcqfAK/Wr8vfyVGYnhUFySGK
	 yz8CTXvlrwrzsXujOQv1PFFU6qNq/+HqMTSoUPGp9jsrXpWSinEcN8OrwkJBZWmMsX
	 Y6CY5ldCX0l281H2As2tLCwnf/2dBT73fatWqkm9jHBATRJSlwFqarlfh00VHQuvI6
	 ORMOh1xiJTjmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11C9D380CEDD;
	Fri, 30 Jan 2026 00:28:51 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260129155441.386002-1-pabeni@redhat.com>
References: <20260129155441.386002-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260129155441.386002-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc8
X-PR-Tracked-Commit-Id: 426ca15c7f6cb6562a081341ca88893a50c59fa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cac38910ecb881b09f61f57545a771bbe57ba68
Message-Id: <176973292968.3113374.1781193841995809319.pr-tracker-bot@kernel.org>
Date: Fri, 30 Jan 2026 00:28:49 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 29 Jan 2026 16:54:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cac38910ecb881b09f61f57545a771bbe57ba68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
