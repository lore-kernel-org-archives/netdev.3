Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6163D5640
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677901; cv=none; b=e/zgzPjva+VEJ6ajMys2rl+wquJNXt0R6cQOXKpDpU45O7O8NmklDgh96TWqSs9F9XtxuQB6At9J5OQaRgHKuFTJD15VXm0TVqdEWsR1auU2ULqUGe9uOq0dFBxMNNxA9BpTAijE1uka3LA8dwe5vHJjyf3S5/01MOItiGTXnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677901; c=relaxed/simple;
	bh=0nDsQ8NGPtDY2U8D7VSeUO3j/c0hdKnJlHcSRTZ1pHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hcCmx2yg5LFWRP50t41YqxE06tkv1RAt7k546Ri6qq+bM/4olBPFiqiTSE1u2iuoFYCIum4INIJ+iS/OqfKKKaTxc3YbzaQf8Lsrh1BPd45QkExc2mNujZvp0NajgOSrAwhENlO38TD0pNd6jKFOTNfwgJz4BElBMkjtpC73yE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxn7pkXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxn7pkXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A192C1F000E9;
	Fri, 14 Aug 2026 03:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677900;
	bh=+6OwyE+JSWmm8Gd1k0SeIJeQHcllu1r8JXDsLf+EPCE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hxn7pkXf01OMXkMedjenj1UFnY3zJ/V4Gx0JYd260W/2N64kvuTQAqCTikTSOYLqE
	 iGXBO44vvUAzJC9c4a4uhO7Jt61ZMJNoW8WuI0tgKQMbmxPQQX/eCOQRpYMVvtpnJd
	 70SCiiNUJpZbOrn+dR01v38XFI3xIZfC2qj95mMRiwGB9B7Hhc4iziZT8Xlu8PmJj9
	 5/6m2AbhFHm7EUI9paz+5/KaZCABiYop5y5KLKADP8cuIo4HsGXaJhQq1UVk/P/rt+
	 KD/1UDyfAPSHOTHwQiCesX8L+ED5+B8v4UWMP3IrBFGoppt3vOWfqZSsEX86JO/Lok
	 jViF6U7Kg4p2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568103810900;
	Fri, 14 Aug 2026 03:24:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: tsconfig: reject zero-valued tx_type
 and
 rx_filter bitsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667785489.3150297.2811414686055013056.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:14 +0000
References: <20260812162230.1837788-1-kuba@kernel.org>
In-Reply-To: <20260812162230.1837788-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 09:22:30 -0700 you wrote:
> The ffs()/fls() guard in ethnl_set_tsconfig() was meant to enforce
> that the user selects exactly one tx_type (and one rx_filter)
> at a time (off / none are explicit types with non-zero values).
> However, both ffs(0) and fls(0) return 0, so the guard passes
> a zero-valued bitset through.
> 
> The subsequent ffs(req_tx_type) - 1 would produce -1, if user selected
> no bit. net_hwtstamp_validate() catches the invalid -1 downstream,
> but returns a generic error (-ERANGE) without telling the user
> what went wrong. Return -EINVAL + extack instead.
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: tsconfig: reject zero-valued tx_type and rx_filter bitsets
    https://git.kernel.org/netdev/net-next/c/77e80af7d2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


