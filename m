Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279319;
	b=VlJi/QulnN/PXsYWrxxJjayi9M2wxoY4vVNIBD0cGAyClMMIwvs99+2xtN20xl9sA8S2
	 0q3odIxat2AqvRwRsmm0eRahB2XwcOEhae427+3oARM0oEsC6gOGAiI7SxBZSLWPtWE/t
	 CRGidDctWT1mESdVWfnV3tgVHfNyT8KnvrgSGx+4m4Z2XLgrncColq9CSGweuBjtB19tX
	 ImV1FcgsZ6BanEUHg/f14sOQUS9d+3wDfwz6sEqd/UGgb3r4NqBagbV8m8ON9S3rRVh8b
	 8e7dX/ZRTzh80r82F6IXyHplLZwtTjIMMU1RUq1bWEq2FPjrp9QSqCmcTgQw7LIptSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279319;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1fxCtwQTd6ybLLHw7FRW0GtCuwc3+kDiS0LRiRdpFYk=;
	b=DCj7bWUHVxRd0+nRgt3Tm+qUeLBhQnXXVeOFKLwq6M+639Oj5d6QruVTKR9eVrDra5sv
	 To1tYT9RLyUCypmJ/g10cVmfUX9Fu2sx6D+wHEHHISz5RW0umRycDoT9WR0rEM/QLOQsM
	 Iqi9lRgPAF/56IKP3UFMtNCI2rDrJYIACcvYQmk7J9ChAm5V72rZbWUleFrlD8WkkTLGS
	 B7Lh2ewtPZIXR97rsq+r3URDwc2Eg8ivkOPW4lLbospDoZUlPAxYodSM7/1KU5I12fGQP
	 xXvnYbMcHvUVqadHgNjdulFDw2PDcFAnStMrzaBTeQsfvM7XFfaJOGHRltTowSYZ6Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDuhEJLA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3F606BAE6;
	Tue, 10 Nov 2026 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDuhEJLA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297011F008A3;
	Tue, 10 Nov 2026 02:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279319;
	bh=1fxCtwQTd6ybLLHw7FRW0GtCuwc3+kDiS0LRiRdpFYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LDuhEJLA3Oh2FDg0+hrlMusVmWjNti0kjWi/a0hzL/7bB6bOSZx6dgbn0bh8uu4tD
	 lk9uV2UYQrxFA3uPHwU+25UoVKoXIb/Ub/3g8vHk1qR/fJEEbKvmGJnq7toVBphgrv
	 IR6aVuUYikVCBXdNSkIw/kYB91cgCFHZcOarm1c+PpxMenhZVzspa0LKOCFUixRGuk
	 R+GNfh9hMbDWTGN3Hv7W5AFGF3dUx607A+HSHXjFR0WfGMcEmccwTFB5USTIwK9uZp
	 Hu25ysOw/2ezCsmysPX8MfAPYbvDPYfivtjAJqzHq+IKqqOtsGGqmOpQ/DuQ6dmY1H
	 2ctUD+DMrRSvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FAB391AFCB;
	Tue, 10 Nov 2026 02:55:19 +0000 (UTC)
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
Subject: Re: [PATCH net] net: mvpp2: fix double free of the replaced rule in
  mvpp2_ethtool_cls_rule_ins()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931767.3612825.5572628668959345425.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:17 +0000
References: <20261104120225.28377-2-fourier.thomas@gmail.com>
In-Reply-To: <20261104120225.28377-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 13:02:23 +0100 you wrote:
> When a rule already exists at the requested location,
> mvpp2_ethtool_cls_rule_ins() removes it from the hardware and frees it,
> but leaves port->rfs_rules[loc] pointing at the freed structure. If
> inserting the new rule then fails, the next rule insertion will free the
> rule once again.
> 
> Clear the slot as soon as the old rule has been freed.
> 
> [...]

Here is the summary with links:
  - [net] net: mvpp2: fix double free of the replaced rule in mvpp2_ethtool_cls_rule_ins()
    https://git.kernel.org/netdev/net-next/c/d26955e57475

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


