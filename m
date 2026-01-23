Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BF279DC9
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197835; cv=none; b=dz8oJDGcmLWbi+gmOEaJh6tKmuG4GnxkbwrLTmwev4Bz8M/LwtDCQETxn27nV5likaoBO3RERIfT+32y/AdDFpHiP7+FM0Q8e0dsayr5XsesjPM4q6AEa6ecZOjopaeD6GDrsmY5/3Gigx/yKgggCyC0z1F/xv0/1Tys14nYpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197835; c=relaxed/simple;
	bh=EAjswXBmTeZUmcLCyjSIijOGAx3IP08Eg0Hs2mIIEQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrwT67+7EBflDbqw82yN05dHVROfDaaTPC40Co1lei3S5DmlR9d0lvSN+1PYocgKdfA3c4cK52Q143XXE3YrASnTsb7QNq9+XON+ULg8oeOqP9k7b+2EJENSX+jQYybXaXvlPoUZ0E1X4y7REuDusY3XKuRtLJc7hoSn6GvU0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxc5C8wQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxc5C8wQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40175C4CEF1;
	Fri, 23 Jan 2026 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769197835;
	bh=EAjswXBmTeZUmcLCyjSIijOGAx3IP08Eg0Hs2mIIEQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yxc5C8wQvnYPUJGJw15Q+EWO/4KUUJHU6ofKljeuTKeyk0PtdkN9F8o+piZD/zxu8
	 EgoeFmpsbfiiI/I+ctulImFTVnUbjnsS1H25nBk4DbcxufB+vgHmddspl+BjAJHdj0
	 etQRnPOv0XBWjX0subiFUVCfCs3uIY0zQcjSxNRDV16AmC1bpGItENbfpq46a3XRjN
	 7wt6Ye5wEq1d+eqR4ivcvBNfYOfI+/Cfin9FChGghfCft3SyXFvTn2eF25oXr9MSKj
	 UZOwlEJNJCVj7+isApjlatj4nJDuFW5wJzwRywoEVN2niGdrIIe4O15Y0r9L8IwT1j
	 upenASPmGh4Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4E85F3808200;
	Fri, 23 Jan 2026 19:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next 00/10] geneve: introduce double tunnel GSO/GRO
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919783084.2695110.88149149748151236.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 19:50:30 +0000
References: <cover.1769011015.git.pabeni@redhat.com>
In-Reply-To: <cover.1769011015.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, donald.hunter@gmail.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, willemdebruijn.kernel@gmail.com,
 sdf@fomichev.me, petrm@nvidia.com, razor@blackwall.org, idosch@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 17:11:26 +0100 you wrote:
> This is the [belated] incarnation of topic discussed in the last Neconf
> [1].
> 
> In container orchestration in virtual environments there is a consistent
> usage of double UDP tunneling - specifically geneve. Such setup lack
> support of GRO and GSO for inter VM traffic.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,01/10] net: introduce mangleid_features
    https://git.kernel.org/netdev/net-next/c/31c5a71d982b
  - [v5,net-next,02/10] geneve: expose gso partial features for tunnel offload
    https://git.kernel.org/netdev/net-next/c/0c09e89f6cea
  - [v5,net-next,03/10] vxlan: expose gso partial features for tunnel offload
    https://git.kernel.org/netdev/net-next/c/e0b73b5a9257
  - [v5,net-next,04/10] geneve: add netlink support for GRO hint
    https://git.kernel.org/netdev/net-next/c/ba1b8c97b9a0
  - [v5,net-next,05/10] geneve: constify geneve_hlen()
    https://git.kernel.org/netdev/net-next/c/759b8d3cef7b
  - [v5,net-next,06/10] geneve: pass the geneve device ptr to geneve_build_skb()
    https://git.kernel.org/netdev/net-next/c/1da80d91bd0e
  - [v5,net-next,07/10] geneve: add GRO hint output path
    https://git.kernel.org/netdev/net-next/c/e0a12cbf262b
  - [v5,net-next,08/10] geneve: extract hint option at GRO stage
    https://git.kernel.org/netdev/net-next/c/0eaf63b3fcda
  - [v5,net-next,09/10] geneve: use GRO hint option in the RX path
    https://git.kernel.org/netdev/net-next/c/fd0dd796576e
  - [v5,net-next,10/10] selftests: net: tests for add double tunneling GRO/GSO
    https://git.kernel.org/netdev/net-next/c/40146bf7555e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


