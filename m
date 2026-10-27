Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793065207;
	b=15yoQP4wbepIgJs26/q3R6MrAUNA5xka2ii4szLdW/+wqZrK9wwhoXsUeXW2czqQV84y
	 g7HT6iM8wTFsDkI3nQHkTXoJ62Xky5fc51lvuZeUiQVm46ZEe48/J+coe8uoHZqZwJXlA
	 NCd3WkZHKSamlkdLyl+jhsbzC6KMoY8wVFbhIRdYFLb2/4ZQOvLnx47F4aYJvVxH1XxWD
	 DgbN4KK0ZKUOMlD5bMxKBUx0bU97IoagvJ7pWN75m5LtAXQc89fpANJCMsAq3IpBhEVAi
	 VGADaKC7qytUHnIMeLqdmxt2cbYruvrx7ozd3NgtnxrWlSn1uQNRA2sWkZK7A3LXuzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793065207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=oLLGLsviN+AyNUwtthLtGQRS/ZFe1aWIbjzfKtVXnoI=;
	b=ec+CL2sJuMccwl7xcf74LxlDlM6VLEUEWtLyzcJZj7VhZC1yUj5hrEvkUs5UHv0E6kAK
	 PBqfQZUMqKaAN2elpvGcErCu3z5+53nVOTWSXteZJGGb8DRuYbKywcgU0fF+VQxnVc0kC
	 0ytVcv1cRmUB8cM8IdFXJLcpuVJELU3aHO1r0ly1IZJWVvz0oYDoGJlKMp0RCqU/Ravdo
	 9CEpPLXM7nflz2jtrCuG5URtoMUKZ7ORzaQRoSG+MngRqoUsBL66Bkz+f4ht2r6+oQ2tr
	 ew1mYlZBU2ujH8zlVJfpF6o2KlpxIx/Ow5y8yTnbwCyAYlS7yKLjxgvR7fvn8Bvq4Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i73fqt55;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33357606A32D;
	Tue, 27 Oct 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i73fqt55
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D801F01825;
	Tue, 27 Oct 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793065206;
	bh=oLLGLsviN+AyNUwtthLtGQRS/ZFe1aWIbjzfKtVXnoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i73fqt558eAnmGmhGUYMZnaF1B+DYgoGrf0uh6aV2cWpFpgZfCNDmbrIEJyR29c+t
	 rut+VhYotqssVs85f0xKoDiKUwXFiS17OzVVedCdJG+1hWnPaCj7Vz8hUCdl+Ei7sk
	 SF2zB9vUZnoWee/Ihzk/a6h/+++0ibndt2kXGFYWbJGsvbDPO0Qz90/Txwhw6XjNEy
	 BpeHaejIFHpMqWmW9FumIP+nVRHEeAL338G6kz3NsHFiB6afYWI5u2fSnBic+TANVi
	 DCtBCmgAVF8yneqrQ1V7iQKxus7ALUBRq2HHXOqmWMZu/Rz6n2VqtXiRoLaSuzbGjd
	 tCeNK0n55iYhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE57A3AA80F1;
	Tue, 27 Oct 2026 01:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/2] net: usb: cdc_ncm/cdc_mbim: fix netpoll lockup
 in tx_fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179306520565.3504795.7927315467376347222.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 01:40:05 +0000
References: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
In-Reply-To: <20261024-cdc-ncm-netpoll-v3-0-6284ca03f967@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: oliver@neukum.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 sjur.brandeland@stericsson.com, alexey.orishko@gmail.com, bjorn@mork.no,
 gsuarez@smithmicro.com, leitao@debian.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mke@visotia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Oct 2026 15:23:05 +0200 you wrote:
> Mikkel reported lockups with netconsole on a cdc_ncm device. Further
> analysis showed that netpoll calls ndo_start_xmit() with IRQs off but
> BHs on while holding the txq lock, and the spin_unlock_bh() in the
> tx_fixup paths runs pending softirqs. A transmit from one of them then
> spins on that txq lock.
> 
> Patch 1 fixes cdc_ncm. Mikkel tested the v2 version of it. Patch 2
> fixes the same code in cdc_mbim and is untested.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: usb: cdc_ncm: don't enable BHs in tx_fixup under netpoll
    https://git.kernel.org/netdev/net/c/108ca34cf4b4
  - [net,v3,2/2] net: usb: cdc_mbim: don't enable BHs in tx_fixup under netpoll
    https://git.kernel.org/netdev/net/c/bfd7ced012c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


