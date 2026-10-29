Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291415;
	b=0wz5e5vxicdOb5cD9FKEvyUFzR+Eha2cuju9vJqO7IwWl1f8eobDaWe/pmWTz9b+6wTq
	 OteazQRF0KTHKHC+8q8Jng0mNSVDVTFRGYPnQ6O/10TkMwLuSLDTzUuiXe8qNz61roF/s
	 d5v0t/oKQ3VuTPk8HFR3JqYM79qlq+lCaS9EJOWWiHmyPz44FKviNLaNm5L1S/y9ZeCVS
	 ujaszQ03Or2FNTGr/U+RHcrDclbBi+wtuolR8O3nWsZeM2YgXDa0VSBOIlwaVs0omrLju
	 +jC8G5pdpcFBjGuJW4Mp/20cFGYKoyTJJQ4AnKqA4MdYr68tE51NGiqOECKbieXyjMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291415;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PLt2EAzlaTKDNOPaD9JM/CvAsTFKXTYjF72tAbeUw5U=;
	b=4SV2fpO8LY48/Pg4T62rUKwVMkG0V2x7KsGTQP55sXrKQ0ImiWGpoiWi1+E9Yr7nI/Nf
	 6MclC4gQ7DNO4TvDFgC0fNhoSy10uDH85QY4r2CEfenHKcchSCDgWc4z81BjOpMGaj3sC
	 7lplJRNY5E9SfdN6Zr0p64mleuqmgdtsnNZKbja0gTKrwD/pVeGQWBtME3AR0J32IsZrV
	 DgUg4Ux3HL74Vac5UjcuLNvsbi7egTwQJJdIChqmlBjyGcY+qI0acqi3OoqICI7rBsiao
	 8AGHcLx9okSdklV+S0lxBejUn2hhebZ7BLSE6GwjHjKywXInSWpCWtZyjsNBPE8nMeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyQUUzTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7060A262D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyQUUzTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4750E1F01825;
	Thu, 29 Oct 2026 16:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291414;
	bh=PLt2EAzlaTKDNOPaD9JM/CvAsTFKXTYjF72tAbeUw5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dyQUUzTT/6xa6EMEgaQV6wGjJu+oBk1CVlzI0FgQb+lr7HEE+cfIQtt+C9mF/lDwj
	 akQe1C4X4Y4tLvYGq5uv8ad1n46FykGfhlz99HHwME5RIqjROOBBc8539cby/GXp2I
	 yaUhTotPXFfT2ddpc9S3BCro3LMuUrh9d0AE/q+/cUpopFsaJ0kLYRNPgFHsu7OLJL
	 Ab87uACYfgcxaj2iS8TTaPZArl+ihEMIx2lIxXgQzfCzqe1s5LVkMZJj/bXWMm+k8O
	 PocflK3t1UOFNZLzvc1HySBrXTpfbrimkBse3d4f0m/dbpVoLiq74FB1vuVuMTGNS+
	 Y1NEXbkQbSJLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401C73808223;
	Thu, 29 Oct 2026 16:30:14 +0000 (UTC)
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
Subject: Re: [PATCH net] tun: drop batched packets while the device is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329141279.559085.15478130548672944710.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:30:12 +0000
References: <20261027101830.85327-1-shaw.leon@gmail.com>
In-Reply-To: <20261027101830.85327-1-shaw.leon@gmail.com>
To: Xiao Liang <shaw.leon@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Oct 2026 18:18:27 +0800 you wrote:
> tun_sendmsg() handles TUN_MSG_PTR batches from vhost-net by calling
> tun_xdp_one() instead of tun_get_user(). But this path does not check
> IFF_UP, allowing packets from a guest to be injected into the host
> receive path while the device is administratively down.
> 
> Check IFF_UP in tun_xdp_one() before running XDP or building an skb.
> Drop the packet when the device is down, matching tun_get_user().
> 
> [...]

Here is the summary with links:
  - [net] tun: drop batched packets while the device is down
    https://git.kernel.org/netdev/net/c/8f44631ba02a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


