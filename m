Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412607;
	b=PIK1yQdlc0vEdSJD8pwIcp0fGFCHm9+q71Mf0e2EY19YBWpNzU2jPBJACXF6EtnYVtnR
	 qlpYm2/Xp8aX0iTFNU/1JPX1bvrMxjxwKFbRe+OcaM3iZV7bTGRbDfYEZhGeKz88ejEDP
	 LCKuVzIA4Ymr+ii4xajiYcXNIpz4pveLslNdBQvN1NF83n8/GnKmb3IWbEoropWHWYTGW
	 y7aR/HlEOdDPHUtbXfBUTPHXYSIuW8/ngdQ5vpHtz3Z1xdwMOFhDhBxRMRE11SDHS2axS
	 Y6Pzp/n4xk5DY3OK5DcytQM5F3NnM4gBjcbO33AKn6JcgVG0jrUF8VA03VRONDF0ahA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Wze92pAkEVKTzAAivNFkrMcbBfdNBRMgj3JMk5sLv6A=;
	b=Eio1GJr7alRB/QL7tCyct4DniwOSKusmtnx1J1QgHEsPyzHcNAXoi8GtStw4LjS/C3C0
	 WFkcXKurhGQ6hIpaW9V06SBKcAgGybYZGAQzNUtFRmhinVUqILqbXYknL2sMJCmA/v6dD
	 pKeDhdtKwQDEQRFI1JdEuCsqux3omNYy551nX+Z7axbrZEVm5sO6S+gV9rKsU8tV9o8S5
	 wJNp8FNwx+C8oylu6MyewbNZF9PwUnH7LLPqX24aFciMJ/cWBt8ElknnfJaGpLRxlVMIv
	 Ix49Vqy6ED9l6r/3HDSusbVzqjmUxxeIpcCavv73TCBlUIhf0lbkj1qpg2NiNy+HzWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACMjgBvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9A606A31A;
	Sat, 31 Oct 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACMjgBvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498BF1F000C1;
	Sat, 31 Oct 2026 02:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793412606;
	bh=Wze92pAkEVKTzAAivNFkrMcbBfdNBRMgj3JMk5sLv6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ACMjgBvcO8F1NSj5Y02ujXb3wTKQi9p7oBk9xKj/VMvdexcRuAFd3QSZwV2mndvjm
	 CGK8htpHh0dZUsbefdUN1Z6FvfhzZmQ1JD3xj2F1JpaQmKB63K2zv6pqKrFkN9i+X6
	 beD4fb4OHqqlUwM3KoFkzIGdW5vHDMfKSYtI1nT2NI2jqwLf2ohBqwrYULrKT49wOF
	 IeS1tiTY1ld77P72WUDF9oe2XkW7t1PEQkuQsUfZwfUOreK8bl/pSWrBL4UG0k2ApN
	 PesmFSrkSbdvCt2kYUkrR10VcAitw/tNjaoPqB4D/SSfe2ULan+wZXx6feNp977lFd
	 QCWXQj4hcA4Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401EB3800479;
	Sat, 31 Oct 2026 02:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net,v2] net: ipa: Fix double free of the interrupt
 structure
 on  config error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179341260505.1900554.6200995720286463519.git-patchwork-notify@kernel.org>
Date: Sat, 31 Oct 2026 02:10:05 +0000
References: <20261029082100.17722-2-fourier.thomas@gmail.com>
In-Reply-To: <20261029082100.17722-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Oct 2026 09:20:55 +0100 you wrote:
> Since ipa_interrupt_init() allocates struct ipa_interrupt in ipa_probe(),
> the structure is owned by ipa_probe() and released with
> ipa_interrupt_exit() on its error paths and in ipa_remove().  The error
> path of ipa_interrupt_config() still frees it with kfree().  If
> ipa_interrupt_config() fails (called from ipa_config() via ipa_setup()),
> ipa_probe() unwinds through err_interrupt_exit, which frees the same
> structure again.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: Fix double free of the interrupt structure on config error
    https://git.kernel.org/netdev/net/c/cb284914e749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


