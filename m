Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FB2C21E8;
	Sat,  2 May 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746064; cv=none; b=LVbjnrZYEGB+eQAOjgF77Qy5sF5FjDbDA0seDHm0Xb/6vpqTIvzNsfpxq107WfdxkSrzm0Sdu+ZBgysSNGe8Gt5fV4vuihKZR8TTCTkkAuM+K83tbhM/KjWRQbYQX8UvGrGIlIe+1A2O2GCKUeGppPVOBTZBnXkpz2Eya2KcbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746064; c=relaxed/simple;
	bh=j4vnNDNkfLYzHGXg0ozwKeVY6TlO+1JSBuk8ThN308c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+xSlcEl2wkSdFK6HwWnYfIhpMeR6C6YzBOpTTDcSLQBV+NYSccSyEzAWQdVklCe3q1/znXwUWYdqEtP+zEl919NFUloD8hIn2W7dxjZwqzP9XhIZl9QjnQ9dG7VlaXABCP/K3y6sQ0BXg/PYp0qDCQDXfUr2ZzDdh2i+sqlJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1geOsEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1geOsEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083F6C2BCC7;
	Sat,  2 May 2026 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777746064;
	bh=j4vnNDNkfLYzHGXg0ozwKeVY6TlO+1JSBuk8ThN308c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1geOsEmNR6ExmAsDvrjiXtAZo1KTlnPIMOGTBzQZ5upQ7W9+4zlJkZy4bhfLTO6g
	 W++bClpzIdr8fpuTHX8/KQFzI5cUawgIGYqBB5hfd7VYfXkGI0Uw0LlujZRd5rd29P
	 IsWoRVWhLHRaAolJFonz9LfKWUpSWXwFYKsvfir2Z6sxV42EODxdZKBi7s4uNS47Sz
	 TzcYH7zkqYWeUJ5j6MTrtmkk+rqj+YYIB4u5W3l/nY2obmfAotvT3VgtAREi/Arm5u
	 4CMaf5p+u0XHM7z59wGNlU4pcdpz0b8RCwi1+4L1OQcnCOcxssPpDSM6U7hrcSFGzu
	 tf6PVILuOnmSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD78380CEFF;
	Sat,  2 May 2026 18:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] amd-xgbe: fix PTP addend overflow causing frozen clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774601604.3903048.7896822431673696993.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 18:20:16 +0000
References: <20260429-fix-xgbe-ptp-addend-v1-1-fca5b0ca5e62@gmail.com>
In-Reply-To: <20260429-fix-xgbe-ptp-addend-v1-1-fca5b0ca5e62@gmail.com>
To: Gregory Fuchedgi <gfuchedgi@gmail.com>
Cc: Raju.Rangoju@amd.com, PrashanthKumar.K.R@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 14:54:14 -0700 you wrote:
> From: Gregory Fuchedgi <gfuchedgi@gmail.com>
> 
> XGBE_PTP_ACT_CLK_FREQ and XGBE_V2_PTP_ACT_CLK_FREQ were 10x too
> large (500MHz/1GHz instead of 50MHz/100MHz), causing the computed
> addend to overflow the 32-bit tstamp_addend. In the general case
> this would result in the clock advancing at the wrong rate. For v2
> (PCI), ptpclk_rate is hardcoded to 125MHz, so the addend formula
> (ACT_CLK_FREQ << 32) / ptpclk_rate yields exactly 8 * 2^32, and
> when stored to the 32-bit tstamp_addend the value is zero. With
> addend = 0 the hardware accumulator never overflows and the PTP
> clock is fully stopped. For v1 (platform), ptpclk_rate is read from
> ACPI/DT so the exact overflow behavior depends on the
> firmware-reported frequency.
> 
> [...]

Here is the summary with links:
  - amd-xgbe: fix PTP addend overflow causing frozen clock
    https://git.kernel.org/netdev/net/c/383d0fb89469

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


