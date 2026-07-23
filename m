Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41343B4AA;
	Thu, 23 Jul 2026 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815869; cv=none; b=P5Bbp9W0mOKEq2nA87SBh1XnRptdR/CVQGNCPkR+1HEknxKZJaIiM7T9+4mN2URhTw+zj27nBrbN1Y/Ds4JMgwY9yypYms7ttEF1Fjiz0urh56eKsmpou1fzuSlud88Ic/8qYM7Jz05ICYD7tu/rqnqHJ8FpWtCv5SAPM/yfFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815869; c=relaxed/simple;
	bh=R3pEaAJtUwmYupU52QnnVy4Wvf5JpVunq2L85p2pxoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JUyx/ZLEOtZi/rS9pAK47PTZBnJavaiVFdNEMNZt6DkpQn+ESz6BEKxGV5xfO0FOYcKWpgVEthqvzPaqEfBIbIhauI8MJ5sFVhjxwiayIED65r0jFxeugLrycCFJTYt0GtdPZVrmb2yy/0D9WJLdicGHn8XCQEUeJ0fx1EhdNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aApV6u5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aApV6u5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9A31F00A3E;
	Thu, 23 Jul 2026 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815854;
	bh=3riE/ajomt3CGK+Se9WbeN2YhpFRhYDpQ3hzVmZIF2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aApV6u5WYUO2Fd6WBXewVlY3rx6VGN4EYXtBi+JXLXGivhriQUqxOHAmlJtsoCLAI
	 eRofBzxTANP9heAt+1OkM+byCU4G1RfOw/bZnrWoqFQmBzErHiu/jv8rWQvkSdgvu8
	 tpNENSXlFbNWaxFBYnkaeUhQH2Z1CcVh61ea7QvigtOPYCGuuaymAbmqMkX6wR3uFF
	 DKh8mP0ewplAohq5setNB3CjwAPXF0jKFYwdJ0pSIGakmUmVfvkfM7YyYV6IWDmatX
	 wshDEKQiNTycUqQspkeTGmK4X9rI7Y8zT/JE7Bc//vAMXx9TutpYUkJgYWcixt5oVF
	 NCeRHquJGzR6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5693F380CFD4;
	Thu, 23 Jul 2026 14:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ppp: annotate data races in ppp_generic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481582189.2248593.7721284529663157759.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:21 +0000
References: <20260722101605.2868548-1-edumazet@google.com>
In-Reply-To: <20260722101605.2868548-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 qingfang.deng@linux.dev, linux-ppp@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 10:16:05 +0000 you wrote:
> Several fields in struct ppp can be read or updated concurrently
> from multiple CPUs without synchronization, causing data races:
> 
> 1. ppp->mru is read concurrently in ppp_receive_nonmp_frame() while
>    being updated via PPPIOCSMRU ioctl. Protect ppp->mru updates in
>    PPPIOCSMRU with ppp_recv_lock(ppp).
> 
> [...]

Here is the summary with links:
  - [net] ppp: annotate data races in ppp_generic
    https://git.kernel.org/netdev/net/c/543adf072165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


