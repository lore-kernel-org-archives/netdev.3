Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494612;
	b=w8SrpMQrFykejeEkVsWqdyrZWBNc5ijXc/N1gnDh7pkNvBlYJrYzsXDwEbVtRUk3ZvF+
	 dHFeLuQElLFRbixFJD7teAcGO9S264tZX065V+4K3iAyqQCVTlkbw3fnoBrrEXnx6I9jM
	 FZ4SzTYAXIN/66+vC3u7/V9OJbt4k+Ki1oysRhWBpFG7sZI0QsN19j/nAaIWyYLHeg4nh
	 aGk79FquBHMZXGfvbawsNKq3zxXnA5imuyr5yAJwFdVBhw9nGzYgSdziCuSOOO87wV2OW
	 mTVtcw32YnrHp5kGkBBu/HaNS6FziuU8lwusYAVFf53TBtbOJcCOfiqkIHWcpvQ1Evg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494612;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+3IN+A5nhPvRVvbTJkXzSBFdWFbcMb+5QoRptbxfYPc=;
	b=RnGqd2XLqoburs4R7MBvgydfkEiE1F4+M7t+pjAYPgQ2doodjYCLC0KUGaXnphQI8HCo
	 jYPGFsE6MGmH0DvpKMTTa1UcFRkMydXvXhFky5j4WUOE7oiGOpBgxCiIV8FwpPxxPqskq
	 Lva4ymrcM6iX6QHWzIxmyE+kttcSBYmrNI24GF0f1FWbY2RhjMKbraBnWpbhiRWHEqkB7
	 qrcaGxrQe/U0KFF5PxmYNWGZ0PScxwPkibGtA3ZQOL34TOr2SDlDFMGUEIIeVUtndjp1D
	 iQZDA4smG5OHPPc+ffKd1OLoT3U5mbeu4/IcJWW5zwy3zRUp2H6NdMY+Bws32858bag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGdYPtG1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E7606A327;
	Tue, 20 Oct 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGdYPtG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804261F000C5;
	Tue, 20 Oct 2026 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792494611;
	bh=+3IN+A5nhPvRVvbTJkXzSBFdWFbcMb+5QoRptbxfYPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LGdYPtG1MJ1ghbSsRWWiJCdPbf2TIcAqxNSWH0IzHSvEx7c2lHhK/206qutwwzpbn
	 h18sggMQSZM5D0rgg+Owo7q92ZETXMi0KuFJa/601B5njnGKXWQJqmk/kVHSs7ck65
	 kVyJTqPzzc4YlkQuX/XeLFP68+k6jlnJ8F+9hKfcpHVIIoDarlUE8zuflfPCr9MK+e
	 ytoROKiDWZ7jKbyztJoVgucM+y3PsWwd8ooB2RIWxa7KMYOhfAPxkadocoSd/RFxL3
	 +ade7ZU6ix/v0zr8WVkF3+L3+LNLosiDPKuw+OuW9V9uwBKLMlzFw2GM2F4U16GuAS
	 roxmcI48UBsQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7737B3808209;
	Tue, 20 Oct 2026 11:10:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net: dsa: motorcomm: Remove the redundant MIB
 clear
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249461002.3669402.14815907556195165257.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 11:10:10 +0000
References: <20261015004422.1554104-1-mmyangfl@gmail.com>
In-Reply-To: <20261015004422.1554104-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Oct 2026 08:44:19 +0800 you wrote:
> The MIB clear in yt921x_chip_setup() is redundant. yt921x_dsa_setup()
> issues a hardware reset first, and the reset itself zeroes all the MIB
> counters.
> 
> It does not follow the correct procedure either: CLEAN only takes effect
> while ALL_PORT is low, so a single-step CLEAN | ALL_PORT write does
> nothing once ALL_PORT is latched - and this write is what latches it for
> any CLEAN requested later.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: motorcomm: Remove the redundant MIB clear
    https://git.kernel.org/netdev/net-next/c/7d23f0f650d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


