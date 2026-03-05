Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6083BA24F;
	Thu,  5 Mar 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739788; cv=none; b=suvp7p9gg+v0pMU5SNKz8OTR+wvrxBjj7yNoDt3q+vUz8aTBUZU7nbt5U1D1IdLVVDyMTMvckZiiCcKHE4t94eQ855NomGTC++pZeCYo4NO1EhRIYkA0oYibxQRGXtVXRlDhT1UMRWSwFnrvfj+SbPtkFuFv4t2mwLWpbG473Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739788; c=relaxed/simple;
	bh=xaxI9wXyhK2uB0sI28ov4lSZimgICF4vdaoKi1ZfTjw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JRPVVnEr89ASoqJQXUL5PnMYUwnugXgc18awR9mJJxuVMcr8hErBQ2xzy039xVm8Zrx4z1z4opZ7x6Mfma6HE9ZcWHKDq7aE8yzYO+27gEvnE/akDlxVxx5OTFLKl2sDb70mC2FWhQAVn2RoTgQFLKy7fNBoMrU1f7+4H4Sgkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHbNt0A0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHbNt0A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE2C116C6;
	Thu,  5 Mar 2026 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739788;
	bh=xaxI9wXyhK2uB0sI28ov4lSZimgICF4vdaoKi1ZfTjw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gHbNt0A0ZvH3jMfkQHNFvR8SE8IlJn1XbDZP6UgfRbTXzoFsdC8vIqfHtV/e0nY7C
	 AGETwjy7QMNHjaCiKllHaxeH0x17XdV1fZi9v/5FTN2L15VUe8aI60cf2aEP8wjPKW
	 Ryu335Bt8mDlbYu+DwmhD+AT4upqKg7KGgOPplcqvJ2vdwAnzuOlTFA+yJL6ELvHiq
	 j+Pi93vW7n35xaJIOqqGcjk7Zakcs0IJzSCyd+GKo6hCtBtKfqRUwDxL40zcGhu4gf
	 /I25l5ext8/uQrf0KVssFa0VtgwNuZiBRX368P0z1jyrLKlr2CHy1A0DjqGq1SlmJW
	 W8bVprDwvQLwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4003B3808200;
	Thu,  5 Mar 2026 19:43:09 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260305171004.322683-1-kuba@kernel.org>
References: <20260305171004.322683-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260305171004.322683-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc3
X-PR-Tracked-Commit-Id: cf440e5b40649d1ffbc6c4e33fef3223c7482897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abacaf559950eec0d99d37ff6b92049409af5943
Message-Id: <177273978772.3262774.812824881655316861.pr-tracker-bot@kernel.org>
Date: Thu, 05 Mar 2026 19:43:07 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Mar 2026 09:10:04 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abacaf559950eec0d99d37ff6b92049409af5943

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
