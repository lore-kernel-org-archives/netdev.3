Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E7C46D2B1;
	Tue, 21 Jul 2026 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651443; cv=none; b=fWV5BFzhqtIOKHWVtvh1Ii/mFcYJ8O9SNpGpVcLrgmwWT8ZFm6hLmDM776GwCzt7HeXbVoCpQxQza7+cBOYqEtfM0E+WxpBCJXOZG6HKolcV7nlDZLNOrjTkhzV6Z80XK8atJcumw/QognXTvYBlFeFX5CzIMk8EcImCTgc0aMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651443; c=relaxed/simple;
	bh=dSWrJydcq2B9Bb228wamlwfeAr5CU+sUl1eOHJbIW+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J116jJ3WfxHpCRGfSTvqVQQSHcM9IndPx4YTaoDQmygxEMkTdVpgPF6go+8jTd+dVpk1LHPz7z54skTQN/TFogiQhwg1luUtYz/uI/Uh2Rw2ChGhVfYmvzEAyL3SAyBmz2OC5DOAjIN/RxFNKpNcY8z7iTq3veNX1E6r0/rZMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2HC1Q82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2HC1Q82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB481F000E9;
	Tue, 21 Jul 2026 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651442;
	bh=hiZfSoTKTIHoVPMPzTv/3edn8TP3cK2ffEGhTMHhApQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2HC1Q82A5JRCVozDeNy7cIsGS2ZK9p2s3PknTUGV8YupKqrKNUCb3UpSD/sT6nx9
	 gpvK9PHZ5H/Xm2BB5iS+UwuSTyfYOJabperrBXJrDd0Wg15BhLS8q6U/8Tllg4N7SM
	 gGcnydR1DV+kQgPWSeCzRtTYcVu3OspFQkaNCUf7dchiVynbNHP28xFjFrhiMfZl/z
	 Ggt3K07ra/R1NDNwuPV7/CoUAEe3/2E1FtOyK+LDOE2pUjGYBBkRrfAz6b04OkpqV0
	 FWgXzxj0+LYoYEYx8Bq7fVmlAPw11ELvLGefRG5BUoov3cTvTyYn24TI9nHoM/NLwA
	 C/uG0qtKk058A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CCD5E3924FFE;
	Tue, 21 Jul 2026 16:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rndis_host: add overflow check in
 rndis_rx_fixup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465141140.391576.1666114427546952620.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:30:11 +0000
References: <2026070900-denim-brook-52d4@gregkh>
In-Reply-To: <2026070900-denim-brook-52d4@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, griffin@kroah.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shaoxul@foxmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 14:24:01 +0200 you wrote:
> From: Griffin Kroah-Hartman <griffin@kroah.com>
> 
> Add an overflow check to ensure that data_offset + data_len + 8 does not
> wrap, which would enable an OOB read of the USB data buffer.
> 
> Assisted-by: gkh_clanker_1000
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shaoxu Liu <shaoxul@foxmail.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [net-next] rndis_host: add overflow check in rndis_rx_fixup()
    https://git.kernel.org/netdev/net-next/c/965a251f23ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


