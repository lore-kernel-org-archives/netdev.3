Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5621A704B
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724389; cv=none; b=Njr8ggAnWlS1HKH1V4pI2yW/ClsXuoTgfh/9s2nLRxU4paApj7We4l050oYQA45ymP/xubyN35H426KQU5AMcHIOyJTCRCQY7IMTza5yQSwhK9oXx9s5It7uQguUuJaGhDvGZw1GTiUfmPLDdbWHSLSz0kMYkTD5REa2d2KqPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724389; c=relaxed/simple;
	bh=GcytzOvkZ+fFBksQpGn+O2s81foO/PcoGNDOOtkS+OY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8c3FXJdMqS6mWIQS4TVi8EcidzIG68c1lQcBL95Ft/v6MiWXhjMWqC8U8xTZoi7ZOs5uSgNziblt9zeYfusrXnOK/1O1/obr95v7M69VfnSCav/ZNtGb0GCnDlapp9rzngOhu9ZA3OYlhcIbtJ2aG7tZ5y0yjDwWPdBLOOdikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3DdvojL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3DdvojL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7B41F000E9;
	Wed, 22 Jul 2026 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724387;
	bh=Jifc5jTq5thwTUZMpOutJBMHTFRkO+SMycVl+jFOiuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M3DdvojLu0gtUehYJ4ArTmzSc9iIk/KXrQ95hVNYA28w2GYLTdr1Cg8hKJJBsNMHA
	 FKARWnO9VxQ9sZ2jnaBTvSpC41408mc9Qvaq5r0A2aCDkF0n9/jyO7crYvuAFZTkOM
	 GBl/2HWxUTMGjhWziI6lBO1QVQpAoteN/2BfFv5wzS1r7fSJP5q4frgru3Z81KoqKS
	 0mmlqe6q34vkWqDZHmX5TA7AirhOghFWEEHtMnI+drsmgh5X6p+ImVLnAnECAVrl8l
	 Q5ghQ9wjCBNTr+sGm+823h0KwemiQPyFqTML1oJgCvEQuuh/+C3u4ErY6cOS5/0Sv3
	 y6gaK8WYblj8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4B380A979;
	Wed, 22 Jul 2026 12:45:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178472435613.1380662.9784266698703490139.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 12:45:56 +0000
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com,
 willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org,
 razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com,
 andrew+netdev@lunn.ch, horms@kernel.org, fw@strlen.de,
 netdev@vger.kernel.org, alice@isovalent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jul 2026 16:42:33 +0300 you wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/9] net: Use helpers to get/set UDP len tree-wide
    https://git.kernel.org/netdev/net-next/c/5329647dad1b
  - [net-next,v9,2/9] net: Enable BIG TCP with partial GSO
    https://git.kernel.org/netdev/net-next/c/842870cdfa33
  - [net-next,v9,3/9] udp: Support BIG TCP GSO packets where they can occur
    https://git.kernel.org/netdev/net-next/c/47282504ad21
  - [net-next,v9,4/9] udp: Support gro_ipv4_max_size > 65536
    https://git.kernel.org/netdev/net-next/c/efbc1aa8ed54
  - [net-next,v9,5/9] udp: Validate UDP length in udp_gro_receive
    https://git.kernel.org/netdev/net-next/c/8475a3efe6e6
  - [net-next,v9,6/9] udp: Set length in UDP header to 0 for big GSO packets
    https://git.kernel.org/netdev/net-next/c/99ad24516295
  - [net-next,v9,7/9] vxlan: Enable BIG TCP packets
    https://git.kernel.org/netdev/net-next/c/f3d0f753f066
  - [net-next,v9,8/9] geneve: Enable BIG TCP packets
    https://git.kernel.org/netdev/net-next/c/03ebe91b0f61
  - [net-next,v9,9/9] selftests: net: Add a test for BIG TCP in UDP tunnels
    https://git.kernel.org/netdev/net-next/c/5cb53743e1ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


