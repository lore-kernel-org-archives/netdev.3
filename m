Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354609;
	b=ynnJ3xljW25yEt4RUF46cuT69QdQ7dDkQ0YRhguDjOeeEPbihNZu8Lxw8Xpf5saXrAHZ
	 DRejaWFJqFIBIJe31oc3xlIn9DTz7vT7A00sJCt8KDG4Fyl82ZCp5A+YwzVkhSmRF0eFr
	 IBceVUTDdq3SMWyeItRT7JlP9BBoFvSysUGmQ+dgA9Av6Or6hZtGLt0hN28Iva5xWtaDO
	 79S04qQkL71crGcTja/JNkTbdJ2l+9SUQ/2skx+wCJHXOtEC0KgeyJ07GgVJGKi4ZNjae
	 pSlRPq5tD9IT3h3r26rHP4esf39A2234R1boJU4mzX+i7fgunrvL57weZ+DIP9S+U0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ORiZhmsmazgd5twv5ZLERqcX7skdOqLbxUSpfPlCjGQ=;
	b=e77cErWHgYgv2WREKvzrVayHz5aZ5kVhluPOq+YbpT392Md9CxOP95USQrsKZzjXw4xX
	 M16c+SuyJuYF5Gm5b1Ur4Gy6RSrNT7Dbji90ABQCHYz7LUSVl5Ld9iD0f/e+Os4bXGebq
	 TvUB5P3OBr2sWWZ4geUou9NMUBrJkwwuta9A0Nv276sTAPbNqQUKzv3YgjFGTrpwwaQSF
	 8pxvBogdk/1ViRuizgQVTe1k0I7L54ja0dBD4VIRTvwNDPngRkvFXUx5jqHov54iYCcEJ
	 uuM55adjC2vRkuk+JsH2QUSANWb+xtxmgJblZ8ByY9qPnW+elQ/G8sC0PU/gMP8FK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilZOCDzI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F60606A31C;
	Tue, 10 Nov 2026 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilZOCDzI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6833F1F0093C;
	Tue, 10 Nov 2026 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354608;
	bh=ORiZhmsmazgd5twv5ZLERqcX7skdOqLbxUSpfPlCjGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ilZOCDzIWsInnhM+sQBYgS8P7NS8z06U7AlTSuf/NB28sgUkDpWJHktlJti6KBPEu
	 wv219egHlcZTv7TJF/IEhJ3fcheWY8YyV4yIGGEb1HQ/5LtThKczYN01XYGP1embjp
	 rivwxGLaHoTUDZj5erDcevub+Ys5nQARP7Rf7hVx4ga12CzF7EMVVaRUsBaw7UkNLY
	 hDWaeZfp47svbcZCO9/5XdZ4NtkASefhnokdzDfkQ+j/BhXSBthIZowlx0qRRFQfd+
	 7VoM7oybCNxO2d5yNzKWpV4GOlw5HWiLiUvnnSiS6W3sJQ/I87B6vwfO3pZegwi1MA
	 GvgE+jDW7A89g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E11639E8A49;
	Tue, 10 Nov 2026 23:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] net: macb: two fixes for macb_tx_error_task()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435460717.120887.12617923076900913409.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:50:07 +0000
References: <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
In-Reply-To: 
 <20261107-nb-macb-tx-error-task-net-v1-0-a2aac5d64d52@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, sean.anderson@linux.dev,
 robert.hancock@calian.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 07 Nov 2026 21:58:46 +0100 you wrote:
> Both pre-existing bugs were flagged during the clashiko review of my
> software FCS patch [1]. These are the promised follow-up patches.
> 
> Patch 1 credits the frames dropped on a TX error to BQL. Patch 2 takes
> tx_ptr_lock in the task, as macb_start_xmit() moves the same pointers
> under it.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: credit unsent frames to BQL in macb_tx_error_task()
    https://git.kernel.org/netdev/net-next/c/7b42f4a88e76
  - [net,2/2] net: macb: take tx_ptr_lock in macb_tx_error_task()
    https://git.kernel.org/netdev/net-next/c/c45ceb26e0dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


