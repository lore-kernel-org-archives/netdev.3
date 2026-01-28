Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF741C62;
	Wed, 28 Jan 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559014; cv=none; b=d86VRxzVFNQP3QbYSUfi/222vjPVryowRoPwF2Clna0n4L38ec6SgtntT2Fo74MIeMDk6Lu23X8W6+KiXjGMBxk82b0OmHC2+TZ6s6gi6+awcVC76RP/g9UxoxLDko9CycK4FtF647V31i2L2X8Wusa2plp3vQ39VQC2Gxs86uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559014; c=relaxed/simple;
	bh=krJlgZ9pte6oOVzR0B9oKzzFHZF6aFmfT3ubmMSDySg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AWi6TZodEIdsgkWnlh0No3qFL/dF0IT1yGRgH4sfkWGSsebJqn5YtAgO+b4NDRvl0Cm8erT229X5B/PP+B+5Kg02SxuPs0o+dxda8eMoupJEmVUZCke9H2Gws4AtwhysVV+CNou50gJUVtpENf0Qg6HUKzM5jVdjMfIQegZGfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQGS0L2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQGS0L2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827B4C116C6;
	Wed, 28 Jan 2026 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769559014;
	bh=krJlgZ9pte6oOVzR0B9oKzzFHZF6aFmfT3ubmMSDySg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WQGS0L2ddR5Lnt2hJa37QLjq0D3TKTvRolxyOzvMCrdprHD8+pFu0RQWEYu6QELOd
	 IUoKAvYKhZ1gVdD3pjBkxCI/ONTWYp83NY55yIhxtmCiL6abLkOw+ebrpwyRBf6ZOH
	 DSfXTMmK5IvuZma1s15O06JVXJNDH++/5Ew9f2yPp4IhMDS2SkF/qAbo0a0F7O82yN
	 82fD1ScDEoWaavPeqBPwYr5IoyQsUkUlRLEspdWUsk1J2YHtePhST8FO4vgLRJ7yi0
	 SzbSu3np1pXD0SKkR+v4mQVtJghRp9V5bBKsvnsVQlwh2/p3nXgkCDtFJXYiyB0qcd
	 DiCZrCJmkVWlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BB8E380AA67;
	Wed, 28 Jan 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: sr9700: replace magic numbers with
 register bit macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176955900836.1450890.18355284875310731714.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 00:10:08 +0000
References: <20260124032248.26807-1-enelsonmoore@gmail.com>
In-Reply-To: <20260124032248.26807-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 peter@korsgaard.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 19:22:43 -0800 you wrote:
> The first byte of the Rx frame is a copy of the Rx status register, so
> 0x40 corresponds to RSR_MF (meaning the frame is multicast). Replace
> 0x40 with RSR_MF for clarity. (All other bits of the RSR indicate
> errors. The fact that the driver ignores these errors will be fixed by
> a later patch.)
> 
> The first byte of the status URB is a copy of the NSR, so 0x40
> corresponds to NSR_LINKST. Replace 0x40 with NSR_LINKST for clarity.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: sr9700: replace magic numbers with register bit macros
    https://git.kernel.org/netdev/net-next/c/3b721117fe15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


