Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480006;
	b=Ksa0+dF3gMcS9G3HVLapyk57s9AvRgdQZ3p1Edp9J04VRn6nP/5paj8OwnGtNAxb0NZk
	 iZc3iKvb8s+0Rt8JcZVPf62mMkUslPI7N7T7Qk6babd5f1sSz+LvNdb1wMIgufrFLfFSN
	 zlEAl5rHnQKKMOZEsX9bV0xFwcDYHi73aWf81udDrDFKrZv3Pf3UunmVMgpN4g/kjJ0QN
	 aQ3L/+Wzk8EjN0IaWZHijUpShZLgPFjEqPDj4Hibq1f8yj9PoflmqVdXFTRO9GbER7zcn
	 seEwczkJ+5LBJmJX2BgpE1cvV64YiOo/RDgdO71F78qh1opMT+3RE1tgDdikvltMMSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=guw6Jr8H88gng+B6xg/pkyA9CralvM9p9uBZeLWrHDw=;
	b=P+s37/ol41qJEgfZKXnIJ1aq+6E8Ee8HYKu/JItXp5NAlUWFPxxe3auWrcn+BgYOQTBv
	 UAlAA63V6/BLXVrepCW9RklI4fEz9ugatViiSFC6oV0RsQ4P7PA9OeZ/BhmFiaw2BLzhQ
	 /BImCvqGpT/tSbUQ6GAZXB4QOiRdjnmZtaZcKsvElsanJ9XqgsenD1oV889BjR2nIHb3V
	 T/TfNqspFkgQl0lQrGdvFLiDG79q51WxQjDYq7rBlDgECgO+NJQgTn/VRfNQjfzQ2DaGH
	 tQEudKht00MxOEndtfNJhf6Fbuo/n2gW1f8AFou7OUwqWkuSQc4hoSl3cz2iFa/ogFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZGhIy9K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E22606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dZGhIy9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09481F00A05;
	Thu, 12 Nov 2026 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480005;
	bh=guw6Jr8H88gng+B6xg/pkyA9CralvM9p9uBZeLWrHDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dZGhIy9KNwJWanX07GM/AkoDFl2ClMgmY2bXMoglJh0epo/A5WPSa2LvNYC7mfVHP
	 oQT0uYPQQhsAjOnk4/ltx79ySeA6qi/f31PAOddNC84Yp51lK8fC6tJyT6UTbdOJCx
	 QuCZAXqkBuzbi66jTM5Y4z4+b/SKCvLbIZSmW9KNKY6I8peiC04wE2wMbtYh3FGZxu
	 Z1H2eJefyMFCErG7znzztSQ54AGkd9DcwqQ8tx1zrBj3X+pp3mILyugwkDPQilkEqC
	 CIcqlX259W7XVqxaUCUUEtnCANDq++UXFZ96enCfdIQvV7M19VVD57lhi3OUHAuSN7
	 cph/RlEbLnOyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D839D3AA9F46;
	Thu, 12 Nov 2026 10:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net: reset transport_header for
 ndo_features_check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179448000468.2004564.5316033987068882580.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 10:40:04 +0000
References: <20261106172925.3718103-1-tactii@gmail.com>
In-Reply-To: <20261106172925.3718103-1-tactii@gmail.com>
To: Matt Vollrath <tactii@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 alexanderduyck@fb.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Nov 2026 12:29:25 -0500 you wrote:
> For CHECKSUM_PARTIAL skbs, validate_xmit_skb() resets
> transport_header (inner_transport_header for encapsulated skbs)
> from csum_start, but only after netif_skb_features() has called
> ndo_features_check().
> 
> The hook can therefore see a transport_header left elsewhere by
> the receive path, while ndo_start_xmit() sees the reset one. For
> example, ip6_rcv_core() leaves it after the fixed header of
> forwarded IPv6 packets with destination options or a routing
> header, and seg6, rpl and ioam6 point it at the header they insert.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: reset transport_header for ndo_features_check
    https://git.kernel.org/netdev/net-next/c/f4564d298418

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


