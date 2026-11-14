Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617411;
	b=h3V+Ut3KNz3WyVzrGZN0jUORHQ+k7P3yUOzQuP/mWWuIOJfQtNQ3Msc4bv7I67h9AqFj
	 vADkJob1KhzPsjZlCERq/4ddhg6aKqP/2L3vzGKUZOAcUoz/GFIIg8jmX/3+tsCqEtEBz
	 IWaBDlo/q99N00C5Mpjv1Ouh8s+V1E4L7zh5hl2jdDZdJp256jckQoLwiaSoL7FcBpLn+
	 0dihFKV8AAPxipgWmXsEsjC099KW/+2YFxFAG1/8T61hdXP3sDlNUK9XceMm5f/E/PHTk
	 strvleE52DlpPbyJv5xw4N53MRFS+hNI71gO1ZVzoUdu2wp/SpTMdvfLjQJJ8MDH4mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617411;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k/rg3ZOYsRZf9uwBQXZ7Qt1v1TtJRuLWtORjvIm+EDA=;
	b=AvEuDcgNJePI9tj8u/57Y5UOlC9/echijTjqEY5KHqb+eZgDzCZT6bp8TwAA9aQv0/K1
	 tKJ1EtaalemJwvaZqt2S9r94k+2QrXfBUollcRtKsiieFN5rZtaIi/6f43Gxi6BgwfuWU
	 8omPX/tPIkevU/qrAQ26YnQZg1dicEZThp8BAbXifIPeIHVndgi/LMfZkuNmcPW1yfgo0
	 Hq1NmRJeNsIONKzUoYZVePWsg6cFpOB6kDTlS6qE5F2w98aKU9fWGr485zvYYF2wLxzZ2
	 kfeTkboR+FGPYrclaLW0QMG+UDjJfXDhWwqWCijeDIs3ADnb4rN3d4z8SyUgz1HyxaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgKU0Fo4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF0606A33F;
	Sat, 14 Nov 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgKU0Fo4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6A61F000C6;
	Sat, 14 Nov 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617410;
	bh=k/rg3ZOYsRZf9uwBQXZ7Qt1v1TtJRuLWtORjvIm+EDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AgKU0Fo4hidfGlUE8ZcsVLEatuGaP1BurwD+h3Y7dRFZ8Hs7vZDCU3h7MqBhXpH2h
	 cddqU9/puLbNK6ia7BoW4P6dczn2+HjO4Ll+znfO/KJmFCo4hoN2tZ2DKDAJzuI/Yp
	 CzdwHOOZnZCuWLbt1gB/3gpWYCeySzwHMIcaEUlySOIGYvp49p1Sh9sG85u+4grCbv
	 HCug8Q6jCiySKBdxGICkFCzSoscEvqe/OAl1I/Dk+bJVgeKD76uESJgKCWWSI6QoEl
	 fbD9V+TJSSUpfqLCRCl3v3uOI2nxrxjnpZK5Qz0Tw2fTm5MfijlYfYYZICJvWu0rX0
	 FqurqSJuMgf7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4539380821F;
	Sat, 14 Nov 2026 00:50:10 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: replace mc_dev with a flag in
 netdev_hw_addr_list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461740927.1921910.2533288322094024725.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:50:09 +0000
References: <20261111023121.1511995-1-yuyanghuang@google.com>
In-Reply-To: <20261111023121.1511995-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf.kernel@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 11:31:21 +0900 you wrote:
> Commit 646cb8868bd2 ("net: add a generation counter for dev->mc
> changes") added an mc_dev back pointer to struct netdev_hw_addr_list,
> so the list helpers can find the netns of a dev->mc list. Only dev->mc
> sets it, but the pointer makes every list 8 bytes larger: 32 to 40
> bytes on 64-bit. struct net_device holds four of these lists, and some
> drivers keep arrays of them.
> 
> [...]

Here is the summary with links:
  - [net-next] net: replace mc_dev with a flag in netdev_hw_addr_list
    https://git.kernel.org/netdev/net-next/c/980d54ce8b29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


