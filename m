Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AE4AAC4D;
	Wed, 30 Sep 2026 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811609; cv=none; b=QHsHQgbjxZMpzbKFjDbNdZGBQRj2LI2xGYOUmDCpl3ddPux/wUItwIC6f1LouE6mPhcWAtPVaJSTEziVLFtkkibrELu4AQ1yQxE4jrm+jub+Yn1W9ntg6EO8PP7ci5g/WYweI4uOk//zrJNzIp2wc8tcHnu1N/H8jzQk+mL5CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811609; c=relaxed/simple;
	bh=MuJJzogIWf+b8hhSHabl/t2tZ67qmfqYX9MKSpRSRIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J4OWWIYEJ979HyTevaS2rzPB+bzgDrX6Ne1RkRIEGM8dI08BzP8Mzb+voQY+IFFvJEFXuVQcHEW2EzQ2Yw5zJ5jr1HqE551UCwQXarwP6lIXERlSx7HT2BTl3zTzTXQcREYyLqNPcqu1FTni1MigGOX72JuIVqC68bm2DaZlY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLT364Aq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLT364Aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B496C1F000FF;
	Wed, 30 Sep 2026 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790811607;
	bh=4snq0PtxiqOoej1Z7MUMqVQjAW3Bf/CxiJhsKpu6mNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OLT364Aq0g2Bav5DIbQYk5cQxdaocKIiQRJRGmnF594v5Vvks4uesOjfax2IlSrSE
	 Rmlj0Or4xsyr0mm7JOqeLA+SbEvg5Uh7TXGTMtmqXxcDR0lpao5NGYXcQxzAVB+q/b
	 n06oOBVYeFmSq8AOiC37vfzsc8YjnKIT6DRql7kwCQGhtObw2OuoDmQc5aB7CPDH2b
	 NPcUoDx7j4vUfGirsCtfZYxut1dZQJ/GuoxxVoi257HulsjkwfM3WVOmDJtTgUlKD1
	 aqNYXkK5x4Qo1brKSaf4nHc7tODFZLymaIiLyvufiHF0TNkUEHhNrMf5YUVC+L4QR3
	 q+jie4Z/eWxuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AA31139EAF51;
	Wed, 30 Sep 2026 23:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] seg6: reallocate the skb head on L2
 encapsulation only when needed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081160653.2175258.10702581891378114546.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 23:40:06 +0000
References: <20260925-seg6-l2cow-v3-1-fc83821542a7@gmail.com>
In-Reply-To: <20260925-seg6-l2cow-v3-1-fc83821542a7@gmail.com>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 23:49:53 +0900 you wrote:
> The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
> on every packet, where the IPv6 encapsulation modes reallocate only when
> they have to.  Ask for the whole encapsulation up front instead, so that
> the reallocation happens at most once and only when the headroom really
> is too small:
> 
>   skb->mac_len + sizeof(struct ipv6hdr) + ipv6_optlen(tinfo->srh)
>   + dst_dev_overhead(cache_dst, skb)
> 
> [...]

Here is the summary with links:
  - [net-next,v3] seg6: reallocate the skb head on L2 encapsulation only when needed
    https://git.kernel.org/netdev/net-next/c/bf515c9fae87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


