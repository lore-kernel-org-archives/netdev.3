Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C03347BDC;
	Thu, 17 Sep 2026 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605687; cv=none; b=qDDjPk3Yyi1hDJyunPvvpcNldFKSM12w+5unNnr4+8TkFUfCKQCTIoonBilAcSOHKrqVZBf6vy3zpqaaK2Egts/UkRFMtY+ryQ4UsrbZHNfgyCauqc3BD+duRWarFVzGvUa6qzUwu4JdY98CwzzqMj/mSNoMQeYIZ4FnEV84gQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605687; c=relaxed/simple;
	bh=LdzIGKc2H010OK/e0Y9DWBLJAyxaLT8kFyPE6OnmPDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=giyno8iMwrdDAy64YhO4Z2LK1djFWAhi9xSuhTk27wbs+HB6G+uwNKATQ4P6nse9PSmCkNbGCLsP/6iWBhQxz5XS+g75I/yTXBAqtlbo8zoXI+JpoC5rKJefz0JzJqspRE4+WCB7km7U8ssno3ZivcZDTCvLqXv2/896LCnHNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0DcBM+1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0DcBM+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD381F00893;
	Thu, 17 Sep 2026 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789605684;
	bh=QFbuXufqOQ4nMKTmIHry8sVooUvZ+CoVf4SjyIcYCf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M0DcBM+1n1DABf3OzYZVWK1d5njqdtGWzqFJFuddU/Nszl5ZlOuAPPST36ixyjDnG
	 A8F6/GE73UeVzVo9iGlygvJOIbL6k7u9Heoyd/cI9Yjzz/yQXHi1TK0X6K/tBybcMF
	 5ant1Y6Z9djnRfDjUWEw8xTw0NiPCUsp9KTcv+gmVk2z7Q1d/tiLF/X0O3miSSrjOf
	 wdu77CJOZodFSSIqowflt6trMxtFaZi6B8yj4gu1dhHzJhDwfLYVegutHdhWQZv/z8
	 YDfY1MDT5gbbIM9YkTaIgyurhvyvES7dpuuLVWlcf/sKLjyt024V7hs/r01HXrEAuK
	 lMxodmkTH2qow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C4939E9601;
	Thu, 17 Sep 2026 00:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: broadcom: enable jumbo frames on
 BCM54xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178960561813.3354472.15061538839508121530.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 00:40:18 +0000
References: <20260914094703.1093504-1-nb@tipi-net.de>
In-Reply-To: <20260914094703.1093504-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 11:47:02 +0200 you wrote:
> Jumbo packets need two bits that default to off, extended packet length in
> the auxiliary control register and PCS transmit FIFO elasticity in the
> extended control register. The latter raises the transmit limit from 4.5
> KB to 9 KB at the cost of 16 ns of 1000BASE-T transmit latency, and the
> two together take copper mode to 10 KB.
> 
> Without them such frames are lost on a 100M link while the same frames
> pass at 1G. On a Raspberry Pi CM5, which uses a BCM54210PE, 9142 byte
> frames at 100M are lost 20 out of 20 with the MAC counting every one
> as transmitted. The same frames over the same path at 1G arrive intact.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: broadcom: enable jumbo frames on BCM54xx
    https://git.kernel.org/netdev/net-next/c/3c8abdbe345b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


