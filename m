Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8152F8E95;
	Fri,  2 Oct 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901609; cv=none; b=WgIU6UuGvpNIB5xMxnwXTAQdw0kydufutjHYedzlcw/EnXro5AoUwQvopKGljJW7u3f5wNe8R96t3XosDerSHiuYI2bkfid4chttZDIo36KTi32KOKZ7uPewur7y2VeRl9rZdML470M15VpCdQtEgcjOxPMMfPURYeWDhix74BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901609; c=relaxed/simple;
	bh=nzA55e04y9X36ngZJ9feqsNy74JQaSEl0mP0xPciQLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sl5RFHR1WrKmiPed9R8CVWkHC4AWMQcWPcJhl8gNTL7/RtRNVkChM4+vvpFWpEQaMMonmOc2zbsCXmM3e78YckojhiZH5XkaKkL+U8ZI0aSToc4ZgQmD3RwPOeDwihonmCwGGsZMgOTqxVDcYuZcN1mctAu2BRkWtwQrGBtl+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtiTUzDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtiTUzDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813681F000FF;
	Fri,  2 Oct 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901608;
	bh=q46L2/V1DUaQ34+1OqzdQ2rZFyX2k0O3zNkucInFmA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JtiTUzDY4RymK52vtSr4hBIEGZDYUZY2u2iD6hdhLwpKISTb5JebC6Bz5aJAr4V5m
	 SFyJ8qGqedp//DyQso4QW+KSsuFWeRqXFjjusB4NtmIVn0JqdI8BkiX6JKym3u5k/B
	 Qv0nmo3KDGQ6K0qg/qK8NHPOBfjTqUSve6jjKFgIKxR5mpsARXRi+N3h99dYAdHNHD
	 V9JS70Dp0hPIa2D14AKTdo1a5OuuK33OrURWuD6xZ7qpETLKTQ31NIk5tYGbnnrCCd
	 p5bzVbRrSli4BmiIKnCwDmrmkc0bbUHR9dUidS8Oey7v3Tx9HChbihD3bLPeUUhjuM
	 KFmNTK0boW3/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7745F381197C;
	Fri,  2 Oct 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: fix kernel-doc description for
 efx_ptp_timeset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090160702.3158777.11776047725730596443.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:40:07 +0000
References: <20260929094211.48125-1-ayush37735@gmail.com>
In-Reply-To: <20260929094211.48125-1-ayush37735@gmail.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: ecree.xilinx@gmail.com, richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
 jkoolstra@xs4all.nl, me@brighamcampbell.com,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 15:12:11 +0530 you wrote:
> Remove excess @valid struct member description from
> 
> efx_ptp_timeset.
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/sfc/ptp.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] sfc: fix kernel-doc description for efx_ptp_timeset
    https://git.kernel.org/netdev/net-next/c/bbafd2f4b354

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


