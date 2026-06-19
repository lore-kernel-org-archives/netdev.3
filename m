Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0110432ED34
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832616; cv=none; b=cCMHRc8jKSQBmBiNcpGE1xWmUx0Ro8p/OsBp/7VM5vAgr5l7M/Edtz4naJIHAeuVtTfbHwJw9fRhplL2zgDTfPKLFqsZhJVSHE/RytyLSIOIidZ88TlAnZl3qgARR/QkT8P8m1fGxFOLghjzNTr9nGjMIIXiJy60y2JEQNNcDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832616; c=relaxed/simple;
	bh=qJAaYzFgsIdNGVlTj8b7gNRMNqGo6RKtB9dlkufPk/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PcQbZiVY2c8WVqCMlRoH4g04NGnKqd4qDHdr8HpFGS1w/w6rhmIgmildaovZ7R9G5DZfFOPxSmONLsI9UOxzIDUt8hQ0rzwAvc1yjl7dnhNt3Tyc+6lVzp7LIZmc9M+V/YeOUmeLEjNWZ3IIVYuJ9fMPv/GR6KertY0tk39y7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixcj7uuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixcj7uuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913181F000E9;
	Fri, 19 Jun 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832613;
	bh=Mdri5u8fjhmWM6bTJIfCNS5aS6Cd8JDe3rJ+eaeN0Zg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ixcj7uuC55izpppWYbEdT6TjSqo8umnDk6zrs66N4dcUHaNh5ja7gm76FbQeHQKd1
	 9pQvLVceRrvL4/hEwt3oKiujSv8059ccE5fPwvgfbF98T3NGQwhAADeNyKHbhIjIcP
	 Ju9Ew0xep8w6cvMCyAtSorW7FqmH0/BOA5EjCveJDpePdflFvWE2aeJdEenEy2Z4Wc
	 EDlyeTL53m3RMdSv5m57ojSQLVjDWM3VsGEF93DSc//OSYDHL1cP4pjRbsjB1GQ/Jm
	 R19XY9Ts/XTSxCuyo/UzZlhkhdOnWFzZGiNxG0h12UfDIukyFDVRdInHysfS5GpCF+
	 5ATn2aWMLvPEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199793A78A7C;
	Fri, 19 Jun 2026 01:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: wangxun: don't advertise IFF_SUPP_NOFCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183260664.3153236.7399761743268101199.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:30:06 +0000
References: <20260617092854.133992-1-clementwei90@163.com>
In-Reply-To: <20260617092854.133992-1-clementwei90@163.com>
To: Rongguang Wei <clementwei90@163.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, pabeni@redhat.com, kuba@kernel.org,
 weirongguang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 17:28:54 +0800 you wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> Like commit a24162f18825("i40e: don't advertise IFF_SUPP_NOFCS"),
> ngbe and txgbe also advertises IFF_SUPP_NOFCS and allowing users
> to use the SO_NOFCS socket option. But the driver does not check
> skb->no_fcs, so this option is silently ignored.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: wangxun: don't advertise IFF_SUPP_NOFCS
    https://git.kernel.org/netdev/net/c/0ec4b7859870

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


