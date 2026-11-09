Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268209;
	b=cibRE/O/HV4wioHA6z8aRY3JUXdmYssr11O+SrOoUqnh4QR3prmpaHAeKZynENEbpOPD
	 8hwerwWBaLj/qiHw4kcy4/2NsM+zCTjcQryPF/VmOsZHDgkktGb2C8MSqMkAyUEluWJAN
	 KX1OlEo93sl4W1yBMmN9RHLmPHIUZapK8vKVvi4TLhSG2VUXD1+OFEZbQ+9ggBnTiF2A0
	 5Ll0Q1K/rtufzmh8ZXOq/dKpuqRGIwHgxb1kJNSZLA9B607crqJPZktH/mxGk5AgQYlNH
	 q+LXgpyceVtg8A3av+HscsRRbW7hKB1BYIKBqvs1J+l6PRKcmj/lE9l55AnIOk9+qKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Y83HRkY/LmVgU3iStIYCp6YWSoUwvJI8yTrNCQGOEM0=;
	b=0oaWS0EvoFSBhtOkyw9AAUYxbyHeqKdl6uyL1CO28j7Z7pSVNlYcAt8N2uc1iHvYGdhy
	 3rXS/Fc+oeZAfhu4c9NmItbjVG6sQPU/jmAAqB7wyVuUbhrMH8bpeYE8BWQGyeNkAIIQV
	 Bu/E6bfrvQPr5H6DDxjdkWBlCgde/iKkhx/Kn8PI0driZoBiVbIzsJQ4c70qoI9vAd4Na
	 yghEFVYno/NcW6n9HAgi++z92IhfnNAL0PLJRjScJtu5tc1Yjz8umhSjnwNfpKh9E8A7o
	 rxkP7DneIXABvwJhXtI8xBV9B4mNsXgEX1MiFTyQ6ZRplL2zdmROxlc5Rm/xwEKc7Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FA62VwPM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AC606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FA62VwPM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72D81F008A1;
	Mon,  9 Nov 2026 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268208;
	bh=Y83HRkY/LmVgU3iStIYCp6YWSoUwvJI8yTrNCQGOEM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FA62VwPMXrBLWB9OK2GqAkeVwm/UY9eBt/pbqY7WnK84GE5bC1hQ2Q+ycpIK7Gqq5
	 UTsI/4vRA3Ky8pLrHONEnKLxAR5uE7lBfYC0A0ZnfXzi2uZW3oGWpCUQqxDzXTCvz3
	 O2uQzg+Nt4veyTVQ2XLe6aRqp37X5z8pXpMHnqscCuuqRN6VIxbi2R8JQ+T6vXN/Q9
	 NliXyuxHrr8VLgEzZEATizMmAz/WdCj2BJG122+y02y7mR9qovpmfs7Uw3Tva7GHnz
	 BjJVWDP/ICwjo+tXHv86jYBH9XgmUJjHosol/HCpaJWfPUHUDiGjaz6G7w8nY8Yvfa
	 eg/p4t2JBeoEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B203391AFA7;
	Mon,  9 Nov 2026 23:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net 0/9] xsk: ZC mbuf fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426820742.3549724.11101369868701539708.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:50:07 +0000
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org, zuomao338@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 13:49:41 +0100 you wrote:
> Welcome,
> 
> Nagato Shiratana reported that duplicate fill ring addresses in aligned
> mode let a driver pass the same buffer to xsk_buff_add_frag() twice.
> This corrupts pool->xskb_list and can lead to a NULL pointer
> dereference in xp_free(). Patch 1 makes xsk_buff_add_frag() reject
> such buffers.
> 
> [...]

Here is the summary with links:
  - [net,1/9] xsk: fix list corruption in xsk_buff_add_frag()
    https://git.kernel.org/netdev/net/c/94ae1259175f
  - [net,2/9] i40e: xsk: fix xsk_buff_add_frag() error handling in Rx
    https://git.kernel.org/netdev/net/c/a259b7ec09ef
  - [net,3/9] ice: xsk: fix leaking Rx buffers in multi-buffer path
    https://git.kernel.org/netdev/net/c/8b7bd01b9c56
  - [net,4/9] ice: xsk: do not free in-flight frags on XDP_TX completion
    https://git.kernel.org/netdev/net/c/5a9b5e315e10
  - [net,5/9] libeth: xsk: do not free in-flight frags on XDP_TX completion
    https://git.kernel.org/netdev/net/c/90e5d84086d9
  - [net,6/9] xsk: do not clear frags flag when acquiring a buffer
    https://git.kernel.org/netdev/net/c/e4ea8671cb79
  - [net,7/9] i40e: xsk: fix multi-buffer XDP_PASS skb construction
    https://git.kernel.org/netdev/net/c/76b41e83e69a
  - [net,8/9] ice: xsk: free stashed Rx frame when cleaning the ring
    https://git.kernel.org/netdev/net/c/d5e7a86b7cd6
  - [net,9/9] idpf: free stashed XSk Rx frame when releasing the queue
    https://git.kernel.org/netdev/net/c/3cbee39da825

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


