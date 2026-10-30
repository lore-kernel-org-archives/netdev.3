Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319007;
	b=k+7B2pJW9zRvTZ9DDlhMffKvinatWCmm/14xNJheZJpc8TN7VfI9ZEt2pHX1BYWe81QM
	 sAfr2K7fwMBE+/ujHyecER501UER3SmWxKDTRyz+2GdFyCRlGAk6+n5UqssNNYeLq8Shm
	 fLv9Ap+GmGid9j2c2GphKsbUBYAU+lLD5ljishDCye4Rwcs/wEpmqVG9NiCHd/BxE8riT
	 aOt7GvgqePajnl4G8ml02Yi6Xnx6xArMMbsT/a7RQe+KdmjKdeM+0BNRoGnoHT5m/U3HF
	 aqt1fJFCAlrBbNoa2bllCXu3losqDf0cRt8X5K0gSfT8VH/DSJG/xCTYm4peMxmIvcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pWoNgUMhu7f6Bg0gcQhal7eYxCy9+QMlzZwQNSLvPzI=;
	b=V/x/oE+FZ0rpNFlDzHRz3iP8krlA5MPbx2MQAxxieClhRrAjTZkDhLqANEnVo25fUrKE
	 d9WMFfQHYVgSGByccTeOU2r9HybTdpyQNRU7IR5lzaeHvpXjP5ye5onEOuyQ+LAaJTqm9
	 6QuRpQv2ZrqadtZf6J87AN8zG3h2szin4xHboJ2Xa/NBX2oJexczBlX5Fmwm1lyjUz8TL
	 f4v6r81st0T0FO3ud4KFN55Olr1ZQvzFkXGose1CLdEdLJ12IzPKDYlrC+S7T9rBH7I3l
	 o/u11SeBKT4opeIVQpCiausc2mpLHa08qVGNOXR/0K3DBYYVs1LqjcZO+pKEVAVDOEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+eGMUb6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DBB606A31C;
	Fri, 30 Oct 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+eGMUb6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8741F1F000C1;
	Fri, 30 Oct 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793319006;
	bh=pWoNgUMhu7f6Bg0gcQhal7eYxCy9+QMlzZwQNSLvPzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R+eGMUb6/qffY31rSuBNjPPXRP5YNysbdw+KDZmlISsOcrDOuTkrvfbAv8LSZ38xG
	 2/+uPGh2M5buu3u7j+z8CDxs3/cf8/nV9owMpYz1woLvBdHK573ZzoWMRP0w3g87PO
	 yuN4qDaVYtD8fodgOfE5LpKETyMVF3exUfIZW486nhqgbRlH5Yxatyf+D+819hS1Kq
	 rfDn6oChrkofdi04gNPQ82KeVqfKK3/JCKqrOqgco4oJkzkQ4cKBCSK6aAifziA915
	 wmK+jTEGlYdVIAJ7QjioFs8WaO5jaZobwr8ZfMJ6yv6htJlgkXkjn5Oe0MPDFnCbt7
	 XyjjSb4z2VRUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1E338007D3;
	Fri, 30 Oct 2026 00:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] seg6: fix transport header for inner IPv4 with IP
 options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179331900509.763714.8850893492667145645.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 00:10:05 +0000
References: <20261028171511.35-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20261028171511.35-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.lebrun@uclouvain.be,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 dsahern@kernel.org, hazleycryilis@gmail.com, hangbin.liu@linux.dev,
 stefano.salsano@uniroma2.it, liuhangbin@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 18:15:11 +0100 you wrote:
> The End.DT4, End.DT46 (its IPv4 path only) and End.DX4 behaviors set the
> transport header of the decapsulated IPv4 packet at a fixed 20 bytes, the
> size of an IPv4 header without options. They do not validate the header
> length either. With options, the transport header points at the first
> option byte. The effects include:
> - ping -R sends an echo request with a 60-byte IPv4 header to a local
>   address through an End.DT4 or an End.DX4 SID. Since icmp_rcv()
>   computes the ICMP checksum from the first option byte, the request
>   fails the check and is counted in IcmpInCsumErrors.
> - A UDP datagram can reach a port that an iptables rule drops. The rule
>   checks the UDP header after the full IPv4 header, while the socket
>   lookup reads it at the fixed 20-byte offset.
> - With an inbound AH state, ah_input() reads the AH header at the fixed
>   20-byte offset, but copies the IPv4 header over it with the length in
>   the IHL field. A packet shorter than that length can make ah_input()
>   write past the end of the data, into skb_shared_info when the skb has
>   no tailroom.
> 
> [...]

Here is the summary with links:
  - [net,v2] seg6: fix transport header for inner IPv4 with IP options
    https://git.kernel.org/netdev/net/c/5838f10563d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


