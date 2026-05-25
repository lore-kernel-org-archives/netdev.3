Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B82C21F8
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733203; cv=none; b=K4tVjz7rbDl8Tmw3kF7rK2qBxrgQ40Uw1X42Mtls7+z7bNJggaZiY4h21scS+6ZabGqKi1kEYcyNXPgRuCxpn0HaUNMeM4/N4r7hYgre5D96I8VP42RHJLt3iKFH1DswW9soJuTdk3rmTU/b1PMewz64NZyQcoJSyWXDC1YS0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733203; c=relaxed/simple;
	bh=tkG/RXo+Jo8cO8Mt/HLHpezPSDA4VOXStY/VLwf+fU4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O1TkJddP2SCF1I1jko4S2icYvvKt2LCgYssAELN0DOiBvekO5xlbyR8A4NhRbS+M/xpt1zI1K1Kahnx6G9dnRJWHl+zNVqo7KODGA/gaQeDPennbe98f2q0vpnGPhYjhuvll/fGBBq+kaO3MI4nzB3jA1vHTo3KqfiNKDtEID2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2QVHIrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2QVHIrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81A21F000E9;
	Mon, 25 May 2026 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779733202;
	bh=bB2JseXZek0LKc1ASqOK+ftODMwWh3xM+n9pZl0G7J0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2QVHIrBEVKZihG5Y1xy1nGYtyNgt1MPrsCIN8SizxEiG3WDkMwdszlSZeqLVbVit
	 D6ztQpZ2J3Khu/r16IaxiyGgFmYoVGP1+uYWuhHHgtzdVaC9AgPwAhkbvhPUKgZsUY
	 ujOqWzWMz5ojy93Z3/LvSJaMOyYISw780qqqhxtRmjCVbqBoQn6IXkpW1bEaD5+s66
	 Sy2mHz42zgGiy4r/r/oEnwbia3N2VI5iQFU+ck8ySUuiQXEtGBi7p4/W98f96Pz/pm
	 kDdPtom67D0w5Ooww3OqzTXcSS01XDhb4Jja9ouPa7NInl+lhtiGO73cQd+ZR56Kv4
	 q0tL0Bhrm/RUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B0E380AA75;
	Mon, 25 May 2026 18:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] ipv6: exthdrs: refresh nh after handling HAO
 option
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973320914.3076487.10031244860101202881.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 18:20:09 +0000
References: 
 <7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com>
In-Reply-To: 
 <7aba1debc2196189172499e5769802b026f8caf8.1779247873.git.zcliangcn@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 yoshfuji@linux-ipv6.org, nakam@linux-ipv6.org, davem@davemloft.net,
 yuantan098@gmail.com, bird@lzu.edu.cn, tr0jan@lzu.edu.cn, zcliangcn@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 17:42:26 +0800 you wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> ip6_parse_tlv() caches skb_network_header(skb) in nh while walking
> IPv6 TLVs.
> 
> ipv6_dest_hao() may call pskb_expand_head() for a cloned skb, which can
> move the skb head and invalidate the cached network header pointer.
> Refresh nh after ipv6_dest_hao() returns so any trailing padding or TLVs
> are parsed from the current skb head.
> 
> [...]

Here is the summary with links:
  - [net,1/1] ipv6: exthdrs: refresh nh after handling HAO option
    https://git.kernel.org/netdev/net/c/f7b52afe3592

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


