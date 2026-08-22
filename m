Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E2331EB5
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430065; cv=none; b=X2KIQAc1cE2z8Vd3UKMWo9cnJCMThSVDZ1+LWq5BpIMTR/XDIY5SpFRCI+bC6R2qZnNf0PfnlRfShQkUorTnaFVnM6Zp/lD50FJS5oFR2Z/MwqJygEHqDI4Pqt9SEFlrSXruMCI7g11BnRk3lQmfGUGxvDOvxPSoKqRDxP33bLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430065; c=relaxed/simple;
	bh=EqmKk81lVW6FNStXii17Fq3r016mP6X2LYWN2kdfGfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjYJrDKMfC0LQvXeszKtCy+E1u9sB2jy34AuQa0jVtQB0ILqs2F9cCAxgElHCxkmI84asmZTOPykzBDf9rRLoV/vVCiC4Yd/HHZQybF3KPjdOplgitNet+v9c7hga56db5oojpG4W2iMx6R0uQXth8TBLDMuqEVGmp9uL3YdudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJQN7k1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJQN7k1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FD11F00A3A;
	Sat, 22 Aug 2026 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430064;
	bh=g2JUEAsAF+Plcu9brirR8zdujspFNvCaj3M99ysuIng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EJQN7k1l4E2fY6MesIT5gyRPDKKFIBNv3hif2xza9bucXTTCmTNMXfgAiQH8hsBUH
	 HLFg/Topwx8DiPZvADm0slswBa4Ad2MIAPZ9WhOkEl9Tk53jc8fyuKZqjwA4HtsyUH
	 kRRYK4id1ck0MThr4j31Qg8qwwKa43RWe0optIo5S3lL85ZrYcx3ej7UvMuCjvv4YD
	 NwvFNEjT75O/yR9L3uOUrpojJhdx+sbryTMKrkHKqb4/NznTp2qdCl3TVL9M4Kt67/
	 QWY3X36S1zXdvFmDZADSI5SbMvL4vc93p0/No/Ir0A8jrotv6KcRNI+PySReqkyQzT
	 jv0E0VdTD2uRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1975E380CEF9;
	Sat, 22 Aug 2026 20:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] tcp: clamp route advmss to TCP_MIN_MSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743001263.1816901.4823966931079740050.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:20:12 +0000
References: <cover.1787074852.git.edragain@163.com>
In-Reply-To: <cover.1787074852.git.edragain@163.com>
To: Wei Ren <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai, edragain@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 23:22:03 +0800 you wrote:
> From: Yong Wang <edragain@163.com>
> 
> Hi Linux kernel maintainers,
> 
> This is v2 of the fix for the divide-by-zero reachable from
> tcp_select_initial_window() via undersized route-derived advmss.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] tcp: clamp route advmss to TCP_MIN_MSS
    https://git.kernel.org/netdev/net/c/870a9e42ecc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


