Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459A1A9F83;
	Fri, 11 Sep 2026 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789087268; cv=none; b=WvLjhD1CwDGRn/WBvgEjp/xxt2uBHdl9cYKzyvyVzWArRNSpQ8ihfq9TICuRplRUoX9+ws/lYjsw2EDFHPhIDXRxpZKijTrUyiq8ZEgqoOkaIOY3dNzXshyf06I0W+j7pkQ9DzI+n9jq8jaIXAjuKKMT3idWLCZqa0nkm8Dy/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789087268; c=relaxed/simple;
	bh=cH7Ka0NdhHhPN4aDbCC1YThLmICsPoBwdDll9H6O+/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fbbeu0mkT3yf8+LMAgBzdJch3uLG+Io1S2rTIK0WNcUdDwTANfcoxGzby9BGx6f7Y/DivMKD6BPmwJK5qfhP0sSI52+RLYgRAhuMTB2vbf7psCgjk42BNo4OceGGh2ImJ7Byr6dpN1QaSTBFn4BsdhoZegk5OdxMvo8+r2O5yO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPg/xI3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPg/xI3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695801F000FF;
	Fri, 11 Sep 2026 00:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789087267;
	bh=Oxuxuc6iSpeiQmAfDxRQOkFLV0e7prDhJMzYyulTHYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XPg/xI3guEGMQ2fAL4iBeaIJGElyNPpfEIG8KZI4mu+R7RI5KDezIBpXUIsUb14DM
	 1Y3HskoOLuzfcW6LOGYk4JZqOPkRdus5Su7cIR2GZB8Ir2p0AGeLznUXg0EDLZKg+a
	 S5VlbrjF0mwt5R+uo0/aiq6BCcSP6QcIWIhIYNnZun448tjl0h2solMY8w4FVucYZX
	 Pha51IxVR3zfOCjHv0fgB4sEMvrOsgkVbKGapJzKMAox7zE5uSrixo7IIqG0B430NM
	 7BLi3xbRbafAB3wBxraYqPGAOSD3oaTj49+YzfurqYH95IE1enV4sj8ReC17rnI+vd
	 i91MI1wgOUufA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09323810901;
	Fri, 11 Sep 2026 00:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: starfire: fix ioaddr sign-extension
 causing
 ioremap() failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178908720445.2162290.13880292468934996463.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 00:40:04 +0000
References: <20260909002829.224639-1-skunkolee@gmail.com>
In-Reply-To: <20260909002829.224639-1-skunkolee@gmail.com>
To: Ivy Lopez <skunkolee@gmail.com>
Cc: ionut@badula.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 18:28:29 -0600 you wrote:
> ioaddr is declared as a signed long, but is assigned the result of
> pci_resource_start(), which returns an unsigned resource_size_t.
> On configurations where the BAR address has its high bit set, the
> value sign-extends when passed to ioremap(), producing a bogus
> 64-bit address and causing device probe to fail:
> 
>   ioremap: invalid physical address fffffffffe480000
>   starfire 0000:08:04.0: cannot Remap 0x80000 @ 0xfe480000, aborting
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: starfire: fix ioaddr sign-extension causing ioremap() failure
    https://git.kernel.org/netdev/net-next/c/f5f0fcfcb30c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


