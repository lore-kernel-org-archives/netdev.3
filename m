Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D43128B6;
	Sun, 30 Aug 2026 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788126092; cv=none; b=FHI3L1bHuB5map1nT9nwgoJxCjxRGJU8x8KeIoEJM7AuwUOnzQ8lz0pQYTLZOt5zKVTBw0N/uQjxSC2ArEpYEEFe+vo1395j7RcQQAxQfEeEbs2zPizbKq3xAfvtsTXNAxdKsCisggsYknGExelrubO4mwG13/IzeapnTW7lVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788126092; c=relaxed/simple;
	bh=izBmWzncec2BPbNuQAbLaUc8mccJye4cbY6lpBX5AV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e92ELLq8FDKbzcazoLOf3kaTL5xSVUZQWxealwsIVOnk7TObSsc21s2ZbEW9Z0a5ZmQdibzeo+FUR/vs/Tf3qLgi8ULFclmM0isWlGQwts4keY7B+ySgnYYd799YR837J8T9/kmH3wSXWk2dWCFROl0fRU+8eumO0twENsd6src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDHQNtj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDHQNtj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2801F00A3D;
	Sun, 30 Aug 2026 21:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788126091;
	bh=/e05R4rh4qWf/mmUn7ec5jHatxrWYsrtH92OCG0xJl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CDHQNtj9u5gI1Zxuks2szMg1FLdAHjYJcl5fjS398fhYNoNXmbl79XnyyX8VWlmV0
	 2AgB4QBxnvByDZhlnM6Q6p4oj3tr++z6+bZIw9u0395Y+eqYnd7TK3BuMpHbNeG6dk
	 bA5iMn6kqNWhxZREhZKkbY+Ac+bCPaOlaIWzDHRezRL49UXS52Y0PK8dmraKM/+g5h
	 byiZCA0I3G5//FnXeZCCKb/YSwi3b+sl+o2q0MqzzuAXPOCWnkflDLjL8MF1XJGNOs
	 NVVmdt+nTBu+GfLnW+eSWvZIwowbO4Jr0nlff1/RLLB5myPbsvcJt/AzfCurzL71Mp
	 n/RaoJulv9p/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B12380CEF0;
	Sun, 30 Aug 2026 21:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: amd-xgbe: discard rx packets with bad FCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178812603439.3466124.1868310641252318448.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 21:40:34 +0000
References: <20260827232220.69907-1-aslan.jnn@gmail.com>
In-Reply-To: <20260827232220.69907-1-aslan.jnn@gmail.com>
To: James Nugraha <aslan.jnn@gmail.com>
Cc: Raju.Rangoju@amd.com, PrashanthKumar.K.R@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Aug 2026 09:22:19 +1000 you wrote:
> amd-xgbe driver currently sets the MAC_RCR.DCRCC bit whenever
> RX is enabled. This disables hardware FCS validation, causing packets
> with bad FCS to be accepted unconditionally.
> 
> This change unsets DCRCC so that packets with bad FCS will be dropped,
> in-line with typical behaviours of many other network controllers.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: amd-xgbe: discard rx packets with bad FCS
    https://git.kernel.org/netdev/net/c/ac8d6b28d48c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


