Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336007;
	b=SfmR/wFZU3DwFRzs/L4gqz0ySkhoBjZoKZZkXhaInrJ7bq+2FxUIzi4xwnx+hHiIWAoE
	 Mo33ox8rLls8fZQAgpa+YtfhTGJGvDf4tlD5LR60fGsh8dx3A/gSbiR52dTC+l2CP76tA
	 lBGsae1kRPlMw+cwpBlVAw4O/deE9OXaRg4Rzro5qqHBS+8OwdipC6fKWP14yhFHwf44l
	 CzImLEVntMb+5EZGN2K/5TW0gpyDMaJXi3xSf6j8TX6tHtWciKNmC+LPbSEZZs4NlYepM
	 Qi5NzqA125IXeo7GqvxQlhlgCvx5SzyVECc/cG2+vQMGIHb5mxTvU+X08JDdK90CqyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4MSh5JOaUd5k77i5qW9LbAd13P6R3ude62+HLiVlgeI=;
	b=JrMKDhUyCf7JSSixDmkle4DkPpaixh49iPtgEdudVJfPBtZc+bRsFhW+oCf8BthFO+6M
	 +WKugZjGnXX7zIRMgUgjaj4KK+h0sTL8fHdxOxuHTfc43tGy47hkZBN4zDaTap/MC2ob9
	 JZmxjVd7G23lVuk5Vlpf9SEsER2TUpvDwtEKdC8fV9Y+8peuKk4az9u8O4xvlL/hBYogL
	 jCdCmmwRKB6rk9N0IEyP/krX81JNI2EYwvXeIJ5zi53Bdf5qzePwve/MmT3Zf7K7FdmVE
	 hFzyLMpI4jm3xtlU+ffbTq1Dy77Wtv2HjjYk/5b9lq6zsUrfgYo18jWRdiIkhapmmvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZzCvEXY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7260A3838
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZzCvEXY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1EB1F008A2;
	Tue, 10 Nov 2026 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336007;
	bh=4MSh5JOaUd5k77i5qW9LbAd13P6R3ude62+HLiVlgeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CZzCvEXYT2IoZAzR6jlervKliIyRcaZwRH4sW0H81zIaa9sSRXFfBSrck55QKyGbc
	 4s9MUXOOcH16EkxASuTL2fdlklUQY0cipPsny2GS5YO/6zlTN6+oJf1wyQILW1zPDM
	 OwxFdqmp8KMo19McW161yPv3A9WYyhaDd4iBnffg1NXBbV/b/2diYOqHHwSK3RWkMh
	 VGl0WHdjbfYNxiFE9Eo0Whhxla3hE3gGXqyqMxIyuzP35/qEkd/649Z3v9pYvmP7iG
	 DAp9g5R/vBheX54W8+tXTB5h2E73ggW0lpAsDLVKvyTtIe3LT8T+9w056uFG5YuHUe
	 QNyOutWcIOuVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2119839D6091;
	Tue, 10 Nov 2026 18:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net] bonding: fix slave_cnt leak on XDP enslave failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433600568.4186528.5122039018289345050.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:40:05 +0000
References: <20261104092851.688361-1-edumazet@kernel.org>
In-Reply-To: <20261104092851.688361-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 luyun@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 10:28:51 +0100 you wrote:
> bond_enslave() increments bond->slave_cnt before setting up XDP on the
> new slave. If that setup fails (slave has no XDP support, already has
> an XDP program, or dev_xdp_propagate() fails), the error path jumps to
> err_sysfs_del, which never decrements slave_cnt.
> 
> Each failed enslave therefore leaves slave_cnt one too high:
> - SIOCBONDINFOQUERY reports a wrong num_slaves,
> - balance-rr picks slave ids beyond the end of the slave list, so
>   bond_get_slave_by_id() falls back to the first usable slave and
>   transmit is skewed toward it.
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix slave_cnt leak on XDP enslave failure
    https://git.kernel.org/netdev/net/c/a97809569964

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


