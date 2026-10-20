Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527010;
	b=nMXaqAD6p47UZylEERSfYWwK2AlHdmvIAcc5WXpkNPrjYYRFrBPOk4SUIvZ/YhPDBeSF
	 Be+F9SWhAHYa2/XSjYEENUL9+6ub4YG+f6n34C7UeuC/p7xjgGKaNSCeEn754l74M02H2
	 IwMnr9X4f06PXTfgBa6VvEa1XV/R8ui8aPSTfXQkvlEv5zN2/MTN3NxKQ/H0PERapbg3S
	 hOQiagvwQomuMblDYHbrcsc4wFIbrc344OGecx89ZlAuiP7JVn46bRo/kBmEtdwS3asD/
	 ox0vMXc1qb/IEfARNQSJAr/VjCQxnpT8TgKON8ZxpzouzC0vHqKYTDU7jfvnbAc0gpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=R/cK/rlqUZTyMXFBg2RmzDR9RhPORVn0GXEqpAUHJKk=;
	b=yhjOI04ck80NQEWpRET2Yi0w0EWmGneFrIdX6qLDHUo/XgwnLWRPd6qD5Wx1tMI1rGB2
	 6TUNVoQ/GljspKI6WeUn7N2TtM7oGuCg/yS4h+T0gS4l4PenqPfkFxtKuqujd3EfAssKM
	 8JaDwKiqdV2iaFRSp7rt6LnYu6J5XqfnGCniZnzXhQoEih0tHC2NKkCftJBXrYM8NxFHW
	 ZWYmRajCMclkJX5bT03EJz8IqBGbLTNQlTdnx5DsUOZPGSCLiUqVgBvbR7WoR8kQ1A0sk
	 sy0mNV711G+baRydoXlabCB5U6f5AphBWiHlTGhfFh9gENFeWmHAYc6hkAN3liOzF3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlqrAiNS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC4606A319;
	Tue, 20 Oct 2026 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BlqrAiNS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088191F000CA;
	Tue, 20 Oct 2026 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527009;
	bh=R/cK/rlqUZTyMXFBg2RmzDR9RhPORVn0GXEqpAUHJKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BlqrAiNSv+CGzQfxSwtD5uEhfdTOGtCjIPFVDLlkVxdc7eT/rjM4ecGNQhp2fmHMC
	 KUjMlyfmWdHSEiLt9Y8Iua+qt15wrKTcW4cRj2WtodUXYjunvXCXcm4Mz1viOhdaIF
	 gYirglmDlWbq6FYGAnVR68P3Nf01ytYFqniVzw7DvXI6cV9lmomQGjuW5syf9S4Mbs
	 TYrLwV3XryRdXor8orNK+/pFgGz6Y4hpUtt0I4O3D3ulU4x2rYo0a98a826Rp0q6wJ
	 jULFKc3pYNC69ZUFT5IxJxW+jrH+Ny42vhPNSEGJqdjaeUuLxDynClihbaafU3kv8V
	 I+fbaiFcr5p2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15D93809A09;
	Tue, 20 Oct 2026 20:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net v3 RESEND 0/6] net: bcmasp: Collection of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252700778.186787.8184035137361691195.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:10:07 +0000
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 13:44:33 -0700 you wrote:
> This patch series is a collection of bug fixes accumulated during a LLM
> coding session. Thanks to Justin for the internal review and helping
> with the last patch.
> 
> Changes in v3:
> 
> - add Nicolai's and Justin's R-b tags where collected, except patch 6
>   that did not make it to the mailing list somehow
> - removed inline keyword from bcmasp_netfilt_is_companion per Nicolai's
>   review
> 
> [...]

Here is the summary with links:
  - [net,v3,RESEND,1/6] net: bcmasp: fix mib counters struct alignment with ethtool stats
    https://git.kernel.org/netdev/net/c/db45c15c9813
  - [net,v3,RESEND,2/6] net: bcmasp: unmap previous DMA mappings on TX map failure
    https://git.kernel.org/netdev/net/c/a3cf9877558a
  - [net,v3,RESEND,3/6] net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
    https://git.kernel.org/netdev/net/c/07b624d2f5a4
  - [net,v3,RESEND,4/6] net: bcmasp: fix OF node reference leak for phy_dn
    https://git.kernel.org/netdev/net/c/a31623d91c6e
  - [net,v3,RESEND,5/6] net: bcmasp: account for offload header in TX short packet padding
    https://git.kernel.org/netdev/net/c/74667a55122a
  - [net,v3,RESEND,6/6] net: bcmasp: fix network filter lookup and wake filter pair allocation
    https://git.kernel.org/netdev/net/c/fa1459375794

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


