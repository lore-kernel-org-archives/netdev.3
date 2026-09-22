Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B5353A73
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037679; cv=none; b=qQEvEQxWrolMSnANzVoxUN2Nvdx8NqkLqWzJL3tIimprlLdX+ZQPj3JLi6r5gi1j6U43oCGWyBkUmAmnxKQ/8hN3gOpaYXFYWNXIvsB/oRWwXChBF9YJcPXh8eLsvpt2SsG1HD003Adkydl1SqSM4qPo/BClBojwbG6s19+SR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037679; c=relaxed/simple;
	bh=jv+7iHLLFVR7vMlOIX8v2emwirT/avSHouY6s6F+g8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ogCTd2T3g1FCeN/JqANPgpd2Uf+7qhlJtavqd6mdO2RgyhDHEnTHntSfZLz9wF+lIG5Et0VQGsZdCZIy5juTnNvYe2rGDUtjm0XviobL5r8MDVMy/G/wAFqnmn0k0X/Mu+CESxgeRLuiO1TdSdpcceBXmlQBUpJUcyEsPxgt6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM2f9AI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM2f9AI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1F81F000FF;
	Tue, 22 Sep 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037678;
	bh=8GawT/fcMMYpf4GTerwZlnjIDnLd2FPy1vv1O6hbZTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PM2f9AI10JkeA7iqWY5F5OYIgvBv+nB+2D7BK8Os/OM8qnDt30imqYUqGhbgiLVas
	 agTWyc2iJ5JHtVeonwbhnc6NTwKkemEL91Uq7aAxUocpO5fhH+E+BPB+P3gvydeGSt
	 bYsdc9aQ95g87wqZ5Ng92YUZep/MhVzeW1Ur0QVD0gRh0Y2MsNAIT60yqgSKfBoJoY
	 7sIsshboQFDr0tWo2A7BPyUeIULGxFIzuxlw8VfgnEGXMe5rVDtRkNiZDFdZVEr0up
	 lmybrxztA/97c0ldukVJnOj3xJdjd99cSUW/fR0i8loPiKhjVOmnvVSL1kO1bhKTnn
	 pN/y39AAaRe2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09DA3930203;
	Tue, 22 Sep 2026 00:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net/sched: Avoid quadratic handle scan in
 qdisc_alloc_handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003760944.3308999.9027552171838055534.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:40:09 +0000
References: <20260918135157.163015-1-victor@mojatatu.com>
In-Reply-To: <20260918135157.163015-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 vega@nebusec.ai, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 10:51:57 -0300 you wrote:
> qdisc_alloc_handle scans for a free auto-handle by probing the
> per-device qdisc hash one handle at a time. With the 16-bucket hash
> populated by tens of thousands of qdiscs, the failing scan is O(N^2)
> under rtnl_lock. A single failing add then holds rtnl_lock for most of a
> second, and rtnl_lock is global, so all other netlink configuration is
> blocked for that time.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net/sched: Avoid quadratic handle scan in qdisc_alloc_handle
    https://git.kernel.org/netdev/net-next/c/1b4efa0399f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


