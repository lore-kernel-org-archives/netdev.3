Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B3280CFB;
	Wed,  9 Sep 2026 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914471; cv=none; b=BEPEzE18K+ZXsUmdhKhnF6Joh0g6SZapvomWaFvWAisX6CarzGSpbgPoWesxwoX3XIz7Yt3xTS9XVAA8NGdCjaoeZuifwVat/PlFq7aIiiOGqt1pNZ2A9vj07fygDsC5QP4lF1t7FAdQo1QMAoxkXaVhc4S0JKtEC+Ya3LD+4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914471; c=relaxed/simple;
	bh=rAtX95PlyXsGKChOaKuWJ7OLalkLcBoK3VjJCdaaWHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M5KK7XQVKNZ+Vrdhn7aaPUvWmkF/N5K9oBgqHmGayQokn21FcoKk3LWpCIyCdbzHpDyzIfM6ALyYZ/3A58teb//Z4TnnUJUZuGGixE825DlXqSOPVmW+hATh4dMv8Fj6yAmcBnpfJI3mm7ScdyplRcxPnO+PEBjJnqbCTHjD738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMx6Nt4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMx6Nt4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19071F00A3D;
	Wed,  9 Sep 2026 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914470;
	bh=irVZ7D1fEE3HniqXWVgOFi+BwWjVyu7zPzBMaO1nZpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nMx6Nt4chmmQEo8Uwjbufr5dS2xUuj7k6T4LF/j2w0Y8HcaJ6IvWWW0+FdfSWhv0Q
	 OGJ6EEXLNuIUViYuE/GvRXKgkfh1oHFqdN9u8ajUUXmVRMpkqCAr9TZDicrshnU1np
	 mc9r6im0bZ23cedsJtWAs/HL4sI7yEdYMKrKhr/l9Z5IUsBGKxEMR2vmyVeMge7OmT
	 lV5fQjcAdkRx5vC2eMcKmS4pZayP4xrpvzlbBoiQUMDgQhSWzVo4+KEPRa5yyOAIMo
	 8iYx3cLcozent/cv7m5G4HPoBCxEO2bX5bn61Ovj/Cy1ouh0fRLVGPum3lU7sIakTC
	 96OVyh/DXK+zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93808380820D;
	Wed,  9 Sep 2026 00:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: smc91x: Remove stale documentation
 reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891440813.81609.7874685715383211918.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:40:08 +0000
References: <20260905051944.11604-1-kmehltretter@gmail.com>
In-Reply-To: <20260905051944.11604-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: andrew+netdev@lunn.ch, nico@fluxnic.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 07:19:44 +0200 you wrote:
> smc9.rst was removed with the separate smc91c92 driver. Stop
> pointing SMC91X users to the nonexistent file.
> 
> Fixes: a3fb9a5bf660 ("drivers: net: smsc: smc91c92: Remove this driver")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: smc91x: Remove stale documentation reference
    https://git.kernel.org/netdev/net-next/c/789842b671a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


