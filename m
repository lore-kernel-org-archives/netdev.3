Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662C53D0D9
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077286; cv=none; b=eZJvpFLEWZtWqOMMtrfKX7Gzej1w5JFJEkhUuaXW/zCJe8VRjrJ4L8N/Sver+lbhjp9wxGw65c/ofEoDufm+0RK6rKamY4QtV3uOiiZ+PyGNjBxGXoCO4ilKn4CyuZyv5kBcvCw8pEy4YQek/ss0ttcsslGDqAHFQD+S5yJVRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077286; c=relaxed/simple;
	bh=m+FaVnybOVjhc5x+vJiArnxkFLG7M3oJavl5vwFv3So=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nNbnpyDg0XQ/WiZB3HFJc/+xPMMwXox2J8jeSNmxLpDohKg7kLt6ss483x6dmuXZM8u03ST9zYXvWu8/uNUaiQ2/KysI4KGbfg67EcsL/4F3FWImvCzVo4nSLFgqy+XZjWethi4YacNXBEHhqFsWNrz7VZK+TTbaHbD1w/UhYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI5FY7tC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI5FY7tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A81F00893;
	Tue, 22 Sep 2026 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077277;
	bh=TVI8eLwDCVBFZKLFv3XCZLNO9wq754ge6tzooZBCKVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iI5FY7tC31jCYoCWmC6EAlFttO4TCUJrb0eNG3JSQ6SdAy4C3oDb2w0BQMTekGn6W
	 oyAFsjA4of5VrIKDHaeEX4zEeYqy+VJePFNgs0/5k52P6bvTSYmpgixOQ6J5S4fA6E
	 USihKoz1RMd/cvFrjRYpb1WFLzOYTt8EN/9WPiyYhMtN6UWCvWYemDy0tDDoUUCD99
	 Qjm2gbzzdc2YHSsE8FKAip7AUa5OSModGpVXubAdRxQ67JvfGRweFz+ndMl3rr/oy2
	 PYQpdrPFGgHOzqv8gU9WOveP5IiVGgXSdUVkmncYQ8cikegbhCFUyulx4ii5/89UMY
	 HCaby9KHRmmhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994538119E2;
	Tue, 22 Sep 2026 11:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: ethtool n-tuple follow
 ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179007720874.3575540.14084472427997041384.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 11:40:08 +0000
References: <20260918185326.3940857-1-kuba@kernel.org>
In-Reply-To: <20260918185326.3940857-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, olteanv@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Sep 2026 11:53:24 -0700 you wrote:
> Here are two small tweaks to the mv88e6xxx n-tuple filter handling
> suggested by Sashiko when reviewing commit b1fffc273112 ("net: dsa:
> mv88e6xxx: bound the policy rule dump by the caller's buffer size")
> 
> At the high level the problem is that the driver has shared rule
> table but for some ops it doesn't check whether the rule operated
> on belongs to the port on which the ethtool request was sent.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: mv88e6xxx: check the port when reading back a policy rule
    https://git.kernel.org/netdev/net-next/c/e3624f5eeac4
  - [net-next,2/2] net: dsa: mv88e6xxx: check the port when deleting a policy rule
    https://git.kernel.org/netdev/net-next/c/242ebf4c5114

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


