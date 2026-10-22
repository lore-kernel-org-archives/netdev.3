Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693810;
	b=kiFcsWAq8rcMMQvEwBDKsglH1lb8kUKkCHscYKX4kCOU8GkxnKt0Jo7DkPsglWcq4FYv
	 rOvB6+Ei6ZFMFSD1un/+XzRKd88uR/MiS8RJSGVp9L4fjyxDdqWUNyw6dSRXdDFCKmLgI
	 /VaqNE/+J59t5+d0x3NfCvQFv5yxpNIXUvsHkJ8qbJxOyAD1jMyEPgCNtMBmC7wN3OdzC
	 PNShYXzp3Bx27vcqItsRma9jMBfmrcxP6lXjcJkZkhJmauOmq3wlX3pCP7Kji2A33uJ7j
	 c62qSLZuBS3V4YGx9hsFeHWHTnrfpOP9EahupWnMrOhW2hharWU7LwVQ3wX0c4odp7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dXzCN7Cx2O7b6G0T2Mwf8ETdFbzwB7uStNfANh0Qtks=;
	b=LfCDf1Mr32fEJAElB/PT4X2KHSOTfCCY7aCSYnWajI+LmA468MIKEkN/bV30zZJ8BKF2
	 TBB6Jyl9rhnl9lVqhMGtUWqCi3yqI4IFSHCVOx8kJPmFCEaYsclI/ZEocp0y8o7hw0OwG
	 yVD1FOdzNLI4qkcbJlQAUs7zBTyyqEkMPaAyvIaM9Q+LOAQSt7Hod5R+nqk0a9+Ykvh4g
	 clOnKDERPMrlrpokP3UFjnal7JJLIjS5Tla8gbZyj9KeicIDH1sereJyBCqY4NCJnbm+O
	 1JcFRPN2SuHazXuV0bfuRHQtWqSPL6T+2ElWiTJXcWivlXyzBLEnfJe8PVYf3/Cjz3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkLTvNtG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254A606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkLTvNtG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1481F01825;
	Thu, 22 Oct 2026 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693810;
	bh=dXzCN7Cx2O7b6G0T2Mwf8ETdFbzwB7uStNfANh0Qtks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OkLTvNtGlerwIA9n0cJ/O2YiM108B+s5CPtq+o+IJP9qeBO9vJOCRw0lAHZ6BNKkL
	 xh9bOK3mYanx/DnoSLMdae6IhakxtEQHT0bNvyLF/BXRovKNeMX4HeQU9IdpWh6Pix
	 y58y0Vxa6+/Dn/4w+iqZjFBizKhCoMgWhP4vITTxMDjV41wS8KmDhquqtxwnUcHvZ1
	 ybIdTuoI3FnGhOJygY4A03b6V/f+DYn4y+VNQyGFRg9mlEDmAc0lgQ0aZw3KbO23Sp
	 zh+A9VcN1dNpdCohc5S5u3V+exdMpuKidZZrrKTLkvw8Y42aYu5z3IVrvW3mDMvp1g
	 4erbZXknyWxKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444713808222;
	Thu, 22 Oct 2026 18:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] lib/fs: fix cgroup2 path for cgroups outside the
 cgroup namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179269380907.87273.10417636674537764715.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 18:30:09 +0000
References: <20261020225114.18233-1-gopalmalaviya53@gmail.com>
In-Reply-To: <20261020225114.18233-1-gopalmalaviya53@gmail.com>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, mkoutny@suse.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 20 Oct 2026 22:51:13 +0000 you wrote:
> get_cgroup2_path() opens a cgroup by its ID, reads the path of the
> resulting fd from /proc/self/fd and returns it with the cgroup2 mount
> point stripped. It assumes that the path always starts with the mount
> point.
> 
> That is not true for a cgroup outside the caller's cgroup namespace:
> the link then reads as just "/". Skipping strlen(mnt) characters of
> it reads past the end of the string into stale stack data, which ss
> then prints as the cgroup path.
> 
> [...]

Here is the summary with links:
  - [iproute2] lib/fs: fix cgroup2 path for cgroups outside the cgroup namespace
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=7a0464e280dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


