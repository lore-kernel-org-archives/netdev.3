Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812392F3621
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136028; cv=none; b=ks40mj9NsdaOmRcX8Whn7Jm0DVC83C/FD5XF5FuFDKQUiofLTjDbx6OkQjTzgsS/Ut76JzW6eJyW+Vj94QkMVBFeKyA7sXMQZfi9N2PEQmGod6wbvhLGx0mDjCbeg4KPpRiRUNNeYuav12V+eLFzRVADoo2TafVFFgzD/SFc2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136028; c=relaxed/simple;
	bh=ahdlY1NrYb5ezUOmeJT2DjPhXGhXzxsiCLyBQinzfjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt5OiJ2suTZDircNnSCFCSHapO+nTZ9ADowKYg7SYy/enSHpy0h9CJHZ4qnrQEZ6MeCx3w1b8M5se18wfob6r6Ve8R/13CGFWFGu1sxZwlfkCg0oGalExXx1jaU3qoyHY3boKjWnKZv/QFMRGsHzQJsUy4XULX2NMUmkKUf13Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a19QlJI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a19QlJI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE66C19423;
	Thu,  2 Apr 2026 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775136028;
	bh=ahdlY1NrYb5ezUOmeJT2DjPhXGhXzxsiCLyBQinzfjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a19QlJI72k+l42psh9zlYWUAawwMFlwKU8zdOWQnEraUpOMJZkUrVfPPvS3YFF9Te
	 xDZudiSSqnSc3tlHz/A9HyLXFCIu+fRm/0XzDRnnUPSnX0RROZHKpTjl+kTAg0/lEh
	 UtV5ZZRsaDwmsu2HpNRX4Q8vuJVYWO7X3VXHiHJfsHwgEOgG4ROZdZ+kdwxTCAfgH6
	 KpRwHN8mOKjvVq21ZaE3U0vm14wHWZjX5SuReG+/4zc/sc10PtmVukIbz+kpqwZMvy
	 fEM+5KgKihCCA8G9FrkmzYpYS9x0ddCMX5uPnMSQAfuuiiOQTsZlkCy+/p8PA87nsR
	 jOuSn/gifFFqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EC03809A05;
	Thu,  2 Apr 2026 13:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/3] net/sched: cls_fw: fix NULL pointer
 dereference on
 shared blocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177513601079.26443.3565261619233773362.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 13:20:10 +0000
References: <20260331050217.504278-1-xmei5@asu.edu>
In-Reply-To: <20260331050217.504278-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 shuah@kernel.org, bestswngs@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Mar 2026 22:02:15 -0700 you wrote:
> The old-method path in fw_classify() calls tcf_block_q() and
> dereferences q->handle.  Shared blocks leave block->q NULL, causing a
> NULL deref when an empty cls_fw filter is attached to a shared block
> and a packet with a nonzero major skb mark is classified.
> 
> Reject the configuration in fw_change() when the old method (no
> TCA_OPTIONS) is used on a shared block, since fw_classify()'s
> old-method path needs block->q which is NULL for shared blocks.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net/sched: cls_fw: fix NULL pointer dereference on shared blocks
    https://git.kernel.org/netdev/net/c/faeea8bbf6e9
  - [net,v3,2/3] net/sched: cls_flow: fix NULL pointer dereference on shared blocks
    https://git.kernel.org/netdev/net/c/1a280dd4bd1d
  - [net,v3,3/3] selftests/tc-testing: add tests for cls_fw and cls_flow on shared blocks
    https://git.kernel.org/netdev/net/c/70f73562d278

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


