Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797008;
	b=PLHzrXB2tqJKxjEGUiFhq6qT5Byw8Qd37zkQTbyIoKvuI7bwOXHQo8BEYccvKGVOExvg
	 uxGQiSAMv6WPen1UxbHFhAI3ZhFWQe+QKgPjAD77Cp8gJf952ylGSLVDO2mFgMKfY2ly9
	 fMOQufeQhykZKaQywNMHVPCnuzwxhGgyKWue/hy37du/pw2Gf2OrzEBI1V4S4lTs/fst8
	 MbZ44j7Y76dc/EocBPvNHL4rb6DyNgmxVmmwfyXrbxx3YPyI+6Y4poDK7a96mC+2CJJE9
	 OuLphgBLbFp1Z7V05M52tJP+0AGxodCcbTy2PuotTFTUuCSQZxqKAHWthzZfO6FYKbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zkOj/dPqDeR2z1raHppz6UsxzcG4JxFkGnpVOXS/y7E=;
	b=ZfYK9qn6duAwUVMvoc1jznJ5MsHWF9/PDjNXebG5xuBov5fFOiO4nxROe+dnoMOtm5TE
	 5lF9CXmQEITdTAi/jBnsTCloylMMnb4sZUANcv6awKzWqw0X7CF1P8LJ4q9TNXpxBY2yp
	 76zrVAb9UdZTmpo2SL+Yp8hD0FtlOI7D7RZqi7oGMy/BFY8JNJV4jvRMkXbRLIiHfNLGx
	 v39cJF1PRpuv6pjmfdqb/zhgiKlhB7z7OgZB413dfY+1iAcZ/+h7STx6AqV9MeLaASlVd
	 3RvFc4JTyu6H9NNFQsf5jiG/sViUcFNJ0WlLHYtVsijDWYvDe2kGBVa9iC5wcWCCZKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUO49j5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C795606A32F;
	Fri, 23 Oct 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUO49j5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DEB1F01829;
	Fri, 23 Oct 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797007;
	bh=zkOj/dPqDeR2z1raHppz6UsxzcG4JxFkGnpVOXS/y7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PUO49j5uQ/za0H789lXGXaBqS0RIluAG5jy3JttaajrHkfXVSMjXrfwr9/BlPr8+H
	 SIwJmETSpT0ZS4U1TqXnnJKUbYo+YtnzsFaXjhJHSeLqdfDJMvF9PBKU3OaRGjVY5K
	 VbJPoQlKuxV39AH8wbFtqXe6A/ovW3q50/urP0m/4hBOnWwj/PDdssXFr1GncrXJvD
	 afNQ+OKRLDe18jiQEir880In+Mp2rI6FuYBs5IDQaS1NRidxqa2+3a3ii/IHfofZfy
	 iKVTX2fc7Xc870Ua0HJzR4KAvezqjGcapdUkMf0Tx8Ffsta2510iWVXaIHJe1vZkzb
	 n3smp6ak3+17g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE521391B16B;
	Fri, 23 Oct 2026 23:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net] tls: avoid field-spanning write when copying crypto
 info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179279700631.1316845.12189047756278316943.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 23:10:06 +0000
References: <20261021073233.16720-1-nandor@riptides.io>
In-Reply-To: <20261021073233.16720-1-nandor@riptides.io>
To: Nandor Kracser <nandor@riptides.io>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 09:32:33 +0200 you wrote:
> do_tls_setsockopt_conf() copies the cipher-specific part of the crypto
> info to crypto_info + 1, where crypto_info points at the 4-byte info
> member of union tls_crypto_context. When optval is a kernel sockptr,
> copy_from_sockptr_offset() is a memcpy(), and FORTIFY_SOURCE bounds the
> destination by that member:
> 
>   [    6.948348] memcpy: detected field-spanning write (size 52) of single field "dst" at include/linux/sockptr.h:49 (size 0)
>   [    6.948480] WARNING: include/linux/sockptr.h:49 at tls_setsockopt+0x9b2/0xa30, CPU#1: init/1
>   [    7.001355] Call Trace:
>   [    7.003146]  do_sock_setsockopt+0xb0/0x190
>   [    7.003975]  __sys_setsockopt+0x76/0xc0
>   [    7.005368]  do_syscall_64+0xda/0x4b0
> 
> [...]

Here is the summary with links:
  - [net] tls: avoid field-spanning write when copying crypto info
    https://git.kernel.org/netdev/net/c/c43c1c24f3cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


