Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DB3A7F57
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102400; cv=none; b=FZdKsCrQQ6lVFQGrHtUTdxsMbPUR1CtWGkjPV0+vpsf3nEjfdE/OKov/JUQsB0zyErFRqCDXeufkxAAChF9RisVO9Lw3u+Blp8UMLaSr8xh42Jrh5XxYeb4JtAdeP9Vd0We1OEP+G0Jabgc1XPDVN81e3Z4Hd4DYVmpkhfnBDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102400; c=relaxed/simple;
	bh=F3HrGAIU2tfaqiQKMyFnIuLdK/rMxiP1uTtgtBIesuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LqsRNRFTc1lnqLyKcrswCBSa9FM6HNXLJkDyRPnCmW2SqB2z4xiwUrAojOhcRrpRdmeD8JcT54PDAFDEmTzVX4EqLq/qvhwDxG6Dh0YsBg2w60cQg3mEUd6BEfUMlHFlWEjVWT+lxaD0In5ZpfFG/O9+fvywgSy+PyhE7HwavJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNdywAOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNdywAOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3EEC116C6;
	Thu, 26 Feb 2026 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772102400;
	bh=F3HrGAIU2tfaqiQKMyFnIuLdK/rMxiP1uTtgtBIesuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cNdywAOfm8n8FdWGqCtZMnQl35m/76rpDRSlQNpCLXc+0HZcJnValSYwO2Fajv4GG
	 KFMFWEcPRobVXr8PKSbHJIC/gctnTjPr5rKCd9mdKBQfUVUKQHGo8V2on5LyoBw8N5
	 uc6uOJP+EGfmzSHj5mj/18d3Q/Xa4AtPcRNkidv9ft6ysihLU3tkQAb9uW4HQLYE0g
	 N0LuZww/1wxffO0F0kk7keV0OiYomIb7nw8TtlkSKd8JOzqbYQR+UMxZeiNIubR1UN
	 legQnFKZ2lD3jVXyhPvAV+mOoPWSOm6H7NPGpvfQN1DZcs4retHXNDnB61ZLTzrgYy
	 IysSH/v0Mdq1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C1B380A977;
	Thu, 26 Feb 2026 10:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: consume xmit errors of GSO frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177210240479.1154168.3627638731313377314.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 10:40:04 +0000
References: <20260223235100.108939-1-kuba@kernel.org>
In-Reply-To: <20260223235100.108939-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 hawk@kernel.org, alexander.h.duyck@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 15:51:00 -0800 you wrote:
> udpgro_frglist.sh and udpgro_bench.sh are the flakiest tests
> currently in NIPA. They fail in the same exact way, TCP GRO
> test stalls occasionally and the test gets killed after 10min.
> 
> These tests use veth to simulate GRO. They attach a trivial
> ("return XDP_PASS;") XDP program to the veth to force TSO off
> and NAPI on.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: consume xmit errors of GSO frames
    https://git.kernel.org/netdev/net/c/7aa767d0d3d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


