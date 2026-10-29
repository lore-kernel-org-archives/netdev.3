Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236207;
	b=jj/bc92/QiE+bdwewpLC/m5qOyrVPWCbhiIw9qgjdKo9kOZBLxuaSdCcdc6qcFvzCDUq
	 fdRmMqhaTWxE9X5He42UyAuc3pQtzYCRZD/Quf6xGXU8m2zZupL9Dv5Ym39SzF4pxLs4M
	 RxkKLavK17h9BxTtVMPAdwROo19DVfNFUVKZZqeHruVR7XJJv5LS9U2PyY7GxXGdLnQtN
	 J9jePe4bwWEhAkoOp9tGdqonxMGPb7eVekjXziI0AB4EROEV5ro9EBRwuYK2WYUCWKX/o
	 kID+/tV1rfQ4PIsMUer+8uPp5v/4rZoJ6odWVJxUUFqzGT0B0dXtmcHFim4fx7W+mjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=AFoxfU//d4qlReBac57JgO7jz3HB/QUBbUj1QJrbioE=;
	b=MjpwFh+d0WtjrC9SsbzJrw6V11qkHunjUJ9n6bhRMZ+Q7LDMRsD0j3/0NOIL67UGOOko
	 N9HFGLOV/Y6yOr0IS4ozD0RECepN/winaycSrRV4PYaPjvqGR0gSeoPvIaGSOI61hJGzG
	 7r1pt5KEhoc/5rScZdz5gUKAmbifU5HhTh6KuB6LddbvCE7Hpwa/eL9s6voj2ExLnGT/d
	 ss5s0eI29SVcn5U+jwoQcB8sXVRGoSiVwhMl/yA1v65tF1Q2A5w6kwHsi8biSsCoXEH1w
	 mIYQDYiV737ayGk4/Mn2MsTCqI+DSXPkXoIKE1XdhsmjvpdlJOr9K+ZfgJkkTk7gBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWuH7B+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3B606A31A;
	Thu, 29 Oct 2026 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWuH7B+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122591F01825;
	Thu, 29 Oct 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793236207;
	bh=AFoxfU//d4qlReBac57JgO7jz3HB/QUBbUj1QJrbioE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cWuH7B+U9Kb8WjHuAk71JGmsTD/xA/Kz8d39UnA2pvlaJkscH0behX1Xm9/yHCW0V
	 ZUATZgl5Gwcgz3zgOYVZ44jyJY/yasSRtGntJLdPL54AZ7KTMbq8DJn4MUr37XWOMQ
	 tCDJ90JPNwbdMDJ1GrC6a6htBqIHZ/LTd5BAJqXTfR24Eip9KhQqxwsSG32aowIMEF
	 RKj+J6B1H6dXg8taDrtw7GNGlhHaOdV7FiNRWjq+PkdenC/gikYxxN5IamdXH34sFe
	 qAqC3z0CwpBA6ayse+kNMFjc4Z+8JuGsZObuEtkQx1aGQ44rKuIx7jYhSUuWsxxjsn
	 8Eh0bad2jEYjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074053AAFC4F;
	Thu, 29 Oct 2026 01:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] bnge fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323620582.1509723.16740327442394388157.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 01:10:05 +0000
References: <20261026092757.9168-1-vikas.gupta@broadcom.com>
In-Reply-To: <20261026092757.9168-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Oct 2026 14:57:55 +0530 you wrote:
> Hi,
> 
> This series fixes RSS indirection table and context sizing for large RX
> ring counts. Patch 1 caps the hardware RSS context count and RX rings
> to the RSS table size, preventing out-of-bounds writes and an oversized
> memset(). Patch 2 fixes the indirection table sizing so rings above
> the table size still receive default RSS traffic.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] bnge: cap RSS contexts and RX rings to the RSS table size
    https://git.kernel.org/netdev/net/c/e8f6ca11167d
  - [net,v3,2/2] bnge: fix RSS table sizing for large RX ring counts
    https://git.kernel.org/netdev/net/c/8b97091eae74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


