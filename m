Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75931A9FAF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524829; cv=none; b=F2ecI+mLCf05ZQMlnE+MUbIcrNTtzK1BJ61doQuv3Jve35Ml5j/CM3zM9ZlVbsYOIR8iYVsTy4eRVPaJ8FaB+LrG17MCSUdc7f+zJfD/3gRNrsxPmSdSHtNWTugi1qrNUovI97QPvblsE3Nr6jnIjegHSf5G1LKQ1JbQY4yj/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524829; c=relaxed/simple;
	bh=5xuAXG5/CDmSgHqJ25JDLvkv3EFCewW2mig86x9U5As=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SZjXfthg+O2pC1vU/x0hJSM6J7kMlBeS7CPZK+RL8DwAbUJJEhz2Y94ixQ9WswmKFSebmPnGM5HN1kJP2+Cb7fHP8Kkr3Aw8uMr/g2CbCPv6O0oXj0cJLyi6XS0pzlNegTHrrHr9jgTdAMr2vbFOcb3Za2Bczn1hIKUW/913fG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+h9B8pu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+h9B8pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F849C4CEF7;
	Tue,  7 Apr 2026 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524829;
	bh=5xuAXG5/CDmSgHqJ25JDLvkv3EFCewW2mig86x9U5As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+h9B8pu3EKTb+MmlIkihMUL0QaDwBcSvS/PjWkD3y1bCay5DYOZ8ZwIh8gtfheE8
	 vEcWLCrBWQNkyPE+dGVdeVphQIEVxZHpfDPw/gS+a3hZ2MgkS8ntwHI//iKs6WtQkR
	 Ep2S/EvHYcw5tNb62EhAkejCbULO01GU/u56fEv1zXrjsoWmvvAShtUBnx++1eRjxw
	 cKwOyyDGpbsLcAuwP7QAb/WBHosLv3L1k7J5hnjiHO6XZl6qxHYLmDnZicHxRXD7+6
	 uSnjhlMWaTGUicj+ZNoSA7gT9/zFiy6MUMFCXMjTuFpa/o8v6WCafv6rw/H/MVJFa4
	 DeKRTE5XugL1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC7A3809A28;
	Tue,  7 Apr 2026 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: tests: use actual address when
 creating dev with addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552480805.3328957.3665125945304556729.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:20:08 +0000
References: 
 <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
In-Reply-To: 
 <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 10:21:04 +0800 you wrote:
> Sashiko reports:
> 
> > This isn't a bug in the core networking code, but the addr parameter
> > appears to be ignored here.
> 
> In mctp_test_create_dev_with_addr(), we are ignoring the addr argument
> and just using `8`. Use the passed address instead.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: tests: use actual address when creating dev with addr
    https://git.kernel.org/netdev/net-next/c/70e32aadb5ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


