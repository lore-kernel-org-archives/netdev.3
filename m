Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508212;
	b=erMGOoz+mYhwDXx0zPwxBiIL0bh0cu9PoIDiN1WnlIYoHmNqO3Wkh5VycWeIA5qysOC2
	 sYG9cT7neT7+SRkmkQT+nLVnTEuvCmCGPBxTBCozxg4PTuZjCxczPLJYOEoLTnlTH8bZu
	 PjwfiKuoBbPibWL9FCguEmfNpOTlVp1c6DzM1GNnyJvlNp6/q6hNQ9wJ1/v0qCJzDaIYL
	 HGSmUQjpongPoesof0bjE4q+6brCRhFjruOdtLQ7UcSftioa0eIZV+YyA7IPRdlxJyxJF
	 hGQRb/f+yEbMAFBrwCRRlXTMuoICy1GEeKoogvIZc2q7oQkUlZTS8UlstztY967PzkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Yp7zrpYK0VzgkQbfc5kJ8QjOM+iG3RytLscadij0xvU=;
	b=Wvv3qrhAKtCSnt1u06nADH/a9JwBB1ED54ybmGrabv9TmXpvQYWSAa1ctVG0nKOk3iXY
	 REwl8q33ucsJRQ2m9s2D1Zz+ArKLoOD1wPdbm4dXwt1C21im0cKxDK4afPIGGPb8yQhbL
	 0/aDoVDb6umwDwjwuNzTAH1sUxqqIUGLQC0JHRBY6q7RBfauVrLeH2WqFC4cRX/G7j3Fh
	 f+5refaXujw9z22bwMBQmY32F9CAG3Re/6AH/KSua3YvOMWQwzpIyQ7z5WO03wFL4B0NN
	 LfDfRGKLvmLW07XviqbM4zr+5xFEVsXqVr0AmlmTIbFs5mGr8FDAhHYOuyJeHbe3pKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCjrdH5K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAE606A8B5;
	Thu, 12 Nov 2026 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCjrdH5K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C6A1F0092C;
	Thu, 12 Nov 2026 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508212;
	bh=Yp7zrpYK0VzgkQbfc5kJ8QjOM+iG3RytLscadij0xvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mCjrdH5Kgvqwqmai3bjSmdFxL9U4g62m747Oiuz68QOL4/hGujqhLnbAKchJCBQUP
	 ZDF5iqp6vRXcxIl1hVC4hlREZUal0EB7Hm1wU6hmCSp/+nfxGsySuFocmRJds/UggY
	 tN9Cd0IZUjYs6Oq8rjypn6I8D21UKtnKc+9G0joAiiqUnHG9fq2WdqT1z8N/HYMkmX
	 Jek7xg8qcz73QCKt6vJztBQ8BC5MoQOvPBp615fdNg05jUIHc5FBg1l5n/z1Kt2+j5
	 9u66NHL2Uh/8KYviXp/qFJbjm+IzSvhs9cWHB7Yg776SOZE09JcR5Y8CX7S3KUACTI
	 I0Uj0c1Z91T9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A34C380AAFF;
	Thu, 12 Nov 2026 18:30:12 +0000 (UTC)
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
Subject: Re: [PATCH net v4 0/3] net: dsa: motorcomm: ACL fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450821077.579048.2767887410669990212.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:30:10 +0000
References: <20261110104930.223598-1-mmyangfl@gmail.com>
In-Reply-To: <20261110104930.223598-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 18:48:52 +0800 you wrote:
> Various ACL defects. Found by LLM and manually verified (on YT9215).
> 
> v4:
>  - reject action following redirect action
> v3: https://lore.kernel.org/r/20261106073806.112122-1-mmyangfl@gmail.com
>  - also unset `reason` initializer
>  - fix action resolver again
> v2: https://lore.kernel.org/r/20261103095514.338700-1-mmyangfl@gmail.com
>  - withdraw patch 2 as it needs another test run on the device
>  - fix patch 3 to align with software behavior
> v1: https://lore.kernel.org/r/20261102071119.3435180-1-mmyangfl@gmail.com
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: dsa: motorcomm: Fix extack message on unsupported TC actions
    https://git.kernel.org/netdev/net/c/7adbc7112dd7
  - [net,v4,2/3] net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
    https://git.kernel.org/netdev/net/c/96a4b015fe66
  - [net,v4,3/3] net: dsa: motorcomm: Delete the ACL rule of the port being unbound
    https://git.kernel.org/netdev/net/c/4e80af24f9f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


