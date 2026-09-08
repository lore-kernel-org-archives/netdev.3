Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010071F4631;
	Tue,  8 Sep 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829271; cv=none; b=cRGjMjpJlQRKpUMdKzwRt3phGcLWJYUstWuJP9PxgBDvNgjIE2cLkccuxjYMRuUFW99042qAoXWQhEpnuVh1FoADqYw40BY+6kK2LKU4tv75gHQgQAFZpreEkBpnqQNE/7/W0kZpKQ/x2GmeAPwFaxyLYMwMYVrGGfI2e/nAH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829271; c=relaxed/simple;
	bh=0xZRX0AKAoaG46NQMKbZvPKXeSe7ATLCUXPOauhQyBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQjQuQu2IloKof7ut7Ro/E3BifyvPczFREc1CMyfxeQjbL1vPVDbOUimsEz74y+kRllhDcx4hNZkDfYoS3JY5+zCIClz3hdhlHKnncv7/e82DFyG7QacFu0lM7QMl/ni11iG6MC5isv+WUvNcIq8ElYcZPh0wpJwTEjkfNcptlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbOhjWh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbOhjWh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44221F00A3A;
	Tue,  8 Sep 2026 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829269;
	bh=p/vaUN8SadathI4jxOqi9n01Wg4n5ht8CeaibvOt1Yc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FbOhjWh/uyfcH8rCLz35B6S2j1ujViyXvAhKHCazfMayH3mvq1dqXf2KStEE4BRsT
	 WT1i+o14Dxi9an7haIBCsnBGkIVCEUDT4M7JBMCPR83FJRu/b89ZcDQBs+j/5ahrvy
	 pfkJOSFUrhQCURUh8zpyMsXLNWzptGAlSf/8Q1NyRBXYsylYASglaEKnan/pHX/tW7
	 jgNkDwPJewrunvDc8l8qwtGxQoh1Q75vUnMM/CbGWUjqMaZAdrEZd8tXi9Zv2kJris
	 kRXQDIzPDFSUDnbhNsLj+vcLFsAKOv5vqJ8GSwY5XftmBwiSm3+aU6ShzzMvJF0mnT
	 5i6SiXoeNCPDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B6339E8A5D;
	Tue,  8 Sep 2026 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: cortina: fix typo "trigged" in comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178882920839.3227186.17273676298075009873.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 01:00:08 +0000
References: <20260904115917.13695-1-hemanth.selam@gmail.com>
In-Reply-To: <20260904115917.13695-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: ulli.kroll@googlemail.com, linusw@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Sep 2026 17:29:16 +0530 you wrote:
> Correct "trigged" to "triggered", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: cortina: fix typo "trigged" in comment
    https://git.kernel.org/netdev/net-next/c/fde5a8bc4cc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


