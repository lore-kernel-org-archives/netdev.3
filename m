Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522812;
	b=hDQ7zFLZy5OhzKRc15MiiS1x/9Jwx3q0aIall8TJh8onNSo+s++90Tr/wutkECMBNjo1
	 JwDnJuhVnsXYgxSCtJHEIxlCtSnJwh3BLl4satvzt3MBxlBlaI9L6AvFd+qi38zPDkkL3
	 XEg8w3oTyKFN5Kn6O0IjnobEvnxJjaDvLW7R8fr3oRFXkL7M4s6tAmhXfzhs/yQnLzW7i
	 FyToYfPL5XmEqoN+I00+N94S3LxeH6zx+InhlljnsrLQqNOXfuoshxCQLMMYKn9M77+27
	 HJP0wwX5R4KIU2tA1P1nNYf6bwAbsP1B7bTZVg1Q/PvPQi/TSYsZo3VcYgdM5a0lo4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kS7rklsk1M528PZqQFNZHAogQLZIvw+QNAsWcaaDZNs=;
	b=jTFId0O9bQYRnva5PEh01mrSg7fuuaW2G9eD8StdkE1AiVsxqmZ0gN+Ysrm4rBo42a+t
	 rL6Xv9HWtrnw5lnguujtF5VZWwX03UhW/BXtPeAF1CZeCP4H2RiGzLhutViCqsFTeQmO8
	 idJwVQK8V0osD0sFS1SkQmLdsqG4cr4+J0BKXvNGNtpEkOAN4keYauDypQAEji8iXLfWE
	 P8Ow1WDWsLDfBAK6J9MMLz3Z6BBkSegQ/1OG2SZ+5tVjER3u2CRvcOgTJ5ab/J6S5Yqla
	 /2bVCbHmtZJ+/VNAdswEw8RAEdvZfikOug9CGjgJLw7g2gY/2Lj9way4+fn3WJaajmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXkI96xI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E801606A31A;
	Tue, 20 Oct 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXkI96xI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B1B1F000C9;
	Tue, 20 Oct 2026 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522812;
	bh=kS7rklsk1M528PZqQFNZHAogQLZIvw+QNAsWcaaDZNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mXkI96xI3xDMevLgzCeDXKzLv5TWVypV9COSIonPH1jZZmlyak01+Yh+iC0T39+Pa
	 R0ItlatIEuL7iz5pkHrj4hGr/7bmxYUqOwmyJYHi/hqNJarx27qD5ND+uPH6joqxFP
	 7xEfPG9C4APq/uewY7TGGj/x4Yw4D1hBqgbG+Rkb5L0xagbEHjqKML5CpQxfBxXHpn
	 20wQ9m+SFNWweY2D+yb3cGGOnTiUaFR+GEcqmlRPY9pDtih7QqAd7Q1gKyFu3adKw8
	 StU2YEuwVfI21mUNuBJYd4qojD9Mjd6WAAC+UfwwMlzMVZnPdyQ19GfzVG9Fwa2Duq
	 BhPr9Aynad/kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15173808209;
	Tue, 20 Oct 2026 19:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] veth: decide peer queue count from the peer's own
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281052.159319.12461762929045255363.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:10 +0000
References: <20261014013620.2497-1-lirongqing@baidu.com>
In-Reply-To: <20261014013620.2497-1-lirongqing@baidu.com>
To: Li@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Rongqing <lirongqing@baidu.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 09:36:20 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> veth_newlink() creates the peer netdev from tbp, which points at the
> nested VETH_INFO_PEER attributes when they are supplied (peer_tb) and
> only aliases the primary device's tb otherwise. However the queue
> reduction is gated on the primary device's attributes:
> 
> [...]

Here is the summary with links:
  - [net] veth: decide peer queue count from the peer's own attributes
    https://git.kernel.org/netdev/net-next/c/267bc3f113d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


