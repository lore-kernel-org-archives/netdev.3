Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FE8834;
	Tue,  6 Oct 2026 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329415; cv=none; b=I11WUPT3gdxF+pQPBcpdvIk7zvLe2Abljf+EEhkmqjSkOu79BjnRpjHVo+BnwErBpTdB0jxcZCjHE9f1OScsYLzq48pTEGMO5nmbdC2Um25JkJSIAoe3blJ4/g6gGaSmh3SEYOOCSQl03w8XzMYezqKOm02n2wcMDMx6mI9ietg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329415; c=relaxed/simple;
	bh=Yu3e/dlOY6ncU/Clfd/WS9zYO3/bqardkvrQCRBZpTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kC75GpWYAhcFqogsqXMWfQDSBwsPj5GYF/TnILPcJFm/8gHeLJfpXAYmDAccNQhW1vPGgofBldH3825m+iG93eRzhWwHlHmWUUCFjce40bjr3zxiJQo6V8Ft+OUEBP6UssrhU9H0+x4y3Xak1IzznHIKcEqlNNFdYhsJo+8/05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3zkTG5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3zkTG5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AE81F0089B;
	Tue,  6 Oct 2026 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791329412;
	bh=A4NUyr/QO4DfM10YUfvefX6iA9EnpgE5LrXQNjc2WVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z3zkTG5QMHf7OKYpZoc+0hAnbgs8p8pRypv3lXRn5THM4d5dridMdcLtORPNpssrK
	 3twZAVx52SMs8uu+d4DoN9KSdRYXAECNDLIiVBMIe0cd21rxkwT1rm5gWvqJUNiAlw
	 kdAvXZ5PkyQzAxf+9d6D90z3r8TlsSqnZOrR0guXGyxEf3ugsJPZZ7cGxIj7CLB0vH
	 pfVzJVzhrXnXFDWMxlOSVmOGD4pn8miLbvcWQebsdieI1RCNQhMnSURcsIRwlcyMYb
	 e9YtSxskyCSmJKJOxFe0SadcbOihpKiMNCTY3f8nuk7KAF+1YGXy2lZ6A27Qg7G4/F
	 2sudriiBShXYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14563806541;
	Tue,  6 Oct 2026 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] ipv4: handle nexthop group shrink races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179132941041.2826662.12574878292005935947.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 23:30:10 +0000
References: <cover.1790915964.git.4ncienth@gmail.com>
In-Reply-To: <cover.1790915964.git.4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 deliran@verdict.gg, donald.hunter@gmail.com, amcohen@nvidia.com,
 roopa@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 13:50:57 +0900 you wrote:
> fib_info_num_path() and fib_info_nhc() can observe different RCU
> generations of a replaceable nexthop group.  An indexed consumer can
> therefore accept an index from a larger group and receive NULL after a
> concurrent shrink.
> 
> Patch 1 is unchanged from v1.  Patch 2 addresses the analogous
> fib_dump_info_fnhe() race Ido identified.  Auditing the remaining
> accessor pairs found the same issue in the RCU-only hardware-flag
> notification path, fixed by patch 3.  Separate patches retain the
> correct Fixes tag for each concurrency boundary.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] ipv4: stop PMTU walk when nexthop group shrinks
    https://git.kernel.org/netdev/net/c/6619e01855e6
  - [net,v2,2/3] ipv4: stop exception dump when nexthop group shrinks
    https://git.kernel.org/netdev/net/c/4f4afc07dcb2
  - [net,v2,3/3] ipv4: stop route notification sizing when nexthop group shrinks
    https://git.kernel.org/netdev/net/c/d3daa33c7af9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


