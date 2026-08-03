Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556C743744A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783649; cv=none; b=cDgBZ9IoDfVdKUIsR+ijo8EYa9YN/afC4bGbNe325I0AdAKCTrMd9gJJfCAu8Qm7K7ZlJQ4YZTylMki7GcxGEBMf+twuVEzwNoaZ+POuXQYMNquH5iA2eYeQguXj+pGKH4dycPhJw/YO9fsr4FTPHWWU8VK4rKS/PV1I5kueZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783649; c=relaxed/simple;
	bh=XV0EQC7JLVtcv+sG4B7bm0K+L05FTi5jx7Q7aQ5TxMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cmpty6nmG81FAWINcNhi6lCA0DoGAmmB1reilN7avUYdb22jiodphgADerIHTC1UfupKKQNqV0ejgMNOx3dceQsAxBFEJCRNT/VqQrik01+btlbs+4SDV8AzDLvlpwVTtanQjG99OJH/m77TwAEGU2Bzv7d7xtzFemZ3M8cLjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXBJ18kI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXBJ18kI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125921F000E9;
	Mon,  3 Aug 2026 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783645;
	bh=rsan2+Q2KnlKVeXYcEkz2bG1EBx2BTD0IHV/32ltY1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OXBJ18kIrZmlSZVGkL7UBBNAkeQUTJpOnBNBvyPDIQaiXaVYlgjkv/pYseyoQn8T9
	 syhA5vkt3YNc/dhkqqU1NkF1N1o+ADIzij70mYJukcwKNGhBghM8o0jrBrejaOfIA/
	 2PXyaNIPg3uO9Cw+g2JbVjkaB/DswDCjNduNFM2uyBFJ6eAn/yiQRhqn4y+x8APsGF
	 UfjA4PYQWht2ybvTPaXPC8DCbEKqmu7SDqxxdt4hcRUejvtdRTZ9kg5Yd2tGO12VsC
	 TWWv03u+S/fwF4BHyaKZ63xr2f0yy2Cfr6oR/HFFTAzjios5HjR9hWojpSDeCqugrS
	 B1GI3uqz1jEQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C13924443;
	Mon,  3 Aug 2026 19:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip: drop unnecessary fallback to ioctl for tx
 queue
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178578360588.2787819.1973787210655671165.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 19:00:05 +0000
References: <20260728213843.794737-1-stephen@networkplumber.org>
In-Reply-To: <20260728213843.794737-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 28 Jul 2026 14:38:43 -0700 you wrote:
> Kernel has been reporting TxQ length with netlink since
> the 2.5 so the ioctl path is dead code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  ip/ipaddress.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)

Here is the summary with links:
  - [iproute2] ip: drop unnecessary fallback to ioctl for tx queue length
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=faceb3260ab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


