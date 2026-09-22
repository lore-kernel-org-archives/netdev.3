Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316E65616A8
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083276; cv=none; b=sssiSRHuTfA8k4AWdi0xBTaqtl+Wrx5PvjoKhBT5gw0kffa06zqCf0DxerGBi6stM5uabbqFvZs70KUnAWzjuhle8CXHXYdHoWJFAE9NxcFdXEQBw8m14rI29zoWHjbvKrRWwdZzm95TRLnvabqg+SuQxeAO7+5mziB9kIimNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083276; c=relaxed/simple;
	bh=NxF3ztYymLzCx17HkJa3QVVLMKcdMSyqCEMvSd1tnek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cP0EYNJP4PDuob5UQf7U/dH1tsmRrWVeI0UYxw3EVMJwE1YwLOaakoeUKXPrpye2PNssBEYgSV5F1xBcbREb42awl78hxUzZ8U7YkBLAxkBL7dX8VxvZqJ1DeupO24Ctc+mGEU4T63QgPagyDBaYAXtVgMOywlhu43sYtxAHmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/F6xGA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/F6xGA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C2A1F000FF;
	Tue, 22 Sep 2026 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083274;
	bh=BWv5lnQJLdhkAeuFVrxPT3dSQux1/bhArOoHFMMbx3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O/F6xGA8VBCDGSorJwosI7uaw9ayng2xCHNt4+BSMPlb+bvXBANBANbZCUKODaHql
	 MqkkL58EhNDJfHv8XdvtlE4R7AhDtMj1Oc9h2Dnl0j9pUzGDBYvl1+mDJjfjKQeKDf
	 dMgygUySlUhGtzaDtzyS4D8smd43leI92o50F62pt9wU4vOhIDvXwfjQdIvjWCy0rG
	 tc0dzmb1+Mg47/NzYW6wBSxtpneNr8T/kT/vX+dlm5X/+L4VHtvmBwSUcAGje3a/WE
	 7rdrmjuf/UASXYnUe7NfFYJawoFq8bDj/xhpaEyZMSUTCcu3ux/K0CVGcp8WdaFzgD
	 BqNFAhxKXEnNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A538119F4;
	Tue, 22 Sep 2026 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock: remove dev_hold() and dev_put() in
 __vsock_deliver_tap_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179008320590.3632047.6169227965497983198.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 13:20:05 +0000
References: <20260921094218.483234-1-edumazet@google.com>
In-Reply-To: <20260921094218.483234-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 sgarzare@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Sep 2026 09:42:18 +0000 you wrote:
> __vsock_deliver_tap_skb() is called from vsock_deliver_tap()
> under rcu_read_lock().
> 
> dev_queue_xmit() does not require the caller to hold a device reference
> count, and the device lifetime is already protected by RCU.
> 
> Remove the redundant dev_hold(dev) and dev_put(dev) calls.
> 
> [...]

Here is the summary with links:
  - [net-next] vsock: remove dev_hold() and dev_put() in __vsock_deliver_tap_skb()
    https://git.kernel.org/netdev/net-next/c/6598456d72e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


