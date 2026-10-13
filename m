Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4152941E;
	Tue, 13 Oct 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897608; cv=none; b=P83006AOWen2N59jchrEQ5pzp400UW2Xg2S7PJY1Ny+P2Hj+RQYMk9wUWxbhiQwfvitHDrqhkQGBvlhsq+Hvop7x5g+1KISTCPVmfVujlWrt+4hFjRXp+00MibgvsTpB9GtoJ3cVH1RqIzDZPp2KENZyFa8kudGtxC8TvLkoH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897608; c=relaxed/simple;
	bh=oP72pkNcenblHYZhQP0W2BNmcgZDTYYIoH0Q/VDHW/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O8/vv/SNp3SYOdGr29IOcuwKxucNas8gyQ0zjBka0RA9ub8z44dIbie0SY6219kCR40RCsbrprBRYVZUDWE0SJWvNYV4N4L+FQpnNcwCvPbJwKVWFiKwBDrdfzcx4h1X74KJgKkC4I0FOW+P0GharT7299s5Up2p9jQXo9n0Ho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0aPJZhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0aPJZhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A61F00898;
	Tue, 13 Oct 2026 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897606;
	bh=ajIPuC++/ABt+Z/kwxEadY4ibt019HfiO4SW7/tQ+UM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P0aPJZhcsMY9LzvNBIMWP3vM4BUUcqNB3bK5Obk5RkYcnuotJGDHNKejOiwUMvT/f
	 a0x8JV1rcUlJtozW+aZWTKNetGfxmRChqcLs1wt0HzP386792mlE8abDdRS8noo17Q
	 Auhl4Auh7whmJgG2C8JTEYU12RKAwc+IyNIzdV08QSRZY5HvaCBFiaWjFquqEl19vV
	 HHfnGa7Sxmg7KFIQrvi+uIsrsfLcyr6fI3PJTBDJNQiHic6luZPUVoQ1NPTPtf31pv
	 pkbjE6GOY2QlkJQh8Zsz/hrpZ4faFZZ7ZhZ1q0z9L0wPu49P4ne/DoZ7F3pHod6YKx
	 FGNUM+44oev+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B46103927077;
	Tue, 13 Oct 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] tcp: fix a few divide-by-zero in
 congestion
 control modules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179189760552.298737.6237021795108605987.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 13:20:05 +0000
References: <20261008092641.140777-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261008092641.140777-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stephen@networkplumber.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Oct 2026 17:26:33 +0800 you wrote:
> Patch 1 and 2 were reported by VEGA <vega@nebusec.ai>.
> 
> Patch 3 was found while reviewing the other TCP congestion control
> modules for the same kind of divide-by-zero on module parameters.
> 
> Target net-next since it is not a big problem.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] tcp_bic: fix divide by zero on max_increment == 0
    https://git.kernel.org/netdev/net-next/c/8edbf6c23363
  - [net-next,v3,2/3] tcp_hybla: fix divide by zero on rtt0 == 0
    https://git.kernel.org/netdev/net-next/c/f09eb97322b1
  - [net-next,v3,3/3] tcp_cubic: fix divide by zero and endless loop on bad module params
    https://git.kernel.org/netdev/net-next/c/7d52b5d16afc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


