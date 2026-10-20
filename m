Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522821;
	b=0vyQzoMCQS6K0dHWy6W9jmj1C3FqGbALwUXRcljeJEy3HmPjT8D3tTYPCvQCxY/FWOGB
	 hYnzip+/arBV79ZtSuNEFh9TSjtzBwr3gYtX9vNXylHAcR/QCjcQOmWgAjEYaq3Z+UbjJ
	 SJIHh/4dN+p0YlOLhau3fgTEyOcgKINFEmWlndQFzXjVN4XRBtRaGVNOnNPrdjMQ4fWQc
	 ssqDGHzt2sMP79D506rvoE04kZuySxN7PEjGstlvNgfQdU6GQigAKX3bAuZHIInJNeUbT
	 obK5B994zehJ4I7H1ZPeKU5F54/BCiAnsbvImesbu6/1kvsX9GNGnDcnqv8lRFhs4jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522821;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xGrLjgO9rmqQYilzMY/O/l1oa07fIv3cEE46t9tgqMQ=;
	b=pKhV/OJgDA2ITG4hF2aY9NunwtFpZv7qkApvl4nqhro0AFA3J2ifMHSnraWC5NkPRDph
	 fmEFLSeEwvSQ+Z1dO6Dvt9qIrVxHCpcL43F6MUcLz3nsKOYNIDHg/Zm/NNHl0pB22l24p
	 Smdu9pd92Kd+KmFPXN2k6P5Nf0NOJwKvPeHh9HdUVY1hRVKYxMFxVSIJciiS3TfVq+hNq
	 4W8N2b1wzo3yUU8tT5yKXL4Vm3NNWOZ6q09PzWOu2YoT3gn3HPoQOTghV4f3iQb/A8VMH
	 Ah8Z0h3DX3lCl4HLzk9wE8PccHgfNPrSiYL1YpCEWbjfOZMEyqylAQDZK+i2y2HYDXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF4YwUl7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7936606A331;
	Tue, 20 Oct 2026 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF4YwUl7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE68A1F000D2;
	Tue, 20 Oct 2026 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522820;
	bh=xGrLjgO9rmqQYilzMY/O/l1oa07fIv3cEE46t9tgqMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KF4YwUl7P2qIoq8+j+5/5ll9js1ic8WqcC/kMLdc8Cazg6jf2gd23p49ViDHc5PyP
	 djMNoECQyxYJqVcX05Ag6Rx/lGInS0zCrpN83YJCWq/ec4/Xceds5BbrlekyA564I7
	 Ea7C20VwSWLChAbFf9QgRaLJOrUZGsPchag6ZLfmLbGvAESI8EnhJiZov6PhSmNiPQ
	 UazbrXNlJ7zEoR0MrfKxlDWczfROSGjPNm2cFsyumVKidETjyDI75DXzavXNOC4SAZ
	 QErOplJ0Lt47lhJLizqpNnNNBvySLdsSiqv18pl+XXCCusL4Xytyz2IccfrkdcavhB
	 nYs4RsNIqbhwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B450F3808209;
	Tue, 20 Oct 2026 19:00:20 +0000 (UTC)
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
Subject: Re: [PATCH net-next v10 0/2] net: wwan: support DTR/RTS on AT ports
 via
 MHI IP_CTRL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281927.159319.5542146548061223834.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:19 +0000
References: <20261013183500.261229-1-peter.hunt@opengear.com>
In-Reply-To: <20261013183500.261229-1-peter.hunt@opengear.com>
To: Peter Hunt <peter.hunt@opengear.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, dnlplm@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 12:34:58 -0600 you wrote:
> Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
> result codes until the host asserts DTR. The in-tree mhi_wwan_ctrl driver
> exposes AT ports but never signals DTR, so URCs never reach userspace.
> 
> Patch 1 extends the wwan core with an optional ->dtr_rts(port, mdmbits)
> port op. The TIOCM bitmask state is tracked in the wwan core, which raises
> DTR/RTS on first open of an AT port whose driver implements ->dtr_rts,
> drops them on last close (if HUPCL is set, which is the default for AT
> ports) and on port removal, and passes the resolved bitmask to the
> driver on TIOCMSET/TIOCMBIC/TIOCMBIS.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/2] net: wwan: core: propagate modem control signals to port drivers
    https://git.kernel.org/netdev/net-next/c/241c9ed785d0
  - [net-next,v10,2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
    https://git.kernel.org/netdev/net-next/c/d509edf90bc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


