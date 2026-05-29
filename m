Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B823AD520;
	Fri, 29 May 2026 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098046; cv=none; b=mDFkOkkd5PFZ2GAowfLM9z0utxoIDJcv9LMRPk7viiuubZrpnU1KydTMhpHoH9pxL7FsQhmPReCISAWHGJV5DXK1ur7Imq0u6l/qOqR1nvPhnkw51dODdQGTFvw/SlztkaT8gEgmq3W7iSIODapXb7kE8kE4iwLS1j09xEICzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098046; c=relaxed/simple;
	bh=uIrRoliMqghjpiwf9gO9dxeMlKJOWyJHsBKC/UvO270=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hCeOwUsyueOahxZTBcRi6ZsDzf33m3jJrZItfzTPn5pUK0ogEZB5l8ASOYTxGoPBaQfdX4qcwGx6nK3TFmYKvX2RcG+PTiBL9TxwvnnWBCGzVex/HzGpm62GGjAZNuaO2U/5qMpugV2lFquKjHGhgXsqzBpm8ZybmCTVasGnOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaC8/Edi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaC8/Edi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAEF1F00898;
	Fri, 29 May 2026 23:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098043;
	bh=d2GQgmvAzbjslPjATttt96zPINX47ueFAswKjoDtw+E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BaC8/Edik0Wi5JjgxhTX6h9mStWr1GxZoy9StZxucsx8taW7YartvRKUbw5xgOxww
	 ByZfTJyPK4swaFtAQUBIiv56mpedaLVXTQqkt2dOI/72SG7E9VSa2KYZzgN258S4L4
	 CT2HHkiCDNsGLfsVcXb4fePJDm+Ac7LituNCgpv0p9xhPgpOUljdgCol0iSM/04ulA
	 uFb9LXVTrU2tX3WzH0GS0j65BD/LDV8SWctaPT/C1cYo+jg7wcIG6RRXC9+1jJoLhx
	 X57Z4WZGDssAGbTTtlp26Yu8QwhWXgYl+56InEbMy4KTqAt4zdubLncgZcjLaDy6zP
	 vaB7G5g+6NuDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199CE39301A3;
	Fri, 29 May 2026 23:40:48 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.1-rc6 (part 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260529210255.4017083-1-kuba@kernel.org>
References: <20260529210255.4017083-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260529210255.4017083-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc6-2
X-PR-Tracked-Commit-Id: 78ef59e7a6459b16f8102e0ee1c718443323d1af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3be0c984ecbcb82b0bec408022c4ef738cb3843
Message-Id: <178009804667.2001479.10813643709714658119.pr-tracker-bot@kernel.org>
Date: Fri, 29 May 2026 23:40:46 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 May 2026 14:02:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.1-rc6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3be0c984ecbcb82b0bec408022c4ef738cb3843

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
