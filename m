Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA7C47DD78
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074790; cv=none; b=IgqzE5dniNL2QrDu9vH+J9kyKs15YkOxGZ1+tkXT80Wf6SvzsRhY21AAWsS+5ZNzgExUpPXbUIEKVeBcxTsDwy0RWnZusETcFrWuajkiPgU1K9zWu1cNVMFlrs3shfBYO9N+K8FKJ/m1wASPpm/a1VwDN5V2O7aKLYvJr3HvnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074790; c=relaxed/simple;
	bh=5BOyvCM0OFih/JmAjyRJbSHPJjH2i/DEaeW61p0UElo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ik3ssfefw7oRZlpfpPrcQobUEy0mWM7UoQz2yaIwrKZGpTMnniCB9B8qshHKgG054Yzqdd86NXC2KusrB2tzm9PkbwEjxUqnpVS2qFEaqsyS3Ico/xiqgoRxLTku6Nkd76jfiiCmkcPfeiMlXdDcecrPoWloiQ10BpZONqrRToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyEwLMA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyEwLMA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB461F000E9;
	Tue, 18 Aug 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787074789;
	bh=lLDxULaxSINaqeC8QkNpAMrN8u0DtwBpFTQTXeoQ+ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IyEwLMA8UqWxotK3chyxluGfzZmLNWHoQX6NYp/bkl4OGvmsGw21iRbKLsU7ghnpG
	 DHUuuySeFyAY9gKbGTYhFxakwFa6mcRgDdCsMKkKEbgbgOT3JS+t9Igdmi3Xr8RA3U
	 s+cqXdOit6s5BT7p10hwH5D4eCL3lsR+tDELgXutxAzu1RXu+Ykj2Bu2jsQcOXpHZX
	 vLNqHutUkAO9HgT4xezRAzYf1FqzNqGxbZvLW/aGJRg53aPKKe0ewyKWyDv1PWxGrp
	 wvKfqu8/a4YaqJ14mTNRFIgQBfomGdoSAxAe9IoSRKU721prxQzThNeedamR3J5fSs
	 +HupLtYP84Rng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB43927043;
	Tue, 18 Aug 2026 17:39:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: add missing ref_tracker_dir_exit() to
 alloc_netdev_mqs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707474055.2194892.15611955237323709521.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 17:39:00 +0000
References: <b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08@I-love.SAKURA.ne.jp>
In-Reply-To: <b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 15:50:13 +0900 you wrote:
> sashiko is reporting that trying to read /sys/kernel/debug/ref_tracker/*
> causes use-afer-free crash when either alloc_percpu() or dev_addr_init()
> in alloc_netdev_mqs() failed, for commit 4d92b95ff2f9 ("net: add net device
> refcount tracker infrastructure") added ref_tracker_dir_exit() to only
> free_netdev() path.
> 
> Reported-by: sashiko.dev (no mail address)
> Closes: https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e513e%40I-love.SAKURA.ne.jp
> Fixes: 4d92b95ff2f9 ("net: add net device refcount tracker infrastructure")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> [...]

Here is the summary with links:
  - net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()
    https://git.kernel.org/netdev/net/c/0b1c2af8a22c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


