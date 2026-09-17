Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC921A434
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606275; cv=none; b=HgqulE+o4KGFN022j6kOW7fY1Kk35IK23W/QWjs4bRdUfJkU3RMelZc+LHjU+uGRCf9Dn6UrF8G2xDjYFl5FgUhXKMjBDPTHm/zLaC45qKMjNB5RYc3ZO0gJ7zOpjmxTYQMc8WVq1xxjkCR2dNaN/EXEsmOec3H3OKi8oEbMfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606275; c=relaxed/simple;
	bh=tPXPwEVrEDPb6h5nubo9aWGh1PyuHUf7eTSC/4jIdKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UqR/eIw1F2SPqCHlIyAjEZNuCLQ0nPVnJ9kwdVNVzhMptoEwCv5vXhDfok9oUI7TTkdXvnYxeY1FLcarjMGH5p1kzTbNohl9mhnuwVvgWfKK/NXD2+8hQ/Rj9E3j2BSc3UDCGO+Raa7wuRAimmjFDC0pijbx2j5ht1gPshJxBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL3/bKQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL3/bKQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF421F000FF;
	Thu, 17 Sep 2026 00:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789606274;
	bh=U9GbkXtzA8d7L1WrZXuMo3S1kKbcyCsM2we/mmRxGHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YL3/bKQWKEk9pCJTNX+hVVX0qYQdgf//KPM6DHXJd6/XyMytMaK2eySgwuPiaY8Sy
	 TKJM+wL1lEcLKfKO5F5UWfp8BPWpUpHvXZ8fUEnLSwnY7ozwzaQ9vDdGem6AQYKskP
	 +mEuFStvwihbbhXBpPCy9xtIGlyKSQ2W+AtxntJspBpmRzWgrmbmEdp+pURRq/s/wi
	 OtRIFTNEI62ZhOo/MRrKQwQena3BC0HezwjqApi2/LMdlWkZRznIgGV5ZItnPR5XvI
	 +Esy51JmiCpV+Efkrq28A0NY+Xn4fQ9aVdwEh2RDmtBiccH3TwGA5wakz7Wp61CNqY
	 xM0OpFHB9EKVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5677B39E9601;
	Thu, 17 Sep 2026 00:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: cortina: Gemini Ethernet
 fixes, part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960620812.3357310.120841097118161243.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:50:08 +0000
References: <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
In-Reply-To: 
 <20260914-b4-gemini-ethernet-fixes-2-v2-0-5ab39a047b90@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 23:26:40 +0200 you wrote:
> Fix two RX-path issues: acknowledge FIFO overruns with the correct status
> bit and bound descriptor processing when malformed chains lack EOF.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> Changes in v2:
> - Resend as prerequisite patches didn't yet reach the merge base.
> - Link to v1: https://patch.msgid.link/20260909-b4-gemini-ethernet-fixes-2-v1-0-5ea3aa393f41@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: ethernet: cortina: Ack RX overrun interrupt correctly
    (no matching commit)
  - [net-next,v2,2/2] net: ethernet: cortina: Bound RX descriptor processing
    https://git.kernel.org/netdev/net-next/c/c5faf1d4df8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


