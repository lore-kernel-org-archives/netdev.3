Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702D3C81AF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626238; cv=none; b=fph92eyOkiSkf816UX2OICbKYYbR+z98bsIHTQn5Q77n5a2GW/og7yfTkZx3JTtfZsOlgUI4YMLfC4/RHCuRk7vmdAGrh+a6ZMRaNLeBZIzgJy1h9/IoEoLbnQAD2RpW1lDi3meWZwzmFC/qoMBC95MBA3xCP9DoktgaN76TM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626238; c=relaxed/simple;
	bh=bMtciTDaTCpa3lkgn0iRc3BHEoqYhcScc2crGmOhkzI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZMKbgusU/PrFri4tncti7Bxy5OOeCuLWxhaYvwninvoBo9TMemCLKcjszSx7PZJRxB4T2l9o9qRFsFj/xfV0opMzN/eVcaZOnXiAJ3tduhwcaAZm2JMAeA7uKEST83NV1P9wHpdYYG/G7F08IHiVdzK+8n2tAoReA0SFOQ03a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NulhYm0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NulhYm0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900341F00A3A;
	Tue, 21 Jul 2026 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784626236;
	bh=D6KP3/wNGioXGe2Q4/iqa5kuKmcPLB9WtAVU9i+IxE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NulhYm0mU5YER5FdswcApcbiR952ELnmiu2fLxtPTuUlRO8W2BDc+n8l3i9bQzHtw
	 U6fiqsM1phi1Oj6b+pCy+IUHUlJWQzoCCGKqLNlsDQpNZBsj6dyXFlM9ggB96C4u5B
	 +Gl+03c/rk0Xyh0yyNliSuSECSc75WyLbvg24ELPE18CdMuKUEQpojrhtzgInA8ceN
	 y+qI0ixjZQA2avuOwbyW1/JT2Ws8s+a/e1ifcqRySjjui7UEFeBx4eAuRrCCUBk4k7
	 GMJzXULoZReiv3xR9+kS6zALRAyJVGWjDqQ0syJm6XZkceJkNRW3/kteFXsc5pcLJs
	 Vv8yWI8PPJq4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD73924A48;
	Tue, 21 Jul 2026 09:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] gtp: parse extension headers before reading inner
 protocol
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462620615.184632.10490417322814845602.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 09:30:06 +0000
References: <20260708042244.120898-1-running910@gmail.com>
In-Reply-To: <20260708042244.120898-1-running910@gmail.com>
To: Zhixing Chen <running910@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 12:22:44 +0800 you wrote:
> GTPv1-U packets may carry a chain of extension headers before the inner
> IP packet. The receive path already parses and skips these extension
> headers, but it currently reads the inner protocol before doing so.
> 
> As a result, the first extension header byte is interpreted as the inner
> IP version. Packets with extension headers are then dropped before PDP
> lookup.
> 
> [...]

Here is the summary with links:
  - [net,v3] gtp: parse extension headers before reading inner protocol
    https://git.kernel.org/netdev/net/c/96e37e2f618e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


