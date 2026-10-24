Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792801207;
	b=VgC2sssDjogYN0o9s+CiGUwjBuo10I6tg8z2bmvIwAf0VWZnTDjXSrFODyZRXwBMz29/
	 VDn6LdWc6lwEhEIKTYahKJlVpIqW1gC9E5J1pztt6Sdu4avKJzggW+4PneCQGRA9LoCaJ
	 tdzA/KEn07msDq0X+F6FuJeGzqhIvsVQrqO9e1j/4gFXg/iS84mdotV9SQ1sLyEABYYio
	 l5i96KgYhTbITWV3C+nT9p5/dfF6XYiTCm+Bk0PkrcszK2SInEosur1VcTm98Nj1DAgDw
	 TNH9krdT/JwaoS/7T4IeFU+6gczjmV0Y3yIxftJS3LXaTldi1fbmhgwTGavP4UaQ/gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PfwXsatDr61B034hWM9U+Q7p7HeLrw5Wrlxl7/A4T58=;
	b=rJldtvFf74bxk+2cKu92+7LueXhZUWvDxd++tvGag0O2LaUhPU4SbjsZSrmXnD8qnr/I
	 Y80zMaHGkIPhWE6gbSR4iyErcapcWvSxTjXc3LYM6vBI0oryornOzcaIkoTUI1i8x6zoU
	 sitG0E6fTOwTpWtjN9eED5Hn5m/bVMPsKbwStmPxF3d17Q5zjkv0Adgr7CPy2NBT7DvMF
	 V9eTD5kQzHtH6patBLpU4TsBmnek7Yu6qKqeTUksmwietlbrLGJLSSMqP3zKdF4Ny3B97
	 apt62izHYgJKjQiDoDSb30TIHYHtxYfxc9hCOcrj4OYEvMWZfKnglbb9pqZjfhmgFXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRAKwjSM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5227606A31A
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRAKwjSM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF401F01825;
	Sat, 24 Oct 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792801206;
	bh=PfwXsatDr61B034hWM9U+Q7p7HeLrw5Wrlxl7/A4T58=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LRAKwjSMWd7NgCpMuSTbACXIPYnDFnXgm+egDuipKJsRaW/Rh7jIN95HT5D/nNXKC
	 Uls8pTBQ26gIlm+KZNrlB4Pb3r4Q0IUkR5R3p6FuZshCZL1U+PpfpPPbsx8bXakq0f
	 /3gyED48WkRFikfmL4GEHFMqi4awR4UQTdM94VgdyUKUDM/TNyPaMTicjGNvLm72+9
	 ssi9vlXO1lrehgrHywzzsNFnXRBMCXJlUaU4+DO+kUjmjz41fXZMV9pve5BYH4Icmn
	 SesXP9QPsJxPIg99jq5cnbmq5T83J7ILoh/GvbnzBIeZZK3IPx+P12KgpYg9OwlqwF
	 Rg1W2u11pG/cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 44556391B16D;
	Sat, 24 Oct 2026 00:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net/sched: etf: initialise the sock_exterr_skb before
 filling it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179280120508.1365357.10840947352327421605.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 00:20:05 +0000
References: <20261021155401.65997-1-phx0fer@gmail.com>
In-Reply-To: <20261021155401.65997-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 23:54:01 +0800 you wrote:
> report_sock_error() clones the transmitted skb, overlays a
> struct sock_exterr_skb on its control block and fills in the seven
> struct sock_extended_err fields, but never clears addr_offset and port.
> skb_clone() copies cb[] verbatim, so the errqueue entry carries the TX
> skb's stale control block to the receive side, and the ipv4 error-queue
> reader trusts those bytes:
> 
> [...]

Here is the summary with links:
  - [net] net/sched: etf: initialise the sock_exterr_skb before filling it
    https://git.kernel.org/netdev/net/c/7076f684d513

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


