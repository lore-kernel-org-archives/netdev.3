Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F423BD05
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596053; cv=none; b=IfO9SJmWrYeSKvssoKWz4aPzkcaMSwEzB04F2PVI7tResaw/t9NdxtrEBt9I7fYfxMDW8Z2xLSinS/+Jt8kj/GlJmFRY/8GbyuysLfoLCNBjC3OO9N/k0wgewIOWCxGnOBH9HSEnNk45BZipQMCfTMKUznJQIE6FESpPl3sE/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596053; c=relaxed/simple;
	bh=KZvoZKb1+gqOv+CkGnTu/fc+/z6ig0x9ThpV7dLfc34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RmrciZmlWeZgf382+aPKGBqi3e3h0iP/MOi3Jj1Ahg9tdzxDD9YBkTswKy9h/j7VAYM4A3Fsy9nXvUjiSik4R/yT6amOGXyQ8CCJDpZ6FJDw87HTZcSErJmgSDUts/yDTzvvTl7eqLeZCjJd8RuDT7dGT3XquagO+oDczMvfp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opr/XDDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opr/XDDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3992C2BCB3;
	Fri,  1 May 2026 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596052;
	bh=KZvoZKb1+gqOv+CkGnTu/fc+/z6ig0x9ThpV7dLfc34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Opr/XDDsxS8wCs6tBVIpSLYi/PMIA4KJNjFwaD/mX1+o4wUsevQpf1C6Ge1w2LA0s
	 guegkxKoeBn5guPyy2qO+/0xDrBKuBg1Pm65e2oKk6ZKangSHu1tru+wmgf2+Qyh+w
	 Ot2uNW9iQEWFaY7pwTShlL2c1YXbizu/PzQ9FDoszJLai2a/FkF2Qa6ZAOT5Fq0iOK
	 wL7Yj5BHTFoBpnanTCua4jTT9XcDbhSJJlKZNEslP8jOpNVtFU7irCw4b9zYKWsQIe
	 KhHc2UUlHbeCEHiL/kxbcc2wIHlPU1OKZvlWno28cG9V2fQjRfJKC1XJvsBDtqjgJn
	 /V1tgi/aQJP+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE07380CEC4;
	Fri,  1 May 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] ipv6: Implement limits on extension header parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759600705.3265014.14474926171818410552.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 00:40:07 +0000
References: <20260429154648.809751-1-daniel@iogearbox.net>
In-Reply-To: <20260429154648.809751-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 tom@herbertland.com, willemdebruijn.kernel@gmail.com, idosch@nvidia.com,
 pabeni@redhat.com, justin.iurman@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 17:46:48 +0200 you wrote:
> ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> find a non-extension-header protocol or run out of packet data. The
> loops have no iteration counter, relying solely on the packet length
> to bound them. For a crafted packet with 8-byte extension headers
> filling a 64KB jumbogram, this means a worst case of up to ~8k
> iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> for example, is used where it parses the inner quoted packet inside
> an incoming ICMPv6 error:
> 
> [...]

Here is the summary with links:
  - [net,v5] ipv6: Implement limits on extension header parsing
    https://git.kernel.org/netdev/net/c/3744b0964d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


