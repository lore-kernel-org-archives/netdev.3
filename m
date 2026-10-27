Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111407;
	b=bNtzAKVUrXxZmwNg/V0irwllXR+32Mbz6BgCN0pWaoRAxJ9T1v8jBZRMkp68z4Xk1A/d
	 W35vCz0wgzb7nMgDbt/aYnFyOwKjUNBkFw/j6+lnRMGn3ymQTfcWl148+wGYvc/Xph2p7
	 Kp7IxGmGjDuKUfSgAwUqmAnvfOthwhyGrIzkr4bN7LQr1RpVudTdJ0ojDfdA+BMM1gG2I
	 o12jnNiRCuOAzEBSF2F9E2Cczi77xlmBGNR7GLvcgYrL/hmox1HW5vJmY9bR8HYjoUFur
	 P5lo7n+yjewErzD5JpSFFG/fzL5ZOwL+fVKpMEjmE+zYBn/Pm2ji7RxTWKYpLTMRlxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mrbZ17LpAhhKkCi5iZUrqpKRsF8yfX0XjlG6eVt89YM=;
	b=O+yf4j5xCOIGiag2EOc0wIky/Al8tyCG9ZwUNuIhylDgFEtNQqhirhoXdCscuafU9klm
	 LPSRXVxKDHm7d5yOCNrVEtZuKAQcZDwDDoc6ggz/emCpxkxjKKTX/SzK+5Dr5PXceaLXV
	 XD+vX1kvakixhVUxj9aYhaFc6B9HHDB7CbMUDiYtn2+Sh/CDNxpc8g8F0uZbFp5uJWXnE
	 /XP9V+Y7nJNnRRIo8ZnCXbv+quwej8KEYd+NAHJ+eN7gRae45IKRtcppfr7E9ZQ154xC+
	 vGcs65dBl9Q1yNNcKcaisaIURbRrFtEh68IsB53yP4gDDwyXqpJBDRbVCUgT4VqNnRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHNcij2v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10282606A324;
	Tue, 27 Oct 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHNcij2v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C880A1F01825;
	Tue, 27 Oct 2026 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111406;
	bh=mrbZ17LpAhhKkCi5iZUrqpKRsF8yfX0XjlG6eVt89YM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gHNcij2v6Uvwdmuo7SLo7bsuQRyYjlVaJelsmOg4LJjSOxCx6+zHgC21CndGbg7OW
	 i/c5RCWUZ5joS7DBrwXMBVlvo5xPyu8JcAHsYCmXnqq7MV2/m0029grSHKcQE2yShJ
	 kIgPyR43T9MypAb2k9ZABOL7SChUoqZJgUHCllO6hztNpnzDJWzjMtLSF9JOi3r25J
	 7DLGHYnPPDdmGb1WbYh86pRd9JsCqdLYPCngL8e36RLsAQT9qs0ds2ruvm/mRL5yWv
	 NQ5EmI4Tp5eb6qnW5V/iZL1KsrC3N7XJAYznUaqhy4NXIIq58VwtSBp/nEvMYI7R5D
	 0ylt3xAMfz7Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE5C73AA942E;
	Tue, 27 Oct 2026 14:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: lan966x: do not warn on MAC entries that are not
 port destined
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179311140532.3859410.11214781707545334136.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 14:30:05 +0000
References: <20261026-lan966x-mac-warn-v1-1-9c885f9cbda9@microchip.com>
In-Reply-To: <20261026-lan966x-mac-warn-v1-1-9c885f9cbda9@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 14:46:28 +0100 you wrote:
> lan966x_mac_irq_handler() scans the rows of the MAC table that the
> analyzer reports as changed, reads back all four columns of each row and
> treats ANA_MACACCESS.DEST_IDX as a port number.
> 
> Before this patch, a destination index above num_phys_ports hits a
> WARN_ON(). The driver installs such entries itself:
> lan966x_mac_cpu_learn() uses PGID_CPU, and L2 multicast entries use a
> general-purpose PGID. A row holding one of them is read back whenever
> another entry in the same row is learned or aged out, so the scan warns
> in normal operation, repeatedly once the MAC table is busy.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: do not warn on MAC entries that are not port destined
    https://git.kernel.org/netdev/net/c/2cffcf1aeabb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


