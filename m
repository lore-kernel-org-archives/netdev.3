Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C547F79E;
	Wed,  9 Sep 2026 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987674; cv=none; b=i8tMR5B80sa2BBtBKEbgj8ck0Y0olt2/1NEm+2cACNBtD+5e6fxSnH9ga6wAO4eXRGnATa5uxadZDCWCCs1iI2Qnz/iOtVDps9Og14GYCkX4TuTgZUOL859aqnNFn5khoB0yydkvAyZI53P4gq2cXTcE/EJYK3XLv5xoamx1Mt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987674; c=relaxed/simple;
	bh=0aeToyGTL4SmgjIQxHg7udCXFyrZGZwOJh8vL1eTDeU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kjv2Iu4IxKt8t44+7d3SPIbw59c2vWnX+YW6CSuwuVXOKPw+lWUBdjS+hcYnpn39OSf6huDHYl3/XMEnYu4dXRTEsh/zP8cRWj6yT/adIF4irdIG7vU8tMxz+4qGMEAJqkTErj2GJNVA3KaHx+WsD/xaiyWnf3lyJHCNPYYXazs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3mb1znX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3mb1znX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C921F00893;
	Wed,  9 Sep 2026 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987673;
	bh=juKOpWYUlDdDSie9e/IhIeGrVoW3twDWEfUqGkR5rD0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O3mb1znXh8PI3P8eFNQGPbHwOtaLJxrJ6Yya/7IfVP7FqhygYR8Bl7St/cb3cEYsY
	 GziVXw9geSiUtCtEkt7bPF6slgfgDutRp5cuhkz3zSqjVybIjpmbDiexEby3PxIjIB
	 IFfcnMlynahybM8TjU7ufw/ez1j+tyuW9ZNJt3p27+uumUfWfMA9rSXjyobSFZ5OGc
	 kzNZ3vyhny9/Y9jMoaYQOIH2myHevv7xIMqWmFtpIEVsD2xXNcGA8zzwFYnjOMoS82
	 YyDg/XOP1rgg89fjtXOwfAZ/CrN9k5JxV9qZjKcr7azopbzxfxenxFAqMSiswwOVlx
	 SWJ4S3CuG6ADw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5682D380AAFF;
	Wed,  9 Sep 2026 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] gtp: fix repeated word 'to' in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898761088.1057294.16159550143311600608.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 21:00:10 +0000
References: <20260907094950.18606-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907094950.18606-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 15:19:50 +0530 you wrote:
> Drop the second 'to', reported by checkpatch.pl as a possible repeated
> word. Only touches a comment, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v2] gtp: fix repeated word 'to' in comment
    https://git.kernel.org/netdev/net-next/c/1c9c07d0ad69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


