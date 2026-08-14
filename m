Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E03DB640
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677905; cv=none; b=GNrsg51j3c01tAqBpk1BhC/QEj+MXoYwjiFq3PdqHJLBaIiYqWLLmz2aq7o8oRCXJ8pU219aXKIb3JVTGRBN3jdWkjDwYCOiba99nxJFQwh4S+lSDDg8jDlVoK3uVjanG0EfYjTyqd/OxiuE7AZ5Sc1PIxS2XjO1NXJ9/REPWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677905; c=relaxed/simple;
	bh=jwRjLkUj0uxe7XFu75iynZpNZaguoekuCnPjpjWvvS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SENyfAw4LUYbm5QIjt0fhdos8TU4+iDlvQz3LghUy61FLllz2CIzWz7JE6kmQz6D67pQ4Z9W2LGppydT6EkskcbC0gIbX6hp+eoHu0IRog1fmeogmGFktUqANFCcx8QblEDQGNe1juu+zVkHAjSPefECEaBY+b90vndNGD+ky74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcBIz9zO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcBIz9zO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68061F000E9;
	Fri, 14 Aug 2026 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677903;
	bh=dQic58IbeB55fjT8SvbHNAMWvjbM3Pq+9NQAJ0RYT6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XcBIz9zO6VaDauOv0luaH0x7hm7C9jWnkstjokj0azcp0eYHRBsQvozmxnTfWOrRi
	 WPIp31UgTjX5Ck1DT0Y5gzF0WixlphZ2OZaWxsDNS1lziT/YnLK01k7s/mhKrq3Qlp
	 rcv9/3h9FARVq410kA1kHaxjtUk7S1sLZYkM2SvDDDD3u4eb4XOeNbFsNbSfwi5tDH
	 MA6ZUJcQBU6wNeLxplMZpND9sIi1cWsHPmhiNZYkIuEeVX+FmR9mou68e3TxK3nViF
	 Gpby9dLdxHbI6vQTBtFsG32Dx5IGAYLnvYfwFZzwzm5/7y4ztcon+IZCwI3DxIyL/A
	 GM+UCHMQajqnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B73810900;
	Fri, 14 Aug 2026 03:24:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/4] net: phy: dp83640: fix shared clock lifetime
 and
 probe error cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667785788.3150297.11534813244914536308.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:17 +0000
References: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
 richardcochran@gmail.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, luoxuanqiang@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 23:13:41 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> The DP83640 driver shares one PTP clock between all PHYs on the same MII
> bus.
> 
> Its driver-local clock lookup and removal scheme can leak the shared clock
> on probe failure or free it while another probe is acquiring it.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/4] net: phy: add PHY package locking helpers
    https://git.kernel.org/netdev/net-next/c/ebb16fca011c
  - [net,v6,2/4] net: phy: dp83640: embed pin configuration in clock
    https://git.kernel.org/netdev/net-next/c/20663d78f1a1
  - [net,v6,3/4] net: phy: dp83640: clear state after PTP registration failure
    https://git.kernel.org/netdev/net-next/c/e8b166c1f0a5
  - [net,v6,4/4] net: phy: dp83640: fix per-bus clock lifetime
    https://git.kernel.org/netdev/net-next/c/854ac5fde221

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


