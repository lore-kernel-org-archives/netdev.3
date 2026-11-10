Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334993;
	b=FP/yJxkSCjzK0bZxUxHSTpooSLVAXL5vN1K8MeZMAJghFiWnUCibaYeXs7rHSgKIxoHO
	 9cg/aliBzVXWBdX8xrdiY9fm+ivaVWrd7FLhznUVEMUay6cqA5LaDjTTVa8Qyf0LKxt4J
	 bYu8bSVTitr+UcAzrGLK5EaxdLqQkwKtCray16gYNO51PJDea4owemsG05gISiiF4dVd1
	 iu4S7b+Nf/rVp/3ZJIayqyuhm7FOdU2dorEocc/ptVw7uUFeSgMV7u8frPL4G2cHfEYix
	 OTpYpXpIeXLE4QhlL1MqUpwB77r1zHnmSpY3qGk1Yt33uhQ26F7V1HgS2A7IYMjMCFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334993;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=L32xlL3j8LzgwOvsZhYg+y811wqSmjBPx2c8wQdC6NI=;
	b=uSkf+53z75qd6ApyV7X9H8IRHeQBajxihEO7PJaaCBjEmKpJNvLKSooXOe5rlYIzASms
	 8b+g0cUcmPjYPfBWdE/MmkOwCQHCXl5Uzbp5OFqjyFV83jIrsPmk47OBjZRCTFNCAhgXV
	 E6PNCTKsU10IFJph7UczsPToe06HnB9akejeR8hcEBc3eVKjq5SZW7r6WwzqQx/Y35Shp
	 sdYJKFJqe1Dd7Y12FRkGVqSJHG/ovQC6SqfFnkgIdWmsCg78XcQEKpghk2kfRben/78qP
	 lK0ExsSGB+G6aiLZt1MlL1oX4EmK48gBehASprQyIyVIcK/oeQ03R90+EHQovTi9VbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnyuOKVj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A23260A3807;
	Tue, 10 Nov 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnyuOKVj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2E21F008A3;
	Tue, 10 Nov 2026 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334993;
	bh=L32xlL3j8LzgwOvsZhYg+y811wqSmjBPx2c8wQdC6NI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AnyuOKVjld5xR2H00+GoPrLNozJ7wl+pE18yC6gXkWNc+hAZxOBSIwQo0xG4YzH2e
	 vd/m+W/icgt4v28MLgqpz30zSeb+L42d4t4iBwdqYjmbybFiE4r/QQZp/iBqIMmVeE
	 oV9y/Xt9YB8kcTesMC3cCF37Ly9LUbEWyOIYBMVValgU5ITrCcK9bearvOZS0v/qMp
	 IFp0IVdBk9WTS/AlZrp8T/zY2jCG2e/4iFepiA14Qnjc463W5VvxeDnfyRmT0cgPsS
	 Ip6VgJYC+Gd/fHB4n+z2lGQHFFgLyFrwsxVzbnyS1jRWtKotQafn27+HYLh3hMCKDY
	 62KWv5BNi2nBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210BF39D608B;
	Tue, 10 Nov 2026 18:23:13 +0000 (UTC)
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
Subject: Re: [PATCH net v5 0/2] bonding: fix the initial last_rx seed for the
 ARP monitor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433499166.4118637.5486946303666911972.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:23:11 +0000
References: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
In-Reply-To: <20261030-bonding-last-rx-v5-0-0b9b653f2f94@well-founded.dev>
To: Ramses de Norre <ramses@well-founded.dev>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, jbohac@suse.cz, edumazet@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, razor@blackwall.org,
 hangbin.liu@linux.dev, liuhangbin@kylinos.cn

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Oct 2026 15:51:14 +0100 you wrote:
> bond_enslave() seeds a new slave's last_rx before it has received
> anything. The ARP monitor checks that seed with an up test for a slave
> that starts DOWN, and with a down test for a slave that starts UP. The
> seed is wrong for both.
> 
> Patch 1 fixes a slave that starts DOWN. Since the up test gained
> arp_interval/2 of slack, the seed falls inside the up window, so the
> slave is reported UP for half an interval without having received
> anything.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] bonding: fix initial last_rx vs ARP-monitor slack window
    https://git.kernel.org/netdev/net-next/c/7cf2286b280b
  - [net,v5,2/2] bonding: give a slave that starts UP a full arp_missed_max window
    https://git.kernel.org/netdev/net-next/c/9231c2b6f180

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


