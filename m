Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585B5C613;
	Sun, 12 Apr 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025843; cv=none; b=hjZKLYM08GwPVKdmxsEep8mieZjk4kLwx9BbQttepRfj7615hVTEDLb3PxdkWlad2zLdOhvTlL8hhml9EyTBlEGscXuO5RUCYFHOGU7oci3eSp8UwanMe281RhFhA1HszAyx7fBcPLIDDb047JnlaxvY9JDhA6vriuTIck2Gc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025843; c=relaxed/simple;
	bh=98UBtyx8ccfvo6A9jQAcH8oWBRXmSNSz0kt5tB27j98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gzJTiiCdPG8Mfqt3u4Drst+8FreJgiUyN1rWg7r91OHZQ9aJc4CVaFT6fVZFHu/3/eIo7IAeUwEG04uYfsP61KWK94fNNd3AgK8+C5RgdbN9rvWookcPNqhvyIY5qeluRI/haGDinMvpn1woFSssCh/EAWKiDfwFic/nR6llR3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExSaLDw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExSaLDw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6CEC19424;
	Sun, 12 Apr 2026 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025842;
	bh=98UBtyx8ccfvo6A9jQAcH8oWBRXmSNSz0kt5tB27j98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ExSaLDw5bgYoT/kFK0Oji1y4yxrScjyM2GeL0gE8oqoK2opX2VYHsg40mkKXfMGhL
	 Zy8hDvAyhtCZCma6XJFIb+BnwrSVWnGsqWCRo+9Qh0J278NKz7tfRhI6R4YxwqXYfS
	 TDBJDA4eQXvmIW4swhalDuLDJyuB103mIy++d1Z6J0SLu38CMxNlZrIAiR1ZLowE5V
	 QfcoSgG3tSODiDTmzI5y1pc4WM8xNAlIx0XdE4imj70SCiFnQDoLDOt9WdZ79pr+Mm
	 my0LJcUBQLcFpDsh8A1e1R2aE+KPgJzOJ0vN9FSwoG3/Q+pup+TZ5NdlfIkvy96gxi
	 FDEiCh4gyjgAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC953809A8C;
	Sun, 12 Apr 2026 20:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: hamradio: fix missing input validation in
 bpqether and scc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602581512.3400761.5438499340536330676.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:30:15 +0000
References: <20260409024927.24397-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260409024927.24397-1-mashiro.chen@mailbox.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jreuter@yaina.de,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 10:49:25 +0800 you wrote:
> This series fixes two missing input validation bugs in the hamradio
> drivers. Both patches were reviewed by Joerg Reuter (hamradio
> maintainer).
> 
> v2 changes:
> - bpqether: no code change; add Acked-by: Joerg Reuter
> - scc: drop the upper bound of 4096 per reviewer feedback;
>   only enforce the minimum of 16
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: hamradio: bpqether: validate frame length in bpq_rcv()
    https://git.kernel.org/netdev/net/c/6183bd8723a3
  - [v2,net,2/2] net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl
    https://git.kernel.org/netdev/net/c/8263e484d662

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


