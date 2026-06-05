Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EF33557D
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623018; cv=none; b=gueeGixtcjprrTc+x1SU0s7zil6bclJqpQ+W8B5r+rvAJzuQyZqAQFv09P02jr9l/OC81n5IAlhLiYmDrcdxV5ai163zatEMo/Js7weqpzGW2z3Oq4DRfNBup+52IHQ775EVwPdF4OzuL8I+tL+++wK5zqK7CUPAOYCJ3bCWenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623018; c=relaxed/simple;
	bh=5kV280KPpbrtrlQBD4AGUpPoVy0AfDM+cwEdL+HhqKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tozOJtYulxuviSE/p1AgWOxKhhVJ2RmRk5+ENarGkujxyF0YZYbdbpuEMkwyJlM1bGAOW4iUuGJiMyOnJb+nZIEq/cO+h20jw6xeDJqwVfeZV2tyz4psQkWEv2VXxk5sOsd4AHrTcsJZMNTShSnLM3nhUqXNImhRRQ0YYQu2R8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCFmOPDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCFmOPDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED28B1F00899;
	Fri,  5 Jun 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623014;
	bh=weNg96zxEw0YQOLnRM6yhlBqLpFSoIZgsDdg6LWSa4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DCFmOPDaH6XNj24ToBjQJOCu2J6zcZoRZ6/WA1oskRuKTU9HiobgVsYJOk+q2zeFS
	 gQLDtlTTZ8nI/T0p/K7X59cuTglFDyAmG6YQgPbRAanP3mNHUu0mgh2S/O20r8jsbL
	 jTnq8oZxr9QOPo6NcFpjjK3icE0LC4U1Ged+52VL6vQ4FUDKEMgj2cKyUgkkcsx2F2
	 CtxLesaj54PR1KdHOkf4C+2Cjk+QJl8G+iCxwh0Yfql/qWarr7y9dNhcOfvyoMIQAK
	 VcOSSHgkVDvt0fClGN/zlG31QrB5GWxfOaBMfrPIsVu3X57AD5BW9ze9bnOBOrHb3C
	 FtaV/n9CdHWxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D094E3930A8A;
	Fri,  5 Jun 2026 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Report extack error to the user if
 airoha_tc_htb_modify_queue() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062301439.3093327.853203913546216659.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:30:14 +0000
References: 
 <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
In-Reply-To: 
 <20260603-airoha_tc_htb_modify_queue-err-message-v1-1-33ec3ab997d9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 03 Jun 2026 12:30:01 +0200 you wrote:
> Report an extack error message in airoha_tc_htb_modify_queue routine if
> airoha_qdma_set_tx_rate_limit() fails.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Report extack error to the user if airoha_tc_htb_modify_queue() fails
    https://git.kernel.org/netdev/net-next/c/144969cd80c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


