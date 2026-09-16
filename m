Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA33368B7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521073; cv=none; b=GRg0R/EOqfYgLA/1Lz69+oeRpkX9Vkpl+qHn1BMRC7Wjrl+P6iZ9l6wfNENOQ5cGwQTdqo0WmRPdf79oshlO1AILQyqw2d/0lwtUCSLgRdIKEFmtwsXFqN1ngCrwtMH0jAmRU7/1jec6Z2IMLnXyQvuqlTWpN58UsPmAYz4LyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521073; c=relaxed/simple;
	bh=7p7C5Go98ihCLL4ghpqqD364lY1762mtdYCzwPeZ2To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cZtu/m0OGAgnhskSmiz/4JTKmcAH8iIklxUN+Fj5UGC52A+cppL8ACEBeF9Ri+0o4cXKvzrmf5UJTrRVrJDpyumlXKs4JplNq+6Z4bVo++JukKp5dsaPHxGMn1+97AamI+2ob8M6xxcTMhki+IqGV+YCx42Lr+6nngV4GYDAM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om9KujA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om9KujA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1A01F00893;
	Wed, 16 Sep 2026 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521072;
	bh=sgucWV6vMUq9VtVhFJZ2VGONsAih/KpPCGt0U0wW1fM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Om9KujA9gQzKOWGg+HnAnjWOe+42LV3/Z3JeBgJEcm3qCdWL7IoR63wDX6Jb+eryW
	 Nm0nR9jhBnGC5QptCJOv/ic53vSX7bIfj5g2sZsU2X/NoVmcLgFHoViA/ieRYIlaEy
	 D1jx3AJ8rijnYs9ZY1r7TssHpLLvQoIMCfFMEXFIXUuXpw2SAl6d7P0OUDLU0XWISH
	 Rmdj5dEgntHZAt4VuHUuAK2pOmIOuxzQMHdaNDsihBY5i/u4a6JQGhoa5V6LLdP0v0
	 FUU8VIl6K5afXDtQ/i/d+DWIOJqF3BwfZpwmFtPcUxZRHYJF18AXos8KLT1FDFYPW0
	 cr+FM5O8adrjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1F3927074;
	Wed, 16 Sep 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] openvswitch: avoid reallocating confirmed
 conntrack
 labels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178952100637.2346086.13652834104390120969.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 01:10:06 +0000
References: <cover.1789218015.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1789218015.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 echaudro@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, pshelar@nicira.com,
 tgraf@suug.ch, joestringer@nicira.com, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 21:22:42 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/openvswitch/conntrack.c. The bug
> is reachable by a root user through BPF and Open vSwitch netlink.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,1/1] openvswitch: avoid reallocating confirmed conntrack labels
    https://git.kernel.org/netdev/net/c/3f118c8217c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


