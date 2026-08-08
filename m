Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE2319851
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786153257; cv=none; b=b0eOlo8xaczCDHx239DAFveOKwe1WUxjSUrA8EZXCcAPHRq0SkIahy+MePJvjCNjI5CCPGqu8bHuUHIzydEZujAmwk25bQ/VR+MY55CgLSDnJ9Sof15zBJUrFsivhmTkxCmrTifZgYU1IZpvZ6TPNjpwW2QGf7ZBhs2iKZJXZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786153257; c=relaxed/simple;
	bh=EY4pk1FRKGUg6N/Rh6yKBslkC6EFJgnGQCWmbz8+t2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bknoSlUZDRzMip3MuICvnOq6wVoI0ZioiGq+6AeMSsRXr0R1geslTOMu5UDadAHJeJbg8PoiUAWJavPO7EGDDlQzxJ7Gv6jfqfEzizdGseAB2OpDaC2iN+PtxDN9eX59d2KqR/vvcUIOru951mK/BQG8+K+prMbzuzyBk3TD+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+uYy9oY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+uYy9oY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378781F00A3A;
	Sat,  8 Aug 2026 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786153256;
	bh=+AqYCwe+Gu4rhgxEi07Oub2Qo9QV6uBmxKiNi0fHvD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+uYy9oYCJHGns6fmt5Xu0mPzdwE1X03HnwtDT4o2R1vir5y7eWl/zuPJvqZcrdMw
	 HiPmqcASMSDRk6wJxERhMo9bTqXgxNXni1lfeq8/OnOkuH/1B70hMk9642css+GqnQ
	 N/1SXI/9c+SUOcApFyplx7jKX6QWf7yU6cusOLmTLpSwAeXm+Ck50iUZk8l/TXlDs3
	 Mhug181EHSj0METymPTKgEcIRviH95K6EeG0wQPipmYr/5a1HJTC+vFrOtkgPvZidU
	 PT5Hq7Jqg62b14vu1scx/LIbF1GubWo37LECcpM7KnR8G898nGCymYg9FfY4ZhKi4+
	 QCj3SuZerHqKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D095F380CEE4;
	Sat,  8 Aug 2026 01:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools/ynl: add ovs_packet uapi header in
 Makefile.deps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178615321439.2493713.737563862054175696.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:40:14 +0000
References: <20260807001918.61957-1-kuba@kernel.org>
In-Reply-To: <20260807001918.61957-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf.kernel@gmail.com, houminxi@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 17:19:18 -0700 you wrote:
> ovs_packet spec needs to fetch the right uAPI header,
> like other ovs specs already do. Otherwise build breaks
> on very old distros (Ubuntu 22.04).
> 
> Spec was added by commit b82bfddc46e2 ("netlink: specs: add OVS packet
> family specification").
> 
> [...]

Here is the summary with links:
  - [net] tools/ynl: add ovs_packet uapi header in Makefile.deps
    https://git.kernel.org/netdev/net-next/c/edabb0da7387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


