Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138983AA9F4;
	Tue, 23 Jun 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782257436; cv=none; b=mE2TOdcvAHZtzCSsHuCxcqwCqbkGm+WhoouekDP+Sh+H57dtkNbwhxFiplRchfKoPEhtahDkXA0sMnNN5rSD4XlL5OfhN+ZaFefZZoB1ulAAAXvoycu7eqS5iMnzRxpl6/B/b4RgkSxusLtd+l8QSjXjC1zjxm6xR6k7Rws8q3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782257436; c=relaxed/simple;
	bh=JLyFT1Jv/J5T1HWl2XSOJT7hQOy7IDnIdZAoaUqZYv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kZWc01cLEQbsoeQZ8IvRugx1XtCUojJTcAFfYr4STHxYwIeegN4LWszXvvryJz1iUaN71Q3c0YGhUrfwOag1iCe2lvQjsaUiRY0xEZIlZu2EJoohuKA3Q401nOgaK97Mho4TgOFc0v1zh34mJa2SyJ98y9cF7ZwCSRpXznoRrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzLpfpI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzLpfpI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ED31F000E9;
	Tue, 23 Jun 2026 23:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782257434;
	bh=aL/M7IRPkz6/JvXVAADlG3jaKhFQEmO0F8gH9rtLMAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fzLpfpI6AgoaOFSco7n4hZvdDna6ZPhoVBeTcGuNrav34rSkoFp6UhtqcOUrab7L6
	 yBxYcgz2yPCevLJarAig55IKMwCyUnvtgv3WrO+uV2U/ahsUrwYbvkpTRFkLMBLEZc
	 jDuzM5Pg1PlawNfcisDuxfzbSho2GNdZ34KLvlRfA9MXkzouWLQ4Zepn+TEY55wt6/
	 DyqaHTPBEkPW4tv3cWIZazkI1Zh3Ey62qPw5Y2OUVwDLrBv5Et8u53dC1JiPkS8eq5
	 Lpj6um5i98/K4vH4IIXwt4qCPDDjv+ZvIBCnKgC/ThT4sh3/b+nOb1mJ3DCRvZhkrs
	 KP11/AdOshQew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A1393101F;
	Tue, 23 Jun 2026 23:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: lan78xx: restore VLAN and hash filters
 after
 link up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178225742381.2469097.14730861553288440326.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 23:30:23 +0000
References: <20260622102911.484045-1-nb@tipi-net.de>
In-Reply-To: <20260622102911.484045-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, Woojung.Huh@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, schuchmann@schleissheimer.de,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 12:29:11 +0200 you wrote:
> Configured VLANs intermittently stop receiving traffic after a link
> down/up cycle, e.g. when the network cable is unplugged and plugged back
> in. VLAN filtering stays enabled but all VLAN-tagged frames are dropped
> until a VLAN is added or removed again.
> 
> The LAN7801 datasheet (DS00002123E) states:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: lan78xx: restore VLAN and hash filters after link up
    https://git.kernel.org/netdev/net/c/5c12248673c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


