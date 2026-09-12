Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646474BEE3E
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171869; cv=none; b=FriJb+9jFN+RVTguvqPEzhqh0l7KhX+4doy3Eog40Rl6PheF7Zlchth/YvX2i889odjkPK7651Dm3d4bSbaDV5/tJWxXtmtL2fbZoKaKkbIvkWXbgp5icyOPbyvJ1yJx/6VjLF3f5h9HeAfVD0ecxYKmpB1HO11IiGcF8UIuZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171869; c=relaxed/simple;
	bh=X52aEyAf7tzf7eY0O5F9T4wuY22AcbZ9lxp1zazdyj0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WXrmwqASqsegGAGnsfhpgiApeV83P05BKMUV8ygHdXmsr3VXKLrPo0nMUQSjrUyNyfzlgqwAtRxrC82n7FpyDqQlcVMRo1Fe6AhIjm1rNtgHjQkOMLXzO9Tz+6pzjwMxYaz8AATtIYT7yKmH8dn/1lUysfPfY1ccrvqgm5CSVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjv7vrvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjv7vrvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13FD1F000FF;
	Sat, 12 Sep 2026 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789171868;
	bh=mqCwzd0QO/WpUcJvPbQz4XDqDZGkg8fZ64EdfLeF470=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mjv7vrvAjYiU7DZ8Kmn1TLCkCeZAfMfFkV9PyTSy3WHcflNLbVlWEJZdPuydU6o7S
	 cAuStpwSNKXzB6XdGYA4h8vomC01z/vaqEAt0zNdfdwA7PT9ijkkcoAGWF5s2IasJf
	 wal8SsqbjQLfKj9J1mmNK3Fp0wxa8xr3Kya5WoKxQXl9DbAQQD2T8YVihfwIZJ/Ztf
	 2VZzPbF3Ho6OK7maXt48GTBPFD7p07XyP13/OuPvqOjknz62AJdJ+x3/rlojjwVRas
	 2VEe8+TQHCnPbxYO0pQEn+9F8siemX9uSbR8UOol/T1DTuyXBdLje4EsFIWL4Tc8jF
	 V5UL3XTEf1h7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D70392445B;
	Sat, 12 Sep 2026 00:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: Make Rx completion coalescing
 configurable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178917180464.3171352.16867293381980871719.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 00:10:04 +0000
References: <20260909211111.1795726-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260909211111.1795726-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mike.marciniszyn@gmail.com, lee@trager.us, jacob.e.keller@intel.com,
 leitao@debian.org, vadim.fedorenko@linux.dev, daskald@meta.com,
 bobbyeshleman@meta.com, asml.silence@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 14:11:11 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> The Rx completion queue writeback coalescing window controls how long
> the queue manager may defer writing completions to host memory.
> 
> Expose this window through the standard rx-cqe-nsecs ethtool
> parameter. Preserve the existing 2000 ns default and accept values
> from 1000 ns through the device maximum (~109 us).
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: Make Rx completion coalescing configurable
    https://git.kernel.org/netdev/net-next/c/c0aca269ec07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


