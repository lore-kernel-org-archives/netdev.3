Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A423845A6
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035092; cv=none; b=MiqUoStaWy0rk6jD0nWgjZiDI9HEKvSz+NPi9mqBf1LYAwM2oPzHBTflfL3FfJcXLJPkGcyghjbkdGBD27L7PbA313g3AgPkwdtAuCe+6rqLA0Kp0pJvnNa5la3sf6YE14+Et7kJ4Ae/xt2zbc7JdmpL1xZelFaFPc5bGc6MpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035092; c=relaxed/simple;
	bh=1DLjXD08DX5NrpydZ6t3+5KwCBc0fIaeLZvu1g42ycU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G/DfNVxJVo5VdCzOCH6LkSUWrZjc1o4teIPr4ZX1loygL0IBJmg2YGVYk3pvsHmVX9uW1SrLH5mx+o/vh6m+ED1jBHO7dy+fqrugZMCLfTNXQHXU5SSXhcD+tDxNmVAd6yqjv/vTgyT/sWvkAK/8FSxJ4xqSeY8+0hA8WHKqJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHlRPxKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHlRPxKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6A01F0155A;
	Thu,  6 Aug 2026 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035073;
	bh=nnTPp2jg0BIwpwPAr8YfULnn1BrP57yBl9tBxXa17/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WHlRPxKT65Oo11zSWPW3xb11mpaZjJC1jV4ova6ljWEjFJWVqwccOp4Xe6059LcrC
	 C7zUIaEn2yl5nRdNqzw0gKXcjBB7dkeC/f5t1xFWr9OZvTmfr0e2m/44meZ6RI7wqP
	 FV28zTBMhhNc5cs42iYAhm1x4Hl4CEJXIuF4MQpxi6s5XYiTDeu2JlMs5eLckz2U7b
	 XuLBRw8XWUgWo0ZocKWcP0PpZRpbObWni1GxjmMPzNM3xQh6PExq9G85xWtbv/S/II
	 n3Tl12OFzKFSIedglaQ9H7M0yni5Xo1vNqS4gIr9NIesn+lrhWfZsQfFXoH/+0+LBE
	 JzNcaJ1dU2mmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DE380820D;
	Thu,  6 Aug 2026 16:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/atm: fix slab-out-of-bounds read in
 vcc_setsockopt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603503263.1375455.12985449787644738517.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:32 +0000
References: <20260805131508.3227331-1-edumazet@google.com>
In-Reply-To: <20260805131508.3227331-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+53ecc09fb81df10ef4de@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 13:15:08 +0000 you wrote:
> vcc_setsockopt() contained an ineffective optlen check:
>   if (__SO_LEVEL_MATCH(optname, level) && optlen != __SO_SIZE(optname))
>       return -EINVAL;
> 
> If __SO_LEVEL_MATCH(optname, level) evaluated to false (e.g. if the caller
> passed a mismatched level), the length check optlen != __SO_SIZE(optname)
> was short-circuited and bypassed. Execution then fell through to switch(optname),
> calling copy_from_sockptr() assuming optval contained sufficient space.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/atm: fix slab-out-of-bounds read in vcc_setsockopt()
    https://git.kernel.org/netdev/net/c/d0c80dbb9704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


