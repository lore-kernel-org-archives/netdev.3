Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789221;
	b=XqkW5Ld6N9Q0Pi3e8EYhHXTk/cqAuYWEgB8IUKxsUMjrOGP1DE94YOJQwHYxoSaS85QE
	 gJOKggw0U+SRzu1RZhv3Z8f2ODuhl6CsqLFIHORKNJgdbWdNtTXnjWu/Cz6ZKBN1nGOAT
	 LUViPKTdbDgBnnZ+Z+bMrOlvrUuF9/f2jEODrz3Eb/PQ58mlvAmK2BlSL2dqmSQ8R1pkM
	 jqRZEPGPXMT4k0JpHy1pMPi+5WtK/N9f4tg29MiApjMd1OKuNP4tzOgguxleK7EM1a9Zj
	 1kf/9T+mMMS/3yd8/SFk6OlYbIneBacjym2bsLOFhZP/FGFUCJnXiYFxtlLD1211UQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789221;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/zRNtfPAXTthuW4uanzpc66x09wuudOPAK79gmQZrRI=;
	b=S8xj77V6CEKgBn1qA9wlZjq8y2XbbVEop2qK38Jlqtu0XotcS9ftXcAJcmRAizCryqsb
	 e628C/zq2LjgJOgBrOyAzBnsRz/jko6pQ2HRJUaPHn7An2UXs2NrxEk35/D6e0Y6GyFdg
	 Epx+Xs1mRHLC36V1L5sNAZkT2JfH4SbCxs8dROPhlrQoMTmT2ciBarvLRmgGIriTz/PBJ
	 QgbbUK28OKKrgxOJhYIJDiDZQolywnrPlU3lFfWxBdyLOz/pMfHkDSedMKfSnBhFjVY9M
	 H7AzHd2qW0pVL9gFK9ramTqzn/hcvqc/+neU9N7gw1BeJwW7c6mfYAd435iuwejvxGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFYRfzCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A5606A31F;
	Fri, 23 Oct 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFYRfzCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104201F01828;
	Fri, 23 Oct 2026 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789221;
	bh=/zRNtfPAXTthuW4uanzpc66x09wuudOPAK79gmQZrRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YFYRfzCYnXyURdqNWs7hnCa3Z5NRRwVwm+2+QYwbOrmuvfcqf3z8+1VsLXhYtsc1w
	 na2hv0CIQ39ZPBSatuvpXr+BhEFHIjczDz7IxRa6rg+EyD1ZDsj1/ATsvKjpYG0JIp
	 uqyvaFQTU+/1GHTq+OraO+2CGKuxHxd3n3OENDlTDzTXAMfIeq6JF5Zj4HhAXlC2iP
	 P5cq+R/7+c5O7AcpxGMg0GRTgACGA6pkmLkisoe/lpORy5ktpnGGNFoTqPRNlTrzlX
	 eYmri4DKy8QT0zQvAnRcuV/serlfrsNBqUlgX9rLhRFvLrariIJYRO5+ZcAv1RpF8q
	 Y2EVEriTWMXIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074A8391B157;
	Fri, 23 Oct 2026 21:00:21 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] net: pse-pd: si3474: two driver fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278921957.1268720.1927086301810125998.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:19 +0000
References: <20261019162453.1244120-1-piotr@kubik.pl>
In-Reply-To: <20261019162453.1244120-1-piotr@kubik.pl>
To: Piotr Kubik <piotr@kubik.pl>
Cc: netdev@vger.kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, github@szelinsky.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 18:24:51 +0200 you wrote:
> Two fixes for the Si3474 PSE driver, found while preparing 2-pair and
> semi-auto support for it.
> 
> Patch 1 stops si3474_pi_enable() from clearing detection and
> classification of the other PI in the same quad. Without it, a PD on
> that PI gets no power after a later plug-in.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: pse-pd: si3474: keep detection enabled on the other PIs
    https://git.kernel.org/netdev/net/c/b530456be771
  - [net,2/2] net: pse-pd: si3474: validate the channels of a PI
    https://git.kernel.org/netdev/net/c/110eb808324f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


