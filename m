Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C23301472
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006249; cv=none; b=GKz7//zoB0R3uNZ9b2MDlqx4qhirdGOOhZK7HGgN+2mHEenQvy05uN16kC0EXpYCw26i6sxfY+pAJIhIQ6Dqj2CDfM/alpNYo29TlnohP5jN8mVXb8n3IYS8D6CowUDfUOfRjOq2WQjaiEHkX35axK3rOUsn9yfkZLRYtLpBcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006249; c=relaxed/simple;
	bh=IhnGn5+xkh5E4Gy8rd91YIxgDyxyLYKyBid8EWeeYA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BSyz8HZVSEE7fFXqcnby8zqMatEHWl3LYu3a5gbWQS9ueEFsXVrFLbeHJlxHqDAaIEKg3sQ7Q4mEqNz8UMHzcPb7P2sIwoZkTREKdRDSZDe/BPOL2/7fJ96fWrZgHniYnHB7BcqSxqVzruTTbTJSXfGLv20gFVuJqpPHa7xYuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQxsaBVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQxsaBVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ED61F000E9;
	Thu, 28 May 2026 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780006248;
	bh=kO6H0zjxu/PZ3nfvaIqpBYr6vfM6pAe6ldmLBCrrXzg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SQxsaBVgxsd2LFPtE6QufpijuuCw313J+KnHyuuNRuOkzWxrHesEPvfrOMi63uhSr
	 D0LKeyCUtjkw0yw+Atizt6gUG6iufPtviCaef93G8KQrCR3bIpjs36ea5o78Wj5otw
	 4p2XIWH4kC9LMmfJHoQMJBppSwbphTvr6rAUI1bzzjuK+2smtHY/pyV60ViMtU9x7f
	 ewMh/Bv7zecIvd6Nld2GK6PeVMn5FvAbWu7N0QfPpAhT2j/uzmQKuOfAKmPkED+i1u
	 asm4Ha3hlL6DblUPaRgSO9o5v5JpQUVGqIgk6WShWfnCPQR7fTm224XSRl4Z2VeSBs
	 MCJrFOw25TosA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BC73811977;
	Thu, 28 May 2026 22:10:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: remove SIOCSHWTSTAMP and SIOCGHWTSTAMP from
 ndo_eth_ioctl comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000625264.1533055.17161971433404428379.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 22:10:52 +0000
References: <20260527120936.24169-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260527120936.24169-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 vladimir.oltean@nxp.com, f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 20:09:36 +0800 you wrote:
> Since commit 4ee58e1e5680 ("net: promote SIOCSHWTSTAMP and SIOCGHWTSTAMP
> ioctls to dedicated handlers"), SIOCSHWTSTAMP and SIOCGHWTSTAMP are no
> longer dispatched through dev_eth_ioctl() / ndo_eth_ioctl(). They are
> now handled by their own dedicated functions dev_set_hwtstamp() and
> dev_get_hwtstamp() in the ioctl path.
> 
> However, the comment describing ndo_eth_ioctl in netdevice.h still
> lists these two ioctls, which is misleading for driver developers who
> may incorrectly assume they need to handle hardware timestamping
> commands in their ndo_eth_ioctl implementation.
> 
> [...]

Here is the summary with links:
  - [net] net: remove SIOCSHWTSTAMP and SIOCGHWTSTAMP from ndo_eth_ioctl comment
    https://git.kernel.org/netdev/net-next/c/31eedfbaa2b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


