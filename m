Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445811;
	b=fONiV9ZzROEIrMBNE2/LXNycP0dxD/pJ5N3CK85v6vKM6F5Xz7H8bClzNr1WQOeoKlfO
	 VKhfVTYnCrdhPoFLsh+1iII/yjGpjm0gdaYhbK81DkCRTlXkIOL1NyV9anE3Z10WDrQ2U
	 ysBpg2or8ksBVxr/eK2mAuwQ+PPFF6J9vFmDQW+gXNvuoPXYZS8gOGpsINT4/QKwRc8qX
	 cAM1isq3aHOyVpr/PT3EGyE5fGwzR4/stssHmuyCNBN+QECz3U2LREfcDncqeNEpx2i4J
	 rosUBAN3ZLhp4uuN4jcNJVyRX/SCY/QKI/QCGDEnqcFa+jrDkJcPlxIoywBLVLzH7Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445811;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=iUK3OkXodJtPrkBBoTTM4dXdzIv8wcciK9J4kqlaKsw=;
	b=gs/AoOsVf12VymJfJ73iEwdWFLgLXaWi9y50tB8om6A7YnIquTN42BA5P1n3BK1gwfox
	 NVh9+tAJAtP1sP9JxCKZxc30FqOENQDsIU6b6NlmXMaKIEfkdqa//cRsqzOlTmyerMIHs
	 QMhsmO0qbOi3WLfo+AD7XtO+9biLmw1lduthCwdrlFevW98zcrPVUnymYiGh8ixFmTLNW
	 KOQRdJZnyknZQ9jzUfoD1Ck6n1H/AomgLSXBAueTY4+c8FCydqwmgWO7nnxNJrHaQHkgA
	 xk/GaA7xct848FF1SIDov5bqbElvwBMME33QPmJ+nKNVfLk2mOR356IZabq+KLufxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex9uc6Ld;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76652606A89D;
	Thu, 12 Nov 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ex9uc6Ld
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8061F00A0C;
	Thu, 12 Nov 2026 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445811;
	bh=iUK3OkXodJtPrkBBoTTM4dXdzIv8wcciK9J4kqlaKsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ex9uc6LdL9rleAtamx2w1yYQbWoASBjdzLUGYVplfMCUUehtGTNP1csnq/CXZQFEl
	 P99nwsNFwJTOofQcJt/BbEzVfFiHCw+4qptwXiQdOvHojdyVBcNfGCgus0GXQZUo7r
	 DZR8JF19Lmm1DSdH55s1cnB+FlwX1yaTm9yhnO0ZZkvQWf+X3qOHzNIhbeR/QO5G7B
	 ypyUCnWUm3LJhR+eE0Sd3dfB3nBnJcU5bICJc7QJcZzx7tK/QAZA17USCGdKOY6j0d
	 2wqsBtFPPSkpBV7VmCkoaRM3h3FenZvUNt2M7MowFt2wzEf7kSLLRJSrJkxMObpLUn
	 vtOUzkUQ+5Jlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 45847391AFCE;
	Thu, 12 Nov 2026 01:10:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next] docs: net: fix outdated default values of four
 sysctls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444580992.1745669.85658794440257470.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:10:09 +0000
References: <20261108061746.32090-1-gopalmalaviya53@gmail.com>
In-Reply-To: <20261108061746.32090-1-gopalmalaviya53@gmail.com>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Nov 2026 06:17:46 +0000 you wrote:
> The defaults documented in ip-sysctl.rst for four sysctls differ from
> the values the kernel actually uses:
> 
>   sysctl                  documented  actual
>   cipso_rbm_strictvalid   0           1
>   flowlabel_state_ranges  1           0
>   router_solicitations    3           -1
>   regen_max_retry         5           3
> 
> [...]

Here is the summary with links:
  - [net-next] docs: net: fix outdated default values of four sysctls
    https://git.kernel.org/netdev/net-next/c/06f74055bc1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


