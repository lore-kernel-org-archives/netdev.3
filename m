Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DC4B126A;
	Thu, 24 Sep 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269883; cv=none; b=ZcFvgXzA+aoNFyAfgBilccp8E6ml3G2SeNZj4hXVJYoFtPry+c20EFxz19jSdVCqoQchcqtHYtjOh4twzyS82Po4/tUaoBDX4FAdUxXeUvddB8ROlxsyHZEyTYsGX21vXPoDbRixbZyUcjM3kjJ3YwqLV6nGlCjvupW2kO7s5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269883; c=relaxed/simple;
	bh=jvmqnA/+3BTpINhy4PKMZ3NxZd347SA58rqD4WOhTtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BTGUkTOJE+7b5KoOoao5GsnLiLsrNeEwrQbrW8dRryL/GPJQU8DpVWBgKTTzXkx2sXX76GVDzFSQ65wdZdJbUo1FrhaZCJo/maBxFLRt3VlgB/Dov+/gBLCfmgOk05q9MASa/Kv0tBQXWyCUjQnzXzWH3Ct6FYUNKxp6W7hBbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGA1qXfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGA1qXfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCF21F000FF;
	Thu, 24 Sep 2026 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269881;
	bh=o5TtA4PjUstn67QcIsxpKM2FkF/4kIsZSZYyqXPocVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GGA1qXfGWig/5N+JTLVPR079cBvFjpVdD44LI7HjdAWuJs9Xh345wVn+xlqFlYl3t
	 ShsVoZmwyl8c9y7EOdCkqAguDN1GJXP/e7VbN/6TKjxr9zOPVwYVC62LqLTVlrxqlG
	 ZmZu0u+45Hpz9zvFG/6YXugzMyE08t5zyq7ksO2UpOMlRwgr1Omse/QMd3iHfwsY98
	 tnbIGdNRK2PsRAoF6WzyBLKDwDM0nnC+PEw4nZt1mQbhuLMBG5xR1xh1KoPfonEXjB
	 PTluGMliqswiwoxAxUrEf24WTMdl8ytJ7cOfYmggWjG0UCsSHDOcNBGzgWNATfxP8/
	 ea32V4Gr65RLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197693A566D8;
	Thu, 24 Sep 2026 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nfp: hold IPsec RX state under the XArray lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026981064.1660211.8740820088652989469.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:10:10 +0000
References: <179001455912.44752.17153022439349797877.idr-bug-92@gmail.com>
In-Reply-To: <179001455912.44752.17153022439349797877.idr-bug-92@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, oss-drivers@corigine.com, linux-kernel@vger.kernel.org,
 lcy8047@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 03:15:59 +0900 you wrote:
> nfp_net_ipsec_rx() drops the XArray lock before taking a reference to the
> xfrm_state it found. The delete path can erase the entry and drop the last
> state reference in that interval. RX can then try to increment a zero
> refcount after the state has been queued for destruction.
> 
> The driver queues firmware invalidation asynchronously; the delete path
> does not wait for the command to complete or drain pending RX processing.
> 
> [...]

Here is the summary with links:
  - [net] nfp: hold IPsec RX state under the XArray lock
    https://git.kernel.org/netdev/net/c/1a983a4e14c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


