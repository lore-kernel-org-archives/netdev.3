Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514220B80B
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784761242; cv=none; b=XzcrEj+ABnv1NSUMjhKo5d9+8ghJUfTy4j5k+nOgQ69XRHUMxHI6ReYqlmzaXqzNGwivJnrYD83+097RRc5gIoz7olVd/46VmePKVHiiBKInbkRvIBypUGkhOsvvkefAZlyY9Z1/2BUDifZYlCzyAKCymJWsoD7M0tkCxFpFK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784761242; c=relaxed/simple;
	bh=chbYEiikU+dhF3jfNbVt/mnP3k1W0ZVEQQGw0om6uUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WGpp6XoT23FeyXlBj8HQtbjsTjMcZCH/GFdlXXf24+49IAS7bqgU4J/fo1O0R+GH4h5Brpw71YLeBybrgqnlEA8HxJLbfG9RUeo/g57NTSiBikwQZ5Gvh2T/lzQ5lRmEgyfFh0mwrVUiZJ/W2yBpzwJtuQy2pry5aTJSwKO/mJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMsgp5zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMsgp5zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C231F000E9;
	Wed, 22 Jul 2026 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784761241;
	bh=iLOKQHuyMEC5z7MzZ9Kf/1oRvCiKqQwpH7IgaoiOkaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oMsgp5zLEqfp+L8aBJmkykx6AIFF6wQ33tJ89Di+gNdclWBQYUUCkI9Oa1vJLxevn
	 c98kw2hpXUIMerXVQ2r07FhW73kk8CgZeLov506KybZyQvqkjBt+x6QoQfxELxX5AP
	 WpKtq+utJW/8zLMiAh1eN5t6dp6Bt/UsiZ35QPoyuO1/RdVLj95SbhYh6pfJnZ0zT9
	 t7MluXwu/PpOKkqa/Vf3VdXKVOxSjyhkIGdYJ0SIEOfbb6TdN11sQ+aftvPDqgaTcO
	 LbrIQ/juSmwPqqUfT8HcoqXB4g3SroBY1kYGBrvDCCyVx0386GC7PbAuXE9vs5xghU
	 6L+DbEYjc5MGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B4E380CED9;
	Wed, 22 Jul 2026 23:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] ipmaddr: use RTM_GETMULTICAST to list
 multicast addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178476120939.2053389.14207335012978761258.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 23:00:09 +0000
References: <20260718064800.103028-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260718064800.103028-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 18 Jul 2026 15:48:00 +0900 you wrote:
> Replace /proc/net/igmp and /proc/net/igmp6 parsing in "ip maddr show"
> with RTM_GETMULTICAST dumps. The kernel dumps IPv6 multicast addresses
> via netlink since the beginning, IPv4 since v6.15 (eb4e17a1d915), and
> reports the group users count via IFA_MC_USERS since kernel commits
> 7cb8198761e6 and e1d0f3f08391.
> 
> The netlink result is only used when it carries the same information
> as procfs: if the dump fails (e.g. no IPv4 dump support) or any entry
> lacks IFA_MC_USERS, the result is discarded and the procfs parsers
> run as before, so output is unchanged on older kernels.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] ipmaddr: use RTM_GETMULTICAST to list multicast addresses
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=b8cdda55904b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


