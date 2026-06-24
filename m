Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C12F5A06;
	Wed, 24 Jun 2026 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267657; cv=none; b=et3/gvvgS0SX2kdHo9LIGbZcc21yqgutnHJFdmk/5qRbzEAzMjrXCFFtShlMi9lhjJvg4PIhGlVLC074paLrLK4PeETiwTknL+ekv6mEek+VkByVikNPE6TSqzHJ1A+LMPGPVOLG5467jK5W2SXfJCKEZCYvTBzTDJd79zbYle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267657; c=relaxed/simple;
	bh=Byt/a5YwQm/EbwETwfYl3nWaMfwquFX0yVQBFnyXY3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=biNdp28LVJADhSy82a+/5Mi4ViOnHkad6RgwhA/QR9u5jAu9rNqQaoO1LZ+gRzbyFimdGW17QTYDv6LTppcR7gnu2mmYvjyFRVbaatWLHzOb7X5xdWVD5lwxZhbyEbmm3sEgDpB6vv1qlmY+WfgEM8U/827sKSQNNRotx32sKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGluRis+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGluRis+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287D71F000E9;
	Wed, 24 Jun 2026 02:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267656;
	bh=8iv5NZ0EhjGf04DMhe6kkoG+u1oTq9Sgycti5VptFuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jGluRis+/NBJFDkJeRk23Bpx+TQDW8Ooq2S3tbRmwMv6TqWew9T0nYuxHRh0BDDj5
	 JWRVEj6IhBYdNGiheQcZ3C7xmzJ6QFqdwQuslzklmv0tzo01bhkjroImGTtqkC+FoS
	 8MptUCBlfkOpxJV/InHJ71m4SoCKap6o7xsvIulCzH0uSHoQ68T/V3iZZwUR0bhZUW
	 8hGmiMZWfoiBCu8+z2e5HZUecf/ym2SEzSu4mGGB43DtKg2U5evrP2uhPDE2k/AY0J
	 zefadzhz6/DjNm/7Y2ppEFa1qOPl+lm/15z+naO9+AOTtMQjKAS7L5tIjkp2SxNbzg
	 wainOGAJ/ITYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A8393102A;
	Wed, 24 Jun 2026 02:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226764506.2513445.9930233925704678428.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:45 +0000
References: <20260622180721.28334-1-wellslutw@gmail.com>
In-Reply-To: <20260622180721.28334-1-wellslutw@gmail.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shital.gandhi45@gmail.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 shitalkumar.gandhi@cambiumnetworks.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 02:07:21 +0800 you wrote:
> I have left Sunplus and no longer have access to the relevant hardware
> to test or maintain this driver. Mark the driver as orphaned.
> 
> Signed-off-by: Wells Lu <wellslutw@gmail.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - MAINTAINERS: Orphan SUNPLUS ETHERNET DRIVER
    https://git.kernel.org/netdev/net/c/89adcf17ee7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


