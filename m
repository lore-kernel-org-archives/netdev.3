Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCA23E320;
	Fri,  3 Apr 2026 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257829; cv=none; b=LpOKTjF0RbXfT+jiC2tWwZfuhK/Rs21H62gaop2nwEnQgty3YamW8P3BVcwRldrmXvk9ooFMzQjISCGxqByfj3qwWvqBqmQl9hv45WKkYgP5qG1/4178s5UT8Uk1Dk1ldhwtERfR1E9SGgicCM77zNbHqeY8AvBymfCaaT96bcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257829; c=relaxed/simple;
	bh=dHW2heR6p5vw6+Pt0QE9uTTUItO4MGXSvD/EFCFHJEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvlt4gIOkCdss3X+ZnDZqIzYsQo++RX8tHW3Q2I4izpjmJ7bX+1S3ASb/7Ql/rIXy87akka9YaM/gmLqrpN82fE+T95t056xEIxBMd74JerY7soCskPUOXcL126D6ckJ54MMg/5BaXPaPbZEnCx6UVt6A7lnYdDur6Ffkac59G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqxbWPyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqxbWPyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACDC19423;
	Fri,  3 Apr 2026 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257828;
	bh=dHW2heR6p5vw6+Pt0QE9uTTUItO4MGXSvD/EFCFHJEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YqxbWPyOvyxO4um/D/zqhvz6HOiCn00KDoemS/zA/M8EuRbE/l4ZetWlExTGwjnd5
	 GVk8ztWI5wdcX7rSqmpfj+1ibCMSud1geHoqeYMUb1CWXPRvJu7HEhIGBnYaplddYN
	 mTk/PZoDIU0+gaHX7pg45FTZPHjJfAeMMtwWRbf0LQW8ugBiEcyEZu1XsVVvxWt22P
	 G7g1LlSqSc/hkJsgtE+KVcGOgY386kC0pdLZniJFg9h4wCFlIPpTwD5nkzYFGcVuz+
	 VJ+sD+MUNom4n4Yb4Vswu8z1BpTUrox6WehH9A8umaFYPIwhyr94cJvnSA8E39LNBv
	 4uZ89F/O3TO3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD13809A14;
	Fri,  3 Apr 2026 23:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfc: s3fwrn5: allocate rx skb before consuming bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525781029.1484550.16067345622361730723.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:10 +0000
References: <20260402042148.65236-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260402042148.65236-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: krzk@kernel.org, bongsu.jeon@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 12:21:48 +0800 you wrote:
> s3fwrn82_uart_read() reports the number of accepted bytes to the serdev
> core. The current code consumes bytes into recv_skb and may already
> deliver a complete frame before allocating a fresh receive buffer.
> 
> If that alloc_skb() fails, the callback returns 0 even though it has
> already consumed bytes, and it leaves recv_skb as NULL for the next
> receive callback. That breaks the receive_buf() accounting contract and
> can also lead to a NULL dereference on the next skb_put_u8().
> 
> [...]

Here is the summary with links:
  - nfc: s3fwrn5: allocate rx skb before consuming bytes
    https://git.kernel.org/netdev/net/c/5c14a19d5b16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


