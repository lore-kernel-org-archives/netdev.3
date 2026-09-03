Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B6378838;
	Thu,  3 Sep 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457285; cv=none; b=lOC5mJ1RbfpmbphVS5+wZmMQvsGw7LQzNB5XKqgWF0yzwO1Ref41X0Qen63Ii5OURH/EPC2NaYtga7cA5LUSjsdJ4DSZgmYtap1IvNKqJnRP2/YYibb2Fmf4FPAveiC2OaxvzHcnpSbVsET+I3b6d42MrcrIY2HjUlsMczeDBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457285; c=relaxed/simple;
	bh=NuaGPCR1LE9d3ZsgG0pkxTBQUIJBPkAbf2IDmjHbcR4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o3gXNG5F8Ca+DJYkj0IO4L3yavyrad+2Ot6Qf/ZTjFHLRz1rwF4q2CzyD+bfC2UucLY5nBTtsxLEN4d49puRsU+dCSVIXeRiUid0Ruif7r97upGtrOvXLvnIQ3CeU2nrqCWEgJu749X1EyUCPF5n72DJV6NGjfXnkzECgMfPZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeZJmIXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeZJmIXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542E71F000E9;
	Thu,  3 Sep 2026 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457284;
	bh=PWmVWRW5QzC7TlgFxMXGUWbh5YMHid9rCZFBYhF2bHA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=VeZJmIXIY0aDxx/88+TJHbSeXx3yqWmHvwcfIlmGBr4bobih/ee06TKuBK1JJj5+7
	 7LXPs2lLgYuqSVkIknT7N3anK4k/zGtPWG9UGH8NyeyEXa4bLnh601y6JZjaf4PsSe
	 BRxLm0YP+i7+xa4JFM9dZBjOfbFQQ7ilqxBdLl5WY08s2xw4w14oFIo1kDQt7N8QhF
	 p6+lfgjol+toXrFWF3GJIftAc4uAH1tVSUcslfZrxC3cY3HGzTB+7yypesGXKCsr/e
	 XKbXrtEbejaYS1gfmcWorPwxu/jbk+LXEu+kBmxrFsjStuP2LLgMGOjCnpi4d79eQO
	 rvLSjEOi9ryGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BFE38119DB;
	Thu,  3 Sep 2026 17:40:26 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260903170735.107840-1-pabeni@redhat.com>
References: <20260903170735.107840-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260903170735.107840-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc2
X-PR-Tracked-Commit-Id: 66817a9794263cd2a5dc4e99bf8e5fcc5ff7181e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adf50c47a47f0f0f0b79dd58ffade9919cddebea
Message-Id: <178845722548.3905140.4140260436433565300.pr-tracker-bot@kernel.org>
Date: Thu, 03 Sep 2026 17:40:25 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Sep 2026 19:07:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adf50c47a47f0f0f0b79dd58ffade9919cddebea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
