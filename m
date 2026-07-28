Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D93FB067;
	Tue, 28 Jul 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231194; cv=none; b=mttEjage+H89GI8aCJ7g5a7xHCXkCZPlZjXZMUjrFMnxVbiC4VoeDPz3acIJ3qnZc+2ZN5zrc2mWPpnqftqtiaOAp2EEXjOlE8xpUMCOYk0IbfQAUH4sPyfI9nOTxQ+t5OiBW++HNIO83uBKBFmuy8SaGFR1VMbKafuFxPGE0JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231194; c=relaxed/simple;
	bh=sQY3iAGiRJPcvyaBaOCuqMNCGBTdnng7P8tZNaQl3AA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l/mIUc06LUZ7Nz+ZXMh8Sjl85IZ1p612aQnMDsusi1ZwJE7tdn9onsxa1RaIoXRhmjLqxWaQLCBCBXSiCxrwlQg6vMLvK0JpMugEW2c7uBkn68JCPcKledI2ql+nCxbOX4+jGr/Eq6PnZTHIRV0US1OOi73vcT3/tJ7Ax6Q7mtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he2FcqGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he2FcqGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8421F00A3A;
	Tue, 28 Jul 2026 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785231192;
	bh=hI9J3CRdKiWfEL3xLru+gCJLu3Ullwm7BYQ9TNcJUmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=he2FcqGM2Ez+TXPd6CESaYiGZMHZXx49gUQvXqvAZywFEIjN37MSpgnlPBIQm8FAj
	 RZNWkzOwRezAcAgOlbjqgdaQJbeBg1i8bH8mgyN6KLHGRCgU8siYyRVMA9I10vcC0Q
	 rZFDWCBx+2nb9twODd2tAFr+FjUc9Sb4Wair72pRbpaGbY1Rgkv6nJib2HT9DSRAuo
	 ZQgWoh+puVbVVaESoiF122bMTGIusxzSLiR7NYIOhDnZRKgYdzMBAG3HHqjBLItY5A
	 ekQupw7YuL33Ycvn3ayEVqrmk/DGXXFtKEgCjScbaQgapmdlJUTYbj1OrvF1hFEmX4
	 HicVirhWHinVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A30380CFE5;
	Tue, 28 Jul 2026 09:32:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: cls_u32: validate offshift to prevent
 shift-out-of-bounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178523115789.1642152.10297334372995213797.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 09:32:37 +0000
References: <20260723044955.89471-1-blbllhy@gmail.com>
In-Reply-To: <20260723044955.89471-1-blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com, victor@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Jul 2026 00:49:55 -0400 you wrote:
> u32_change() copies the user-provided tc_u32_sel.offshift (unsigned char,
> 0-255) into the kernel knode object without bounds validation. When a
> packet later hits u32_classify() with TC_U32_VAROFFSET set, it evaluates
> `ntohs(offmask & *data) >> offshift` where the left operand is a 16-bit
> value promoted to a 32-bit int. Any offshift >= 32 is undefined behavior
> per C11 6.5.7p3, triggerable by an unprivileged user via user/network
> namespaces.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: cls_u32: validate offshift to prevent shift-out-of-bounds
    https://git.kernel.org/netdev/net/c/aef96eead286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


