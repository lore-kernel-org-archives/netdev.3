Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22F31ED7C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483007; cv=none; b=cbST8JU8qY9pRVjk3pQQiv4llUXdmuy1+DnvI6DXBqEeSKlishyLJ/GGKqmcnXtzhwB0Xzrjfl2RPr3h7csN3rUCwIzdhl5K9ocd3AGSGCrdOOOxakJ6YlvBBjEaoLuTX9eH+yd6WwWSnvbcHFhkc7Lc5vzyVt5yLdppPH5tPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483007; c=relaxed/simple;
	bh=JqkPzmSqvPXyMmdfswqE6h8ZoNjuVGK8reHt/ohUuC0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uMIVf3EcAf0syB9qe96bu4CQAkZf5dibbnlArtRE7/Y0n0hD52TzqyAw2XzI1PiayWGn757XYi38MhJITUAV7YkdLMAusqzskeBeds8xGgoVldj3QmUmmVpCb6Cx/w+UIlLgJoEpIA2Okou4mffxfT25WulmQhDzdRmVJyZPlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQbEarJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQbEarJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812381F000FF;
	Thu,  8 Oct 2026 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791483006;
	bh=lpzka9QE+YcqJuN7pAn4MeV+vXOz4vFLQb+oDkApE3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nQbEarJ6RhBS/iYAAhV0yYaG9aIENd84+1OPSKgzBJ2+LFJ7t2FHb9LvZKJGFH6W5
	 rEVts1R4IlkK1oTAc8M6I11EciG4ZMvi2dCS9e3sMhB9DOM6Kuu2bYa1i4L450MgXp
	 0fEVcBDUTHEKKatC39RDkykGxfLAjZpvQYGWV4T3Eno2wF0k9eOhneUl+creSP8TW5
	 BTcwYj/6YGKD21BcYdlCEHwHBix/Z9kOhpkrmt6FJWKcjBIkhLjttGhvJ3uFu2BDho
	 6PzWRJ9MgVTByicT3ZW90B9JbuF6mRR8z+C378kvYYyfjh6tMuC0nB2Y2rF3ywEWED
	 eAcPeleBc5ifg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775A2380CEC8;
	Thu,  8 Oct 2026 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: gro_cells: prevent enabling threaded NAPI on
 gro_cells
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148300528.376744.13933815444451373396.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:10:05 +0000
References: <20261006235113.2394030-1-namangulati@google.com>
In-Reply-To: <20261006235113.2394030-1-namangulati@google.com>
To: Naman Gulati <namangulati@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 kuniyu@google.com, syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Oct 2026 23:51:13 +0000 you wrote:
> gro_cells allocates a per-CPU struct gro_cell with per-CPU queues
> (cell->napi_skbs), per-CPU local_lock_t (cell->bh_lock), and per-CPU
> napi_struct (cell->napi). On !CONFIG_PREEMPT_RT, local_lock_t only
> provides lockdep annotation (and is a complete no-op when
> CONFIG_DEBUG_LOCK_ALLOC is disabled), relying on per-CPU locality and
> disabled BH context for mutual exclusion; it does not provide cross-CPU
> synchronization.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: gro_cells: prevent enabling threaded NAPI on gro_cells
    https://git.kernel.org/netdev/net-next/c/4e3b56eb2ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


