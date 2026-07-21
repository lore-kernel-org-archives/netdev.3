Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681F46C4B6
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655047; cv=none; b=P9AW91EepW6ozNxGzHo01zw+D36dG3yLds24o0VjoZ32L+eS9ZGXV5/UEGgn1/4u3QzmH+3N8TtLB3hPm3aNH6PRxSeCJr7HGU05fJ+Anq5nuOLoo/rztafjLwAJaqcqyD3PMLeCriuUPSwGdfYNTdFVILy6RRpbTIx9jAuf0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655047; c=relaxed/simple;
	bh=kEt7+5y4zwST507puOcN3dCyfwBWL5zSUnr/w8+EI8s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yomq/JBUsEhVukazkPvR/2h86NQMDCg6Sckn8gzU5pgD8J/QjW8H+pZAyar240myS8JmAoFH87d11Eg6qs8an73UfAxQES4gnj2YQu23oj0cI7WMpo5gEtxUIyX3/iuvf9NIVXj2Huq0YZ8Sj9aNsJgGRmy+X4Neu5E0ud+3laU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrEuD95G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrEuD95G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA91F00A3A;
	Tue, 21 Jul 2026 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784655046;
	bh=VgiuplhlX+zgD0xJisPJ9Cmu1YvAfEJQlV0BSFK2VQY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MrEuD95G/jr01PR4ojShf2YbzhGUFcUSUsRYmNokJuB1ZRcXUW2B9CNDk2dsOA7eA
	 G3CYUflaKR87Pq1UbKJtH/j5OIBLbGEResdRbbMIny47l4CSZF7hgrYu3Idz84OKqW
	 pL+xKJ0QzFGpDGfnTsA99V39uY83NqguLdGoAuBBaP11XV/OMu1vMKHf17ylwoqDW1
	 yq9/883lkAmvtRSPn7TGVOChsGwh9mCdy3iC2gBAoJuTgzOOQSL1q2rx8uP0emosM7
	 1FDy1ot8z7B0p0Zws1jtJWqY5VhuZmAXjBzSK6C6wGd4/hYwY6GZfnidXigJa4qtSJ
	 KtWZDgUpcwFAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19E0739253CB;
	Tue, 21 Jul 2026 17:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] geneve: fix hint header definition wrt endianness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465501563.874899.3127995542704202708.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 17:30:15 +0000
References: <20260709124801.140632-1-atenart@kernel.org>
In-Reply-To: <20260709124801.140632-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 14:48:00 +0200 you wrote:
> Bitfields are packed differently depending on the endianness, take it into
> account in the GRO hint header definition.
> 
> Fixes: e0a12cbf262b ("geneve: add GRO hint output path")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529144713.780938-1-atenart%40kernel.org
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] geneve: fix hint header definition wrt endianness
    https://git.kernel.org/netdev/net/c/751bfa982b4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


