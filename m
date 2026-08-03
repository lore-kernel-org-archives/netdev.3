Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB42423E9C;
	Mon,  3 Aug 2026 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792650; cv=none; b=Co7o5ZPixCbrmK4Xx5csJ8y37mcuLCtfKzcJ03jA61H+eWqioAbtRrELXIcW0fqz7jr36BhNT5k0Hkzd4fcd4NJ/cRrQU4HYodF5bvyxtdu4uSBN6nRtFwAYvABdKfn3EJjVQAwERGuQEGX4JL+pPhrgtbhz/mU8PQSaWWl0rf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792650; c=relaxed/simple;
	bh=wuM9EbhhJiB2G0uMaPtnh2/u+AVs9EjVNy4obLz+BEU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ufWO9Kto0Qd2Wlk7il2msd9HDqNBeKTaSbeMshYCmDzxnG7KEhC/5m1ARMyiWxP59YHn7LCxSIUo0Iqe9YIomWx0m1bw/1Ax9tjuwmcuYxUuoxO+CdHpwShtHFRl1N/wH2w5JLK0BXCycXzpf9C7WparJHe6uG6okYEN5+2/k90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGegQlIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGegQlIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D7A1F000E9;
	Mon,  3 Aug 2026 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785792649;
	bh=TjcFIulPITLUnZ+fgXtOJI2vu9hxdAtgbHciEIOhdUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EGegQlIPV4BvmMWZ7KanbAcmqqSgta9c97bBC5DptDB7kfOAGXFoQwfqMalljEau+
	 2f9YHvnwudJzpmEK/FCxiGUBcTCx7nwbCT9bYAF/qfOmXdIFrwEIY3bZ2eCeiKK/rb
	 UQf5GLl5OlMhI92hKDcOJD2+A7GOk75WDk+6bnkrLnkeU73uxoWTWYbArvMeKD5Pr/
	 hQnFmNHPHrXdWZHDf5RmJO8ZZg3abjYNPI/sRzJJd0cNOB389OnCy26R0Lc35Ls3fj
	 GEPPPY07IVvYHQg+LAf0WG0JrsUpvcPqJYgMdnbtYQ/hErwMNuq6SMVw4o1OZPKnmy
	 sTIBN5YP7fK/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C83924461;
	Mon,  3 Aug 2026 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: do not change rcv_ssthresh in
 tcp_measure_rcv_mss()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178579261039.2840566.9155529941452764214.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 21:30:10 +0000
References: <20260725030806.28135-1-zcgao@amazon.com>
In-Reply-To: <20260725030806.28135-1-zcgao@amazon.com>
To: Nathan Gao <zcgao@amazon.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 20:08:06 -0700 you wrote:
> Commit f5da7c45188e ("tcp: adjust rcvq_space after updating scaling
> ratio") replaced the direct window_clamp update in tcp_measure_rcv_mss()
> with a call to tcp_set_window_clamp(), a helper that implements the
> TCP_WINDOW_CLAMP setsockopt. As a side effect, the helper also shrinks
> rcv_ssthresh via __tcp_adjust_rcv_ssthresh().
> 
> As a result, each scaling_ratio decrease detected by
> tcp_measure_rcv_mss() also cuts rcv_ssthresh. Elsewhere in TCP,
> rcv_ssthresh is usually cut under memory pressure and grows via
> tcp_grow_window().
> 
> [...]

Here is the summary with links:
  - [net] tcp: do not change rcv_ssthresh in tcp_measure_rcv_mss()
    https://git.kernel.org/netdev/net/c/0e125ecfe20c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


