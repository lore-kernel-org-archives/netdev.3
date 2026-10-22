Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629020;
	b=QrYnQPXp8IMX9U6QSQLFl1xyAJpE0Nt3l5YEdERkh6GDSSvE4IVkGeT02LVrSWYAHTKP
	 +gG/laHg6GP6A+XwA6xtMp4GDpGq05JBQsIT8mthGkac5oEQlxj+r2u96RqggucfZxCCM
	 sZKvKovCrlgfl610Y4Pia7PqDpYCwAVVcxF+AH8KOXrZU/bokXN6QgAL4r4VCHTeFz/yd
	 5lriHUWNejmVxKrsVsbZ6Ese8lhurVapdR2Tmr5TgHGtqR+D2BzlMp6OiuokV494rEZfI
	 AyAzi5DYMnSIrst0962W1zW3xvogcbgbTlwaNKeAokTB5Yms+AJ97Dj57oOOsVQzj+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629020;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8pNHSkapv5Hh6MFB+4Zfh9P0PKU9Hwu71Ww3kljWSoU=;
	b=FO5moAbEh8mmolUha1pueaR32HSwrR9jLY4KZM41iOVPpDoKlkag0zXuiR6G34jk/bkn
	 JCXTPNPmbHquguqi0USZ8/fyD8Azw6BO0j7CVTGcy8ujC/jLKwy1yrfHVFbeIC/OZSqj2
	 41pbahL8siJKVUcOrNt/R+94WH+Pc3GvfYkkhr0aXFG36VZwns3bFZgI8DqZMJZA8jNv+
	 wWyEzp63gjdY+5B4GcR6zWNBBb8gXM4GTGlYHO7qODAJdleA97QRrHqLaLz+17HdMR3sa
	 v3TFmYgJA+CCIc3PG1SEyNkkCi57yId6v0oA0QxLULU+JlrpWsgelCg8tntA9lOVtyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWRsxr+z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5D606A339
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWRsxr+z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092A21F000CA;
	Thu, 22 Oct 2026 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629020;
	bh=8pNHSkapv5Hh6MFB+4Zfh9P0PKU9Hwu71Ww3kljWSoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jWRsxr+zLKzt7XBLSobKNzmkFtzJ5fORq2o/RidN5BH8Z6pPwjucJiPHMdiZQUNsQ
	 rAbL0YAuKamGhYZgpJwm5s+zMv93m4SVIjIgYlEfACyVo8XHSxLyss035VEhSFmEAs
	 uKgyZ3AZYHMGqp+xki/rxp8VSAzGT+0vHOKjiHPIioqIvbPETU6YJC4i6DuPZ9qb3/
	 7neD8dGZ/FNuPeKkriE1TuIATv46QS90IF6NUSzqpuNCZwg6ddyTOBTSf0LtH5kAaq
	 ///9UGOPjti2Bh4RZZJnNCbxz8NJV5Dx1yxAKhImlzkQFYK0pHRgM2XjqTR2z+w5ld
	 /tCQ9dq+5E5FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13EA380A963;
	Thu, 22 Oct 2026 00:30:19 +0000 (UTC)
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
Subject: Re: [PATCH net] virtio-net: fix frag overflow in big packets receive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262901854.1378903.15801370235793249806.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:18 +0000
References: <20261020032108.81879-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20261020032108.81879-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 23:15:50 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> In big packets mode with guest GSO, add_recvbuf_big() posts a chain of
> MAX_SKB_FRAGS + 1 pages. page_to_skb() copies only ETH_HLEN of the
> first page into the linear area and adds the rest of that page as a
> frag, then one frag per remaining page. A device that fills the entire
> buffer therefore causes MAX_SKB_FRAGS + 1 frags, writing one
> skb_frag_t past the end of skb_shinfo(skb)->frags[].
> 
> [...]

Here is the summary with links:
  - [net] virtio-net: fix frag overflow in big packets receive
    https://git.kernel.org/netdev/net/c/b0e4ea3a0cd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


