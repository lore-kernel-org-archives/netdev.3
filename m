Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802608;
	b=gJm4zj05llkdpUvQfkqL4wBdLC0tJls2oQRd3tnEfGEWXa3ZyMAa4Wn2BiCxZ4bZuMeL
	 CEPuXMSeS3NRia9kE1BeDHa1JCqXKDz20pJ2/73V03C0QCp9tpn1e/cvpxVjInHK2Z2uL
	 GLUsk3/la0FfnDUNh+lnPwOIRXH9qZoXuhbeMrbjsyZVj9y0Uav/0f8T4TczicqW1nA+f
	 ASxXV4tWKi4qUAefa1p1cWdsckmgXb62PEJvwKtbkC4Lh+jbJwuLVUHDBq3vsAkO2FcGZ
	 xMi/LCIZvmlKnLiFyWAil5sJ2MeG1vtpDjQJLJURYoG8IEOeKYln52tfVgslbTvJlfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=m6jyuYJ+k/aJVgQSBraKmOICtvoXZbUo7d6My8LNfAg=;
	b=Xtqzd8SfZzSfpXnzgD2LARIPLNZeSrz97A/zKr5KV1/1E4wONBkyzbmyaBiBUrRKJ+bU
	 zwji/8R59bMmi0181t8Czl2kH8GXSjdywzC/xMIPicQ+sH5EuxIBIawAzTrwDywP6iY9/
	 lQroo+9iqIdigSaxsbY9ghr9LrwljB9bhTqOGZx0CilFVdi8jyfsR/cHckGBlv5t8nrVT
	 2RXqygn34c7h/uom7/Iyd+/b/WBZCIbCOPpYtZVB8ZdIxykfnogKsoaEHrw0PA3t1RRc7
	 S1cVEiGtObiGcKuYf7pp9Voes28/Ja6hGdKxKPs1wMzoynN8p8xJSBEGaJUh5b2x/UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0nd6YTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38269606D802;
	Wed,  4 Nov 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0nd6YTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBAE1F00919;
	Wed,  4 Nov 2026 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802608;
	bh=m6jyuYJ+k/aJVgQSBraKmOICtvoXZbUo7d6My8LNfAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h0nd6YTZ5/ShRgRjgA0JrYnUypdvSeEMgXEXt/yHTrQ3Q/aDRzRmlNwxQOTgOOhJ/
	 JutxJ/2h+sVbi0tLNNrFLKWyVssrOChy0HQ7ZLbO6rpdG9N+0cNgAeztSa0DUiyabW
	 Eisg9HPiczhXzkofv/uvL8Vi5MfgtIopdJE9ttFkiyzapX7Y7FEEwERqjc8LkoZ0ev
	 2Zy2ylE4OB417vNCsr2NtvvH3ZZDNIrnQN+fGxCFZUIM1oj2sxDm0lMKEbAFjvWJpq
	 laKdSrAie15LkcmMwsDzTZ1Aso0G+4HAMhbowHox2Oa81DBCCqvxdXKMpoeovhqcxY
	 sUyZ0eEel/Efg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0306339E8A46;
	Wed,  4 Nov 2026 14:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net] net: skbuff: reject zero MPLS TTL before decrementing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179380260654.2859910.17192610571456946539.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 14:30:06 +0000
References: <20261031114135.3784868-2-thnkslprpt@gmail.com>
In-Reply-To: <20261031114135.3784868-2-thnkslprpt@gmail.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, willemb@google.com, almasrymina@google.com,
 josef@toxicpanda.com, jiayuan.chen@linux.dev, john.hurley@netronome.com,
 xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Oct 2026 13:41:35 +0200 you wrote:
> skb_mpls_dec_ttl() decrements the u8 TTL before checking whether it
> expired. An incoming TTL of zero wraps to 255, causing the TC MPLS
> dec_ttl action to pass an expired packet instead of dropping it.
> 
> Reject a zero TTL before the decrement while preserving the existing
> behavior for TTL one and valid TTL values.
> 
> [...]

Here is the summary with links:
  - [net] net: skbuff: reject zero MPLS TTL before decrementing
    https://git.kernel.org/netdev/net/c/24614e72df48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


