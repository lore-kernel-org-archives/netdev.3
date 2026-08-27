Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B6370ACE;
	Thu, 27 Aug 2026 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865311; cv=none; b=eVy5YGS49hmnwEuy3AE9PfKB8Wh1a1x6XrlC0v4Xw58nXogta92OJzX5i2jzZlovN5V01UJL7w4oUz7PShaFchWA1WDL8fJJPnQFk1QDnkRcXahYL95dJ0ZpnxfotzsWFBHMi4s3J8hfbbSwfiVocFSM7F1DgQK3dcSbWUczXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865311; c=relaxed/simple;
	bh=bnuYzXISx5hbhXzBdSbmBKYin0x8SLA1elIXkcONKQk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H+2WYJC2J3rziAL7GvcQevR/p9GyGCFyr3hIaCx0woepgGDApkKVwzYFYfyRsZv8kgTjsSi5ajQrw6Oo5vOb1tfCzHJxosembPCD9EKkPxZv9NQwBQXGuHCxsOOhUFXcEt+Y4lf8AkxNf/VNOcSZ3gbAi79uhQSPwqrYJFErEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJvi5yrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJvi5yrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A71F000E9;
	Thu, 27 Aug 2026 21:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787865310;
	bh=1rSZaJWPhzFQBD1gNuXTbgMgUKNEMNt13YZEq5B1UGQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=KJvi5yrGG/eeGPgNO62MajU5Ibezt0sMnylruE1P1bO+Kzgr8omquI03dXz0BfM2V
	 uXDq5o/VYzW8tAVHgvLMF4cTeTCDupzNo7XecY3DgeHJx0JHyjL3BqDTDB0jzUA3Vr
	 su8Ju3Vmjaceki8F3epQR9+mLaWbXPTeM3nyTt1cQyZ3AcuD3W+nmEv00olNd4U89V
	 uDIJMhoRbs3Vl4ADMaUjPw/WSgvt7AWTRmqSc3ArSKGOFPeXjSSS7JATgPxtzPardl
	 El9UxL0xTc7N8mYbrXwtCGnEXJuyRo4JSgi8k0+ETtgwwvxrmQOAgZBdrauQXuN9iw
	 4QmlGBJRPBUow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B453809A8D;
	Thu, 27 Aug 2026 21:14:16 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260827205133.1242124-1-kuba@kernel.org>
References: <20260827205133.1242124-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260827205133.1242124-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc1
X-PR-Tracked-Commit-Id: 4a9d62a8774f130a5b8de26ca9f415e6050a9d51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b78070aaef63512688aebfbc82365ef9d6660f1
Message-Id: <178786525515.1850666.17347770825528315703.pr-tracker-bot@kernel.org>
Date: Thu, 27 Aug 2026 21:14:15 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Aug 2026 13:51:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b78070aaef63512688aebfbc82365ef9d6660f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
