Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5381D5AD4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826867; cv=none; b=Pill/N3jjpNOobEouI55tmQhFjKO6lLxCriahAzsdW8kP+L4wSFGQt0KXYwLxweaqcsPl5k4RJQLwuGdCWEXaxIvA3f95k9BhKyo0vTwT1y3ngbsab/+gAqT/+z9w//i+elcuUUJZyJqctOLqgIfYyafaOWbj5el5b6VDM/lN0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826867; c=relaxed/simple;
	bh=aOLk56O4/aWs6hGe+eMIqQNWdjZHuOFqD22HO/WKtWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a7tGrUY57MfJFmhYA6o2GseMDS2k0mXjqK+WNnUf6lJ9/6aInordTVYy1q5Ch20dzA0k/k7JSXJa7sjQc4K5i+bP4tYuKtFL7tvLCfzA7ouXiIS4hM7YCySgsoDwPkvyhAjfh12T3HGVl2e2LdmDIU2Kg3srCzoBWR/fruewDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2kktaoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2kktaoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B4A1F00A3A;
	Tue,  8 Sep 2026 00:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788826866;
	bh=Zli961gm/IUUuUZ86zu7OaElquGMaeP4kd18r2l8128=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k2kktaoH3O8ZOPVF+2VhvUVziKDeM9go9dw4/jTF5YZq8E7F3EzjA2kwLPNmvKkBr
	 ajyjz4UzkT99U5+vQXgpj04bGvqklBKjTBKgAwS7f7dV3Rgh168SaWiS6koDN0NDYv
	 HLO0XNc+BvU8tIcJpOAal/ykzBaaPw0FwBhASdNyxGac0ia3osDsClAPaWslMQUaBs
	 76JgH+D6OwD4d8YYXoU2otNZX3YFI73ZptRsiEUOuxt35IX4oRv6jtjdfapqH01tVU
	 VNGqPULJe463YnefIBvXRACustzPruwUWdDi752MxootvZmUPyZaWUyrfnAgXLDQNx
	 XI5nQo8WaXV9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0639E8A5B;
	Tue,  8 Sep 2026 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/4] Fix UDP length overflow in edge cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882680564.3217518.149069519818519342.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 00:20:05 +0000
References: <20260901195714.673548-1-alice.kernel@fastmail.im>
In-Reply-To: <20260901195714.673548-1-alice.kernel@fastmail.im>
To: Alice Mikityanska <alice.kernel@fastmail.im>
Cc: willemdebruijn.kernel@gmail.com, dsahern@kernel.org, idosch@nvidia.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, shuah@kernel.org, hannes@stressinduktion.org,
 vadim.fedorenko@linux.dev, netdev@vger.kernel.org, alice@isovalent.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 22:57:10 +0300 you wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> These are fixes for rare edge cases of 16-bit UDP length field overflow
> that might happen on netdevs with MTU >= 64k.
> 
> Exposed by the new WARN added to udp_set_len_short, reported by syzbot.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/4] net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
    https://git.kernel.org/netdev/net/c/b83641e0ab8b
  - [net,v5,2/4] net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
    https://git.kernel.org/netdev/net/c/0ae10b6be49b
  - [net,v5,3/4] selftests: net: Test UDP length overflow with PMTU discover and big MTU
    https://git.kernel.org/netdev/net/c/18a9a4342136
  - [net,v5,4/4] net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward
    https://git.kernel.org/netdev/net/c/199271ebc71c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


