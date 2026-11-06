Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005410;
	b=pMGzjlx4iW2qfqvxnGVzqykVGNyYihjooLngye/5FuydOCD6fCIGUbpJsWr0/dwhupSP
	 bouwUOIQq2vmETDsAjGm9NTbHeL1mG+r+rbvdvFUSLWB4Rx8vKx0RDsmYUyse/YQyKBeY
	 y6CXTiK37/Rtlzu/BMXyyBFQwkJwTarYHZJIilR1ZofGIJpNzkyDz1EBudzD5+vuFWzXj
	 qUCzeXMYit7X6P0KgeJ0kZShuFh19njNRtn0/sPDLYsiILgSZ2O7emOXr0G6FoVFqX9gH
	 TEcrw/DXQItC8mKbNSNnsu7f/bqFw0nwCzMW8j6GPyV7FOR7rYoC7vj3Poy/VGNWloQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9ZLpQyvtdYVGyID0aWXmsg785XHobyy6QQXDYoshbAs=;
	b=RP911fTtaWlvEDqBbpvYlsyQjmRC6ErTmEO8zPC3CE8Mm2cteGaxdIG2eHwCbegWgyrb
	 pxjhpM+evrYrS2JPhhkjmzQYtF4P8Pf2RhvoCAIqWdTs4C+7KIgrYw4LAVyl2dR4UcVA/
	 6Fffa68X1S/mNNNyVfZLjz63E48wliRRp1vAj6pJDRGMv1Xc88MwjI6SsG60FtNdvv8yk
	 WHQj0LFfjpEYOp56LYPlYa2IhMlGgUNxQQsY6VM1EfJTYzsDQ/LkmxqBth459zI9pGpbk
	 1TlC/Em6pwsnLbrgrVPEkY+gMbdp53JqIo2yeyjpqARoq7CBLbYHKJclzVDhmCxKGMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfAcyqCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AA606D802;
	Fri,  6 Nov 2026 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfAcyqCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31431F008A3;
	Fri,  6 Nov 2026 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794005409;
	bh=9ZLpQyvtdYVGyID0aWXmsg785XHobyy6QQXDYoshbAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HfAcyqCYfNGj2KyDoSSZFC7TwK66fbrCupOLinfxbjZet+8Wi2RsitlrAc/1Ty/z5
	 U1DptM8S9BBKPv7dbWpQohULUQw8u4JfgWbgZZrCts7O9/ONdFxfNP34/UT7IYEWFj
	 9PVm0c9DgycdmBvwfZs+3AMqRsvdNTLCADDuDwdh2Nuc5HarNMcL5h1mj1D7nM+VNZ
	 uKCULw0XJKBM7ffrsXXisnVgq4rmqD7bs4LKMcyCh4K2fHuf44yVDvsJetlc25DU2g
	 7AQeHyxDreplO/lHIJoK+qUP92/dJMohFGB2VqK/32+g+3Tpo3cC4O2jUHB2w694e6
	 AHxiHvmLR6/kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2043A55EC2;
	Fri,  6 Nov 2026 22:50:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpts: keep port and
 direction when matching PTPv1 TX timestamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400540817.914342.9340472227607828483.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 22:50:08 +0000
References: <20261103-am65-cpts-ptpv1-v2-1-e1f79ed1ba60@pascal-audio.com>
In-Reply-To: <20261103-am65-cpts-ptpv1-v2-1-e1f79ed1ba60@pascal-audio.com>
To: Jesper L. Nielsen <jln@pascal-audio.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 bigeasy@linutronix.de, martin.kaistra@linutronix.de, andrew+netdev@lunn.ch,
 s-vadapalli@ti.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 03 Nov 2026 09:42:52 +0100 you wrote:
> From: "Jesper L. Nielsen" <jln@pascal-audio.com>
> 
> The CPTS reports the message type of a timestamp event using the PTPv2
> header layout, i.e. the low nibble of the first header byte. In a PTPv1
> header that byte is the upper byte of versionPTP and always 0, so every
> PTPv1 event is reported as message type 0, while
> am65_skb_get_mtype_seqid() reads the PTPv1 message type from the control
> field. To make PTPv1 match at all, commit 1b9e743e923b ("net: ethernet:
> ti: am65-cpts: Fix PTPv1 message type on TX packets") overwrites the
> whole value compared against the skb with the skb's own value once the
> sequence ids are equal. That throws away the event type and the port
> number of the event as well, so a PTPv1 skb matches any TX event with
> the same sequence id on either port. For PTPv1 this defeats
> commit a23c657e332f ("net: ethernet: ti: am65-cpsw: Use also port
> number to identify timestamps"). The overwritten value also sticks for
> the rest of the TX queue walk.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: am65-cpts: keep port and direction when matching PTPv1 TX timestamps
    https://git.kernel.org/netdev/net/c/c4b75e64aa5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


