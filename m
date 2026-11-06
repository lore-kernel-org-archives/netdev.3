Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005420;
	b=0uwiac2zwlGmQkEGVIjwpNVES0EfPLO32IAGegdKYxCSlVPm1B2OIlBCsEqOd1j7+K60
	 M+FO2u48eCio6o5aIN8knDPnnBZr+oTtlQwmLoAOMn/qmF59PGwnip2EcurpetwTq2yFj
	 2nX2pkkMceiy3xhTciIqxUbV1pl+YGggZ4xhAWO5sHQZbLFdKaxv6bjWVSy4udwLCrgsw
	 N0wC4D3QUGj3ZJAYxMoj74lmV4RncFC89RW6355K/j+41L9pRJTdiHsfeKrH4S2Lq47zj
	 CQRURnQvet2aBAmgqXbI19Q5NrbY49gmcbbt51dFKbQ0Z/nXlaW5orsVeMA23WgbtPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005420;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=h4VSmwTZV0YWOykh4jILTENaZMSACTGbnBlQyMHdOos=;
	b=j9O/fIluJOd9u39abMBXWA1wF9RaiWeKyz6TJyxFTIE8ewbILMFMkjwhiGw5z+P6ggFc
	 McX1CjW9e7NBU4+J0H0i1kavOEk+TTiS2nOS3pdat2jDPvs5k8dDxwGSUHEzzvKOP5+0X
	 AtV5wAaQqgUhe8y79KY6uYUkEEN9QyLHDra9hbvb4IlRMKYNoVoqgUUhOFyzSsio8M3u3
	 r2lYzTRGxU5h5x7hnFqz4CRkipCtSp6kTA6EbFnZDkbdMiNKO8bnXJmYZ6OJw+ScarToO
	 KuK7wRA7zBwwfzEdPss4XvjDA3O22zABIWEiK1XGITo4WEGmyZqEc98Drz3dOqN7wXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiyJ6uD1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BC7606A333
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiyJ6uD1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6491F008A3;
	Fri,  6 Nov 2026 22:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794005420;
	bh=h4VSmwTZV0YWOykh4jILTENaZMSACTGbnBlQyMHdOos=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DiyJ6uD1/EFA0g9aC6UAi2xsPWUeiMRvU3PryzvVVeTbef/gGHXVqvIyLXILCOe2b
	 3YdXP9Rqbg6UWGEzUHegyrOWTcI9oqFjuaEp6rWeQUJv7+1n+IMrWtDBAdFLrCL8+f
	 FLUqjWRZFr8YC1IhNWjd4Az/AN/0hnWvYzVZC++N266quGL3w7rpE+UfdZLd/ILk5H
	 xRWWbMvy6HQQwp/aK5FkiKQI53vKrUXBFxkPgVoR16SgDQJtAquKhq8YBA+npm+pXS
	 02/6an4T90v+awy3aTNOHtH3LHCA7gj7fZwdrMJ8SPguCLCMfZfgy5KtQIhjc2aTps
	 gwWgJgH+W5Yaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2120C3A55EC2;
	Fri,  6 Nov 2026 22:50:20 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: skbuff: replace ubuf_info ops ptr with type
 id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400541867.914342.2798395680614428990.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:50:18 +0000
References: <20261103194625.1628600-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20261103194625.1628600-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, paul@xen.org,
 wei.liu@kernel.org, mst@redhat.com, axboe@kernel.dk, josef@toxicpanda.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 14:46:20 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Avoid an easily corruptible callback pointer on skb linear
> out-of-bounds write bugs.
> 
> skb_shinfo(skb)->destructor_arg points to a struct ubuf_info, whose
> first member is a ubuf_info_ops vtable pointer. Corrupting
> skb_shared_info gives a trivial one-hop indirect call primitive via
> uarg->ops->complete.
> 
> [...]

Here is the summary with links:
  - [net-next] net: skbuff: replace ubuf_info ops ptr with type id
    https://git.kernel.org/netdev/net-next/c/ecca9bb2c855

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


