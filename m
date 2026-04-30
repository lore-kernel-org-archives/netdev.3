Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B929CE1
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582855; cv=none; b=gESrHaopeDpTzVM/mpua60+RTBmY/mF/OxL1qGVXOTBXqtSbruDw+6AZg70qLN5497cnwc3nPJJso8xbMXznqMrarkSxSfWx9fdO4Xbxzfu9vUNq2dwvqDd5XX8UNPzaMYz29tnjnvCw1TWnjNmxcclD17siBWrlR6DRJ3uG1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582855; c=relaxed/simple;
	bh=APeY7f/g4A8CtFSDbzef/BTrZwJE4NxcTnHlix3ipIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b7N7ncsWLeBmaBOjYueHcD/L4zdjv36B2kUsnrXv+hrvE5UZdatnQwpLCk0NxB8U4OuWTi6/cC5yJpg2y5R2Vq1hQOAktWUAV1FCii57consIUOtvi6l5CLdG5R0208CwaQ76Wsq3s5uJEZYUJj7+YWUpUfSvSxqGHqW3FY/FQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwP7nToZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwP7nToZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F020C2BCB3;
	Thu, 30 Apr 2026 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777582855;
	bh=APeY7f/g4A8CtFSDbzef/BTrZwJE4NxcTnHlix3ipIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CwP7nToZyhKSC96Lo1ZLjYqZUnQRtzYRpIFVksOQ4K/OfkHvi3CfSNLvOoL4m1dz7
	 L17BQ4qALWAPb/Y/y68pjRgR3m1f0AFoDazANScu3iLGPEmbVLxzazvU0jqGXZMXQz
	 S4MavGFsypFWFfvppC4EJkNAlfS6GfE/lSC6doQ+RFaLYRtK13jICZbOYYQUrN3eGH
	 VC/c22U2VzT9eWK+pfkKkoaqMBYjNBvKRMCzIwfVHB1+fnHeX4wxpVMUOoF4twTu14
	 em59mNkv6/c7ZwhQe6GwqsoNJoZpUwrodAJXSdOqQJ7Xn9zROLMGzgYS6rK/SGbmuN
	 Vh/IJGVVLyuOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9D380AA7D;
	Thu, 30 Apr 2026 21:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: mctp: test: minor kunit test fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177758280955.3201582.307308430080438516.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 21:00:09 +0000
References: 
 <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
In-Reply-To: 
 <20260429-dev-mctp-test-fixes-v1-0-1127b7425809@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 oliver.sang@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 16:21:40 +0800 you wrote:
> This series provides two fixes in the MCTP kunit tests - one exposed by
> ktr, and one found while debugging the former on different VM configs.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
> Jeremy Kerr (2):
>       net: mctp: test: use a zeroed struct sockaddr_mctp
>       net: mctp: test: Use dev_direct_xmit for TX to our test device
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: mctp: test: use a zeroed struct sockaddr_mctp
    https://git.kernel.org/netdev/net/c/18ed60e33e6c
  - [net,2/2] net: mctp: test: Use dev_direct_xmit for TX to our test device
    https://git.kernel.org/netdev/net/c/768729710641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


