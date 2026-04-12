Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489818B0F;
	Sun, 12 Apr 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025237; cv=none; b=R/3eoqeZx07a/VWy/TVEIaRNsL+MQI3my+24nCzCkIwWv9G5sAse60lQT3ZOsiMgYk2b2yTJYPG42Oj2fSDDE0Kwg4WqPqrXEgINjLofDLYiwwg7Thj/mwKwp+zQnrwTk7dKMNyXIuFYLayxpbpwF6dgPiSaTgHaz9Z8CWOLFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025237; c=relaxed/simple;
	bh=jryuqrjGAu240c9yLVNycnyI2OE92hyePx6bd/iOniI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hW/a+iTXbQznNBmCdxZyxmMUGFLJRlRUmrqIOu9o8wER5Ux2B0ApTgZJyym3JiEbQtOfhO9r7ErVchInXrvYIsH6c+/7ZRPqDIK1IFeiJMxWNk3w/rz8cyzJqlIZrDS+j5sZ58lvmuECek2U1YyUGaVDQrfZcQ6FXaV6S9bKI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox6+DH6J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox6+DH6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68092C19424;
	Sun, 12 Apr 2026 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025237;
	bh=jryuqrjGAu240c9yLVNycnyI2OE92hyePx6bd/iOniI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ox6+DH6JYC/EwulA9ij6sUWgR/jS5AFTeXxETcPYmdaxHPWGTqfGwA7+ue3pv3EhK
	 zpWMiegQNQ6rd9KotZtOQ1LuPN0M+QSy1DACyxhwJbrDF/8jHS56gk12r4eeXBpzFB
	 UiYwI4bHwySXyhZf7uKIH/iIPDDWHOeDiSQxEwMNLbUdBfFgCUzxFS9nYMmnf8DhJj
	 B48UQi+iSSuDAnFUV861ff8WBurnWrIPQ50Qhe4AOZv1E+NF9L48MEavTjKCpjf6tu
	 fGromhvp76QYqKLK3JIQQxre442GfHgC1kNRfxeEx2p3VraV/uJ+czj/MrOTOr8ifv
	 g6e3PXHOi6nzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D223809A8C;
	Sun, 12 Apr 2026 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rose: reject truncated CLEAR_REQUEST frames in
 state
 machines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602520954.3398432.9861431630028064654.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:20:09 +0000
References: <20260408172551.281486-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260408172551.281486-1-mashiro.chen@mailbox.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 01:25:51 +0800 you wrote:
> All five ROSE state machines (states 1-5) handle ROSE_CLEAR_REQUEST
> by reading the cause and diagnostic bytes directly from skb->data[3]
> and skb->data[4] without verifying that the frame is long enough:
> 
>   rose_disconnect(sk, ..., skb->data[3], skb->data[4]);
> 
> The entry-point check in rose_route_frame() only enforces
> ROSE_MIN_LEN (3 bytes), so a remote peer on a ROSE network can
> send a syntactically valid but truncated CLEAR_REQUEST (3 or 4
> bytes) while a connection is open in any state.  Processing such a
> frame causes a one- or two-byte out-of-bounds read past the skb
> data, leaking uninitialized heap content as the cause/diagnostic
> values returned to user space via getsockopt(ROSE_GETCAUSE).
> 
> [...]

Here is the summary with links:
  - [net] net: rose: reject truncated CLEAR_REQUEST frames in state machines
    https://git.kernel.org/netdev/net/c/2835750dd647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


