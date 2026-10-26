Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058610;
	b=uwvOTAAzEg8RojQ59Gpx5oTtZGrZzRawUk1dGpfMDVQ9uodY61HhfFyWm/XHptq/5UnX
	 ypc5rmh3GfhsLQugqbQbZ16syhryhgHqYu5X2RYfQQaX/8Vj5YLSe4a0TtIg+6bKxqSts
	 7HT/Q2vPJvlM3GbtAe772ScxL2rkF4XVLwlzrbNCZnW2z4pR08r+SnS2OuM9TaO8vPhMI
	 5piACuGdDeFV14ceDLXltCBCew0cHuXPWrl6tX3Vj2trqiyD00J+yWDu9q51RqhbzN/1I
	 nUVok55HvlLQj5PnJmclyfJ/cHu/F0synoLH3hxE5XNOd6Bw2z63L5hf03CR2KTUgmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GNADXg2V622Yxr65qM2wv5tZQIWoR6xmp2ryOsAa94w=;
	b=yi+4RKs9ufVtw4KjcIseOpOjof3QooeNGr4pcgmMjvO/ww4Fk9XwjDUFJPN2ob/fE2IK
	 6X2uaRHJeGvwfQKiXeCJpLqewFG5d10EWGxCFuWib116iiUVokAEo8rQrGCCkiErTusOT
	 XSDZE9XLilqiqSUcXXS3fTs5sETCwv50cvcyVn61CehR0sq71GFEe7dGdzNy2X8AS4Iq/
	 CmE5O5GS557bPYkLVH0oFyoD1Rn7IGue/+5aK595IotWr4f0ylEZuJGxSlF/YN061pIgd
	 gDK9Wx4WmbwvedntrU64B7eO+a59WmfNr4BLQ7gDs4aooKlDyI7uw+k3dAUR55Jmw2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SySVkDVK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C138606A31B
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SySVkDVK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BD71F01829;
	Mon, 26 Oct 2026 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058610;
	bh=GNADXg2V622Yxr65qM2wv5tZQIWoR6xmp2ryOsAa94w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SySVkDVK6d1oLzJJpX2sAaWXZRnj+w8HrRYi+g9VJN4HoSRC36CjYpOKZyJXryzrc
	 kSdLtf6xQ48b1CxXmfmSFwFZOmFfsYhySN0Y8IRAgi6/jtitnC+moHgLLO7T/dTyqN
	 57tU94FBXmgFAE+1dyk6jugVZO2VCtE9UmKMxjsbR7M0jqY7QlMZKNJMX86fC7wJt+
	 TvkJHYq4t5ockur9xLiyuJCeZ5P9Wfh/cxY6qg0BrQ73NwPTvtQGUs5dWG+nj4HEHK
	 1B96+PUw/iHRtnFw4rXFqiR2MPWALSpo/fqzYlRqHvG5Dxwh54OI8BSVzyLg/xzWic
	 Wlnd8Owx/35wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 072893AA80F1;
	Mon, 26 Oct 2026 23:50:10 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] ipmr, ip6mr: Fix several info leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305860867.3465814.11702728052795787601.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:50:08 +0000
References: <20261025071729.34967-1-idosch@nvidia.com>
In-Reply-To: <20261025071729.34967-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org,
 yoshfuji@linux-ipv6.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Oct 2026 09:17:27 +0200 you wrote:
> ip{,6}mr_cache_report() copy the IP header of a packet that triggered an
> upcall to a report packet that is delivered to user space. The header
> is not always fully initialized or present, resulting in info leaks
> flagged by KMSAN.
> 
> Patch 1 fixes an info leak in the RTM_GETROUTE path, caused by the fact
> that ipmr_get_route() does not fully initialize the IP header of the
> packet that it creates. IPv6 does not suffer from this problem.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipmr: fully initialize the synthetic IP header in ipmr_get_route()
    https://git.kernel.org/netdev/net/c/134351edc28e
  - [net,2/2] ipmr, ip6mr: validate packets injected into the register vif on xmit
    https://git.kernel.org/netdev/net/c/aa1799e93f5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


