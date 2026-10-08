Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0935200C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485414; cv=none; b=NyPB+AFLZpbwZ7GPHxfAOFnwsbxgQhAhvDBcZHZS4pZFdbUgYxLVliX61y12kNKeH2W4F1BquUh7B5davSVmxUUDaxnlFH68iervJCUrtQTGjgwma/fqrSALGpWjogbOFhofAIzYpBdYhtEDMi4T6y9ANuIyocVODCX/IhXz5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485414; c=relaxed/simple;
	bh=R23R/h2WX7r8F2EBBgcimv+l2mjHIp70kr5w3/fUb8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UxqqXL2TaRq0Rkqop6w5glSuXQraP7VOe+R3lKvlpsNnhNVKoTNAoOHQ1qb78kKJc3Dc/wvUxOYlfIcdnxjVCbosr1yKHcbiPAR9Ym3ipHrCf6Hj0aKFb2+5FkeERCBOYO/1YDFOv6Owokvbt3W+4L+Kxaban9B1cBGEEaICkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQmyiWNf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQmyiWNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843971F00893;
	Thu,  8 Oct 2026 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485411;
	bh=acIJNf4n7gZ8GGXBINdNdhcy50rYnLXkB2aWRJwCFaQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GQmyiWNf89+whC5uxi1s0UvQul512NKJ3RYpOOmCXNcNXLqZr82RNsmHoUxbXOyGb
	 loubr7LTQNeEvoW/sI++Xk7+ZvtMdHWFAz2N58fBowcY2TbmTwS31pdrmbJW0xOvNF
	 rJGbfPY6h9r5WlHFXPeFUSQl7i6DJxtwqYXzOJOB2fFwbG95/3AiXEHiMlu7SjLwH0
	 BRhpz/tDdxUNiCdYYXD+AAGchr+3RvwWEs7uD3hiDe6ygzH9SIblFsJ3aF2AMVAHCz
	 PbUPemMEqkdaQUpS9WBGjSdc45M45kmNRXi2VtOtL9bxui0VOeJEu1cnXzHbWvzn/W
	 bNnIYyUTR09Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77598380CEC8;
	Thu,  8 Oct 2026 18:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] WireGuard fixes for 7.3-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148541001.391001.15413183141710298717.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:50:10 +0000
References: <20261008130124.724119-1-Jason@zx2c4.com>
In-Reply-To: <20261008130124.724119-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Oct 2026 14:59:13 +0200 you wrote:
> Hi Jakub,
> 
> This series contains two important WireGuard fixes and one trivial
> cleanup.
> 
> 1) Remove an unused variable.
> 
> [...]

Here is the summary with links:
  - [net,1/3] wireguard: noise: remove unused variable
    (no matching commit)
  - [net,2/3] wireguard: queueing: preserve tstamp_type when encapsulating packet
    https://git.kernel.org/netdev/net/c/65ab9de4bdd4
  - [net,3/3] wireguard: noise: reject response consumption after intermediate initiation
    https://git.kernel.org/netdev/net/c/d0305f8d9002

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


