Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916E3BD651;
	Sat, 11 Jul 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783768268; cv=none; b=ovH7CVk2sH8wpIdxzmW8ec1/TLrEjlI9uVUEHMeszW3o5LV9CATFCd9pij4OexBIHguLUzxrlbj9ulx6Xtiue31Y0i0SmHaGbooffr6r6uFF1YcIApbpJcU+t3RU6QG+pdTvINgXfv1sE0OtJma9aeoQGu1wDHcvLlRmN2bkgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783768268; c=relaxed/simple;
	bh=s6/iCs+g/DewZyr7DrkDuzlmYmAocsP016EdWcllA4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oQtSP/WGivRjuhh4AomPyZZ/EUcpFF5bfLcaw9qUEVQMFDS4DM+qHix0P+cXAaQonbYI+1zFy2RelRGN0JsB4x+IflQkvWUdVWsHujGVRjnNYsrD3J0x5dOimsitR7Ymd+iypgZ2bXhMN9oUsxLESO2Rg2zc9RzC+yBqZ65aGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsLhuauX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsLhuauX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448421F00A3A;
	Sat, 11 Jul 2026 11:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783768267;
	bh=FIK/Ng2QmkVGBjLJDefkXUrMsIT3Rs6w82qHdlai9gA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AsLhuauXf5x5ABf2ZvoJlazBFPPIBg6ftIz4U9wgWhL2969UbUTyohghV4fEE6Ur4
	 ChRzz4iF2lpb6lBbKodYqzAo6Li/lug0YymgxZuf7iJ5Qt+zaJdVrizZa6XL7OSQwI
	 odkxkeJJJljc5OVw/XJQfw1J7F/g5O+ViQs4ZMH/P+GQiYWeqy9AbEfz70GjIsN/VJ
	 A06biGPexX9h9gUlSkIHwncBwO5RyHRkjQ9Vn5AKbJl3+Z6OouhE8yFzwSGF4cRkVY
	 A1c/0jPr2DYBWDwJ9YObRkYqP9C5OTs3x24pUQt6/rk1ra5rN26bP9cVFOUHXiS/1j
	 4HoEU85WxljTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B5839244F2;
	Sat, 11 Jul 2026 11:10:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: qualcomm: remove unneeded
 'fast_io'
 parameter in regmap_config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178376824415.1081492.7151671823715227270.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jul 2026 11:10:44 +0000
References: <20260705164208.2184-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260705164208.2184-2-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, jie.luo@oss.qualcomm.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  5 Jul 2026 18:41:59 +0200 you wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: qualcomm: remove unneeded 'fast_io' parameter in regmap_config
    https://git.kernel.org/netdev/net-next/c/f6f3b36c15ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


