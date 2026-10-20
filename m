Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459809;
	b=O6oDmCW8tO/DDErf3xa4vZmZ6WIFn8nW/1FSMeyhOf5q3XOvlksLxtaLta5dkL4Mri5T
	 0AdyJdF/yuxb1cktezwITOZK9a0VkLwyHnwE2nYOvEozVGZfA/WcjwnwIvzskU5AfJoE6
	 TnXfZD6uOkTfP+D85ze94spGEWm8zDwtewnVqCQVDN9/YPCxHxman63Jj6BdENINakmUc
	 P785usqy/RL6XHzHOdRLb0C3OqqwN0/80EezIdiFnBTbfnbEk7MjPLzUkkDTyyDZ2IEts
	 omAAQ6CkwjI8zO4KekJy/yTsEqdG0UK95Gz65f52V3nHZJ/Q+T+visToWHylo3zV4Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FzucgFhkY9ThJI72vZY3NNoGVXc8zIf74nFvWBK5StE=;
	b=EK+pUNR5EAJLmMgQqsXaH43JsFPiHgGLJgqydomR1mx/gomVRJWgB6BmQHuhFahzU0/6
	 tuY5K9WdPamcmzN5KQlGRH4A/7Y2AnafpuR0oYNm57qsINUa2stK1FGKWgXyzSqd2D4F6
	 GsQuzL6UCHjQEUUa5TFuc0bn3I9DJOl1FfwbLJidS8PByTjGcilqb+D2FCoWpI3oGEjjQ
	 JVmk4+RCRatbH26H0x1rAHuN7zCrF1yoVXnIhAd/4t+i3+0xMNQrP3Aup/w5Dl+vz/GHW
	 hQ9l5tOVYEEZY97mSDBv4brfEleI8xKf2GTMienUbN6hSnjKFmiHtm93HejNGQk4G/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NW/n1sII";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B20606A31B;
	Tue, 20 Oct 2026 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NW/n1sII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074991F000C4;
	Tue, 20 Oct 2026 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459809;
	bh=FzucgFhkY9ThJI72vZY3NNoGVXc8zIf74nFvWBK5StE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NW/n1sIIwpqKVq2lo/V4KTC4LZVtsCmGdz+c0Jy5e4iH1g117sh3zrXMkZ+3VRLCC
	 d4xqxS2kvrU/WNcJN1ESTVsAQIaLwxQ1BvVGiWQr8L9OXJG7phcSCrqj53i5ajHxJB
	 PU1V45TvkU/n6yBvEwTwjbSec4iv8p8cGv6NNYTBIly3MQWNLGMO2nR2hKyCXjh4yq
	 DKMP7YU8CKVV4yIGEZkNuYuMRB+/m8I6lNt7gORoFSgsofaVmfLyIF10L8Iboq3CE0
	 ewm3AQEwwLo0xZzx0JNAnrrsWP2+qWhQWTUc59Gh5CIGvrpnw/OiH8Pj/vkr32+0fl
	 2PsKwnaayGmxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14CD3924A6F;
	Tue, 20 Oct 2026 01:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 00/11] net: ethernet: qualcomm: ppe: Add
 support for IPQ5424 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245980778.3422113.8249352066378796733.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 01:30:07 +0000
References: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
In-Reply-To: <20261011-qcom_ipq5424_ppe-v2-0-8c7b057e2c43@oss.qualcomm.com>
To: Jie Luo <jie.luo@oss.qualcomm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 Oct 2026 06:02:06 -0700 you wrote:
> This series adds support in the PPE driver for the IPQ5424 SoC.
> 
> IPQ5424 integrates the same PPE switch core as IPQ9574, but with a few
> differences:
> 
> 1.) It has 3 Ethernet ports plus 1 EDMA FIFO, instead of IPQ9574's 6 ports,
>     1 EDMA FIFO and 1 EIP FIFO.
> 2.) The PPE clock runs at 375 MHz instead of IPQ9574's 353 MHz.
> 3.) It requires a different, smaller set of interconnect paths.
> 4.) It uses different BM (buffer management), QM (queue management) and
>     scheduler configurations.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] dt-bindings: net: qcom,ipq9574-ppe: Split EDMA reset into sys and apb
    https://git.kernel.org/netdev/net-next/c/7d0692e7f050
  - [net-next,v2,02/11] net: ethernet: qualcomm: ppe: Fix multicast queue config table access
    https://git.kernel.org/netdev/net-next/c/7baaa2bed6fd
  - [net-next,v2,03/11] dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5424 PPE support
    https://git.kernel.org/netdev/net-next/c/2575292d1c92
  - [net-next,v2,04/11] docs: networking: Document IPQ5424 as a supported SoC
    https://git.kernel.org/netdev/net-next/c/ff5f9cb0c28d
  - [net-next,v2,05/11] net: ethernet: qualcomm: ppe: Add platform support for IPQ5424
    https://git.kernel.org/netdev/net-next/c/b52c8b48864e
  - [net-next,v2,06/11] net: ethernet: qualcomm: ppe: Add IPQ5424 BM buffer configuration
    https://git.kernel.org/netdev/net-next/c/d377b0e5c488
  - [net-next,v2,07/11] net: ethernet: qualcomm: ppe: Add IPQ5424 QM configuration
    https://git.kernel.org/netdev/net-next/c/04181e75cbd2
  - [net-next,v2,08/11] net: ethernet: qualcomm: ppe: Add IPQ5424 scheduler resource configuration
    https://git.kernel.org/netdev/net-next/c/b9f3abbb9f1c
  - [net-next,v2,09/11] net: ethernet: qualcomm: ppe: Add IPQ5424 scheduler configuration
    https://git.kernel.org/netdev/net-next/c/7ba101e7fa86
  - [net-next,v2,10/11] net: ethernet: qualcomm: ppe: Add IPQ5424 service code configuration
    https://git.kernel.org/netdev/net-next/c/c61091061206
  - [net-next,v2,11/11] net: ethernet: qualcomm: ppe: Add IPQ5424 counter debugfs support
    https://git.kernel.org/netdev/net-next/c/f60a45426d5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


