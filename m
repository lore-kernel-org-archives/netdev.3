Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9D3CEBBD;
	Tue, 15 Sep 2026 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438278; cv=none; b=BqBzMGut0uK2gWkV3OgJeMoQ1tKmUozl8mBlz+GuE11Vd8gHBu37aOrsjTVaMPSeU7HAPMhDZFpX2rT5LW+eVY8iQD/IjrL0rKxFk+OdyMh4G69VBf1mXjP8ZSPAVfaHhY/Rbe+e8y6w4Ua8hvqqmoto8Bz37cAzpBV/ruWE2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438278; c=relaxed/simple;
	bh=N8N0SKdMrgOaYhGwu4u41DLLVvGDfwueA6SuLrV1jfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W4Cuct+EniHcXJyPhbYgLNtYmcEiAJWpajSYaA6pwKbdLB5odETuFvwikOliaS31iQn5OstUf3PwZVI/iHia6V6WyaZpmatvOrksvde297CX5SSdhCNWmye8BNAnD2GFFlGHWGe80EZVAPZNvlg0itZqz4O3BztETuQ4xHC/BJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtAwHN9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtAwHN9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E6D1F000FF;
	Tue, 15 Sep 2026 02:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438277;
	bh=oPPURAaLdMZZFUJHXFdnAHiF47kIBYfbwwPk9AMn/Uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dtAwHN9HQEOtG18BYLcDu+WVGwc6sHAg+XCck4V8EgHvugfIC5fDdT2XI9XWMMfNT
	 2Bdx8W8tyMXRr7/OR9QkVqXyX1vNA2TZZwxHyiPUFOe0jJV8VPXK3RcEIDN08KtbyO
	 JaV4qzfnvNCFP4n8ajM4eo18nvEI38UpT5sKB/OyYSRBfOS6wggEr+jqVR3IjJllI2
	 +w3kV/PM98+KzmPLy77igpKb3+sOjiYKFk+FZ+aEgOe23bU/Gn6ODVQXrQuK+f5Xdn
	 3CRuhLVmry2VTWx7yoMFkOWHewaGaKU6xggPCy36+ghJdDiFq6gV/1Ux+d1vIizKkU
	 G24gYt2jeWcug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C173924FFE;
	Tue, 15 Sep 2026 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP
 decapsulation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943821188.1315233.6322722088221273157.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:10:11 +0000
References: <20260913194421.31-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260913194421.31-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 21:44:21 +0200 you wrote:
> When an SRv6 packet arrives on an interface enslaved to a VRF,
> vrf_ip6_rcv() sets IP6SKB_L3SLAVE in IP6CB, but decap_and_validate()
> has never set IPSKB_L3SLAVE in IPCB. The bit stayed clear in the
> common case, and with CONFIG_IPV6_MIP6 the leftover frag_max_size of
> a reassembled outer packet could even set it, with no VRF involved.
> Commit 44930446dde4 ("ipv6: seg6: clear IPv4 control block on IPIP
> decapsulation") then made the unreliable bit reliably clear.
> 
> [...]

Here is the summary with links:
  - [net] seg6: set IPSKB_L3SLAVE from IP6SKB_L3SLAVE on IPIP decapsulation
    https://git.kernel.org/netdev/net/c/7616242a2b37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


