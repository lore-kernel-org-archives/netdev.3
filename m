Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824153FD5A;
	Thu, 15 Oct 2026 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077785; cv=none; b=BXgxML/1z69zcCI1O2xseJYh4DJVwBdJXIbJKFodg9DOGhAet++UIdQFfpvrNcMGjgfvJxEx5Bg3GLwFkP3/mq4xUxJ+PnRE5PWqehRNYj5LUyj4zs6kPPl70DVXPRKb3VvLbWAL64g/VC+EbjgokxPu1byl8jrVPt6Qcz82z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077785; c=relaxed/simple;
	bh=pBVIUhqWcaZfPcq5z/rpMLtbodmcs1yW4/aInBEFpxU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fm4CF+9/VwgKtU46v5jUk4JnGapNgCe0VoxFl4kBpW9dvxNzoIVbN4tufENIKAbhs6i0tfrK5yp0CeNUxauTwwEynysvZdFVQTYD4oCqadGObHTH3GCQbfg+1ViH5WDXd8vWz3pil3tWXPqqkr5o8vCgfwCJIPHgkzFmtfJ87TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN3t7+40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mN3t7+40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E0B1F000C4;
	Thu, 15 Oct 2026 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077777;
	bh=uJXIiF8prnALe94Y+5cz/F5pbW16tata7wadQKRqYnk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=mN3t7+40h16hYrfupBzonJnvQDLQLiDubNZ8eRqsCORCJH2z38rP3wfcJqMHDwfpC
	 qGJtFqiqWFkYeaWxIEUeqbnRwPMQNSf2l5UvOs5HLCZbHFqfx+klCjD/dRMlPlkb+K
	 Cm3ZELkQt3DpGge5B6ecdXU33CE6WqpLNd1fDRypb69SR1mys1SCiAcvLjwyBHGllO
	 XfWz3w2s+GoqTDAsiKKQNrKh2NZ5ameFTCnfOu27CmiPsW9uv70ETVCBowITbF7zvC
	 amuQLd63At+PC4yvtpaGtz9Kks2UcsyataZyFEqG8NHwbJTUsKKRiDweeMR//HVZk2
	 +Vm32xLzsRKiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3C2392EB21;
	Thu, 15 Oct 2026 15:22:57 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261015140051.105229-1-pabeni@redhat.com>
References: <20261015140051.105229-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261015140051.105229-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc8
X-PR-Tracked-Commit-Id: aa07285705f8d5bac464eb1c5b7412f8e88b91e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 045958acaa75205b31578cb22c4345e28dd2e4bf
Message-Id: <179207777577.3502468.11718910943020250395.pr-tracker-bot@kernel.org>
Date: Thu, 15 Oct 2026 15:22:55 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 15 Oct 2026 16:00:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/045958acaa75205b31578cb22c4345e28dd2e4bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
