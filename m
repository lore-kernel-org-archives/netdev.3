Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA23E3C53;
	Thu, 23 Jul 2026 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837571; cv=none; b=hUzkQQnzrTHGkSAxqoAuXLBlr94MWw4oAk6WLrZiIrc9hADcZrV6aQK4hPzVcydDgzP9hQ47B1BvNjp5wltrTOKtDfjo1+ttByP0KTGj2RBeyRaoSudZtU8RK2GL23Bx7uRsIngvvVkBgnNZDnO5COBikzb/aWuiiZPbqA81tLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837571; c=relaxed/simple;
	bh=kuAZqwl0pM8MrwWfVDDgFdZuiUQJfeHGB71iH9mEo6Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DBJ02NavzWh6X2f8YXKrdUG7PWfvkyvzCI3diNDJKv3q4bto7cozoZ7q3D/A46Tzd9aSW4ZKAPk4OG95yvvYzhwjkQq5gyO7SUfq8VHmFGLVvLmtxS4QXpBd4hno21lqFy/mf01crsecCRjfVmHwDOz1Z2jL4liCPXhZ0sVaSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxs2TFH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxs2TFH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6984F1F000E9;
	Thu, 23 Jul 2026 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784837569;
	bh=2GBvSMOUtjKXjoMS4L8etP7mk10jP7qqmSANrz3A/o0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Wxs2TFH26PeYJDN4PWPaJZaTAJ+144+aJN4ZsBNSW0fAFSOnAySOXwGjey7mHma1I
	 4x8rfqIhlwEOmBB9EwqlLzfwzHRsZkFoFnJ5/OvPt7sLcCWa5foN1itR+bobHrzBg7
	 KbLW03tnfugLrh28Uo5zWpenk/Fs9LEKIBhgiNqRLXFUOQ/ZUseMKXb91YKRJOo4TP
	 shbCFxnCfVqo68I+XX26kU7r7ZHl8Cm5O7tKluq/EUl5dZh0ZlmYFqKSsEl4EDRWhH
	 t/s8DlQRZWz4TiKyENjdkDh5qNDN7Q+kYRYClZ0L6vJFLjzHYN0h+ROs58X1+eksz8
	 3bgb6ATjFHl6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C1B3924A14;
	Thu, 23 Jul 2026 20:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260723185040.3891350-1-kuba@kernel.org>
References: <20260723185040.3891350-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260723185040.3891350-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc5
X-PR-Tracked-Commit-Id: 6a8da869fa338e008533dd6385a0eb35dee6acf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d326f83e819c53aa05c40d64f5805d6237b6aa1b
Message-Id: <178483753733.2853857.12569721122845078705.pr-tracker-bot@kernel.org>
Date: Thu, 23 Jul 2026 20:12:17 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Jul 2026 11:50:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d326f83e819c53aa05c40d64f5805d6237b6aa1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
