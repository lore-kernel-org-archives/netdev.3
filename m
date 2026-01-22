Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6603E8C5D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077822; cv=none; b=E0wlSWCxM3wrE8KPK5A+uP/gkSmN5oVyFDt/PAn+nSc3FoPIU6ZaxnHR6n2QOGgrr3GkK2BScXk9yD7NObWjT2Nt1djlFK2QVfgjTM78LD6HnhMpFpF3MORuvWf1jL8j3xD1n7YogfafSQuikvPkAJTdjbnzd4Sb7OW3mt7xUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077822; c=relaxed/simple;
	bh=PkYzR9JC57/zM/bD2k1MqhaKBXvhnNIBqEUq9nVaObY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZMUkRxUKaPOKXe7GJreRoOv9Iu0iYMhFBVv5Zm16g4x1/DFGPWIiEjtpVr098geWk80KSVLROAMvIqAXJ7HeO5vyzX/rBCILCBUgW37rSyc3S5aDsTNYGh/y7VGASaMqzHwaIlXO1HNOLG87fmhlzzz0YDPJ2KUrZJ45zpw3BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub2A5Y3u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub2A5Y3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC876C116C6;
	Thu, 22 Jan 2026 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769077819;
	bh=PkYzR9JC57/zM/bD2k1MqhaKBXvhnNIBqEUq9nVaObY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ub2A5Y3uCb6mFWI/KCjf8gisIHB0nwRaj3BiqXBOiDlJCbjXE9ahGka1JXocZ/+UE
	 AzkwO2cGi+zl79zePd+Q48u292Xk6yRIEVJlRVZ+jD10uN76XFw5kAENw/BUaS/IrB
	 nK2zxR1lHCzkWHV+rdzLLEf7wCoKeGylIuNrw8gWpq0e0FOFyoBm8mJ5hRlo8AP5Ce
	 EXf2NlKMIMWUDqRgNBJWtg4KmsP3Bd/SOKUTOtjZD+UAmhSdv4LQqCedtc3IEfJ+SV
	 NlJGxB9LOQex7GdYNNmvBcECl8DW03UiEIsZ8ZzaD58lzUKjmjNTSyNfAbK/HYcSkm
	 X0j6Syi2N2L3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BDF73808200;
	Thu, 22 Jan 2026 10:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/4] A series of minor optimizations of the
 bonding module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176907781601.1655391.11599216973044645959.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 10:30:16 +0000
References: <cover.1768709239.git.tonghao@bamaicloud.com>
In-Reply-To: <cover.1768709239.git.tonghao@bamaicloud.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, andrew+netdev@lunn.ch, razor@blackwall.org,
 liuhangbin@gmail.com, kerneljasonxing@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 18 Jan 2026 12:21:10 +0800 you wrote:
> These patches mainly target the peer notify mechanism of the bonding module.
> Including updates of peer notify, lock races, etc. For more information, please
> refer to the patch.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/4] net: bonding: use workqueue to make sure peer notify updated in lacp mode
    https://git.kernel.org/netdev/net-next/c/11ea9b8a88dd
  - [net-next,v5,2/4] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
    https://git.kernel.org/netdev/net-next/c/70fc6649b36c
  - [net-next,v5,3/4] net: bonding: skip the 2nd trylock when first one fail
    https://git.kernel.org/netdev/net-next/c/f1986b3a9f2e
  - [net-next,v5,4/4] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
    https://git.kernel.org/netdev/net-next/c/429208aab9db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


