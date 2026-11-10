Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279304;
	b=RG0IGP7qF4vdi04UeEXCkWtYx8ZU7aXz4ziU12EKck0HfYDPPIDoACGQEBVCsoi8tUic
	 MylvT9dYQXwaDiKp8wA+6WSlRYUGS+t19UqHB9F/sbif9fZ7M9yEwM/p2tLuqOiRtQGdI
	 rVehy39B0TEeBo0jpvVcV0YUVlaylq0UMC2gZxJykKCezk9vXsnjYZWw9eLpqUbXZX1CK
	 u6kVEZ2Rsokt5Ug5Z7wn76WOm8+ML2tVfGIAOuvaGLJjA/ix+aCR5FFX7hSbh6Zeb0iXS
	 eHkLO40jgJqYLQ/wkCeCNOHFQGEQGRri2YWE4LYzsz1HiR5gc2e0b/zPW4P/D613Wqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279304;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ywQ2RoGdhlkeDV6w/mm5sM6eufyYYmhH+3GSzk0jG2Y=;
	b=aMZfGicS/cWhlqZMb8jnMshq2fkr5rdN00vti4BpOx8jYurKBd+aYYQUx1PU0vRDvZ/s
	 ojt7GKsNlEAPO+KoIqQM7UW0+c8s+PKSzXxk83Ig9e85UU/suNQ3chnrYBiQ6UKp2lqSj
	 A51hAMreUgLzrmBazrqh5edH8aBhwYGfzedfk/GKqFWj2p5vKK7lWOTAb3ovpgTqgrGEl
	 tF6UDmsoXMVG5VyISQLeiwB1WluT3X+lbzw+V8LhHXifjCR4JK0ggoR6L4szCtfwX5/Ea
	 47/zennLL73TUzlmEGXkq9ru4gH8J45UfgkUuDxiZPagX81gbQ1TopNovhHTGgiHJlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCb3ibf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2760A6F6B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCb3ibf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B071F0089F;
	Tue, 10 Nov 2026 02:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279304;
	bh=ywQ2RoGdhlkeDV6w/mm5sM6eufyYYmhH+3GSzk0jG2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PCb3ibf7P8ZjaZGl6/Jy0KWuchCxExY3Y+0/8lZ9BL9tUKdpiwKBmJ97dkBmeGzTL
	 qPapojco2UbQEwykTbUY25OFps24ryRRAb24kE3Cp8bgaF3o7mDJTXegMTGIQ7Vf5u
	 bKLawD8k5LxIqijOGKHYGYBm4B17Y5jKz0Vhq/L5S10HZuSvK6RNMVyvK4p4MHpFCj
	 K73UWamwZS0xdRfqRt/QvMGbHArXcsHl7lyMPux0dA83FfO/gbyMxqNWoV3qDipJdF
	 2sxLO5Xa2OEkpqAqgXwTclvD4qZp9RJl50cHagWtUdvdvBHjKYHYaK93JYaY2wd0kR
	 bjGCSC/oxmX4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2ADC5391AFCB;
	Tue, 10 Nov 2026 02:55:04 +0000 (UTC)
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
Subject: Re: [PATCH net] ipvlan: make outbound skb headers writable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427930292.3612825.12017413725749529323.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:02 +0000
References: <20261104113530.986664-1-edumazet@kernel.org>
In-Reply-To: <20261104113530.986664-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, maheshb@google.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 12:35:30 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> In L3 and L3S modes, ipvlan_process_v4_outbound() and
> ipvlan_process_v6_outbound() hand the skb to ip_local_out() and
> ip6_local_out(). The IP output path assumes it owns the network header:
> __ip_local_out() rewrites tot_len and the header checksum, and
> transport-mode XFRM can memmove the network header into the headroom
> when xfrm_skb_check_space() finds enough room, without copying.
> 
> [...]

Here is the summary with links:
  - [net] ipvlan: make outbound skb headers writable
    https://git.kernel.org/netdev/net/c/a45dbf182137

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


