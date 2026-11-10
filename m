Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279278;
	b=OeHkCOzNFQZJqjXuSlzWFO08qiIKSI7ZO+liLKf0oTQfrhMvHLSCV1OlCW2tePq6LR1T
	 gFKykNxCCTKytMh0uzwvrVVAXDoIbVLjAzYsKIOBEWqTf8LgxDIx65UWFSkSbIC0s08gR
	 XusXFtgFWy4XZ8FmU4bQvBW0NO3vP/HICvRaE5LDZdxZFUKOhJjT3vW1MTS8/yI5UBsXk
	 8eBqJjmJnhQxetJYMdq891MBI+dSNR9qqsEIDd/SEwqHJJ3FaaHU3Cfp8zkT5u6BeYhv6
	 IIFfziSzWRLSHHpDwaENe1t0c2Wck0aMcYtWrXYNqQqG7pONpXlSFQpWu8n3wDF/+4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279278;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=7MqSvCb9hdzWtI2daE+ejGvqIyzBh230NO2kSRwCxro=;
	b=qfTyMnwuUQOtZQTsYv1VYayq2K1rJQpaWTX2ePz9I5zgSfFTwJnXx1giYCkTuOSyHN7q
	 yS0Y9724z1QOShYEQWkOBrnwlvkMRhpf2r5FnuWKyaCLWCld8/JDMso4dIMzE1jpC78Lm
	 zt3xy3LzSkfsgaWl8q8bZoRQld+5kdaaqxsNVM4dKcKCgKNeBGf27PWautc6hI4qs/eSF
	 cSPbkknLXk2vKtbiB54JQgz1w6DjAxN2Vz6z8MV6w4KD2soP9lt84knVC7roczlUvTpRl
	 3X6Xn8o1bDDblZQdS6G/EnHHSA6neT381VGKeGENeqJfjbBlacnxoQe1Wm/+Ni0zQjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpPjFgbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43D606A31C;
	Tue, 10 Nov 2026 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpPjFgbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61341F0089F;
	Tue, 10 Nov 2026 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279277;
	bh=7MqSvCb9hdzWtI2daE+ejGvqIyzBh230NO2kSRwCxro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OpPjFgbZ6nKGz2uqfbzz5+gERuk1oOhiCbCakI7lYkA+02AH4VyQTgngQfpJqACdD
	 gVwvLhm3nrRjCqFZoix6or8OPRVNnf3HRibTnHIZ/GhX2z+tU00NvYESU8YLWJSCGB
	 7vClAx6kqJtGPtRxBEB7HGNpOjOmhapBnpx7fwjYETqDG7KCMeWb75mLyzrUN+pdb6
	 /XyjVbJj5YnCiS0D4f3xP86pz83YMDAViwZCloyRmVp98iRCCaK9DSzdIEFZBsLwor
	 Jjkn04K1E6Vp9dBw03MKeNOOEKOwvl19vS48ZKhUzGFmEOKCVp2uZO14JWOxyXmbFy
	 CTv0nDesU0xwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B4DD391AFCB;
	Tue, 10 Nov 2026 02:54:37 +0000 (UTC)
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
Subject: Re: [PATCH net] net: raw: fix ICMP unreachable sent when receive
 queue is
 full
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427927617.3612825.16017397193883972723.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:36 +0000
References: <20261104115732.322151-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261104115732.322151-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 kees@kernel.org, jlayton@kernel.org, runyu.xiao@seu.edu.cn,
 leitao@debian.org, gustavoars@kernel.org, joe@dama.to, sdf@fomichev.me,
 lirongqing@baidu.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 19:57:26 +0800 you wrote:
> It's found in a raw socket application. When the application doesn't
> read packets in time, the client receives ICMP Protocol Unreachable,
> which makes the client abort the session.
> 
> The reason is that the server hits the sk_rcvbuf limit, and
> raw_v4_input() skips the socket before setting 'delivered', so it
> returns 0. Then ip_protocol_deliver_rcu() sees 'raw' is 0, thinks no one
> handles this protocol and calls icmp_send() to send ICMP Protocol
> Unreachable.
> 
> [...]

Here is the summary with links:
  - [net] net: raw: fix ICMP unreachable sent when receive queue is full
    https://git.kernel.org/netdev/net/c/45441a94d502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


