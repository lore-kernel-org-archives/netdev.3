Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CA72621
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841867; cv=none; b=U+Bd0bYK+UkSRe6mMD5VzHZnWpbbEYXUbnwsg0MoELoMrNWvx9+y0A/ubNTXh04FMLsS/VCTsb7gTpsOH1x4YhsUSgbFDD/4QfA9zcReAX/UnEvnCoEGGFUGlYGyqJmfT0bYJo2XqoGYFVRORunMtVFCacFFvF0yymaK9AENWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841867; c=relaxed/simple;
	bh=qM5//IbKIvQTg29r1d15kR2NQuIztF5gp47vOPie/pw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUtoDAsTw+9NDkiR2o4Tju5jdiTzWxxn58Ghbd+FOhrnod+nYSJNEFy/RjSijvqkA6SjlVlHVqt81QzW8sDx5yZJlKQzU9hjzMplR+bYX0jrjil/yCnz05p5z/U4oBb87FWV2opBbC9gV9bvWqekvq1cs1we1sv3lc6OckfR5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ircZpDte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ircZpDte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402EF1F00A3A;
	Tue,  8 Sep 2026 04:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788841866;
	bh=pjnbx6IW+LGFhN2Usyy6w/2iUDyyHS5s7Y0Rbe9bpqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ircZpDtebMPancL0t8f3EWR/gVPbo5K3KVfm1r0c6H4S9NYUTh9Ho8FlplHzz6tBM
	 ayWowq3mrPpoWLPPuosO43Vbmw3z/nWF4bD/V224ffZiVJvdPrZGzI/2ohc2kPbvXZ
	 v6EjiZnauIttgndPpF1X4fW5NTXXVN8SlkWbIarKbxGL6muYOjsqkY6l9YoMR73kPp
	 6FkhMXb01ZmUgRdyLm7uT6M5wb5YRZs/rNzdPKH9Fq94sd+HLk4oWLj289PZ1edo78
	 L2uLp2BRNOBlIhzSjSncJcFT0um4ob9KwWttxSxSC4olSb58uA80kdPlgS6WFpj5Ef
	 OzdnmoKxUmS1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5686639E8A5F;
	Tue,  8 Sep 2026 04:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/1] ipv6: flowlabel: cap duplicate leases per
 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178884180515.3283041.5224905934013507102.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 04:30:05 +0000
References: <cover.1788415194.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1788415194.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 14:23:02 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv6/ip6_flowlabel.c. The bug is
> reachable by a non-root user without namespace setup.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/1] ipv6: flowlabel: cap duplicate leases per socket
    https://git.kernel.org/netdev/net/c/8d6cd1885085

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


