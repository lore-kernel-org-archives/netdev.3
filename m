Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FCE555
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782686426; cv=none; b=emAofzvhPv42AKc11IA+y18WWxyAJ1LKcXjNqFKCCjzIANBrU/qTmhbn0Pl4liz+AEJeYLmnJFVIkEgNYbRPCbOGpMp7j3NtqRTTPSeZi9/j7z72AZM+bmRgcEldgyncmYVPBogCxHDPvCewD7s+7c6klwumlh6eSovzxlYpX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782686426; c=relaxed/simple;
	bh=8ovpqgNOoy3r62Ie6K3eaJKNRS1FYL7ymTTcCx7ZSRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3dUfEI3UgXoCRyHkEZPCjWspwV2VeBIzBkWwJM610cqaAT3lHY1nnKgO9wfLckTkUCrZWvCTZDEe5STMeeR3uz5hl19RtEi0Ssgq4KrHgoo42j3fIGlIxMEHGf8Ble2Hgq9qXlRYjvZ8XyvwRLOxEhizhAn5Q6jx1cyAMvixTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+hBuwcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+hBuwcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393571F000E9;
	Sun, 28 Jun 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782686425;
	bh=DmDrBe1XAILxDIC4Vacz65646j73s844IR1DcIPL9zY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+hBuwcCz+0ue12zXljp0zNzN8T2BZ62qfWyOxoOlG02X7eV/32Z0bQDSBslcuIkJ
	 dRGmL7hYaZ2l54MrT1dXkjzrCgmYhqELSBw1qSu9St1AtKepxnLxUj7g1mvthYvtyz
	 TxfX5rw0NCTF1SCJYNQj5+cOXiA8PgnD1CseISOnmbF1ptHuokuTKgHuuW4vc0Gdjs
	 hI+uDYGjYaVQVXAzxTxWPGUgTsrjeLcb68XOrY6YFNbiJLbgvtKH2RhhVp468WkS1a
	 Funiw7bD/zbkPpnwjT2qDZwvKRWpPMD1SuZuCUTG8o+qEOE0MdJWWl9DoBWaP+ujep
	 clynRpPF3I3Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939133938EA2;
	Sun, 28 Jun 2026 22:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: fix troff warnings and whitespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178268641023.2198080.5124456905511691247.git-patchwork-notify@kernel.org>
Date: Sun, 28 Jun 2026 22:40:10 +0000
References: <20260628215830.379088-1-stephen@networkplumber.org>
In-Reply-To: <20260628215830.379088-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 28 Jun 2026 14:58:02 -0700 you wrote:
> Fix troff warnings about line breaks around URL's.
> Remove unnecessary whitespace at end of line.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/ip-link.8.in  | 5 ++++-
>  man/man8/tc-flower.8   | 2 --
>  man/man8/tc-fq_codel.8 | 2 +-
>  man/man8/tc-netem.8    | 4 ++++
>  man/man8/tc-red.8      | 6 +++++-
>  5 files changed, 14 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [iproute2] man: fix troff warnings and whitespace
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ee2a4a866256

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


