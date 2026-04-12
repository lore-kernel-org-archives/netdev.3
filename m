Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE1CA5A;
	Sun, 12 Apr 2026 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019250; cv=none; b=HsNHKJDzK6vaH8wog6IeLwVLB2pKrgkbYeFkLSrMw2rFqWErCsMTt6cL4hMshJxg8JzYN2zqjKUUipGNJRCacm0uwwc3Yww0Rj7eUoHhmZehPF0cLpaFn01kD1JeDMgW2/vx/3scrKfJUVXyfEhySQpc/8WwFEISiu0J4oDadvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019250; c=relaxed/simple;
	bh=8WWySsScl9MiL4rJ02PKou/vdr3Zoy2gOehGrUzdoJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dyos59vEloQ5kVEVpNfuweiYXtruReaS6osG5EBzornXtgJEEPLmwFSOtph/9muJLMGiEFsBdymnkO7ma41JC0R4ymYeaQD1ZA1k4amTmZQAUwnq/BRNhKKRuiLqujQXKTFbkiCKUKzf35OcrXw/dfuaXvXg25Tg7sUnozbuvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivHIPA+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivHIPA+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9EFC19424;
	Sun, 12 Apr 2026 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019249;
	bh=8WWySsScl9MiL4rJ02PKou/vdr3Zoy2gOehGrUzdoJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ivHIPA+k/wAuk7jQXAtJiyJPXHE0e1sbz/ccvurJIbL9vcnkAjugihP260VvYBRkH
	 xFoxIaOwrfDYfKBlbEyl9FnugI2tzGc7+c6PyWvU5+mGfPMkZo88BdzxicaATtEtR5
	 GIx5UkTZe9NxxR2dTb2HvM7CTmE4CgsMM+8hA8wK0DRJjc4pifhGjHWksAxGg2u+wP
	 SvCOIQJ01xJOJ2fUeG36fZz/DHwMPIO0U/c6Q/y53X1m6jby/KK/Tv4uBaycCifIxI
	 1kaZ6RyQrfTlEE1b6lJ4eJLRByjAz4P8oeG87Q4YPKN8HUcQ5HhGGC72g2oFEETU4E
	 xpQ+OEyGp7prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDE33809A8C;
	Sun, 12 Apr 2026 18:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] ynl/ethtool/netlink: fix nla_len overflow
 for large string sets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601922203.3370691.7398703435218885148.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:40:22 +0000
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
In-Reply-To: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 15:08:48 +0800 you wrote:
> This series addresses a silent data corruption issue triggered when ynl
> retrieves string sets from NICs with a large number of statistics entries
> (e.g. mlx5_core with thousands of ETH_SS_STATS strings).
> 
> The root cause is that struct nlattr.nla_len is a __u16 (max 65535
> bytes). When a NIC exports enough statistics strings, the
> ETHTOOL_A_STRINGSET_STRINGS nest built by strset_fill_set() exceeds
> this limit. nla_nest_end() silently truncates the length on assignment,
> producing a corrupted netlink message.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] tools: ynl: move ethtool.py to selftest
    https://git.kernel.org/netdev/net-next/c/22ef8a263c17
  - [net-next,v2,2/5] tools: ynl: ethtool: use doit instead of dumpit for per-device GET
    https://git.kernel.org/netdev/net-next/c/1c43d471a513
  - [net-next,v2,3/5] tools: ynl: ethtool: add --dbg-small-recv option
    https://git.kernel.org/netdev/net-next/c/594ba4477164
  - [net-next,v2,4/5] netlink: add a nla_nest_end_safe() helper
    https://git.kernel.org/netdev/net-next/c/1346586a9ac9
  - [net-next,v2,5/5] ethtool: strset: check nla_len overflow
    https://git.kernel.org/netdev/net-next/c/b2fb1a336383

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


