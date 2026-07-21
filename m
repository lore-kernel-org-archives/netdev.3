Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DADC3B9DA8;
	Tue, 21 Jul 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628037; cv=none; b=gyxDnQZmGLu0R+5LFaB/qGROEMCjI9DnMkZdmE4py2bP4WX9fOyewn3gYlUVQ6ulLvB9lC5EV5ZzCjjatOqUMSipA5WWAm6O3I0oQ/8jLtiRCGdEVjoyL/BxAynx3IslhisbiJ4oPoQ1Jjq3ipI3+IIPKW+IxjLi+G6m+phZw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628037; c=relaxed/simple;
	bh=c2hQBA71OGLLxM613n5dImMpDiZ6Q6md9S865VT48kU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=shIET1LpFxp4UNV1V05RyqYL5i91SsN9f0Trc5s5gSDAc3x/dfpiMfCkkjMiIX56QzNLwefh2wKKsa3RG+nfPSRzJ+V6U2E5hkAxF5lsXRJGkkGoK6zpRLQ3fGwUIJq8I2DQUse6saDMqZd7TvLNGHU3MtEol+l6UdSodD7Ews0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr6uPvvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr6uPvvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AB11F000E9;
	Tue, 21 Jul 2026 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628036;
	bh=6Bbtpm4dOiGzKSFVHH+iv47HOvPnWJHDX95dijvj01c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dr6uPvvqZXg0+LgVlBdTULpITfFOfMq1rPaEAR/SCFWPFlIrf2VWjer5tou/pJ988
	 4Yg/eGRpGfNXH2RuzHnKtJaKx6HmBC/8bbHNvSDzvTMgFsWUtpfL4pqk4g5Lok55hN
	 Xw2Oekv0BdTj2khsg4xNnMyXdCamrOcInLl3ylWUHcEYRU5C83jy+6n9YbptY7NkSQ
	 j0Yfl+UMMs51Z0f2LYqhDYQe6Xf3t/rCazZ8kB2YixVewRViMaT0vYLHvhoVC+VRGf
	 +wXWKARtyyeG9GrNt+NSipys3C744YIoVSjPwaKXi2U7DFwrx/ppVtNFQNsqUZpRK6
	 aqhz0zKbhCstw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BEC3924A5D;
	Tue, 21 Jul 2026 10:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] rxrpc: fix io_thread race in
 rxrpc_wake_up_io_thread()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462800591.197248.10517907642301650885.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 10:00:05 +0000
References: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, luoxuanqiang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 17:35:34 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> rxrpc_wake_up_io_thread() checks local->io_thread before waking it, but
> then reloads the pointer for wake_up_process().
> 
> local->io_thread is cleared with WRITE_ONCE() when the I/O thread exits, so
> the second load can see NULL even if the first load did not.
> 
> [...]

Here is the summary with links:
  - [net,v1] rxrpc: fix io_thread race in rxrpc_wake_up_io_thread()
    https://git.kernel.org/netdev/net/c/745fb794c3e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


