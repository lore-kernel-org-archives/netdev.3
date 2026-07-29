Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4663BB48;
	Wed, 29 Jul 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291643; cv=none; b=MKHbrs/4AxliGGrmyFCCozgjDg3/WGEEIpLL4RQwgEmTGnAylAjCFZKoe9c/El41kNdTnzJdDK9hcYE7j+RzgbaRaNL2ogBs6y3UiB1Q3NWXiO+hqHc+FIZlebYVWZMzz6KPtNfDqiKS6/O2s2HihSoMc8/i8fV0AP6jcNoiYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291643; c=relaxed/simple;
	bh=BfdzX9mlI8Xf0tm2ki0kSvtcNq/Cz/D9SN+HIVIKHGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qhZqLhC4Q4qBLV+/5r9FA0tFC8WNbCrIlNjnoIwlufxj18QHoJmsVflk63zTYM/IPd//dks0igdTjXZNHFcBdj1JBum2pjNzmdtnToEcGsTtrJyknDbKgCX+kRrHgv/rfwV+xwfnI3RK/JheP07UBIgcNDo212VK101gpEaQB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw9M8cNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw9M8cNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E231F000E9;
	Wed, 29 Jul 2026 02:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291641;
	bh=LUXXZsA5zVRiWTELbcRwZR8rtebE8hosTMLXeFvFHq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bw9M8cNGcK9rf4k3D07NDGJSWX5bLThD02LmpnoS9s3O21ZcJYg04QVU2WZASpo51
	 IFmOHrftm1abrNskU50RXMSQP8lh8G6SCg/3mcx2QnKSTUxvYP4QRmU3awQsmFI/GD
	 2xTTyAbwx1SoMxGm9OOEtYIxIJGsSH+43nHaSjtuXDJjIkXj8qgSCzBbrsSbuvtC5v
	 0o54dQBIS2CvdSyUxkGwEculBt45p361nYk+4Ij0n2qxlsQGm0EvmiUeDL4R6yxsl8
	 s7A8BPdK1Zw4/HkTHm9jo/i3NIS5cDMfetOj6nE0+U4EErAXu0P/WNqbn8fdSOcSVo
	 SeHB2DWd12DfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938B63924A61;
	Wed, 29 Jul 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ppp: convert chan_sem to a mutex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178529160639.2412604.7477768336250808136.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 02:20:06 +0000
References: <20260727032802.4090-1-qingfang.deng@linux.dev>
In-Reply-To: <20260727032802.4090-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, hataegu0826@gmail.com,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 11:28:00 +0800 you wrote:
> chan_sem's read-side lock is taken under another mutex, so there is no
> benefit in keeping it as an rwsem. Replace the rwsem with a mutex.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/ppp_generic.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] ppp: convert chan_sem to a mutex
    https://git.kernel.org/netdev/net-next/c/2bb54b49e9d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


