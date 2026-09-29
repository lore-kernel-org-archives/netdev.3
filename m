Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8A50E585;
	Tue, 29 Sep 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679026; cv=none; b=BdmRj89+VObN4h7kY6uAWAmIJvLrMm5S1OaI1cF0TS/iYYaKkQJvk0dNuAZfSu/AOvhiwo4hJ5HEdJfcFl5SWBH/biGyN+fA79T3afnbO+5IIlZJg3UMiBcHXKoTO6UVOnrc8jHcazznFVUFDcSxrH2jSCAWVQzKLvxiISe8DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679026; c=relaxed/simple;
	bh=o2/8TWYywI4nEo+ESUn/g2tu9uywXevzV6w6dambVbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qpmDnu7f8QacTim+Al5zwk7zG9hpnhW4bmKVlxaICAwSYsISyLQgIp+z6EUJMV2cSjW8cWTcspqfiFtRZ/rLogMFL+8nxXkK2GAkI2Rhd3edFHVQwrstXBkIkK6rjTG1X5VN0wwEJmrYK8lRQEh3VkBrUYPYKDXdmpdVme7BalY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR91flTC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR91flTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C931F0089A;
	Tue, 29 Sep 2026 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790679014;
	bh=MSFZinW0vLdryXw6ZgTln6m9SLNxnYwGM6Rt3T27BGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XR91flTCtfXGkU85SW/+Ynrr/O7YMPYj5szeMDsIAwPUYb50R97Wc+9fTYnl2DdNm
	 8pT6FU2ltNptL2DLc5PwZP5UGLwZEsaeAIbX2f4/APUARsM3noxZBfzqJAYq4r8snu
	 gSeuujunHvBh7ubBymcKE2o7jewYFmfXExf2XtWtoqNBE0sxChI0luwmP01GE4WXdo
	 ZhAuw0HvdXaLIi0SObl6s2fKonB+1aAi0lOwkb48NGtX0m4tqUaMDGNJOC6KIr4Ffv
	 WBeMxg25ckFOH6n7UkgHm0xPx3oheBcm820jq/AgI54Pqpja3RIf0D0S99QvF7LpHh
	 g22DEdyQHeu+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7749339263B1;
	Tue, 29 Sep 2026 10:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] rust: net: netlink: validate attribute length
 before
 casting to `c_int`
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067901302.426683.9503370759137996060.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 10:50:13 +0000
References: <20260925085449.22553-1-sagartaunk@proton.me>
In-Reply-To: <20260925085449.22553-1-sagartaunk@proton.me>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, cmllamas@google.com,
 mmaurer@google.com, andrew@lunn.ch, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 25 Sep 2026 08:55:04 +0000 you wrote:
> `put()` trusted an unchecked `as` cast from `usize` to `c_int`.
> When the length exceeds `i32::MAX` that cast wraps around to a
> negative value.
> 
> This ultimately resulted in a kernel panic when the reinterpreted
> value via `__nla_reserve()` and `skb_put()` became enormous.
> 
> [...]

Here is the summary with links:
  - [net,v6] rust: net: netlink: validate attribute length before casting to `c_int`
    https://git.kernel.org/netdev/net/c/0923198be4ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


