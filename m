Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDDC3101A2;
	Thu,  3 Sep 2026 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399706; cv=none; b=gCMQFmjnuz8thWAu2/4XCsalyarpWjfJ6cL+teBhiemzBO2Lf0eiXTTXkLAUx6JbXltoG6J9Z3P52iPOqi9av3KrK413BtiL0npToUIDvpIb6zhnstof3uHnUVEHY1VAUKsuMpjP7BHhylQbvfoONXCkEfOwPijC+rkuhe6Re04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399706; c=relaxed/simple;
	bh=NFI1vBTpiJHg+SmW2ml5hA4OyOH8r+xNsYJcrhmQWx8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HysdsTjfOJo1gYPYQWcUejOuYQz1ryobKBb47obXrhcaeJFGITmCLs1Kb6adHuA3ubzCAkXBMr32Fzk4oy1bmU8lAx3ceQV235o6x8ZTu8YYn2mjAB6YlUL0/fC8cEVt99EKz83PLe6LEmhMf9ru81DAigMMSe0OOcnXKnDq/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiMl5CVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiMl5CVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE801F000E9;
	Thu,  3 Sep 2026 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399705;
	bh=bWy7hh2HitvjComEr/gNB4xn0pOUI1nPn6cCMFE2qSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HiMl5CVNWt7FWifpKrNa9D0vl5PSscS5NkKzsbbHxYVO3/25HLVVrOfXGcJTsM7wO
	 9sEGCg31II7amC0EA96s0nKlveQA8MTf+7+x5eur/XsBCHLz23MPVFmhH6QRI4I+nW
	 Ep0+xLRBk1kFa2+FnAbz88Lqj9lg0MzAgbMM07kbOfzqq8V41QqV8QCINJRt3wjy51
	 OiRIscbFwN+Qyh7+f+ciIRYJdn8/++3xSXJN3NgLQZJ+X9hitFE1/Brq4IH+5UTcTf
	 Aw+UeUy1Ynu7PUqDJERL+tZNHtF0U+UQngbxAhkteRi4A95uBNeR6DYX8oNv+e+tYv
	 CMIHOl4k1f0XA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09983927054;
	Thu,  3 Sep 2026 01:40:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/2] bonding: fix TLB load-tracking overflow on
 high-speed NICs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839964638.3035212.18319346859188777128.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:40:46 +0000
References: <20260831-bond_overflow-v6-0-ffb0ed1f7268@kylinos.cn>
In-Reply-To: <20260831-bond_overflow-v6-0-ffb0ed1f7268@kylinos.cn>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 razor@blackwall.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 liuhangbin@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 09:50:58 +0800 you wrote:
> The bonding TLB (Transmit Load Balancing) mode tracks per-slave and
> per-client transmit byte counts in u32 fields. At sustained throughput
> above ~3.2 Gbit/s over the 10-second rebalance interval these counters
> wrap, causing compute_gap() to produce incorrect gap values and
> mis-select transmit slaves. Such speeds are routine on modern NICs
> under heavy traffic.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/2] bonding: convert unbalanced_load to per-cpu state
    https://git.kernel.org/netdev/net-next/c/e14761563588
  - [net,v6,2/2] bonding: fix u32 overflow in compute_gap()
    https://git.kernel.org/netdev/net-next/c/4cef95f72bbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


